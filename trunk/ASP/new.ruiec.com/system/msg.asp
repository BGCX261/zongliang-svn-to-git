<!--#include file="sdcms_check.asp"-->
<%
Dim Sdcms,title,Sd_Table,Sd_Table02,Sd_Table03,Stype,keyword,Publish_Where,Tj,T,Action,Classid,Page
t=IsNum(Trim(Request.QueryString("t")),0)
Action=Lcase(Trim(Request("Action")))
Classid=IsNum(Trim(Request("Classid")),0)
KeyWord=FilterText(Trim(Request("KeyWord")),0)
Page=IsNum(Trim(Request.QueryString("page")),1)
Set Sdcms=New Sdcms_Admin
Sdcms.Check_admin
Select Case Action
	Case "v":title="查看信息"
	Case Else:stype="main":title="反馈管理"
End Select
Sd_Table="Sd_Info"
Sd_Table02="Sd_Comment"
Sd_Table03="Sd_Digg"
Sdcms_Head
IF t=0 Then
	publish_where=" Userid>=0 "
Else
	publish_where=" Userid<0 "
	title="投稿管理"
End IF
%>

<ul id="sdcms_sub_title">
	<li class="sub"><a<%if stype<>"main" then%> href="javascript:void(0)" onClick="selectTag('tagContent0',this)"<%end if%>><%=title%></a></li>
	<%if stype<>"main" then%>
	<li class="unsub"><a href="msg.asp">返回列表</a></li>
	<%end if%>
</ul>
<div id="sdcms_right_b">
<%
Select Case Action
	Case "v":sdcms.Check_lever 13:view
	Case "del":sdcms.Check_lever 14:del
	Case "yd":sdcms.Check_lever 15:Changeyd
	Case "wd":sdcms.Check_lever 16:Changewd
	Case "ts":sdcms.Check_lever 17:Changets
	Case "jj":sdcms.Check_lever 18:Changejj
	Case Else:main
