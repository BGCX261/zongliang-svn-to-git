<!--#include file="../Include/Const.asp" -->
<!--#include file="../Include/ConnSiteData.asp" -->
<!--#include file="Admin_htmlconfig.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="Images/Admin_style.css">
<script language="javascript" src="../Scripts/Admin.js"></script>
<%
if Instr(session("AdminPurview"),"|55,")=0 then
  response.write ("<br /><br /><div align=""center""><font style=""color:red; font-size:9pt; "")>您没有管理该模块的权限！</font></div>")
  response.end
end if
%>
<br />
<%
If Request("Action")="FormEdit" Then
sql="select * from ChinaQJ_Form where id="&Request("id")
set rs=server.createobject("adodb.recordset")
rs.open sql,conn,1,1
id=Request("id")
ChinaQJ_FormName=rs("ChinaQJ_FormName")
ChinaQJ_FormView=rs("ChinaQJ_FormView")
rs.close
set rs=nothing
pageinfo="修改"
else
pageinfo="增加新"
end if

If Request("Action")="FormAddSave" Then
If Request("id")<>"" Then
sql="select * from ChinaQJ_Form where id="&Request("id")
set rs=server.createobject("adodb.recordset")
rs.open sql,conn,1,3
else
sql="select * from ChinaQJ_Form"
set rs=server.createobject("adodb.recordset")
rs.open sql,conn,1,3
rs.addnew
end if
rs("ChinaQJ_FormName")=Request("ChinaQJ_FormName")
rs("ChinaQJ_FormView")=Request("ChinaQJ_FormView")
rs.update
id=rs("id")
rs.close
set rs=nothing
If Request("id")="" Then
response.redirect "ChinaQJ_Form_Diy.asp?Action=FormAddNextItem&Classid="&id
else
response.redirect "ChinaQJ_Form_Diy.asp"
end if
end if

If Request("Action")="FormAddNextItem" or Request("Action")="FormAddNextEdit" Then
if Request("id")="" then
sql="select * from ChinaQJ_Form_Q where classid="&Request("classid")
else
sql="select * from ChinaQJ_Form_Q where id="&Request("id")
end if
set rs=server.createobject("adodb.recordset")
rs.open sql,conn,1,1
if rs.eof then
ChinaQJ_FormSort=0
ClassID=Request("classid")
else
ClassID=Request("classid")
ChinaQJ_FormTitle=rs("ChinaQJ_FormTitle")
ChinaQJ_FormContent=rs("ChinaQJ_FormContent")
ChinaQJ_FormType=rs("ChinaQJ_FormType")
ChinaQJ_FormMust=rs("ChinaQJ_FormMust")
ChinaQJ_FormView=rs("ChinaQJ_FormView")
ChinaQJ_FormSort=rs("ChinaQJ_FormSort")
If Not(IsNull(ChinaQJ_FormContent)) Then
ChinaQJ_FormContent=split(ChinaQJ_FormContent,"|")
End If
end if
rs.close
set rs=nothing
end if

If Request("Action")="FormAddNextSave" Then
if Request("ID")="" then
sql="select * from ChinaQJ_Form_Q"
set rs=server.createobject("adodb.recordset")
rs.open sql,conn,1,3
rs.addnew
rs("ClassID")=Request("ClassID")
rs("ChinaQJ_FormTitle")=Request("ChinaQJ_FormTitle")
ChinaQJ_FormContent=replace(Request("ChinaQJ_FormContent"),", ","|")
rs("ChinaQJ_FormContent")=ChinaQJ_FormContent
rs("ChinaQJ_FormType")=Request("ChinaQJ_FormType")
rs("ChinaQJ_FormMust")=Request("ChinaQJ_FormMust")
rs("ChinaQJ_FormView")=Request("ChinaQJ_FormView")
rs("ChinaQJ_FormSort")=Request("ChinaQJ_FormSort")
rs.update
rs.close
set rs=nothing
response.redirect "ChinaQJ_Form_Diy.asp?Action=FormAddNextItemShow"
else
sql="select * from ChinaQJ_Form_Q where ID="&Request("ID")
set rs=server.createobject("adodb.recordset")
rs.open sql,conn,1,3
rs("ClassID")=Request("ClassID")
rs("ChinaQJ_FormTitle")=Request("ChinaQJ_FormTitle")
ChinaQJ_FormContent=replace(Request("ChinaQJ_FormContent"),", ","|")
rs("ChinaQJ_FormContent")=ChinaQJ_FormContent
rs("ChinaQJ_FormType")=Request("ChinaQJ_FormType")
rs("ChinaQJ_FormMust")=Request("ChinaQJ_FormMust")
rs("ChinaQJ_FormView")=Request("ChinaQJ_FormView")
rs("ChinaQJ_FormSort")=Request("ChinaQJ_FormSort")
rs.update
rs.close
set rs=nothing
response.redirect "ChinaQJ_Form_Diy.asp?Action=FormAddNextItemShow"
end if
end if

