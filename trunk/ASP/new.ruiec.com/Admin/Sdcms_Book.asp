<!--#include file="sdcms_check.asp"-->
<%
Dim sdcms,Sd_Table,title,Action,Classid
Classid=IsNum(Trim(Request("Classid")),0)
Action=Lcase(Trim(Request("Action")))
Set sdcms=New Sdcms_Admin
sdcms.Check_admin
classid=IsNum(classid,0)
Select Case Action
	Case "replay":title="回复留言"
	Case Else:title="留言管理"
End Select
Sd_Table="Sd_Book"
Sdcms_Head
%>
<div class="sdcms_notice"><span>管理操作：</span><a href="?">留言管理</a></div>
<br>
 
<ul id="sdcms_sub_title">
	<li class="sub"><%=title%></li>
</ul>
<div id="sdcms_right_b">
<%
Select Case Action
	Case "del":sdcms.Check_lever 23:del
	Case "pass":sdcms.Check_lever 22:pass(1)
	Case "nopass":sdcms.Check_lever 22:pass(0)
	Case "replay":sdcms.Check_lever 22:replay
	Case "save":sdcms.Check_lever 22:save
	Case Else:main
End Select
Db_Run
CloseDb
Set Sdcms=Nothing

Sub Main
	Echo "<form name=""add"" action=""?"" method=""post""  onSubmit=""return confirm('确定要执行选定的操作吗？');"">"
	Dim Page,P,Rs,i,j,tj,num
	Page=IsNum(Trim(Request.QueryString("page")),1)
	Set P=New Sdcms_Page
	With P
	.Conn=Conn
	.PageNum=Page
	.Table=Sd_Table
	.Field="id,username,ispass,ip,adddate,content,ispass,recontent"
	.Key="ID"
	.Where=tj
	.Order="ID Desc"
	.PageStart="?page="
	End With
	On Error ReSume Next
	Set Rs=P.Show
	IF Err Then
		Echo "没有留言"
		num=0
		Err.Clear
	End IF
	For I=1 To P.PageSize
		IF Rs.Eof Or Rs.Bof Then Exit For
	%>
	<table border="0" align="center" cellpadding="3" cellspacing="1" class="table_b">
	<tr> 
      <td class="title_bg" style="text-align:left"><span style="float:right"><a href="?action=replay&id=<%=rs(0)%>">回复</a> <%if rs(6)=0 then%><a href="?action=pass&id=<%=rs(0)%>">通过验证</a><%else%><a href="?action=nopass&id=<%=rs(0)%>">取消验证</a><%end IF%> <a href="?action=del&id=<%=rs(0)%>" onclick='return confirm("真的要删除?不可恢复!");'>删除</a></span><input name="id" type="checkbox" value="<%=rs(0)%>"> <%=rs(1)%> 发表于：<%=rs(4)%>　IP：<%=rs(3)%></td>
    </tr>
    <tr onmouseover=this.bgColor='#EEFEED'; onmouseout=this.bgColor='#ffffff';  bgcolor='#ffffff'>
      <td style="word-break:break-all;" class="tdbg"><%=Content_Encode(rs(5))%><%IF rs(7)<>"" then%><br><b>回复</b>：<%=Content_Encode(rs(7))%><%end IF%></td>
    </tr>
	</table><br>
	<%
		Rs.MoveNext
	Next
	IF Len(Num)=0 Then    
	%>
	<table border="0" align="center" cellpadding="3" cellspacing="1" class="table_b">
	<tr>
      <td class="tdbg" >
	  <input name="chkAll" type="checkbox" id="chkAll" onclick=CheckAll(this.form) value="checkbox"><label for="chkall">全选</label> 
              <select name="action">
			  <option>→操作</option>
			  <option value="pass">通过审核</option>
			  <option value="nopass">取消审核</option>
			  <option value="del">删除</option>
			  </select> 
             
      <input type="submit" class="bnt01" value="执行">

</td>
    </tr>
	<tr>
      <td class="tdbg content_page" align="center"><%Echo P.PageList%></td>
    </tr>
  </table>
