<!--#include file="sdcms_check.asp"-->
<%
Dim Sdcms,title,Sd_Table,Action,Class_Array,stype
Action=Lcase(Trim(Request.QueryString("Action")))
Set Sdcms=new Sdcms_Admin
Sdcms.Check_admin
Select Case Action
	Case "add":title="添加分类"
	Case "edit":title="修改分类"
	Case "move","movesave":stype="main":title="转移分类"
	Case "batch":stype="main":title="批量设置"
	Case Else:stype="main":title="分类管理"
End Select
Sd_Table="sd_class"
Sdcms_Head
%>
<div class="sdcms_notice"><span>管理操作：</span><a href="?action=add">添加分类</a>　┊　<a href="?">分类管理</a>　┊　<a href="?action=batch">批量设置</a></div>
<br>
<ul id="sdcms_sub_title">
	<li class="sub"><a<%if stype<>"main" then%> href="javascript:void(0)" onClick="selectTag('tagContent0',this)"<%end if%>><%=title%></a></li>
	<%if stype<>"main" then%>
	<li class="unsub"><a href="javascript:void(0)" onClick="selectTag('tagContent1',this)">参数设置</a></li>
	<%end if%>
</ul>
<div id="sdcms_right_b">
<%
Select Case Action
	Case "add":sdcms.Check_lever 6:add
	Case "edit":sdcms.Check_lever 7:add
	Case "move":sdcms.Check_lever 7:Move_Class
	Case "movesave":sdcms.Check_lever 7:Move_Class_Save
	Case "batch":sdcms.Check_lever 7:batch
	Case "batchsave":sdcms.Check_lever 7:Batch_Save
	Case "save":save
	Case "makehtml":sdcms.Check_lever 7:make_c_list
	Case "pagelist":Mack_Page_List
	Case "saveorder":sdcms.Check_lever 7:SaveOrder
	Case "down":sdcms.Check_lever 7:down
	Case "del":sdcms.Check_lever 8:del
	Case Else:main
End Select
Db_Run
Sub Main
%>
  <table border="0" align="center" cellpadding="2" cellspacing="1" class="table_b">
  <form method="post" action="?action=SaveOrder" onsubmit="return confirm('确定要保存吗？')">
    <tr>
      <td width="60" class="title_bg">编号</td>
      <td width="*" class="title_bg">标题</td>
      <td width="200" class="title_bg">管理</td>
    </tr>
	<%
	Dim Rs,Sql
	Sql="Select ID,Title,Ordnum,Depth,Followid,ClassUrl From "&Sd_Table&" Order By Ordnum,ID"
	Set Rs=Conn.Execute(Sql)
	DbQuery=DbQuery+1
	IF Rs.Eof Then
	%>
	<tr onmouseover=this.bgColor='#EEFEED'; onmouseout=this.bgColor='#ffffff';  bgcolor='#ffffff'>
      <td height="25" colspan="3" align="center" class="tdbg">没有类别</td>
    </tr>
	<%
	Else
		Class_Array=Rs.GetRows()
		Rs.Close
		Set Rs=Nothing
		Show_Class(0)
	%>
	<tr>
	  <td colspan="3" align="center" class="tdbg"><input name="submit" type="submit" class="bnt" value="保存排序" /></td>
    </tr>
	<%End IF%>
	</form>
  </table>
<%
End Sub

Sub Show_Class(ParentId)
	Dim I,J,Rows,N_NextParentId,Url
	Rows=UBound(Class_Array,2)
	For I=0 To Rows
	IF Class_Array(4,I)=ParentId Then
	Select Case Sdcms_Mode
		Case "2","1":Url=Class_Array(5,I)
		Case Else:Url=Class_Array(0,I)
	End Select
%>
<tr onmouseover=this.bgColor='#EEFEED'; onmouseout=this.bgColor='#ffffff';  bgcolor='#ffffff'>
      <td align="center" height="25"><input type="Hidden" name="ID" value="<%=Class_Array(0,I)%>" class="input" size="2"><%=Class_Array(0,I)%></td>
      <td ><%For J=0 To Class_Array(3,I)%>　<%Next%><%=IIF(Class_Array(4,I)>0,"<img src=""Images/line.gif"" />","")%><a href="<%=Get_Link(Sd_Table,Url)%>" target="_blank"><%=Class_Array(1,I)%></a>　<span class="c9">排序</span> <input type="text" name="ordnum" value="<%=Class_Array(2,I)%>" class="input" size="2" onKeyUp="value=value.replace(/[^\d]/g,'');" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''));"></td>
      <td align="center"><%IF Sdcms_Mode=2 Then%><a href="?action=makehtml&id=<%=Class_Array(0,I)%>">生成</a>　<%End IF%><a href="?action=add&followid=<%=Class_Array(0,I)%>">添加子类</a>　<a href="?action=move&id=<%=Class_Array(0,I)%>">移动</a>　<a href="?action=edit&id=<%=Class_Array(0,I)%>">编辑</a>　<a href="?action=del&id=<%=Class_Array(0,I)%>" onclick="return confirm('真的要删除?不可恢复!\n\n将删除该类别下的所有信息!');">删除</a></td>
  </tr>
<%
	Show_Class(Class_Array(0,I))
	End IF
	Next
End Sub

Sub SaveOrder
	Dim t0,t1,t2,t3,I,Rs
	t0=Trim(Request.Form("ID"))
	t1=Trim(Request.Form("ordnum"))
	t2=Split(t0,", ")
	t3=Split(t1,", ")
	IF Ubound(t2)-Ubound(t3)<>0 Then Echo "参数错误！":Exit Sub
	For I=0 To Ubound(t2)
		IF IsNumeric(t2(I)) And IsNumeric(t3(I))  Then
			Set Rs=Conn.Execute("Select Followid,allclassid From "&Sd_Table&" Where Id="&t2(I)&"")
			DbQuery=DbQuery+1
			IF Not Rs.Eof Then
				Conn.Execute("Update "&Sd_Table&" Set Ordnum="&t3(I)&" Where Id="&t2(I)&"")
				DbQuery=DbQuery+1
			End IF
			Rs.Close
			Set Rs=Nothing
		End IF
	Next
	Echo "排序保存成功！"
