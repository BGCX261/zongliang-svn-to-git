<!--#include file="sdcms_check.asp"-->
<%
Dim sdcms,Sd_Table,title
Set Sdcms=New Sdcms_Admin
Sdcms.Check_admin
Dim Action:Action=Lcase(Trim(Request("Action")))
Select Case action
	Case "add":title="添加单页"
	Case "edit":title="修改单页"
	Case Else:title="单页管理"
End Select
Sd_Table="Sd_Other"
Sdcms_Head
%>
<div class="sdcms_notice"><span>管理操作：</span><a href="?action=add">添加单页</a>　┊　<a href="?">单页管理</a></div>
<br>
<ul id="sdcms_sub_title">
	<li class="sub"><%=title%></li>
</ul>
<div id="sdcms_right_b">
<%
Select Case Action
	Case "add":sdcms.Check_lever 15:add
	Case "edit":sdcms.Check_lever 16:add
	Case "save":save
	Case "up":sdcms.Check_lever 16:up
	Case "down":sdcms.Check_lever 16:down
	Case "makehtml":sdcms.Check_lever 16:makehtml
	Case "del":sdcms.Check_lever 17:del
	Case Else:Main
End Select
Db_Run
CloseDb
Set Sdcms=Nothing

Sub Main
%>
  <table border="0" align="center" cellpadding="3" cellspacing="1" class="table_b">
    <form name="add" action="?" method="post" onSubmit="return confirm('确定要执行选定的操作吗？');">
	<tr>
	  <td width="30" class="title_bg">选择</td>
	  <td width="60" class="title_bg">编号</td>
      <td width="*" class="title_bg">栏目名称</td>
	  <td width="80" class="title_bg">排序</td>
      <td width="120" class="title_bg">管理</td>
    </tr>
	<%
	Dim Rs,Sql,Rs1,Url
	Sql="Select ID,Title,Ordnum,Followid,PageDir,HtmlName From "&Sd_Table&" Where Followid=0 Order By Ordnum Desc"
	Set Rs=Conn.Execute(Sql)
	DbQuery=DbQuery+1
	While Not Rs.Eof
	Select Case Sdcms_Mode
		Case "2":Url=Rs(4)&Rs(5)
		Case Else:Url=Rs(0)
	End Select
	%>
	<tr onmouseover=this.bgColor='#EEFEED'; onmouseout=this.bgColor='#ffffff';  bgcolor='#ffffff'>
	  <td height="25" align="center"><input name="ID" type="checkbox" value="<%=Rs(0)%>"></td>
	  <td align="center"><%=Rs(0)%></td>
      <td><a href="<%=Get_Link(Sd_Table,Url)%>" target="_blank"><%=Rs(1)%></a></td>
	  <td align="center"><a href="?action=up&id=<%=Rs(0)%>&ordnum=<%=Rs(2)%>&followid=<%=Rs(3)%>">↑</a> <a href="?action=down&id=<%=Rs(0)%>&ordnum=<%=Rs(2)%>&followid=<%=Rs(3)%>">↓</a></td>
      <td align="center"><%IF Sdcms_Mode=2 Then%><a href="?action=makehtml&id=<%=Rs(0)%>">生成</a> <%End IF%><a href="?action=edit&id=<%=Rs(0)%>">编辑</a> <a href="?action=del&id=<%=Rs(0)%>" onclick="return confirm('确定要删除？不可恢复！')">删除</a></td>
    </tr>
	<%
	Sql="Select ID,Title,Ordnum,Followid,PageDir,HtmlName  From "&Sd_Table&" Where Followid="&Rs(0)&" Order By Ordnum Desc"
	Set Rs1=Conn.Execute(Sql)
	DbQuery=DbQuery+1
	While Not Rs1.Eof
	%>
	<tr onmouseover=this.bgColor='#EEFEED'; onmouseout=this.bgColor='#ffffff';  bgcolor='#ffffff'>
	  <td height="25" align="center"><input name="ID" type="checkbox" value="<%=Rs1(0)%>"></td>
	  <td align="center"><%=Rs1(0)%></td>
      <td>　<img src="Images/line.gif" /><%=Rs1(1)%></td>
	  <td align="center"><a href="?action=up&id=<%=Rs1(0)%>&ordnum=<%=Rs1(2)%>&followid=<%=Rs1(3)%>">↑</a> <a href="?action=down&id=<%=Rs1(0)%>&ordnum=<%=Rs1(2)%>&followid=<%=Rs1(3)%>">↓</a></td>
      <td align="center"><%IF Sdcms_Mode=2 Then%><a href="?action=makehtml&id=<%=Rs1(0)%>">生成</a><%End IF%> <a href="?action=edit&id=<%=Rs1(0)%>">编辑</a> <a href="?action=del&id=<%=Rs1(0)%>" onclick="return confirm('确定要删除？不可恢复！')">删除</a></td>
    </tr>
	<%
	Rs1.MoveNext:Wend:Rs1.Close
	Rs.MoveNext:Wend:Rs.Close
	%>
	<tr>
      <td colspan="5" class="tdbg" >
	 <input name="chkAll" type="checkbox" id="chkAll" onclick=CheckAll(this.form) value="checkbox"><label for="chkall">全选</label>  
              <select name="action">
			  <option>→操作</option>
			  <%IF Sdcms_Mode=2 Then%><option value="makehtml">生成</option><%End IF%>
			  <option value="del">删除</option>
			  </select> 
      <input type="submit" class="bnt01" value="执行"></td>
    </tr>
	</form>
  </table>

