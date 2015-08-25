<!--#include file="../inc/conn.asp"-->
<%
'============================================================
'插件名称：Digg插件
'Website：http://www.sdcms.cn
'Author：IT平民
'Date：2008-7-6
'============================================================
Sub Up(t0)
	IF Load_Cookies("Digg_"&ID)="" Then
		Dim Sql,Rs
		DbOpen
		Sql="Select Digg,Followid,DiggType From Sd_Digg Where Followid="&ID&" And DiggType="&t0&""
		Set Rs=Server.CreateObject("Adodb.recordset")
		Rs.Open Sql,Conn,1,3
		IF Rs.Eof Then
			Rs.Addnew
			Rs(0)=1
			Rs(1)=ID
			Rs(2)=t0
			Rs.update	
		Else
			Rs.update
			Rs(0)=Rs(0)+1
			Rs.update
		End IF
		Rs.Close:Set Rs=Nothing
		Add_Cookies "Digg_"&ID,ID:Add_Cookies "Digg_Show"&ID,Empty
		Show_Digg(1)
	Else
		Show_Digg(0)
	End IF
End Sub

Function Show_Digg(t)
	IF Load_Cookies("Digg_Show"&ID)=Empty Then
		Dim Sql,Rs,t0,t1,t2,t3,t4,t5,t6,t7,t8,t9
		Dim k0,k1,k2,k3,k4,k5,k6,k7
		DbOpen
		Set Rs=Conn.Execute("Select Digg From Sd_Digg Where Followid="&ID&" And DiggType=0")
		IF Rs.Eof Then
			t0=0
		Else
			t0=Rs(0)
		End IF
		Rs.Close:Set Rs=Nothing
		Set Rs=Conn.Execute("Select Digg From Sd_Digg Where Followid="&ID&" And DiggType=1")
		IF Rs.Eof Then
			t1=0
		Else
			t1=Rs(0)
		End IF
		Rs.Close:Set Rs=Nothing
		Set Rs=Conn.Execute("Select Digg From Sd_Digg Where Followid="&ID&" And DiggType=2")
		IF Rs.Eof Then
			t2=0
		Else
			t2=Rs(0)
		End IF
		Rs.Close:Set Rs=Nothing
		Set Rs=Conn.Execute("Select Digg From Sd_Digg Where Followid="&ID&" And DiggType=3")
		IF Rs.Eof Then
			t3=0
		Else
			t3=Rs(0)
		End IF
		Rs.Close:Set Rs=Nothing
		Set Rs=Conn.Execute("Select Digg From Sd_Digg Where Followid="&ID&" And DiggType=4")
		IF Rs.Eof Then
			t4=0
		Else
			t4=Rs(0)
		End IF
		Rs.Close:Set Rs=Nothing
		Set Rs=Conn.Execute("Select Digg From Sd_Digg Where Followid="&ID&" And DiggType=5")
		IF Rs.Eof Then
			t5=0
		Else
			t5=Rs(0)
		End IF
		Rs.Close:Set Rs=Nothing
		Set Rs=Conn.Execute("Select Digg From Sd_Digg Where Followid="&ID&" And DiggType=6")
		IF Rs.Eof Then
			t6=0
		Else
			t6=Rs(0)
		End IF
		Rs.Close:Set Rs=Nothing
		Set Rs=Conn.Execute("Select Digg From Sd_Digg Where Followid="&ID&" And DiggType=7")
		IF Rs.Eof Then
			t7=0
		Else
			t7=Rs(0)
		End IF
		Rs.Close:Set Rs=Nothing
		t9=t0+t1+t2+t3+t4+t5+t6+t7
		IF t9=0 Then
			k0=0:k1=0:k2=0:k3=0:k4=0:k5=0:k6=0:k7=0
		Else
			k0=FormatNumber(t0/t9,2,True,False,True)*100
			k1=FormatNumber(t1/t9,2,True,False,True)*100
			k2=FormatNumber(t2/t9,2,True,False,True)*100
			k3=FormatNumber(t3/t9,2,True,False,True)*100
			k4=FormatNumber(t4/t9,2,True,False,True)*100
			k5=FormatNumber(t5/t9,2,True,False,True)*100
			k6=FormatNumber(t6/t9,2,True,False,True)*100
			k7=FormatNumber(t7/t9,2,True,False,True)*100
		End IF
		t8=t0&"#"&k0&":"&t1&"#"&k1&":"&t2&"#"&k2&":"&t3&"#"&k3&":"&t4&"#"&k4&":"&t5&"#"&k5&":"&t6&"#"&k6&":"&t7&"#"&k7
		Add_Cookies "Digg_Show"&ID,t8
	End IF
	Echo Load_Cookies("Digg_Show"&ID)&":"&t
End Function

Dim ID:ID=IsNum(Trim(Request.QueryString("ID")),0)
Dim Act:Act=IsNum(Trim(Request.QueryString("Act")),0)
IF Act>=8 Then Act=0
Select Case Lcase(Trim(Request.QueryString("Action")))
	Case "up":up(Act)
	Case Else:Show_Digg(1)
End select
%>