﻿<!--#include file="../Include/Const.asp" -->
<!--#include file="../Include/ConnSiteData.asp" -->
<!--#include file="Admin_htmlconfig.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="Images/Admin_style.css">
<script language="javascript" src="../Scripts/Admin.js"></script>
<script language="javascript" src="JavaScript/Tab.js"></script>
<script language="javascript" src="/Scripts/MyEditObj.js?type=<%=editType%>"></script>
<%
if Instr(session("AdminPurview"),"|53,")=0 then
  response.write ("<br /><br /><div align=""center""><font style=""color:red; font-size:9pt; "")>您没有管理该模块的权限！</font></div>")
  response.end
end if
%>
<br />
<%
If Trim(Request.QueryString("Result"))="Modify" Then
sql="select * from ChinaQJ_NetWork where id="&Request("id")
set rs=server.createobject("adodb.recordset")
rs.open sql,conn,1,1
id=Request("id")
  '多语言循环拾取数据
set rsl = server.createobject("adodb.recordset")
sqll="select * from ChinaQJ_Language order by ChinaQJ_Language_Order"
rsl.open sqll,conn,1,1
while(not rsl.eof)
  Lanl=rsl("ChinaQJ_Language_File")
  ChinaQJ_Company=rs("ChinaQJ_Company"&Lanl)
  ChinaQJ_Address=rs("ChinaQJ_Address"&Lanl)
  ChinaQJ_User=rs("ChinaQJ_User"&Lanl)
  ChinaQJ_Demo=rs("ChinaQJ_Demo"&Lanl)
  execute("ChinaQJ_Company"&Lanl&"=ChinaQJ_Company")
  execute("ChinaQJ_Address"&Lanl&"=ChinaQJ_Address")
  execute("ChinaQJ_User"&Lanl&"=ChinaQJ_User")
  execute("ChinaQJ_Demo"&Lanl&"=ChinaQJ_Demo")
rsl.movenext
wend
rsl.close
set rsl=nothing

ChinaQJ_Province=rs("ChinaQJ_Province")
ChinaQJ_Tel=rs("ChinaQJ_Tel")
ChinaQJ_Fax=rs("ChinaQJ_Fax")
ChinaQJ_Url=rs("ChinaQJ_Url")
ChinaQJ_Zip=rs("ChinaQJ_Zip")

rs.close
set rs=nothing
pageinfo="修改"
else
pageinfo="添加"
end if
%>
<%
If Trim(Request.QueryString("Action"))="SaveEdit" Then
if Request("id")<>"" then
sql="select * from ChinaQJ_NetWork where id="&Request("id")
set rs=server.createobject("adodb.recordset")
rs.open sql,conn,1,3
else
sql="select * from ChinaQJ_NetWork"
set rs=server.createobject("adodb.recordset")
rs.open sql,conn,1,3
rs.addnew
end if
  '多语言循环保存数据
set rsl = server.createobject("adodb.recordset")
sqll="select * from ChinaQJ_Language order by ChinaQJ_Language_Order"
rsl.open sqll,conn,1,1
while(not rsl.eof)
  rs("ChinaQJ_Company"&rsl("ChinaQJ_Language_File"))=Request("ChinaQJ_Company"&rsl("ChinaQJ_Language_File"))
  rs("ChinaQJ_Address"&rsl("ChinaQJ_Language_File"))=Request("ChinaQJ_Address"&rsl("ChinaQJ_Language_File"))
  rs("ChinaQJ_User"&rsl("ChinaQJ_Language_File"))=Request("ChinaQJ_User"&rsl("ChinaQJ_Language_File"))
  rs("ChinaQJ_Demo"&rsl("ChinaQJ_Language_File"))=Request("ChinaQJ_Demo"&rsl("ChinaQJ_Language_File"))
rsl.movenext
wend
rsl.close
set rsl=nothing

rs("ChinaQJ_Province")=Request("ChinaQJ_Province")
rs("ChinaQJ_Tel")=Request("ChinaQJ_Tel")
rs("ChinaQJ_Fax")=Request("ChinaQJ_Fax")
rs("ChinaQJ_Url")=Request("ChinaQJ_Url")
rs("ChinaQJ_Zip")=Request("ChinaQJ_Zip")

rs("ChinaQJ_AddTime")=now()
rs.update
rs.close
set rs=nothing
response.redirect "ChinaQJ_NetWorkList.asp"
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
<form name="editForm" method="post" action="ChinaQJ_NetWorkEdit.asp?Action=SaveEdit&Result=<%= Request("Result") %>&ID=<%= Request("id") %>">
  <tr>
    <th height="22" colspan="2" sytle="line-height:150%">【<%= pageinfo %>营销网络】</th>
  </tr>
  <tr><td colspan="2">
