<!--#include file="../Inc/Conn.asp"-->
<%
'============================================================
'插件名称：Tags
'Website：http://www.sdcms.cn
'Author：IT平民
'Date：2010-10
'============================================================
	Dim Temp,Show,Rs_t,ID
	ID=IsNum(Trim(Request.QueryString("ID")),0)
	Set Temp=New Templates
	DbOpen
	Set Rs_t=Conn.Execute("Select ID,Title,keyword,Description,Pic,Content,AddDate,Temp_Dir from Sd_Topic where id="&ID&"")
	IF Rs_t.Eof Then
		Echo "参数错误"
		Rs_t.Close:Set Rs_t=Nothing
		Died
	End IF
	Dim Topic_t0,Topic_t1,Topic_t2,Topic_t3,Topic_t4,Topic_t5,Topic_t6,Topic_t7
	Topic_t0=Rs_t(0)
	Topic_t1=Rs_t(1)
	Topic_t2=Rs_t(2)
	Topic_t3=Rs_t(3)
	Topic_t4=Rs_t(4)
	Topic_t5=Rs_t(5)
	Topic_t6=Rs_t(6)
	Topic_t7=Rs_t(7)
	Rs_t.Close:Set Rs_t=Nothing

	Temp.Label "{sdcms:topic_id}",Topic_t0
	Temp.Label "{sdcms:topic_title}",Topic_t1
	Temp.Label "{sdcms:topic_key}",Topic_t2
	Temp.Label "{sdcms:topic_dec}",Topic_t3
	Temp.Label "{sdcms:topic_pic}",Topic_t4
	Temp.Label "{sdcms:topic_content}",Topic_t5
	Temp.Label "{sdcms:topic_adddate}",Topic_t6

	
	IF Len(Topic_t7)=0 Then
		Show=Temp.Sdcms_Load(Load_temp_dir&sdcms_skins_info_Topic)
	Else
		Show=Temp.Sdcms_Load(Sdcms_Root&Topic_t7)
	End IF
	
	Temp.TemplateContent=Show
	Temp.Analysis_Static
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
		Echo "请正确使用专题模板":Died
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
		Select Case Sdcms_Mode
			Case "1"
				.PageStart="List_"&ID&"_"
				.PageEnd=Sdcms_Filetxt
			Case Else
				.PageStart="?ID="&ID&"&Page="
		End Select
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
	Show=Temp.Display
	Echo Show
	Set Temp=Nothing
%>