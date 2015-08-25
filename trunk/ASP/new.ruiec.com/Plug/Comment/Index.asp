<!--#include file="../../inc/conn.asp"-->
<%
'============================================================
'插件名称：Ajax评论
'Website：http://www.sdcms.cn
'Author：IT平民
'Date：2009-12-9
'============================================================
	DbOpen
	IF Clng(sdcms_comment_pass)=0 Then
		Echo "系统未开启评论系统":Died
	End IF
	
	Select Case Trim(Request.QueryString("Action"))
		Case "save":Check_Id:save_comment
		Case "support":Support
		Case Else:Check_Id:show_comment
	End Select
	
Sub Check_Id
	Dim ID:ID=IsNum(Trim(Request("ID")),0)
	Set Rs=Conn.Execute("Select id,iscomment from sd_info where id="&id&"")
	IF Rs.Eof Then
		Echo "错误的参数":Died
	End IF
	Dim This_Comment
	IF Sdcms_Cache Then
		IF Check_Cache("comment_"&id) Then
			Create_Cache "comment_"&id,rs(1)
		End IF
		This_Comment=Load_Cache("comment_"&id)
	Else
		This_Comment=rs(1)
	End IF
	Rs.Close:Set Rs=Nothing
	IF This_Comment=0 Then Echo "此信息禁止评论":Died
End Sub

Sub Save_Comment
	Dim ID:ID=IsNum(Trim(Request.Form("ID")),0)
	Dim lastpostdate,username,content,content1,yzm,msg_contents,rs,sql,t1,followid,allfollowid
	lastpostdate=Load_Cookies("comment_"&ID)
	lastpostdate=Re(lastpostdate,"&#32;","　")
	IF lastpostdate<>"" Then
		IF DateDiff("s",lastpostdate,Now())<=60 Then
			Echo "1您发表的速度太快，歇歇再发吧":Exit Sub
		End IF
	End IF
	username=Trim(Request.Form("username"))
	content=Trim(Request.Form("content"))
	content1=Removehtml(Request.Form("content"))
	yzm=Trim(Request.Form("yzm"))
	Followid=IsNum(Trim(Request.Form("Followid")),0)
	IF yzm<>Session("SDCMSCode") Then Echo "1验证码错误":Exit Sub
	IF username="" or content="" Then Echo "1数据不能为空":Exit Sub
	IF len(username)<2 Then Echo "1名字太短了吧？":Exit Sub
	IF len(username)>10 Then Echo "1名字也太长了吧":Exit Sub
	IF len(content1)=0 Then Echo "1一点汉字都不写？":Exit Sub
	IF len(content1)<5 Then Echo "1就写这么点内容？":Exit Sub
	IF len(content1)>300 Then Echo "1大哥内容多了我存不下啊！":Exit Sub
	IF t1<>0 And Isnumeric(t1) Then content=Left(content,Clng(t1))
	IF Followid>0 Then
		Set Rs=Conn.Execute("Select allfollowid From Sd_Comment Where Id="&Followid&"")
		IF Rs.Eof Then
			Echo "1参数错误！":Died
		Else
			IF Rs(0)<>0 Then
			Dim totallever
				totallever=Ubound(Split(Rs(0),","))
				IF totallever>=10 Then
					Echo "1系统最多允许盖10层楼":Exit Sub
				End IF
				allfollowid=Rs(0)&","&Followid
			Else
				allfollowid=Followid
			End IF
		End IF
	Else
		allfollowid=0
	End IF
	username=FilterText(username,1)
	content=FilterHtml(content)

	Set Rs=Server.CreateObject("adodb.recordset")
	Sql="Select username,content,ip,infoid,ispass,adddate,followid,allfollowid from sd_comment"
	Rs.open sql,conn,1,3
	Rs.addnew
	Rs(0)=left(username,10)
	Rs(1)=content
	Rs(2)=GetIp
	Rs(3)=Id
	IF sdcms_comment_ispass=1 Then
		msg_contents="，请等待审核"
		rs(4)=0
	Else
		rs(4)=1
	End IF
	Rs(5)=Dateadd("h",Sdcms_TimeZone,Now())
	Rs(6)=followid
	Rs(7)=allfollowid
	rs.update
	Conn.Execute("update sd_info set comment_num=comment_num+1 where id="&id&"")
	IF sdcms_comment_ispass=1 Then
		Echo "0评论发表成功"&msg_contents&"!"
	Else
		Echo "0评论发表成功"
	End IF
	Add_Cookies "comment_"&ID,Now()