If Request("Action")="FormBackDel" Then
conn.execute "delete from ChinaQJ_Form_C where ID="&Request("ID")
response.redirect "ChinaQJ_Form_Diy.asp?Action=FormBack"
end if

If Request("Action")="FormAddNextItemDel" Then
conn.execute "delete from ChinaQJ_Form_Q where ID="&Request("ID")
response.redirect "ChinaQJ_Form_Diy.asp?Action=FormAddNextItemShow"
end if

If Request("Action")="" Then
%>
<table class="tableBorder" width="98%" border="0" align="center" cellpadding="5" cellspacing="1">
  <form Action="DelContent.Asp?Result=FormDiy" method="post" name="formDel">
    <tr>
      <th width="5%" align="left">ID</th>
      <th width="5%" align="left">生效</th>
      <th width="65%" align="left">表单名称</th>
      <th width="20%" align="center">管理操作</th>
      <th width="5%" align="center">选择</th>
    </tr>
<% FormList() %>
  </form>
</table>
<%
function FormList()
  dim idCount
  dim pages
      pages=20
  dim pagec
  dim page
      page=clng(request("Page"))
  dim pagenc
      pagenc=2
  dim pagenmax
  dim pagenmin
  dim datafrom
      datafrom="ChinaQJ_Form"
  dim sqlid
  dim Myself,PATH_INFO,QUERY_STRING
      PATH_INFO = request.servervariables("PATH_INFO")
	  QUERY_STRING = request.ServerVariables("QUERY_STRING")'
      if QUERY_STRING = "" or Instr(PATH_INFO & "?" & QUERY_STRING,"Page=")=0 then
	    Myself = PATH_INFO & "?"
	  else
	    Myself = Left(PATH_INFO & "?" & QUERY_STRING,Instr(PATH_INFO & "?" & QUERY_STRING,"Page=")-1)
	  end if
  dim taxis
      taxis="order by id desc"
  dim i
  dim rs,sql
  sql="select count(ID) as idCount from ["& datafrom &"]"
  set rs=server.createobject("adodb.recordset")
  rs.open sql,conn,1,1
  idCount=rs("idCount")
  if(idcount>0) then
    if(idcount mod pages=0)then
	  pagec=int(idcount/pages)
   	else
      pagec=int(idcount/pages)+1
    end if
    sql="select id from ["& datafrom &"] "
    set rs=server.createobject("adodb.recordset")
    rs.open sql,conn,1,1
    rs.pagesize = pages
    if page < 1 then page = 1
    if page > pagec then page = pagec
    if pagec > 0 then rs.absolutepage = page  
    for i=1 to rs.pagesize
	  if rs.eof then exit for  
	  if(i=1)then
	    sqlid=rs("id")
	  else
	    sqlid=sqlid &","&rs("id")
	  end if
	  rs.movenext
    next
  end if
  if(idcount>0 and sqlid<>"") then
    sql="select * from ["& datafrom &"]"
    set rs=server.createobject("adodb.recordset")
    rs.open sql,conn,1,1
    while(not rs.eof)
