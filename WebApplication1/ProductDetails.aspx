﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProductDetails.aspx.cs" Inherits="WebApplication1.ProductDetails" %>
<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Details</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        #form1 {
            width: 400px;
            margin: 0 auto;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container mt-5 pt-5">
            <h2 class="text-center">Product Details</h2>
            <div class="row mt-4">
                <div class="col-md-6">
                    <!-- Image control to display the product image -->
                    <asp:Image ID="imgProduct" runat="server" CssClass="img-fluid" />
                </div>
                <div class="col-md-6">
                    <h3><asp:Label ID="lblProductName" runat="server" Text=""></asp:Label></h3>
                    <p><asp:Label ID="lblProductDescription" runat="server" Text=""></asp:Label></p>
                    <p><strong>Price:</strong> <asp:Label ID="lblProductPrice" runat="server" Text=""></asp:Label></p>
                    <p><strong>Stock:</strong> <asp:Label ID="lblProductStock" runat="server" Text=""></asp:Label></p>
                    <button class="btn btn-primary" runat="server" onserverclick="AddToCart_Click">Add to Cart</button>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
