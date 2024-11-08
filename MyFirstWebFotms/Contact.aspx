<%@ Page Title="Contact" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
CodeBehind="Contact.aspx.cs" Inherits="MyFirstWebFotms.Contact" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderMain" runat="Server"><h2>Контакти</h2>
 <p>ДВНЗ "Чернівецький політехнічний коледж"</p>
 <p>
 <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="http://www.polytech.cv.ua">
http://www.polytech.cv.ua </asp:HyperLink> </p>
 <p>Ціклова комісія інженерії програмного забезпечення</p>
 <p>
 <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="http://www.moodle.polytech.cv.ua">
http://www.moodle.polytech.cv.ua</asp:HyperLink> </p>
 <p>Адреса: 58000 м. Чернівці, вул. П. Каспрука, 2</p>
 <p>Email: <a href="mailto:mail@polytech.cv.ua">mail@polytech.cv.ua</a></p>
</asp:Content>