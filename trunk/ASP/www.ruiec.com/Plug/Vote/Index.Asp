<!--#include file="../../Inc/Conn.asp"-->
<%
'============================================================
'������ƣ�ͶƱ
'Website��http://www.sdcms.cn
'Author��ITƽ��
'Date��2008-8-25
'Update:2009-10-5
'============================================================
Sub SaveVote
	Dim Rs,Sql,t0
	DbOpen
	Set Rs=server.CreateObject("adodb.recordset")
	Sql="Select result From Sd_Vote Where Id="&id&""
	Rs.Open Sql,Conn,1,3 
	IF Rs.Eof Then
		Echo "1û�д�ͶƱ"
		Rs.Close
		Set Rs=Nothing
		Exit Sub
	Else
		t0=Trim(Request("t0"))
		IF t0="" then
			Echo "1��ѡ��ͶƱ��Ŀ":Died
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
			Echo "0��ϲ����ͶƱ�ɹ���"
			Add_Cookies "vote_"&id&"",id
			Rs.Close
			Set Rs=Nothing
		Else
			Echo "1���Ѿ�Ͷ��Ʊ��"
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
			Temp.Load(Load_temp_dir&sdcms_skins_vote)
			Temp.Gzip
			Echo Temp.Display
		Set Temp=Nothing
End Select
Closedb
%>