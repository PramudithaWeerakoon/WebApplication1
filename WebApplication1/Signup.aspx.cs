using System;
using System.Data.SqlClient;
using BCrypt.Net;

namespace WebApplication1
{
    public partial class Signup : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnSignupSubmit_Click(object sender, EventArgs e)
        {
            // Get form values
            string fullName = txtName.Text.Trim();
            string username = txtUsername.Text.Trim();
            string email = txtEmail.Text.Trim();
            string phone = txtPhone.Text.Trim();
            string password = txtPassword.Text.Trim();
            string confirmPassword = txtConfirmPassword.Text.Trim();
            string profilePicturePath = null;

            // Basic validation
            if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(email) || string.IsNullOrEmpty(password))
            {
                Response.Write("<script>alert('All fields are required.');</script>");
                return;
            }

            if (password != confirmPassword)
            {
                Response.Write("<script>alert('Passwords do not match.');</script>");
                return;
            }

            // Hash the password using BCrypt
            string hashedPassword = BCrypt.Net.BCrypt.HashPassword(password);

            // Directly using the connection string you provided
            string connString = "Server=LIFE-HO-ICT-16\\test;Database=Product;User Id=thilanka;Password=abc@12345;Encrypt=True;TrustServerCertificate=True;";

            using (SqlConnection conn = new SqlConnection(connString))
            {
                try
                {
                    // Check if the username or email already exists
                    conn.Open();
                    string checkQuery = "SELECT COUNT(*) FROM users WHERE username = @Username OR email = @Email";
                    using (SqlCommand checkCmd = new SqlCommand(checkQuery, conn))
                    {
                        checkCmd.Parameters.AddWithValue("@Username", username);
                        checkCmd.Parameters.AddWithValue("@Email", email);

                        int userExists = (int)checkCmd.ExecuteScalar();
                        if (userExists > 0)
                        {
                            Response.Write("<script>alert('Username or Email already exists.');</script>");
                            return;
                        }
                    }

                    // Insert new user if no conflict
                    string query = "INSERT INTO users (username, email, password_hash, full_name, phone, created_at, updated_at) " +
                                   "VALUES (@Username, @Email, @Password, @FullName, @Phone, GETDATE(), GETDATE())";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Username", username);
                        cmd.Parameters.AddWithValue("@Email", email);
                        cmd.Parameters.AddWithValue("@Password", hashedPassword);
                        cmd.Parameters.AddWithValue("@FullName", fullName);
                        cmd.Parameters.AddWithValue("@Phone", phone);

                        int result = cmd.ExecuteNonQuery();
                        if (result > 0)
                        {
                            // Set the session variable to mark the user as authenticated
                            Session["IsAuthenticated"] = true;

                            // Alert and redirect to home page
                            Response.Write("<script>alert('Signup successful!');window.location='home.aspx';</script>");
                        }
                        else
                        {
                            Response.Write("<script>alert('Signup failed. Please try again.');</script>");
                        }
                    }
                }
                catch (Exception ex)
                {
                    Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
                }
            }
        }
    }
}
