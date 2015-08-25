<!--#include file="sdcms_check.asp"-->
<%
Dim sdcms,Sd_Table,title,stype,Action
Action=Lcase(Trim(Request.QueryString("Action")))
Set sdcms=New Sdcms_Admin
sdcms.Check_admin
Select Case action
	Case "add":title="添加广告"
	Case "edit":title="修改广告"
	Case "getcode":title="调用广告"
	Case Else:stype=1:title="广告管理"
End Select
Sd_Table="sd_ad"
Sdcms_Head
%>

<div class="sdcms_notice"><span>管理操作：</span><a href="?action=add">添加广告</a>　┊　<a href="?">广告管理</a></div>
<br>
<ul id="sdcms_sub_title">
	<li class="sub"><%=title%></li>
	 
</ul>
<div id="sdcms_right_b">
<%
Select Case Action
	Case "add":sdcms.Check_lever 21:add
	Case "edit":sdcms.Check_lever 22:add
	Case "save":save
	Case "del":sdcms.Check_lever 23:del
	Case "getcode":getcode
	Case "pass":sdcms.Check_lever 22:pass
	Case Else:main
End Select
Db_Run
CloseDb
Set sdcms=Nothing
Sub Main
%>
  <table border="0" align="center" cellpadding="3" cellspacing="1" class="table_b" id="tagContent0">
    <tr>
      <td width="60" class="title_bg">编号</td>
      <td class="title_bg">网站广告</td>
      <td width="80" class="title_bg">类别</td>
	  <td width="150" class="title_bg">日期</td>
	  <td width="60" class="title_bg">状态</td>
      <td width="160" class="title_bg">管理</td>
    </tr>
	<%
	Dim Sql,rs
	Sql="select id,title,url,ispic,adddate,followid,ispass from "&Sd_Table&" where followid<=0 order by id desc"
	Set Rs=Conn.Execute(sql)
	DbQuery=DbQuery+1
	While Not Rs.Eof
	%>
    <tr onmouseover=this.bgColor='#EEFEED'; onmouseout=this.bgColor='#ffffff';  bgcolor='#ffffff'>
      <td height="25" align="center" class="tdbg"><%=Rs(0)%></td>
	  <td><%=Rs(1)%></td>
	  <td align="center" class="tdbg"><%
	  IF Rs(5)=0 Then
		  Echo "广告类别"
	  Else
		  Select Case Rs(3)
			  Case "0":Echo "文字广告"
			  Case "1":Echo "图片广告"
			  Case "2":Echo "Flash广告"
			  Case "3":Echo "代码广告"
		  End Select
	  End IF
	   %></td>
	   <td align="center"><%=Rs(4)%></td>
	   <td align="center" class="tdbg"><%=IIF(Rs(6)=0,"未审","已审")%></td>
      <td align="center"><input type="button"  class="bnt01" value="调用" onClick="location.href='?action=getcode&id=<%=rs(0)%>';" <%=IIF(Rs(5)=0,"disabled=""disabled""","已审")%>> <input type="button" onClick="location.href='?action=edit&id=<%=rs(0)%>';" class="bnt01" value="编辑"> <input type="button"  onClick="if(confirm('真的要删除?不可恢复!'))location.href='?action=del&id=<%=rs(0)%>';return false;" class="bnt01" value="删除"></td>
    </tr>
	<%
	Dim rs1
	Sql="select id,title,url,ispic,adddate,followid,ispass from "&Sd_Table&" where Followid="&rs(0)&" order by id desc"
	Set rs1=Conn.Execute(sql)
	DbQuery=DbQuery+1
	While Not Rs1.eof
	%>
	<tr onmouseover=this.bgColor='#EEFEED'; onmouseout=this.bgColor='#ffffff';  bgcolor='#ffffff'>
      <td height="25" align="center" class="tdbg"><%=rs1(0)%></td>
	  <td>　├ <%=rs1(1)%></td>
	  <td align="center" class="tdbg"><%
		  Select Case rs1(3)
			  Case "0":echo "文字广告"
			  Case "1":echo "图片广告"
			  Case "2":echo "Flash广告"
			  Case "3":echo "代码广告"
		  End Select
	   %></td>
	   <td align="center"><%=rs1(4)%></td>
	   <td align="center" class="tdbg"><%=IIF(Rs1(6)=0,"未审","已审")%></td>
      <td align="center"><input type="button"  class="bnt01" value="调用" onClick="location.href='?action=getcode&id=<%=rs1(0)%>';"> <input type="button" onClick="location.href='?action=edit&id=<%=rs1(0)%>';" class="bnt01" value="编辑"> <input type="button"  onClick="if(confirm('真的要删除?不可恢复!'))location.href='?action=del&id=<%=rs1(0)%>';return false;" class="bnt01" value="删除"></td>
    </tr>
	<%
	Rs1.MoveNext
	Wend
	Rs1.Close:Set Rs1=Nothing
	Rs.movenext
	Wend
	Rs.Close:Set Rs=Nothing
	%>
  </table>
   
