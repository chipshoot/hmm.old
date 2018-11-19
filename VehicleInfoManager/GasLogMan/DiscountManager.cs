﻿using DomainEntity.Enumerations;
using DomainEntity.Misc;
using DomainEntity.Vehicle;
using Hmm.Contract;
using Hmm.Contract.Core;
using Hmm.Contract.GasLogMan;
using Hmm.Utility.Currency;
using Hmm.Utility.Dal.Exceptions;
using Hmm.Utility.Dal.Query;
using Hmm.Utility.Misc;
using Hmm.Utility.Validation;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Xml.Linq;

namespace VehicleInfoManager.GasLogMan
{
    public class DiscountManager : ManagerBase<GasDiscount>, IDiscountManager
    {
        private readonly IHmmNoteManager<HmmNote> _noteManager;
        private readonly IEntityLookup _lookupRepo;

        public DiscountManager(IHmmNoteManager<HmmNote> noteManager, IEntityLookup lookupRepo)
        {
            Guard.Against<ArgumentNullException>(noteManager == null, nameof(noteManager));
            Guard.Against<ArgumentNullException>(lookupRepo == null, nameof(lookupRepo));

            _noteManager = noteManager;
            _lookupRepo = lookupRepo;
        }

        public IEnumerable<GasDiscount> GetDiscounts()
        {
            var discounts = _noteManager.GetNotes()
                .Where(n => n.Subject == AppConstant.GasDiscountRecordSubject)
                .Select(GetEntityFromNote).ToList();
            return discounts;
        }

        public GasDiscount GetDiscountById(int id)
        {
            return GetDiscounts().FirstOrDefault(d => d.Id == id);
        }

        public IEnumerable<GasDiscountInfo> GetDiscountInfos(GasLog gasLog)
        {
            var infos = new List<GasDiscountInfo>();

            var content = gasLog.Content;
            if (!IsNoteContentValid(content, out var noteXml))
            {
                return infos;
            }

            var ns = noteXml.Root?.GetDefaultNamespace();
            var discountRoot = noteXml.Root?.Element(ns + "Content")?.Element(ns + "GasLog")?.Element(ns + "Discounts");
            if (discountRoot == null)
            {
                ProcessResult.AddMessage("Cannot find discounts element");
                return infos;
            }

            foreach (var element in discountRoot.Elements())
            {
                var amountNode = element.Element(ns + "Amount")?.Element(ns + "Money");
                if (amountNode == null)
                {
                    ProcessResult.AddMessage("Cannot found money information from discount string");
                    continue;
                }

                var money = Money.FromXml(amountNode);
                var discountIdStr = element.Element(ns + "Program")?.Value;
                if (!int.TryParse(discountIdStr, out var discountId))
                {
                    ProcessResult.AddMessage($"Cannot found valid discount id from string {discountIdStr}");
                    continue;
                }

                var discount = GetDiscountById(discountId);
                if (discount == null)
                {
                    ProcessResult.AddMessage($"Cannot found discount id : {discountId} from data source");
                    continue;
                }

                infos.Add(new GasDiscountInfo
                {
                    Amount = money,
                    Program = discount
                });
            }

            return infos;
        }


        public GasDiscount CreateDiscount(GasDiscount discount)
        {
            Guard.Against<ArgumentNullException>(discount == null, nameof(discount));

            var discountCatalog = _lookupRepo.GetEntities<NoteCatalog>().FirstOrDefault(c => c.Name == AppConstant.GasDiscountRecordSubject);
            if (discountCatalog == null)
            {
                ProcessResult.Rest();
                ProcessResult.Success = false;
                ProcessResult.AddMessage("Cannot find discount catalog from data source");
                return null;
            }

            // ReSharper disable once PossibleNullReferenceException
            discount.Subject = AppConstant.GasDiscountRecordSubject;
            discount.Catalog = discountCatalog;

            SetEntityContent(discount);
            var savedDiscount = _noteManager.Create(discount);

            if (!_noteManager.ProcessResult.Success)
            {
                ProcessResult.Rest();
                ProcessResult.Success = false;
                ProcessResult.MessageList.AddRange(_noteManager.ProcessResult.MessageList);
                return null;
            }

            return savedDiscount as GasDiscount;
        }

        public GasDiscount UpdateDiscount(GasDiscount discount)
        {
            Guard.Against<ArgumentNullException>(discount == null, nameof(discount));

            // ReSharper disable once PossibleNullReferenceException
            SetEntityContent(discount);
            var savedDiscount = _noteManager.Update(discount);

            if (!_noteManager.ProcessResult.Success)
            {
                ProcessResult.Rest();
                ProcessResult.Success = false;
                ProcessResult.MessageList.AddRange(_noteManager.ProcessResult.MessageList);
                return null;
            }

            return savedDiscount as GasDiscount;
        }

        public ProcessingResult ProcessResult { get; } = new ProcessingResult();

        protected override void SetEntityContent(GasDiscount discount)
        {
            var xml = new XElement(AppConstant.GasDiscountRecordSubject,
                new XElement("Date", discount.CreateDate.ToString("O")),
                new XElement("Program", discount.Program),
                new XElement("Amount", discount.Amount.Measure2Xml(_noteManager.ContentNamespace)),
                new XElement("DiscountType", discount.DiscountType),
                new XElement("IsActive", discount.IsActive),
                new XElement("Comment", discount.Comment)
            );

            discount.Content = string.Empty;
            discount.Content = xml.ToString(SaveOptions.DisableFormatting);
        }

        protected override GasDiscount GetEntityFromNote(HmmNote note)
        {
            if (note == null)
            {
                return null;
            }

            var noteStr = note.Content;
            if (string.IsNullOrEmpty(noteStr))
            {
            }
            var noteXml = XDocument.Parse(noteStr);
            var ns = noteXml.Root?.GetDefaultNamespace();
            var discountRoot = noteXml.Root?.Element(ns + "Content")?.Element(ns + AppConstant.GasDiscountRecordSubject);
            if (discountRoot == null)
            {
                return null;
            }

            bool.TryParse(discountRoot.Element(ns + "IsActive")?.Value, out var isActive);
            Enum.TryParse<GasDiscountType>(discountRoot.Element(ns + "DiscountType")?.Value, out var discType);
            var discount = new GasDiscount
            {
                Id = note.Id,
                Author = note.Author,
                Catalog = note.Catalog,
                CreateDate = note.CreateDate,
                LastModifiedDate = note.LastModifiedDate,
                Content = note.Content,
                Program = discountRoot.Element(ns + "Program")?.Value,
                Amount = Money.FromXml(discountRoot.Element(ns + "Amount")?.Element(ns + "Money")),
                DiscountType = discType,
                IsActive = isActive,
                Comment = discountRoot.Element(ns + "Comment")?.Value,
                Description = note.Description,
            };

            return discount;
        }

        private bool IsNoteContentValid(string noteContent, out XDocument noteXml)
        {
            if (string.IsNullOrEmpty(noteContent))
            {
                ProcessResult.Success = false;
                ProcessResult.AddMessage("Null or empty note content found", true);
                noteXml = null;
                return false;
            }

            try
            {
                noteXml = XDocument.Parse(noteContent);
                return true;
            }
            catch (Exception ex)
            {
                ProcessResult.Success = false;
                ProcessResult.AddMessage(ex.GetAllMessage(), true);
                noteXml = null;
                return false;
            }
        }
    }
}