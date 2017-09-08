﻿using System.Collections.Generic;

namespace Hmm.Api.Models
{
    public abstract class ApiEntity
    {
        protected ApiEntity()
        {
            Links = new List<Link>();
        }

        public List<Link> Links { get; }
    }
}