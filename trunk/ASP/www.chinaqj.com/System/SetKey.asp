<!--#include file="../Include/Const.asp" -->
<!--#include file="../Include/ConnSiteData.asp" -->
<!--#include file="CheckAdmin.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="Images/Admin_style.css">
<script language="javascript" src="../Scripts/Admin.js"></script>
<br />
<%
if Instr(session("AdminPurview"),"|36,")=0 then
  response.write "<center>您没有管理该模块的权限！</center>"
  response.end
End If
%>
<table class="tableBorder" width="95%" border="0" align="center" cellpadding="5" cellspacing="1">
<form action="DelContent.asp?Result=SiteLink" method="post" name="formDel">
  <tr>
    <th width="8">ID</th>
	<th align="left">链接文字</th>
	<th align="left">链接地址</th>
	<th width="60" align="left">优先级别</th>
	<th width="60" align="left">替换次数</th>
	<th width="60" align="left">打开方式</th>
	<th width="30">状态</th>
	<th align="left" width="60">管理</th>
	<th width="28">操作</th>
  </tr>
  <% SetLinkList() %>
  </form>
</table>
<%
function SetLinkList()
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
      datafrom="ChinaQJ_Link"
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
      taxis="order by id desc"
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
      Response.Write "<td nowrap class=""leftrow"">"&rs("ID")&"</td>" & vbCrLf
	  Response.Write "<td nowrap class=""leftrow""><a href=""LinkEdit.asp?id="&rs("ID")&"&Result=Modify"">"&rs("Text")&"</a></td>" & vbCrLf
      Response.Write "<td nowrap class=""leftrow"">"&rs("Link")&"</td>" & vbCrLf
      Response.Write "<td nowrap class=""leftrow"">"&rs("Order")&"</td>" & vbCrLf
	  Response.Write "<td nowrap class=""leftrow"">" & vbCrLf
	  If rs("Replace") = 0 Then
	  Response.Write "不限"
	  Else
	  Response.Write rs("Replace")
	  End If
	  Response.Write "</td>" & vbCrLf
	  Response.Write "<td nowrap class=""leftrow"">" & vbCrLf
	  Select Case Cstr(LCase(rs("Target")))
	  Case "0"
		Response.Write "<font color=""blue"">原窗口</font>"
	  Case "1"
		Response.Write "新窗口"
	  Case Else
		Response.Write rs("Target")
	  End Select
	  Response.Write "</td>" & vbCrLf
	  Response.Write "<td nowrap class=""leftrow"">" & vbCrLf
	  Select Case Cstr(LCase(rs("State")))
	  Case "0"
		Response.Write "<font color=""red"">禁用</font>"
	  Case "1"
		Response.Write "启用"
	  Case Else
		Response.Write rs("State")
	  End Select
	  Response.Write "</td>" & vbCrLf
      Response.Write "<td nowrap class=""leftrow""><a href=""LinkEdit.asp?Result=Add"">添加</a> <a href=""LinkEdit.asp?id="&rs("ID")&"&Result=Modify"">修改</a></td>" & vbCrLf
      Response.Write "<td nowrap class=""centerrow""><input name='selectID' type='checkbox' value='"&rs("ID")&"'></td>" & vbCrLf
      Response.Write "</tr>" & vbCrLf
	  rs.movenext
    wend
    Response.Write "<tr>" & vbCrLf
    Response.Write "<td colspan='9' nowrap class=""forumRow"" align=""right""><input onClick=""CheckAll(this.form)"" name=""buttonAllSelect"" type=""button"" id=""submitAllSearch"" value=""全选""> <input onClick=""CheckOthers(this.form)"" name=""buttonOtherSelect"" type=""button"" id=""submitOtherSelect"" value=""反选""> <input type=""submit"" name=""batch"" value=""批量生效"" onClick=""return test();""> <input type=""submit"" name=""batch"" value=""批量失效"" onClick=""return test();""> <input name='batch' type='submit' value='删除所选' onClick=""return test();""></td>" & vbCrLf
    Response.Write "</tr>" & vbCrLf
  else
    response.write "<tr><td colspan='9' nowrap class=""centerrow"">暂无相关数据</td></tr>"
  end if
  Response.Write "<tr>" & vbCrLf
  Response.Write "<td colspan='9' nowrap class=""leftrow"">" & vbCrLf
  Response.Write "<table width='100%' border='0' align='center' cellpadding='0' cellspacing='0'>" & vbCrLf
  Response.Write "<tr>" & vbCrLf
  Response.Write "<td class=""leftrow"">共<font color='red'> "&idcount&" </font>条记录 页次：<font color='red'>"&page&"</font></strong>/"&pagec&"&nbsp;每页：<font color='red'>"&pages&"</font>条</td>" & vbCrLf
  Response.Write "<td class=""forumRow"" align=""right"">" & vbCrLf
  pagenmin=page-pagenc
  pagenmax=page+pagenc
  if(pagenmin<1) then pagenmin=1
  if(page>1) then response.write ("<a href='"& myself &"Page=1'><font style='font-size: 14px; font-family: webdings'>9</font></a> ")
  if(pagenmin>1) then response.write ("<a href='"& myself &"Page="& page-(pagenc*2+1) &"'><font style='font-size: 14px; font-family: webdings'>7</font></a> ")
  if(pagenmax>pagec) then pagenmax=pagec
  for i = pagenmin to pagenmax
	if(i=page) then
	  response.write (" <font color='red'>"& i &"</font> ")
	else
	  response.write ("[<a href="& myself &"Page="& i &">"& i &"</a>]")
	end if
  next
  if(pagenmax<pagec) then response.write (" <a href='"& myself &"Page="& page+(pagenc*2+1) &"'><font style='font-size: 14px; font-family: webdings'>8</font></a> ")
  if(page<pagec) then response.write ("<a href='"& myself &"Page="& pagec &"'><font style='font-size: 14px; font-family: webdings'>:</font></a> ")
  Response.Write "跳转到：第 <input name='SkipPage' style=""width: 30px"" onKeyDown='if(event.keyCode==13)event.returnValue=false' onchange=""if(/\D/.test(this.value)){alert('请在跳转栏输入数字！');this.value='"&Page&"';}"" type='text' value='"&Page&"'> 页" & vbCrLf
  Response.Write "<input name='submitSkip' type='button' onClick='GoPage("""&Myself&""")' value='转到'>" & vbCrLf
  Response.Write "</td>" & vbCrLf
  Response.Write "</tr>" & vbCrLf
  Response.Write "</table>" & vbCrLf
  rs.close
  set rs=nothing
  Response.Write "</td>" & vbCrLf
  Response.Write "</tr>" & vbCrLf
end function
%>