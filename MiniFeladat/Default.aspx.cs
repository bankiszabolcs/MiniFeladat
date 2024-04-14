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
            return products.FirstOrDefault(p => p.ProductId == id);
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
    }


    public partial class Default : System.Web.UI.Page
    {
        protected List<Product> ProductList { get; set; }
        protected List<ProductCategory> Categories { get; set; }
        private static ProductService productService;
        private static ProductCategoryService categoryService;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                productService = new ProductService();
                categoryService = new ProductCategoryService();

                categoryService.Add(new ProductCategory(1, "Háztartás"));
                categoryService.Add(new ProductCategory(2, "Elektronika"));
                categoryService.Add(new ProductCategory(3, "Ruha"));

                Categories = categoryService.GetAll();

                productService.Add(new Product("Laptop", 198899f, 10, "Erőteljes laptop játékhoz és produktivitáshoz", Categories[1].Name, true));
                productService.Add(new Product("Póló", 4999.99f, 50, "Kényelmes pamut póló mindennapos viselethez", Categories[2].Name, true));
                productService.Add(new Product("Kávéfőző", 99990.99f, 20, "Automatikus kávéfőző finom kávékészítéshez", Categories[0].Name, false));

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
        public static Product UpdateProduct(int id, string name, float price, int stockQuantity, string description, string category, bool isAvailable )
        {
            Product updatedProduct = new Product(id, name, price, stockQuantity, description, category, isAvailable);
            productService.Update(updatedProduct);
            return updatedProduct;
        }

        [WebMethod]
        public static Product AddProduct(string name, float price, int stockQuantity, string description, string category, bool isAvailable)
        {
            Product newProduct = new Product(name, price, stockQuantity, description, category, isAvailable);
            productService.Add(newProduct);
            return newProduct;
        }

    }
}