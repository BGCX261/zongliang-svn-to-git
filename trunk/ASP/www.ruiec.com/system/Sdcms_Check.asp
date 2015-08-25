<!--#include file="../inc/conn.asp"-->
<%
Dim sdcms_adminid,sdcms_adminname,sdcms_adminpwd,sdcms_isadmin,sdcms_alllever,sdcms_infolever
sdcms_adminid=IsNum(Load_Cookies("sdcms_id"),0)
sdcms_adminname=FilterHtml(Load_Cookies("sdcms_name"))
sdcms_adminpwd=FilterHtml(Load_Cookies("sdcms_pwd"))
sdcms_isadmin=IsNum(Load_Cookies("sdcms_admin"),0)
sdcms_alllever=FilterHtml(Load_Cookies("sdcms_alllever"))
sdcms_infolever=FilterHtml(Load_Cookies("sdcms_infolever"))
Class Sdcms_Admin
	Public Sub Check_admin
		IF Sdcms_adminname="" And Sdcms_adminpwd="" Then
			Go("Index.Asp"):Died
		Else
			Dim Sql,Rs
			DbOpen
			Sql="select sdcms_name,sdcms_pwd from sd_admin where sdcms_name='"&sdcms_adminname&"' And sdcms_pwd='"&sdcms_adminpwd&"'"
			Set Rs=Conn.Execute(Sql)
			IF Rs.Eof Then
				Go("Index.Asp?Action=Out"):Died
			End IF
			Rs.Close
			Set Rs=Nothing
		End IF
	End Sub
	
	Public Sub Check_lever(t0)
		Dim t1
		IF Load_Cookies("sdcms_admin")=0 Then
			t1=sdcms_alllever
			IF t0<>"" Then
				IF Instr(", "&t1&", ",", "&t0&", ")=0 Then Echo "您的权限不足以进行此次操作!":Died
			End IF
		End IF
	End Sub
	
	Function Check_Info_Lever
		Dim alllever,alllevers,get_classid,I,all_levers
		get_classid=""
		alllever=sdcms_infolever
		'先将栏目的id读出来，并且将相关栏目的classid也写出来
		IF Instr(alllever,",")>0 Then
			alllevers=Split(alllever,", ")
			For i=0 To ubound(alllevers)
				all_levers=Split(alllevers(i),"|")
				Set Rs=Conn.Execute("select allclassid from sd_class where id="&all_levers(0)&"")
				IF Not Rs.Eof Then
					get_classid=get_classid&Rs(0)&","
				End IF
				Rs.Close
				Set Rs=Nothing
			Next
			IF Right(get_classid,1)="," Then
				get_classid=Left(get_classid,Len(get_classid)-1)
			End IF
			check_info_lever=get_classid
		Else
			IF Len(alllever)>0 Then
				Set Rs=Conn.Execute("select allclassid from sd_class where id="&alllever&"")
				IF Not Rs.eof Then
					check_info_lever=Rs(0)
				Else
					check_info_lever="0"
				End IF
				Rs.Close
				Set Rs=Nothing
			Else
				check_info_lever="0"
			End IF
		End IF
		IF check_info_lever<>"0" Then
		check_info_lever="classid in ("&check_info_lever&") "
		End IF
	End Function
End Class

Sub Progress(num,t0)
	Echo "<script>$(""#progress"&t0&""")[0].style.width ="""&num&"%"";$(""#progress"&t0&""").html("""&num&"%"");</script>" & VbCrLf
End Sub

Sub admin_upfile(t0,t1,t2,t3,t4,t5,t6)
Echo "<iframe id="""&t4&""" src=""sdcms_up.asp?t0="&t0&"&t1="&t3&"&t2="&t4&"&t3="&t5&"&t4="&t6&""" scrolling=""no"" frameborder=""0"" width="""&t1&""" height="""&t2&"""  ></iframe>"
End sub

Sub AddLog(t0,t1,t2,t3)
	DbOpen
	IF t3=1 Then
		Conn.Execute("Insert into Sd_Log (sdcms_name,ip,content,adddate) values('"&t0&"','"&t1&"','"&t2&"','"&Dateadd("h",Sdcms_TimeZone,Now())&"')")
	Else
		IF Sdcms_AdminLog Then
			Conn.Execute("Insert into Sd_Log (sdcms_name,ip,content,adddate) values('"&t0&"','"&t1&"','"&t2&"','"&Dateadd("h",Sdcms_TimeZone,Now())&"')")
		End IF
	End IF
End Sub

Sub Db_Run
	Echo "<div class=""runtime""><br>Processed In "&Runtime&" Seconds, "&DbQuery&" Queries　</div>"
End Sub

Sub Sdcms_Head
	With Response
		.Write"<!DOCTYPE html PUBLIC ""-//W3C//DTD XHTML 1.0 Transitional//EN"" ""http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"">"&vbcrlf
		.Write"<html xmlns=""http://www.w3.org/1999/xhtml"">"&vbcrlf
		.Write"<head>"&vbcrlf
		.Write"<meta http-equiv=""Content-Type"" content=""text/html; charset=gb2312"" />"&vbcrlf
		.Write"<meta http-equiv=""X-UA-Compatible"" content=""IE=EmulateIE7"" />"&vbcrlf
		.Write"<title>网站信息管理系统</title>"&vbcrlf
		.Write"<link href=""css/sdcms.css"" rel=""stylesheet"" type=""text/css"" />"&vbcrlf
		.Write"<script language=""javascript"" src=""js/sdcms.js""></script>"&vbcrlf
		.Write"<script type=""text/javascript"" src=""../editor/jquery.js""></script>"&vbcrlf
		.Write"<script type=""text/javascript"" src=""../editor/kindeditor.js"" charset=""utf-8"" ></script>"&vbcrlf
		.Write"<script type=""text/javascript"" src=""js/color.js""></script>"&vbcrlf
		IF Instr(Request.ServerVariables("SCRIPT_NAME"),"sdcms_main")<>0 then
		.Write"<script language=""javascript"">$(document).ready(function (){Get_Notice(0,""sdcms_notice"");Get_Notice(1,""sdcms_nice"");});</script>"&vbcrlf
		End IF
		.Write"</head>"&vbcrlf
		.Write"<body>"&vbcrlf
	End With
End Sub
%>