using MiniFeladat.Model;
using MiniFeladat.Services;
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
        public static object UpdateProduct(int id, string name, float price, int stockQuantity, string description, string category, bool isAvailable)
        {
            try
            {
                Product updatedProduct = new Product(id, name, price, stockQuantity, description, category, isAvailable);
                productService.Update(updatedProduct);
                return new { success = true, data = updatedProduct };
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                return new { success = false, message = ex.Message };
            }
        }

        [WebMethod]
        public static object AddProduct(string name, float price, int stockQuantity, string description, string category, bool isAvailable)
        {
            try
            {
                Product newProduct = new Product(name, price, stockQuantity, description, category, isAvailable);
                productService.Add(newProduct);
                return new { success = true, data = newProduct };
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                return new { success = false, message = ex.Message };
            }

        }

    }
}