End Sub

Sub Add
	Dim t0,t1,t2,t3,t4,t5,t5_0,t5_1,t6,t7,t8,t9,t10
	Dim Rs,Sql
	Dim ID:ID=IsNum(Trim(Request.QueryString("ID")),0)
	Dim Followid:Followid=IsNum(Trim(Request.QueryString("followid")),0)
	IF ID>0 Then
		Sql="Select title,ClassUrl,followid,class_type,channel_temp,list_temp,show_temp,pagenum,keyword,class_desc,Ordnum From "&Sd_Table&" Where ID="&ID
		Set Rs=Conn.Execute(Sql)
		DbQuery=DbQuery+1
		IF Rs.Eof Then
			Echo "请勿非法提交参数":Exit Sub
		Else
			t0=Rs(0)
			t1=Rs(1)
			t2=Rs(2)
			t3=Rs(3)
			t4=Rs(4)
			t5=Rs(5)
			t5_0="skins/"&Sdcms_Skins_Root&"/"&sdcms_skins_info_list_text
			t5_1="skins/"&Sdcms_Skins_Root&"/"&sdcms_skins_info_list_pic
			t6=Rs(6)
			t7=Rs(7)
			t8=Rs(8)
			t9=Rs(9)
			t10=Rs(10)
			IF Right(t1,"1")="/" Then t1=Left(t1,Len(t1)-1)
		End IF
		Rs.Close
		Set Rs=Nothing
		IF Load_Cookies("sdcms_admin")=0 Then
			IF Instr(Session(sdcms_cookies&"sdcms_infoalllever"),ID&"|2")=0 Then Echo "您没有此栏目的编辑权限":Exit Sub
		End IF
	Else
		t2=Followid
		t3=0
		t4=""
		t5=""
		t5_0="skins/"&Sdcms_Skins_Root&"/"&sdcms_skins_info_list_text
		t5_1="skins/"&Sdcms_Skins_Root&"/"&sdcms_skins_info_list_pic
		t6=""
		t7=20
		t10=0
		IF Load_Cookies("sdcms_admin")=0 Then
			IF Instr(Session(sdcms_cookies&"sdcms_infoalllever"),ID&"|1")=0 Then Echo "您没有此栏目的编辑权限":Exit Sub
		End IF
	End IF
	Echo Check_Add
%>
  <table width="98%" border="0" align="center" cellpadding="3" cellspacing="1" id="tagContent0">
   <form name="add" method="post" action="?action=save&id=<%=ID%>" onSubmit="return checkadd()">
   <tr>
      <td width="120" align="center" class="tdbg">分类名称：      </td>
      <td class="tdbg"><input value="<%=t0%>" name="t0" class="input" type="text" id="t0" size="40" maxlength="50"></td>
    </tr>
	<tr>
      <td align="center" class="tdbg">生成目录：      </td>
      <td class="tdbg"><input value="<%=t1%>" type="text" name="t1" class="input" size="40" maxlength="50" style="ime-mode:disabled">　<span>支持多级，前面不要加“/”</span></td>
    </tr>
	<%IF ID=0 Then%>
	<tr class="tdbg">
      <td align="center">类别选择：</td>
      <td><select name="t2" ><option value="0" >作为一级分类</option><%=Get_Class(Followid)%></select></td>
    </tr>
	<%End IF%>
	<tr>
      <td align="center" class="tdbg">分类排序：      </td>
      <td class="tdbg"><input name="t10" value="<%=t10%>" class="input" type="text" id="t10" size="40" maxlength="5" onKeyUp="value=value.replace(/[^\d]/g,'');"  onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''));">　<span>数字越小越靠前</span></td>
    </tr>
	<tr>
      <td align="center" class="tdbg">关 键 字：</td>
      <td class="tdbg"><textarea name="t8"  id="t8" cols="60" rows="2" class="inputs"><%=Content_Encode(t8)%></textarea></td>
    </tr>
	<tr>
      <td align="center" class="tdbg">描　　述：</td>
      <td class="tdbg"><textarea name="t9" id="t9" cols="60" rows="2" class="inputs"><%=Content_Encode(t9)%></textarea></td>
    </tr>
    </table>
    <table width="98%" border="0" align="center" cellpadding="3" cellspacing="1"  id="tagContent1" class="dis">
    <tr class="tdbg">
      <td align="center" width="120">频道选项：</td>
      <td><input name="t3" type="radio" value="1" <%=IIF(t3=1,"checked","")%> onClick=$("#flag")[0].style.display='inline';$("#flag1")[0].style.display='none';  id="t3_0"><label for="t3_0">作为频道</label> <input name="t3" type="radio" value="0" <%=IIF(t3=0,"checked","")%> onClick=$("#flag")[0].style.display='none';$("#flag1")[0].style.display='inline'; id="t3_1"><label for="t3_1">作为列表</label>　<span>作为频道时，此类别不可发信息</span></td>
    </tr>
    <tr class="tdbg<%=IIF(t3=0," dis","")%>" id="flag">
      <td width="120" align="center">频道模板：</td>
      <td><input name="t4" class="input" type="text" id="t4" size="40" maxlength="50" value="<%=t4%>">　<span>默认留空</span>　<input type="button" value="选择" class="bnt01 hand" onClick="Open_w('sdcms_temp.asp?Path=<%=Sdcms_Skins_Root%>',500,300,window,document.add.t4);" /></td>
    </tr>
	<tr class="tdbg<%=IIF(t3=1," dis","")%>" id="flag1">
      <td width="120" align="center">列表模板：</td>
      <td><input name="t5" class="input" type="text" id="t5" size="40" maxlength="50" value="<%=t5%>">　<span>默认留空</span>　<input type="button" value="文字" class="bnt01 hand" onClick="$('#t5')[0].value='<%=t5_0%>';" /> <input type="button" value="图片" class="bnt01 hand" onClick="$('#t5')[0].value='<%=t5_1%>';" /> <input type="button" value="选择" class="bnt01 hand" onClick="Open_w('sdcms_temp.asp?Path=<%=Sdcms_Skins_Root%>',500,300,window,document.add.t5);" /></td>
    </tr>
	<tr class="tdbg">
      <td align="center">内容模板：</td>
      <td><input name="t6" class="input" type="text" id="t6" size="40" maxlength="50" value="<%=t6%>">　<span>默认留空</span>　<input type="button" value="选择" class="bnt01 hand" onClick="Open_w('sdcms_temp.asp?Path=<%=Sdcms_Skins_Root%>',500,300,window,document.add.t6);" /></td>
    </tr>
    <tr>
      <td align="center" class="tdbg">分页数量：      </td>
      <td class="tdbg"><input name="t7" value="<%=t7%>" class="input" type="text" id="t7"  size="40" maxlength="5" onKeyUp="value=value.replace(/[^\d]/g,'');"  onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''));">　<span>作为列表时，每页显示的数量</span></td>
    </tr>
    </table>
    <tr class="tdbg">
	  <td>&nbsp;</td>
      <td><input type="submit" class="bnt" value="保存设置"> <input type="button" onClick="history.go(-1)" class="bnt" value="放弃返回"></td>
    </tr>
	</form>
  </table>
