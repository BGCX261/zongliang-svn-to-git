<!--#include file="../Include/Const.asp" -->
<!--#include file="../Include/ConnSiteData.asp" -->
<!--#include file="CheckAdmin.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%
if Instr(session("AdminPurview"),"|41,")=0 then
  response.write ("<br /><br /><div align=""center""><font style=""color:red; font-size:9pt; "")>您没有管理该模块的权限！</font></div>")
  response.end
end if
%>
<link rel="stylesheet" href="Images/Admin_style.css">
<script language="javascript" src="../Scripts/Admin.js"></script>
<br />
<table class="tableBorder" width="95%" border="0" align="center" cellpadding="5" cellspacing="1">
<form action="DelContent.Asp?Result=Language" method="post" name="formDel">
  <tr>
    <th width="8">ID</th>
    <th align="left">语言名称</th>
    <th align="left" width="120">语言图标</th>
    <th align="left" width="60">语言标识</th>
    <th align="left" width="60">语言目录</th>
    <th align="left" width="28">排序</th>
    <th align="left" width="28">状态</th>
    <th width="60">操作</th>
  </tr>
  <% LanguageList() %>
  </form>
</table>
<%
function LanguageList()
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
      datafrom="ChinaQJ_Language"
  dim datawhere
	  datawhere=""
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
      taxis="order by ChinaQJ_Language_Order"
  dim i
  dim rs,sql
  sql="select count(ID) as idCount from ["& datafrom &"]" & datawhere
  set rs=server.createobject("adodb.recordset")
  rs.open sql,conn,0,1
  idCount=rs("idCount")
  if(idcount>0) then
    if(idcount mod pages=0)then
	  pagec=int(idcount/pages)
   	else
      pagec=int(idcount/pages)+1
    end if
    sql="select id from ["& datafrom &"] " & datawhere & taxis
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
    sql="select * from ["& datafrom &"] where id in("& sqlid &") "&taxis
    set rs=server.createobject("adodb.recordset")
    rs.open sql,conn,0,1
    while(not rs.eof)
	  Response.Write "<tr>" & vbCrLf
      Response.Write "<td nowrap class=""forumRow"">"&rs("ID")&"</td>" & vbCrLf
      Response.Write "<td nowrap class=""forumRow""><font color=""red"">"&rs("ChinaQJ_Language_Name")&"</font>"
	  if rs("ChinaQJ_Language_Index") then
	  Response.Write "<font color=""blue"">(首页优先)</font></td>" & vbCrLf
	  end if
	  Response.Write "<td nowrap class=""leftrow""><img src="""&rs("ChinaQJ_Language_Ico")&""" align=""absmiddle""></td>" & vbCrLf
	  Response.Write "<td nowrap class=""leftrow"">"& rs("ChinaQJ_Language_FrontName") &"</td>" & vbCrLf
	  Response.Write "<td nowrap class=""leftrow"">"& rs("ChinaQJ_Language_File") &"</td>" & vbCrLf
	  Response.Write "<td nowrap class=""leftrow"">"& rs("ChinaQJ_Language_Order") &"</td>" & vbCrLf
	  if rs("ChinaQJ_Language_State") then
	  Response.Write "<td nowrap class=""leftrow""><font color=""red"">启用</font></td>" & vbCrLf
	  else
	  Response.Write "<td nowrap class=""leftrow""><font color=""red"">禁用</font></td>" & vbCrLf
	  end if
	  Response.Write "<td nowrap class=""centerrow""><a href=""ChinaQJ_Multi_Language_Edit.Asp?Result=Modify&ID="&rs("ID")&""">修改</a> "
	  if rs("ChinaQJ_Language_Index")=false then
	  Response.Write "<a href=""DelContent.Asp?Result=Language&ID="&rs("ID")&""">删除</a>"
	  end if
	  Response.Write "" & vbCrLf
      Response.Write "</tr>" & vbCrLf
	  rs.movenext
    wend
  else
    response.write "<tr><td nowrap align='center' colspan='11' class=""forumRow"">暂无留言信息</td></tr>"
  end if
  Response.Write "<tr>" & vbCrLf
  Response.Write "<td colspan='11' nowrap class=""forumRow"">" & vbCrLf
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