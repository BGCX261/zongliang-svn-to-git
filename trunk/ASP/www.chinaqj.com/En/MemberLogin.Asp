<!--#include file="../Include/Const.Asp"-->
<!--#include file="../Include/ConnSiteData.Asp"-->
<!--#include file="../Include/Md5.Asp"-->
<!--#include file="Language.Asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="shortcut icon" href="favicon.ico"/>
<%
if request.QueryString("Action")="Out" then
   session.contents.remove "MemName"
   session.contents.remove "GroupID"
   session.contents.remove "GroupLevel"
   session.contents.remove "MemLogin"
   session("MemName")=""
   session("GroupID")=""
   session("MemLogin")=""
   response.write "<script language='javascript'>alert('"&ChinaQJLanguageTxt305&"');location.replace('index.asp');</script>"
   response.redirect SysRootDir & Language
   response.end
end If

dim LoginName,LoginPassword,VerifyCode,MemName,Password,GroupID,GroupName,Working,rs,sql
LoginName=trim(request.form("LoginName"))
LoginPassword=Md5(request.form("LoginPassword"))
set rs = server.createobject("adodb.recordset")
sql="select * from ChinaQJ_Members where MemName='"&LoginName&"'"
rs.open sql,conn,1,3
if rs.bof and rs.eof then
   response.write "<script language='JavaScript'>alert('"&ChinaQJLanguageTxt163&"');" & "history.back()" & "</script>"
   response.end
else
   MemName=rs("MemName")
   Password=rs("Password")
   GroupID=rs("GroupID")
   GroupName=rs("GroupName")
   Working=rs("Working")
end if

if LoginPassword<>Password then
   response.write "<script language='JavaScript'>alert('"&ChinaQJLanguageTxt164&"');" & "history.back()" & "</script>"
   response.end
end if

if not Working then
   response.write "<script language='JavaScript'>alert('"&ChinaQJLanguageTxt165&"');" & "history.back()" & "</script>"
   response.end
end if

if UCase(LoginName)=UCase(MemName) and LoginPassword=Password then
   rs("LastLoginTime")=now()
   rs("LastLoginIP")=Request.ServerVariables("Remote_Addr")
   rs("LoginTimes")=rs("LoginTimes")+1
   rs.update
   rs.close
   set rs=nothing
   session("MemName")=MemName
   session("GroupID")=GroupID
   set rs = server.createobject("adodb.recordset")
   sql="select * from ChinaQJ_MemGroup where GroupID='"&GroupID&"'"
   rs.open sql,conn,1,1
   session("GroupLevel")=rs("GroupLevel")
   rs.close
   set rs=nothing
   session("MemLogin")="Succeed"
   session.timeout=60
   response.write "<script language='javascript'>alert('"&ChinaQJLanguageTxt306&"');location.replace(index.asp');</script>"
   response.redirect "Index.Asp"
   response.end
end if
%>