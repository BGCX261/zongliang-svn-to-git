<!--#include file="../inc/conn.asp"-->
<%
	Dim Temp,Show,KeyWord,Key,Page
    KeyWord=Trim(Request.QueryString())
	KeyWord=Split(Keyword,"/")
	IF Ubound(KeyWord)<=1 Then
		Key=""
	Else
		Key=FilterHtml(URLDecode(Re(KeyWord(1),"？","")))
		Page=IsNum(KeyWord(2),1)
	End IF
	IF Len(key)<2 Then ErrMsg:Died
	Set Temp=New Templates
	DbOpen
    Temp.Label "{sdcms:keyword}",Key

	Show=Temp.Sdcms_Load(Load_temp_dir&sdcms_skins_search)
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
		Echo "请正确使用搜索模板":Died
	End IF
		
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
		.PageStart="?/"&Server.URLEncode(key)&"/"
	End With
	Set Rs=P.Show
	
	IF Err Then
		Show=Replace(Show,PageHtml,PageEof)
		Temp.Label "{sdcms:listpage}",""
		Err.Clear
	Else
		IF Page=1 Then Add_key(key)
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
	Set P=Nothing
	Set Temp=Nothing

	Sub Add_key(t0)
		IF Conn.execute("Select Count(id) From Sd_Search Where title='"&t0&"'")(0)=0 Then
		   Conn.execute("Insert Into Sd_Search (title,ispass,adddate) values('"&t0&"',1,'"&Dateadd("h",Sdcms_TimeZone,Now())&"')")
		Else
		   Conn.execute("Update Sd_Search Set hits=hits+1 Where title='"&t0&"'")
		End If
	End Sub
	
	Sub ErrMsg
		Echo "<script src="""&Sdcms_Root&"editor/xheditor/jquery.js"" language=""javascript""></script>"
		Echo "关键字不能为空，且不能小于2个字符<br><br><span id=""outtime"" style='color:#f00;'>5</span> 秒后<a href="""&Sdcms_Root&""">返回首页</a>"
		Echo "<script language=JavaScript>"
		Echo "var secs=5;var wait=secs * 1000;"
		Echo "for(i=1; i<=secs;i++){window.setTimeout(""Update("" + i + "")"", i * 1000);}"
		Echo "function Update(num){if(num != secs){printnr = (wait / 1000) - num;"
		Echo "$(""#outtime"").html(""<span style='color:#f00;'>""+printnr+""</span>"");}}"
		Echo "setTimeout(""window.location='"&Sdcms_Root&"'"","&Int(5*1000)&");</script>"
	End Sub
%>