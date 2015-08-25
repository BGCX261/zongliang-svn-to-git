<!--#include file="../Include/Const.asp" -->
<!--#include file="../Include/ConnSiteData.asp" -->
<!--#include file="CheckAdmin.asp"-->
<!--#include file="../Include/Version.asp" -->
<%
Dim theInstalledObjects(27)
theInstalledObjects(0) = "MSWC.AdRotator"
theInstalledObjects(1) = "MSWC.BrowserType"
theInstalledObjects(2) = "MSWC.NextLink"
theInstalledObjects(3) = "MSWC.Tools"
theInstalledObjects(4) = "MSWC.Status"
theInstalledObjects(5) = "MSWC.Counters"
theInstalledObjects(6) = "MSWC.PermissionChecker"
theInstalledObjects(7) = "ADODB.Stream"
theInstalledObjects(8) = "adodb.connection"
theInstalledObjects(9) = "Scripting.FileSystemObject"
theInstalledObjects(10) = "SoftArtisans.FileUp"
theInstalledObjects(11) = "SoftArtisans.FileManager"
theInstalledObjects(12) = "JMail.Message"
theInstalledObjects(13) = "CDONTS.NewMail"
theInstalledObjects(14) = "Persits.MailSender"
theInstalledObjects(15) = "LyfUpload.UploadFile"
theInstalledObjects(16) = "Persits.Upload.1"
theInstalledObjects(17) = "w3.upload"
theInstalledObjects(18) = "Persits.MailSender"
theInstalledObjects(19) = "SmtpMail.SmtpMail.1"
theInstalledObjects(20) = "IISmail.Iismail.1"
theInstalledObjects(21) = "DkQmail.Qmail"
theInstalledObjects(22) = "Geocel.Mailer"
theInstalledObjects(23) = "Persits.Jpeg"
theInstalledObjects(24) = "SoftArtisans.ImageGen"
theInstalledObjects(25) = "W3Image.Image"
theInstalledObjects(26) = "wsImage.Resize"
theInstalledObjects(27) = "SMTPsvg.Mailer"

''''''''''''''''''''''''''''''
Function IsObjInstalled(strClassString)
On Error Resume Next
IsObjInstalled = False
Err = 0
Dim xTestObj
Set xTestObj = Server.CreateObject(strClassString)
If 0 = Err Then IsObjInstalled = True
Set xTestObj = Nothing
Err = 0
End Function
''''''''''''''''''''''''''''''
Function getver(Classstr)
On Error Resume Next
getver=""
Err = 0
Dim xTestObj
Set xTestObj = Server.CreateObject(Classstr)
If 0 = Err Then getver=xtestobj.version
Set xTestObj = Nothing
Err = 0
End Function

m_SQL = "select count(*) from ChinaQJ_Admin"
set rs = conn.Execute(m_SQL)
m_ManageNumber = rs(0)
rs.Close
set rs=Nothing

m_SQL = "select count(*) from ChinaQJ_Members"
set rs = conn.Execute(m_SQL)
m_UserNumber = rs(0)
rs.Close
set rs=Nothing

m_SQL = "select count(*) from ChinaQJ_Message"
set rs = conn.Execute(m_SQL)
m_Message = rs(0)
rs.Close
set rs=Nothing

m_SQL = "select count(*) from ChinaQJ_Message where ViewFlagCh = 1"
set rs = conn.Execute(m_SQL)
m_MessageViewFlag = rs(0)
rs.Close
set rs=Nothing

m_SQL = "select count(*) from ChinaQJ_About"
set rs = conn.Execute(m_SQL)
m_About = rs(0)
rs.Close
set rs=Nothing

m_SQL = "select count(*) from ChinaQJ_Download"
set rs = conn.Execute(m_SQL)
m_Download = rs(0)
rs.Close
set rs=Nothing

m_SQL = "select count(*) from ChinaQJ_FriendLink"
set rs = conn.Execute(m_SQL)
m_FriendLink = rs(0)
rs.Close
set rs=Nothing

m_SQL = "select count(*) from ChinaQJ_Jobs"
set rs = conn.Execute(m_SQL)
m_Jobs = rs(0)
rs.Close
set rs=Nothing

m_SQL = "select count(*) from ChinaQJ_News"
set rs = conn.Execute(m_SQL)
m_News = rs(0)
rs.Close
set rs=Nothing

m_SQL = "select count(*) from ChinaQJ_Order"
set rs = conn.Execute(m_SQL)
m_Order = rs(0)
rs.Close
set rs=Nothing

m_SQL = "select count(*) from ChinaQJ_Others"
set rs = conn.Execute(m_SQL)
m_Others = rs(0)
rs.Close
set rs=Nothing

m_SQL = "select count(*) from ChinaQJ_Products"
set rs = conn.Execute(m_SQL)
m_Products = rs(0)
rs.Close
set rs=Nothing

