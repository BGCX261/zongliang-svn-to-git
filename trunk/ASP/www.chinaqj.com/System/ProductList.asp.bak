<!--#include file="../Include/Const.asp" -->
<!--#include file="../Include/ConnSiteData.asp" -->
<!--#include file="CheckAdmin.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%
if Instr(session("AdminPurview"),"|12,")=0 then
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
'==============================================
'	获取导航Map(System)
'
'=================================================
function PlaceFlag()
  if Result="Search" then
	If Keyword<>"" Then
		Response.Write "产品：列表 -> 检索 -> 关键字：<font color='red'>"&Keyword&"</font>"
	Else
		Response.Write "产品：列表 -> 检索 -> 关键字为空(显示全部产品)"
	End If
  else
    if SortPath<>"" then
      Response.Write "产品：列表 -> <a href='ProductList.asp'>全部</a>"
	  TextPath(SortID)
	else
      Response.Write "产品：列表 -> 全部"
	end if
  end if
end function
%>
<br />
<table class="tableBorder" width="95%" border="0" align="center" cellpadding="5" cellspacing="1">
<form name="formSearch" method="post" action="Search.asp?Result=Products">
  <tr>
    <th height="22" sytle="line-height:150%">【产品检索及分类查看】</th>
  </tr>
  <tr>
    <td class="forumRow">关键字：<input name="Keyword" type="text" value="<%=Keyword%>" size="20"> <input name="submitSearch" type="submit" value="搜索产品"></td>
  </tr>
  <tr>
    <td class="forumRow"><%PlaceFlag()%></td>
  </tr>
  </form>
  <tr><td class="forumRow">
<% If Trim(Request.QueryString("sortid"))="" Then %>
<%= ChinaQJProductFolderb(0) %>
<% Else %>
<%= ChinaQJProductFolderb(Trim(Request.QueryString("sortid"))) %>
<% End If %>
  </td></tr>
</table>
<br />
<table class="tableBorder" width="95%" border="0" align="center" cellpadding="5" cellspacing="1">
<form action="DelContent.asp?Result=Products" method="post" name="formDel">
  <tr>
    <th width="8">ID</th>
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
    <th align="left">中文标题</th>
    <th align="left">英文标题</th>
    <th align="left" width="80">产品编号</th>
    <th align="left" width="35">状态</th>
    <th align="left" width="40">排序</th>
    <th align="left" width="30">人气</th>
    <th width="50">操作</th>
    <th width="30">选择</th>
  </tr>
  <% GetProductsList() %>
  </form>
</table>
<%