<%
End Sub

Sub Save
Dim t0,t1,t2,t3,t4,t5,t6,t7,t8,t9,t10,up1,up2,Sys_dir,i,Rs,Sql,LogMsg,act,id
ID=IsNum(Trim(Request.QueryString("ID")),0)
t0=FilterText(Trim(Request.Form("t0")),1)
t1=FilterText(Trim(Request.Form("t1")),0)
t2=IsNum(Trim(Request.Form("t2")),0)
t3=IsNum(Trim(Request.Form("t3")),0)
t4=FilterText(Trim(Request.Form("t4")),0)
t5=FilterText(Trim(Request.Form("t5")),0)
t6=FilterText(Trim(Request.Form("t6")),0)
t7=IsNum(Trim(Request.Form("t7")),20)
t8=FilterHtml(Trim(Request.Form("t8")))
t9=FilterHtml(Trim(Request.Form("t9")))
t10=IsNum(Trim(Request.Form("t10")),0)

IF Right(t1,1)<>"/" Then t1=t1&"/"
IF Left(t1,1)="/" Then t1=Right(t1,Len(t1)-1)
IF t7<=0 Then t7=20

IF ID=0 Then
	sdcms.Check_lever 6
	IF t2>0 And Load_Cookies("sdcms_admin")=0 Then
		IF Instr(Session(sdcms_cookies&"sdcms_infoalllever"),t2&"|1")=0 Then Echo "您没有此栏目的创建权限":Died
	End IF
Else
	sdcms.Check_lever 7
	IF Load_Cookies("sdcms_admin")=0 Then
		IF Instr(Session(sdcms_cookies&"sdcms_infoalllever"),t2&"|2")=0 Then Echo "您没有此栏目的编辑权限":Died
	End IF
	Dim Is_Rename,ClassUrl_Old
	Is_Rename=False
	Set Rs=Conn.Execute("Select ClassUrl From "&Sd_Table&" Where Id="&Id&"")
	DbQuery=DbQuery+1
	IF Not Rs.Eof Then
		ClassUrl_Old=Rs(0)
	End IF
	Rs.Close
	Set Rs=Nothing
	IF ClassUrl_Old<>t1 Then Is_Rename=True
End IF

Set Rs=Server.CreateObject("adodb.recordset")
Sql="Select title,ClassUrl,followid,class_type,channel_temp,list_temp,show_temp,pagenum,keyword,class_desc,ordnum,Depth,id From "&Sd_Table
IF ID=0 Then
	Sql=Sql&" Where ClassUrl='"&t1&"' And Followid="&t2&""
Else
	Sql=Sql&" Where ID="&ID&""
End IF
Rs.Open Sql,Conn,1,3
DbQuery=DbQuery+1
IF ID=0 Then
	IF Not Rs.Eof Then
		Echo "该类别的目录名称已存在，请换个试试！":Died
	End IF
	Rs.AddNew
Else
	Rs.UpDate
