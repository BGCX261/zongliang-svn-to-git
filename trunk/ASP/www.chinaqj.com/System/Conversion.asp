<!--#include file="../Include/Const.asp" -->
<!--#include file="../Include/ConnSiteData.asp" -->
<!--#include file="CheckAdmin.asp"-->
<%
ID=request.QueryString("ID")
LX=request.QueryString("LX")
Operation=request.QueryString("Operation")
strReferer=Request.ServerVariables("http_referer")
ViewLanguage=request.QueryString("ViewLanguage")

If Operation = "up" Then
Conn.execute "update "&LX&" set ViewFlag"&ViewLanguage&" = 1 where ID=" & ID
Else
Conn.execute "update "&LX&" set ViewFlag"&ViewLanguage&" = 0 where ID=" & ID
End If

If Operation = "BizOK" Then
Conn.execute "update "&LX&" set BizOK = 1 where ID=" & ID
End If

response.Redirect strReferer
%>