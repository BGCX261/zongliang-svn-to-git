<!--#include file="sdcms_check.asp"-->
<%
Dim Sdcms,title,Action
Action=Lcase(Trim(Request.QueryString("Action")))
Set Sdcms=New Sdcms_Admin
Sdcms.Check_admin
Sdcms.Check_lever ""
Set Sdcms=Nothing
Title="缓存管理"
Sdcms_Head
%>
<div class="sdcms_notice"><span>管理操作：</span><a href="?"><%=title%></a></div>
<br>
<ul id="sdcms_sub_title">
	<li class="sub"><%=title%></li> 
</ul>
<div id="sdcms_right_b">
<%
Select Case Action
	Case "delall":delall
	Case Else:main
End Select
Db_Run
CloseDb
Sub main
%>
  <table border="0" align="center" cellpadding="3" cellspacing="1">
    <%IF Not Sdcms_Cache Then%>
    <tr bgcolor="#ffffff">
      <td height="25" align="center">系统未开启缓存，无需清理。</td>
    </tr>
	<%
	Else
	IF Application.Contents.Count=0 Then%>
    <tr onmouseover=this.bgColor='#EEFEED'; onmouseout=this.bgColor='#ffffff'; bgcolor='#ffffff'>
      <td height="25" align="center">没有缓存</td>
    </tr>
	<%Else%>
    <tr onmouseover=this.bgColor='#EEFEED'; onmouseout=this.bgColor='#ffffff';  bgcolor='#ffffff'>
	 <td height="25" style="word-break:break-all;">共有缓存：<%=Application.Contents.Count%>个</td>
    </tr>
	<tr bgcolor='#ffffff'>
      <td height="25"><input type="button" class="bnt" value="清空缓存" onClick="if(confirm('真的要删除?不可恢复!'))location.href='?action=delall';return false;"></td>
    </tr>
	<%End IF:End IF%>
  </table>
<%
End Sub

Sub DelAll
	Application.Contents.RemoveAll()
	Go("?")
End Sub
%>  
</div>
</body>
</html>