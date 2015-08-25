<!--#include file="sdcms_check.asp"-->
<%
Dim sdcms,Sd_Table,title,Action
Action=Lcase(Trim(Request.QueryString("Action")))
Set Sdcms=New Sdcms_Admin
Sdcms.Check_admin
sdcms.Check_lever 23
Set Sdcms=Nothing
Title="蜘蛛来访"
Sd_Table="Sd_Spider"
Sdcms_Head
%>
<div class="sdcms_notice"><span>管理操作：</span><a href="?">蜘蛛来访</a></div>
<br>
<ul id="sdcms_sub_title">
	<li class="sub"><%=title%></li><li class="unsub"><a href="?action=del_all" onclick='return confirm("真的要删除?不可恢复!");'>清空记录</a></li>
</ul>
<div id="sdcms_right_b">
<%
Select Case Action
	Case "del":del
	Case "del_all":del_all
	Case Else:main
End Select
Db_Run
CloseDb

Sub Main
%>
<table border="0" align="center" cellpadding="3" cellspacing="1" class="table_b">
  <tr onmouseover="this.bgColor='#EEFEED';" onmouseout="this.bgColor='#ffffff';" bgcolor='#ffffff'>
    <td height="20" align="center" class="tdbg01">蜘蛛</td>
    <td align="center" bgcolor="#EEFEED" class="tdbg01">最后来访时间</td>
    <td align="center" class="tdbg01">总来访次数</td>
	<td align="center" class="tdbg01">操作</td>
  </tr>
  <%Dim Rs:Set Rs=Conn.Execute("Select title,Lastdate,hits From "&Sd_Table&""):DbQuery=DbQuery+1:IF Rs.Eof Then%>
  <tr bgcolor='#ffffff'>
    <td height="25" colspan="4" align="center">暂无来访记录</td>
  </tr>
  <%End IF:While Not Rs.Eof%>
  <tr onmouseover="this.bgColor='#EEFEED';" onmouseout="this.bgColor='#ffffff';" bgcolor='#ffffff'>
    <td height="25" align="center"><%=Rs(0)%></td>
    <td align="center"><%=Rs(1)%></td>
    <td align="center"><%=Rs(2)%></td>
	<td align="center"><a href="?action=del&id=<%=Rs(0)%>" onclick='return confirm("真的要删除?不可恢复!\n2天内的将会被保留!");'>删除</a></td>
  </tr>
  <%Rs.MoveNext:Wend:Rs.Close:Set Rs=Nothing%>
</table>
<%
End Sub

Sub Del
	Dim ID:ID=IsNum(Trim(Request.QueryString("ID")),0)
	Conn.Execute("Delete From "&Sd_Table&" where id in("&id&")")
	Go("?")
End Sub

Sub Del_All
	Conn.Execute("Delete From "&Sd_Table&"")
	Go("?")
End Sub
%>
</div>
</body>
</html>