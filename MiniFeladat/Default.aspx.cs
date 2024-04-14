using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace MiniFeladat
{
    public class Product
    {
        private static int lastProductId = 0;
        public int ProductId { get; private set; }
        public string Name { get; set; }
        public decimal Price { get; set; }
        public int StockQuantity { get; set; }
        public string Description { get; set; }
        public bool IsAvalailable { get; set; }
        public ProductCategory Category { get; set; }

        public Product(string name, decimal price, int stockQuantity, string description, ProductCategory category)
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
            IsAvalailable = true;
        }


        public Product(int id, string name, decimal price, int stockQuantity, string description, ProductCategory category)
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
            IsAvalailable = true;
        }
    }


    public enum ProductCategory
    {
        Electronics,
        Apparel,
        Home,
        Clothes
    }

    public class ProductService
    {
        private List<Product> products;

        public ProductService()
        {
            products = new List<Product>();
        }

        public void Add(Product product)
        {
            products.Add(product);
        }

        public List<Product> GetAll()
        {
            return products;
        }

        public Product Get(int id)
        {
            return products.Where(p => p.ProductId == id).FirstOrDefault();
        }

        public void Update(Product updatedProduct)
        {
            int index = products.FindIndex(p => p.ProductId == updatedProduct.ProductId);
            if (index != -1)
            {
                products[index] = updatedProduct;
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

        public void FillWithData()
        {
            products.Add(new Product("Laptop", 198899m, 10, "Erőteljes laptop játékhoz és produktivitáshoz", ProductCategory.Electronics));
            products.Add(new Product("Póló", 4999.99m, 50, "Kényelmes pamut póló mindennapos viselethez", ProductCategory.Clothes));
            products.Add(new Product("Kávéfőző", 99990.99m, 20, "Automatikus kávéfőző finom kávékészítéshez", ProductCategory.Home));
        }
    }


    public partial class Default : System.Web.UI.Page
    {
        protected List<Product> ProductList { get; set; }
        private static ProductService productService;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                productService = new ProductService();

                productService.FillWithData();

                ProductList = productService.GetAll();
            }
        }

        [WebMethod]
        public static int DeleteProduct(int productId)
        {
            productService.Delete(productId);
            return productId;
        }

        [WebMethod]
        public static int UpdateProduct(int id, string name, float price, int stockQuantity, string description, ProductCategory category )
        {
            Product updatedProduct = new Product(id, name, Convert.ToDecimal(price), stockQuantity, description, category);
            productService.Update(updatedProduct);
            return id;
        }
    }
}