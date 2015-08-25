<!--#include file="sdcms_check.asp"-->
<%
Dim sdcms,Sd_Table,title,Action
Action=Lcase(Trim(Request.QueryString("Action")))
Set Sdcms=new Sdcms_Admin
Sdcms.Check_admin
Select Case Action
	Case "add":title="添加投票"
	Case "edit":title="修改投票"
	Case "show":title="查看投票"
	Case Else:title="投票管理"
End Select
Sd_Table="sd_vote"
Sdcms_Head
%>
<div class="sdcms_notice"><span>管理操作：</span><a href="?action=add">添加投票</a>　┊　<a href="?">投票管理</a></div>
<br>
<ul id="sdcms_sub_title">
	<li class="sub"><%=title%></li>
	
</ul>
<div id="sdcms_right_b">
<%
Select Case Action
	Case "add":sdcms.Check_lever 21:Add
	Case "edit":sdcms.Check_lever 22:Add
	Case "save":save
	Case "del":sdcms.Check_lever 23:Del
	Case "show":shows
	Case Else:Main
End Select
Db_Run
CloseDb
Set Sdcms=Nothing
Sub Main
%>
  <table border="0" align="center" cellpadding="3" cellspacing="1" class="table_b" id="tagContent0">
    <tr>
      <td width="60" class="title_bg">编号</td>
      <td class="title_bg">投票名称</td>
      <td width="160" class="title_bg">日期</td>
      <td width="160" class="title_bg">管理</td>
    </tr>
	<%
	Dim Rs,i
	Set Rs=Conn.Execute("select id,title,adddate  from "&Sd_Table&"   order by id desc")
	DbQuery=DbQuery+1
	While Not Rs.Eof
	%>
    <tr onmouseover=this.bgColor='#EEFEED'; onmouseout=this.bgColor='#ffffff';  bgcolor='#ffffff'>
	<%For I=0 To 2%>
      <td height="25" <%IF I<>1 then%>align="center"<%end if%>><%=Rs(I)%></td>
	  <%Next%>
      <td align="center"><a href='?action=show&id=<%=rs(0)%>'>查看</a> <a href="?action=edit&id=<%=Rs(0)%>">编辑</a> <a href="?action=del&id=<%=rs(0)%>" onclick='return confirm("真的要删除?不可恢复!");'>删除</a></td>
    </tr>
	<%Rs.MoveNext:Wend:Rs.Close:Set Rs=Nothing%>
  </table>
  
<%
End Sub
Sub Add
	Dim ID:ID=IsNum(Trim(Request.QueryString("ID")),0)
	IF ID>0 Then
		Dim Rs,i,vote,result
		Set Rs=Conn.Execute("select title,stype,vote,result from "&Sd_Table&" where id="&id&"")
		DbQuery=DbQuery+1
		IF Rs.Eof Then
			Echo "请勿非法提交参数":Exit Sub
		Else
			Dim t0,t1,t2,t3
			t0=Rs(0)
			t1=Rs(1)
			t2=Rs(2)
			t3=Rs(3)
		End IF
		Rs.Close
		Set Rs=Nothing
	Else
		t1=1
	End IF
	Echo Check_Add
%>
  <table width="98%" border="0" align="center" cellpadding="3" cellspacing="1">
  <form name="add" method="post" action="?action=save&id=<%=id%>" onSubmit="return checkadd()">
    <tr>
      <td width="9%" align="center" class="tdbg">投票名称：      </td>
      <td width="91%" class="tdbg"><input name="t0" type="text" class="input" value="<%=t0%>" id="t0" size="50"></td>
    </tr>
    <tr class="tdbg">
      <td align="center">投票选项：      </td>
      <td><input name="t1" type="radio" value="1" <%=IIF(t1=1,"checked","")%> id="t1_0"><label for="t1_0">单选</label> <input name="t1" type="radio" value="0" <%=IIF(t1=0,"checked","")%> id="t1_1"><label for="t1_1">多选</label></td>
    </tr>
    <tr class="tdbg">
      <td align="center">项目内容：</td>
      <td><input type="button" class="bnt" name="addvote" value="添加项目" onclick="Addvote();"> <input type="button" class="bnt" name="modifyvote" value="修改项目" onclick="return Modifyvote();"> <input type="button" class="bnt" name="delvote" value="删除项目" onclick="Delvote();"> <input class="bnt" onClick="changepos(content,-1)"  value="上 移" type="button"> <input class="bnt" onClick="changepos(content,1)" type="button" value="下 移"><br><input type="hidden" name="votes" value="" ><select class="inputs" name="content" style="width:400px;height:200px;margin-top:5px;" size="2" ondblclick="return Modifyvote();" >
	<%
	IF Len(t3)>0 Then
		result=split(t3,"|")
		vote=split(t2,"|")
		For I=0 to Ubound(vote)-1
			Echo "<option value="&vote(i)&"|"&result(i)&">"&Content_Encode(vote(i))&"|"&Content_Encode(result(i))&"</option>"
		next
	End IF
	%>