End IF
Rs(0)=Left(t0,50)
Rs(1)=Left(t1,50)
IF ID=0 Then Rs(2)=t2
Rs(3)=t3
Rs(4)=Left(t4,50)
Rs(5)=Left(t5,50)
Rs(6)=Left(t6,50)
Rs(7)=IsNum(t7,20)
Rs(8)=t8
Rs(9)=t9
IF ID=0 Then Rs(10)=IsNum(t10,1)
IF ID=0 Then Rs(11)=Get_Max_Depth(t2)
Rs.UpDate
Rs.MoveLast
	Dim this_id:this_id=Rs(12)
	Rs.Close
	Set Rs=Nothing
	IF ID=0 Then
		Dim partent_dir
		'建立文件夹
		IF Sdcms_Mode=2 Then Create_Folder Sdcms_Root&Sdcms_Htmdir&t1
		IF t2=0 then
			Conn.Execute("Update "&Sd_Table&" set allclassid='"&this_id&"',partentid='"&this_id&"' where id="&this_id&"")
			DbQuery=DbQuery+1
		Else
			Dim Rs1,partent_id,Old_allclassid
			'计算分类之间的关系，将下级分类id添加到上级id中去
			 Conn.Execute("Update  "&Sd_Table&" set allclassid='"&this_id&"',partentid='"&this_id&"' where id="&this_id&"")
			 DbQuery=DbQuery+1
			 Set Rs1=Conn.Execute("select partentid from "&Sd_Table&" where id="&t2&"")
			 DbQuery=DbQuery+1
			 IF Not Rs1.Eof Then
				 partent_id=this_id&","&Rs1(0)
				 Conn.Execute("Update "&Sd_Table&" set partentid='"&partent_id&"' where Id="&this_id&"")
				 DbQuery=DbQuery+1
			 End IF
			
			 Set Rs=Conn.Execute("Select id,allclassid From "&Sd_Table&"  Where Id In("&Rs1(0)&")")
			 DbQuery=DbQuery+1
			 While Not Rs.Eof
				 Old_allclassid=Rs(1)
				 Conn.Execute("Update "&Sd_Table&" Set allclassid='"&Old_allclassid&","&this_id&"' Where ID="&Rs(0)&"")
				 DbQuery=DbQuery+1				 
			 Rs.MoveNext
			 Wend
			 Rs.Close
			 Set Rs=Nothing
			 Rs1.Close
			 Set Rs1=Nothing
		End IF
	Else
		IF Sdcms_Mode=2 Then
			IF Is_Rename Then
				ReName_Folder Sdcms_root&Sdcms_HtmDir&ClassUrl_Old,Sdcms_Root&Sdcms_HtmDir&t1
			End IF
		End IF
	End IF
	Echo "保存成功<br>"
	Dim sdcms_c
	Set sdcms_c=New sdcms_create
		sdcms_c.Create_google_map Sdcms_Create_GoogleMap(0),Sdcms_Create_GoogleMap(1),Sdcms_Create_GoogleMap(2)
	Set sdcms_c=Nothing
	IF ID=0 Then LogMsg="添加类别" Else LogMsg="修改类别"
	AddLog sdcms_adminname,GetIp,LogMsg&title,0
	IF Sdcms_Mode=2 And Id=0 Then
		Echo "<br>请不要离开，系统将在 <span id=""outtime""> <span class='red'>3</span></span>  秒后生成此类别"
		Echo "<script language=JavaScript>"
		Echo "var secs=3;var wait=secs * 1000;"
		Echo "for(i=1; i<=secs;i++){window.setTimeout(""Update("" + i + "")"", i * 1000);}"
		Echo "function Update(num){if(num != secs){printnr = (wait / 1000) - num;"
		Echo "$(""#outtime"")[0].style.width=(num/secs)*100+""%"";"
		Echo "$(""#outtime"").html("" <span class='red'>""+printnr+""</span> "");}}"
		Echo "setTimeout(""location.href='?action=makehtml&id="&this_id&"';"",""3000"");</script>"
	End IF
End Sub

Sub Batch
%>
  <table width="98%" border="0" align="center" cellpadding="3" cellspacing="1">
  <form name="add" method="post" action="?action=batchsave">
    <tr>
      <td width="120" align="center"><input type="checkbox" checked="checked" disabled="disabled" />类别/选择<br />
      <input  type="checkbox" name="checkall" id="checkall" onclick="checkselect(this,$('#t0')[0])"><label for="checkall">全选/取消</label> </td>
      <td><select name="t0" size="10" multiple="multiple" id="t0" style="width:60%;"><%=Get_Class(0)%></select>
      </td>
    </tr> 
	<tr class="tdbg">
      <td align="center"><input name="up1" type="checkbox" id="up1" value="1" checked="checked" />
      <label for="up1">频道选项：</label></td>
      <td><input name="t1" id="t1" type="radio" value="1" onClick=$("#flag")[0].style.display='';$("#flag1")[0].style.display='none';  />作为频道<input name="t1" id="t1" type="radio" value="0" checked="checked" onClick=$("#flag")[0].style.display='none';$("#flag1")[0].style.display='';  />作为列表　<span>作为频道时,此类别不可发信息</span></td>
    </tr>
	<tr class="tdbg dis" id="flag">
      <td align="center">频道模板：</td>
      <td><input name="t2" class="input" type="text" id="t2" size="40" maxlength="50" value="">　<input type="button" value="选择" class="bnt01 hand" onClick="Open_w('sdcms_temp.asp?Path=<%=Sdcms_Skins_Root%>',500,300,window,document.add.t2);" /></td>
    </tr>
	<tr class="tdbg" id="flag1">
      <td align="center">类别模板：</td>
      <td><input name="t3" class="input" type="text" id="t3" size="40" maxlength="50" value="">　<input type="button" value="文字" class="bnt01 hand" onClick="$('#t3')[0].value='<%="skins/"&Sdcms_Skins_Root&"/"&sdcms_skins_info_list_text%>';" /> <input type="button" value="图片" class="bnt01 hand" onClick="$('#t3')[0].value='<%="skins/"&Sdcms_Skins_Root&"/"&sdcms_skins_info_list_pic%>';" /> <input type="button" value="选择" class="bnt01 hand" onClick="Open_w('sdcms_temp.asp?Path=<%=Sdcms_Skins_Root%>',500,300,window,document.add.t3);" /></td>
    </tr>
	<tr class="tdbg">
      <td align="center"><input name="up2" type="checkbox" id="up2" value="1" checked="checked" />
      <label for="up2">显示模板：</label></td>
      <td><input name="t4" class="input" type="text" id="t4" size="40" maxlength="50" value="">　<input type="button" value="选择" class="bnt01 hand" onClick="Open_w('sdcms_temp.asp?Path=<%=Sdcms_Skins_Root%>',500,300,window,document.add.t4);" /></td>
    </tr>
	<tr>
      <td align="center" class="tdbg"><input name="up3" type="checkbox" id="up3" value="1" />
      <label for="up3">分页数量：</label>      </td>
      <td class="tdbg"><input name="t5" value="20" class="input" type="text" id="t5" size="40" maxlength="3" onKeyUp="value=value.replace(/[^\d]/g,'');"  onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''));"></td>
    </tr>
    <tr>
      <td align="center" class="tdbg"><input name="up4" type="checkbox" id="up4" value="1" />
      <label for="up4">关 键 字：</label></td>
      <td class="tdbg"><textarea name="t6" cols="60" rows="4" class="inputs"></textarea></td>
    </tr>
	<tr>
      <td align="center" class="tdbg"><input name="up5" type="checkbox" id="up5" value="1" />
      <label for="up5">描　　述：</label></td>
      <td class="tdbg"><textarea name="t7" cols="60" rows="4" class="inputs"></textarea></td>
    </tr>
    <tr class="tdbg">
	  <td align="center"><strong>勾选才更新</strong></td>
      <td><input type="submit" class="bnt" value="保存设置"> <input type="button" onClick="history.go(-1)" class="bnt" value="放弃返回"></td>
    </tr>
	</form>
  </table>
