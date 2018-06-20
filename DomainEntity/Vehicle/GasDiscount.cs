﻿using DomainEntity.Misc;

namespace DomainEntity.Vehicle
{
    /// <summary>
    /// The class describe the information of a discount,
    /// when add a gas log to data source, user can select
    /// and apply the discount to log
    /// </summary>
    /// <seealso cref="DomainEntity.Misc.HmmNote" />
    public class GasDiscount : HmmNote
    {
        public GasDiscount()
        {
            Subject = "Discount";
        }

        public string Program { get; set; }

        public bool IsActive { get; set; }

        /// <summary>
        /// Gets or sets the comment, the way of calculating
        /// discount can be added to comment, e.g. 0.2c/liter
        /// </summary>
        /// <value>
        /// The comment.
        /// </value>
        public string Comment { get; set; }
    }
}