<!--#include file="../Include/Const.asp" -->
<%
'强制浏览器重新访问服务器下载页面，而不是从缓存读取页面
Response.Expires = -1
Response.ExpiresAbsolute = Now() - 1
Response.Expires = 0
Response.CacheControl = "no-cache"
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<link rel="shortcut icon" href="favicon.ico"/>
<title>ChinaQJ企业网站管理系统 <%=Str_Soft_Version%></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="Images/Admin_style.css">
<LINK href="images/Login.css" type=text/css rel=stylesheet>
<script language="javascript">
<!--
if(self!=top){
    top.location=self.location;
}
CheckBrowser();
function CheckForm() {
    if(document.Login.UserName.value == "") {
        alert("请输入用户名！");
        document.Login.UserName.focus();
        return false;
    }
    if(document.Login.password.value == "") {
        alert("请输入密码！");
        document.Login.password.focus();
        return false;
    }
    if (document.Login.CheckCode.value == "") {
        alert ("请输入您的验证码！");
        document.Login.CheckCode.focus();
        return(false);
    }
    if (document.Login.AdminLoginCode.value == "") {
        alert ("请输入您的管理验证码！");
        document.Login.AdminLoginCode.focus();
        return(false);
    }
}
function CheckBrowser() {
    var app=navigator.appName;
    var verStr=navigator.appVersion;
    if(app.indexOf("Netscape") != -1) {
        alert("友情提示：\n您使用的是Netscape、Firefox或者其他非IE浏览器，可能会导致无法使用后台的部分功能。建议您使用 IE6.0 或以上版本。");
    }
    else if(app.indexOf("Microsoft") != -1) {
        if (verStr.indexOf("MSIE 3.0")!=-1 || verStr.indexOf("MSIE 4.0") != -1 || verStr.indexOf("MSIE 5.0") != -1 || verStr.indexOf("MSIE 5.1") != -1)
        alert("友情提示：\n您的浏览器版本太低，可能会导致无法使用后台的部分功能。建议您使用 IE6.0 或以上版本。");
    }
}
function refreshimg(){document.all.checkcode.src="../Include/CheckCode/CheckCode.asp";}
//-->
</script>
<script language="javascript">
if (top != self)top.location.href = "Admin_Login.asp"; 
</script>
</head>

<BODY id=loginbody>
<FORM name=Login onSubmit="return CheckForm()" action="CheckLogin.Asp" method="post">
<DIV id=adminboxall>
<DIV class=adminboxtop></DIV>
<DIV id=adminboxmain>
<DIV class=menu><INPUT 
style="BORDER-TOP-WIDTH: 0px; BORDER-LEFT-WIDTH: 0px; BORDER-BOTTOM-WIDTH: 0px; WIDTH: 76px; HEIGHT: 26px; BORDER-RIGHT-WIDTH: 0px" 
type=image src="images/admin_menu.gif" name=Submit> </DIV></DIV>
<DIV class=adminboxbottom>
<DIV id=login>
<UL>
  <LI class=text>用户名：<BR>
  <DIV class=box1><INPUT class=boxcontent style="FONT-FAMILY: 宋体" maxLength=20 
  value="" name=UserName> </DIV></LI>
  <LI class=text>密 码：<BR>
  <DIV class=box2><INPUT class=boxcontent type=password maxLength=20 
  value="" name=password> </DIV></LI>
<% If EnableSiteManageCode=1 Then %>
  <LI class=text>管理认证码：<BR>
  <DIV class=box3>
    <input class=boxcontent type=password maxlength=20 
  value="" name=AdminLoginCode>
  </DIV></LI>
<% End If %>
<% If EnableSiteCheckCode=1 Then %>
  <LI class=textCode>验证码：<BR>
  <DIV class=box4><INPUT class=boxcontent2 style="IME-MODE: disabled" 
  type=password maxLength=20 name=CheckCode> <a href="javascript:refreshimg()" title="看不清楚，换个图片。"><img id="checkcode" src="../Include/CheckCode/CheckCode.asp" style="border: 1px solid #ffffff" /></a></DIV></LI>
<% End If %>
  </UL></DIV></DIV><A href="http://www.chinaqj.com/" target=_blank><font style="color:#bbb">http://www.ChinaQJ.com</font></A>
<DIV class=clearbox></DIV></DIV></FORM>
</body>
</html>