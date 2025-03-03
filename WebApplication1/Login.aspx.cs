using System;
using System.Data.SqlClient;
using BCrypt.Net;  // Make sure to include the BCrypt.Net namespace for password verification

namespace WebApplication1
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Optionally handle any initializations or checks if user is already logged in
            if (Session["IsAuthenticated"] != null && (bool)Session["IsAuthenticated"] == true)
            {
                Response.Redirect("Home.aspx"); // Redirect to Home if already authenticated
            }
        }

        protected void btnLoginSubmit_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text.Trim();

            // Connection string (replace with your actual connection string)
            string connString = "Server=SB-IT-LAPT-082;Database=Product;Integrated Security=True;Encrypt=True;TrustServerCertificate=True;";

            using (SqlConnection conn = new SqlConnection(connString))
            {
                try
                {
                    // Open the connection
                    conn.Open();

                    // Query to find the user by email
                    string query = "SELECT id, password_hash FROM users WHERE email = @Email";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Email", email);

                        SqlDataReader reader = cmd.ExecuteReader();
                        if (reader.HasRows)
                        {
                            reader.Read();
                            string hashedPassword = reader["password_hash"].ToString();
                            int userId = (int)reader["id"]; // Get the user ID from the database

                            // Verify the password using BCrypt
                            if (BCrypt.Net.BCrypt.Verify(password, hashedPassword))
                            {
                                // Set the session to mark the user as authenticated and store userId
                                Session["IsAuthenticated"] = true;
                                Session["UserId"] = userId;

                                // Redirect to the dashboard page or home page
                                Response.Redirect("home.aspx");
                            }
                            else
                            {
                                Response.Write("<script>alert('Invalid Credentials!');</script>");
                            }
                        }
                        else
                        {
                            Response.Write("<script>alert('Email not found!');</script>");
                        }
                    }
                }
                catch (Exception ex)
                {
                    Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
                }
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            Response.Redirect("Login.aspx"); // Redirect to login page
        }

        protected void btnShopNow_Click(object sender, EventArgs e)
        {
            Response.Redirect("Shop.aspx"); // Redirect to shopping page
        }
    }
}
