<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="TicketSystem.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            =Login Page=<br />
            <br />
            username:
            <asp:TextBox ID="username" runat="server"></asp:TextBox>
            <br />
            password:
            <asp:TextBox ID="password" runat="server"></asp:TextBox>
            <br /><br />
            <asp:Button ID="sigin" runat="server" OnClick="login" Text="Log In" />
            <br /><br /><br />
            &nbsp;<asp:Label runat="server" Text="Not Registered?"></asp:Label><br />
            <asp:Button ID="signup" runat="server" OnClick="register" Text="Register" />
        </div>
    </form>
</body>
</html>
