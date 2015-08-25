<!--#include file="sdcms_check.asp"-->
<%
Dim Sdcms,title,Sd_Table,skins,stype,Action
Action=Lcase(Trim(Request("Action")))
Set Sdcms=New Sdcms_Admin
Sdcms.Check_admin
Select Case action
	Case "add":title="添加专题"
	Case "edit":title="修改专题"
	Case Else:title="专题管理"
End Select
Sd_Table="sd_topic"
Sdcms_Head
%>

<div class="sdcms_notice"><span>管理操作：</span><a href="?action=add">添加专题</a>　┊　<a href="?">专题管理</a></div>
<br>
<ul id="sdcms_sub_title">
	<li class="sub"><%=title%></li>
</ul> 
<div id="sdcms_right_b">
<%
Select Case Action
	Case "add":sdcms.Check_lever 9:Add
	Case "edit":sdcms.Check_lever 10:Add
	Case "save":Save
	Case "del":sdcms.Check_lever 11:Del
	Case Else:Main
End Select
Db_Run
CloseDb
Set Sdcms=Nothing
Sub Main
%>
  <table border="0" align="center" cellpadding="3" cellspacing="1" class="table_b">
    <form name="add" action="?" method="post"  onSubmit="return confirm('确定要执行选定的操作吗？');">
	<tr>
	  <td width="30" class="title_bg">选择</td>
      <td width="60" class="title_bg">编号</td>
      <td width="*" class="title_bg">标题</td>
      <td width="140" class="title_bg">日期</td>
      <td width="60" class="title_bg">推荐</td>
      <td width="100" class="title_bg">管理</td>
    </tr>
	<%
	Dim Page,P,Rs,I,Num
	Page=IsNum(Trim(Request.QueryString("page")),1)
	Set P=New Sdcms_Page
	With P
		.Conn=Conn
		.PageNum=Page
		.Table=Sd_Table
		.Field="id,title,adddate,IsNice"
		.Key="ID"
		.Order="Ordnum Desc,ID Desc"
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
	 <td height="25" align="center"><input name="id"  type="checkbox" value="<%=Rs(0)%>"></td>
	 <td align="center"><%=Rs(0)%></td>
	  <td><a href="<%=Get_Link(Sd_Table,Rs(0))%>" target="_blank"><%=Rs(1)%></a></td>
	  <td align="center"><%=Rs(2)%></td>
      <td align="center"><%=IIF(Rs(3)=1,"√","<b>×</b>")%></td>
      <td align="center"><a href="?action=edit&id=<%=Rs(0)%>">编辑</a> <a href="?action=del&id=<%=Rs(0)%>" onclick='return confirm("真的要删除?不可恢复!");'>删除</a></td>
    </tr>
	<%
	Rs.MoveNext
	Next         
	%>
	<tr>
      <td colspan="6" class="tdbg" >
	  <input name="chkAll" type="checkbox" id="chkAll" onclick=CheckAll(this.form) value="checkbox"><label for="chkall">全选</label>  
              <select name="action">
			  <option>→操作</option>
			  <option value="del">删除</option>
			  </select>
      <input type="submit" class="bnt01" value="执行"></td>
    </tr>
	<%IF Len(Num)=0 Then%>
	<tr>
      <td colspan="6" class="tdbg content_page" align="center"><%Echo P.PageList%></td>
	</tr>
	<%End IF%>
	</form>
  </table>

<%
Set P=Nothing
End Sub

Sub Add
	Dim Rs,ID
	ID=IsNum(Trim(Request.QueryString("ID")),0)
	IF ID>0 Then
		Set Rs=Conn.Execute("Select Title,Isnice,keyword,Description,Pic,OrdNum,Temp_Dir,Content from "&Sd_Table&" where id="&id&"")
		IF Rs.Eof Then
			Echo "请勿非法提交参数":Exit Sub
		Else
			Dim t0,t1,t2,t3,t4,t5,t6,t7
			t0=Rs(0)
			t1=Rs(1)
			t2=Rs(2)
			t3=Rs(3)
			t4=Rs(4)
			t5=Rs(5)
			t6=Rs(6)
			t7=Rs(7)
		End IF
		Rs.Close
		Set Rs=Nothing
	Else
		t5=Get_Max_ID
		t6=""
	End IF
	Echo Check_Add
