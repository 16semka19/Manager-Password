<%@ Page Title="Реєстрація" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="MyFirstWebFotms.Register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderMain" runat="Server">
    <div class="mar"> 
    <h2>Реєстрація</h2>
    <p>Ім'я:</p>
    <p>
        <asp:TextBox ID="txtName" runat="server"></asp:TextBox>
        <br />
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtName" 
            ErrorMessage="Поле є обов'язковим!" ForeColor="Red" />
    </p>
    <p>Email:</p>
    <p>
        <asp:TextBox ID="txtEmail" runat="server"></asp:TextBox>
        <br />
        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtEmail" 
            ErrorMessage="Поле є обов'язковим!" ForeColor="Red" />
    </p>
    <p>Пароль:</p>
    <p>
        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"></asp:TextBox>
        <br />
        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtPassword"
            ErrorMessage="Поле є обов'язковим!" ForeColor="Red" />
    </p>
    <asp:Button ID="btnRegister" runat="server" Text="Зареєструватися" OnClick="btnRegister_Click" CssClass="button-style" />
    <br />
    <asp:Label ID="lblMessage" runat="server" ForeColor="Red" />
        </div>
</asp:Content>
