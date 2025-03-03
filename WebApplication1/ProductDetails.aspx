<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Shop.aspx.cs" Inherits="WebApplication1.Products" %>
<!DOCTYPE html>
<html lang="en">
<head runat="server">
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Product Listing</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" />
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  <link rel="stylesheet" href="styles/shop.css" />
  <style>
    /* Cart Icon Styling */
    .cart-icon {
      position: fixed;
      top: 20px;
      right: 20px;
      font-size: 24px;
      color: #000;
      background-color: #fff;
      padding: 10px;
      border-radius: 50%;
      box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);
      z-index: 100;
    }
    
    .modal-content {
      padding: 20px;
      border-radius: 10px;
    }

    .modal-header {
      background-color: #f8f9fa;
    }

    .modal-body {
      display: flex;
      justify-content: center;
      align-items: center;
    }

    /* Ensure the image in the modal scales to fit and maintains its aspect ratio */
    #productImage {
      max-width: 100%;
      height: auto;
      object-fit: contain;
    }

    .modal-dialog {
      max-width: 800px; /* Ensure the modal has a maximum width */
    }

    /* Optional: Styling for the modal content */
    .modal-body {
      padding: 30px;
    }

    .product-details {
      padding-left: 20px;
    }
  </style>
</head>
<body>
  <form id="form1" runat="server">
    <!-- Cart Icon with Item Count -->
    <div class="cart-icon">
      <a href="#" id="cartIcon" data-bs-toggle="modal" data-bs-target="#cartModal">
        <i class="fas fa-shopping-cart fa-lg"></i>
        Cart <asp:Label ID="lblCartItemCount" runat="server" Text="0"></asp:Label>
      </a>
    </div>

    <!-- Product Listing -->
    <div class="container mt-5">
      <h2 class="text-center">Our Products</h2>
      <div class="row mt-4">
        <asp:Repeater ID="rptProducts" runat="server">
          <ItemTemplate>
            <div class="col-md-4 mb-4">
              <div class="card p-3 shadow-sm"
                   data-bs-toggle="modal" data-bs-target="#productModal"
                   data-id='<%# Eval("Id") %>'
                   data-name='<%# Eval("Name") %>'
                   data-description='<%# Eval("Description") %>'
                   data-price='<%# Eval("Price") %>'
                   data-stock='<%# Eval("StockQuantity") %>'
                   data-image='<%# Eval("ImageUrl") %>'>
                <img src='<%# Eval("ImageUrl") %>' class="card-img-top img-fluid" alt="Product Image" />
                <div class="card-body text-center">
                  <h5 class="card-title"><%# Eval("Name") %></h5>
                  <p class="card-text"><%# Eval("Description") %></p>
                  <p class="text-muted">£<%# Eval("Price") %></p>
                  <p><strong>Stock:</strong> <%# Eval("StockQuantity") %> available</p>
                  <asp:Button runat="server" CssClass="btn btn-primary" Text="Add to Cart" 
                              CommandArgument='<%# Eval("Id") %>' 
                              CommandName='<%# Eval("Price") %>'
                              OnClick="AddToCart_Click" />
                </div>
              </div>
            </div>
          </ItemTemplate>
        </asp:Repeater>
      </div>
    </div>

    <!-- Product Modal (for viewing product details) -->
    <div class="modal fade" id="productModal" tabindex="-1" aria-labelledby="productModalLabel" aria-hidden="true">
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="productModalLabel"></h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
            <div class="row">
              <!-- Image on the left side -->
              <div class="col-md-6">
                <img id="productImage" class="img-fluid" src="" alt="Product Image" />
              </div>
              <!-- Product details on the right side -->
              <div class="col-md-6 product-details">
                <h4 id="productName"></h4>
                <p id="productDescription"></p>
                <p><strong>Price:</strong> £<span id="productPrice"></span></p>
                <p><strong>Stock:</strong> <span id="productStock"></span> available</p>
                <button class="btn btn-primary" id="addToCartBtn">Add to Cart</button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Cart Modal (hidden by default) -->
    <div class="modal fade" id="cartModal" tabindex="-1" aria-labelledby="cartModalLabel" aria-hidden="true">
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="cartModalLabel">Your Cart</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body" id="cartItemsContainer">
            <p>Your cart is empty.</p>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            <button type="button" class="btn btn-primary" id="checkoutBtn">Checkout</button>
          </div>
        </div>
      </div>
    </div>
    
  </form> <!-- Close the form tag here -->
  
  <script>
      // Client-side cart management
      var cart = [];

      // Function to add an item to the cart
      function addToCart(productId, productName, productPrice) {
          var item = {
              id: productId,
              name: productName,
              price: productPrice
          };

          cart.push(item);
          updateCartUI();
      }

      // Function to update the cart UI (icon count & modal display)
      function updateCartUI() {
          // Update the cart icon count
          $('#cartItemCount').text(cart.length);

          // Update the cart items in the modal
          var cartItemsHTML = '';
          if (cart.length === 0) {
              cartItemsHTML = '<p>Your cart is empty.</p>';
          } else {
              cart.forEach(function (item, index) {
                  cartItemsHTML += `<div class="cart-item">
              <strong>${item.name}</strong> - £${item.price}
              <br/>
              <button class="btn btn-danger btn-sm" onclick="removeFromCart(${index})">Remove</button>
            </div>`;
              });
          }
          $('#cartItemsContainer').html(cartItemsHTML);
      }

      // Function to remove an item from the cart
      function removeFromCart(index) {
          cart.splice(index, 1);
          updateCartUI();
      }

      // When the "Add to Cart" button in the product modal is clicked
      $('#addToCartBtn').on('click', function () {
          var productId = $('#productModal').data('id');
          var productName = $('#productModal').data('name');
          var productPrice = $('#productModal').data('price');
          addToCart(productId, productName, productPrice);
          $('#productModal').modal('hide');
      });

      // Populate the product modal with details from the clicked product card
      $(document).ready(function () {
          $('#productModal').on('show.bs.modal', function (event) {
              var button = $(event.relatedTarget); // Element that triggered the modal
              var productId = button.data('id');
              var productName = button.data('name');
              var productDescription = button.data('description');
              var productPrice = button.data('price');
              var productStock = button.data('stock');
              var productImage = button.data('image');

              var modal = $(this);
              modal.find('#productModalLabel').text(productName);
              modal.find('#productName').text(productName);
              modal.find('#productDescription').text(productDescription);
              modal.find('#productPrice').text(productPrice);
              modal.find('#productStock').text(productStock);
              modal.find('#productImage').attr('src', productImage);

              // Save details on the modal so they can be used when adding to cart
              modal.data('id', productId);
              modal.data('name', productName);
              modal.data('price', productPrice);
          });
      });
  </script>
</body>
</html>