%>
  <table width="98%" border="0" align="center" cellpadding="3" cellspacing="1">
  <form name="add" method="post" action="?action=save&id=<%=ID%>" onSubmit="return checkadd()">
   <tr>
      <td width="100" align="center" class="tdbg">专题名称：</td>
      <td class="tdbg"><input name="t0" type="text" class="input" id="t0" size="40" value="<%=t0%>">　<input name="t1" type="checkbox" value="1" <%=IIF(t1=1,"checked","")%> id="t1" /><label for="t1">推荐</label></td>
    </tr>
	<tr>
      <td width="100" align="center" class="tdbg">关 键 字：</td>
      <td class="tdbg"><input name="t2" type="text" class="input" size="40" value="<%=t2%>"></td>
    </tr>
	<tr>
      <td width="100" align="center" class="tdbg">描　　述：</td>
      <td class="tdbg"><textarea name="t3" rows="2" class="inputs"><%=Content_Encode(t3)%></textarea></td>
    </tr>
	<tr>
      <td width="100" align="center" class="tdbg">专题图片：</td>
      <td class="tdbg"><input name="t4" id="t4" type="text" class="input" size="40" value="<%=t4%>">　<span>可以为空</span><%admin_upfile 1,"100%","20","t4","UpLoadPicIframe",1,1%></td>
    </tr>
	<tr>
      <td width="100" align="center" class="tdbg">专题排序：</td>
      <td class="tdbg"><input name="t5" type="text" class="input" size="40" value="<%=t5%>">　<span>只能是数字</span></td>
    </tr>
	<tr>
      <td width="100" align="center" class="tdbg">绑定模板：</td>
      <td class="tdbg"><input name="t6" type="text" class="input" size="40" value="<%=t6%>">　<span>默认留空</span>　<input type="button" value="选择" class="bnt01 hand" onClick="Open_w('sdcms_temp.asp?Path=<%=Sdcms_Skins_Root%>',500,300,window,document.add.t6);" /></td>
    </tr>
   <tr class="tdbg">
      <td  width="100" align="center">专题介绍：</td>
      <td><textarea name="t7" id="t7" style="width:100%;height:200px;"><%=t7%></textarea>
	 </td>
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
	Dim t0,t1,t2,t3,t4,t5,t6,t7,Rs,Sql,LogMsg,ID
	ID=IsNum(Trim(Request.QueryString("ID")),0)
	t0=FilterText(Trim(Request.Form("t0")),1)
	t1=IsNum(Trim(Request.Form("t1")),0)
	t2=FilterText(Trim(Request.Form("t2")),0)
	t3=FilterText(Trim(Request.Form("t3")),0)
	t4=FilterHtml(Trim(Request.Form("t4")))
	t5=IsNum(Trim(Request.Form("t5")),0)
	t6=FilterText(Trim(Request.Form("t6")),0)
	t7=Request.Form("t7")
	
	IF ID=0 Then sdcms.Check_lever 9 Else sdcms.Check_lever 10
	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql="Select Title,Isnice,Keyword,Description,Pic,OrdNum,Temp_Dir,Content,Adddate From "&Sd_Table
	IF ID>0 then 
		Sql=Sql&" where ID="&ID
	End if
	Rs.Open Sql,Conn,1,3
	IF ID=0 Then 
	  Rs.Addnew
	Else
	  Rs.Update
	End IF
	Rs(0)=Left(t0,50)
	Rs(1)=t1
	Rs(2)=Removehtml(t2)
	Rs(3)=Removehtml(t3)
	Rs(4)=Left(t4,255)
	Rs(5)=Left(t5,10)
	Rs(6)=Left(t6,50)
	Rs(7)=t7
	IF ID=0 Then Rs(8)=Dateadd("h",Sdcms_TimeZone,Now())
	rs.Update
	Rs.MoveLast
	IF ID=0 Then
		LogMsg="添加专题"
	Else
		LogMsg="修改专题"
	End IF
	AddLog sdcms_adminname,GetIp,LogMsg&Rs(0),0
	Rs.Close
	Set Rs=Nothing
	Go "?"
End Sub

Sub Del
	Dim ID,I,Rs
	ID=Trim(Request("ID"))
	IF Len(ID)>0 Then
		AddLog sdcms_adminname,GetIp,"删除专题：编号为"&id,0
		ID=Split(ID,", ")
		For I=0 To Ubound(ID)
			Set Rs=Conn.Execute("Select ID From "&Sd_Table&" where id="&Clng(ID(I))&"")
			IF Not Rs.Eof Then
				Conn.Execute("Update Sd_Info Set Topic=0 Where Topic="&Clng(ID(I))&"")
			End IF
			Conn.Execute("Delete From "&Sd_Table&" Where Id="&Clng(ID(I))&"")
		Next
		Rs.Close
		Set Rs=Nothing
	End IF
	Go "?"
End Sub

Function Get_Max_ID()
	Dim Rs_Max,Sql
	Sql="Select Max(Ordnum) From "&Sd_Table
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
	Check_Add=Check_Add& "KE.show({"
	Check_Add=Check_Add& "			id : 't7',"
	Check_Add=Check_Add& "			imageUploadJson : '../../../"&Get_ThisFolder&"Sdcms_Editor_Up.asp',"
	Check_Add=Check_Add& "			items : ["
	Check_Add=Check_Add& "				'fontname', 'fontsize', '|', 'textcolor', 'bgcolor', 'bold', 'italic', 'underline',"
	Check_Add=Check_Add& "				'|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',"
	Check_Add=Check_Add& "				'insertunorderedlist', '|',  'image', 'link', 'unlink', 'about']"
	Check_Add=Check_Add& "		});"
	Check_Add=Check_Add&"	function checkadd()"&vbcrlf
	Check_Add=Check_Add&"	{"&vbcrlf
	Check_Add=Check_Add&"	if (document.add.t0.value=='')"&vbcrlf
	Check_Add=Check_Add&"	{"&vbcrlf
	Check_Add=Check_Add&"	alert('专题名称不能为空');"&vbcrlf
	Check_Add=Check_Add&"	document.add.t0.focus();"&vbcrlf
	Check_Add=Check_Add&"	return false"&vbcrlf
	Check_Add=Check_Add&"	}"&vbcrlf
	Check_Add=Check_Add&"	if (KE.isEmpty('t7'))"&vbcrlf
	Check_Add=Check_Add&"	{"&vbcrlf
	Check_Add=Check_Add&"	alert('专题介绍不能为空');"&vbcrlf
	Check_Add=Check_Add&"	document.add.t7.focus;"&vbcrlf
	Check_Add=Check_Add&"	return false"&vbcrlf
	Check_Add=Check_Add&"	}"&vbcrlf
	Check_Add=Check_Add&"	}"&vbcrlf
	Check_Add=Check_Add&"	</script>"&vbcrlf
End Function
%>  
</div>
</body>
</html>