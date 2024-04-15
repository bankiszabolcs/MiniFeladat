using MiniFeladat.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MiniFeladat.Services
{
    public class ProductCategoryService
    {
        private List<ProductCategory> productCategories;

        public ProductCategoryService()
        {
            productCategories = new List<ProductCategory>();
        }
        public List<ProductCategory> GetAll()
        {
            return productCategories;
        }

        public void Add(ProductCategory product)
        {
            productCategories.Add(product);
        }
    }
}