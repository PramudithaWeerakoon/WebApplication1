using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class Products : System.Web.UI.Page
    {
        // Called on page load
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadProducts();
                UpdateCartCount();
            }
        }

        // Event handler when "Add to Cart" is clicked
        protected void AddToCart_Click(object sender, EventArgs e)
        {
            var button = (Button)sender;
            int productId = Convert.ToInt32(button.CommandArgument);

            // Get the product details based on the ID
            Product product = GetProductById(productId);
            if (product != null)
            {
                // Add product to the cart (session-based)
                AddToCartSession(product);
                UpdateCartCount();
                Response.Write("<script>alert('Product added to cart: " + product.Name + "');</script>");
            }
        }

        // Load products from the database
        private void LoadProducts()
        {
            string connString = ConfigurationManager.ConnectionStrings["ProductDB"].ConnectionString;
            List<Product> products = new List<Product>();

            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = "SELECT Id, Name, Description, Price, StockQuantity, IsSold, CreatedAt, UpdatedAt, Category, ImageUrl FROM Products WHERE IsSold = 0";
                SqlCommand cmd = new SqlCommand(query, conn);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    products.Add(new Product
                    {
                        Id = Convert.ToInt32(reader["Id"]),
                        Name = reader["Name"].ToString(),
                        Description = reader["Description"].ToString(),
                        Price = Convert.ToDecimal(reader["Price"]),
                        StockQuantity = Convert.ToInt32(reader["StockQuantity"]),
                        IsSold = Convert.ToBoolean(reader["IsSold"]),
                        CreatedAt = Convert.ToDateTime(reader["CreatedAt"]),
                        UpdatedAt = Convert.ToDateTime(reader["UpdatedAt"]),
                        Category = reader["Category"].ToString(),
                        ImageUrl = reader["ImageUrl"].ToString()
                    });
                }
            }

            rptProducts.DataSource = products;
            rptProducts.DataBind();
        }

        // Get a single product by ID from the database
        private Product GetProductById(int productId)
        {
            string connString = ConfigurationManager.ConnectionStrings["ProductDB"].ConnectionString;
            Product product = null;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = "SELECT Id, Name, Description, Price, StockQuantity, ImageUrl FROM Products WHERE Id = @ProductId AND IsSold = 0";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@ProductId", productId);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    product = new Product
                    {
                        Id = Convert.ToInt32(reader["Id"]),
                        Name = reader["Name"].ToString(),
                        Description = reader["Description"].ToString(),
                        Price = Convert.ToDecimal(reader["Price"]),
                        StockQuantity = Convert.ToInt32(reader["StockQuantity"]),
                        ImageUrl = reader["ImageUrl"].ToString()
                    };
                }
            }

            return product;
        }

        // Add the product to session-based cart
        private void AddToCartSession(Product product)
        {
            // Retrieve the cart from session
            List<CartItem> cart = (List<CartItem>)Session["Cart"];
            if (cart == null)
            {
                cart = new List<CartItem>();
            }

            // Check if the product already exists in the cart
            CartItem cartItem = cart.Find(c => c.ProductId == product.Id);
            if (cartItem != null)
            {
                // Increase quantity if the product already exists in the cart
                cartItem.Quantity++;
            }
            else
            {
                // Add the new product to the cart
                cart.Add(new CartItem
                {
                    ProductId = product.Id,
                    ProductName = product.Name,
                    ProductPrice = product.Price,
                    Quantity = 1
                });
            }

            // Save cart back to session
            Session["Cart"] = cart;
        }

        // Update the cart item count in the UI
        private void UpdateCartCount()
        {
            List<CartItem> cart = (List<CartItem>)Session["Cart"];
            int itemCount = cart != null ? cart.Count : 0;
            lblCartItemCount.Text = itemCount.ToString();
        }

        // Class representing each item in the cart
        public class CartItem
        {
            public int ProductId { get; set; }
            public string ProductName { get; set; }
            public decimal ProductPrice { get; set; }
            public int Quantity { get; set; }
        }

        // Class representing product details
        public class Product
        {
            public int Id { get; set; }
            public string Name { get; set; }
            public string Description { get; set; }
            public decimal Price { get; set; }
            public int StockQuantity { get; set; }
            public bool IsSold { get; set; }
            public DateTime CreatedAt { get; set; }
            public DateTime UpdatedAt { get; set; }
            public string Category { get; set; }
            public string ImageUrl { get; set; }
        }
    }
}