<%
End IF
Set P=Nothing
End sub

Sub Replay
	Dim Rs,ID:ID=IsNum(Trim(Request.QueryString("ID")),0)
	Set Rs=Conn.Execute("select id,content,recontent,ispass from "&Sd_Table&" where id="&id&"")
	DbQuery=DbQuery+1
	IF Rs.Eof Then
	Echo "请勿非法提交参数":Exit Sub
	End IF
	Echo Check_Add
%>
  <table width="98%" border="0" align="center" cellpadding="3" cellspacing="1">
  <form name="add" method="post" action="?action=save&id=<%=id%>" onSubmit='return checkadd()'>
    <tr>
      <td width="120" align="center" class="tdbg">内　容：      </td>
      <td class="tdbg"><textarea name="t0" rows="10" class="inputs"><%=Content_Encode(Rs(1))%></textarea></td>
    </tr>
   <tr class="tdbg">
      <td align="center">回　复：</td>
      <td><textarea name="t1" rows="10" class="inputs"><%=Content_Encode(Rs(2))%></textarea></td>
    </tr>
	<tr class="tdbg">
      <td align="center">属　性：</td>
      <td><input name="t2" id="t2" type="checkbox" value="1" checked="checked" /><label for="t2">通过验证</label></td>
    </tr>
    <tr class="tdbg">
	  <td>&nbsp;</td>
      <td><input name="Submit" type="submit" class="bnt" value="保 存"> <input type="button" onClick="history.go(-1)" class="bnt" value="返 回"></td>
    </tr>
	</form>
  </table>
<%
End Sub

Sub Save
	Dim t0,t1,t2,rs,sql
	Dim ID:ID=IsNum(Trim(Request.QueryString("ID")),0)
	t0=Request.Form("t0")
	t1=Request.Form("t1")
	t2=IsNum(Trim(Request.Form("t2")),0)
	Set Rs=Server.CreateObject("adodb.recordset")
	Sql="Select content,recontent,Ispass From "&Sd_Table&" Where ID="&ID
	Rs.Open Sql,Conn,1,3
	Rs.Update
	Rs(0)=t0
	Rs(1)=t1
	Rs(2)=t2
	Rs.Update
	Rs.Close
	Set Rs=Nothing
	AddLog sdcms_adminname,GetIp,"回复留言",0
	Go("?")
End Sub

Sub Del
	Dim ID:ID=Trim(Request("ID"))
	ID=Re(ID," ","")
	IF Len(ID)>0 Then
		ID=Re(ID," ","")
		AddLog sdcms_adminname,GetIp,"删除留言：编号为"&id,0
		Conn.Execute("Delete from "&Sd_Table&" Where Id in("&id&")")
	End if
	Go("?")
End Sub

Sub Pass(t0)
	Dim ID:ID=Trim(Request("ID"))
	ID=Re(ID," ","")
	Dim LogMsg
	IF t0=0 Then LogMsg="取消验证留言：编号为" Else LogMsg="通过验证留言：编号为"
	AddLog sdcms_adminname,GetIp,LogMsg&id,0
	Conn.Execute("Update "&Sd_Table&" Set IsPass="&t0&" Where Id In("&id&")")
	Go("?")
End Sub

Function Check_Add
	Check_Add="	<script>"&vbcrlf
	Check_Add=Check_Add&"	function checkadd()"&vbcrlf
	Check_Add=Check_Add&"	{"&vbcrlf
	Check_Add=Check_Add&"	if (document.add.t1.value=='')"&vbcrlf
	Check_Add=Check_Add&"	{"&vbcrlf
	Check_Add=Check_Add&"	alert('回复内容不能为空');"&vbcrlf
	Check_Add=Check_Add&"	document.add.t1.focus();"&vbcrlf
	Check_Add=Check_Add&"	return false"&vbcrlf
	Check_Add=Check_Add&"	}"&vbcrlf
	Check_Add=Check_Add&"	}"&vbcrlf
	Check_Add=Check_Add&"	</script>"&vbcrlf
End Function
%>  
</div>
</body>
</html>