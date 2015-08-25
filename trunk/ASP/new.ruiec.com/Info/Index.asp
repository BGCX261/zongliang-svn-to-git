<!--#include file="../Inc/Conn.asp"-->
<%
DbOpen
Dim C,id,cname,turl
If Request.QueryString("ID")<>"" Then
	id = IsNum(Trim(Request.QueryString("ID")),0)
End If
If id=0 Then
	If Request.QueryString("cname")<>"" Then
		cname = (Trim(Request.QueryString("cname")))
		If right(cname,1)<>"/" Then cname=cname&"/" End If
		cname=filterstr(cname)
	End If
	If cname<>"" Then
		turl = cname
	Else
		turl = LCase(Request.ServerVariables("URL"))
		turl = Mid(turl,2,Len(turl)-10)
	End If
	set rs=conn.execute("select id from sd_class where classurl='"&turl&"'")
	if rs.eof then
		id=0
	else
		id=rs(0)
	end if
	rs.close
	set rs=Nothing
End If

If id=0 Then
	Response.Redirect Sdcms_WebUrl
	Response.end
End If

Set C=New Sdcms_Create
	C.Create_class_list(ID)
Set C=Nothing
CloseDb

function filterstr(byval t0)
	t0=replace(t0," ","")
	t0=replace(t0,"　","")
	t0=replace(t0,"&","&amp;")
	t0=replace(t0,"'","&#39;")
	t0=replace(t0,"""","&#34;")
	t0=replace(t0,"<","&lt;")
	t0=replace(t0,">","&gt;")
	if instr(t0,"expression")<>0 then
		t0=replace(t0,"expression","e&#173;xpression",1,-1,0)
	end if
	filterstr=t0
end function
%>