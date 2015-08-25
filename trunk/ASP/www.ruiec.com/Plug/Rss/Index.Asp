<!--#include file="../../Inc/Conn.asp"-->
<%
'============================================================
'插件名称：RSS
'Website：http://www.sdcms.cn
'Author：IT平民
'Date：2008-2-25
'LastUpDate：2011-10
'============================================================
Response.Clear
Response.ContentType="text/xml"
Dim ID:ID=IsNum(Trim(Request.QueryString("ID")),0)
Dim Rs_Class
DbOpen
Set Rs_Class=Conn.Execute("Select Allclassid From Sd_class Where ID="&ID&"")
IF Rs_Class.Eof Then
	Echo Get_allrss
Else
	Echo Get_rss(ID,Rs_Class(0))
End IF
Rs_Class.Close:Set Rs_Class=Nothing

Function Get_Rss(t0,t1)
	Dim t2,Rs,t3
	t2=""
	t2=t2&"<?xml version=""1.0"" encoding=""gb2312""?>"& vbcrlf
	t2=t2&"<rss version=""2.0"">"& vbcrlf
	t2=t2&"<channel>"& vbcrlf
	Set rs=Conn.Execute("Select title,ClassUrl,Class_Desc,ID From Sd_Class Where Id="&Id&"")
	IF Not Rs.Eof Then
	t2=t2&"<title>"&Rs(0)&"</title>"& vbcrlf
	Select Case Sdcms_Mode
		Case "0"
		t2=t2&"<link>"&sdcms_weburl&sdcms_root&"Info/?ID="&Rs(3)&"</link>"& vbcrlf
		Case "1"
		t2=t2&"<link>"&sdcms_weburl&sdcms_root&"html/"&Rs(1)&"</link>"& vbcrlf
		Case "2"
		t2=t2&"<link>"&sdcms_weburl&sdcms_root&Sdcms_Htmdir&Rs(1)&"</link>"& vbcrlf
	End Select
	
	t2=t2&"<description><![CDATA["&Rs(2)&"]]></description>"& vbcrlf
	t2=t2&"<language>zh-cn</language>"& vbcrlf
	t2=t2&"<generator>Rss Generator By "&Sdcms_new_version&"</generator>"& vbcrlf
	End IF
	Set Rs=Conn.Execute("Select Top 100 title,classid,jj,lastupdate,author,htmlname,classurl,id From View_info Where Classid In("&t1&") and ispass=1 Order by lastupdate desc")
	
	While Not rs.Eof
	Select Case Sdcms_Mode
		Case "0":t3=Sdcms_WebUrl&Sdcms_Root&"Info/View.Asp?ID="&Rs(7)
		Case "1":t3=Sdcms_WebUrl&Sdcms_Root&"html/"&Rs(6)&Rs(7)&sdcms_filetxt
		Case "2":t3=sdcms_weburl&sdcms_root&Sdcms_HtmDir&Rs(6)&Rs(5)&sdcms_filetxt
	End Select
	t2=t2&"<item>"& vbcrlf
	t2=t2&"    <title>"&rs(0)&"</title>"& vbcrlf
	t2=t2&"    <link>"&t3&"</link>"& vbcrlf
	t2=t2&"    <description><![CDATA["&rs(2)&"]]></description>"& vbcrlf
	t2=t2&"    <pubDate><![CDATA["&Dateadd("h",Sdcms_TimeZone,Now())&"]]></pubDate>"& vbcrlf
	t2=t2&"    <category><![CDATA["&loadrecord("title","sd_class",rs(1))&"]]></category>"& vbcrlf
	t2=t2&"    <author><![CDATA["&rs(4)&"]]></author>"& vbcrlf
	t2=t2&"</item>"& vbcrlf
	Rs.Movenext
	Wend
	Rs.Close
	Set Rs=Nothing
	t2=t2&"</channel>"& vbcrlf
	t2=t2&"</rss>"& vbcrlf
	Get_rss=t2
End Function

Function Get_allrss
	Dim t1,rs
	t1=""
	t1=t1&"<?xml version=""1.0"" encoding=""gb2312""?>"& vbcrlf
	t1=t1&"<rss version=""2.0"">"& vbcrlf
	t1=t1&"<channel>"& vbcrlf

	t1=t1&"<title>"&sdcms_webname&" Rss Generator By "&Sdcms_new_version&"</title>"& vbcrlf
	t1=t1&"<link>"&sdcms_weburl&sdcms_root&"</link>"& vbcrlf
	t1=t1&"<description><![CDATA["&loadrecord("webdec","sd_const",1)&"]]></description>"& vbcrlf
	t1=t1&"<language>zh-cn</language>"& vbcrlf
	t1=t1&"<generator>Rss Generator By SDCMS.CN</generator>"& vbcrlf
	Set Rs=Conn.Execute("Select title,ClassUrl,Class_desc,ID From Sd_Class Order By Id desc")
	While Not Rs.Eof
	t1=t1&"<item>"& vbcrlf
	t1=t1&"    <title><![CDATA["&Rs(0)&"]]></title>"& vbcrlf
	t1=t1&"    <link>"&Sdcms_Root&"plug/rss/?id="&Rs(3)&"</link>"& vbcrlf
	t1=t1&"    <description><![CDATA["&Rs(2)&"]]></description>"& vbcrlf
	t1=t1&"</item>"& vbcrlf
	Rs.Movenext
	Wend
	Rs.Close
	Set Rs=Nothing
	t1=t1&"</channel>"& vbcrlf
	t1=t1&"</rss>"& vbcrlf
	Get_allrss=t1
End Function
%>