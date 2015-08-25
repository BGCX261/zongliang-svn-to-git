<!--#include file="../../Inc/Conn.asp"-->
<%
'============================================================
'插件名称：投票
'Website：http://www.sdcms.cn
'Author：IT平民
'Date：2008-8-25
'Update:2009-10-5
'============================================================
Sub SaveVote
	Dim Rs,Sql,t0
	DbOpen
	Set Rs=server.CreateObject("adodb.recordset")
	Sql="Select result From Sd_Vote Where Id="&id&""
	Rs.Open Sql,Conn,1,3 
	IF Rs.Eof Then
		Echo "1没有此投票"
		Rs.Close
		Set Rs=Nothing
		Exit Sub
	Else
		t0=Trim(Request("t0"))
		IF t0="" then
			Echo "1请选择投票项目":Died
		End IF

		IF Load_Cookies("vote_"&id&"")="" then
			Dim t1,J,I,t2
			t0=Check_Event(t0,",","")
			t0=Split(t0,",")
			t1=Split(Rs(0),"|")
			For J=0 To Ubound(t0)
				For I=0 To Ubound(t1)-1
					IF I=Clng(t0(J)) Then
						t1(I)=t1(I)+1
					End IF
					IF Ubound(t0)-J<1 Then
						t2=t2&t1(I)&"|"
					End IF
				Next
			Next
			Rs(0)=t2
			Rs.update
			Echo "0恭喜您，投票成功！"
			Add_Cookies "vote_"&id&"",id
			Rs.Close
			Set Rs=Nothing
		Else
			Echo "1您已经投过票了"
		End IF 
	End if	
End Sub
Dim ID:ID=IsNum(Trim(Request.QueryString("ID")),0)
Select Case Lcase(Trim(Request.QueryString("Action")))
	Case "save":SaveVote
	Case Else
		Dim Temp
		Set Temp=New Templates
			Temp.Label "{sdcms:vote_id}",ID
			Temp.Label "{sdcms:map_nav}",""
			Temp.Load(Load_temp_dir&sdcms_skins_vote)
			Temp.Gzip
			Echo Temp.Display
		Set Temp=Nothing
End Select
Closedb
%>