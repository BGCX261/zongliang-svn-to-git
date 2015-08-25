<!--#include file="Inc/Conn.asp"-->
<%
	if not(blogmode) then
		Server.Transfer "Index.asp"
		died
	end if
	Dim Temp,Show,c,d
	c=request.QueryString("c")
	if isdate(c)=0 then
		go sdcms_root:died
	else
		d=cdate(c)
		dim y,m
		y=year(d)
		m=month(d)
		dim where
		where="year(adddate)='"&y&"' and month(adddate)='"&m&"'"
	end if
	
		Set Temp=New Templates
		DbOpen
		Temp.Label "{sdcms:like}",where
		Show=Temp.Sdcms_Load(Load_temp_dir&sdcms_skins_blogdate)
		Temp.TemplateContent=Show
		Temp.Analysis_Static()
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
					.PageStart="date-"&c&"_"
					.PageEnd=""
				Case Else
					.PageStart="?c="&c&"&Page="
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