<%
End Sub

Sub Add
	Dim ID:ID=IsNum(Trim(Request.QueryString("ID")),0)
	IF ID>0 Then
		Dim Rs
		Set Rs=Conn.Execute("Select title,followid,page_temp,pagedir,htmlname,page_key,page_desc,content From "&Sd_Table&" Where Id="&id&"")
		DbQuery=DbQuery+1
		IF Rs.Eof then
			Echo "请勿非法提交参数":Exit Sub
		Else
			Dim t0,t1,t2,t3,t4,t5,t6,t7
			t0=Rs(0)
			t1=Rs(1)
			t2=Rs(2)
			t3=Re(Rs(3),"/","")
			t4=Rs(4)
			t5=Rs(5)
			t6=Rs(6)
			t7=Rs(7)
		End IF
		Rs.Close
		Set Rs=Nothing
	Else
		t2=""
		t4=sdcms_filename
	End IF
	Echo Check_Add
%>
  <form name="add" method="post" action="?action=save&id=<%=id%>" onSubmit="return checkadd()">
  <table width="98%" border="0" align="center" cellpadding="3" cellspacing="1">
    <tr>
      <td width="120" align="center" class="tdbg">栏目名称：      </td>
      <td class="tdbg"><input name="t0" type="text" class="input" value="<%=t0%>" id="t0" size="50"></td>
    </tr>
     <tr class="tdbg">
      <td align="center">栏目属性：      </td>
      <td><select name="t1">
	  <option value="0">一级栏目</option>
	  <%Set Rs=Conn.Execute("Select id,title From "&Sd_Table&" Where Followid=0 And ID<>"&ID&" Order By OrdNum Desc"):DbQuery=DbQuery+1:While Not Rs.Eof%>
	  <option value="<%=Rs(0)%>"<%=IIF(Rs(0)=t1,"selected","")%>><%=Rs(1)%></option>
	  <%Rs.MoveNext:Wend:Rs.Close%>
	  </select></td>
    </tr>
    <tr class="tdbg">
      <td align="center">模板设置：</td>
      <td><input name="t2" class="input" type="text" id="t2" size="50" maxlength="50" value="<%=t2%>">　<span>默认留空</span>　<input type="button" value="选择" class="bnt01 hand" onClick="Open_w('sdcms_temp.asp?Path=<%=Sdcms_Skins_Root%>',500,300,window,document.add.t2);" /></td>
    </tr>
	<tr class="tdbg">
     <td align="center">生成设置：</td>
     <td><input name="t3" value="<%=t3%>" type="text" class="input" /> / <input name="t4" value="<%=t4%>" size="10" type="text" class="input" /><%=Sdcms_FileTxt%> 　<span>前者为目录，后者为文件名(默认为自动编号)</span></td>
   </tr>
   <tr class="tdbg">
      <td align="center">关 键 字：</td>
      <td><input name="t5" class="input" type="text" id="t5" size="50" maxlength="50" value="<%=t5%>"></td>
    </tr>
    <tr class="tdbg">
      <td align="center">描　　述：</td>
      <td><textarea name="t6" rows="2" class="inputs"><%=Content_Encode(t6)%></textarea></td>
    </tr>
   <tr class="tdbg">
      <td align="center">栏目内容：</td>
      <td>
	  <div id="div_Page_Con" style="display:none;"><%=Content_Encode(t7)%></div>
	  <script>Start_MyEdit("t7","div_Page_Con");</script>
	  <!--<textarea name="t7" id="t7" style="width:100%;height:300px;"><%=Content_Encode(t7)%></textarea>-->
	  <%admin_upfile 10,"100%","20","","UpLoadIframe",0,1%><input name="up" id="up" type="checkbox" value="1" /><label for="up">保存远程图片</label></td>
    </tr>
    <tr class="tdbg">
	  <td>&nbsp;</td>
      <td><input type="submit" class="bnt" value="保存设置"> <input type="button" onClick="history.go(-1)" class="bnt" value="放弃返回"></td>
    </tr>
  </table>
  </form>
