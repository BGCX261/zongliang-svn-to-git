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
			Response.write("<script>alert('\u63d0\u4ea4\u592a\u5feb\uff0c\u8bf7\u8fc7\u4f1a\u518d\u8bd5'); window.opener = null; window.close();</script>")
			Response.end
		End IF
	End IF
	t0=FilterHtml(Trim(Request.Form("t0")))
	t1=FilterHtml(Trim(Request.Form("t1")))
	t2=FilterHtml(Trim(Request.Form("t2")))
	t3=FilterHtml(Trim(Request.Form("t3")))
	t4=Check_ispic(t2)
	IF t3<>Session("SDCMSCode") then Echo "<script>alert('\u9a8c\u8bc1\u7801\u9519\u8bef'); window.opener = null; window.close();</script>":Exit Sub
	IF t0="" Or t1="" Then
		Echo "<script>alert('\u6570\u636e\u4e0d\u5b8c\u6574'); window.opener = null; window.close();</script>":Exit Sub
	End IF
	IF  Len(t0)<2 then
	Echo "<script>alert('\u7f51\u7ad9\u540d\u5b57\u592a\u77ed\u4e86\u5427\uff1f'); window.opener = null; window.close();</script>":Exit Sub
	End IF
	IF  Len(t0)>10 then
	Echo "<script>alert('\u7f51\u7ad9\u540d\u5b57\u4e5f\u592a\u957f\u4e86\u5427'); window.opener = null; window.close();</script>":Exit Sub
	End IF
	IF  Len(t1)<7 then
	Echo "<script>alert('\u7f51\u5740\u9519\u8bef'); window.opener = null; window.close();</script>":Died
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
		Echo "<script>alert('\u8bf7\u52ff\u91cd\u590d\u7533\u8bf7'); window.opener = null; window.close();</script>":Died
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
		Response.write("<div style='width:100%;height:100%' align='center'><span style='color:red' id='spobj'></span></div>")
		Response.write("<script>spobj.innerHTML='\u7533\u8bf7\u6210\u529f!\u5ba1\u6838\u901a\u8fc7\u540e\u4f1a\u663e\u793a...'; setTimeout(function(){window.location.href='http://www.ruiec.com/';},3000);</script>")
		Add_Cookies "linkadddate",Now()
	End IF
End Sub
Select Case Lcase(Trim(Request.QueryString("Action")))
	Case "save":Savelink
	Case Else
		Dim Temp, acstr
		Set acstr = Request.QueryString
		Set Temp = New Templates
		Temp.Label "{sdcms:class_id}",0
		If acstr="link" Then
			Temp.Label "{sdcms:class_title}","申请友情链接"
		Else
			Temp.Label "{sdcms:class_title}","友情链接"
		End If
		Temp.Label "{sdcms:class_key}",""
		Temp.Label "{sdcms:class_desc}",""
		Temp.Label "{sdcms:class_allclassid}",0
		Temp.Label "{sdcms:class_classurl}",Sdcms_weburl
		Temp.Label "{sdcms:class_url}",Sdcms_weburl
		Temp.Label "{sdcms:class_followid}",""
		Temp.Label "{sdcms:class_position}",""
		Temp.Label "{sdcms:map_nav}",""
		Temp.Load(Load_temp_dir&sdcms_skins_link)
		Temp.Gzip
		Echo Temp.Display
		Set Temp=Nothing
End Select
%>