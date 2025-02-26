<%@ Page Title="Home" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="WebApplication1.home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="styles/home.css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Navigation Bar -->
    <nav class="navbar">
        <div class="logo1">
            <img src="Imagesnew/OIP2.jpeg" alt="Jordan Logo" />
        </div>
        <ul class="nav-links">
            <li><a href="#">MEN</a></li>
            <li><a href="#">WOMEN</a></li>
            <li><a href="#">KIDS</a></li>
            <li><a href="#">COLLECTION</a></li>
            <li><a href="#">TRENDS</a></li>
        </ul>
        <div class="login-btn">
            <!-- Login Button -->
            <asp:Button ID="btnLogin" runat="server" CssClass="btn-login" Text="LOGIN" OnClick="btnLogin_Click" Visible="false" />
            <!-- Logout Button -->
            <asp:Button ID="btnLogout" runat="server" CssClass="btn-login" Text="LOGOUT" OnClick="btnLogout_Click" Visible="false" />
            <!-- Profile Button -->
            <asp:Button ID="btnProfile" runat="server" CssClass="btn-login" Text="PROFILE" OnClick="btnProfile_Click" Visible="false" />
        </div>
    </nav>

    <!-- Hero Section -->
    <div class="hero-section">
        <div class="hero-text">
            <h1>Find The Best <br> Products <br> For You</h1>
            <p>Horem Ipsum Dolor Sit Amet, Consectetur Adipiscing Elit. 
               Nunc Vulpulate Libero Et Velit Interdum, Ac Aliquet Odio Mattis. 
               Class Aptent Taciti Sociosqu Ad Litora.</p>
            <asp:Button ID="btnShopNow" runat="server" CssClass="btn-shop" Text="SHOP NOW" OnClick="btnShopNow_Click" />
        </div>
        <div class="hero-image">
            <img src="Imagesnew/erf.png" alt="Fashion Model">
        </div>
    </div>
</asp:Content>