<%
End Sub

Sub Save
	Dim ID:ID=IsNum(Trim(Request.QueryString("ID")),0)
	Dim t0,t1,t2,t3,t4,t5,t6,t7,up,Rs,Sql,LogMsg
	t0=FilterText(Trim(Request.Form("t0")),1)
	t1=IsNum(Trim(Request.Form("t1")),0)
	t2=FilterText(Trim(Request.Form("t2")),0)
	t3=FilterText(Trim(Request.Form("t3")),0)&"/"
	t4=Trim(Request.Form("t4"))
	t5=FilterHtml(Trim(Request.Form("t5")))
	t6=FilterHtml(Trim(Request.Form("t6")))
	t7=Trim(Request.Form("t7"))
	up=IsNum(Trim(Request.Form("up")),0)
	IF t3="/" Then t3=Replace(t3,"/","")
	t4=Re_FileName(t4)
	
	IF ID=0 Then sdcms.Check_lever 15 Else sdcms.Check_lever 16
	IF Up=1 Then t7=ReplaceRemoteUrl(t7,"","","","")
	IF ID>0 Then
		IF ID=t1 Then
			Echo "类别选择错误":Exit Sub
		End IF
	End IF
	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql="Select title,followid,page_temp,pagedir,htmlname,page_key,page_desc,content,ordnum,adddate,ID From "&Sd_Table
	IF ID>0 Then Sql=Sql&" Where id="&ID
	Rs.Open Sql,Conn,1,3
	IF ID=0 Then 
		Rs.Addnew
	Else
		Rs.Update
	End IF
	Rs(0)=Left(t0,50)
	Rs(1)=t1
	Rs(2)=Left(t2,50)
	IF ID>0 And Sdcms_Mode=2 Then
		Del_File Sdcms_Root&Rs(3)&Rs(4)&Sdcms_Filetxt
	End IF
	Rs(3)=Left(t3,50)
	Rs(4)=Left(t4,50)
	Rs(5)=Left(t5,50)
	Rs(6)=t6
	Rs(7)=t7
	IF ID=0 Then Rs(8)=Get_Max_ID(t1):Rs(9)=Dateadd("h",Sdcms_TimeZone,Now())
	Rs.Update
	IF ID=0 Then LogMsg="添加单页" Else LogMsg="修改单页"
	Rs.MoveLast
	ID=Rs(10)
	Custom_HtmlName t4,Sd_Table,t0,ID
	Rs.Close
	Set Rs=Nothing
	AddLog sdcms_adminname,GetIp,LogMsg&t0,0
	IF Sdcms_Mode=2 Then
		Dim Sdcms_C
		Set Sdcms_C=New Sdcms_Create
			Sdcms_C.Create_Other ID
		Set Sdcms_C=Nothing
	End IF
  Go "?"
End Sub

Sub Del
	Dim ID:ID=IsNum(Trim(Request.QueryString("ID")),0)
	IF Len(ID)>0 Then
		Dim counts
		AddLog sdcms_adminname,GetIp,"删除单页：编号为"&id,0
		counts=Conn.Execute("select count(id) from "&Sd_Table&" where followid="&id&" ")(0)
		IF counts>0 Then
			Echo "不能删除有下级页面的页面":Died
		End IF
		IF Sdcms_Mode=2 Then Del_File Sdcms_Root&LoadRecord("pagedir",Sd_Table,id)&LoadRecord("htmlname",Sd_Table,id)&sdcms_filetxt
		Conn.Execute("Delete from "&Sd_Table&" where id="&id&"")
	End IF
	Go "?"
End Sub

Sub Makehtml
	Dim ID:ID=Trim(Request("ID"))
	IF Len(ID)>0 Then
		AddLog sdcms_adminname,GetIp,"生成单页：编号为"&id,0
		ID=Split(ID,", ")
		Dim I
		For I=0 To Ubound(ID)
		  Set Sdcms=New sdcms_create
		  sdcms.Create_other Clng(ID(I))
		  Set Sdcms=Nothing
		Next
	Else
		Go "?"
	End IF
End Sub