End Select
Db_Run
CloseDb
Set Sdcms=Nothing
Sub Main	
%>
  <table border="0" align="center" cellpadding="3" cellspacing="1" class="table_b">
   <form name="add" action="?t=<%=t%>&Page=<%=Page%>" method="post" onSubmit="return confirm('确定要执行选定的操作吗？');"> 
	<tr>
	  <td width="30" class="title_bg">选择</td>
	  <td width="30" class="title_bg">ID</td>
      <td class="title_bg">姓名</td>
      <td width="200" class="title_bg">公司</td>
	  <td width="80" class="title_bg">电话</td>
	  <td width="40" class="title_bg">审核</td>
	  <td width="100" class="title_bg">IP</td>
	  <td width="150" class="title_bg">浏览器</td>
	  <td width="80" class="title_bg">操作系统</td>
	  <td width="130" class="title_bg">时间</td>
      <td width="100" class="title_bg">管理</td>
    </tr>
	<%
	IF Classid<>0 Then tj=" And Classid In("&Get_Son_Classid(Classid)&") "
	Dim Where
	Where=""&publish_where&" And "
	
	IF Sdcms_DataType Then
		Where=Where&"(InStr(1,LCase(Title),LCase('"&keyword&"'),0)<>0 or InStr(1,LCase(id),LCase('"&keyword&"'),0)<>0) "
	Else
		Where=Where&"(title like '%"&keyword&"%' Or id like '%"&keyword&"%')"
	End IF
		
	IF Load_Cookies("sdcms_admin")=0 Then
		Dim SdcmsAdmin
		Set SdcmsAdmin=New Sdcms_Admin
		Where=Where&" And "&SdcmsAdmin.Check_Info_Lever&""
		Set SdcmsAdmin=Nothing
	End IF
	
	Where=Where&" "&tj&" "
	
	Dim P,Rs,I,Num,Url
	
	Set P=New Sdcms_Page
	With P
	.Conn=Conn
	.PageNum=Page
	.Table="sd_msg"
	.Field="*"
	.Key="ID"
	.Where=""
	.Order="addtime desc,statu,id desc"
	.PageStart=""
	End With
	On Error ReSume Next
	Set Rs=P.Show
	IF Err Then
		Num=0
		Err.Clear
	End IF
	For I=1 To P.PageSize
		IF Rs.Eof Or Rs.Bof Then Exit For
		Select Case Sdcms_Mode
			Case "2","1":Url=Rs(12)&Rs(13)
			Case Else:Url=Rs(0)
		End Select
		Dim strong,strongs
		strong = ""
		strongs = ""
		If Rs("statu")="0" Then
			strong = "<strong>"
			strongs = "</strong>"
		End If
	%>
   <tr onmouseover=this.bgColor='#EEFEED'; onmouseout=this.bgColor='#ffffff';  bgcolor='#ffffff'>
	  <td height="25" align="center"><input name="id" type="checkbox" value="<%=Rs("ID")%>"></td>
      <td align="center"><%=strong%><%=Rs("ID")%><%=strongs%></td>
	  <td align="center"><%=strong%><%=Rs("username")%><%=strongs%></td>
	  <td align="center"><%=strong%><%=rs("company")%><%=strongs%></td>
	  <td align="center"><%=strong%><%=Rs("tel")%><%=strongs%></td>
	  <td align="center"><%=strong%><%=IIF(Rs("ispass")="0","<font color='red'>未通过</font>","<font color='#0099CC'>已通过</font>")%><%=strongs%></td>
	  <td align="center"><%=strong%><%=Rs("addip")%><%=strongs%></td>
	  <td align="center"><%=strong%><%=Rs("addbs")%><%=strongs%></td>
	  <td align="center"><%=strong%><%=Rs("addos")%><%=strongs%></td>
	  <td align="center"><%=strong%><%=Rs("addtime")%><%=strongs%></td>
      <td align="center"><a href="?action=v&id=<%=rs("ID")%>">查看</a> <a href="?action=del&id=<%=rs("ID")%>" onclick='return confirm("真的要删除?不可恢复!");'>删除</a></td>
    </tr>
	<%
		Rs.MoveNext
	Next       
	%>
	<tr>
      <td colspan="11" class="tdbg" align="left">
		<input name="chkAll" type="checkbox" id="chkAll" onclick=CheckAll(this.form) value="checkbox"><label for="chkall">全选</label>
		<select name="action" onchange="if(this.value=='movelist'){t0.disabled=false}else{t0.disabled=true};">
			<option>→操作</option>
			<option value="yd">设为已读</option>
			<option value="wd">设为未读</option>
			<option>----------</option>
			<option value="ts">通过审核</option>
			<option value="jj">拒绝审核</option>
			<option>----------</option>
			<option value="del">删除信息</option>
		</select>
		<input type="submit" class="bnt01" value="执行" />
	  </td>
    </tr>
	<%IF Len(Num)=0 Then%>
	<tr>
      <td colspan="11" class="tdbg content_page" align="center"><%Echo P.PageList%></td>
	</tr>
	<%End IF%>
	</form>
  </table>
<%
Set P=Nothing
End Sub

Sub Del
	Dim ID:ID=Trim(Request("ID"))
	IF Len(ID)>0 Then
		ID=Split(ID,", ")
		Dim I
		For I=0 To Ubound(ID)
			Conn.Execute("Delete From sd_msg Where ID="&Clng(ID(I))&"")
		Next
	End IF
	Go "msg.asp"
End Sub

'------------------------
Sub Changeyd
	Dim ID:ID=Trim(Request("ID"))
	IF Len(ID)>0 Then
		ID=Split(ID,", ")
		Dim I
		For I=0 To Ubound(ID)
			Conn.Execute("UPDATE sd_msg SET statu = '1' WHERE ID="&Clng(ID(I))&"")
		Next
	End IF
	Go "msg.asp"
End Sub

Sub Changewd
	Dim ID:ID=Trim(Request("ID"))
	IF Len(ID)>0 Then
		ID=Split(ID,", ")
		Dim I
		For I=0 To Ubound(ID)
			Conn.Execute("UPDATE sd_msg SET statu = '0' WHERE ID="&Clng(ID(I))&"")
		Next
	End IF
	Go "msg.asp"
End Sub

Sub Changets
	Dim ID:ID=Trim(Request("ID"))
	IF Len(ID)>0 Then
		ID=Split(ID,", ")
		Dim I
		For I=0 To Ubound(ID)
			Conn.Execute("UPDATE sd_msg SET ispass = '1' WHERE ID="&Clng(ID(I))&"")
		Next
	End IF
	Go "msg.asp"