<%
End Sub

Sub Batch_Save
	Dim t0,t1,t2,t3,t4,t5,t6,t7,up1,up2,up3,up4,up5,t00,I,Rs,Sql
	t0=Trim(Request.Form("t0"))
	t1=Trim(Request.Form("t1"))
	t2=Trim(Request.Form("t2"))
	t3=Trim(Request.Form("t3"))
	t4=Trim(Request.Form("t4"))
	t5=Trim(Request.Form("t5"))
	t6=Trim(Request.Form("t6"))
	t7=Trim(Request.Form("t7"))
	up1=Trim(Request.Form("up1"))
	up2=Trim(Request.Form("up2"))
	up3=Trim(Request.Form("up3"))
	up4=Trim(Request.Form("up4"))
	up5=Trim(Request.Form("up5"))
	IF t0="" Then Alert "至少选择一个类别","?action=batch":Exit Sub
	t00=Split(t0,", ")
	For I=0 To Ubound(t00)
		IF Len(up1&up2&up3&up4&up5)>0 Then
			Set Rs=Server.CreateObject("Adodb.RecordSet")
			Sql="Select Class_type,Channel_temp,List_temp,Show_temp,Pagenum,Keyword,Class_Desc From "&Sd_Table&" where id="&t00(I)&""
			Rs.Open Sql,Conn,1,3
			DbQuery=DbQuery+1
			Rs.Update
			IF Len(up1)>0 Then Rs(0)=t1
			IF Len(up1)>0 Then Rs(1)=t2
			IF Len(up1)>0 Then Rs(2)=t3
			IF Len(up2)>0 Then Rs(3)=t4
			IF Len(up3)>0 Then Rs(4)=t5
			IF Len(up4)>0 Then Rs(5)=t6
			IF Len(up5)>0 Then Rs(6)=t7
			Rs.Update
			Rs.Close
			Set Rs=Nothing
		End IF
	Next
	Alert "设置成功","?"
End Sub

Sub Move_Class
	Dim Old
	Dim ID:ID=IsNum(Trim(Request.QueryString("ID")),0)
	Set Old=Conn.Execute("select followid,title From "&Sd_Table&" Where Id="&ID&"")
	DbQuery=DbQuery+1
	IF Old.Eof Then
		Old.Close
		Set Old=Nothing
		Go "?"
		Exit Sub
	Else
		Dim Followid
		Followid=Old(0)
		Title=Old(1)
		Old.Close
		Set Old=Nothing
	End IF
%>
  <table width="98%" border="0" align="center" cellpadding="3" cellspacing="1" class="table_b">
  <form method="post" action="?action=movesave&id=<%=ID%>">
    <tr>
      <td width="120" align="center" class="tdbg01">当前栏目：</td>
      <td class="tdbg01"><%=Title%></td>
    </tr>
    <tr>
      <td align="center" class="tdbg">目标栏目：</td>
      <td class="tdbg"><select name="t0" size="20" multiple="multiple" id="t0" style="width:60%;">
        <option value="0" <%=IIF(followid=0,"selected","")%>>作为一级分类</option><%=Get_Class(Followid)%></select>      </td>
    </tr> 
    <tr class="tdbg">
	  <td align="center"></td>
      <td><input type="submit" class="bnt" value="保存设置"> <input type="button" onClick="history.go(-1)" class="bnt" value="放弃返回"></td>
    </tr>
	</form>
  </table>
<%
End Sub