<%
End Sub

Sub Add
	Dim Rs,ID,I
	ID=IsNum(Trim(Request.QueryString("ID")),0)
	IF ID>0 Then
		Set Rs=Conn.Execute("select title,followid,ispic,pic,ad_w,ad_h,url,ispass,content from "&Sd_Table&" where id="&id&"")
		DbQuery=DbQuery+1
		IF Rs.Eof Then
			Echo "请勿非法提交参数":Exit Sub
		Else
			Dim t0,t1,t2,t3,t4,t5,t6,t7,t8,t9
			t0=Rs(0)
			t1=Rs(1)
			t2=Rs(2)
			t3=Rs(3)
			t4=Rs(4)
			t5=Rs(5)
			t6=Rs(6)
			t7=Rs(7)
			t8=Rs(8)
			t9=Conn.Execute("select count(id) from "&Sd_Table&" where followid="&ID&"")(0)
		End IF
		Rs.Close
		Set Rs=Nothing
	Else
		t7=1:t9=0
	End IF
	Echo Check_Add	
%>
  <table width="98%" border="0" align="center" cellpadding="3" cellspacing="1">
  <form name="add" method="post" action="?action=save&id=<%=id%>" onSubmit="return checkadd()">
     <tr>
      <td width="120" align="center" class="tdbg">名　　称：</td>
      <td class="tdbg"><input name="t0" type="text" class="input" id="t0" size="50" value="<%=t0%>"></td>
    </tr>
	<tr <%IF t9>0 Then%>class="dis"<%end if%>>
      <td width="120" align="center" class="tdbg">选　　项： </td>
      <td class="tdbg"><input name="t1" type="radio" value="0"  <%=IIF(t1=0,"checked","")%>  onclick="<%for i=0 to 4%>$('#ad0<%=i%>')[0].style.display='none';<%next%>this.form.t6.disabled=true;" id="t1_0"><label for="t1_0">作为类别</label> <input name="t1" type="radio" value="1" <%=IIF(t1<>0,"checked","")%> onclick="<%for i=0 to 2%>$('#ad0<%=i%>')[0].style.display='block';<%next%>this.form.t6.disabled=false;this.form.t9.disabled=true;" id="t1_1"><label for="t1_1">作为广告</label></td>
    </tr>
	<tr class="tdbg<%=IIF(t1=0," dis","")%>" id="ad00">
      <td width="120" align="center">广告类别：</td>
      <td>
	  <input name="t2" type="radio" onClick="$('#ad03')[0].style.display='none';$('#ad04')[0].style.display='none';<%for i=1 to 2%>$('#ad0<%=i%>')[0].style.display='block';<%next%>this.form.t3.disabled=true;this.form.t6.disabled=false;this.form.t9.disabled=true;" value="0" <%=IIF(t2=0,"checked","")%> id="t2_0"><label for="t2_0">文字广告</label> 
	  <input name="t2" type="radio" onClick="<%for i=1 to 3%>$('#ad0<%=i%>')[0].style.display='block';<%next%>$('#ad04')[0].style.display='none';this.form.t3.disabled=false;this.form.t6.disabled=false;this.form.t9.disabled=true;" value="1" <%=IIF(t2=1,"checked","")%> id="t2_1"><label for="t2_1">图片广告</label>
	  <input name="t2" type="radio" onClick="<%for i=1 to 1%>$('#ad0<%=i%>')[0].style.display='none';<%next%>$('#ad02')[0].style.display='none';$('#ad04')[0].style.display='none';$('#ad03')[0].style.display='block';this.form.t3.disabled=false;this.form.t6.disabled=true;this.form.t9.disabled=true;" value="2" <%=IIF(t2=2,"checked","")%> id="t2_2"><label for="t2_2">Flash广告</label> <input name="t2" type="radio" onClick="<%for i=1 to 3%>$('#ad0<%=i%>')[0].style.display='none';<%next%>$('#ad04')[0].style.display='block';this.form.t3.disabled=true;this.form.t6.disabled=true;this.form.t9.disabled=false;" value="3" <%=IIF(t2=3,"checked","")%> id="t2_3"><label for="t2_3">广告代码</label></td>
    </tr>
    <tr class="tdbg<%if t1=0 or t2<1 or t2>2 then%> dis<%end if%>" id="ad03">
      <td  width="120" align="center">广告文件：</td>
      <td><input name="t3" type="text" class="input" id="t3" size="50" <%if t1=0 or t2<1 or t2>2 then%>disabled="disabled"<%end if%> value="<%=t3%>">
	  宽：
	    <input name="t4" type="text" class="input"  maxlength="4" size="3" onKeyUp="value=value.replace(/[^\d]/g,'');"  onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''));" value="<%=t4%>"> 
	    高：
	    <input name="t5" type="text" class="input"  maxlength="4" size="3" onKeyUp="value=value.replace(/[^\d]/g,'');"  onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''));" value="<%=t5%>">	  
	  <br><%admin_upfile 1,"100%","20","t3","UpLoadIframe",0,0%>
	  </td>
    </tr>
	<tr class="tdbg<%if t1=0 or t2>=2 then%> dis<%end if%>" id="ad01">
      <td  width="120" align="center">网　　址：      </td>
      <td><input name="t6" type="text" class="input" id="t1" size="50" <%if t1=0 or t2>=2 then%>disabled="disabled"<%end if%> value="<%=t6%>"></td>
    </tr>
	<tr class="tdbg<%if t1=0 or t2<3 then%> dis<%end if%>" id="ad04">
      <td width="120" align="center">代　　码：</td>
      <td><textarea name="t9"  rows="16"  class="inputs" <%if t1=0 or t2<3 then%>disabled="disabled"<%end if%> ><%=Content_Encode(t8)%></textarea><span>支持Google、Baidu、Alimama等广告代码，直接粘贴进来即可。</span></td>
    </tr>
	<tr class="tdbg<%if t1=0 Or t2=3 then %> dis<%end if%>" id="ad02">
      <td width="120" align="center">类　　别：      </td>
      <td><select name="t7" >
	    <option value="-1" <%=IIF(t1=-1,"selected","")%>>不使用类别</option>
		<%
		Dim rs1
		Set rs1=conn.execute("select id,title from "&Sd_Table&" where Followid=0 order by id desc")
		While Not Rs1.eof
		%>
		<option value="<%=rs1(0)%>" <%=IIF(Clng(t1)=Rs1(0),"selected","")%>><%=rs1(1)%></option>
		<%Rs1.Movenext:Wend:Rs1.Close:Set Rs1=Nothing%>
	    </select></td>
    </tr>
	<tr class="tdbg">
      <td align="center">验　　证：      </td>
      <td><input name="t8" type="checkbox" value="1"  id="t8" <%=IIF(t7=1,"checked","")%> /><label for="t8">已验证</label></td>
    </tr>
    <tr class="tdbg">
	  <td>&nbsp;</td>
      <td><input type="submit" class="bnt" value="保存设置"> <input type="button" onClick="history.go(-1)" class="bnt" value="放弃返回"></td>
    </tr>
	</form>
  </table>