Sub Up
	Dim ID:ID=IsNum(Trim(Request.QueryString("ID")),0)
	Dim Followid:Followid=IsNum(Trim(Request.QueryString("Followid")),0)
	Dim Ordnum:Ordnum=IsNum(Trim(Request.QueryString("Ordnum")),0)
	Dim Rs,Sql
	Sql="Select top 1 id,ordnum from "&Sd_Table&" where followid="&followid&" and ordnum>"&ordnum&" order by ordnum"
	Set Rs=Conn.Execute(sql)
	IF Not Rs.Eof Then
		Conn.Execute("Update "&Sd_Table&" Set Ordnum="&rs(1)&" where id="&ID&"")
		Conn.Execute("Update "&Sd_Table&" Set Ordnum="&rs(1)&"-1 where id="&rs(0)&"")
	End IF
	Rs.Close
	Set Rs=Nothing
	Go "?"
End Sub

Sub Down
	Dim ID:ID=IsNum(Trim(Request.QueryString("ID")),0)
	Dim Followid:Followid=IsNum(Trim(Request.QueryString("Followid")),0)
	Dim Ordnum:Ordnum=IsNum(Trim(Request.QueryString("Ordnum")),0)
	Dim Rs,Sql
	Sql="Select top 1 id,ordnum from "&Sd_Table&" where followid="&followid&" and ordnum<"&ordnum&" order by ordnum desc"
	Set Rs=Conn.Execute(sql)
	IF Not Rs.Eof Then
		Conn.Execute("Update "&Sd_Table&" Set Ordnum="&rs(1)&" where id="&ID&"")
		Conn.Execute("Update "&Sd_Table&" Set Ordnum="&rs(1)&"+1 where id="&rs(0)&"")
	End IF
	Rs.Close
	Set Rs=Nothing
	Go "?"
End Sub

Function Get_Max_ID(ByVal t0)
	Dim Rs_Max,Sql
	Sql="Select Max(Ordnum) From "&Sd_Table&" Where Followid="&t0
	Set Rs_Max=Conn.Execute(Sql)
	DbQuery=DbQuery+1
	IF Rs_Max.Eof Then
		Get_Max_ID=1
	Else
		IF Len(Rs_Max(0))=0 Or IsNull(Rs_Max(0)) Then
			Get_Max_ID=1
		Else
			Get_Max_ID=Rs_Max(0)+1
		End IF
	End IF
	Rs_Max.Close
	Set Rs_Max=Nothing
End Function

Function Check_Add
	Check_Add="	<script>"&vbcrlf
	'Check_Add=Check_Add& "KE.show({"
	'Check_Add=Check_Add& "			id : 't7',"
	'Check_Add=Check_Add& "			imageUploadJson : '../../../"&Get_ThisFolder&"Sdcms_Editor_Up.asp',"
	'Check_Add=Check_Add& "			fileUploadJson : '../../"&Get_ThisFolder&"Sdcms_Editor_Up.asp?act=1'"
	'Check_Add=Check_Add& "		});"
	Check_Add=Check_Add&"	function checkadd()"&vbcrlf
	Check_Add=Check_Add&"	{"&vbcrlf
	Check_Add=Check_Add&"	if (document.add.t0.value=='')"&vbcrlf
	Check_Add=Check_Add&"	{"&vbcrlf
	Check_Add=Check_Add&"	alert('标题不能为空');"&vbcrlf
	Check_Add=Check_Add&"	document.add.t0.focus();"&vbcrlf
	Check_Add=Check_Add&"	return false"&vbcrlf
	Check_Add=Check_Add&"	}"&vbcrlf

	Check_Add=Check_Add&"	if (document.add.t4.value=='')"&vbcrlf
	Check_Add=Check_Add&"	{"&vbcrlf
	Check_Add=Check_Add&"	alert('文件名不能为空');"&vbcrlf
	Check_Add=Check_Add&"	document.add.t4.focus();"&vbcrlf
	Check_Add=Check_Add&"	return false"&vbcrlf
	Check_Add=Check_Add&"	}"&vbcrlf
	'Check_Add=Check_Add&"	if (KE.isEmpty('t7'))"&vbcrlf
	'Check_Add=Check_Add&"	{"&vbcrlf
	'Check_Add=Check_Add&"	alert('内容不能为空');"&vbcrlf
	'Check_Add=Check_Add&"	document.add.t7.focus;"&vbcrlf
	'Check_Add=Check_Add&"	return false"&vbcrlf
	'Check_Add=Check_Add&"	}"&vbcrlf
	Check_Add=Check_Add&"	}"&vbcrlf
	Check_Add=Check_Add&"	</script>"&vbcrlf
End Function
%>  
</div>
</body>
</html>