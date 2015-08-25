<!--#include file="../Inc/Conn.asp"-->
<%
Dim burl
burl = Request.ServerVariables("HTTP_REFERER")

If InStr(LCase(burl),  LCase(Sdcms_WebUrl))<=0 Then 
	Response.write("<script type='text/javascript'>alert('Error: \u8bf7\u52ff\u975e\u6cd5\u63d0\u4ea4!'); window.location.href='"&Sdcms_WebUrl&"'; </script>")
	Response.end
End If

Dim tag,Page,C

If Request.Form("tag")<>"" Then
	tag = Trim(Request.Form("tag"))
ElseIf request("tag")<>"" Then
	tag = request("tag")
End If

If tag="" Then
	Response.write("<script type='text/javascript'>alert('Tag\u4e0d\u80fd\u4e3a\u7a7a!'); window.opener = null; window.close();</script>")
	Response.end
End If

If request("Page")<>"" Then Page=request("Page") Else Page=1 End If

DbOpen

Set C=New Sdcms_Create
Call C.Create_Tag_List(tag,Page)
Set C=Nothing
CloseDb

%>