Sub Move_Class_Save
	Dim t0,old,Old_Followid,Old_allclassid,Old_partentid,Old_allclassid01,Old_Followid_Num
	Dim ID:ID=IsNum(Trim(Request.QueryString("ID")),0)
	t0=Trim(Request.Form(("t0")))
	Set Old=Conn.Execute("select followid,allclassid,partentid From "&Sd_Table&" Where Id="&ID&"")
	DbQuery=DbQuery+1
	IF Old.Eof Then
		Old.Close
		Set Old=Nothing
		Go "?"
		Exit Sub
	Else
		Old_Followid=Old(0)
		Old_allclassid=Old(1)
		Old_partentid=Old(2)
		Old.Close
		Set Old=Nothing
		Old_Followid_Num=Conn.Execute("Select Count(id) From "&Sd_Table&" Where Followid="&ID&"")(0)
		DbQuery=DbQuery+1
	End IF
	IF Clng(t0)=Clng(Old_Followid) Then
		Echo "没有移动"
		Exit Sub
	End IF
	Old_allclassid01=Re(","&Old_allclassid&",",""&ID&"","")
	IF Instr(","&Old_allclassid01&",",","&t0&",")>0 Then
		Echo "不可以移动到下级分类"
		Exit Sub
	End IF
	IF Clng(t0)=Clng(ID) Then
		Echo "不可以移动自己下面"
		Exit Sub
	End IF
	'如果目标ID为0
	IF t0=0 Then
		Dim Rs,O_partentid,N_partentid
		Dim Rs1,O_allclassid,N_allclassid
		IF Old_Followid_Num=0 Then'如果没有下级类别
			Set Rs=Conn.Execute("Select ID,partentid From "&Sd_Table&" Where Id In("&Old_allclassid&") Order By Id Desc")
			DbQuery=DbQuery+1
			While Not Rs.Eof
				'先去掉所有父类别中本类的ID
				Set Rs1=Conn.Execute("Select ID,allclassid From "&Sd_Table&" Where Id In("&Old_partentid&") and id<>"&Rs(0)&" Order By Id")
				While Not Rs1.Eof
					N_allclassid=Re(","&Rs1(1)&",",","&Rs(0)&",",",")
					IF Left(N_allclassid,1)="," Then N_allclassid=Right(N_allclassid,Len(N_allclassid)-1)
					IF Right(N_allclassid,1)="," Then N_allclassid=Left(N_allclassid,Len(N_allclassid)-1)
					Conn.Execute("Update "&Sd_Table&" Set allclassid='"&N_allclassid&"' Where ID="&Rs1(0)&"")
				Rs1.MoveNext
				Wend
				Rs1.Close
				Set Rs1=Nothing
				'然后调整所有子类别所属父类别
				N_partentid=Re(","&Rs(0)&","&Rs(1)&",",","&Old_partentid&",",",")
				IF Left(N_partentid,1)="," Then N_partentid=Right(N_partentid,Len(N_partentid)-1)
				IF Right(N_partentid,1)="," Then N_partentid=Left(N_partentid,Len(N_partentid)-1)
				Conn.Execute("Update "&Sd_Table&" Set partentid='"&N_partentid&"' Where ID="&Rs(0)&"")
				DbQuery=DbQuery+1
			Rs.MoveNext
			Wend
			Rs.Close
			Set Rs=Nothing
			Conn.Execute("update "&Sd_Table&" set followid=0 where id="&ID&"")
			DbQuery=DbQuery+1
			Re_Depth'重计类别层级
			Echo "转移成功"
		Else'如果有下级类别
			'首先更新其父类别的所有子类别
			Set Rs=Conn.Execute("Select ID,allclassid From "&Sd_Table&" Where Id In("&Old_partentid&") And ID<>"&ID&" Order By Id Desc")
			DbQuery=DbQuery+1
			While Not Rs.Eof
				N_allclassid=Re(","&Rs(1)&",",","&Old_allclassid&",",",")
				IF Left(N_allclassid,1)="," Then N_allclassid=Right(N_allclassid,Len(N_allclassid)-1)
				IF Right(N_allclassid,1)="," Then N_allclassid=Left(N_allclassid,Len(N_allclassid)-1)
				Conn.Execute("Update "&Sd_Table&" Set allclassid='"&N_allclassid&"' Where ID="&Rs(0)&"")
				DbQuery=DbQuery+1
			Rs.MoveNext
			Wend
			Rs.Close
			Set Rs=Nothing
			'其次将所有下级类别中的此类别的Followid去掉(这里可能有问题)
			'调整原来ID及子ID的父ID(去掉原ID的父ID)
			'更新ID所有子类别的父类别
			Dim Old_Old_Old_partentid
			Old_Old_Old_partentid=Re(","&Old_partentid&",",","&ID&",","")
			IF Left(Old_Old_Old_partentid,1)="," Then Old_Old_Old_partentid=Right(Old_Old_Old_partentid,Len(Old_Old_Old_partentid)-1)
			IF Right(Old_Old_Old_partentid,1)="," Then Old_Old_Old_partentid=Left(Old_Old_Old_partentid,Len(Old_Old_Old_partentid)-1)
			Set Rs=Conn.Execute("Select ID,partentid From "&Sd_Table&" Where Id In("&Old_allclassid&")  Order By Id Desc")
			DbQuery=DbQuery+1
			While Not Rs.Eof
				N_partentid=Re(","&Rs(1)&",",","&Old_Old_Old_partentid&",",",")
				IF Left(N_partentid,1)="," Then N_partentid=Right(N_partentid,Len(N_partentid)-1)
				IF Right(N_partentid,1)="," Then N_partentid=Left(N_partentid,Len(N_partentid)-1)
				Conn.Execute("Update "&Sd_Table&" Set partentid='"&N_partentid&"' Where ID="&Rs(0)&"")
				DbQuery=DbQuery+1
			Rs.MoveNext
			Wend
			Rs.Close
			Set Rs=Nothing
			Conn.Execute("update "&Sd_Table&" set followid=0 where id="&ID&"")
			DbQuery=DbQuery+1
			Re_Depth'重计类别层级
			Echo "转移成功"
		End IF
	Else
		'如果目标ID不为0
		'首先要去掉原来的子类别中所继承的父类别ID，然后换上新的父类别ID
		'获得目标ID父类
		Dim New_allclassid,New_partentid
		Set Rs=Conn.Execute("Select allclassid,partentid From "&Sd_Table&" Where Id="&t0&"")
		DbQuery=DbQuery+1
		IF Rs.Eof Then
			Echo "来源错误":Exit Sub
		Else
			New_allclassid=Rs(0)
			New_partentid=Rs(1)
		End IF
		Rs.Close
		Set Rs=Nothing

		'如果原父ID=0，那么直接加
		IF Old_Followid=0 Then
			'将目标ID的所有父类加上此ID开始
			Set Rs=Conn.Execute("Select ID,allclassid From "&Sd_Table&" Where Id In("&New_partentid&")")
			DbQuery=DbQuery+1
			While Not Rs.Eof
				Conn.Execute("Update "&Sd_Table&" Set allclassid='"&Rs(1)&","&Old_allclassid&"' Where ID="&Rs(0)&"")
			Rs.MoveNext
			Wend
			Rs.Close
			Set Rs=Nothing
			'将目标ID的所有父类加上此ID结束
			
			IF Old_Followid_Num=0 Then'如果此ID没有下级类别
				Conn.Execute("Update "&Sd_Table&"  Set partentid='"&ID&","&New_partentid&"' Where ID="&ID&"")
				DbQuery=DbQuery+1
			Else
				'调整原来ID及子ID的父ID(去掉原ID的父ID)
				'更新ID所有子类别的父类别和层级
				Dim O_o_o_o_partentid,N_n_n_n_partentid
				Set Rs=Conn.Execute("Select ID,partentid From "&Sd_Table&" Where Id In ("&Old_allclassid&")")
				DbQuery=DbQuery+1
				While Not Rs.Eof
					O_o_o_o_partentid=","&Rs(1)&","
					N_n_n_n_partentid=Re(O_o_o_o_partentid,","&Old_Followid&",",",")
					IF Left(N_n_n_n_partentid,1)="," Then N_n_n_n_partentid=Right(N_n_n_n_partentid,Len(N_n_n_n_partentid)-1)
					IF Right(N_n_n_n_partentid,1)="," Then N_n_n_n_partentid=Left(N_n_n_n_partentid,Len(N_n_n_n_partentid)-1)
					Conn.Execute("Update "&Sd_Table&"  Set partentid='"&N_n_n_n_partentid&","&New_partentid&"' Where ID="&Rs(0)&"")
					DbQuery=DbQuery+1
				Rs.MoveNext
				Wend
				Rs.Close
				Set Rs=Nothing
			End IF
		Else
			'如果原父ID<>0,否则要先去掉原ID的所有父ID的子类
			Dim O_o_o_partentid,O_o_partentid,N_n_partentid
			O_o_o_partentid=Re(Old_partentid,ID&",","")
			Set Rs=Conn.Execute("Select ID,allclassid From "&Sd_Table&" Where Id In("&O_o_o_partentid&")")
			DbQuery=DbQuery+1
			While Not Rs.Eof
				N_n_partentid=Re(","&Rs(1)&",",","&Old_allclassid&",",",")
				IF Left(N_n_partentid,1)="," Then N_n_partentid=Right(N_n_partentid,Len(N_n_partentid)-1)
				IF Right(N_n_partentid,1)="," Then N_n_partentid=Left(N_n_partentid,Len(N_n_partentid)-1)
				Conn.Execute("Update "&Sd_Table&" Set allclassid='"&N_n_partentid&"' Where ID="&Rs(0)&"")
				DbQuery=DbQuery+1
			Rs.MoveNext
			Wend
			Rs.Close
			Set Rs=Nothing
			'将目标ID的所有父类加上此ID开始
			Set Rs=Conn.Execute("Select ID,allclassid From "&Sd_Table&" Where Id In("&New_partentid&")")
			DbQuery=DbQuery+1
			While Not Rs.Eof
				Conn.Execute("Update "&Sd_Table&" Set allclassid='"&Rs(1)&","&Old_allclassid&"' Where ID="&Rs(0)&"")
				DbQuery=DbQuery+1
			Rs.MoveNext
			Wend
			Rs.Close
			Set Rs=Nothing
			
			IF Old_Followid_Num=0 Then'如果没有下级类别
				Conn.Execute("Update "&Sd_Table&"  Set partentid='"&ID&","&New_partentid&"' Where ID="&ID&"")
				DbQuery=DbQuery+1
			Else
				'调整原来ID及子ID的父ID(去掉原ID的父ID)
				'更新ID所有子类别的父类别
				Dim Old_Old_partentid
				Old_Old_partentid=Re(","&Old_partentid&",",","&ID&",","")
				IF Left(Old_Old_partentid,1)="," Then Old_Old_partentid=Right(Old_Old_partentid,Len(Old_Old_partentid)-1)
				IF Right(Old_Old_partentid,1)="," Then Old_Old_partentid=Left(Old_Old_partentid,Len(Old_Old_partentid)-1)
					
				Dim O_o_o_o_o_partentid,N_n_n_n_n_partentid
				Set Rs=Conn.Execute("Select ID,partentid From "&Sd_Table&" Where Id In ("&Old_allclassid&")")
				DbQuery=DbQuery+1
				While Not Rs.Eof
					O_o_o_o_o_partentid=","&Rs(1)&","
					N_n_n_n_n_partentid=Re(O_o_o_o_o_partentid,","&Old_Old_partentid&",",",")
					IF Left(N_n_n_n_n_partentid,1)="," Then N_n_n_n_n_partentid=Right(N_n_n_n_n_partentid,Len(N_n_n_n_n_partentid)-1)
					IF Right(N_n_n_n_n_partentid,1)="," Then N_n_n_n_n_partentid=Left(N_n_n_n_n_partentid,Len(N_n_n_n_n_partentid)-1)
					Conn.Execute("Update "&Sd_Table&"  Set partentid='"&N_n_n_n_n_partentid&","&New_partentid&"' Where ID="&Rs(0)&"")
					DbQuery=DbQuery+1
				Rs.MoveNext
				Wend
				Rs.Close
				Set Rs=Nothing
			End IF
		End IF
		Conn.Execute("Update "&Sd_Table&" Set Followid="&t0&" Where id="&ID&"")
		DbQuery=DbQuery+1
		Re_Depth'重计类别层级
		Echo "转移成功"
	End IF
