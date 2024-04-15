using MiniFeladat.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MiniFeladat.Services
{
    public class ProductService
    {
        private List<Product> products;

        public ProductService()
        {
            products = new List<Product>();
        }

        public void Add(Product product)
        {
            if (!products.Any(p => p.Name.ToLower().Trim() == product.Name.ToLower().Trim()))
            {
                products.Add(product);
            }
            else
            {
                throw new ArgumentException("Ilyen névvel már található termék!");
            }
        }

        public List<Product> GetAll()
        {
            return products;
        }

        public Product Get(int id)
        {
            return products.FirstOrDefault(p => p.ProductId == id);
        }

        public void Update(Product updatedProduct)
        {
            int index = products.FindIndex(p => p.ProductId == updatedProduct.ProductId);
            if (index != -1)
            {
                if (products.Where(p => p.Name.ToLower().Trim() == updatedProduct.Name.ToLower().Trim() && updatedProduct.ProductId != p.ProductId).ToList().Count == 0)
                {
                    products[index] = updatedProduct;
                }
                else
                {
                    throw new ArgumentException("Ilyen névvel már található termék!");
                }
            }
            else
            {
                throw new ArgumentException("Termék nem található.");
            }
        }

        public void Delete(int productId)
        {
            products.RemoveAll(p => p.ProductId == productId);
        }
    }

}