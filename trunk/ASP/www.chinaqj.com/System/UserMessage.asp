<!--#include file="../Include/Const.asp" -->
<!--#include file="../Include/ConnSiteData.asp" -->
<!--#include file="Admin_htmlconfig.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%
if Instr(session("AdminPurview"),"|40,")=0 then
  response.write ("<br /><br /><div align=""center""><font style=""color:red; font-size:9pt; "")>您没有管理该模块的权限！</font></div>")
  response.end
end if
%>
<link rel="stylesheet" href="Images/Admin_style.css">
<script language="javascript" src="../Scripts/Admin.js"></script>
<%
dim Result,Keyword,SortID,SortPath
Result=request.QueryString("Result")
Keyword=request.QueryString("Keyword")
SortID=request.QueryString("SortID")
SortPath=request.QueryString("SortPath")
function PlaceFlag()
  if Result="Search" Then
	If Keyword<>"" Then
		Response.Write "客户咨询：列表 -> 检索 -> 关键字：<font color='red'>"&Keyword&"</font>"
	Else
		Response.Write "客户咨询：列表 -> 检索 -> 关键字为空(显示全部新闻)"
	End If
  else
    if SortPath<>"" then
      Response.Write "客户咨询：列表 -> <a href='UserMessage.asp'>全部</a>"
	else
      Response.Write "客户咨询：列表 -> 全部"
	end if
  end if
end function
%>
<br />
<table class="tableBorder" width="95%" border="0" align="center" cellpadding="5" cellspacing="1">
<form name="formSearch" method="post" action="Search.asp?Result=UserMessage">
  <tr>
    <th height="22" sytle="line-height:150%">【客户咨询检索及分类查看】</th>
  </tr>
  <tr>
    <td class="forumRow">关键字：<input name="Keyword" type="text" value="<%=Keyword%>" size="20"> <input name="submitSearch" type="submit" value="搜索客户咨询"></td>
  </tr>
  <tr>
    <td class="forumRow"><%PlaceFlag()%></td>
  </tr>
  </form>
</table>
<br />
<table class="tableBorder" width="95%" border="0" align="center" cellpadding="5" cellspacing="1">
<form action="DelContent.asp?Result=UserMessage" method="post" name="formDel">
  <tr>
    <th width="5%">ID</th>
	<th width="6%">处理</th>
	<th align="left">客户咨询内容</th>
	<th width="10%" align="left">电话</th>
	<th width="10%" align="left">地址</th>
	<th width="10%" align="left">信箱</th>
	<th width="10%" align="left">发布时间</th>
	<th width="6%">选择</th>
  </tr>
<% UserMessageList() %>
</form>
</table>
<%
function UserMessageList()
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
      datafrom="ChinaQJ_Biz"
  dim datawhere
      if Result="Search" then
	     datawhere="where BizContent like '%" & Keyword &"%'"
	  end if
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
	i=0
    while(not rs.eof)
	  Response.Write "<tr onclick=""showDetail("&i&")"" style=""cursor: hand"">" & vbCrLf
      Response.Write "<td nowrap class=""forumRow"">"&rs("ID")&"</td>" & vbCrLf
      if rs("BizOK") then
        Response.Write "<td nowrap align='center' class=""forumRow"" width=""50""><font color='blue'>已处理</font></td>" & vbCrLf
      else
        Response.Write "<td nowrap align='center' class=""forumRow"" width=""50""><a href=""Conversion.asp?id="&rs("ID")&"&LX="&datafrom&"&Operation=BizOK""><font color='red'>未处理</font></a></td>" & vbCrLf
	  end If
	  if StrLen((rs("BizContent")))>40 then
        Response.Write "<td nowrap title='"&rs("BizContent")&"' class=""forumRow"">"&StrLeft(rs("BizContent"),37)&"</td>" & vbCrLf
      else
        Response.Write "<td nowrap title='"&rs("BizContent")&"' class=""forumRow"">"&rs("BizContent")&"</td>" & vbCrLf
      end if 
      Response.Write "<td nowrap align=""center"" class=""forumRow"">"&rs("BizPhone")&"</td>" & vbCrLf
      Response.Write "<td nowrap align=""center"" class=""forumRow"">"&rs("BizAddr")&"</td>" & vbCrLf
      Response.Write "<td nowrap align=""center"" class=""forumRow"">"&rs("BizEMail")&"</td>" & vbCrLf
      Response.Write "<td nowrap align=""center"" class=""forumRow"">"&rs("BizDate")&"</td>" & vbCrLf
 	  Response.Write "<td nowrap align='center' class=""forumRow""><input name='selectID' type='checkbox' value='"&rs("ID")&"'></td>" & vbCrLf
      Response.Write "</tr>" & vbCrLf
      Response.Write "<tr style=""display:none;"" id=""detail_"&i&""">" & vbCrLf
      Response.Write "<td colspan=""8"" nowrap align=""left"" bgcolor=""#FFFFF0"">"&rs("BizContent")&"<br />"&rs("BizPhone")&" "&rs("BizEMail")&"<br />"&rs("BizAddr")&"</td>" & vbCrLf
      Response.Write "</tr>" & vbCrLf
	  rs.movenext
	  i=i+1
    wend
    Response.Write "<tr>" & vbCrLf
    Response.Write "<td colspan='9' nowrap align=""right"" class=""forumRow""><input type=""submit"" name=""batch"" value=""批量处理"" onClick=""return test();""> <input onClick=""CheckAll(this.form)"" name=""buttonAllSelect"" type=""button"" id=""submitAllSearch"" value=""全选""> <input onClick=""CheckOthers(this.form)"" name=""buttonOtherSelect"" type=""button"" id=""submitOtherSelect"" value=""反选""> <input name='batch' type='submit' value='删除所选' onClick=""return test();""></td>" & vbCrLf
    Response.Write "</tr>" & vbCrLf
  else
    response.write "<tr><td nowrap align='center' colspan='9' class=""forumRow"">暂无客户咨询</td></tr>"
  end if
  Response.Write "<tr>" & vbCrLf
  Response.Write "<td colspan='9' nowrap class=""forumRow"">" & vbCrLf
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

Function TextPath(ID)
  Dim rs,sql
  Set rs=server.CreateObject("adodb.recordset")
  sql="Select * From ChinaQJ_NewsSort where ID="&ID
  rs.open sql,conn,1,1
  TextPath=" -> <a href=""NewsList.asp?SortID="&rs("ID")&"&SortPath="&rs("SortPath")&""">"&rs("SortName")&"</a>"
  if rs("ParentID")<>0 then TextPath rs("ParentID")
  response.write(TextPath)
End Function

Function ViewGroupName(GruopID)
  dim rs,sql
  set rs = server.createobject("adodb.recordset")
  sql="select GroupID,GroupName from ChinaQJ_MemGroup where GroupID='"&GruopID&"'"
  rs.open sql,conn,1,1
  if rs.bof and rs.eof then
    ViewGroupNameSi="未设组别"
  else
    ViewGroupName=rs("GroupName")
  end if
  rs.close
  set rs=nothing
end Function
%>
<script language="javascript">
<!--
function showDetail(n)
{
	var o = document.getElementById("detail_"+n);
	o.style.display = o.style.display?"":"none";
}
//-->
</script>