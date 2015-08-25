<!--#include file="../inc/conn.asp"-->
<%
Response.Expires = -1
Response.ExpiresAbsolute = Now() - 1
Response.cachecontrol = "no-cache"
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>SDCMS数据库升级程序</title>
<link href="images/sdcms.css" rel="stylesheet" type="text/css" />
</head>

<body>
<div class="width">
	<div class="left">
	<div id="update_img"><img src="images/update.gif" alt="SDCMS网站信息管理系统"/>
	  <div>
	<span class="title">官方网站</span>：<a href="Http://www.sdcms.cn" target="_blank">Http://www.sdcms.cn</a><br><span class="title">官方论坛</span>：<a href="Http://bbs.sdcms.cn" target="_blank">Http://bbs.sdcms.cn</a></div>
	</div>
    </div>
	
	<div class="left">
		<h1>SDCMS数据库升级程序</h1>
		<dl>
			<dt class="update_content"><strong>升级说明：</strong>
				<ul>
					<li class="action">仅适用于SDCMS1.2Sp1 To SDCMS1.3Beta；</li>
					<li>升级前请先备份好原网站所有数据，以免出现问题；</li>
					<li>升级过程中请勿关闭本页面，以免产生意外问题；</li>
					<li class="action">升级后请删除本升级程序，并按升级说明继续操作。</li>
				</ul>
			</dt>
			<dt><input class="bnt" id="load_bnt" type="button" value="开始升级" onClick="if(confirm('准备好升级了吗?'))location.href='?action=update';return false;" /><div id="load_update"><div id="load_updates"></div></div></dt>	
		</dl>
	</div>
	
</div>
<%
Select Case action
	Case "update":update_sdcms
End Select

Sub Progress(t0)
	Echo "<script>document.getElementById(""load_update"").style.display='block';document.getElementById(""load_updates"").style.width="""&t0&"%"";document.getElementById(""load_updates"").innerHTML="""&t0&"%"";</script>"
	Response.Flush()
End Sub

