<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="TicketSystem.Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Register</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
             <asp:Label runat="server" Text="=Registration Page="></asp:Label>
            <br />
            <asp:Label runat="server" Text="--------------------------------------------------"></asp:Label>
            <br />
            <asp:Label runat="server" Text="Register as Sports Association Manager"></asp:Label>
            <br />
            name:
            <asp:TextBox ID="name_sam" runat="server"></asp:TextBox>
            <br />
            username:
            <asp:TextBox ID="username_sam" runat="server"></asp:TextBox>
            <br />
            password:
            <asp:TextBox ID="password_sam" runat="server"></asp:TextBox>
            <br /><br />
            <asp:Button runat="server" Text="Register" OnClick="register_sam"></asp:Button>
            <br />
            <asp:Label runat="server" Text="--------------------------------------------------"></asp:Label>
            <br />
            <asp:Label runat="server" Text="Register as Club Representative"></asp:Label>
            <br />
            name:
            <asp:TextBox ID="name_cr" runat="server"></asp:TextBox>
            <br />
            username:
            <asp:TextBox ID="username_cr" runat="server"></asp:TextBox>
            <br />
            password:
            <asp:TextBox ID="password_cr" runat="server"></asp:TextBox>
            <br />
            club name:
            <asp:TextBox ID="clubname" runat="server"></asp:TextBox>
            <br /><br />
            <asp:Button runat="server" Text="Register" OnClick="register_cr"></asp:Button>
            <br />
            <asp:Label runat="server" Text="--------------------------------------------------"></asp:Label>
            <br />
            <asp:Label runat="server" Text="Register as Stadium Manager"></asp:Label>
            <br />
            name:
            <asp:TextBox ID="name_sm" runat="server"></asp:TextBox>
            <br />
            username:
            <asp:TextBox ID="username_sm" runat="server"></asp:TextBox>
            <br />
            password:
            <asp:TextBox ID="password_sm" runat="server"></asp:TextBox>
            <br />
            stadium name:
            <asp:TextBox ID="stadiumname" runat="server"></asp:TextBox>
            <br /><br />
            <asp:Button runat="server" Text="Register" OnClick="register_sm"></asp:Button>
            <br />
            <asp:Label runat="server" Text="--------------------------------------------------"></asp:Label>
            <br />
            <asp:Label runat="server" Text="Register as Fan"></asp:Label>
            <br />
            name:
            <asp:TextBox ID="name_fan" runat="server"></asp:TextBox>
            <br />
            username:
            <asp:TextBox ID="username_fan" runat="server"></asp:TextBox>
            <br />
            password:
            <asp:TextBox ID="password_fan" runat="server"></asp:TextBox>
            <br />
            national id:
            <asp:TextBox ID="nationalid" runat="server"></asp:TextBox>
            <br />
            phone number:
            <asp:TextBox ID="phonenumber" runat="server"></asp:TextBox>
            <br />
            birth date:
            <asp:TextBox ID="birthdate" runat="server"></asp:TextBox>
            <br />
            address:
            <asp:TextBox ID="address" runat="server"></asp:TextBox>
            <br /><br />
            <asp:Button runat="server" Text="Register" OnClick="register_fan"></asp:Button>
            <br />
            <asp:Label runat="server" Text="--------------------------------------------------"></asp:Label>
        </div>
    </form>
</body>
</html>
