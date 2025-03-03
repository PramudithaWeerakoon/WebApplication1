<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="WebApplication1.Login" %>
<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nike Login</title>
    <link rel="stylesheet" href="styles/login.css" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="left-section">
                <img src="Imagesnew/awTg2o.jpg" alt="Nike Shoes" class="shoes-image" />
            </div>
            <div class="right-section">
                <div class="logo">
                    <img src="Imagesnew/OIP2.jpeg" alt="Jordan Logo" /> 
                </div>
                <div class="form-group">
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="input-field" placeholder="Email"></asp:TextBox>
                </div>
                <div class="form-group">
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="input-field" TextMode="Password" placeholder="Password"></asp:TextBox>
                </div>
                <asp:LinkButton ID="lnkForgotPassword" runat="server" CssClass="forgot-password">Forgot Password?</asp:LinkButton>
                <asp:Button ID="btnLoginSubmit" runat="server" CssClass="login-btn" Text="LOGIN" OnClick="btnLoginSubmit_Click" style="margin-bottom: 10px;" />
                <asp:Button ID="btnLoginSubmit1" runat="server" CssClass="signup-btn" Text="SIGN UP" PostBackUrl="~/Signup.aspx" />
                <div class="social-login">
                    <p>Or Login With</p>
                    <img src="Imagesnew/OIP.jpeg" alt="Google" class="social-icon" />
                    <img src="Imagesnew/OIP1.jpeg" alt="Facebook" class="social-icon" />
                </div>
            </div>
        </div>
    </form>
</body>
</html>
