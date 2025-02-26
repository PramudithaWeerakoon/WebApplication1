using System;
using System.Data.SqlClient;
using BCrypt.Net;  // For password hashing

namespace WebApplication1
{
    public partial class Profile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["IsAuthenticated"] != null && (bool)Session["IsAuthenticated"] == true)
                {
                    LoadProfileDetails();
                }
                else
                {
                    Response.Redirect("Login.aspx"); // If the user is not authenticated
                }
            }
        }

        private void LoadProfileDetails()
        {
            // Retrieve the user's ID from session
            int userId = (int)Session["UserId"];
            string connString = "Server=LIFE-HO-ICT-16\\test;Database=Product;User Id=thilanka;Password=abc@12345;Encrypt=True;TrustServerCertificate=True;";

            using (SqlConnection conn = new SqlConnection(connString))
            {
                try
                {
                    conn.Open();
                    string query = "SELECT full_name, email, phone, last_login, profile_picture, password_hash FROM users WHERE id = @UserId";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@UserId", userId);

                        SqlDataReader reader = cmd.ExecuteReader();
                        if (reader.HasRows)
                        {
                            reader.Read();
                            lblFullName.Text = reader["full_name"].ToString();
                            lblEmail.Text = reader["email"].ToString();
                            lblPhone.Text = reader["phone"].ToString();
                            lblLastLogin.Text = reader["last_login"].ToString();
                            string profilePicture = reader["profile_picture"].ToString();

                            // Set profile picture (if you have one)
                            if (!string.IsNullOrEmpty(profilePicture))
                            {
                                imgProfilePicture.Src = profilePicture;  // Set image URL
                            }

                            // For password display, we generally won't show it, but can set it for update purposes.
                            // Example: lblPassword.Text = "********"; - or use a textbox for editing password
                            txtCurrentPassword.Text = ""; // Empty the password field to hide it initially
                        }
                        else
                        {
                            Response.Redirect("Login.aspx"); // If user not found, redirect to login
                        }
                    }
                }
                catch (Exception ex)
                {
                    Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
                }
            }
        }

        protected void btnBackToHome_Click(object sender, EventArgs e)
        {
            // Redirect to the home page
            Response.Redirect("Home.aspx");
        }


        protected void btnUpdatePassword_Click(object sender, EventArgs e)
        {
            string currentPassword = txtCurrentPassword.Text.Trim();
            string newPassword = txtNewPassword.Text.Trim();
            string confirmPassword = txtConfirmPassword.Text.Trim();

            // Check if the new password and confirm password match
            if (newPassword != confirmPassword)
            {
                Response.Write("<script>alert('New password and confirmation do not match!');</script>");
                return;
            }

            // Retrieve the user's ID from session
            int userId = (int)Session["UserId"];
            string connString = "Server=LIFE-HO-ICT-16\\test;Database=Product;User Id=thilanka;Password=abc@12345;Encrypt=True;TrustServerCertificate=True;";

            using (SqlConnection conn = new SqlConnection(connString))
            {
                try
                {
                    conn.Open();
                    // Query to retrieve the stored password hash
                    string query = "SELECT password_hash FROM users WHERE id = @UserId";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@UserId", userId);

                        SqlDataReader reader = cmd.ExecuteReader();
                        if (reader.HasRows)
                        {
                            reader.Read();
                            string storedPasswordHash = reader["password_hash"].ToString();

                            // Verify the current password using BCrypt
                            if (BCrypt.Net.BCrypt.Verify(currentPassword, storedPasswordHash))
                            {
                                // Hash the new password before storing it
                                string newPasswordHash = BCrypt.Net.BCrypt.HashPassword(newPassword);

                                // Update the password in the database
                                reader.Close(); // Close the previous reader
                                string updateQuery = "UPDATE users SET password_hash = @NewPassword WHERE id = @UserId";
                                using (SqlCommand updateCmd = new SqlCommand(updateQuery, conn))
                                {
                                    updateCmd.Parameters.AddWithValue("@NewPassword", newPasswordHash);
                                    updateCmd.Parameters.AddWithValue("@UserId", userId);

                                    int rowsAffected = updateCmd.ExecuteNonQuery();
                                    if (rowsAffected > 0)
                                    {
                                        Response.Write("<script>alert('Password updated successfully!');</script>");
                                    }
                                    else
                                    {
                                        Response.Write("<script>alert('Password update failed!');</script>");
                                    }
                                }
                            }
                            else
                            {
                                Response.Write("<script>alert('Current password is incorrect!');</script>");
                            }
                        }
                        else
                        {
                            Response.Write("<script>alert('User not found!');</script>");
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