<%
End Sub

Sub Getcode
	Dim Rs,ID:ID=IsNum(Trim(Request.QueryString("ID")),0)
	Set Rs=Conn.Execute("select id from "&Sd_Table&" where id="&id&"")
	DbQuery=DbQuery+1
	IF Rs.Eof Then
		Echo "请勿非法提交参数":Exit Sub
	End IF
	Rs.Close
	Set Rs=Nothing
%>
<table width="98%" border="0" align="center" cellpadding="3" cellspacing="1">
    <tr class="tdbg">
    <tr class="tdbg">
      <td align="center">代码：</td>
      <td><textarea name="get_c" rows="2" class="inputs"><script src="{sdcms:root}Plug/GG.asp?id=<%=id%>" language="javascript"></script></textarea></td>
    </tr>
    <tr class="tdbg">
      <td>&nbsp;</td>
      <td><input  type="button"   class="bnt" value="复制" onClick="CopyUrl(get_c);"> <input name="Submit22" type="button" onClick="history.go(-1)" class="bnt" value="返 回"></td>
    </tr>
</table>
<%
End Sub

Sub Save
	Dim t0,t1,t2,t3,t4,t5,t6,t7,t8,t9,rs,sql,LogMsg
	Dim ID:ID=IsNum(Trim(Request.QueryString("ID")),0)
	t0=FilterText(Trim(Request.Form("t0")),1)
	t1=IsNum(Trim(Request.Form("t1")),0)
	t2=IsNum(Trim(Request.Form("t2")),0)
	t3=FilterText(Trim(Request.Form("t3")),0)
	t4=IsNum(Trim(Request.Form("t4")),0)
	t5=IsNum(Trim(Request.Form("t5")),0)
	t6=FilterText(Trim(Request.Form("t6")),0)
	t7=IsNum(Trim(Request.Form("t7")),-1)
	t8=IsNum(Trim(Request.Form("t8")),0)
	t9=Trim(Request.Form("t9"))
	IF ID=0 Then sdcms.Check_lever 21 Else sdcms.Check_lever 22
	Set Rs=Server.CreateObject("adodb.recordset")
	Sql="select title,followid,ispic,pic,ad_w,ad_h,url,ispass,content,id,adddate From "&Sd_Table
	IF ID>0 Then 
		Sql=Sql&" where id="&id&""
	End IF
	Rs.Open Sql,Conn,1,3
	IF ID=0 Then 
		Rs.Addnew
	Else
		Rs.Update
	End IF
	Rs(0)=Left(t0,255)
	IF t1=0 Then
		Rs(1)=t1
	Else
		Rs(1)=t7
	End IF
	Rs(2)=t2
	Rs(3)=Left(t3,255)
	Rs(4)=Left(t4,4)
	Rs(5)=Left(t5,4)
	Rs(6)=Left(t6,255)
	Rs(7)=t8
	Rs(8)=t9
	IF ID=0 Then Rs(10)=Dateadd("h",Sdcms_TimeZone,Now())
	Rs.Update
	Rs.MoveLast
	IF ID=0 Then LogMsg="添加广告" Else LogMsg="修改广告"
	AddLog sdcms_adminname,GetIp,LogMsg&rs(0),0
	Del_Cache("Gg"&Rs(9))
	Rs.Close
	Set Rs=Nothing
	Go("?")
