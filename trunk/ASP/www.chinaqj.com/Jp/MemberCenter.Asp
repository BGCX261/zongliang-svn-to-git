<!--#include file="../Include/Const.Asp" -->
<!--#include file="../Include/NoSQL.Asp" -->
<!--#include file="../Include/ConnSiteData.Asp" -->
<!--#include file="Function.Asp" -->
<%Call SiteInfo%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="shortcut icon" href="favicon.ico"/>
<title><%=ChinaQJLanguageTxt22%> - <% =SiteTitle %></title>
<meta name="keywords" content="<% =Keywords %>" />
<meta name="description" content="<% =Descriptions %>" />
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
<!--#include file="page_Header.asp" -->
<!--#include file="Page_MemberCenter.asp" -->
<!--#include file="page_Footer.Asp" -->
</body>
</html>
<script language="javascript">
<!--
function refreshimg(){document.all.checkcode.src="../Include/CheckCode/CheckCode.Asp";}
//-->
</script>