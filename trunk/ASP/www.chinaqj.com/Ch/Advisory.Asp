<!--#include file="../Include/Const.Asp" -->
<!--#include file="../Include/NoSQL.Asp" -->
<!--#include file="../Include/ConnSiteData.Asp" -->
<!--#include file="Function.Asp" -->
<%
Call SiteInfo
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="shortcut icon" href="favicon.ico"/>
<title><% =FormName %> - <% =SiteTitle %></title>
<meta name="keywords" content="<% =FormName %>" />
<meta name="description" content="<% =FormName %>" />
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
<%
If Trim(request("action")) = "Save" Then
    Dim ChinaQJForm
    ID = Trim(Request.Form("ClassID"))
    If ID = "" Or Not IsNumeric(ID) Then Url_Return "参数错误！"
    sql = "select * from ChinaQJ_Form_Q where ClassID = " & ID & " order by ID asc"
    Set rs = server.CreateObject("adodb.recordset")
    rs.Open sql, conn, 1, 1
    Do While Not rs.EOF
        ChinaQJ_FormV = "a_"&rs("ID")&""
        If rs("ChinaQJ_FormMust") = 1 Then
            If Trim(Request.Form(ChinaQJ_FormV)) = "" Then Url_Return "含 * 为必填项，请返回检查！"
        End If
        ChinaQJForm = ChinaQJForm&Replace(Request.Form(ChinaQJ_FormV), "|", " ")&"|"
        rs.MoveNext
    Loop
    rs.Close
    ChinaQJForm = HTMLEncode(ChinaQJForm)
    sql = "select * from ChinaQJ_Form_C"
    Set rs = server.CreateObject("adodb.recordset")
    rs.Open sql, conn, 1, 3
    rs.Addnew
    rs("ClassID") = ID
    rs("ChinaQJ_FormContent") = ChinaQJForm
    rs("ChinaQJ_FormIP") = GetIP()
    rs("ChinaQJ_FormAddTime") = Now()
    rs.Update
    rs.Close
    Set rs = Nothing
    Url_Go "数据提交成功！感谢您的关注！", "Advisory.Asp?ID="&ID&""
End If

ID = Trim(Request.QueryString("ID"))
If ID = "" Or Not IsNumeric(ID) Then Url_Return "警告：参数错误！"
sql = "select ChinaQJ_FormView,ChinaQJ_FormName from ChinaQJ_Form where ID=" & ID
Set rs = conn.Execute(sql)
If rs.EOF Then Url_Return "暂无相关数据！"
If rs(0) <> 1 Then Url_Return "数据已被锁定！"
FormName = rs(1)
rs.Close
Set rs = Nothing
%>

<body>
<!--#include file="page_Header.asp" -->
<!--#include file="page_Advisory.asp" -->
<!--#include file="page_Footer.Asp" -->
</body>
</html>