End Sub

Sub Del
	Dim ID:ID=IsNum(Trim(Request.QueryString("ID")),0)
	Del_Cache("Gg"&ID)
	Dim LogMsg:LogMsg="删除广告："
	AddLog sdcms_adminname,GetIp,LogMsg&loadrecord("title",Sd_Table,id),0
	Conn.Execute("Delete From "&Sd_Table&" Where id="&id&" Or Followid="&ID&"")
	Go("?") 
End Sub

Function Check_Add
	Check_Add="	<script>"&vbcrlf
	Check_Add=Check_Add&"	function checkadd()"&vbcrlf
	Check_Add=Check_Add&"	{"&vbcrlf
	Check_Add=Check_Add&"	if (document.add.t0.value=='')"&vbcrlf
	Check_Add=Check_Add&"	{"&vbcrlf
	Check_Add=Check_Add&"	alert('名称不能为空');"&vbcrlf
	Check_Add=Check_Add&"	document.add.t0.focus();"&vbcrlf
	Check_Add=Check_Add&"	return false"&vbcrlf
	Check_Add=Check_Add&"	}"&vbcrlf
	Check_Add=Check_Add&"	if (!document.add.t3.disabled && document.add.t3.value=='')"&vbcrlf
	Check_Add=Check_Add&"	{"&vbcrlf
	Check_Add=Check_Add&"	alert('广告文件不能为空');"&vbcrlf
	Check_Add=Check_Add&"	document.add.t3.focus();"&vbcrlf
	Check_Add=Check_Add&"	return false"&vbcrlf
	Check_Add=Check_Add&"	}"&vbcrlf
	Check_Add=Check_Add&"	if (!document.add.t6.disabled && document.add.t6.value=='')"&vbcrlf
	Check_Add=Check_Add&"	{"&vbcrlf
	Check_Add=Check_Add&"	alert('网址不能为空');"&vbcrlf
	Check_Add=Check_Add&"	document.add.t6.focus();"&vbcrlf
	Check_Add=Check_Add&"	return false"&vbcrlf
	Check_Add=Check_Add&"	}"&vbcrlf
	Check_Add=Check_Add&"	if (!document.add.t9.disabled && document.add.t9.value=='')"&vbcrlf
	Check_Add=Check_Add&"	{"&vbcrlf
	Check_Add=Check_Add&"	alert('广告代码不能为空');"&vbcrlf
	Check_Add=Check_Add&"	document.add.t9.focus();"&vbcrlf
	Check_Add=Check_Add&"	return false"&vbcrlf
	Check_Add=Check_Add&"	}"&vbcrlf
	Check_Add=Check_Add&"	}"&vbcrlf
	Check_Add=Check_Add&"	</script>"&vbcrlf
End Function
%>  
</div>
</body>
</html>