<!--#include file="../Include/Const.asp" -->
<!--#include file="../Include/ConnSiteData.asp" -->
<!--#include file="Admin_htmlconfig.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="Images/Admin_style.css">
<script language="javascript" src="../Scripts/Admin.js"></script>
<%
if Instr(session("AdminPurview"),"|48,")=0 then
  response.write ("<br /><br /><div align=""center""><font style=""color:red; font-size:9pt; "")>您没有管理该模块的权限！</font></div>")
  response.end
end if
If Not IsObjInstalled("JMail.Message") Then 
	 response.write "<script language='javascript'>alert('服务器不支持JMail组件');location.replace('Admin_EMail.asp');</script>"
end if
%>
<br />

<table class="tableBorder" width="95%" border="0" align="center" cellpadding="5" cellspacing="1">
  <form name="SendMail" method="post" action="Admin_EMailPub.asp?Action=Send">
    <tr>
      <th height="22" colspan="2" sytle="line-height:150%">【企业注册用户、邮件订阅邮件群发】</th>
    </tr>
    <tr>
      <td width="200" align="right" class="forumRow">发信人：</td>
      <td class="forumRowHighlight"><input name="ToEMail" type="text" id="ToEMail" style="width: 350" value="<%= Request("selectemail") %>">
        <input type="checkbox" name="UserEMail" value="on">
        发送给所有注册会员（默认发送所有邮件订阅用户）<br />
        <font color="#CC0000">手动录入，请以“,”分隔邮箱地址。</font></td>
    </tr>
    <tr>
      <td align="right" class="forumRow">邮件标题：</td>
      <td class="forumRowHighlight"><input name="EMailTitle" type="text" id="EMailTitle" style="width: 500" value=""></td>
    </tr>
    <tr>
      <td align="right" class="forumRow">邮件内容：</td>
      <td class="forumRowHighlight"><textarea name="EMailBody" id="EMailBody" style="display: none"></textarea>
        <iframe ID="eWebEditor1" src="eWebEditor/ewebeditor.htm?id=EMailBody&style=coolblue" frameborder="0" scrolling="no" width="550" height="350"></iframe></td>
    </tr>
    <tr>
      <td class="forumRow"></td>
      <td class="forumRowHighlight"><input name="SendMailPub" type="button" id="SendMailPub" value="批量发送邮件" onclick="doSubmit()">
        <input type="button" value="返回上一页" onclick="history.back(-1)"></td>
    </tr>
  </form>
</table>
<br />
<script language="JavaScript">
function doSubmit(){
    if (document.SendMail.EMailTitle.value==""){
        alert("请填写邮件标题！");
        document.SendMail.EMailTitle.focus();
        return false;
    }
    if (eWebEditor1.getHTML()==""){
        alert("请填写邮件内容！");
        return false;
    }
    document.SendMail.submit();
}
</script>
<%
strToEmail=Request("ToEMail")
if Trim(Request.QueryString("UserEMail"))="on" then
    sql="select id from ChinaQJ_Members"
    set rs=server.createobject("adodb.recordset")
    rs.open sql,conn,1,1
	if not rs.eof then
	Emailist=""
	do while not rs.eof
	Emailist=Emailist & "," & rs("email")
	rs.movenext
	loop	
	end if
	rs.close
	set rs=nothing
	strToEmail=strToEmail&Emailist
end if

if Request("Action")="Send" then
moremail=Split(strToEmail,",")
if ubound(moremail)>0 then
for i=0 to ubound(moremail)
Call JSendMail(moremail(i))
next
else
Call JSendMail(strToEmail)
end if
end if

Private Function JSendMail(strToEmail) 
strTitle=Request("EMailTitle")
strSubject=Request("EMailBody")
'MailDomain="163.com"


     On Error Resume Next 
     Dim JMail 
     Set JMail = Server.CreateObject("JMail.Message") 
     JMail.Charset = "gb2312"         '邮件编码 
     JMail.silent = True 
     JMail.ContentType = "text/html"     '邮件正文格式 
     'JMail.ServerAddress=JMailSMTP     '用来发送邮件的SMTP服务器 
     '如果服务器需要SMTP身份验证则还需指定以下参数 
     JMail.MailServerUserName = JMailUser     '登录用户名 
     JMail.MailServerPassWord = JMailPass         '登录密码 
     JMail.MailDomain = MailDomain       '域名（如果用"name@domain.com"这样的用户名登录时，请指明domain.com 
     JMail.AddRecipient strToEmail, strToEmail     '收信人 
     JMail.Subject = strTitle       '主题 
     JMail.HMTLBody = strSubject     '邮件正文（HTML格式） 
     JMail.Body = strSubject         '邮件正文（纯文本格式） 
     JMail.FromName = JMailName       '发信人姓名 
     JMail.From = JMailOutFrom         '发信人Email 
     JMail.Priority = 1             '邮件等级，1为加急，3为普通，5为低级 
     JMail.Send (JMailSMTP) 
     JSendMail = JMail.ErrorMessage 
     JMail.Close 
     Set JMail = Nothing 
     JSendMail = "" 
	 response.write "<script language='javascript'>alert('发送成功！');location.replace('Admin_EMail.asp');</script>"
End Function 
Function IsObjInstalled(strClassString) 
     On Error Resume Next 
     IsObjInstalled = False 
     Err = 0 
     Dim xTestObj 
     Set xTestObj = CreateObject(strClassString) 
     If Err.Number = 0 Then IsObjInstalled = True 
     Set xTestObj = Nothing 
     Err = 0 
End Function
%>