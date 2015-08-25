<!--#include file="../Include/Const.asp" -->
<!--#include file="../Include/ConnSiteData.asp" -->
<!--#include file="Admin_htmlconfig.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="Images/Admin_style.css">
<script language="javascript" src="../Scripts/Admin.js"></script>
<script language="javascript" src="JavaScript/Tab.js"></script>
<%
if Instr(session("AdminPurview"),"|50,")=0 then
  response.write ("<br /><br /><div align=""center""><font style=""color:red; font-size:9pt; "")>您没有管理该模块的权限！</font></div>")
  response.end
end if
%>
<br />
<%
If Request("Result")="Modify" Then
sql="select * from ChinaQJ_Properties where id="&Request("id")
set rs=server.createobject("adodb.recordset")
rs.open sql,conn,1,1
if rs.bof and rs.eof then
	response.write ("<center>数据库记录读取错误！</center>")
	response.end
end If
id=Request("id")
Properties_Name=rs("Properties_Name")
Properties_Check=rs("Properties_Check")
  '多语言循环拾取数据
set rsl = server.createobject("adodb.recordset")
sqll="select * from ChinaQJ_Language order by ChinaQJ_Language_Order"
rsl.open sqll,conn,1,1
while(not rsl.eof)
  Lanl=rsl("ChinaQJ_Language_File")
  if rs("ProProperties"&Lanl)<>"" then
  ProProperties=Split(rs("ProProperties"&Lanl),"§§§")
  Num_1=ubound(ProProperties)+1
  execute("ProProperties"&Lanl&"=ProProperties")
  execute("Num"&Lanl&"=Num_1")
  else
  execute("Num"&Lanl&"=0")
  end if
rsl.movenext
wend
rsl.close
set rsl=nothing

rs.close
set rs=nothing
end if

If Request("Action")="SaveEdit" Then
if request("Properties_Name")="" then
      response.write ("<script language='javascript'>alert('请填写属性名称！');history.back(-1);</script>")
      response.end
end if
set rs=server.createobject("adodb.recordset")
if Request("id")<>"" then
sql="select * from ChinaQJ_Properties where id="&Request("id")
rs.open sql,conn,1,3
else
sql="select * from ChinaQJ_Properties"
rs.open sql,conn,1,3
rs.addnew
end if
  '多语言循环保存数据
set rsl = server.createobject("adodb.recordset")
sqll="select * from ChinaQJ_Language order by ChinaQJ_Language_Order"
rsl.open sqll,conn,1,1
while(not rsl.eof)
  Lanl=rsl("ChinaQJ_Language_File")
  for i=1 to 8
    if Request.Form("ProProperties"&i&Lanl)<>"" then
	Num_2=i
	end if
  next
  if Num_2="" then Num_2=0
  if Num_2>0 then
	For i=1 to Num_2
		if Request.Form("ProProperties"&i&Lanl)<>"" then
		  if ProProperties2="" then
		    ProProperties2=trim(Request.Form("ProProperties"&i&Lanl))
		  else
			ProProperties2=ProProperties2&"§§§"&trim(Request.Form("ProProperties"&i&Lanl))
		  end if
		End If
	Next
  end if
  rs("ProProperties"&Lanl)=ProProperties2
  ProProperties2=""
rsl.movenext
wend
rsl.close
set rsl=nothing

rs("Properties_Name")=Request("Properties_Name")
rs("Properties_Check")=Request("Properties_Check")
rs("AddTime")=now()
rs.update
rs.close
set rs=nothing
response.write "<script language='javascript'>alert('设置成功！');location.replace('PropertiesList.Asp');</script>"
end if
%>
<ul id="tablist">
<% 
set rs = server.createobject("adodb.recordset")
sql="select * from ChinaQJ_Language order by ChinaQJ_Language_Order"
rs.open sql,conn,1,1
lani=1
while(not rs.eof)
%>
   <li <% If rs("ChinaQJ_Language_Index") Then Response.Write("class=""selected""")%>><a rel="tcontent<%= lani %>" style="cursor: hand;"><%=rs("ChinaQJ_Language_Name")%></a></li>   
<% 
rs.movenext
lani=lani+1
wend
rs.close
set rs=nothing
%>
</ul>
<br />
<table class="tableBorder" width="95%" border="0" align="center" cellpadding="0" cellspacing="1">
  <form name="editForm" method="post" action="PropertiesEdit.Asp?Action=SaveEdit&Result=<%= Request("Result") %>&ID=<%= Request("id") %>">
    <tr>
      <th height="28" colspan="2" sytle="line-height:150%">【<% If Request("Result")="Add" Then Response.Write("添加")%><% If Request("Result")="Modify" Then Response.Write("修改")%>产品属性】</th>
    </tr>
    <tr>
      <td align="right" class="forumRow" width="200">属性名称：</td>
      <td class="forumRowHighlight"><input name="Properties_Name" type="text" id="Properties_Name" style="width: 250px;" value="<%= Properties_Name %>"> <font color="red">*</font></td>
    </tr>
    <tr height="28">
      <td colspan="2">
<% 
set rs2 = server.createobject("adodb.recordset")
sql2="select * from ChinaQJ_Language order by ChinaQJ_Language_Order"
rs2.open sql2,conn,1,1
lani=1
while(not rs2.eof)
%>
<div id="tcontent<%= lani %>" class="tabcontent">
<table class="tableborderOther" width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr height="35">
      <td width="200" class="forumRowA"><%=rs2("ChinaQJ_Language_Name")%>属性：</td>
      <td class="forumRowHighlight">
        <%For i=0 to (eval("Num"&rs2("ChinaQJ_Language_File"))-1)%>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr height="28">
            <td>属性值：<input name="ProProperties<%=i+1%><%= rs2("ChinaQJ_Language_File") %>" type="text" id="ProProperties<%=i+1%><%= rs2("ChinaQJ_Language_File") %>" value="<%=eval("ProProperties"&rs2("ChinaQJ_Language_File"))(i)%>" style="width: 180" /></td>
          </tr>
        </table>
        <%Next%>
        <%For i=eval("Num"&rs2("ChinaQJ_Language_File")) to 7%>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr height="28">
            <td>属性值：<input name="ProProperties<%=i+1%><%= rs2("ChinaQJ_Language_File") %>" type="text" id="ProProperties<%=i+1%><%= rs2("ChinaQJ_Language_File") %>" value="" style="width: 180" /></td>
          </tr>
        </table>
        <%Next%>
      </td>
    </tr>
</table>
</div>

<% 
rs2.movenext
lani=lani+1
wend
rs2.close
set rs2=nothing
%>
  <script>showtabcontent("tablist")</script></td></tr>
    <tr>
      <td class="forumRow" align="right">是否优先：</td>
      <td class="forumRowHighlight"><select style="width: 80px;" name="Properties_Check">
      <% If Properties_Check="" Then Properties_Check=0%>
          <option value="0" <% If Properties_Check=0 Then Response.Write("selected")%>>默认</option>
          <option value="1" style="color: red;" <% If Properties_Check Then Response.Write("selected")%>>优先</option>
        </select> <font color="red">*</font></td>
    </tr>
    
    <tr height="35">
      <td class="forumRow"></td>
      <td class="forumRowHighlight"><input name="submitSaveEdit" type="submit" id="submitSaveEdit" value="保存设置">
        <input type="button" value="返回上一页" onclick="history.back(-1)"></td>
    </tr>
  </form>
</table>
<br />