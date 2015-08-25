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
sql="select * from ChinaQJ_Subsidiary where id="&Request("id")
set rs=server.createobject("adodb.recordset")
rs.open sql,conn,1,1
if rs.bof and rs.eof then
	response.write ("<center>数据库记录读取错误！</center>")
	response.end
end If
id=Request("id")
Sequence=rs("Sequence")
  '多语言循环拾取数据
set rsl = server.createobject("adodb.recordset")
sqll="select * from ChinaQJ_Language order by ChinaQJ_Language_Order"
rsl.open sqll,conn,1,1
while(not rsl.eof)
  Lanl=rsl("ChinaQJ_Language_File")
  Subsidiary=rs("Subsidiary"&Lanl)
  execute("Subsidiary"&Lanl&"=Subsidiary")
  if rs("PropertyName"&Lanl)<>"" and rs("PropertyValue"&Lanl)<>"" then
  PropertyName=Split(rs("PropertyName"&Lanl),"§§§")
  PropertyValue=Split(rs("PropertyValue"&Lanl),"§§§")
  Num_1=ubound(PropertyName)+1
  execute("PropertyName"&Lanl&"=PropertyName")
  execute("PropertyValue"&Lanl&"=PropertyValue")
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
set rs3 = server.createobject("adodb.recordset")
sql3="select ChinaQJ_Language_File from ChinaQJ_Language order by ChinaQJ_Language_Order"
rs3.open sql3,conn,1,1
if request("Subsidiary"&rs3("ChinaQJ_Language_File"))="" then
      response.write ("<script language='javascript'>alert('请填写子公司标识！');history.back(-1);</script>")
      response.end
end if
rs3.close
set rs3=nothing
set rs=server.createobject("adodb.recordset")
if Request("id")<>"" then
sql="select * from ChinaQJ_Subsidiary where id="&Request("id")
rs.open sql,conn,1,3
else
sql="select * from ChinaQJ_Subsidiary"
rs.open sql,conn,1,3
rs.addnew
end if
  '多语言循环保存数据
set rsl = server.createobject("adodb.recordset")
sqll="select * from ChinaQJ_Language order by ChinaQJ_Language_Order"
rsl.open sqll,conn,1,1
while(not rsl.eof)
  Lanl=rsl("ChinaQJ_Language_File")
  rs("Subsidiary"&Lanl)=trim(Request.Form("Subsidiary"&Lanl))
  for i=1 to 20
    if Request.Form("PropertyName"&i&Lanl)<>"" and Request.Form("PropertyValue"&i&Lanl)<>"" then
	Num_2=i
	end if
  next
  if Num_2="" then Num_2=0
  if Num_2>0 then
	For i=1 to Num_2
		if Request.Form("PropertyName"&i&Lanl)<>"" and Request.Form("PropertyValue"&i&Lanl)<>"" then
		  if PropertyName2="" then
		    PropertyName2=trim(Request.Form("PropertyName"&i&Lanl))
			PropertyValue2=trim(Request.Form("PropertyValue"&i&Lanl))
		  else
			PropertyName2=PropertyName2&"§§§"&trim(Request.Form("PropertyName"&i&Lanl))
			PropertyValue2=PropertyValue2&"§§§"&trim(Request.Form("PropertyValue"&i&Lanl))
		  end if
		End If
	Next
  end if
  rs("PropertyName"&Lanl)=PropertyName2
  rs("PropertyValue"&Lanl)=PropertyValue2
  PropertyName2=""
  PropertyValue2=""
rsl.movenext
wend
rsl.close
set rsl=nothing

rs("Sequence")=Request("Sequence")
rs("AddTime")=now()
rs.update
rs.close
set rs=nothing
response.write "<script language='javascript'>alert('设置成功！');location.replace('Admin_SubSidiaryList.asp');</script>"
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
  <form name="editForm" method="post" action="Admin_SubSidiaryEdit.Asp?Action=SaveEdit&Result=<%= Request("Result") %>&ID=<%= Request("id") %>">
    <tr>
      <th height="22" colspan="2" sytle="line-height:150%">【添加子公司信息】</th>
    </tr>
  <tr><td colspan="2">
<% 
set rs2 = server.createobject("adodb.recordset")
sql2="select * from ChinaQJ_Language order by ChinaQJ_Language_Order"
rs2.open sql2,conn,1,1
lani=1
while(not rs2.eof)
%>
<div id="tcontent<%= lani %>" class="tabcontent">
<table class="tableborderOther" width="100%" border="0" align="center" cellpadding="0" cellspacing="1">
    <tr height="35">
      <td width="200" align="right" class="forumRow"><%=rs2("ChinaQJ_Language_Name")%>子公司标识：</td>
      <td class="forumRowHighlight"><input name="Subsidiary<%= rs2("ChinaQJ_Language_File") %>" type="text" id="Subsidiary<%= rs2("ChinaQJ_Language_File") %>" style="width: 300" value="<%= eval("Subsidiary"&rs2("ChinaQJ_Language_File")) %>" maxlength="100"> <font color="red">*</font></td>
    </tr>
    <tr height="35">
      <td align="right" class="forumRow"><%=rs2("ChinaQJ_Language_Name")%>子公司参数：</td>
      <td class="forumRowHighlight">
        <%For i=0 to (eval("Num"&rs2("ChinaQJ_Language_File"))-1)%>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td height="28">属性名称：
              <input name="PropertyName<%=i+1%><%= rs2("ChinaQJ_Language_File") %>" type="text" id="PropertyName<%=i+1%><%= rs2("ChinaQJ_Language_File") %>" value="<%=eval("PropertyName"&rs2("ChinaQJ_Language_File"))(i)%>" size="18" />
              属性值：
              <input name="PropertyValue<%=i+1%><%= rs2("ChinaQJ_Language_File") %>" type="text" id="PropertyValue<%=i+1%><%= rs2("ChinaQJ_Language_File") %>" value="<%=eval("PropertyValue"&rs2("ChinaQJ_Language_File"))(i)%>" size="50" /></td>
          </tr>
        </table>
        <%Next%>
        <%For i=eval("Num"&rs2("ChinaQJ_Language_File")) to 19%>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td height="28">属性名称：
              <input name="PropertyName<%=i+1%><%= rs2("ChinaQJ_Language_File") %>" type="text" id="PropertyName<%=i+1%><%= rs2("ChinaQJ_Language_File") %>" value="" size="18" />
              属性值：
              <input name="PropertyValue<%=i+1%><%= rs2("ChinaQJ_Language_File") %>" type="text" id="PropertyValue<%=i+1%><%= rs2("ChinaQJ_Language_File") %>" value="" size="50" /></td>
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
    <tr height="35">
      <td width="200" align="right" class="forumRow">排序：</td>
      <% If Sequence="" Then Sequence=0%>
      <td class="forumRowHighlight"><input name="Sequence" type="text" id="Sequence" style="width: 50" value="<%= Sequence %>" maxlength="10"> <font color="red">排序功能操作提示：控制数据在前台显示的前后顺序，数字越大的排列靠前显示。如默认系统则按添加顺序显示。</font></td>
    </tr>
    
    <tr height="35">
      <td align="right" class="forumRow"></td>
      <td class="forumRowHighlight"><input name="submitSaveEdit" type="submit" id="submitSaveEdit" value="保存设置">
        <input type="button" value="返回上一页" onclick="history.back(-1)"></td>
    </tr>
  </form>
</table>
<br />