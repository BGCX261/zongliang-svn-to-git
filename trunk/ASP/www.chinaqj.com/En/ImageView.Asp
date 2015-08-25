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
ID=request.QueryString("ID")
if ID <> "" or IsNumeric(ID) then
set rs = server.createobject("adodb.recordset")
sql="select * from ChinaQJ_Image where "&ViewFlag&" and ID="&ID
rs.open sql,conn,1,3
If rs("SeoKeywords"&Language) <> "" Then
SeoKeywords=rs("SeoKeywords"&Language)
Else
SeoKeywords=rs("ImageName"&Language)
End If
If rs("SeoDescription"&Language) <> "" Then
SeoDescription=rs("SeoDescription"&Language)
Else
SeoDescription=rs("ImageName"&Language)
End If
SeoTitle=rs("ImageName"&Language)
End If
rs.close
set rs=nothing
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="shortcut icon" href="favicon.ico"/>
<title><% =SeoTitle %> - <% =SiteTitle %></title>
<meta name="keywords" content="<% =SeoKeywords %>" />
<meta name="description" content="<% =SeoDescription %>" />
<!--#include file="Page_CSS.asp" -->
<script language="javascript" src="../Scripts/Admin.js"></script>
<script type="text/javascript" src="../Scripts/Flash.js"></script>
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
<% menuname="客户案例" %>
<!--#include file="page_Header.asp" -->
<!--#include file="page_ImageView.asp" -->
<!--#include file="page_Footer.Asp" -->
</body>
</html>