End Sub

Sub Del
	IF Load_Cookies("sdcms_admin")=0 Then
		IF Instr(Session(sdcms_cookies&"sdcms_infoalllever"),ID&"|3")=0 Then Echo "您没有此栏目的删除权限":Died
	End IF
	Dim Rs,class_num,ID
	ID=IsNum(Trim(Request.QueryString("ID")),0)
	Class_Num=Conn.Execute("Select Count(id) From "&Sd_Table&" Where Followid="&ID&"")(0)
	DbQuery=DbQuery+1
	Set Rs=Conn.Execute("Select followid,ClassUrl,partentid From "&Sd_Table&" where id="&id&"")
	IF class_num>0 Then
		Echo "不能删除有下级分类的分类":Exit Sub
	Else
		AddLog sdcms_adminname,GetIp,"删除分类："&LoadRecord("title",Sd_Table,id),0
		IF Sdcms_Mode=2 Then Del_Folder sdcms_root&sdcms_htmdir&Rs(1)
		'清除父类别中含有本类别的所有ID
		Set Rs=Conn.Execute("Select ID,allclassid From "&Sd_Table&" Where Id In("&Rs(2)&")")
		DbQuery=DbQuery+1
		While Not Rs.Eof
			Conn.Execute("Update "&Sd_Table&" Set allclassid='"&Re(Rs(1),","&ID,"")&"' Where ID="&Rs(0)&"")
			DbQuery=DbQuery+1
		Rs.MoveNext
		Wend
		Rs.Close
		Set Rs=Nothing
		Conn.Execute("Delete From "&Sd_Table&" Where Id="&ID&"")
		Conn.Execute("Delete From Sd_Info Where Classid="&ID&"")
		DbQuery=DbQuery+2
		'严格意义上来讲，这里还应该更新下全站
	End IF
	Go "?"
