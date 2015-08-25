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
    Set rs = server.CreateObject("Adodb.Recordset")
    sql = "Select * From ChinaQJ_Key Where ID = " & ID
    rs.Open sql, conn, 1, 1
    KeyName = rs("KeyName")
    Content = rs("Content")
    rs.Close
    Set rs = Nothing
    Set rs = server.CreateObject("Adodb.Recordset")
    sql = "Select * From ChinaQJ_KeyIdea Where ID = " & KeyName
    rs.Open sql, conn, 1, 1
    KeyIdeaName = Replace(rs("KeyIdeaName"&Language), "{关键字标签}", Content)
    KeyIdeaContent = Replace(rs("Content"&Language), "{关键字标签}", Content)
    KeyIdeaSeoKeywords = Replace(rs("SeoKeywords"&Language), "{关键字标签}", Content)
    KeyIdeaSeoDescription = Replace(rs("SeoDescription"&Language), "{关键字标签}", Content)
    KeyIdeaTheTags = Replace(rs("TheTags"&Language), "{关键字标签}", Content)
    rs.Close
    Set rs = Nothing
End If
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="shortcut icon" href="favicon.ico"/>
<title><%=KeyIdeaName%> - <%=SiteTitle%></title>
<meta name="keywords" content="<%=KeyIdeaSeoKeywords%>" />
<meta name="description" content="<%=KeyIdeaSeoDescription%>" />
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
<% menuname="服务范围" %>
<!--#include file="page_Header.asp" -->
<!--#include file="page_KeyView.asp" -->
<!--#include file="page_Footer.Asp" -->
</body>
</html>