<!--#include file="../Include/Const.Asp" -->
<!--#include file="../Include/NoSQL.Asp" -->
<!--#include file="../Include/ConnSiteData.Asp" -->
<!--#include file="Function.Asp" -->
<% Call SiteInfo %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="shortcut icon" href="favicon.ico"/>
<title><%=ChinaQJLanguageTxt254%> - <% =SiteTitle %></title>
<meta name="keywords" content="<% =Keywords %>" />
<meta name="description" content="<% =Descriptions %>" />
<%
Dim Action
Action = Request.QueryString("Action")
ChinaQJSubscribe = Trim(Request.Form("ChinaQJSubscribe"))
If ChinaQJSubscribe = "" Then
response.write "<script language=""JavaScript"">alert('"&ChinaQJLanguageTxt255&"');" & "history.back()" & "</script>"
response.End
End If
Select Case Action
Case "Add"
set rs = server.createobject("adodb.recordset")
sql="select * from ChinaQJ_EMail where ChinaQJ_EMail = '"&ChinaQJSubscribe&"'"
rs.open sql,conn,1,3
If rs.bof And rs.eof Then
rs.addnew
rs("ChinaQJ_EMail") = ChinaQJSubscribe
rs("ChinaQJ_PubTime") = Now()
rs.update
Else
response.write "<script language=""JavaScript"">alert('"&ChinaQJLanguageTxt256&"');" & "history.back()" & "</script>"
End If
rs.close
Set rs = Nothing
response.write "<script language=""JavaScript"">alert('"&ChinaQJLanguageTxt257&"\n"&ChinaQJLanguageTxt258&"【"&ComName&"】"&ChinaQJLanguageTxt259&"');" & "history.back()" & "</script>"
Case "Del"
Error = True
set rs = server.createobject("adodb.recordset")
sql="select * from ChinaQJ_EMail where ChinaQJ_EMail = '"&ChinaQJSubscribe&"'"
rs.open sql,conn,1,1
If rs.bof And rs.eof Then
error = False
End If
rs.close
Set rs = Nothing
If Error = True Then
conn.execute("delete from ChinaQJ_EMail where ChinaQJ_EMail = '"&ChinaQJSubscribe&"'")
response.write "<script language=""JavaScript"">alert('"&ChinaQJLanguageTxt260&"');" & "history.back()" & "</script>"
Else
response.write "<script language=""JavaScript"">alert('"&ChinaQJLanguageTxt261&"');" & "history.back()" & "</script>"
End If
End Select
%>