End Sub

Sub Show_Comment
	Sdcms_Cache=False'强制关闭缓存
	Dim ID:ID=IsNum(Trim(Request.QueryString("ID")),0)
	Dim Temp,Show,Rs1,page,partentids,map_nav,I,rs_P,ClassRoot
	Set Temp=New Templates
	Set Rs1=Conn.Execute("Select Top 1 Title,ClassUrl,HtmlName,Partentid From View_Info Where ID="&ID&"")
	IF Not Rs1.Eof Then
		Temp.Label "{sdcms:info_title}",Rs1(0)
		Temp.Label "{sdcms:class_title}","评论: "&Rs1(0)
		Temp.Label "{sdcms:class_title_site}","评论: "&Rs1(0)
		partentids = Rs1(3)
	End If
	If request("Page")<>"" Then Page=request("Page") Else Page=1 End If
	
	partentids=Split(partentids,",")
	For I=ubound(partentids) To 0 Step -1
		Set Rs_P=Conn.Execute("Select ClassUrl,title,ID From Sd_class Where Id="&partentids(I)&"")
		IF Not Rs_P.Eof Then
			Select Case Sdcms_Mode
				Case "0"
					ClassRoot=Sdcms_Root&"Info/?Id="&Rs_P(2)
				Case "1"
					ClassRoot=Sdcms_Root&"html/"&Rs_P(0)
				Case "2"
					ClassRoot=Sdcms_Root&Sdcms_HtmDir&Rs_P(0)
			End Select
			map_nav=map_nav&" > <a href="&ClassRoot&">"&Rs_P(1)&"</a>"
			Rs_P.Close:Set Rs_P=Nothing
		End IF
	Next

	Dim info_url
	Select Case Sdcms_Mode
	Case "0":info_url=sdcms_root&"info/view.asp?id="&id
	case "1":info_url=sdcms_root&"html/"&rs1(1)&rs1(2)&Sdcms_FileTxt
	case else
	info_url=sdcms_root&Sdcms_HtmDir&rs1(1)&rs1(2)&Sdcms_FileTxt
	end select
	Temp.Label "{sdcms:info_id}",ID
	Temp.Label "{sdcms:info_url}",info_url
	Temp.Label "{sdcms:map_nav}",map_nav
	Temp.Label "{sdcms:class_id}",0
	Temp.Label "{sdcms:so_pate}",page

	Show=Temp.Sdcms_Load(Sdcms_Root&"skins/"&Sdcms_Skins_Root&"/"&sdcms_skins_comment)
		
	Temp.TemplateContent=Show
	Temp.Analysis_Static()
	Show=Temp.Display
	Temp.Page_Mark(Show)
		
	Temp.TemplateContent=Show
	Temp.Analysis_Static()
	Temp.Analysis_Loop()
	Temp.Analysis_IIF()
	Show=Temp.Gzip
	Show=Temp.Display

	Echo Show
	Set Temp=Nothing	
End Sub

Sub Support
	Dim ID:ID=IsNum(Trim(Request.QueryString("ID")),0)
	Set Rs=Conn.Execute("Select SupportNum From Sd_Comment Where Id="&ID&"")
	IF Not Rs.Eof Then
		IF Len(Session("Support"))=0 Then
			Session("Support")=1
		Else
			Session("Support")=Session("Support")+1
		End IF
		IF Session("Support")>5 Then
			Echo "1"&Rs(0)
		Else
			Conn.Execute("Update Sd_Comment Set SupportNum=SupportNum+1 Where Id="&ID&"")
			Echo "0"&Rs(0)
		End IF
	Else
		Echo "00"
	End IF
	Rs.Close
	Set Rs=Nothing
End Sub
%>