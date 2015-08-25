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
<title>SDCMS配置升级程序</title>
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
		<h1>SDCMS配置升级程序</h1>
		<dl>
			<dt class="update_content"><strong>升级说明：</strong>
				<ul>
					<li class="action">仅适用于SDCMS1.3 To SDCMS1.3.1；</li>
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
dim action
action=request("action")
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
'作用：1.3 To 1.3.1
'Author：IT平民
'Date：2011-10-10
'=========================================
	Echo "<script>document.getElementById(""load_bnt"").disabled=true;</script>"
	
	Progress 5
	Progress 10
	Progress 5
	Progress 20
	Progress 25
	Progress 30
	Progress 35
	Progress 40
	Progress 45
	Progress 50
	Progress 55
	Progress 60

	if Sdcms_Mode=1 then
	dim httpd
		httpd=""
		httpd=httpd&"[ISAPI_Rewrite]"&vbcrlf&vbcrlf

		httpd=httpd&"# 3600 = 1 hour"&vbcrlf
		httpd=httpd&"#CacheClockRate 3600"&vbcrlf&vbcrlf
		
		httpd=httpd&"RepeatLimit 32"&vbcrlf&vbcrlf
		
		httpd=httpd&"#重写单页"&vbcrlf
		httpd=httpd&"RewriteRule "&Get_Sys_Dir&"Page/(.*)_(\d*)\.html "&Get_Sys_Dir&"page/\?id=$1&page=$2 [N,I]"&vbcrlf
		httpd=httpd&"RewriteRule "&Get_Sys_Dir&"Page/(.*)\.html "&Get_Sys_Dir&"page/\?id=$1 [N,I]"&vbcrlf&vbcrlf
		
		httpd=httpd&"#重写专题"&vbcrlf
		httpd=httpd&"RewriteRule "&Get_Sys_Dir&"Topic/List_(.*)_(\d*)\.html "&Get_Sys_Dir&"Topic/\List.asp\?ID=$1&Page=$2 [N,I]"&vbcrlf
		httpd=httpd&"RewriteRule "&Get_Sys_Dir&"Topic/List_(.*)\.html "&Get_Sys_Dir&"Topic/\List.asp\?ID=$1 [N,I]"&vbcrlf
		httpd=httpd&"RewriteRule "&Get_Sys_Dir&"Topic/Index_(.*)\.html "&Get_Sys_Dir&"Topic/\?page=$1 [N,I]"&vbcrlf
		httpd=httpd&"RewriteRule "&Get_Sys_Dir&"Topic/Index\.html "&Get_Sys_Dir&"Topic/\index.asp [N,I]"&vbcrlf&vbcrlf
		
		httpd=httpd&"#重写Tags"&vbcrlf
		httpd=httpd&"RewriteRule "&Get_Sys_Dir&"tags/List_(.*)\.html "&Get_Sys_Dir&"tags/\List.asp\?page=$1 [N,I]"&vbcrlf
		httpd=httpd&"RewriteRule "&Get_Sys_Dir&"tags/List\.html(.*) "&Get_Sys_Dir&"tags/\list.asp [N,I]"&vbcrlf&vbcrlf
		
		httpd=httpd&"RewriteRule "&Get_Sys_Dir&"tags/(.*)_(\d*)\.html "&Get_Sys_Dir&"tags/\?/$1/$2 [N,I]"&vbcrlf
		httpd=httpd&"RewriteRule "&Get_Sys_Dir&"tags/(.*)\.html "&Get_Sys_Dir&"tags/\?/$1/ [N,I]"&vbcrlf&vbcrlf
		
		httpd=httpd&"#重写index.asp"&vbcrlf
		httpd=httpd&"RewriteRule "&Get_Sys_Dir&"index\.html(.*) "&Get_Sys_Dir&"index.asp [N,I]"&vbcrlf&vbcrlf
		httpd=httpd&"#重写博客"&vbcrlf
		httpd=httpd&"RewriteRule "&Get_Sys_Dir&"index_(\d*)\.html "&Get_Sys_Dir&"index.asp\?page=$1 [N,I]"&vbcrlf&vbcrlf
		
		httpd=httpd&"#重写sitemap.asp"&vbcrlf
		httpd=httpd&"RewriteRule "&Get_Sys_Dir&"sitemap\.html(.*) "&Get_Sys_Dir&"sitemap.asp [N,I]"&vbcrlf&vbcrlf
		
		httpd=httpd&"#重写内容"&vbcrlf
		httpd=httpd&"RewriteRule "&Get_Sys_Dir&"html/(.*)/(\d*)_(\d*)\.html "&Get_Sys_Dir&"Info/\View.asp\?ID=$2&page=$3 [N,I]"&vbcrlf
		httpd=httpd&"RewriteRule "&Get_Sys_Dir&"html/(.*)/(\d*)\.html "&Get_Sys_Dir&"Info/\View.asp\?ID=$2 [N,I]"&vbcrlf&vbcrlf
		
		httpd=httpd&"#重写列表"&vbcrlf
		httpd=httpd&"RewriteRule "&Get_Sys_Dir&"html/(.*)/(\d*) "&Get_Sys_Dir&"Info/\?cname=$1&page=$2 [N,I]"&vbcrlf
		httpd=httpd&"RewriteRule "&Get_Sys_Dir&"html/(.*)/ "&Get_Sys_Dir&"Info/\?cname=$1 [N,I]"&vbcrlf&vbcrlf
		
		httpd=httpd&"#重写内容"&vbcrlf
		httpd=httpd&"RewriteRule "&Get_Sys_Dir&"date-(.*)_(\d*) "&Get_Sys_Dir&"date.asp\?c=$1&page=$2 [N,I]"&vbcrlf
		httpd=httpd&"RewriteRule "&Get_Sys_Dir&"date-(.*) "&Get_Sys_Dir&"date.asp\?c=$1 [N,I]"
		Savefile "/","httpd.ini",httpd
	end if
	Progress 65
	Progress 70
	Progress 75
	Progress 80
	'更新下系统配置
	dim Config
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
	Config=Config&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_Mode:Sdcms_Mode="&Sdcms_Mode&""&vbcrlf
	Config=Config&"'博客模式"& vbcrlf
	Config=Config&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim blogmode:blogmode=false"&vbcrlf
	Config=Config&"'生成目录，根目录为空,也可以指定为某一目录，形式为：""sdcms/"",必须以：""/""结束"& vbcrlf
	Config=Config&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_HtmDir:Sdcms_HtmDir="""&Sdcms_HtmDir&""""&vbcrlf
	Config=Config&"'时区设置,请不要随意更改"& vbcrlf
	Config=Config&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_TimeZone:Sdcms_TimeZone="&Sdcms_TimeZone&""&vbcrlf
	Config=Config&"'是否开启管理日志"& vbcrlf
	Config=Config&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_AdminLog:Sdcms_AdminLog="&Sdcms_AdminLog&""&vbcrlf
	Config=Config&"'是否开启缓存"& vbcrlf
	Config=Config&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_Cache:Sdcms_Cache="&Sdcms_Cache&""&vbcrlf
	Config=Config&"'缓存前缀,如果有多个站点，请设置不同的值"& vbcrlf
	Config=Config&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_Cookies:Sdcms_Cookies="""&Sdcms_Cookies&""""&vbcrlf
	Config=Config&"'缓存时间，单位为秒"& vbcrlf
	Config=Config&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_CacheDate:Sdcms_CacheDate="&Sdcms_CacheDate&""&vbcrlf
	Config=Config&"'系统文件的后缀名，建议不要改动"& vbcrlf
	Config=Config&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_FileTxt:Sdcms_FileTxt="""&Sdcms_FileTxt&""""&vbcrlf
	Config=Config&"'系统模板目录,一般不建议手动更改"& vbcrlf
	Config=Config&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_Skins_Root:Sdcms_Skins_Root="""&Sdcms_Skins_Root&""""&vbcrlf
	Config=Config&"'系统生成文件的默认文件名，建议不要改动"& vbcrlf
	Config=Config&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_FileName:Sdcms_FileName="""&Sdcms_FileName&""""&vbcrlf
	Config=Config&"'附件目录"& vbcrlf
	Config=Config&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_UpfileDir:Sdcms_UpfileDir="""&Sdcms_UpfileDir&""""&vbcrlf
	Config=Config&"'允许上传文件类型,多个请用|格开"& vbcrlf
	Config=Config&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_UpfileType:Sdcms_UpfileType="""&Sdcms_UpfileType&""""&vbcrlf
	Config=Config&"'允许上传的文件最大值，单位：KB"& vbcrlf
	Config=Config&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_upfileMaxSize:Sdcms_upfileMaxSize="&Sdcms_upfileMaxSize&""&vbcrlf
	Config=Config&"'生成偏好设置,系统自动生成，请务随意改动"& vbcrlf
	Config=Config&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_Create_Set:Sdcms_Create_Set="""&Sdcms_Create_Set&""""&vbcrlf
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
	Config=Config&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_Length:Sdcms_Length="&Sdcms_Length&""&vbcrlf
	Config=Config&"'数据库连接类型,True为Access，False为MSSQL"& vbcrlf
	Config=Config&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_DataType:Sdcms_DataType="&Sdcms_DataType&vbcrlf
	Config=Config&"'Access数据库目录"& vbcrlf
	Config=Config&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_DataFile:Sdcms_DataFile=""Data"""&vbcrlf
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
	Config=Config&"<!--#include file=""../Skins/"&Sdcms_Skins_Root&"/Skins.asp""-->"
	Savefile "../Inc/","Const.asp",Config
	Progress 85
	Progress 90
	Progress 95
	Progress 96
	Progress 97
	Progress 98
	Progress 99
	Progress 100

	Echo "<script>document.getElementById(""load_bnt"").value='升级完成';load_updates.innerHTML=""升级完毕，请按说明继续操作！"";</script>"
	
End Sub
%>
</body>
</html>
