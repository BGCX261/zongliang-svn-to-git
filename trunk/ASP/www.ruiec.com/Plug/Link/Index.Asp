<!--#include file="../../inc/conn.asp"-->
<%
'============================================================
'插件名称：友情链接
'Website：http://www.sdcms.cn
'Author：IT平民
'Date：2009-6-5
'============================================================
Sub Savelink
	DbOpen
	Dim lastpostdate,t0,t1,t2,t3,t4,rs,t5,sql
	lastpostdate=Load_Cookies("linkadddate")
	lastpostdate=Replace(lastpostdate,"&#32;","　")
	IF lastpostdate<>"" then
		IF Int(DateDiff("s",lastpostdate,Now()))<=60 Then
			Echo "0提交太快，请过会再试":Died
		End IF
	End IF
	t0=FilterHtml(Trim(Request.Form("t0")))
	t1=FilterHtml(Trim(Request.Form("t1")))
	t2=FilterHtml(Trim(Request.Form("t2")))
	t3=FilterHtml(Trim(Request.Form("t3")))
	t4=Check_ispic(t2)
	IF t3<>Session("SDCMSCode") then Echo "0验证码错误":Exit Sub
	IF t0="" Or t1="" Then
		Echo "0数据不完整":Exit Sub
	End IF
	IF  Len(t0)<2 then
	Echo "0网站名字太短了吧？":Exit Sub
	End IF
	IF  Len(t0)>10 then
	Echo "0网站名字也太长了吧":Exit Sub
	End IF
	IF  Len(t1)<7 then
	Echo "0网址错误":Died
	End IF

	Set Rs=Conn.Execute("Select Max(ordnum) From Sd_Link Where Ispic="&t4&"")
	IF Rs.Eof Then
		t5=1
	Else
		IF Rs(0)<>"" Then t5=Cint(Rs(0))+1 Else t5=1 End IF
	End If
	Rs.Close
	Set Rs=Nothing
	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql="Select title,url,pic,ispic,ordnum From Sd_link Where title Like '%"&t0&"%' Or url Like '%"&t1&"%'"
	Rs.Open Sql,Conn,1,3
	IF Not Rs.Eof Then
		Echo "0请勿重复申请":Died
	Else
		Rs.AddNew
		Rs(0)=t0
		Rs(1)=t1
		Rs(2)=t2
		Rs(3)=t4
		Rs(4)=t5
		Rs.Update
		Rs.Close
		Set Rs=Nothing
		Echo "1申请成功，审核后显示"
		Add_Cookies "linkadddate",Now()
	End IF
End Sub
Select Case Lcase(Trim(Request.QueryString("Action")))
	Case "save":Savelink
	Case Else
		Dim Temp
		Set Temp=New Templates
			Temp.Load(Load_temp_dir&sdcms_skins_link)
			Temp.Gzip
			Echo Temp.Display
		Set Temp=Nothing
End Select
%>