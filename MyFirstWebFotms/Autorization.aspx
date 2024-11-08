<%@ Page Title="Autorization" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="Autorization.aspx.cs" Inherits="MyFirstWebFotms.Autorization" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
    <div class="mar" style="text-align: center;">
        <h2>Авторизація</h2>
        <p>Email:</p>
        <p>
            <asp:TextBox ID="txtEmail"  CssClass="marg"  runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtEmail" ErrorMessage="Поле є обов'язковим!" ForeColor="Red" />
        </p>
        <p>Пароль:</p>
        <p>
            <asp:TextBox ID="txtPassword" CssClass="marg" runat="server" TextMode="Password"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtPassword" ErrorMessage="Поле є обов'язковим!" ForeColor="Red" />
        </p>
        <asp:Button ID="btnLogin" runat="server" Text="Авторизація" CssClass="button-style" OnClick="btnLogin_Click" />
        
       
        <asp:Button ID="btnRegister" runat="server" Text="Реєстрація" CssClass="button-style" OnClick="btnRegister_Click" CausesValidation="false" />
        
        <br />
        <asp:Label ID="lblMessage" runat="server" ForeColor="Red" />
        <!-- Додаткові мітки для діагностики (тимчасово) -->
        <!-- <asp:Label ID="lblHashedPassword" runat="server" ForeColor="Blue" /> -->
    </div>
</asp:Content>