End Sub

Sub Make_C_List
	IF Load_Cookies("sdcms_admin")=0 Then
		IF Instr(Session(sdcms_cookies&"sdcms_infoalllever"),ID&"|2")=0 Then Echo "您没有此栏目的编辑权限":Died
	End IF
	Dim ID:ID=IsNum(Trim(Request.QueryString("ID")),0)
	Dim Rs
	Set Rs=Conn.Execute("Select AllClassID,PageNum,Class_Type From "&Sd_Table&" Where ID="&ID&"")
	IF Rs.Eof Then
		Echo "参数错误"
	Else
		IF Rs(2)=1 Then
			Dim Sdcms_C
			Set Sdcms_C=New Sdcms_Create
			Sdcms_C.Create_Channel ID
			Set Sdcms_C=Nothing
		Else
			Dim This_Count,TotalPage
			This_Count=Conn.Execute("Select Count(ID) From Sd_Info Where IsPass=1 And ClassID In("&Rs(0)&")")(0)
			TotalPage=Abs(Int(-Abs(This_Count/Rs(1))))
			IF TotalPage=0 Then TotalPage=1
			Go "?action=pagelist&id="&id&"&TotalPage="&TotalPage&"&page=1"
		End IF
	End IF
	Rs.Close
	Set Rs=Nothing
End Sub

Sub Mack_Page_List
	Dim ID:ID=IsNum(Trim(Request.QueryString("ID")),0)
	Dim TotalPage:TotalPage=IsNum(Trim(Request.QueryString("TotalPage")),0)
	Dim Pages:Pages=IsNum(Trim(Request.QueryString("Page")),0)
	Echo "<br>总计需要生成："&TotalPage&" 页 已生成："&Pages&" 页<br><br>"
	Dim Sdcms_C
	Set Sdcms_C=New Sdcms_Create
	Sdcms_C.Create_I_List ID
	Set Sdcms_C=Nothing
	Pages=Pages+1
	
	IF Pages<=TotalPage Then
		Echo "<script>setTimeout(""location.href='?action=pagelist&id="&id&"&TotalPage="&TotalPage&"&page="&Pages&"';"",""1000"");</script>"
	Else
		Echo "<br>全部生成完毕"
	End IF

End Sub

Function Check_Add
	Check_Add="<script>"&vbcrlf
	Check_Add=Check_Add&"function checkadd()"&vbcrlf
	Check_Add=Check_Add&"{"&vbcrlf
	Check_Add=Check_Add&"if (document.add.t0.value=='')"&vbcrlf
	Check_Add=Check_Add&"{"&vbcrlf
	Check_Add=Check_Add&"alert('分类名称不能为空');"&vbcrlf
	Check_Add=Check_Add&"document.add.t0.focus;"&vbcrlf
	Check_Add=Check_Add&"return false"&vbcrlf
	Check_Add=Check_Add&"}"&vbcrlf
	Check_Add=Check_Add&"if (document.add.t1.value=='')"&vbcrlf
	Check_Add=Check_Add&"{"&vbcrlf
	Check_Add=Check_Add&"alert('生成的目录不能为空');"&vbcrlf
	Check_Add=Check_Add&"document.add.t1.focus;"&vbcrlf
	Check_Add=Check_Add&"return false"&vbcrlf
	Check_Add=Check_Add&"}"&vbcrlf
	Check_Add=Check_Add&"}"&vbcrlf
	Check_Add=Check_Add&"</script>"&vbcrlf
End Function

Function Get_Max_Depth(ByVal t0)
	Dim Rs_Max
	t0=IsNum(t0,0)
	Set Rs_Max=Conn.Execute("Select Depth From "&Sd_Table&" Where id="&t0&"")
	DbQuery=DbQuery+1
	IF Rs_Max.Eof Then
		Get_Max_Depth=1
	Else
		IF Len(Rs_Max(0))=0 Then
			Get_Max_Depth=1
		Else
			Get_Max_Depth=Rs_Max(0)+1
		End IF
	End IF
	Rs_Max.Close
	Set Rs_Max=Nothing
End Function

Sub Re_Depth
	Dim Rs_Depth,Depth
	Set Rs_Depth=Conn.Execute("Select id,partentid From "&Sd_Table&"")
	DbQuery=DbQuery+1
	While Not Rs_Depth.Eof
		Depth=Ubound(Split(Rs_Depth(1),","))+1
		Conn.Execute("Update "&Sd_Table&" Set Depth="&Depth&" Where Id="&Rs_Depth(0)&"")
		DbQuery=DbQuery+1
	Rs_Depth.MoveNext
	Wend
	Rs_Depth.Close
	Set Rs_Depth=Nothing
End Sub
%>  
</div>
</body>
</html>