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
	<li class="sub">企业信息</li>
</ul>
<div id="sdcms_right_b">
  <table border="0" align="center" cellpadding="3" cellspacing="1" class="table_b">
    <tr onmouseover=this.bgColor='#EEFEED'; onmouseout=this.bgColor='#ffffff';  bgcolor='#ffffff'>
      <td width="100" height="22" align="center">公司名称：</td>
      <td>深圳源中瑞科技有限公司</td>
    </tr> 
    <tr onmouseover=this.bgColor='#EEFEED'; onmouseout=this.bgColor='#ffffff';  bgcolor='#ffffff'>
      <td height="22" align="center">当前网站：</td>
      <td><a href="http://www.sdcms.cn">www.ruiec.com</a></td>
    </tr>
    <tr onmouseover=this.bgColor='#EEFEED'; onmouseout=this.bgColor='#ffffff';  bgcolor='#ffffff'>
      <td height="22" align="center">当前版本：</td>
      <td>1.31</td>
    </tr>
    <tr onmouseover=this.bgColor='#EEFEED'; onmouseout=this.bgColor='#ffffff';  bgcolor='#ffffff'>
      <td height="22" align="center">相关站点：</td>
      <td><a href="http://www.ruiec.cn" target="_blank">中瑞网络</a>&nbsp;&nbsp;<a href="http://www.ruiec.net" target="_blank">中瑞IDC</a></td>
    </tr>
  </table>
</div>

</body>
</html>
<%End Sub%>