%>
<tr>
<td nowrap class="leftrow"><%= rs("id") %></td>
<td nowrap class="leftrow"><% If rs("ChinaQJ_FormView")=1 Then %><font color='blue'>√</font><% Else %><font color='red'>×</font><% End If %></td>
<td nowrap class="leftrow"><%= rs("ChinaQJ_FormName") %></td>
<td nowrap class="centerrow"><a href="/ch/Advisory.Asp?ID=<%= rs("id") %>" target="_blank"><font color="red"><u>预览</u></font></a> <a href="ChinaQJ_Form_Diy.asp?Action=FormEdit&ID=<%= rs("id") %>">修改</a> <a href="ChinaQJ_Form_Diy.asp?Action=FormAddNextItemShow&ClassID=<%= rs("id") %>">字段管理</a> <a href="ChinaQJ_Form_Diy.asp?Action=FormBack&ClassID=<%= rs("id") %>">查看反馈</a></td>
<td nowrap class="centerrow"><input name='selectID' type='checkbox' value='<%= rs("id") %>'></td>
</tr>
<%
	rs.movenext
    wend
%>
<tr>
<td colspan='7' nowrap class="forumRow" align="right"><input type="submit" name="batch" value="批量生效" onClick="return test();"> <input type="submit" name="batch" value="批量失效" onClick="return test();"> <input onClick="CheckAll(this.form)" name="buttonAllSelect" type="button" id="submitAllSearch" value="全选"> <input onClick="CheckOthers(this.form)" name="buttonOtherSelect" type="button" id="submitOtherSelect" value="反选"> <input name='batch' type='submit' value='删除所选' onClick="return test();"></td>
</tr>
<%
  else
    response.write "<tr><td nowrap align='center' colspan='7' class=""forumRow"">暂无产品信息</td></tr>"
  end if
  Response.Write "<tr>" & vbCrLf
  Response.Write "<td colspan='7' nowrap class=""forumRow"">" & vbCrLf
  Response.Write "<table width='100%' border='0' align='center' cellpadding='0' cellspacing='0'>" & vbCrLf
  Response.Write "<tr>" & vbCrLf
  Response.Write "<td class=""forumRow"">共计：<font color='red'>"&idcount&"</font>条记录 页次：<font color='red'>"&page&"</font></strong>/"&pagec&" 每页：<font color='red'>"&pages&"</font>条</td>" & vbCrLf
  Response.Write "<td align='right'>" & vbCrLf
  pagenmin=page-pagenc
  pagenmax=page+pagenc
  if(pagenmin<1) then pagenmin=1
  if(page>1) then response.write ("<a href='"& myself &"Page=1'><font style='font-size: 14px; font-family: Webdings'>9</font></a> ")
  if(pagenmin>1) then response.write ("<a href='"& myself &"Page="& page-(pagenc*2+1) &"'><font style='font-size: 14px; font-family: Webdings'>7</font></a> ")
  if(pagenmax>pagec) then pagenmax=pagec
  for i = pagenmin to pagenmax
	if(i=page) then
	  response.write (" <font color='red'>"& i &"</font> ")
	else
	  response.write ("[<a href="& myself &"Page="& i &">"& i &"</a>]")
	end if
  next
  if(pagenmax<pagec) then response.write (" <a href='"& myself &"Page="& page+(pagenc*2+1) &"'><font style='font-size: 14px; font-family: Webdings'>8</font></a> ")
  if(page<pagec) then response.write ("<a href='"& myself &"Page="& pagec &"'><font style='font-size: 14px; font-family: Webdings'>:</font></a> ")
  Response.Write "第<input name='SkipPage' onKeyDown='if(event.keyCode==13)event.returnValue=false' onchange=""if(/\D/.test(this.value)){alert('请输入需要跳转到的页数并且必须为整数！');this.value='"&Page&"';}"" style='width: 28px;' type='text' value='"&Page&"'>页" & vbCrLf
  Response.Write "<input name='submitSkip' type='button' onClick='GoPage("""&Myself&""")' value='转到'>" & vbCrLf
  Response.Write "</td>" & vbCrLf
  Response.Write "</tr>" & vbCrLf
  Response.Write "</table>" & vbCrLf
  rs.close
  set rs=nothing
  Response.Write "</td>" & vbCrLf
  Response.Write "</tr>" & vbCrLf
end Function
%>
<br />
<% End If %>
<% If Request("Action")="FormAdd" or Request("Action")="FormEdit" Then %>
<table class="tableBorder" width="95%" border="0" align="center" cellpadding="5"
    cellspacing="1">
  <form name="editForm" method="post" Action="ChinaQJ_Form_Diy.asp?Action=FormAddSave">
    <tr>
      <th height="22" colspan="2" sytle="line-height:150%">【<%= pageinfo %>表单】</th>
    </tr>
    <tr>
      <td width="200" class="forumRow">表单名称：</td>
      <td class="forumRowHighlight"><input name="ChinaQJ_FormName" type="text" ID="ChinaQJ_FormName" style="width: 300" value="<%= ChinaQJ_FormName %>">
        <font color="red"><input name="id" type="hidden" value="<%= id %>" />* 仅作后台管理识别用</font></td>
    </tr>
    <tr>
      <td class="forumRow">是否启用：</td>
      <td class="forumRowHighlight"><input name="ChinaQJ_FormView" type="radio" ID="ChinaQJ_FormView" value="1" <% If ChinaQJ_FormView=1 Then %>checked="checked"<% End If %>/>开启
        <input name="ChinaQJ_FormView" type="radio" ID="ChinaQJ_FormView" value="0" <% If ChinaQJ_FormView=0 Then %>checked="checked"<% End If %>/>关闭 <font color="red">*</font></td>
    </tr>
    <tr>
      <td class="forumRow"></td>
      <td class="forumRowHighlight"><input name="submitSaveEdit" type="submit" ID="submitSaveEdit" value="保存设置">
        <input type="button" value="返回上一页" onclick="history.back(-1)"></td>
    </tr>
  </form>
</table>
<% End If %>
<br />
<% If Request("Action")="FormAddNextItem" or Request("Action")="FormAddNext" or Request("Action")="FormAddNextEdit" Then %>
<table class="tableBorder" width="95%" border="0" align="center" cellpadding="5" cellspacing="1">
  <form name="editForm" method="post" Action="ChinaQJ_Form_Diy.asp?Action=FormAddNextSave&ClassID=<%= Request("Classid") %>&id=<%= Request("id") %>">
    <tr>
<% 
sql="select * from ChinaQJ_Form where id="&Request("classid")
set rs=server.createobject("adodb.recordset")
rs.open sql,conn,1,1
%>
      <th height="22" colspan="2" sytle="line-height:150%">【表单名称：<%= rs("ChinaQJ_FormName") %>】</th>
    </tr>
<% 
rs.close
set rs=nothing
%>
    <tr>
      <td width="200" class="forumRow">选项类型：</td>
      <td class="forumRowHighlight">
      <select name="ChinaQJ_FormType" onchange="Setdisplay(this.value)" style="width: 180px;">
          <option value="1" <% If ChinaQJ_FormType=1 Then %>Selected<% End If %>>单选框</option>
          <option value="2"<% If ChinaQJ_FormType=2 Then %>Selected<% End If %>>复选框</option>
          <option value="3"<% If ChinaQJ_FormType=3 Then %>Selected<% End If %>>下拉菜单</option>
          <option value="4"<% If ChinaQJ_FormType=4 Then %>Selected<% End If %>>单行文本</option>
          <option value="5"<% If ChinaQJ_FormType=5 Then %>Selected<% End If %>>多行文本</option>
        </select>
        <input name="ClassID" type="hidden" id="ClassID" value="<%= ClassID %>" />
        <font color="red">*</font></td>
    </tr>
    <tr>
      <td class="forumRow">是否必选项：</td>
      <td class="forumRowHighlight"><input name="ChinaQJ_FormMust" type="radio" ID="ChinaQJ_FormMust" value="1" <% If ChinaQJ_FormMust=1 Then Response.Write("checked")%> />是
        <input name="ChinaQJ_FormMust" type="radio" ID="ChinaQJ_FormMust" value="0" <% If ChinaQJ_FormMust=0 Then Response.Write("checked")%>/>否
        <font color="red">*</font></td>
    </tr>
    <tr>
      <td class="forumRow">是否生效：</td>
      <td class="forumRowHighlight"><input name="ChinaQJ_FormView" type="radio" ID="ChinaQJ_FormView" value="1" <% If ChinaQJ_FormView=1 Then Response.Write("checked")%> />是
        <input name="ChinaQJ_FormView" type="radio" ID="ChinaQJ_FormView" value="0" <% If ChinaQJ_FormView=0 Then Response.Write("checked")%>/>否
        <font color="red">*</font></td>
    </tr>
    <tr>
      <td class="forumRow">排序：</td>
      <td class="forumRowHighlight"><input name="ChinaQJ_FormSort" type="text" ID="ChinaQJ_FormSort" value="<%= ChinaQJ_FormSort %>" style="width: 35px;" />
        <font color="red">*</font></td>
    </tr>
    <tr>
      <td class="forumRow">选项标题：</td>
      <td class="forumRowHighlight"><input name="ChinaQJ_FormTitle" type="text" ID="ChinaQJ_FormTitle" style="width: 300px;" value="<%= ChinaQJ_FormTitle %>"/>
        <font color="red">*</font></td>
    </tr>
    <tr ID="OptionsArea">
      <td class="forumRow">选项内容：</td>
      <td class="forumRowHighlight">
<% If Request("Action")="FormAddNextEdit" Then
If Not(IsNull(ChinaQJ_FormContent)) Then
Dim htmlshop
%>
      <ul ID="qul" style="list-style: none; margin: 0; padding: 0;">
<% for htmlshop=0 to ubound(ChinaQJ_FormContent) %>
          <li><input name="ChinaQJ_FormContent" type="text" ID="ChinaQJ_FormContent" value="<%= trim(ChinaQJ_FormContent(htmlshop)) %>"></li>
<%
next
end if
%>
        </ul>
<% Else %>
      <ul ID="qul" style="list-style: none; margin: 0; padding: 0;">
          <li><input name="ChinaQJ_FormContent" type="text" ID="ChinaQJ_FormContent"></li>
        </ul>
<% End If %>
        <span class="ts">注意：选项内容中禁止含“|”和“,”字符，并确保所有选项不为空。</span><br />
        <span onclick="Addqul();" style="cursor: hand;">增加选项(+)</span> <span onclick="Delqul();" style="cursor: hand;">减少选项(-)</span> <font color="red">*</font></td>
    </tr>
    <tr>
      <td class="forumRow"></td>
      <td class="forumRowHighlight"><input name="submitSaveEdit" type="submit" ID="submitSaveEdit" value="保存设置">
        <input type="button" value="返回上一页" onclick="history.back(-1)"></td>
    </tr>
  </form>
</table>
<br />
<% End If
If Request("Action")="FormAddNextItemShow" Then
%>
<table class="tableBorder" width="98%" border="0" align="center" cellpadding="5" cellspacing="1">
  <form Action="DelContent.Asp?Result=FormDiy" method="post" name="formDel">
  <tr height="22" sytle="line-height:150%">
    <th width="30%" align="left">选项标题</th>
    <th width="20%" align="left">选项类型</th>
    <th width="10%" align="center">是否必填项</th>
    <th width="10%" align="center">是否生效</th>
    <th width="10%" align="center">排序</th>
    <th width="20%" align="center">管理字段<font color="red">(<a href="?Action=FormAddNext&ClassID=1"><font color="red">添加字段</font></a>)</font></th>
  </tr>
<% FormqList() %>
  </form>
</table>
<%
function FormqList()
  dim idCount
  dim pages
      pages=20
  dim pagec
  dim page
      page=clng(request("Page"))
  dim pagenc
      pagenc=2
  dim pagenmax
  dim pagenmin
  dim datafromq
      datafromq="ChinaQJ_Form_Q"
  dim sqlid
  dim Myself,PATH_INFO,QUERY_STRING
      PATH_INFO = request.servervariables("PATH_INFO")
	  QUERY_STRING = request.ServerVariables("QUERY_STRING")'
      if QUERY_STRING = "" or Instr(PATH_INFO & "?" & QUERY_STRING,"Page=")=0 then
	    Myself = PATH_INFO & "?"
	  else
	    Myself = Left(PATH_INFO & "?" & QUERY_STRING,Instr(PATH_INFO & "?" & QUERY_STRING,"Page=")-1)
	  end if
  dim taxis
      taxis="order by id desc"
  dim i
  dim rs,sql
  sql="select count(ID) as idCount from ["& datafromq &"]"
  set rs=server.createobject("adodb.recordset")
  rs.open sql,conn,1,1
  idCount=rs("idCount")
  if(idcount>0) then
    if(idcount mod pages=0)then
	  pagec=int(idcount/pages)
   	else
      pagec=int(idcount/pages)+1
    end if
    sql="select id from ["& datafromq &"] "
    set rs=server.createobject("adodb.recordset")
    rs.open sql,conn,1,1
    rs.pagesize = pages
    if page < 1 then page = 1
    if page > pagec then page = pagec
    if pagec > 0 then rs.absolutepage = page  
    for i=1 to rs.pagesize
	  if rs.eof then exit for  
	  if(i=1)then
	    sqlid=rs("id")
	  else
	    sqlid=sqlid &","&rs("id")
	  end if
	  rs.movenext
    next
  end if
  if(idcount>0 and sqlid<>"") then
    sql="select * from ["& datafromq &"] order by ChinaQJ_FormSort"
    set rs=server.createobject("adodb.recordset")
    rs.open sql,conn,1,1
    while(not rs.eof)
%>
  <tr>
    <td class="leftrow"><%= rs("ChinaQJ_FormTitle") %></td>
    <td class="leftrow">
	<% If rs("ChinaQJ_FormType")=1 Then %>
    单选框
	<% elseIf rs("ChinaQJ_FormType")=2 Then %>
    复选框
	<% elseIf rs("ChinaQJ_FormType")=3 Then %>
    下拉菜
	<% elseIf rs("ChinaQJ_FormType")=4 Then %>
    单行文本
	<% elseIf rs("ChinaQJ_FormType")=5 Then %>
    多行文本
	<% End If %>
    </td>
    <td class="centerrow"><% If rs("ChinaQJ_FormMust")=1 Then %><font color="red">是</font><% Else %><font color="blue">否</font><% End If %></td>
    <td class="centerrow"><% If rs("ChinaQJ_FormView")=1 Then %><font color="red">是</font><% Else %><font color="blue">否</font><% End If %></td>
    <td class="centerrow"><%= rs("ChinaQJ_FormSort") %></td>
    <td class="centerrow"><a href="ChinaQJ_Form_Diy.asp?Action=FormAddNext&ClassID=<%= rs("classid") %>">添加字段</a> <a href="ChinaQJ_Form_Diy.asp?Action=FormAddNextEdit&ClassID=<%= rs("classid") %>&ID=<%= rs("id") %>">修改字段</a> <a href="ChinaQJ_Form_Diy.asp?Action=FormAddNextItemDel&ID=<%= rs("id") %>&ClassID=<%= rs("classid") %>">删除字段</a></td>
  </tr>
<%
	rs.movenext
    wend
%>
<%
  else
    response.write "<tr><td nowrap align='center' colspan='7' class=""forumRow"">暂无产品信息</td></tr>"
  end if
  Response.Write "<tr>" & vbCrLf
  Response.Write "<td colspan='7' nowrap class=""forumRow"">" & vbCrLf
  Response.Write "<table width='100%' border='0' align='center' cellpadding='0' cellspacing='0'>" & vbCrLf
  Response.Write "<tr>" & vbCrLf
  Response.Write "<td class=""forumRow"">共计：<font color='red'>"&idcount&"</font>条记录 页次：<font color='red'>"&page&"</font></strong>/"&pagec&" 每页：<font color='red'>"&pages&"</font>条</td>" & vbCrLf
  Response.Write "<td align='right'>" & vbCrLf
  pagenmin=page-pagenc
  pagenmax=page+pagenc
  if(pagenmin<1) then pagenmin=1
  if(page>1) then response.write ("<a href='"& myself &"Page=1'><font style='font-size: 14px; font-family: Webdings'>9</font></a> ")
  if(pagenmin>1) then response.write ("<a href='"& myself &"Page="& page-(pagenc*2+1) &"'><font style='font-size: 14px; font-family: Webdings'>7</font></a> ")
  if(pagenmax>pagec) then pagenmax=pagec
  for i = pagenmin to pagenmax
	if(i=page) then
	  response.write (" <font color='red'>"& i &"</font> ")
	else
	  response.write ("[<a href="& myself &"Page="& i &">"& i &"</a>]")
	end if
  next
  if(pagenmax<pagec) then response.write (" <a href='"& myself &"Page="& page+(pagenc*2+1) &"'><font style='font-size: 14px; font-family: Webdings'>8</font></a> ")
  if(page<pagec) then response.write ("<a href='"& myself &"Page="& pagec &"'><font style='font-size: 14px; font-family: Webdings'>:</font></a> ")
  Response.Write "第<input name='SkipPage' onKeyDown='if(event.keyCode==13)event.returnValue=false' onchange=""if(/\D/.test(this.value)){alert('请输入需要跳转到的页数并且必须为整数！');this.value='"&Page&"';}"" style='width: 28px;' type='text' value='"&Page&"'>页" & vbCrLf
  Response.Write "<input name='submitSkip' type='button' onClick='GoPage("""&Myself&""")' value='转到'>" & vbCrLf
  Response.Write "</td>" & vbCrLf
  Response.Write "</tr>" & vbCrLf
  Response.Write "</table>" & vbCrLf
  rs.close
  set rs=nothing
  Response.Write "</td>" & vbCrLf
  Response.Write "</tr>" & vbCrLf
end Function
%>
<center><font color="#CC0000">前台字段排序显示将按照从小大到的原则</font></center>
<br />
<% End If
If Request("Action")="FormBack" Then
%>
<table class="tableBorder" width="98%" border="0" align="center" cellpadding="5" cellspacing="1">
  <form Action="DelContent.Asp?Result=FormDiy" method="post" name="formDel">
    <tr>
      <th width="70%" align="center">提交内容</th>
      <th width="30%" align="center">管理操作</th>
    </tr>
<% FormBackList() %>
  </form>
</table>
<%
function FormBackList()
  dim idCount
  dim pages
      pages=20
  dim pagec
  dim page
      page=clng(request("Page"))
  dim pagenc
      pagenc=2
  dim pagenmax
  dim pagenmin
  dim datafromb
      datafromb="ChinaQJ_Form_C"
  dim sqlid
  dim Myself,PATH_INFO,QUERY_STRING
      PATH_INFO = request.servervariables("PATH_INFO")
	  QUERY_STRING = request.ServerVariables("QUERY_STRING")'
      if QUERY_STRING = "" or Instr(PATH_INFO & "?" & QUERY_STRING,"Page=")=0 then
	    Myself = PATH_INFO & "?"
	  else
	    Myself = Left(PATH_INFO & "?" & QUERY_STRING,Instr(PATH_INFO & "?" & QUERY_STRING,"Page=")-1)
	  end if
  dim taxis
      taxis="order by id desc"
  dim i
  dim rs,sql
  sql="select count(ID) as idCount from ["& datafromb &"]"
  set rs=server.createobject("adodb.recordset")
  rs.open sql,conn,1,1
  idCount=rs("idCount")
  if(idcount>0) then
    if(idcount mod pages=0)then
	  pagec=int(idcount/pages)
   	else
      pagec=int(idcount/pages)+1
    end if
    sql="select id from ["& datafromb &"] "
    set rs=server.createobject("adodb.recordset")
    rs.open sql,conn,1,1
    rs.pagesize = pages
    if page < 1 then page = 1
    if page > pagec then page = pagec
    if pagec > 0 then rs.absolutepage = page  
    for i=1 to rs.pagesize
	  if rs.eof then exit for  
	  if(i=1)then
	    sqlid=rs("id")
	  else
	    sqlid=sqlid &","&rs("id")
	  end if
	  rs.movenext
    next
  end if
  if(idcount>0 and sqlid<>"") then
    sql="select * from ["& datafromb &"]"
    set rs=server.createobject("adodb.recordset")
    rs.open sql,conn,1,1
    while(not rs.eof)
	ChinaQJ_FormContent=rs("ChinaQJ_FormContent")
	If Not(IsNull(ChinaQJ_FormContent)) Then
	ChinaQJ_FormContent=split(ChinaQJ_FormContent,"|")
	End If
	Dim ChinaQJ
%>
<td nowrap class="leftrow">
<table class="tableBorder" width="98%" border="0" align="center" cellpadding="5" cellspacing="1">
<% 
    sqlq="select * from ChinaQJ_Form_Q where classid="&rs("classid")&" order by ChinaQJ_FormSort"
    set rsq=server.createobject("adodb.recordset")
    rsq.open sqlq,conn,1,1
	i=0
    while(not rsq.eof)
 %>
    <tr>
      <td class="leftrow"><%= rsq("ChinaQJ_FormTitle") %>：<%= trim(ChinaQJ_FormContent(i)) %></td>
    </tr>
<%
rsq.movenext
i=i+1
wend
rsq.close
set rsq=nothing
%>
</table>
</td>
<td nowrap class="leftrow">
提交时间：<%= rs("ChinaQJ_FormAddTime") %><br />用户IP地址：<%= rs("ChinaQJ_FormIP") %><br /><a href="ChinaQJ_Form_Diy.asp?Action=FormBackDel&ID=<%= rs("id") %>&ClassID=<%= rs("ClassID") %>"><u>删除该条记录</u></a></td>
</tr>
<%
	rs.movenext
    wend
%>
<%
  else
    response.write "<tr><td nowrap align='center' colspan='7' class=""forumRow"">暂无产品信息</td></tr>"
  end if
  Response.Write "<tr>" & vbCrLf
  Response.Write "<td colspan='7' nowrap class=""forumRow"">" & vbCrLf
  Response.Write "<table width='100%' border='0' align='center' cellpadding='0' cellspacing='0'>" & vbCrLf
  Response.Write "<tr>" & vbCrLf
  Response.Write "<td class=""forumRow"">共计：<font color='red'>"&idcount&"</font>条记录 页次：<font color='red'>"&page&"</font></strong>/"&pagec&" 每页：<font color='red'>"&pages&"</font>条</td>" & vbCrLf
  Response.Write "<td align='right'>" & vbCrLf
  pagenmin=page-pagenc
  pagenmax=page+pagenc
  if(pagenmin<1) then pagenmin=1
  if(page>1) then response.write ("<a href='"& myself &"Page=1'><font style='font-size: 14px; font-family: Webdings'>9</font></a> ")
  if(pagenmin>1) then response.write ("<a href='"& myself &"Page="& page-(pagenc*2+1) &"'><font style='font-size: 14px; font-family: Webdings'>7</font></a> ")
  if(pagenmax>pagec) then pagenmax=pagec
  for i = pagenmin to pagenmax
	if(i=page) then
	  response.write (" <font color='red'>"& i &"</font> ")
	else
	  response.write ("[<a href="& myself &"Page="& i &">"& i &"</a>]")
	end if
  next
  if(pagenmax<pagec) then response.write (" <a href='"& myself &"Page="& page+(pagenc*2+1) &"'><font style='font-size: 14px; font-family: Webdings'>8</font></a> ")
  if(page<pagec) then response.write ("<a href='"& myself &"Page="& pagec &"'><font style='font-size: 14px; font-family: Webdings'>:</font></a> ")
  Response.Write "第<input name='SkipPage' onKeyDown='if(event.keyCode==13)event.returnValue=false' onchange=""if(/\D/.test(this.value)){alert('请输入需要跳转到的页数并且必须为整数！');this.value='"&Page&"';}"" style='width: 28px;' type='text' value='"&Page&"'>页" & vbCrLf
  Response.Write "<input name='submitSkip' type='button' onClick='GoPage("""&Myself&""")' value='转到'>" & vbCrLf
  Response.Write "</td>" & vbCrLf
  Response.Write "</tr>" & vbCrLf
  Response.Write "</table>" & vbCrLf
  rs.close
  set rs=nothing
  Response.Write "</td>" & vbCrLf
  Response.Write "</tr>" & vbCrLf
end Function
%>
<center><font color="#CC0000">前台字段排序显示将按照从小大到的原则</font></center>
<br />
<% End If %>