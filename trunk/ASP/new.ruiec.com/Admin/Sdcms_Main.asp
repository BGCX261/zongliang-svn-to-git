<!--#include file="sdcms_check.asp"-->
<%
Dim Sdcms,Action:Action=Lcase(Trim(Request.QueryString("Action")))
Set Sdcms=New Sdcms_Admin
Sdcms.Check_admin
Set Sdcms=Nothing
Sdcms_Head
Main
Db_Run
Sub Main
%>
<div class="sdcms_notice" id="notice"><table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="80"><span>官方通知：</span></td>
    <td width="*" align="left" id="sdcms_notice">Loading</td>
	<td height="25" align="right"><img src="images/close.gif" onclick="$('#notice').toggle('slow')" class="hand" hspace="6" vspace="6"></td>
  </tr>
</table>
</div>
 
<br>
<ul id="sdcms_sub_title">
	<li class="sub">服务器信息</li>
</ul>
<div id="sdcms_right_b">
<table border="0" align="center" cellpadding="3" cellspacing="1" class="table_b">
    <tr>
      <td height="25" align="center" class="tdbg01">Adodb.Stream</td>
      <td align="center" class="tdbg01">Scripting.FileSystemObject</td>
      <td align="center" class="tdbg01">Microsoft.XMLHTTP</td>
	  <td align="center" class="tdbg01">Persits.Jpeg</td>
      <td align="center" class="tdbg01">JMail.SmtpMail</td>
	  <td align="center" class="tdbg01">脚本超时</td>
    </tr>
	<tr onmouseover=this.bgColor='#EEFEED'; onmouseout=this.bgColor='#ffffff';  bgcolor='#ffffff'>
      <td height="20" align="center"><%=IIF(IsObjInstalled("Adodb.Stream"),"√","×")%></td>
      <td align="center"><%=IIF(IsObjInstalled("Scripting.FileSystemObject"),"√","×")%></td>
	  <td align="center"><%=IIF(IsObjInstalled("Microsoft.XMLHTTP"),"√","×")%></td>
	  <td align="center"><%=IIF(IsObjInstalled("Persits.Jpeg"),"√","×")%></td>
      <td align="center"><%=IIF(IsObjInstalled("JMail.SMTPMail"),"√","×")%></td>
	  <td align="center"><%=Server.ScriptTimeout%> 秒</td>
    </tr>
  </table>
</div>

 
<br>
<ul id="sdcms_sub_title">
	<li class="sub">官方推荐</li>
</ul>
<div id="sdcms_right_b">
  <table width="100%" border="0" align="center" cellpadding="3" cellspacing="1">
    <tr bgcolor='#ffffff'>
      <td height="108" valign="top" id="sdcms_nice">Loading</td>
      </tr>
  </table>
</div>

<br>
<ul id="sdcms_sub_title">
	<li class="sub">版权信息</li>
</ul>
<div id="sdcms_right_b">
  <table border="0" align="center" cellpadding="3" cellspacing="1" class="table_b">
    <tr onmouseover=this.bgColor='#EEFEED'; onmouseout=this.bgColor='#ffffff';  bgcolor='#ffffff'>
      <td width="100" height="22" align="center">程序名称：</td>
      <td>SDCMS网站信息管理系统</td>
    </tr> 
    <tr onmouseover=this.bgColor='#EEFEED'; onmouseout=this.bgColor='#ffffff';  bgcolor='#ffffff'>
      <td height="22" align="center">官方网站：</td>
      <td><a href="http://www.sdcms.cn">www.sdcms.cn</a></td>
    </tr>
    <tr onmouseover=this.bgColor='#EEFEED'; onmouseout=this.bgColor='#ffffff';  bgcolor='#ffffff'>
      <td height="22" align="center">当前版本：</td>
      <td><%=Sdcms_Version%></td>
    </tr>
    <tr onmouseover=this.bgColor='#EEFEED'; onmouseout=this.bgColor='#ffffff';  bgcolor='#ffffff'>
      <td height="22" align="center">合作站点：</td>
      <td><a href="http://www.nicemb.com" target="_blank">苏州时代网络科技有限公司</a></td>
    </tr>
  </table>
</div>

</body>
</html>
<%End Sub%>