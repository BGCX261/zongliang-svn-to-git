<!--#include file="sdcms_check.asp"-->
<!--#include file="../Plug/Coll_Info/Conn.asp"-->
<%
Dim sdcms,title,Sd_Table,Action
Action=Lcase(Trim(Request.QueryString("Action")))
Set Sdcms=New Sdcms_Admin
Sdcms.Check_admin
sdcms.Check_lever 22
Set Sdcms=Nothing
title="采集设置"
Sd_Table="Sd_Coll_Config"
Sdcms_Head
%>
<div class="sdcms_notice"><span>管理操作：</span><a href="Sdcms_Coll_Config.asp">采集设置</a>　┊　<a href="Sdcms_Coll_Item.asp">采集管理</a> (<a href="Sdcms_Coll_Item.asp?action=add">添加</a>)　┊　<a href="Sdcms_Coll_Filters.asp">过滤管理</a> (<a href="Sdcms_Coll_Filters.asp?action=add">添加</a>)　┊　<a href="Sdcms_Coll_History.asp">历史记录</a></div>
<br>
<ul id="sdcms_sub_title">
	<li class="sub"><%=title%></li>	
</ul>
<div id="sdcms_right_b">
<%
Select Case Lcase(action)
Case "save":Collection_Data:Save
Case Else:Collection_Data:main
End Select
Db_Run
CloseDb


Sub Main
Dim Rs
Set Rs=Coll_Conn.Execute("select Timeout,MaxFileSize,FileExtName,UpfileDir from "&Sd_Table&" where id=1")
DbQuery=DbQuery+1
IF Rs.Eof Then
	Echo "请勿非法提交参数":Exit Sub
End IF
Echo Check_Add
%>
<form name="add" method="post" action="?action=save" onSubmit="return checkadd()">
  <table width="98%" border="0" align="center" cellpadding="3" cellspacing="1">
    <tr>
      <td width="120" align="center" class="tdbg">超时设置：      </td>
      <td class="tdbg"><input name="t0" type="text" class="input" value="<%=rs(0)%>" size="30">　<span>默认64秒 如果128K的数据64秒还下载不完(按每秒2K保守估算)，则超时。</span></td>
    </tr>
	<tr class="tdbg">
      <td align="center">附件大小：      </td>
      <td><input name="t1" type="text" class="input" value="<%=rs(1)%>"  size="30">　<span>单位：KB，允许保存文件的大小，不限制请输入“0”</span></td>
    </tr>
	<tr class="tdbg">
      <td align="center">附件类型：      </td>
      <td><input name="t2" type="text" class="input" value="<%=rs(2)%>"  size="30">　<span>采集保存文件类型,格式:Rm|swf|rar</span></td>
    </tr>
	<tr class="tdbg">
      <td align="center">附件目录：      </td>
      <td><input name="t3" type="text" class="input" value="<%=rs(3)%>"  size="30">　<span>采集保存目录,后面不需要带"/"符号</span></td>
    </tr>
	<tr class="tdbg">
	  <td>&nbsp;</td>
      <td><input name="Submit" type="submit" class="bnt" value="保 存"></td>
    </tr>
	</table>
<%
Rs.Close
Set Rs=Nothing
End Sub

Sub Save
	Dim t0,t1,t2,t3,Rs,Sql
	t0=IsNum(Trim(Request.Form("t0")),64)
	t1=IsNum(Trim(Request.Form("t1")),0)
	t2=Trim(Request.Form("t2"))
	t3=FilterText(Trim(Request.Form("t3")),0)
	Set Rs=Server.CreateObject("adodb.recordset")
	Sql="Select Timeout,MaxFileSize,FileExtName,UpfileDir From "&Sd_Table&" where id=1"
	Rs.Open Sql,Coll_Conn,1,3
	Rs.update
		Rs(0)=Left(t0,50)
		Rs(1)=Left(t1,50)
		Rs(2)=Left(t2,50)
		Rs(3)=Left(t3,50)
	Rs.Update
	Rs.Close
	Set Rs=Nothing
	Del_Cache("Get_Coll_Config")
	Alert "保存成功！","?"
End Sub

Function Check_Add
	Check_Add="	<script>"&vbcrlf
	Check_Add=Check_Add&"	function checkadd()"&vbcrlf
	Check_Add=Check_Add&"	{"&vbcrlf
	Check_Add=Check_Add&"	if (document.add.t0.value=='')"&vbcrlf
	Check_Add=Check_Add&"	{"&vbcrlf
	Check_Add=Check_Add&"	alert('超时设置不能为空');"&vbcrlf
	Check_Add=Check_Add&"	document.add.t0.focus();"&vbcrlf
	Check_Add=Check_Add&"	return false"&vbcrlf
	Check_Add=Check_Add&"	}"&vbcrlf
	Check_Add=Check_Add&"	if (document.add.t1.value=='')"&vbcrlf
	Check_Add=Check_Add&"	{"&vbcrlf
	Check_Add=Check_Add&"	alert('附件大小不能为空');"&vbcrlf
	Check_Add=Check_Add&"	document.add.t1.focus();"&vbcrlf
	Check_Add=Check_Add&"	return false"&vbcrlf
	Check_Add=Check_Add&"	}"&vbcrlf
	Check_Add=Check_Add&"	if (document.add.t2.value=='')"&vbcrlf
	Check_Add=Check_Add&"	{"&vbcrlf
	Check_Add=Check_Add&"	alert('附件类型不能为空');"&vbcrlf
	Check_Add=Check_Add&"	document.add.t2.focus();"&vbcrlf
	Check_Add=Check_Add&"	return false"&vbcrlf
	Check_Add=Check_Add&"	}"&vbcrlf
	Check_Add=Check_Add&"	if (document.add.t3.value=='')"&vbcrlf
	Check_Add=Check_Add&"	{"&vbcrlf
	Check_Add=Check_Add&"	alert('附件目录不能为空');"&vbcrlf
	Check_Add=Check_Add&"	document.add.t3.focus();"&vbcrlf
	Check_Add=Check_Add&"	return false"&vbcrlf
	Check_Add=Check_Add&"	}"&vbcrlf
	Check_Add=Check_Add&"	}"&vbcrlf
	Check_Add=Check_Add&"	</script>"&vbcrlf
End Function
%>  
</div>
</body>
</html>