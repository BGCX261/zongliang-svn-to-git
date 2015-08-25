<!--#include file="conn.asp"-->
<%
DbOpen
Dim ID:ID=IsNum(Trim(Request.QueryString("ID")),0)
IF ID=0 Then Echo ID:Died
Dim t:t=IsNum(Trim(Request.QueryString("t")),0)
Dim Action:Action=Lcase(Trim(Request.QueryString("Action")))
Select Case Action
	Case "1":info_hits
	Case "2":comment_num
	Case Else:Echo "0"
End Select
CloseDb
Sub info_hits
	Dim Rs
	Set Rs=Conn.Execute("select hits,dayhits,weekhits,monthhits,lasthitsdate from sd_info where id="&id&"")
	IF Rs.Eof Then
		Echo "0"
	Else
		Conn.Execute("update sd_info set hits=hits+1 where id="&id&"")
		IF DateDiff("D",rs(4),Now())<=0 Then
			Conn.Execute("update sd_info set dayhits=dayhits+1 where id="&id&"")
		Else
			Conn.Execute("update sd_info set dayhits=1 where id="&id&"")  
		End IF
		
		IF DateDiff("ww",rs(4),Now())<=0 Then
			Conn.Execute("update sd_info set weekhits=weekhits+1 where id="&id&"")
		Else
			Conn.Execute("update sd_info set weekhits=1 where id="&id&"")
		End IF
		
		IF DateDiff("m",rs(4),Now())<=0 Then
			Conn.Execute("update sd_info set monthhits=monthhits+1 where id="&id&"")
		Else
			Conn.Execute("update sd_info set monthhits=1 where id="&id&"")
		End IF
		Conn.Execute("update sd_info set lasthitsdate="&SqlNowString&" where id="&id&"")
		Select Case t
			Case "1":Echo rs(1)
			Case "2":Echo rs(2)
			Case "3":Echo rs(3)
			Case Else:Echo rs(0)
		End Select
		Rs.Close:Set Rs=Nothing
	End IF
End Sub

Sub comment_num
	Dim Rs
	Set Rs=Conn.Execute("select comment_num,id from sd_info where id="&id&"")
	IF Rs.Eof Then
		Echo "0"
	Else
		Echo "<a>"&Rs(0)&"</a>"
	End IF
	Rs.Close
	Set Rs=Nothing
End Sub
%>