<!--#include file="../Include/Const.Asp" -->
<!--#include file="../Include/NoSQL.Asp" -->
<!--#include file="../Include/ConnSiteData.Asp" -->
<!--#include file="Function.Asp" -->
<%
Call SiteInfo
if ISHTML = 1 then
Response.expires = 0
Response.expiresabsolute = Now() - 1
Response.addHeader "pragma", "no-cache"
Response.addHeader "cache-control", "private"
Response.CacheControl = "no-cache"
End If
if request.QueryString("SortID")="" then
SeoTitle=ChinaQJLanguageTxt226
ClassSeo=ProSortName
elseif not IsNumeric(request.QueryString("SortID")) then
SeoTitle=ChinaQJLanguageTxt16
elseif conn.execute("select * from ChinaQJ_ProductSort Where "&ViewFlag&" and ID="&request.QueryString("SortID")).eof then
SeoTitle=ChinaQJLanguageTxt16
else
set rs = server.createobject("adodb.recordset")
sql="select * from ChinaQJ_ProductSort where "&ViewFlag&" and ID="&request.QueryString("SortID")
rs.open sql,conn,1,1
SeoTitle=rs("SortName"&Language)
Keywords = rs("SeoKeywords" & Language)
Descriptions = rs("SeoDescription" & Language)
ClassSeo=rs("ClassSeo")
rs.close
set rs=nothing
end if
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="shortcut icon" href="favicon.ico"/>
<title><% =SeoTitle %> - <% =SiteTitle %></title>
<meta name="keywords" content="<% =Keywords %>" />
<meta name="description" content="<% =Descriptions %>" />
<!--#include file="Page_CSS.asp" -->
<script language="javascript" src="../Scripts/Html.js"></script>
<script language="javascript" src="../Scripts/Admin.js"></script>
<script type="text/javascript" src="../Scripts/Flash.js"></script>
<script src="../Scripts/clearbox.js?dir=../Scripts/clearbox&lng=Ch" type="text/javascript"></script>
<script language="JavaScript">
<!--
function killErrors() {
    return true;
}
window.onerror = killErrors;
//-->
</script>
</head>

<body>
<% menuname="产品展示" %>
<!--#include file="page_Header.asp" -->
<!--#include file="page_ProductList.asp" -->
<!--#include file="page_Footer.Asp" -->
</body>
</html>