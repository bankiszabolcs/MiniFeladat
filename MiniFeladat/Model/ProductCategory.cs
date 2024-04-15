using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MiniFeladat.Model
{
    public class ProductCategory
    {
        public int Id { get; set; }
        public string Name { get; set; }

        public ProductCategory(int id, string name)
        {
            Id = id;
            Name = name;
        }
    }
}