m_SQL = "select count(*) from ChinaQJ_Talents"
set rs = conn.Execute(m_SQL)
m_Talents = rs(0)
rs.Close
set rs=nothing
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="Images/Admin_style.css">
<br />
<table class="tableBorder" width="95%" border="0" align="center" cellpadding="5" cellspacing="1">
  <tr>
    <th height="22" colspan="2" sytle="line-height:150%">【系统信息】</th>
  </tr>
  <tr>
    <td width="47%" class="leftRow">服务器类型：<%=Request.ServerVariables("OS")%>(IP：<%=Request.ServerVariables("local_addr")%>)</td>
    <td width="53%" class="forumRowHighlight">脚本解释引擎：<%=ScriptEngine & "/"& ScriptEngineMajorVersion &"."&ScriptEngineMinorVersion&"."& ScriptEngineBuildVersion %></td>
  </tr>
  <tr>
    <td class="leftRow">站点物理路径：<%=request.ServerVariables("APPL_PHYSICAL_PAth")%></td>
    <td class="forumRowHighlight">协议的名称和版本：<%=request.ServerVariables("SERVER_PROTOCOL")%>
</td>
  </tr>
  <tr>
    <td class="leftRow">FSO文本读写：
      <%If Not IsObjInstalled(theInstalledObjects(9)) Then%>
      <b><font color="#FF0000">×</font></b>
      <%else%>
      <b><font color="#FF0000">√</font></b>
    <%end if%></td>
    <td class="forumRowHighlight">脚本超时时间：<%=Server.ScriptTimeout%>秒</td>
  </tr>
  <tr>
    <td class="leftRow">客户端操作系统：
      <%
      dim thesoft,vOS
      thesoft=Request.ServerVariables("HTTP_USER_AGENT")
      if instr(thesoft,"Windows NT 5.0") then
	     vOS="Microsoft Windows 2000"
      elseif instr(thesoft,"Windows NT 5.2") then
	     vOs="Microsoft Windows 2003"
      elseif instr(thesoft,"Windows NT 5.1") then
         vOs="Microsoft Windows XP"
      elseif instr(thesoft,"Windows NT") then
       	 vOs="Microsoft Windows NT"
      elseif instr(thesoft,"Windows 9") then
	     vOs="Microsoft Windows 9x"
      elseif instr(thesoft,"unix") or instr(thesoft,"linux") or instr(thesoft,"SunOS") or instr(thesoft,"BSD") then
	     vOs="类Unix"
      elseif instr(thesoft,"Mac") then
	     vOs="Mac"
      else
     	vOs="Other"
      end if
      response.Write(vOs)
      %></td>
    <td class="forumRowHighlight">返回服务器处理请求的端口：<%=Request.ServerVariables("SERVER_PORT")%></td>
  </tr>
</table>
<br />
<table class="tableBorder" width="95%" border="0" align="center" cellpadding="5" cellspacing="1">
  <tr>
    <th height="22" colspan="2" sytle="line-height:150%">【常见的文件上传和管理组件】</th>
  </tr>
  <tr>
    <td width="47%" class="leftRow">SoftArtisans.FileUp(SA-FileUp 文件上传)：
      <%If Not IsObjInstalled(theInstalledObjects(10)) Then%>
      <b><font color="#FF0000">×</font></b>
      <%else%>
      <b><font color="#FF0000">√</font></b>
    <%end if%></td>
    <td width="53%" class="forumRowHighlight">SoftArtisans.FileManager(SoftArtisans 文件管理)：
      <%If Not IsObjInstalled(theInstalledObjects(11)) Then%>
      <b><font color="#FF0000">×</font></b>
      <%else%>
      <b><font color="#FF0000">√</font></b>
  <%end if%></td>  </tr>
  <tr>
    <td class="leftRow">LyfUpload.UploadFile(刘云峰的文件上传组件)：
      <%If Not IsObjInstalled(theInstalledObjects(15)) Then%>
      <b><font color="#FF0000">×</font></b>
      <%else%>
      <b><font color="#FF0000">√</font></b>
    <%end if%></td>    <td class="forumRowHighlight">Persits.Upload.1(ASPUpload 文件上传)：
      <%If Not IsObjInstalled(theInstalledObjects(16)) Then%>
      <b><font color="#FF0000">×</font></b>
      <%else%>
      <b><font color="#FF0000">√</font></b>
  <%end if%></td>  </tr>
  <tr>
    <td class="leftRow">w3.upload(Dimac 文件上传)：
      <%If Not IsObjInstalled(theInstalledObjects(17)) Then%>
      <b><font color="#FF0000">×</font></b>
      <%else%>
      <b><font color="#FF0000">√</font></b>
    <%end if%></td></td>
    <td class="forumRowHighlight"></td>
  </tr>
