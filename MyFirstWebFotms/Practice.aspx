<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
CodeBehind="Practice.aspx.cs" Inherits="MyFirstWebFotms.Practice" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderMain" runat="Server">
 <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/
pub/shockwave/cabs/flash/swflash.cab# version=9,0,0,0" width="610" height="103">
 <param name="movie" value="flash/flash2.swf" />
 <param name="quality" value="best" />
 <param name="menu" value="true" /><param name="allowScriptAccess" value="sameDomain" />
 <img src="image/wow.gif" height="200" width="634" border="0"> </object>
 <h2>Довідник</h2>
 <p>
 <asp:HyperLink ID="HyperLink3" runat="server" NavigateUrl="book\attack HTTP.pdf"
CssClass="hyperlink">HTTP</asp:HyperLink>
 </p>
 <p>
 <asp:HyperLink ID="HyperLink4" runat="server" NavigateUrl="files/Лабораторна робота №4.pdf"
CssClass="hyperlink">HTTPS</asp:HyperLink>
</p>
 <p>
 <asp:HyperLink ID="HyperLink5" runat="server" NavigateUrl="files/Лабораторна робота №5.pdf"
CssClass="hyperlink">SQL</asp:HyperLink>

 </p>
 <p>
 <asp:HyperLink ID="HyperLink6" runat="server" NavigateUrl="files/Лабораторна робота №6.pdf"
CssClass="hyperlink">Metasploit</asp:HyperLink>

</p>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderBar" runat="Server"><h2>Література</h2>
 <asp:HyperLink ID="HyperLink8" runat="server" NavigateUrl="http://www.ozon.ru/context/detail/id/5602592/"
ImageUrl="images/books/1.jpeg" ImageWidth="100px" CssClass="books"></asp:HyperLink>
 <asp:HyperLink ID="HyperLink13" runat="server" NavigateUrl="http://www.amazon.com/Beginning-MicrosoftServer-2012-Programming/dp/1118102282" ImageUrl="images/books/6.jpeg" ImageWidth="100px"
CssClass="books"></asp:HyperLink>
</asp:Content>
