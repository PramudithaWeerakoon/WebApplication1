\<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="WebApplication1.Profile" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <title>Profile</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

    <style>
        /* Make sure body and html take full height */
        html, body {
            height: 100%;
            margin: 0;
            padding: 0;
            overflow: hidden; /* Disable scrollbars */
        }

        /* Custom button styles */
        .btn-custom {
            font-size: 15px !important;  /* Set font size */
            height: 40px !important;     /* Set height explicitly */
            padding: 0 20px !important;  /* Control the padding */
            width: auto !important;      /* Let width be auto (instead of 100%) */
        }

        /* Back button style */
        .btn-back {
            background-color: #dc3545 !important;  /* Red color for the back button */
            border-color: #dc3545 !important;      /* Ensure border color matches */
        }

        /* Center the buttons in the parent container */
        .button-container {
            display: flex;
            justify-content: flex-start; /* Align to the left */
            gap: 10px; /* Add space between buttons */
        }

        /* Ensure the profile section doesn't overflow and is centered properly */
        .profile-section {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            height: 100%;
        }

        /* Make sure the profile picture is responsive */
        #imgProfilePicture {
            max-width: 100%;
            height: auto;
        }

        .profile-info {
            flex: 1;
            margin-left: 20px;
        }

        /* Adjusting the height of the password section and profile details to fit */
        .password-section {
            margin-top: 20px;
            flex: 1;
            display: flex;
            flex-direction: column;
        }

        .container {
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            height: 100%;
            padding-bottom: 20px;
        }

    </style>
</head>
<body>
    <form id="form1" runat="server" class="container">
        <h2 class="mt-4">Profile Details</h2>

        <div class="profile-section">
            <div class="col-md-3">
                <!-- Profile Picture -->
                <img id="imgProfilePicture" runat="server" class="img-thumbnail" />
            </div>
            <div class="profile-info col-md-9">
                <!-- Profile Information -->
                <p><strong>Full Name: </strong><asp:Label ID="lblFullName" runat="server" CssClass="form-control" ReadOnly="true"></asp:Label></p>
                <p><strong>Email: </strong><asp:Label ID="lblEmail" runat="server" CssClass="form-control" ReadOnly="true"></asp:Label></p>
                <p><strong>Phone: </strong><asp:Label ID="lblPhone" runat="server" CssClass="form-control" ReadOnly="true"></asp:Label></p>
                <p><strong>Last Login: </strong><asp:Label ID="lblLastLogin" runat="server" CssClass="form-control" ReadOnly="true"></asp:Label></p>
            </div>
        </div>

        <!-- Button container with flexbox to control alignment and spacing -->
        <div class="button-container mt-3">
            <!-- Back Button -->
            <asp:Button ID="btnBackToHome" runat="server" Text="Back to Home" CssClass="btn btn-danger btn-custom btn-back" OnClick="btnBackToHome_Click" />
        </div>

        <!-- Password Update Section -->
        <h3 class="mt-4">Change Password</h3>
        <div class="password-section row">
            <div class="col-md-9">
                <div class="form-group">
                    <label for="txtCurrentPassword">Current Password</label>
                    <asp:TextBox ID="txtCurrentPassword" runat="server" CssClass="form-control" TextMode="Password" Placeholder="Enter current password"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label for="txtNewPassword">New Password</label>
                    <asp:TextBox ID="txtNewPassword" runat="server" CssClass="form-control" TextMode="Password" Placeholder="Enter new password"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label for="txtConfirmPassword">Confirm New Password</label>
                    <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-control" TextMode="Password" Placeholder="Confirm new password"></asp:TextBox>
                </div>
                <asp:Button ID="Button1" runat="server" Text="Update Password" CssClass="btn btn-primary btn-block btn-custom" OnClick="btnUpdatePassword_Click" />
                <asp:Label ID="lblPasswordStatus" runat="server" CssClass="mt-2" />
            </div>
        </div>

    </form>

    <!-- Optional Bootstrap JS for Modal or alerts (if needed) -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>
