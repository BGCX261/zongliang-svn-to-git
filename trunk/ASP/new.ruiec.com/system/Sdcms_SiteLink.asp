<!--#include file="sdcms_check.asp"-->
<%
Dim sdcms,Sd_Table,title,Action
Action=Lcase(Trim(Request("Action")))
Set Sdcms=New Sdcms_Admin
Sdcms.Check_admin
Select Case Action
	Case "add":title="添加内链"
	Case "edit":title="修改内链"
	Case Else:title="内链管理"
End Select
Sd_Table="sd_sitelink"
Sdcms_Head
%>

<div class="sdcms_notice"><span>管理操作：</span><a href="?action=add">添加内链</a>　┊　<a href="?">内链管理</a></div>
<br>
<ul id="sdcms_sub_title">
	<li class="sub"><%=title%></li> 
</ul>
<div id="sdcms_right_b">
<%
Select Case Action
	Case "add":sdcms.Check_lever 18:add
	Case "edit":sdcms.Check_lever 19:add
	Case "save":save
	Case "del":sdcms.Check_lever 20:del
	Case Else:main
End Select
Db_Run
CloseDb
Set Sdcms=Nothing
Sub Main
%>
  <table border="0" align="center" cellpadding="3" cellspacing="1" class="table_b">
    <form action="?" method="post" onSubmit="return confirm('确定要执行选定的操作吗？');">
	<tr>
	  <td width="30" class="title_bg">选择</td>
      <td class="title_bg" width="*">内链接</td>
      <td width="80" class="title_bg">窗口类别</td>
      <td width="80" class="title_bg">状态</td>
      <td width="80" class="title_bg">管理</td>
    </tr>
	<%
	Dim Page,P,Rs,i,num
	Page=IsNum(Trim(Request.QueryString("page")),1)
	Set P=New Sdcms_Page
	With P
	.Conn=Conn
	.PageNum=Page
	.Table=Sd_Table
	.Field="id,title,content,siteurl,linktype,ispass"
	.Key="ID"
	.Order="ordnum desc,ID Desc"
	.PageStart="?page="
	End With
	On Error ReSume Next
	Set Rs=P.Show
	IF Err Then
		Num=0
		Err.Clear
	End IF
	For I=1 To P.PageSize
		IF Rs.Eof Or Rs.Bof Then Exit For 
	%>
    <tr onmouseover=this.bgColor='#EEFEED'; onmouseout=this.bgColor='#ffffff';  bgcolor='#ffffff'>
	 <td height="25" align="center"><input name="id" type="checkbox" value="<%=Rs(0)%>"></td>
	  <td><a href="<%=Rs(3)%>" title="<%=rs(2)%>"><%=Rs(1)%></a></td>
	  <td align="center"><%=IIF(Rs(4)=1,"新","原")%>窗口</td>
	  <td align="center"><%=IIF(Rs(5)=1,"√","×")%></td>
      <td align="center"><a href="?action=edit&id=<%=rs(0)%>">编辑</a> <a href="?action=del&id=<%=Rs(0)%>" onclick='return confirm("真的要删除?不可恢复!");'>删除</a></td>
    </tr>
	<%
		Rs.MoveNext
	Next       
	%>
	<tr>
      <td colspan="5" class="tdbg" >
	 <input name="chkAll" type="checkbox" id="chkAll" onclick=CheckAll(this.form) value="checkbox"><label for="chkall">全选</label>  
              <select name="action">
			  <option value="del">删除</option>
			  </select> 
      <input type="submit" class="bnt01" value="执行">

</td>
    </tr>
	<%IF Len(Num)=0 Then%>
	<tr>
      <td colspan="5" class="tdbg content_page" align="center"><%Echo P.PageList%></td>
	</tr>
	<%End IF%>
	</form>
  </table>

<%
Set P=Nothing
End Sub

Sub Add
Dim ID:ID=IsNum(Trim(Request.QueryString("ID")),0)
IF ID>0 Then
	Dim Rs,Sql
	Sql="Select title,content,siteurl,ordnum,replacenum,linktype,ispass From "&Sd_Table&" Where id="&ID
	Set Rs=Conn.Execute(Sql)
	IF Rs.Eof Then
		Echo "请勿非法提交参数":Exit Sub
	Else
		Dim t0,t1,t2,t3,t4,t5,t6
		t0=Rs(0)
		t1=Rs(1)
		t2=Rs(2)
		t3=Rs(3)
		t4=Rs(4)
		t5=Rs(5)
		t6=Rs(6)
	End IF
	Rs.Close
	Set Rs=Nothing
Else
	t5=1
	t6=1
