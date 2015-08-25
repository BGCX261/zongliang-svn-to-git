<!--#include file="Include/Const.Asp" -->
<!--#include file="Include/ConnSiteData.Asp" -->
<%
If ISHTML = 1 Then
response.redirect Default_Index&"/index.html"
else
response.redirect Default_Index&"/index.asp"
End If
%>