</select></td>
    </tr>
	 
    <tr class="tdbg">
	  <td>&nbsp;</td>
      <td><input type="submit" class="bnt" value="保存设置"> <input type="button" onClick="history.go(-1)" class="bnt" value="放弃返回"></td>
    </tr>
	</form>
  </table>
<%
End Sub

Sub Shows
	Dim ID:ID=IsNum(Trim(Request.QueryString("ID")),0)
	Dim rs,vote,result,total_vote,i
	Set Rs=Conn.Execute("select id,title,vote,result from sd_vote where id="&id&"")
	DbQuery=DbQuery+1
	IF Rs.Eof Then
		Go("?"):Exit Sub
	Else
		vote=rs(2)
		result=rs(3)
		total_vote=0
		vote=split(vote,"|")
		result=split(result,"|")
		For I=0 To Ubound(result)-1
			IF Not result(I)="" Then total_vote=result(i)+total_vote
		Next
	End IF
	Rs.Close
	Set Rs=Nothing
%>
<table width="98%" border="0" align="center" cellpadding="3" cellspacing="1" class="table_b">
     <tr>
      <td width="45%" align="center" class="title_bg" >选项      </td>
      <td width="45%" class="title_bg" >比例 </td>
      <td width="10%" class="title_bg" >票数</td>
    </tr>
	<%For I=0 To Ubound(vote)-1%>
    <tr class="tdbg">
	  <td height="25"><%Echo ""&i+1&". "&vote(i)&""%> (<%IF total_vote=0 Then Echo "0" Else Echo IIF(result(I)=0,"0",Formatpercent(result(I)/total_vote,0))%>)</td>
      <td><div style="border:1px solid #ccc;"><div style='width:<%IF total_vote=0 Then Echo "0" Else Echo IIF(result(I)=0,"0",Formatpercent(result(I)/total_vote,0))%>;background:#5BAA26;height:14px;'></div></div></td>
      <td align="center"><%=result(I)%></td>
    </tr>
	<%Next%>
	<tr>
      <td colspan="2" align="center" class="tdbg" ><input type="button" onClick="location.href='?action=edit&id=<%=ID%>'" class="bnt01" value="编辑">　<input type="button" onClick="history.go(-1)" class="bnt01" value="返回"></td>
      <td align="center" class="tdbg" >总数：<%=total_vote%></td>
	</tr>

  </table>
<%
End Sub

Sub Save
	Dim ID:ID=IsNum(Trim(Request.QueryString("ID")),0)
	Dim t0,t1,votes,vote,result,i,somevote,j,s,s1,rs,sql,LogMsg
	t0=FilterText(Trim(Request.Form("t0")),1)
	t1=IsNum(Trim(Request.Form("t1")),0)
	votes=FilterHtml(Trim(Request.Form("votes")))
	IF ID=0 Then sdcms.Check_lever 21 Else sdcms.Check_lever 22
	IF Len(votes)=0 Then
		Alert "项目内容不能为空","javascript:history.go(-1)":Exit Sub
	End IF
	 
	votes=Split(votes,",")
	For i=0 To (Ubound(votes)-1)
		IF Not Instr(votes(i),"|")>0 Then
			Alert "投票选项"&i+1&"有错误","javascript:history.go(-1)":Exit Sub
		End IF
		somevote=Split(votes(i),"|")
		For J=0 To Ubound(somevote)
		s=somevote(0)
		s1=somevote(1)
		IF Not Isnumeric(s1) Then
			Alert "投票选项"&i+1&"有错误","javascript:history.go(-1)":Exit Sub
		End IF
		Next  
		vote=vote&s&"|"
		result=result&s1&"|"
	Next
	
	Set Rs=Server.CreateObject("adodb.recordset")
	Sql="Select id,vote,result,title,stype,adddate From "&Sd_Table&""
	IF ID>0 Then 
		Sql=Sql&" where id="&ID
	End IF
	Rs.Open Sql,Conn,1,3
	
	IF ID=0 Then 
		Rs.Addnew
	Else
		Rs.Update
	End IF
	rs(1)=vote
	rs(2)=result
	rs(3)=t0
	rs(4)=t1
	IF ID=0 Then Rs(5)=Dateadd("h",Sdcms_TimeZone,Now())
	Rs.Update
	Rs.Close
	Set Rs=Nothing
	IF ID=0 Then LogMsg="添加投票" Else LogMsg="修改投票"
	AddLog sdcms_adminname,GetIp,LogMsg&t0,0
	Go("?")
End Sub

Sub Del
	Dim ID:ID=IsNum(Trim(Request.QueryString("ID")),0)
	AddLog sdcms_adminname,GetIp,"删除投票：编号为"&id,0
	Conn.Execute("Delete From "&Sd_Table&" Where id="&id&"")
	Go("?") 
End Sub

