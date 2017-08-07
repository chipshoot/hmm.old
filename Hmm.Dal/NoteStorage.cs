﻿using DomainEntity.Misc;
using Hmm.Utility.Dal;
using Hmm.Utility.Dal.Query;

namespace Hmm.Dal
{
    public class NoteStorage : StorageBase<HmmNote>
    {
        public NoteStorage(IEntityLookup lookupRepo, IUnitOfWork uow) : base(lookupRepo, uow)
        {
        }

        public override HmmNote Add(HmmNote entity)
        {
            throw new System.NotImplementedException();
        }

        public override bool Delete(HmmNote entity)
        {
            throw new System.NotImplementedException();
        }

        public override void Flush()
        {
            throw new System.NotImplementedException();
        }

        public override void Refresh(ref HmmNote entity)
        {
            throw new System.NotImplementedException();
        }

        public override HmmNote Update(HmmNote entity)
        {
            throw new System.NotImplementedException();
        }
    }
}