End IF
Echo Check_Add
%>
  <table width="98%" border="0" align="center" cellpadding="3" cellspacing="1">
  <form name="add" method="post" action="?action=save&id=<%=id%>" onSubmit="return checkadd()">
    <tr>
      <td width="120" align="center" class="tdbg">名 称：      </td>
      <td class="tdbg"><input name="t0" type="text" class="input" id="t0" size="40" value="<%=t0%>"></td>
    </tr>
    <tr class="tdbg">
      <td align="center">提 示：</td>
      <td><input name="t1" type="text" class="input" id="t1" size="40" value="<%=t1%>">　<span>提示文字</span></td>
    </tr>
	<tr class="tdbg">
      <td align="center">链 接：</td>
      <td><input name="t2" type="text" class="input" id="t2" size="40" value="<%=t2%>">　<span>请填写完整路径 如：http://www.sdcms.cn</span></td>
    </tr>
    <tr class="tdbg">
      <td align="center">优 先：</td>
      <td><input name="t3" type="text" class="input" id="t3" size="40" value="<%=t3%>" onKeyUp="value=value.replace(/[^\d]/g,'');"  onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''));">　<span>数字越大越优先</span></td>
    </tr>
	<tr class="tdbg">
      <td align="center">次 数：</td>
      <td><input name="t4" type="text" class="input" id="t4" size="40" value="<%=t4%>" onKeyUp="value=value.replace(/[^\d]/g,'');"  onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''));">　<span>0为替换全部</span></td>
    </tr>
	<tr class="tdbg">
      <td align="center">窗 口：</td>
      <td><input name="t5" type="radio" value="0" <%=IIF(t5=0,"checked","")%> id="t5_0"><label for="t5_0">原窗</label> <input name="t5" type="radio" value="1" <%=IIF(t5=1,"checked","")%> id="t5_1"><label for="t5_1">新窗</label></td>
    </tr>
	<tr class="tdbg">
      <td align="center">状 态：</td>
      <td><input name="t6" type="radio" value="1" <%=IIF(t6=1,"checked","")%> id="t6_0"><label for="t6_0">启用</label> <input name="t6" type="radio" value="0" <%=IIF(t6=0,"checked","")%> id="t6_1"><label for="t6_1">关闭</label></td>
    </tr>
    <tr class="tdbg">
	  <td>&nbsp;</td>
      <td><input type="submit" class="bnt" value="保存设置"> <input type="button" onClick="history.go(-1)" class="bnt" value="放弃返回"></td>
    </tr>
	</form>
  </table>
<%
End Sub

Sub Save
	Dim ID:ID=IsNum(Trim(Request.QueryString("ID")),0)
	Dim t0,t1,t2,t3,t4,t5,t6,Rs,Sql,LogMsg
	t0=Trim(Request.Form("t0"))
	t1=Trim(Request.Form("t1"))
	t2=Trim(Request.Form("t2"))
	t3=IsNum(Trim(Request.Form("t3")),0)
	t5=IsNum(Trim(Request.Form("t5")),0)
	t6=IsNum(Trim(Request.Form("t6")),0)
	t4=IsNum(Trim(Request.Form("t4")),0)
	IF ID=0 Then sdcms.Check_lever 18 Else sdcms.Check_lever 19
	Set Rs=Server.CreateObject("adodb.recordset")
	Sql="Select title,content,siteurl,ordnum,linktype,ispass,replacenum From "&Sd_Table
	IF ID>0 Then Sql=Sql&" Where id="&ID
	Rs.Open Sql,Conn,1,3
	IF ID=0 Then 
		Rs.Addnew 
	Else 
		Rs.Update 
	End IF
	Rs(0)=Left(t0,50)
	Rs(1)=Left(t1,255)
	Rs(2)=Left(t2,255)
	Rs(3)=Left(t3,50)
	Rs(4)=Left(t5,50)
	Rs(5)=Left(t6,50)
	Rs(6)=Left(t4,50)
	Rs.Update
	Rs.Close
	IF ID=0 Then LogMsg="添加内链接" Else LogMsg="修改内链接"
	AddLog sdcms_adminname,GetIp,LogMsg&t0,0
	Del_Cache "sitelinks"
	Go("?") 
End Sub

Sub Del
	Dim ID:ID=Trim(Request("ID"))
	ID=Re(ID," ","")
	IF Len(ID)>0 Then
		AddLog sdcms_adminname,GetIp,"删除内链接：编号为"&id,0
		Conn.Execute("Delete from "&Sd_Table&" where id in("&id&")")
	End IF
	Del_Cache "sitelinks"
	Go("?")
End Sub

Function Check_Add
	Check_Add="	<script>"&vbcrlf
	Check_Add=Check_Add&"	function checkadd()"&vbcrlf
	Check_Add=Check_Add&"	{"&vbcrlf
	Check_Add=Check_Add&"	if (document.add.t0.value=='')"&vbcrlf
	Check_Add=Check_Add&"	{"&vbcrlf
	Check_Add=Check_Add&"	alert('内链接名称不能为空');"&vbcrlf
	Check_Add=Check_Add&"	document.add.t0.focus();"&vbcrlf
	Check_Add=Check_Add&"	return false"&vbcrlf
	Check_Add=Check_Add&"	}"&vbcrlf
	Check_Add=Check_Add&"	if (document.add.t2.value=='')"&vbcrlf
	Check_Add=Check_Add&"	{"&vbcrlf
	Check_Add=Check_Add&"	alert('链接不能为空');"&vbcrlf
	Check_Add=Check_Add&"	document.add.t2.focus();"&vbcrlf
	Check_Add=Check_Add&"	return false"&vbcrlf
	Check_Add=Check_Add&"	}"&vbcrlf
	Check_Add=Check_Add&"	}"&vbcrlf
	Check_Add=Check_Add&"	</script>"&vbcrlf
End Function
%>  
</div>
</body>
</html>