<!--#include file="sdcms_check.asp"-->
<%
Dim sdcms,Sd_Table,Sd_Table01,title,Classid,Action
Classid=IsNum(Trim(Request("Classid")),0)
Action=Lcase(Trim(Request("Action")))
Set Sdcms=New Sdcms_Admin
Sdcms.Check_Admin
title="评论管理"
Sd_Table="sd_comment"
Sd_Table01="sd_info"
Sdcms_Head
%>
<div class="sdcms_notice"><span>管理操作：</span><a href="?">评论管理</a></div>
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
	Case "add":sdcms.Check_lever 21:Add
	Case "save":sdcms.Check_lever 22:SaveDb
	Case Else:main
End Select
Db_Run
CloseDb
Set sdcms=Nothing
Sub Main
	Echo "<form name=""add"" action=""?"" method=""post"" onSubmit=""return confirm('确定要执行选定的操作吗？');"">"
	Dim Page,P,Rs,i,j,tj,num,InfoUrl
	IF Classid>0 Then tj="Infoid="&classid
	Page=IsNum(Trim(Request.QueryString("page")),1)
	Set P=New Sdcms_Page
	With P
	.Conn=Conn
	.PageNum=Page
	.Table="View_Comment"
	.Field="id,username,ispass,ip,adddate,content,ispass,infoid,title,classid,classurl,HtmlName"
	.Key="ID"
	.Where=tj
	.Order="ID Desc"
	.PageStart="?classid="&classid&"&Page="
	End With
	On Error ReSume Next
	Set Rs=P.Show
	IF Err Then
		Echo "没有评论"
		num=0
		Err.Clear
	End IF
	For I=1 To P.PageSize
		IF Rs.Eof Or Rs.Bof Then Exit For
	%>
	<table border="0" align="center" cellpadding="3" cellspacing="1" class="table_b">
	<tr> 
      <td class="title_bg" style="text-align:left"><span style="float:right"><%IF Rs(6)=0 then%><a href="?action=pass&id=<%=Rs(0)%>&classid=<%=Classid%>">通过验证</a><%Else%><a href="?action=nopass&id=<%=Rs(0)%>&classid=<%=Classid%>">取消验证</a><%End IF%> <a href="?action=add&id=<%=Rs(0)%>&classid=<%=classid%>">编辑</a> <a href="?action=del&id=<%=Rs(0)%>&classid=<%=classid%>" onclick='return confirm("真的要删除?不可恢复!");'>删除</a></span><input name="id"  type="checkbox" value="<%=rs(0)%>"> <%=Rs(1)%> 发表于：<%=Rs(4)%>　IP：<%=Rs(3)%></td>
   
    </tr>
    <tr onmouseover=this.bgColor='#EEFEED'; onmouseout=this.bgColor='#ffffff';  bgcolor='#ffffff'>
      <td style="word-break:break-all;line-height:25px;">
      <%
		Select Case Sdcms_Mode
			Case "0":InfoUrl=Sdcms_Root&"Info/View.Asp?ID="&Rs(9)
			Case "1":InfoUrl=Sdcms_Root&"Info/View_"&Rs(9)&Sdcms_FileTxt
			Case "2":InfoUrl=Sdcms_Root&Sdcms_HtmDir&Rs(10)&Rs(11)&Sdcms_FileTxt
		End Select
	  %>
	  所属信息：<a href="<%=InfoUrl%>" target="_blank"><%=Rs(8)%></a><br>
	  <%=Content_Encode(Rs(5))%></td>
    </tr>
	</table><br>
	<%
		Rs.MoveNext
	Next
	IF Len(Num)=0 Then    
	%>
	<table border="0" align="center" cellpadding="3" cellspacing="1" class="table_b">
	<tr>
      <td   class="tdbg" >
	  <input name="chkAll" type="checkbox" id="chkAll" onclick=CheckAll(this.form) value="checkbox"><label for="chkall">全选</label>  
              <select name="action">
			  <option>→操作</option>
			  <option value="pass">通过审核</option>
			  <option value="nopass">取消审核</option>
			  <option value="del">删除</option>
			  </select> 
             
      <input type="submit" class="bnt01" value="执行"></td>
    </tr>
	 
	<tr>
      <td class="tdbg content_page" align="center"><%Echo P.PageList%></td>
    </tr>
  </table>
