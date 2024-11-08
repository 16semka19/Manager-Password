<%@ Page Title="Contact" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
CodeBehind="Contact.aspx.cs" Inherits="MyFirstWebFotms.Contact" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderMain" runat="Server"><h2>Контакти</h2>
 <p>ФОП Семисюк Дмитро Володимирович"</p>
 <p>
 <asp:HyperLink ID="HyperLink1" runat="server" >
 </asp:HyperLink> </p>

 <p>
 <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="http://www.prod.16semka19.com">
www.prod.16semka19.com</asp:HyperLink> </p>
 <p>Адреса: 58000 м. Чернівці, вул, Героїв Майдану 239, офіс 235</p>
 <p>Email: <a href="mailto:mail@polytech.cv.ua">mail@16semka19.cv.ua</a></p>
</asp:Content>