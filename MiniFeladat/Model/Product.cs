using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MiniFeladat.Model
{
    public class Product
    {
        private static int lastProductId = 0;
        public int ProductId { get; private set; }
        public string Name { get; set; }
        public float Price { get; set; }
        public int StockQuantity { get; set; }
        public string Description { get; set; }
        public bool IsAvailable { get; set; }
        public string Category { get; set; }

        public Product(string name, float price, int stockQuantity, string description, string category, bool isAvailable)
        {
            if (string.IsNullOrWhiteSpace(name))
            {
                throw new ArgumentException("A termék neve nem lehet üres.", nameof(name));
            }

            if (price < 0)
            {
                throw new ArgumentException("Az ár nem lehet negatív.", nameof(price));
            }

            if (stockQuantity < 0)
            {
                throw new ArgumentException("A készletmennyiség nem lehet negatív.", nameof(stockQuantity));
            }

            if (string.IsNullOrWhiteSpace(description))
            {
                throw new ArgumentException("A termék leírása nem lehet üres.", nameof(description));
            }

            lastProductId++;
            ProductId = lastProductId;
            Name = name;
            Price = price;
            StockQuantity = stockQuantity;
            Description = description;
            Category = category;
            IsAvailable = isAvailable;
        }


        public Product(int id, string name, float price, int stockQuantity, string description, string category, bool isAvailable)
        {
            if (string.IsNullOrWhiteSpace(name))
            {
                throw new ArgumentException("A termék neve nem lehet üres.", nameof(name));
            }

            if (price < 0)
            {
                throw new ArgumentException("Az ár nem lehet negatív.", nameof(price));
            }

            if (stockQuantity < 0)
            {
                throw new ArgumentException("A készletmennyiség nem lehet negatív.", nameof(stockQuantity));
            }

            if (string.IsNullOrWhiteSpace(description))
            {
                throw new ArgumentException("A termék leírása nem lehet üres.", nameof(description));
            }

            ProductId = id;
            Name = name;
            Price = price;
            StockQuantity = stockQuantity;
            Description = description;
            Category = category;
            IsAvailable = isAvailable;
        }
    }
}