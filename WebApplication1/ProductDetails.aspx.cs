using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Web.UI;
using System.Web;

namespace WebApplication1
{
    public partial class ProductDetails : System.Web.UI.Page
    {
        // This method will run on page load and check if there's a productId in the query string.
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Get the productId from the query string
                if (Request.QueryString["productId"] != null)
                {
                    int productId = Convert.ToInt32(Request.QueryString["productId"]);
                    LoadProductDetails(productId);
                }
            }
        }

        // This method loads product details from the database and binds it to the page controls.
        private void LoadProductDetails(int productId)
        {
            string connString = ConfigurationManager.ConnectionStrings["ProductDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = "SELECT Id, Name, Description, Price, StockQuantity, ImageUrl FROM Products WHERE Id = @ProductId";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@ProductId", productId);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    // Get the product details
                    string productName = reader["Name"].ToString();
                    string productDescription = reader["Description"].ToString();
                    decimal productPrice = Convert.ToDecimal(reader["Price"]);
                    int productStock = Convert.ToInt32(reader["StockQuantity"]);
                    string productImage = reader["ImageUrl"].ToString();

                    // Set values to controls on the page
                    lblProductName.Text = productName;
                    lblProductDescription.Text = productDescription;
                    lblProductPrice.Text = "£" + productPrice.ToString("F2");
                    lblProductStock.Text = productStock.ToString();
                    imgProduct.ImageUrl = productImage;
                }
            }
        }

        // This method is triggered when the "Add to Cart" button is clicked.
        protected void AddToCart_Click(object sender, EventArgs e)
        {
            // Get the productId from the query string (already loaded from the page).
            int productId = Convert.ToInt32(Request.QueryString["productId"]);
            string productName = lblProductName.Text;
            decimal productPrice = Convert.ToDecimal(lblProductPrice.Text.TrimStart('£')); // Price without £ sign

            // Create the cart item object
            CartItem newItem = new CartItem
            {
                ProductId = productId,
                ProductName = productName,
                ProductPrice = productPrice,
                Quantity = 1
            };

            // Retrieve the current cart from the session, or create a new cart if it doesn't exist
            List<CartItem> cart = (List<CartItem>)Session["Cart"];
            if (cart == null)
            {
                cart = new List<CartItem>();
            }

            // Add the new item to the cart
            cart.Add(newItem);

            // Save the updated cart back into the session
            Session["Cart"] = cart;

            // Display a success message (you could redirect to another page, or use a modal/popup)
            Response.Write("<script>alert('Product added to cart!');</script>");
        }
    }

    // Define a CartItem class to represent each item in the cart
    public class CartItem
    {
        public int ProductId { get; set; }
        public string ProductName { get; set; }
        public decimal ProductPrice { get; set; }
        public int Quantity { get; set; }
    }
}
