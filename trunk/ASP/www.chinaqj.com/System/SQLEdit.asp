<!--#include file="../Include/Const.asp" -->
<!--#include file="../Include/ConnSiteData.asp" -->
<!--#include file="CheckAdmin.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="Images/Admin_style.css">
<script language="javascript" src="../Scripts/Admin.js"></script>
<br />
<%
if Instr(session("AdminPurview"),"|39,")=0 then
	response.write "<center>您没有管理该模块的权限！</center>"
	response.end
end If
dim i,tablename
tablename=trim(request.QueryString("tablename"))
if(len(tablename)<1) then
	response.write "<script language='JavaScript'>alert('数据表参数错误！');" & "history.back()" & "</script>"
	response.End()
end If
dim Action,rsCheckAdd,rs,sql
Action=request.QueryString("Action")
if Action="SaveEdit" then
	fieldname=trim(request.Form("fieldname"))
	if(len(fieldname)<1) then
 		response.write "<script language='JavaScript'>alert('请输入字段名！');" & "history.back()" & "</script>"
 		response.End()
	end if
	fieldtype=trim(request.Form("fieldtype"))
	if(len(fieldtype)<1) then
 		response.write "<script language='JavaScript'>alert('请选择字段类型！');" & "history.back()" & "</script>"
 		response.End()
	end if
	if fieldtype="varchar" then
		charlen=Cint(request.Form("varchar_len"))
		addsql="alter table "&tablename&" add "&fieldname&" "&fieldtype&" ("&charlen&") null"
	else
		addsql="alter table "&tablename&" add "&fieldname&" "&fieldtype
	end if
	conn.execute(addsql)
	Response.Write "<script language=javascript>alert('数据表 "&tablename&" 新字段 "&fieldname&" 添加成功！');window.location.href='"&request.servervariables("http_referer")&"';</script>"
end if
set rs=server.createobject("adodb.recordset")
rs.open "select top 1 * from "&tablename,conn,3,1
%>
<table class="tableBorder" width="95%" border="0" align="center" cellpadding="5" cellspacing="1">
  <tr height="22" sytle="line-height:150%">
    <th align="left" width="200" style="padding-left: 8px">字段名称</th>
    <th align="left" style="padding-left: 8px">字段属性</th>
  </tr>
  <%For i=0 To rs.fields.count-1%>
  <tr>
    <td class="forumRow" style="padding-left: 8px"><%=rs(i).name%></td>
    <td class="forumRow" style="padding-left: 8px"><%
if rs.fields(i).type="3" then
	response.write "长整型"
if rs.fields(i).Attributes="16" then response.write " 自动编号字段"
elseif rs.fields(i).type="202" then
	response.write "文本："
	response.write "长度"&rs.fields(i).DefinedSize
elseif rs.fields(i).type="2" then
	response.write "整形"
elseif rs.fields(i).type="11" then
	response.write "是/否"
elseif rs.fields(i).type="135" Or rs.fields(i).type="7" then
	response.write "日期/时间"
elseif rs.fields(i).type="203" then
	response.write "备注"
elseif rs.fields(i).type="6" then
	response.write "货币"
elseif rs.fields(i).type="205" then
	response.write "OLE 对象"
else
	response.write "未知"&rs.fields(i).type
end if
%></td>
  </tr>
  <%Next%>
</table>
<%
rs.close
set rs=nothing
%>
<br />
<script language="javascript">
function seleChan(str){
	if(str=="varchar"){
		document.getElementById("charlen").style.display="";
	}
	else{
		document.getElementById("charlen").style.display="none";
	}
}
</script>
<table class="tableBorder" width="95%" border="0" align="center" cellpadding="5" cellspacing="1">
  <form name="form1" method="post" action="?Action=SaveEdit&tablename=<%=tablename%>">
    <tr>
      <th height="22" colspan="2" sytle="line-height:150%">【添加新字段】</th>
    </tr>
    <tr>
      <td width="200" class="forumRow" align="right">字段名称：</td>
      <td class="forumRowHighlight"><input name="fieldname" type="text" style="width: 150px">
        <font color="red">*</font></td>
    </tr>
    <tr>
      <td class="forumRow" align="right">字段类型：</td>
      <td class="forumRowHighlight"><select name="fieldtype" style="width: 100px" onChange="seleChan(this.options[this.selectedIndex].value)">
          <option value="int">长整型</option>
          <option value="smallint">整型</option>
          <option value="varchar">文本</option>
          <option value="datetime">日期/时间</option>
          <option value="memo">备注</option>
          <option value="money">货币</option>
          <option value="bit">是/否</option>
        </select>
        <font color="red">*</font></td>
    </tr>
    <tr id="charlen" style="display:none; float:inherit;">
      <td class="forumRow" align="right">字段长度：</td>
      <td class="forumRowHighlight"><input name="varchar_len" type="text" id="varchar_len" style="width: 100px"></td>
    </tr>
    <tr>
      <td class="forumRow"></td>
      <td class="forumRowHighlight"><input name="submitSaveEdit" type="submit" id="submitSaveEdit" value="保存设置">
        <input type="button" value="返回上一页" onclick="history.back(-1)"></td>
    </tr>
  </form>
</table>
<br />
<center>
  <font color="red">警告：本功能将直接操作您的数据库结构，不建议非专业人员使用。在进行任何操作前请备份您的数据！</font>
</center>
<br />