<%
End IF
Set P=Nothing
End Sub

Sub Add
	Dim Rs,ID:ID=IsNum(Trim(Request.QueryString("ID")),0)
	Set Rs=Conn.Execute("Select content,ispass From "&Sd_Table&" where id="&id&"")
	DbQuery=DbQuery+1
	IF Rs.Eof Then
	Echo "请勿非法提交参数":Exit Sub
	End IF
	Echo Check_Add
%>
  <table width="98%" border="0" align="center" cellpadding="3" cellspacing="1">
  <form name="add" method="post" action="?action=save&id=<%=id%>&classid=<%=classid%>" onSubmit="return checkadd()">
    <tr>
      <td width="120" align="center" class="tdbg">评论内容：      </td>
      <td class="tdbg"><textarea name="t0" rows="10" class="inputs"><%=Content_Encode(Rs(0))%></textarea></td>
    </tr>
	<tr class="tdbg">
      <td align="center">属　性：</td>
      <td><input name="t1" id="t1" type="checkbox" value="1" checked="checked" /><label for="t1">通过验证</label></td>
    </tr>
    <tr class="tdbg">
	  <td>&nbsp;</td>
      <td><input name="Submit" type="submit" class="bnt" value="保 存"> <input type="button" onClick="history.go(-1)" class="bnt" value="返 回"></td>
    </tr>
	</form>
  </table>
<%
End Sub

Sub SaveDb
	Dim t0,t1,Rs,sql
	Dim ID:ID=IsNum(Trim(Request.QueryString("ID")),0)
	t0=Request.Form("t0")
	t1=IsNum(Trim(Request.Form("t1")),0)
	Set Rs=Server.CreateObject("adodb.recordset")
	Sql="Select Content,Ispass From "&Sd_Table&" Where ID="&ID
	Rs.Open Sql,Conn,1,3
	Rs.Update
	Rs(0)=t0
	Rs(1)=t1
	Rs.Update
	Rs.Close
	Set Rs=Nothing
	Go("?classid="&Classid&"")
End Sub

Sub Del
	Dim ID:Id=Trim(Request("ID"))
	IF Len(ID)>0 then
		ID=Split(ID,", ")
		Dim I,InfoId
		For I=0 To Ubound(ID)	
			AddLog sdcms_adminname,GetIp,"删除评论：编号为"&Clng(ID(I)) ,0
			InfoId=conn.execute("Select Infoid From "&Sd_Table&" Where id="&Clng(ID(I))&"")(0)
			Conn.Execute("Update "&Sd_Table01&" Set Comment_num=Comment_num-1 Where Id="&infoid&"")
			Conn.Execute("Delete From "&Sd_Table&" Where ID="&ID(i)&"")
		Next
	End IF
	Go("?classid="&Classid&"")
End Sub

Sub Pass(t0)
	Dim ID:Id=Trim(Request("ID"))
	ID=Re(ID," ","")
	Dim LogMsg
	IF t0=0 Then LogMsg="取消验证评论：编号为" Else LogMsg="通过验证评论：编号为"
	AddLog sdcms_adminname,GetIp,LogMsg&ID,0
	Conn.Execute("Update "&Sd_Table&" Set IsPass="&t0&" Where Id In("&ID&")")
	Go("?classid="&classid&"")
End Sub

Function Check_Add
	Check_Add="	<script>"&vbcrlf
	Check_Add=Check_Add&"	function checkadd()"&vbcrlf
	Check_Add=Check_Add&"	{"&vbcrlf
	Check_Add=Check_Add&"	if (document.add.t0.value=='')"&vbcrlf
	Check_Add=Check_Add&"	{"&vbcrlf
	Check_Add=Check_Add&"	alert('评论内容不能为空');"&vbcrlf
	Check_Add=Check_Add&"	document.add.t0.focus();"&vbcrlf
	Check_Add=Check_Add&"	return false"&vbcrlf
	Check_Add=Check_Add&"	}"&vbcrlf
	Check_Add=Check_Add&"	}"&vbcrlf
	Check_Add=Check_Add&"	</script>"&vbcrlf
End Function
%>  
</div>
</body>
</html>