<% 
set rs = server.createobject("adodb.recordset")
sql="select * from ChinaQJ_Language order by ChinaQJ_Language_Order"
rs.open sql,conn,1,1
lani=1
while(not rs.eof)
%>
<div id="tcontent<%= lani %>" class="tabcontent">
<table class="tableborderOther" width="100%" border="0" align="center" cellpadding="0" cellspacing="1">
  <tr height="35">
    <td align="right" class="forumRow" width="200"><%=rs("ChinaQJ_Language_Name")%>销售点名称：</td>
    <td class="forumRowHighlight"><input name="ChinaQJ_Company<%= rs("ChinaQJ_Language_File") %>" type="text" id="ChinaQJ_Company<%= rs("ChinaQJ_Language_File") %>" style="width: 350px;" value="<%= eval("ChinaQJ_Company"&rs("ChinaQJ_Language_File")) %>" /> <font color="red">*</font></td>
  </tr>
  <tr height="35">
    <td align="right" class="forumRow"><%=rs("ChinaQJ_Language_Name")%>联系地址：</td>
    <td class="forumRowHighlight"><input name="ChinaQJ_Address<%= rs("ChinaQJ_Language_File") %>" type="text" id="ChinaQJ_Address<%= rs("ChinaQJ_Language_File") %>" style="width: 350px;" value="<%= eval("ChinaQJ_Address"&rs("ChinaQJ_Language_File")) %>" //> <font color="red">*</font></td>
  </tr>
  <tr height="35">
    <td align="right" class="forumRow"><%=rs("ChinaQJ_Language_Name")%>联系人：</td>
    <td class="forumRowHighlight"><input name="ChinaQJ_User<%= rs("ChinaQJ_Language_File") %>" type="text" id="ChinaQJ_User<%= rs("ChinaQJ_Language_File") %>" style="width: 200px;" value="<%= eval("ChinaQJ_User"&rs("ChinaQJ_Language_File")) %>" /> <font color="red">*</font></td>
  </tr>
  <tr height="35">
    <td align="right" class="forumRow"><%=rs("ChinaQJ_Language_Name")%>详细说明：</td>
    <td class="forumRowHighlight">
		<div id="div_Con_<%=rs("ChinaQJ_Language_File")%>" style="display:none;"><%= eval("ChinaQJ_Demo" & rs("ChinaQJ_Language_File")) %></div>
		<script>Start_MyEdit("ChinaQJ_Demo<%=rs("ChinaQJ_Language_File")%>","div_Con_<%=rs("ChinaQJ_Language_File")%>");</script>
	</td>
  </tr>
</table>
</div>
<% 
rs.movenext
lani=lani+1
wend
rs.close
set rs=nothing
%>
  <script>showtabcontent("tablist")</script></td>
  </tr>
  <tr height="35">
    <td align="right" class="forumRow">销售区域：</td>
    <td class="forumRowHighlight"><select name="ChinaQJ_Province">
    <option value="">选择省份</option>
<%
sqlp="select * from ChinaQJ_Province"
set rsp=server.createobject("adodb.recordset")
rsp.open sqlp,conn,1,1
while(not rsp.eof)
%>
    <option value="<%= rsp("ChinaQJ_Province") %>" <% If ChinaQJ_Province=rsp("ChinaQJ_Province") Then Response.Write("selected")%>><%= rsp("ChinaQJ_Province") %></option>
<%
rsp.movenext
wend
rsp.close
set rsp=nothing
%>
    </select> <font color="red">*</font></td>
  </tr>
  <tr height="35">
    <td align="right" class="forumRow"><div style="width:200px;">联系电话：</div></td>
    <td class="forumRowHighlight" width="90%"><input name="ChinaQJ_Tel" type="text" id="ChinaQJ_Tel" style="width: 200px;" value="<%= ChinaQJ_Tel %>" /></td>
  </tr>
  <tr height="35">
    <td align="right" class="forumRow">传真号码：</td>
    <td class="forumRowHighlight"><input name="ChinaQJ_Fax" type="text" id="ChinaQJ_Fax" style="width: 200px;" value="<%= ChinaQJ_Fax %>" /></td>
  </tr>
  <tr height="35">
    <td align="right" class="forumRow">邮政编码：</td>
    <td class="forumRowHighlight"><input name="ChinaQJ_Zip" type="text" id="ChinaQJ_Zip" style="width: 200px;" value="<%= ChinaQJ_Zip %>" /> </td>
  </tr>
  <tr height="35">
    <td align="right" class="forumRow">公司网址：</td>
    <td class="forumRowHighlight"><input name="ChinaQJ_Url" type="text" id="ChinaQJ_Url" style="width: 200px;" value="<%= ChinaQJ_Url %>" /></td>
  </tr>
  <tr height="35">
    <td class="forumRow"></td>
    <td class="forumRowHighlight"><input name="submitSaveEdit" type="submit" id="submitSaveEdit" value="保存设置"> <input type="button" value="返回上一页" onclick="history.back(-1)"></td>
  </tr>
  </form>
</table>