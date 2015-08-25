<!--#include file="conn.asp"-->
<%
Sub Get_Digg
	Dim Rs
	DbOpen
	Set Rs=Conn.Execute("Select Digg From Sd_Digg Where Followid="&ID&"")
	IF Rs.Eof Then
		Echo "0"
	Else
		Echo rs(0)
	End IF
	Rs.Close:Set Rs=Nothing
End Sub

Sub Digg
	IF Load_Cookies("Digg_"&ID)="" Then
		Dim Rs,sql
		DbOpen
		Sql="Select Digg,Followid From Sd_Digg Where Followid="&ID&""
		Set Rs=Server.CreateObject("Adodb.recordset")
		Rs.Open Sql,Conn,1,3
		IF Rs.Eof Then
			Rs.Addnew
			Rs(0)=1
			Rs(1)=ID
			Rs.update
			Echo "0已顶成"
			Add_Cookies "Digg_"&ID,ID
		Else
			Rs.update
			Rs(0)=Rs(0)+1
			Rs.update
			Echo "0已顶成"
			Add_Cookies "Digg_"&ID,ID
		End IF
		Rs.Close:Set Rs=Nothing
	Else
		Echo "1顶过了"
	End IF
End Sub

Dim ID:ID=IsNum(Trim(Request.QueryString("ID")),0)
Dim Action:Action=Lcase(Trim(Request.QueryString("Action")))
Select Case Action
	Case "digg":Digg
	Case Else:Get_Digg
End Select
Closedb
%>