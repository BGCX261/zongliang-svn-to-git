<!--#include file="../Inc/Conn.asp"-->
<%
DbOpen
Dim C,ID
ID=IsNum(Trim(Request.QueryString("ID")),0)
Set C=New Sdcms_Create
	C.Create_info_show(ID)
Set C=Nothing
CloseDb
%>