Function Check_Add
	Check_Add="<script>"&vbcrlf
	Check_Add=Check_Add&"function changepos(obj,index)"&vbcrlf
	Check_Add=Check_Add&"{"&vbcrlf
	Check_Add=Check_Add&"if(index==-1){"&vbcrlf
	Check_Add=Check_Add&"if (obj.selectedIndex>0){"&vbcrlf
	Check_Add=Check_Add&"obj.options(obj.selectedIndex).swapNode(obj.options(obj.selectedIndex-1))"&vbcrlf
	Check_Add=Check_Add&"}"&vbcrlf
	Check_Add=Check_Add&"}"&vbcrlf
	Check_Add=Check_Add&"else if(index==1){"&vbcrlf
	Check_Add=Check_Add&"if (obj.selectedIndex<obj.options.length-1){"&vbcrlf
	Check_Add=Check_Add&"obj.options(obj.selectedIndex).swapNode(obj.options(obj.selectedIndex+1))"&vbcrlf
	Check_Add=Check_Add&"}"&vbcrlf
	Check_Add=Check_Add&"}"&vbcrlf
	Check_Add=Check_Add&"}"&vbcrlf
	
	Check_Add=Check_Add&"function Addvote(){"&vbcrlf
	Check_Add=Check_Add&"  var thisvote='投票名称'+(document.add.content.length+1)+'|0'; "&vbcrlf
	Check_Add=Check_Add&"  var vote=prompt('请输入投票名称和初始值，中间用“|”隔开：',thisvote);"&vbcrlf
	Check_Add=Check_Add&"  if(vote!=null&&vote!=''){document.add.content.options[document.add.content.length]=new Option(vote,vote);}"&vbcrlf
	Check_Add=Check_Add&"}"&vbcrlf
	Check_Add=Check_Add&"function Modifyvote(){"&vbcrlf
	Check_Add=Check_Add&"  if(document.add.content.length==0) return false;"&vbcrlf
	Check_Add=Check_Add&"  var thisvote=document.add.content.value; "&vbcrlf
	Check_Add=Check_Add&"  if (thisvote=='') {alert('请先选择一个投票项目，再点修改按钮！');return false;}"&vbcrlf
	Check_Add=Check_Add&"  var vote=prompt('请输入投票名称和初始值，中间用“|”隔开：',thisvote);"&vbcrlf
	Check_Add=Check_Add&"  if(vote!=thisvote&&vote!=null&&vote!=''){document.add.content.options[document.add.content.selectedIndex]=new Option(vote,vote);}"&vbcrlf
	Check_Add=Check_Add&"}"&vbcrlf
	Check_Add=Check_Add&"function Delvote(){"&vbcrlf
	Check_Add=Check_Add&"  if(document.add.content.length==0) return false;"&vbcrlf
	Check_Add=Check_Add&"  var thisvote=document.add.content.value; "&vbcrlf
	Check_Add=Check_Add&"  if (thisvote=='') {alert('请先选择一个投票项目，再点删除按钮！');return false;}"&vbcrlf
	Check_Add=Check_Add&"  document.add.content.options[document.add.content.selectedIndex]=null;"&vbcrlf
	Check_Add=Check_Add&"}"&vbcrlf
	Check_Add=Check_Add&"	function checkadd()"&vbcrlf
	Check_Add=Check_Add&"	{"&vbcrlf
	Check_Add=Check_Add&"	if (document.add.t0.value=='')"&vbcrlf
	Check_Add=Check_Add&"	{"&vbcrlf
	Check_Add=Check_Add&"	alert('投票名称不能为空');"&vbcrlf
	Check_Add=Check_Add&"	document.add.t0.focus();"&vbcrlf
	Check_Add=Check_Add&"	return false"&vbcrlf
	Check_Add=Check_Add&"	}"&vbcrlf
	 
	Check_Add=Check_Add&"	if (document.add.content.length==0)"&vbcrlf
	Check_Add=Check_Add&"	{"&vbcrlf
	Check_Add=Check_Add&"	alert('投票项目不能为空');"&vbcrlf
	Check_Add=Check_Add&"	document.add.content.focus();"&vbcrlf
	Check_Add=Check_Add&"	return false"&vbcrlf
	Check_Add=Check_Add&"	}"&vbcrlf
	Check_Add=Check_Add&"	if (document.add.content.length<2)"&vbcrlf
	Check_Add=Check_Add&"	{"&vbcrlf
	Check_Add=Check_Add&"	alert('投票项目内容至少两个以上');"&vbcrlf
	Check_Add=Check_Add&"	document.add.content.focus();"&vbcrlf
	Check_Add=Check_Add&"	return false"&vbcrlf
	Check_Add=Check_Add&"	}"&vbcrlf
	Check_Add=Check_Add&"　var s=""""; "&vbcrlf
	Check_Add=Check_Add&"　for(i=0;i<=document.all(""content"").length-1;i++) "&vbcrlf
	Check_Add=Check_Add&"　{ "&vbcrlf
	Check_Add=Check_Add&"　var s=s+document.add.content.options(i).value+"",""; "&vbcrlf
	Check_Add=Check_Add&"　} "&vbcrlf
	Check_Add=Check_Add&"　document.add.votes.value=s"&vbcrlf
	Check_Add=Check_Add&"　}"&vbcrlf
	Check_Add=Check_Add&"	</script>"&vbcrlf
End Function
%>  
</div>
</body>
</html>