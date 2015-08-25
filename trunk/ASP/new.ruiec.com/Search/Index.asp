<!--#include file="../Inc/Conn.asp"-->
<%
Dim burl
burl = Request.ServerVariables("HTTP_REFERER")

If InStr(LCase(burl),  LCase(Sdcms_WebUrl))<=0 Then 
	Response.write("<script type='text/javascript'>alert('Error: \u8bf7\u52ff\u975e\u6cd5\u63d0\u4ea4!'); window.location.href='"&Sdcms_WebUrl&"'; </script>")
	Response.end
End If

Dim so_key,Page,C

If Request.Form("so_key")<>"" Then
	so_key = v(Trim(Request.Form("so_key")))
ElseIf request("key")<>"" Then
	so_key = v(request("key"))
End If

If so_key="" Then
	Response.write("<script type='text/javascript'>alert('\u5173\u952e\u5b57\u4e0d\u80fd\u4e3a\u7a7a!'); window.opener = null; window.close();</script>")
	Response.end
End If

If request("Page")<>"" Then Page=request("Page") Else Page=1 End If

DbOpen

If Page=1 Then
	Add_key(so_key) 
End If

Set C=New Sdcms_Create
Call C.Create_Search_List(rv(so_key),Page)
Set C=Nothing
CloseDb
Sub Add_key(t0)
	IF Conn.execute("Select Count(id) From Sd_Search Where title='"&t0&"'")(0)=0 Then
	   Conn.execute("Insert Into Sd_Search (title,ispass,adddate) values('"&t0&"',1,'"&Dateadd("h",Sdcms_TimeZone,Now())&"')")
	Else
	   Conn.execute("Update Sd_Search Set hits=hits+1 Where title='"&t0&"'")
	End If
End Sub
%>