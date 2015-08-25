<!--#include file="../Inc/Conn.asp"-->
<%
DbOpen
Dim C,ID,cname
cname=(Trim(request.QueryString("cname")))
if right(cname,1)<>"/" then cname=cname&"/"
cname=filterstr(cname)
set rs=conn.execute("select id from sd_class where classurl='"&cname&"'")
if rs.eof then
	id=0
else
	id=rs(0)
end if
rs.close
set rs=nothing
if id=0 then
	ID=IsNum(Trim(Request.QueryString("ID")),0)
end if
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