End Sub

Sub Changejj
	Dim ID:ID=Trim(Request("ID"))
	IF Len(ID)>0 Then
		ID=Split(ID,", ")
		Dim I
		For I=0 To Ubound(ID)
			Conn.Execute("UPDATE sd_msg SET ispass = '0' WHERE ID="&Clng(ID(I))&"")
		Next
	End IF
	Go "msg.asp"
End Sub

Sub view
	Dim ID:ID=Trim(Request("ID"))
	IF Len(ID)>0 Then
		If Request.Form("vpass")<>"" Then
			Conn.Execute("UPDATE sd_msg SET ispass = '"&Clng(Request.Form("vpass"))&"' WHERE ID = "&Clng(ID)&"")
			Go "msg.asp"
		End If

		Dim Rs
		Set Rs = Conn.Execute("SELECT * From sd_msg Where ID="&Clng(ID)&"")
		If Rs("statu")="0" Then 
			Conn.Execute("Update sd_msg Set statu='1' Where ID="&Clng(ID)&"")
		End If
%>
	<style>.input{width:300px}</style>
	<form id="myFM" method="post" action="">
	<table width="98%" border="0" align="center" cellpadding="3" cellspacing="1" id="tagContent1" class="table_b">
		<tr class="tdbg">
			<td align="center" width="120">ID：</td>
			<td><input value="<%=Rs("ID")%>" type="text" class="input" readonly="readonly" style="color:#666"></td>
		</tr>
		<tr class="tdbg">
			<td align="center" width="120">姓　名：</td>
			<td><input value="<%=Rs("username")%>" type="text" class="input" readonly="readonly" style="color:#666"></td>
		</tr>
		<tr class="tdbg">
			<td align="center" width="120">公  司：</td>
			<td><input value="<%=Rs("company")%>" type="text" class="input" readonly="readonly" style="color:#666"></td>
		</tr>
		<tr class="tdbg">
			<td align="center" width="120">电　话：</td>
			<td><input value="<%=Rs("tel")%>" type="text" class="input" readonly="readonly" style="color:#666"></td>
		</tr>
		<tr class="tdbg">
			<td align="center" width="120">内  容：</td>
			<td><textarea readonly="readonly" class="input" style="width:60%;height:150px;"><%=Rs("content")%></textarea></td>
		</tr>
		<tr class="tdbg">
			<td align="center" width="120">时　间：</td>
			<td><input value="<%=Rs("addtime")%>" type="text" class="input" readonly="readonly" style="color:#666"></td>
		</tr>
		<tr class="tdbg">
			<td align="center" width="120">IP：</td>
			<td><input value="<%=Rs("addip")%>" type="text" class="input" readonly="readonly" style="color:#666"></td>
		</tr>
		<tr class="tdbg">
			<td align="center" width="120">操作系统：</td>
			<td><input value="<%=Rs("addos")%>" type="text" class="input" readonly="readonly" style="color:#666"></td>
		</tr>
		<tr class="tdbg">
			<td align="center" width="120">浏览器：</td>
			<td><input value="<%=Rs("addbs")%>" type="text" class="input" readonly="readonly" style="color:#666"></td>
		</tr>
		<tr class="tdbg">
			<td align="center" width="120">其它信息：</td>
			<td><textarea readonly="readonly" class="input" style="width:60%;height:150px;"><%=Rs("addother")%></textarea></td>
		</tr>
	</table>
	<table width="98%" border="0" align="center" cellpadding="3" cellspacing="1" >
		<tr class="tdbg">
			<td width="100">&nbsp;</td>
			<td>
<%			If Rs("ispass")="0" Then %>
			<input type="hidden" name="vpass" value="1" />
			<input type="submit" class="bnt" value="通过审核" onclick="return confirm('确定要通过该留言吗?');" />
<%			Else %>
			<input type="hidden" name="vpass" value="0" />
			<input type="submit" class="bnt" value="拒绝审核" onclick="return confirm('确定要拒绝该留言吗?');" />
<%			End If %>
			<a href="msg.asp">返回</a>
		    </td>
		</tr>
	</table>
	</form>
<%
	Else
		Go "msg.asp"
	End IF

End Sub
%>
</div>
</body>
</html>