<!--#include file="../../Inc/Conn.asp"-->
<%
'============================================================
'插件名称：Ajax留言本
'Website：http://www.sdcms.cn
'Author：IT平民
'Date：2008-11-6
'Update:2010-10
'============================================================
Dim book_pass
Dim Action:Action=Lcase(Trim(Request.QueryString("Action")))
book_pass=0 '是否需要审：0为审核，1为直接通过
DbOpen
Select Case Action
	Case "save":SaveDb
	Case Else:Show_msg
End select

Sub SaveDb
	IF Check_post Then
		Echo "1禁止从外部提交数据!":Exit Sub
	End IF
	Dim lastpostdate,username,content,content1,yzm
	lastpostdate=Load_Cookies("book")
	lastpostdate=Re(lastpostdate,"&#32;","　")
	IF lastpostdate<>"" then
		IF Int(DateDiff("s",lastpostdate,now()))<=60 then
			Echo "1您发表的速度太快!":Died
		End IF
	End IF
	username=Trim(Request.Form("username"))
	content=Request.Form("content")
	content1=Removehtml(Request.Form("content"))
	yzm=Trim(Request.Form("yzm"))
	IF yzm<>Session("SDCMSCode") Then echo "1验证码错误":Exit Sub
	IF username="" Or content="" Then Echo "1请填写好各项的表单":Exit Sub'数据为空
	IF Len(username)<2 Then Echo "1名字太短了吧？":Exit Sub'名字太短
	IF Len(username)>10 Then Echo "1名字也太长了吧":Exit Sub'名字太长
	IF Len(content1)=0 Then Echo "1内容必须有文字!":Exit Sub'内容太少
	IF Len(content)<5 Then Echo "1就写这么点内容？":Exit Sub'内容太少
	IF Len(content)>300 Then Echo "1大哥内容多了我存不下啊！":Exit Sub'内容太长
	username=FilterText(username,1)
	content=FilterHtml(content)
	Dim Rs,Sql
	Set Rs=Server.CreateObject("adodb.recordset")
	Sql="Select username,content,ispass,ip,adddate From sd_book "
	Rs.Open Sql,Conn,1,3
	rs.Addnew
	rs(0)=Left(username,10)
	rs(1)=content
	rs(2)=book_pass
	rs(3)=GetIp
	Rs(4)=Dateadd("h",Sdcms_TimeZone,Now())
	rs.Update
	rs.Close
	Set Rs=Nothing
	IF book_pass=1 then
		Echo "0发布成功"'发布成功
	Else
		Echo "0发布成功，审核后显示"'发布成功
	End IF
	Add_Cookies "book",Now()
End Sub

Sub Show_msg
	Sdcms_Cache=False'强制关闭缓存
	Dim Temp,show
	Set Temp=New Templates
	Show=Temp.Sdcms_Load(Load_temp_dir&sdcms_skins_book)
	Temp.TemplateContent=Show

	Show=Temp.Display
	Temp.Page_Mark(Show)
	
	Dim PageField,PageTable,PageWhere,PageOrder,PagePageSize,PageEof,PageLoop,PageHtml
	PageHtml=Temp.Page_Html
	PageField=Temp.Page_Field
	PageTable=Temp.Page_Table
	PageWhere=Temp.Page_Where
	PageOrder=Temp.Page_Order
	PagePageSize=Temp.Page_PageSize
	PageEof=Temp.Page_Eof
	PageLoop=Temp.Page_Loop
	IF Len(PagePageSize)=0 Then
		Echo "请正确使用留言模板":Died
	End IF
	
	Dim Page:Page=IsNum(Trim(Request.QueryString("Page")),1)
	Dim P,I
	Set P=New Sdcms_Page
	With P
		.Conn=Conn
		.Pagesize=PagePageSize
		.PageNum=Page
		.Table=PageTable
		.Field=PageField
		.Where=PageWhere
		.Key="ID"
		.Order=PageOrder
		.PageStart="?Page="
	End With
	Set Rs=P.Show

	IF Err Then
		Show=Replace(Show,PageHtml,PageEof)
		Temp.Label "{sdcms:listpage}",""
		Err.Clear
	Else
		Dim Get_Loop,t1
		Get_Loop=""
		t1=""
		For I=1 To P.PageSize
			IF Rs.Eof Or Rs.Bof Then Exit For
				t1=PageLoop
				t1=t1&Temp.Get_Page(t1,PageTable,I)
				Get_Loop=Get_Loop&t1
			Rs.MoveNext
		Next
		Get_Loop=Replace(Get_Loop,PageLoop,"")
		Show=Replace(Show,PageHtml,Get_Loop)
		Temp.Label "{sdcms:listpage}",P.PageList
	End IF
	Temp.TemplateContent=Show
	Temp.Analysis_Static()
	Temp.Analysis_Loop()
	Temp.Analysis_IIF()
	Show=Temp.Gzip
	Echo Temp.Display
	Set Temp=Nothing
End Sub
%>