'===================================================
'	获取信息列表(Beta)
'	NEW...
'
'===================================================
Function GetProductsList()

	Dim PageShowCount	'页面显示数量
		PageShowCount=20
	Dim InfoCount		'信息总数量
		InfoCount=0
	Dim PageID			'当前页数
		PageID=BetaIsInt(request.QueryString("Page"))
	Dim IPageMax		'总页数
		IPageMax=0
	Dim TabName			'数据表名
		TabName="ChinaQJ_Products"
	Dim StrSql
		StrSql="SELECT TOP "&PageShowCount&" * FROM "&TabName
	
	Dim mOrder
		mOrder=" ORDER BY UpdateTime DESC,ID DESC"	'	排序

	Dim mim
		mim=request.QueryString("im")
	If mim<>"" Then PageID=1 End If

	Dim SqlWhere

	If PageID=0 Then PageID=1 End If

	If request.QueryString("Result")="Search" and request.QueryString("Keyword")<>"" Then				'搜索关键字
		SqlWhere=" ProductNameCh LIKE '%"&request.QueryString("Keyword")&"%'"	'where
	End If
	
	If request.QueryString("mdiy")<>"" Then			'diy type
		If SqlWhere<>"" Then
			SqlWhere=SqlWhere&" AND "&request.QueryString("mdiy")
		Else
			SqlWhere=request.QueryString("mdiy")
		End If
	End If

	If SortID<>"" Then									'类型ID
		If SqlWhere<>"" Then							'
			SqlWhere=SqlWhere&" AND SortID="&SortID		'where
		Else 
			SqlWhere=" SortID="&SortID					'where
		End If
	End If
	If PageID<>0 And PageID<>1 Then									'页面ID
		If SqlWhere<>"" Then							'where!=""
			StrSql=StrSql&" WHERE "&SqlWhere&" AND (ID NOT IN(SELECT TOP "&PageID*PageShowCount-PageShowCount&" ID FROM "&TabName&" WHERE "&SqlWhere&mOrder&")) "&mOrder
		Else
			StrSql=StrSql&" WHERE (ID NOT IN(SELECT TOP "&PageID*PageShowCount-PageShowCount&" ID FROM "&TabName&mOrder&")) "&mOrder
		End If
	Else
		If SqlWhere<>"" Then							'where!=""
			StrSql=StrSql&" WHERE "&SqlWhere&mOrder
		End If
	End If
	
	dim rs	'数据库
	set rs = server.createobject("adodb.recordset")
	rs.open StrSql,conn,0,1
	If rs.eof Then 
		Response.write("<tr><td align=""center"">暂无相关信息</td></tr>")
		exit function
	Else
		Do While Not rs.eof
			Response.write("<tr><td nowrap="" class=""forumRow"">"&rs("ID")&"</td>")
			dim rs2	'数据库
			set rs2 = server.createobject("adodb.recordset")
			rs2.open "select * from ChinaQJ_Language order by ChinaQJ_Language_Order",conn,0,1
			If rs2.eof Then 
				Response.write("暂无相关信息")
				exit function
			Else
				Do While Not rs2.eof
					If rs("ViewFlag"&rs2("ChinaQJ_Language_File")) Then
						Response.write("<td nowrap="""" align=""center"" class=""forumRow"">")
						Response.write("<a href=""Conversion.asp?id="&rs("ID")&"&LX="&TabName&"&Operation=down&ViewLanguage="&rs2("ChinaQJ_Language_File")&""">")
						Response.write("<font color='blue'>√</font></a></td>")
					Else
						Response.Write("<td nowrap="""" align=""center"" class=""forumRow"">")
						Response.write("<a href=""Conversion.asp?id="&rs("ID")&"&LX="&TabName&"&Operation=up&ViewLanguage="&rs2("ChinaQJ_Language_File")&""">")
						Response.write("<font color='red'>×</font></a></td>")
					End If
					rs2.movenext
				Loop
			End If 
			rs2.close
			
			Response.write("		<td nowrap="""" title="""&rs("ProductNameCh")&""" class=""forumRow"">")
			Response.write("			<input type=""text"" name=""ProductNameCh"" size=""35"" value="""&rs("ProductNameCh")&""">")
			Response.write("			<img src=""Images/tm.gif"" width=""20"" height=""20"" title=""标题颜色"" align=""absmiddle"" style=""background-color:"&rs("TitleColor")&""" />")
			Response.write("		</td>")
			Response.write("		<td nowrap="""" title="""&rs("ProductNameEn")&""" class=""forumRow"">")
			Response.write("			<input type=""text"" name=""ProductNameEn"" size=""35"" value="""&rs("ProductNameEn")&""">")
			Response.write("		</td>")
			Response.write("		<td nowrap="""" class=""forumRow""><input type=""text"" name=""ProductNo"" size=""12"" value="""&rs("ProductNo")&"""></td>")
			Response.write("		<td nowrap="""" class=""forumRow"">")
			If rs("NewFlagCh") Then Response.Write("<font color='red'>新品</font>") End If
			If rs("CommendFlagCh") Then Response.Write("<font color='green'>推荐</font>") End If
			If rs("NewFlagCh")=false And rs("CommendFlagCh")=false Then Response.Write("无") End If
			Response.Write("		</td>")
			Response.Write("		<td nowrap="""" class=""forumRow"">")
			Response.Write("			<input type=""text"" name=""Sequence"" size=""5"" value="""&rs("Sequence")&"""  onkeypress=""if(event.keyCode<45||event.keyCode>57)event.returnValue=false"">")
			Response.Write("		</td>")
			Response.Write("		<td nowrap class=""forumRow"">")
			Response.Write("			<input type=""text"" name=""ClickNumber"" size=""5"" value="""&rs("ClickNumber")&""" onkeypress=""if(event.keyCode<45||event.keyCode>57)event.returnValue=false"">")
			Response.Write("		</td>")
			Response.Write("		<td align=""center"" nowrap="""" class=""forumRow"">")
			Response.Write("			<a href='ProductEdit.asp?Result=Modify&ID="&rs("ID")&"'>修改</a>")
			Response.Write("			<input name=""pro_id"" type=""hidden"" value="""&rs("ID")&""">")
			Response.Write("			<a href='ProductList.asp?Action=Copy&ID="&rs("ID")&"'>复制</a>")
			Response.Write("		</td>")
			Response.Write("		<td nowrap align=""center"" class=""forumRow""><input name=""selectID"" type=""checkbox"" value="""&rs("ID")&"""></td>")
			Response.Write("</tr>")
				
			rs.movenext
		Loop
	End if
	rs.close
	set rs=Nothing

	Response.Write("		<tr>")
	Response.Write("			<td colspan=""99"" nowrap align=""right"" class=""forumRow"">")
	Response.Write("				<input type=""submit"" name=""batch"" value=""批量修改产品参数"" onClick=""return test();"">")
	Response.Write("				<input type=""submit"" name=""batch"" value=""中文生效"" onClick=""return test();"">")
	Response.Write("				<input type=""submit"" name=""batch"" value=""中文失效"" onClick=""return test();"">")
	Response.Write("				<input type=""submit"" name=""batch"" value=""英文生效"" onClick=""return test();"">")
	Response.Write("				<input type=""submit"" name=""batch"" value=""英文失效"" onClick=""return test();"">")
	Response.Write("				<input onClick=""CheckAll(this.form)"" name=""buttonAllSelect"" type=""button"" id=""submitAllSearch"" value=""全选"">")
	Response.Write("				<input onClick=""CheckOthers(this.form)"" name=""buttonOtherSelect"" type=""button"" id=""submitOtherSelect"" value=""反选"">")
	Response.Write("				<input name='batch' type='submit' value='删除所选' onClick=""return test();"">")
	Response.Write("			</td>")
	Response.Write("		</tr>")
	Response.Write("		<tr>")
	Response.Write("			<td colspan=""99"" nowrap class=""forumRow"" align='right'>")
	
	'===================
	'	分页
	'=======================================================

	If SqlWhere<>"" Then 
		InfoCount=conn.Execute("SELECT COUNT(*) FROM "&TabName&" WHERE "&SqlWhere)(0)
	Else
		InfoCount=conn.Execute("SELECT COUNT(*) FROM "&TabName)(0)
	End If
	If PageID="" Then PageID=1 End If 
	If InfoCount Mod PageShowCount=0 Then 
		IPageMax=Int(InfoCount/PageShowCount)
	Else 
		IPageMax=Int(InfoCount/PageShowCount)+1
	End If

	Dim urls
		urls=Request.ServerVariables("URL")
	Dim qstr
		qstr="?"&Request.ServerVariables("Query_String")
	Dim qpid
		qpid=request.QueryString("Page")
	If qpid<>"" Then
		qstr=Replace(qstr,"Page="&qpid,"")
	Else
		If qstr<>"?" Then qstr=qstr&"&"	End If
	End If

	If request.QueryString("im")<>"" Then qstr=Replace(qstr,"im=0&","") End If
	
	Dim murl
		murl=urls&qstr
	
	Response.Write("		<tr>")
	Response.Write("			<td colspan=""99"" nowrap class=""forumRow"">")
	Response.Write("				<table width='100%' border='0' align='center' cellpadding='0' cellspacing='0'>")
	Response.Write("					<tr>")
	Response.Write("						<td class=""forumRow"">共计：<font color='red'>"&InfoCount&"</font>条记录 页次：<font color='red'>"&PageID&"</font></strong>/"&IPageMax&" 每页：<font color='red'>"&PageShowCount&"</font>条</td>")
	Response.Write("						<td align='right'>")
	
	
	If PageID=1 Then
		Response.write("<a href=""javascript:;"" class=""mPage"" style=""cursor: not-allowed; text-decoration: none; color: #CCC;"" title=""木有了"">首页</a>")
		Response.write("<a href=""javascript:;"" class=""mPage"" style=""cursor: not-allowed; text-decoration: none; color: #CCC;"" title=""木有了"">上一页</a>")
	Else
		Response.write("<a href="""&murl&"Page=1"" class=""mPage"">首页</a><a href="""&murl&"Page="&(PageID-1)&""" class=""mPage"">上一页</a>")
	End If

	'============
	
	Dim it				' 初使页数
		it=(PageID-2)
	Dim itc				'显示总页数
		itc=5
	
	If PageID<=2 Then it=1 End If
	If IPageMax<itc Then
		itc=IPageMax
	Else
		If PageID+2>=IPageMax Then it=(PageID-(itc-(IPageMax-PageID))) End If
		itc=(it+itc)
	End If
	For i=it To itc
		If (i-PageID)=0 Then
			Response.write("<span class=""mPage"" style=""background-color:#FFBA00; color:#000;"" >"&i&"</span>")
		Else
			Response.write("<a href="""&murl&"Page="&i&""" class=""mPage"">"&i&"</a>")
		End If
	Next
	
	'=================

	If (IPageMax-PageID)<1 Then
		Response.write("<a href=""javascript:;"" class=""mPage"" style=""cursor: not-allowed; text-decoration: none; color: #CCC;"" title=""木有了"">下一页</a>")
		Response.write("<a href=""javascript:;"" class=""mPage"" style=""cursor: not-allowed; text-decoration: none; color: #CCC;"" title=""木有了"">尾页</a>")
	Else
		Response.write("<a href="""&murl&"Page="&(PageID+1)&""" class=""mPage"">下一页</a><a href="""&murl&"Page="&IPageMax&""" class=""mPage"">尾页</a>")
	End If
	
	'==============

	Response.Write("第<input name='SkipPage' onKeyDown='if(event.keyCode==13)event.returnValue=false' onchange=""if(/\D/.test(this.value)){alert('请输入需要跳转到的页数并且必须为整数！');this.value='"&PageID&"';}"" style='width: 28px;' type='text' value='"&PageID&"'")
	If IPageMax<=1 Then Response.write(" disabled=""disabled"" title='No'") End If
	Response.Write(">页<input name='submitSkip' type='button' onClick='GoPage("""&murl&""")' value='转到'")
	If IPageMax<=1 Then Response.write(" disabled=""disabled"" title='No'") End If
	Response.Write("></td>")
	Response.Write("</tr>")
	Response.Write("</table>")

	Response.Write("</td>")
	Response.Write("</tr>")

End Function

'==================================	获取信息列表(old)
function ProductsList()
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
      datafrom="ChinaQJ_Products"
  dim datawhere
      if Result="Search" then
	     datawhere="where ProductNameCh like '%" & Keyword &_
		           "%' "
	  else
	    if SortPath<>"" then
		  datawhere="where Instr(SortPath,'"&SortPath&"')>0 "
        else
		  datawhere=""
		end if
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
      taxis="order by Sequence,id"
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
	  Response.Write "<td nowrap title='"&rs("ProductNameCh")&"' class=""forumRow""><input type=""text"" name=""ProductNameCh"" size=""35"" value="""&rs("ProductNameCh")&"""> <img src=""Images/tm.gif"" width=""20"" height=""20"" title=""标题颜色"" align=""absmiddle"" style=""background-color:"&rs("TitleColor")&"""></td>" & vbCrLf
	  Response.Write "<td nowrap title='"&rs("ProductNameEn")&"' class=""forumRow""><input type=""text"" name=""ProductNameEn"" size=""35"" value="""&rs("ProductNameEn")&"""></td>" & vbCrLf
      Response.Write "<td nowrap class=""forumRow""><input type=""text"" name=""ProductNo"" size=""12"" value="""&rs("ProductNo")&"""></td>" & vbCrLf
      Response.Write "<td nowrap class=""forumRow"">" & vbCrLf
      if rs("NewFlagCh") then Response.Write "<font color='red'>新品</font> "
      if rs("CommendFlagCh") then Response.Write "<font color='green'>推荐</font>"
	  if rs("NewFlagCh") = false And rs("CommendFlagCh") = false then Response.Write "无"
      Response.Write "</td>"
	  Response.Write "<td nowrap class=""forumRow""><input type=""text"" name=""Sequence"" size=""5"" value="""&rs("Sequence")&""" onkeypress=""if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false""></td>" & vbCrLf
	  Response.Write "<td nowrap class=""forumRow""><input type=""text"" name=""ClickNumber"" size=""5"" value="""&rs("ClickNumber")&""" onkeypress=""if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false""></td>" & vbCrLf
      Response.Write "<td align=""center""nowrap class=""forumRow""><a href='ProductEdit.asp?Result=Modify&ID="&rs("ID")&"'>修改</a><input name=""pro_id"" type=""hidden"" value="""&rs("ID")&""">  <a href='ProductList.asp?Action=Copy&ID="&rs("ID")&"'>复制</a></td></td>" & vbCrLf
 	  Response.Write "<td nowrap align='center' class=""forumRow""><input name='selectID' type='checkbox' value='"&rs("ID")&"'></td>" & vbCrLf
      Response.Write "</tr>" & vbCrLf
	  rs.movenext
    wend
    Response.Write "<tr>" & vbCrLf
    Response.Write "<td colspan='99' nowrap align=""right"" class=""forumRow""><input type=""submit"" name=""batch"" value=""批量修改产品参数"" onClick=""return test();""> <input type=""submit"" name=""batch"" value=""中文生效"" onClick=""return test();""> <input type=""submit"" name=""batch"" value=""中文失效"" onClick=""return test();""> <input type=""submit"" name=""batch"" value=""英文生效"" onClick=""return test();""> <input type=""submit"" name=""batch"" value=""英文失效"" onClick=""return test();""> <input onClick=""CheckAll(this.form)"" name=""buttonAllSelect"" type=""button"" id=""submitAllSearch"" value=""全选""> <input onClick=""CheckOthers(this.form)"" name=""buttonOtherSelect"" type=""button"" id=""submitOtherSelect"" value=""反选""> <input name='batch' type='submit' value='删除所选' onClick=""return test();""></td>" & vbCrLf
    Response.Write "</tr>" & vbCrLf
  else
    response.write "<tr><td nowrap align='center' colspan='13' class=""forumRow"">暂无产品信息</td></tr>"
  end if
  Response.Write "<tr>" & vbCrLf
  Response.Write "<td colspan='99' nowrap class=""forumRow"">" & vbCrLf
  Response.Write "<table width='100%' border='0' align='center' cellpadding='0' cellspacing='0'>" & vbCrLf
  Response.Write "<tr>" & vbCrLf
  Response.Write "<td class=""forumRow"">共计：<font color='red'>"&idcount&"</font>条记录 页次：<font color='red'>"&page&"</font></strong>/"&pagec&" 每页：<font color='red'>"&pages&"</font>条</td>" & vbCrLf
  Response.Write "<td align='right'>" & vbCrLf
  pagenmin=page-pagenc
  pagenmax=page+pagenc
  '==================
  '		测试
  '===================
  
  'urls=Request.ServerVariables("URL")
  'qstr="?"&Request.ServerVariables("Query_String")
  
  'qpid=request.QueryString("Page")
  'If qpid<>"" Then
  '	qstr=Replace(qstr,"Page="&qpid,"")
  'End If
  
  'murl=urls&qstr

  '================end

  if(pagenmin<1) then pagenmin=1
  if(page>1) then response.write ("<a href='"& Myself &"Page=1'><font style='font-size: 14px; font-family: Webdings'>9</font></a> ")
  if(pagenmin>1) then response.write ("<a href='"& Myself &"Page="& page-(pagenc*2+1) &"'><font style='font-size: 14px; font-family: Webdings'>7</font></a> ")
  if(pagenmax>pagec) then pagenmax=pagec
  for i = pagenmin to pagenmax
	if(i=page) then
	  response.write (" <font color='red'>"& i &"</font> ")
	else
	  response.write ("[<a href="& Myself &"Page="& i &">"& i &"</a>]")
	end if
  next
  if(pagenmax<pagec) then response.write (" <a href='"& Myself &"Page="& page+(pagenc*2+1) &"'><font style='font-size: 14px; font-family: Webdings'>8</font></a> ")
  if(page<pagec) then response.write ("<a href='"& Myself &"Page="& pagec &"'><font style='font-size: 14px; font-family: Webdings'>:</font></a> ")
  Response.Write "第<input name='SkipPage' onKeyDown='if(event.keyCode==13)event.returnValue=false' onchange=""if(/\D/.test(this.value)){alert('请输入需要跳转到的页数并且必须为整数！');this.value='"&Page&"';}"" style='width: 28px;' type='text' value='"&Page&"'>页" & vbCrLf
  Response.Write "<input name='submitSkip' type='button' onClick='GoPage("""&Myself&""")' title='"&urls&qstr&"' value='转到'>" & vbCrLf
  Response.Write "</td>" & vbCrLf
  Response.Write "</tr>" & vbCrLf
  Response.Write "</table>" & vbCrLf
  rs.close
  set rs=nothing
  Response.Write "</td>" & vbCrLf
  Response.Write "</tr>" & vbCrLf
end Function



if Request("Action")="Copy" then
dim sqlread,rsread,sqlcopy,rscopy
    sqlread="select * from ChinaQJ_Products where id="&Request("ID")
    set rsread=server.createobject("adodb.recordset")
    rsread.open sqlread,conn,1,1

    sqlcopy="select * from ChinaQJ_Products"
    set rscopy=server.createobject("adodb.recordset")
    rscopy.open sqlcopy,conn,1,3
	  rscopy.addnew
  '多语言循环保存数据
set rsl = server.createobject("adodb.recordset")
sqll="select * from ChinaQJ_Language order by ChinaQJ_Language_Order"
rsl.open sqll,conn,1,1
while(not rsl.eof)
  Lan1=rsl("ChinaQJ_Language_File")
  rscopy("ProductName"&Lan1)=rsread("ProductName"&Lan1) & " 复制"
  rscopy("ViewFlag"&Lan1)=rsread("ViewFlag"&Lan1)
  rscopy("CommendFlag"&Lan1)=rsread("CommendFlag"&Lan1)
  rscopy("NewFlag"&Lan1)=rsread("NewFlag"&Lan1)
  rscopy("Content"&Lan1)=rsread("Content"&Lan1)
  rscopy("SeoKeywords"&Lan1)=rsread("SeoKeywords"&Lan1)
  rscopy("SeoDescription"&Lan1)=rsread("SeoDescription"&Lan1)
  rscopy("ProName"&Lan1)=rsread("ProName"&Lan1)
  rscopy("ProInfo"&Lan1)=rsread("ProInfo"&Lan1)
rsl.movenext
wend
rsl.close
set rsl=nothing
	  rscopy("classseo")=rsread("ClassSeo")
      rscopy("SortID")=rsread("SortID")
      rscopy("SortID")=rsread("SortID")
      rscopy("SortPath")=rsread("SortPath")
	  randomize timer
      ProductNo=Hour(now)&Minute(now)&Second(now)&"-"&int(900*rnd)+100
      rscopy("ProductNo")=ProductNo
      rscopy("GroupID")=rsread("GroupID")
      rscopy("Exclusive")=rsread("Exclusive")
	  rscopy("SmallPic")=rsread("SmallPic")
      rscopy("BigPic")=rsread("BigPic")
	  rscopy("OtherPic")=rsread("OtherPic")
	  rscopy("Sequence")=rsread("Sequence")
	  rscopy("TitleColor")=rsread("TitleColor")
	  if PubRndDisplay=1 then
	  rscopy("ClickNumber")=Rnd_ClickNumber(PubRndNumStart,PubRndNumEnd)
	  else
	  rscopy("ClickNumber")=0
	  end if
	  rscopy("PropertiesID")=rsread("PropertiesID")
	  rscopy.update
	  rscopy.close
	  set rscopy=nothing
	 rsread.close
	 set rsread=nothing
	 response.redirect "ProductList.asp"
end if

'=========================================
'	获取导航Map(分类)
'	ID	分类ID
'==============================================
Function TextPath(ID)
  Dim rs,sql
  Set rs=server.CreateObject("adodb.recordset")
  sql="Select * From ChinaQJ_ProductSort where ID="&ID
  rs.open sql,conn,1,1
  TextPath=" -> <a href=ProductList.asp?SortID="&rs("ID")&"&SortPath="&rs("SortPath")&">"&rs("SortNameCh")&"</a>"
  if rs("ParentID")<>0 then TextPath rs("ParentID")
  response.write(TextPath)
End Function

Function SortText(ID)
  Dim rs,sql
  Set rs=server.CreateObject("adodb.recordset")
  sql="Select * From ChinaQJ_ProductSort where ID="&ID
  rs.open sql,conn,1,1
  SortText=rs("SortName")
  rs.close
  set rs=nothing
End Function

'=========================================
'	获取所有分类
'
'==============================================
Function ChinaQJProductFolderb(id)
  Dim rs,sql,i,ChildCount,FolderType,FolderName,onMouseUp,ListType
  Set rs=server.CreateObject("adodb.recordset")
  sql="Select * From ChinaQJ_ProductSort where ParentID="&id&" order by Sequence asc,ID asc"
  rs.open sql,conn,1,1
    if id=0 and rs.recordcount=0 then
        response.write "<center>暂无分类</center>"
        exit function
    end if
  i=1
  while not rs.eof
    ChildCount=conn.execute("select count(*) from ChinaQJ_ProductSort where ParentID="&rs("id"))(0)
    if ChildCount=0 then
      FolderName=rs("SortNameCh")
    else
      FolderName=rs("SortNameCh")
    end If
    datafrom="ChinaQJ_ProductSort"
        AutoLink = "ProductList.Asp?SortID="&rs("ID")&"&SortPath="&rs("SortPath")&""
    response.write("<a href="""&AutoLink&"""><font style=""font-weight:bold; font-size:12px;"">"&FolderName&"</font></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")
    rs.movenext
    i=i+1
    wend
    rs.close
    set rs=Nothing
	If i<>1 Then Response.write("<br />") End If

	Call BetaNewSo("ProductList.Asp","","NewFlagCh","新品")
	Call BetaNewSo("ProductList.Asp","","CommendFlagCh","推荐")
	Call BetaNewSo("ProductList.Asp","NOT ","ViewFlagCh","中文未显示")
	Call BetaNewSo("ProductList.Asp","NOT ","ViewFlagEn","英文未显示")
	Call BetaNewSo("ProductList.Asp","NOT ","ViewFlagJp","日文未显示")

End Function

'=================================
'	测试函数(显示)
'	mAsp		Asp 文件
'	DT			diy 条件[1]
'	DIY			diy 条件[2]
'	Txt			显示名称
'=================================
Function BetaNewSo(mAsp,DT,DIY,Txt)
	If mAsp="" Then mAsp=Request.ServerVariables("Url") End If
	qstr=Request.ServerVariables("Query_String")
	mdiy=request.QueryString("mdiy")
	col=""" title=""点击选择"""
	If request.QueryString("im")<>"" Then qstr=Replace(qstr,"im=0","") End If
	If mdiy<>"" Then
		qstr=Replace(qstr,"mdiy="&Replace(mdiy," ","%20"),"")
		If InStr(mdiy, DIY)<=0 Then
			mdiy=mdiy&" AND "&DT&DIY
		Else
			col="color:#ccc"" title=""点击取消选择"""
			If InStr(mdiy, " AND "&DT&DIY)>0 Then mdiy=Replace(mdiy," AND "&DT&DIY,"") End If
			If InStr(mdiy, DT&DIY&" AND ")>0 Then mdiy=Replace(mdiy,DT&DIY&" AND ","") End If
			If InStr(mdiy, DT&DIY)>0 Then mdiy=Replace(mdiy,DT&DIY,"") End If
		End If
	Else
		mdiy=DT&DIY
	End If

	If qstr="&" Then qstr="" End If
	If qstr<>"" And Left(qstr,1)<>"&" Then qstr="&"&qstr End If 
	qstr=Replace(qstr,"&&","&")

	If mdiy<>"" Then
		Response.write("<a href="""&mAsp&"?im=0&mdiy="&mdiy&qstr&""">")
	Else
		Response.write("<a href="""&mAsp&"?im=0"&qstr&""">")
	End If
	Response.write("<font style=""font-weight:bold; font-size:12px;"&col&""">"&Txt&"</font></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")

End Function 


%>