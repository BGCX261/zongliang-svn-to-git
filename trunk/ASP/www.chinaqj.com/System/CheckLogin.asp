<!--#include file="../Include/Const.asp"-->
<!--#include file="../Include/ConnSiteData.asp"-->
<!--#include file="../Include/Md5.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%
dim LoginName,LoginPassword,AdminName,Password,AdminPurview,Working,UserName,rs,sql
LoginName=trim(request.form("UserName"))
LoginPassword=Md5(request.form("password"))
CheckCode = LCase(Trim(Request("CheckCode")))
AdminLoginCode = Trim(Request("AdminLoginCode"))
If EnableSiteCheckCode = 1 and CheckCode = "" Then
   response.write "<script language='JavaScript'>alert('验证码不能为空，请返回检查！');" & "history.back()" & "</script>"
   response.end
End If
If EnableSiteCheckCode = 1 and Trim(Session("CheckCode")) = "" Then
   response.write "<script language='JavaScript'>alert('您在管理登录停留的时间过长，导致验证码失效。\n请重新返回登录页面进行登录。');" & "history.back()" & "</script>"
   response.end
End If
If EnableSiteCheckCode = 1 and CheckCode <> Session("CheckCode") Then
   response.write "<script language='JavaScript'>alert('您输入的验证码和系统产生的不一致，请重新输入。');" & "history.back()" & "</script>"
   response.end
End If
If EnableSiteManageCode = 1 And AdminLoginCode <> SiteManageCode Then
   response.write "<script language='JavaScript'>alert('您输入的后台管理认证码不对，请重新输入。');" & "history.back()" & "</script>"
   response.end
End If
set rs = server.createobject("adodb.recordset")
sql="select * from ChinaQJ_Admin where AdminName='"&LoginName&"'"
rs.open sql,conn,1,3
if rs.eof then
   response.write "<script language='JavaScript'>alert('无此帐号，请返回检查！');" & "history.back()" & "</script>"
   response.end
else
   AdminName=rs("AdminName")
   Password=rs("Password")
   AdminPurview=rs("AdminPurview")
   Working=rs("Working")
   UserName=rs("UserName")
end if
if LoginPassword<>Password then
   response.write "<script language='JavaScript'>alert('密码错误，请返回检查！');" & "history.back()" & "</script>"
   response.end
end if
if not Working then
   response.write "<script language='JavaScript'>alert('帐号被禁用！');" & "history.back()" & "</script>"
   response.end
end if
if LoginName=AdminName and LoginPassword=Password then
   rs("LastLoginTime")=now()
   rs("LastLoginIP")=Request.ServerVariables("Remote_Addr")
   rs.update
   rs.close
   set rs=nothing
   session("AdminName")=AdminName
   session("UserName")=UserName
   session("AdminPurview")=AdminPurview
   session("LoginSystem")="Succeed"
   session.timeout=60
   Response.Cookies("AdminLoginCode")=AdminLoginCode
   dim LoginIP,LoginTime,LoginSoft
   LoginIP=Request.ServerVariables("Remote_Addr")
   LoginSoft=Request.ServerVariables("Http_USER_AGENT")
   LoginTime=now()
   set rs = server.createobject("adodb.recordset")
   sql="select * from ChinaQJ_AdminLog"
   rs.open sql,conn,1,3
   rs.addnew
   rs("AdminName")=AdminName
   rs("UserName")=UserName
   rs("LoginIP")=LoginIP
   rs("LoginSoft")=LoginSoft
   rs("LoginTime")=LoginTime
   rs.update
   rs.close
   set rs=nothing
   set conn=nothing
   response.redirect "Admin_Index.asp"
   response.end
end if
%>