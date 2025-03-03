<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Signup.aspx.cs" Inherits="WebApplication1.Signup" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nike Signup</title>
    <link rel="stylesheet" href="styles/login.css" />
</head>
<body>
    <form id="form1" runat="server" enctype="multipart/form-data">
        <div class="container">
            <div class="left-section">
                <img src="Imagesnew/awTg2o.jpg" alt="Nike Shoes" class="shoes-image" />
                <div class="overlay">
                    
                </div>
            </div>
            <div class="right-section">
                <div class="logo">
                    <img src="Imagesnew/OIP2.jpeg" alt="Jordan Logo" />
                </div>

                <div class="form-group">
                    <asp:TextBox ID="txtName" runat="server" CssClass="input-field" placeholder="Name"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtName" ErrorMessage="Name is required." CssClass="error-message" />
                </div>

                <div class="form-group">
                    <asp:TextBox ID="txtUsername" runat="server" CssClass="input-field" placeholder="Username"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvUsername" runat="server" ControlToValidate="txtUsername" ErrorMessage="Username is required." CssClass="error-message" />
                </div>

                <div class="form-group">
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="input-field" placeholder="Email"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="Email is required." CssClass="error-message" />
                    <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="Invalid email format." CssClass="error-message" ValidationExpression="^\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$" />
                </div>

                <div class="form-group">
                    <asp:TextBox ID="txtPhone" runat="server" CssClass="input-field" placeholder="Phone"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvPhone" runat="server" ControlToValidate="txtPhone" ErrorMessage="Phone number is required." CssClass="error-message" />
                </div>

                <div class="form-group">
                    <asp:FileUpload ID="fuProfilePicture" runat="server" CssClass="input-field" />
                </div>

                <div class="form-group">
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="input-field" TextMode="Password" placeholder="Password"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword" ErrorMessage="Password is required." CssClass="error-message" />
                </div>

                <div class="form-group">
                    <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="input-field" TextMode="Password" placeholder="Confirm Password"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvConfirmPassword" runat="server" ControlToValidate="txtConfirmPassword" ErrorMessage="Confirm Password is required." CssClass="error-message" />
                    <asp:CompareValidator ID="cvPassword" runat="server" ControlToValidate="txtConfirmPassword" ControlToCompare="txtPassword" ErrorMessage="Passwords do not match." CssClass="error-message" />
                </div>

                <asp:Button ID="btnSignupSubmit" runat="server" CssClass="signup-btn" Text="SIGN UP" OnClick="btnSignupSubmit_Click" style="margin-bottom: 10px;" />
                <asp:Button ID="btnLoginSubmit" runat="server" CssClass="login-btn" Text="LOGIN" PostBackUrl="~/Login.aspx" />
            </div>
        </div>
    </form>
</body> 
</html>
