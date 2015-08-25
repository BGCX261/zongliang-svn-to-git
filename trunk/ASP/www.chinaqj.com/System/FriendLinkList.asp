<!--#include file="../Include/Const.asp" -->
<!--#include file="../Include/ConnSiteData.asp" -->
<!--#include file="CheckAdmin.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%
if Instr(session("AdminPurview"),"|5,")=0 then
  response.write ("<br /><br /><div align=""center""><font style=""color:red; font-size:9pt; "")>您没有管理该模块的权限！</font></div>")
  response.end
end if
%>
<link rel="stylesheet" href="Images/Admin_style.css">
<script language="javascript" src="../Scripts/Admin.js"></script>
<br />
<table class="tableBorder" width="95%" border="0" align="center" cellpadding="5" cellspacing="1">
<form action="DelContent.asp?Result=FriendLink" method="post" name="formDel">
  <tr>
    <th>ID</th>
<% 
set rs = server.createobject("adodb.recordset")
sql="select * from ChinaQJ_Language order by ChinaQJ_Language_Order"
rs.open sql,conn,1,1
while(not rs.eof)
%>
<th><%=rs("ChinaQJ_Language_Name")%></th>
<% 
rs.movenext
wend
rs.close
set rs=nothing
%>
    <th>友情链接标题</th>
	<th width="200">前台显示</th>
	<th>链接地址</th>
	<th>操作</th>
	<th>选择</th>
  </tr>
  <% FriendLinkList() %>
  </form>
</table>
<% if request.QueryString("Result")="ModifySequence" then call ModifySequence() %>
<% if request.QueryString("Result")="SaveSequence" then call SaveSequence() %>
<%
function FriendLinkList()
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
      datafrom="ChinaQJ_FriendLink"
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
      taxis="order by id asc"
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
      Response.Write "<td width=""20"" nowrap class=""forumRow"">"&rs("ID")&"</td>" & vbCrLf
set rs2 = server.createobject("adodb.recordset")
sql2="select * from ChinaQJ_Language order by ChinaQJ_Language_Order"
rs2.open sql2,conn,1,1
while(not rs2.eof)

      if rs("ViewFlag"&rs2("ChinaQJ_Language_File")) then
        Response.Write "<td nowrap align=""center"" class=""forumRow""><a href=""Conversion.asp?id="&rs("ID")&"&LX="&datafrom&"&Operation=down&ViewLanguage="&rs2("ChinaQJ_Language_File")&"""><font color='blue'>√</font></a></td>" & vbCrLf
      else
        Response.Write "<td nowrap align=""center"" class=""forumRow""><a href=""Conversion.asp?id="&rs("ID")&"&LX="&datafrom&"&Operation=up&ViewLanguage="&rs2("ChinaQJ_Language_File")&"""><font color='red'>×</font></a></td>" & vbCrLf
	  end If

rs2.movenext
wend
rs2.close
set rs2=nothing
        Response.Write "<td nowrap class=""forumRow"">"&rs("LinkNameCh")&"</td>" & vbCrLf
	  if rs("LinkType") then
        Response.Write "<td title="""&rs("LinkNameCh")&""" nowrap class=""forumRow""><img align=""absmiddle"" src="""&rs("LinkFaceCh")&"""></td>" & vbCrLf
      else
        Response.Write "<td title="""&rs("LinkNameCh")&""" nowrap class=""forumRow"">"&rs("LinkFaceCh")&"</td>" & vbCrLf
      end if
	  if StrLen(rs("LinkUrl"))>53 then
        Response.Write "<td title="""&rs("LinkUrl")&""" nowrap class=""forumRow""><a href="""&rs("LinkUrl")&""" target=""_blank"">"&StrLeft(rs("LinkUrl"),50)&"</a></td>" & vbCrLf
      else
        Response.Write "<td title="""&rs("LinkUrl")&""" nowrap class=""forumRow""><a href="""&rs("LinkUrl")&""" target=""_blank"">"&rs("LinkUrl")&"</a></td>" & vbCrLf
      end If
      Response.Write "<td width=""60"" align=""center""nowrap class=""forumRow""><a href='FriendLinkEdit.asp?Result=Modify&ID="&rs("ID")&"'>修改</a></td>" & vbCrLf
 	  Response.Write "<td width=""28"" nowrap align='center' class=""forumRow""><input name='selectID' type='checkbox' value='"&rs("ID")&"'></td>" & vbCrLf
      Response.Write "</tr>" & vbCrLf
	  rs.movenext
    wend
    Response.Write "<tr>" & vbCrLf
    Response.Write "<td colspan='10' nowrap align=""right"" class=""forumRow""><input type=""submit"" name=""batch"" value=""中文生效"" onClick=""return test();""> <input type=""submit"" name=""batch"" value=""中文失效"" onClick=""return test();""> <input type=""submit"" name=""batch"" value=""英文生效"" onClick=""return test();""> <input type=""submit"" name=""batch"" value=""英文失效"" onClick=""return test();""> <input onClick=""CheckAll(this.form)"" name=""buttonAllSelect"" type=""button"" id=""submitAllSearch"" value=""全选""> <input onClick=""CheckOthers(this.form)"" name=""buttonOtherSelect"" type=""button"" id=""submitOtherSelect"" value=""反选""> <input name='batch' type='submit' value='删除所选' onClick=""return test();""></td>" & vbCrLf
    Response.Write "</tr>" & vbCrLf
  else
    response.write "<tr><td nowrap align='center' colspan='10' class=""forumRow"">暂无友情链接</td></tr>"
  end if
  Response.Write "<tr>" & vbCrLf
  Response.Write "<td colspan='10' nowrap class=""forumRow"">" & vbCrLf
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