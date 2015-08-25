<!--#include file="../Inc/Conn.asp"-->
<%
IF Sdcms_Mode<2 Then
	DbOpen
	Dim C,ID
	ID=IsNum(Trim(Request.QueryString("ID")),0)
	Set C=New Sdcms_Create
		C.Create_Other(ID)
	Set C=Nothing
	CloseDb
End IF
%>