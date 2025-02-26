using System;

namespace WebApplication1
{
    public partial class home : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Check if the user is authenticated
            if (Session["IsAuthenticated"] != null && (bool)Session["IsAuthenticated"] == true)
            {
                // If authenticated, show Logout and Profile buttons, hide Login button
                btnLogin.Visible = false;
                btnLogout.Visible = true;
                btnProfile.Visible = true;  // Show the Profile button
            }
            else
            {
                // If not authenticated, show Login button, hide Logout and Profile buttons
                btnLogin.Visible = true;
                btnLogout.Visible = false;
                btnProfile.Visible = false;
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            Response.Redirect("Login.aspx"); // Redirect to login page
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            // Clear the session
            Session["IsAuthenticated"] = null;

            // Use JavaScript to refresh the page
            ClientScript.RegisterStartupScript(this.GetType(), "refresh", "location.reload();", true);
        }

        protected void btnProfile_Click(object sender, EventArgs e)
        {
            Response.Redirect("Profile.aspx"); // Redirect to profile page
        }

        protected void btnShopNow_Click(object sender, EventArgs e)
        {
            Response.Redirect("Shop.aspx"); // Redirect to shopping page
        }
    }
}