</table>
<br />
<table class="tableBorder" width="95%" border="0" align="center" cellpadding="5" cellspacing="1">
  <tr>
    <th height="22" colspan="2" sytle="line-height:150%">【常见的收发邮件组件】</th>
  </tr>
  <tr>
    <td width="47%" class="leftRow">Jmail4.2组件支持：
      <%If Not IsObjInstalled(theInstalledObjects(13)) Then%>
      <b><font color="#FF0000">×</font></b>
      <%else%>
      <b><font color="#FF0000">√</font></b>
    <%end if%></td>    <td width="53%" class="forumRowHighlight">CDONTS.NewMail(虚拟 SMTP 发信)：
      <%If Not IsObjInstalled(theInstalledObjects(14)) Then%>
      <b><font color="#FF0000">×</font></b>
      <%else%>
      <b><font color="#FF0000">√</font></b>
  <%end if%></td>  </tr>
  <tr>
    <td class="leftRow">Persits.MailSender(ASPemail 发信)：
      <%If Not IsObjInstalled(theInstalledObjects(18)) Then%>
      <b><font color="#FF0000">×</font></b>
      <%else%>
      <b><font color="#FF0000">√</font></b>
    <%end if%></td>    <td class="forumRowHighlight">SMTPsvg.Mailer(ASPmail 发信)：
      <%If Not IsObjInstalled(theInstalledObjects(27)) Then%>
      <b><font color="#FF0000">×</font></b>
      <%else%>
      <b><font color="#FF0000">√</font></b>
      <%end if%>
</td>
  </tr>
  <tr>
    <td class="leftRow">SmtpMail.SmtpMail.1(SmtpMail 发信)：
      <%If Not IsObjInstalled(theInstalledObjects(19)) Then%>
      <b><font color="#FF0000">×</font></b>
      <%else%>
      <b><font color="#FF0000">√</font></b>
    <%end if%></td>
    <td class="forumRowHighlight">IISmail.Iismail.1(IISmail 发信)：
      <%If Not IsObjInstalled(theInstalledObjects(20)) Then%>
      <b><font color="#FF0000">×</font></b>
      <%else%>
      <b><font color="#FF0000">√</font></b>
    <%end if%></td>
  </tr>
  <tr>
    <td class="leftRow">DkQmail.Qmail(dkQmail 发信)：
      <%If Not IsObjInstalled(theInstalledObjects(21)) Then%>
      <b><font color="#FF0000">×</font></b>
      <%else%>
      <b><font color="#FF0000">√</font></b>
    <%end if%></td>
    <td class="forumRowHighlight">Geocel.Mailer(Geocel 发信)：
      <%If Not IsObjInstalled(theInstalledObjects(22)) Then%>
      <b><font color="#FF0000">×</font></b>
      <%else%>
      <b><font color="#FF0000">√</font></b>
    <%end if%></td>
  </tr>
  <tr>
    <td class="leftRow">Persits.Jpeg(AspJpeg图像)：
      <%If Not IsObjInstalled(theInstalledObjects(23)) Then%>
      <b><font color="#FF0000">×</font></b>
      <%else%>
      <b><font color="#FF0000">√</font></b>
    <%end if%></td>
    <td class="forumRowHighlight">SoftArtisans.ImageGen(SA 的图像读写组件)：
      <%If Not IsObjInstalled(theInstalledObjects(24)) Then%>
      <b><font color="#FF0000">×</font></b>
      <%else%>
      <b><font color="#FF0000">√</font></b>
    <%end if%></td>
  </tr>
  <tr>
    <td class="leftRow">W3Image.Image(Dimac 的图像读写组件)：
      <%If Not IsObjInstalled(theInstalledObjects(25)) Then%>
      <b><font color="#FF0000">×</font></b>
      <%else%>
      <b><font color="#FF0000">√</font></b>
    <%end if%></td>
    <td class="forumRowHighlight">wsImage.Resize：
      <%If Not IsObjInstalled(theInstalledObjects(26)) Then%>
      <b><font color="#FF0000">×</font></b>
      <%else%>
      <b><font color="#FF0000">√</font></b>
    <%end if%></td>
  </tr>
</table>
<br />
<table class="tableBorder" width="95%" border="0" align="center" cellpadding="5" cellspacing="1">
  <tr>
    <th height="22" colspan="2" sytle="line-height:150%">【版本信息】</th>
  </tr>
  <tr>
    <td width="47%" class="leftRow">ChinaQJ <%=Str_Soft_Version%></td>
    <td width="53%" class="forumRowHighlight">秦江陶瓷</td>
  </tr>
  <tr>
    <td width="47%" class="leftRow">管 理 员：<%=m_ManageNumber%>个 注册会员：<%=m_UserNumber%>个 留言：<%=m_Message%>(已审<%=m_MessageViewFlag%>条) 应聘信息：<%=m_Talents%>条</td>
    <td width="53%" class="forumRowHighlight">企业信息：<%=m_About%>条 下载信息：<%=m_Download%>条 友情链接：<%=m_FriendLink%>条 人才信息：<%=m_Jobs%>条</td>
  </tr>
  <tr>
    <td width="47%" class="leftRow">新闻动态：<%=m_News%>条 在线订单：<%=m_Order%>条</td>
    <td width="53%" class="forumRowHighlight">其他信息：<%=m_Others%>条 公司产品：<%=m_Products%>条</td>
  </tr>
</table>
<br />
<table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td align="center">Copyright (c) 2007-<%= year(now()) %> <a href="http://www.chinaqj.com" title="秦江陶瓷" target="_blank"><font face="Verdana, arial, helvetica, sans-serif" size="1"><b>www.<font color="#CC0000">ChinaQJ</font>.com</b></font></a> All Rights Reserved.</td>
  </tr>
</table>