Sub update_sdcms
'=========================================
'说明：SDCMS升级文件
'作用：1.2sp1 To 1.3beta
'Author：IT平民
'Date：2010-11-28
'=========================================
	Echo "<script>document.getElementById(""load_bnt"").disabled=true;</script>"
	On Error ReSume Next
	IF Sdcms_DataType Then SqlNowString="Now()" Else SqlNowString="Getdate()"
	Set Conn=Server.CreateObject("ADODB.Connection")
	Conn.open ConnStr

	Sql="CREATE TABLE [Sd_OutSite] ("
	Sql=Sql&"	[ID] int IDENTITY (1, 1) PRIMARY KEY NOT NULL ,"
	Sql=Sql&"	[Title] nvarchar (50) NULL ,"
	Sql=Sql&"	[CacheTime] int NULL default 0,"
	Sql=Sql&"	[Loop_Content]  ntext NULL ,"
	Sql=Sql&"	[ispass] int NULL default 0,"
	Sql=Sql&"	[AddDate] smalldatetime NULL default "&SqlNowString
	Sql=Sql&")"
	Conn.Execute(Sql)
	Progress 5

	Sql="Alter Table [Sd_Class] Drop class_num,filename"
	Conn.Execute(Sql)
	Progress 10
	
	IF Sdcms_DataType Then
		Set Cat=Server.CreateObject("ADOX.Catalog")
			Cat.ActiveConnection=Connstr
			Cat.Tables("Sd_Class").Columns("classdir")="ClassUrl"
		Set Cat=Nothing
	Else
		Sql="EXEC sp_rename 'Sd_Class.classdir','ClassUrl','COLUMN'"
		Conn.Execute(Sql)
	End IF
	Progress 15
	
	Sql="Alter Table [Sd_Class] add Depth int Default 0"
	Conn.Execute(Sql)
	Progress 20
	
	'需要重新计算已有类别的depth的值
	Set Rs_Depth=Conn.Execute("Select ID,Partentid From Sd_Class")
	DbQuery=DbQuery+1
	While Not Rs_Depth.Eof
		Depth=Ubound(Split(Rs_Depth(1),","))+1
		Conn.Execute("Update Sd_Class Set Depth="&Depth&" Where Id="&Rs_Depth(0)&"")
		DbQuery=DbQuery+1
	Rs_Depth.MoveNext
	Wend
	Rs_Depth.Close
	Set Rs_Depth=Nothing
	Progress 25
	
	Sql="CREATE View [View_Info] as "
	Sql=Sql&" SELECT Sd_Info.*,Sd_Class.Title AS ClassName,Sd_Class.ClassUrl AS ClassUrl,Sd_Class.FollowID AS FollowID,"
	Sql=Sql&"Sd_Class.PartentID AS PartentID,Sd_Class.Show_Temp AS Show_Temp"
	Sql=Sql&" FROM Sd_Info LEFT OUTER JOIN Sd_Class ON Sd_Info.ClassID=Sd_Class.ID"
	Conn.Execute(Sql)
	Progress 30
	
	Sql="Alter Table [Sd_Info] Drop iscreate,IsSdcms"
	Conn.Execute(Sql)
	Progress 35
	
	Sql="Alter Table [Sd_Info] add Style nvarchar(255) Null"
	Conn.Execute(Sql)
	Progress 40
	
	Sql="Drop Table [sd_skins]"
	Conn.Execute(Sql)
	Progress 45
	Sql="Alter Table [Sd_Comment] add followid int default 0,SupportNum int default 0,allfollowid ntext Null"
	Conn.Execute(Sql)
	Progress 50
	'需要更新数字字段的值
	Conn.Execute("Update Sd_Comment Set followid=0,SupportNum=0")
	Progress 55
	Sql="Drop Table [sd_notice]"
	Conn.Execute(Sql)
	Progress 60
	Sql="Drop Table [Sd_Count]"
	Conn.Execute(Sql)
	Progress 70
	Sql="Alter Table [Sd_Other] add Page_Key nvarchar(255) Null,Page_Desc ntext Null"
	Conn.Execute(Sql)
	Progress 75
	Sql="Alter Table [Sd_Topic] Drop Root,Filename"
	Conn.Execute(Sql)
	Progress 80
	
	Progress 85
	Conn.Execute("Update Sd_Class Set channel_temp='',list_temp='',show_temp=''")
	
	Progress 90
	Conn.Execute("Update Sd_Other Set page_temp=''")
	
	Progress 95
	Conn.Execute("Update Sd_Topic Set Temp_Dir=''")
	
	'更新下系统配置
	Config=""
	Config=Config&"<"
	Config=Config&"%"& vbcrlf
	Config=Config&"'网站名称"& vbcrlf
	Config=Config&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_WebName:Sdcms_WebName="""&Sdcms_WebName&""""&vbcrlf
	Config=Config&"'网站域名"& vbcrlf
	Config=Config&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_WebUrl:Sdcms_WebUrl="""&Sdcms_WebUrl&""""&vbcrlf
	Config=Config&"'系统目录，根目录为：""/"",虚拟目录形式为：""/sdcms/"""& vbcrlf
	Config=Config&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_Root:Sdcms_Root="""&Sdcms_Root&""""&vbcrlf
	Config=Config&"'运行模式,0为动态默认，1为伪静态，2为静态"& vbcrlf
	Config=Config&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_Mode:Sdcms_Mode=2"&vbcrlf
	Config=Config&"'生成目录，根目录为空,也可以指定为某一目录，形式为：""sdcms/"",必须以：""/""结束"& vbcrlf
	Config=Config&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_HtmDir:Sdcms_HtmDir="""&Sdcms_HtmDir&""""&vbcrlf
	Config=Config&"'时区设置,请不要随意更改"& vbcrlf
	Config=Config&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_TimeZone:Sdcms_TimeZone=0"&vbcrlf
	Config=Config&"'是否开启管理日志"& vbcrlf
	Config=Config&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_AdminLog:Sdcms_AdminLog="&Sdcms_AdminLog&""&vbcrlf
	Config=Config&"'是否开启缓存"& vbcrlf
	Config=Config&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_Cache:Sdcms_Cache="&Sdcms_Cache&""&vbcrlf
	Config=Config&"'缓存前缀,如果有多个站点，请设置不同的值"& vbcrlf
	Config=Config&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_Cookies:Sdcms_Cookies="""&Sdcms_Cookies&""""&vbcrlf
	Config=Config&"'缓存时间，单位为秒"& vbcrlf
	Config=Config&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_CacheDate:Sdcms_CacheDate=60"&vbcrlf
	Config=Config&"'系统文件的后缀名，建议不要改动"& vbcrlf
	Config=Config&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_FileTxt:Sdcms_FileTxt="".Html"""&vbcrlf
	Config=Config&"'系统模板目录,一般不建议手动更改"& vbcrlf
	Config=Config&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_Skins_Root:Sdcms_Skins_Root=""2009"""&vbcrlf
	Config=Config&"'系统生成文件的默认文件名，建议不要改动"& vbcrlf
	Config=Config&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_FileName:Sdcms_FileName=""{ID}"""&vbcrlf
	Config=Config&"'附件目录"& vbcrlf
	Config=Config&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_UpfileDir:Sdcms_UpfileDir="""&Sdcms_UpfileDir&""""&vbcrlf
	Config=Config&"'允许上传文件类型,多个请用|格开"& vbcrlf
	Config=Config&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_UpfileType:Sdcms_UpfileType="""&Sdcms_UpfileType&""""&vbcrlf
	Config=Config&"'允许上传的文件最大值，单位：KB"& vbcrlf
	Config=Config&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_upfileMaxSize:Sdcms_upfileMaxSize="&Sdcms_upfileMaxSize&""&vbcrlf
	Config=Config&"'生成偏好设置,系统自动生成，请务随意改动"& vbcrlf
	Config=Config&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_Create_Set:Sdcms_Create_Set=""0, 1, 2"""&vbcrlf
	Config=Config&"'生成GOOGLE地图的参数"& vbcrlf
	Config=Config&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_Create_GoogleMap:Sdcms_Create_GoogleMap=Split(""20,daily,0.8"","","")"&vbcrlf
	Config=Config&"'评论开关"& vbcrlf
	Config=Config&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_Comment_Pass:Sdcms_Comment_Pass="&Sdcms_Comment_Pass&""&vbcrlf
	Config=Config&"'评论审核"& vbcrlf
	Config=Config&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_Comment_IsPass:Sdcms_Comment_IsPass="&Sdcms_Comment_IsPass&""&vbcrlf
	Config=Config&"'Html标签过滤"& vbcrlf
	Config=Config&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_BadHtml:Sdcms_BadHtml="""&Sdcms_BadHtml&""""&vbcrlf
	Config=Config&"'Html标签事件过滤"& vbcrlf
	Config=Config&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_BadEvent:Sdcms_BadEvent="""&Sdcms_BadEvent&""""&vbcrlf
	Config=Config&"'脏话过滤"& vbcrlf
	Config=Config&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_BadText:Sdcms_BadText="""&Sdcms_BadText&""""&vbcrlf
	Config=Config&"'信息描述自动截取字符数,建议为：200-500"& vbcrlf
	Config=Config&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_Length:Sdcms_Length=500"&vbcrlf
	Config=Config&"'数据库连接类型,True为Access，False为MSSQL"& vbcrlf
	Config=Config&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_DataType:Sdcms_DataType="&Sdcms_DataType&vbcrlf
	Config=Config&"'Access数据库目录"& vbcrlf
	Config=Config&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_DataFile:Sdcms_DataFile="""&Sdcms_DataFile&""""&vbcrlf
	Config=Config&"'Access数据库名称"& vbcrlf
	Config=Config&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_DataName:Sdcms_DataName="""&Sdcms_DataName&""""&vbcrlf
	Config=Config&"'MSSQL数据库IP,本地用 (local) 外地用IP "& vbcrlf
	Config=Config&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_SqlHost:Sdcms_SqlHost="""&Sdcms_SqlHost&""""&vbcrlf
	Config=Config&"'MSSQL数据库名"& vbcrlf
	Config=Config&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_SqlData:Sdcms_SqlData="""&Sdcms_SqlData&""""&vbcrlf
	Config=Config&"'MSSQL数据库帐户"& vbcrlf
	Config=Config&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_SqlUser:Sdcms_SqlUser="""&Sdcms_SqlUser&""""&vbcrlf
	Config=Config&"'MSSQL数据库密码"& vbcrlf
	Config=Config&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_SqlPass:Sdcms_SqlPass="""&Sdcms_SqlPass&""""&vbcrlf
	Config=Config&"'系统安装日期"& vbcrlf
	Config=Config&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_CreateDate:Sdcms_CreateDate="""&Sdcms_CreateDate&""""&vbcrlf
	Config=Config&"%"
	Config=Config&">"&vbcrlf
	Config=Config&"<!--#include file=""../Skins/2009/Skins.asp""-->"
	Savefile "../Inc/","Const.asp",Config
	Echo Err.Description
	
	Progress 100

	Echo "<script>document.getElementById(""load_bnt"").value='升级完成';load_updates.innerHTML=""数据库升级完毕，请按说明继续操作！"";</script>"
	IF Err Then
		Echo "<script>document.getElementById(""load_bnt"").value='操作失败';</script>"
		Echo "<script>load_updates.style.width =""100%"";load_updates.innerHTML="""&Err.Description&""";</script>" & VbCrLf
		Err.Clear
	End IF
End Sub
%>
</body>
</html>
