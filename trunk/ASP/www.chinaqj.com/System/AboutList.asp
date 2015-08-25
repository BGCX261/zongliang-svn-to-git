<!--#include file="../Include/Const.asp" -->
<!--#include file="../Include/ConnSiteData.asp" -->
<!--#include file="CheckAdmin.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%
if Instr(session("AdminPurview"),"|9,")=0 then
  response.write ("<br /><br /><div align=""center""><font style=""color:red; font-size:9pt; "")>您没有管理该模块的权限！</font></div>")
  response.end
end if
%>
<link rel="stylesheet" href="Images/Admin_style.css">
<script language="javascript" src="../Scripts/Admin.js"></script>
<br />
<table class="tableBorder" width="95%" border="0" align="center" cellpadding="5" cellspacing="1">
<form action="DelContent.asp?Result=About" method="post">
  <tr>
    <th height="22" colspan="99" sytle="line-height:150%">【企业信息管理】</th>
  </tr>
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
	<th width="200">信息标题</th>
	<th>查看组别</th>
	<th>阅读权限</th>
	<th>显示顺序</th>
	<th>人气</th>
	<th>操作</th>
	<th>选择</th>
  </tr>
  <% AboutList() %>
  </form>
</table>
<% if request.QueryString("Result")="ModifySequence" then call ModifySequence() %>
<% if request.QueryString("Result")="SaveSequence" then call SaveSequence() %>
<%
'=====================================
'
'	获取信息列表
'
'=======================================
function GetInfoList()
	Dim PageShowCount	'页面显示数量
		PageShowCount=20
	Dim InfoCount		'信息总数量
		InfoCount=0
	Dim PageID			'当前页数
		PageID=BetaIsInt(request.QueryString("Page"))
	Dim IPageMax		'总页数
		IPageMax=0
	Dim TabName			'数据表名
		TabName="ChinaQJ_About"
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
		SqlWhere=" AboutNameCh LIKE '%"&request.QueryString("Keyword")&"%'"	'where
	End If
	
	If request.QueryString("mtp")<>"" Then			'diy type
		Dim mtp
			mtp=request.QueryString("mtp")
		If SqlWhere<>"" Then
			SqlWhere=SqlWhere&" AND "&mtp
		Else
			SqlWhere=mtp
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
			StrSql=StrSql&" WHERE "&SqlWhere&" AND (ID NOT IN(SELECT TOP "&PageID*PageShowCount-PageShowCount&" ID FROM "&TabName&" WHERE "&SqlWhere&mOrder&")) "
		Else
			StrSql=StrSql&" WHERE (ID NOT IN(SELECT TOP "&PageID*PageShowCount-PageShowCount&" ID FROM "&TabName&mOrder&")) "
		End If
	Else
		If SqlWhere<>"" Then							'where!=""
			StrSql=StrSql&" WHERE "&SqlWhere
		End If
	End If
	
	StrSql=StrSql&mOrder

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
				Response.write("<td>Null</td>")
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
  
end Function

function AboutList()
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
      datafrom="ChinaQJ_About"
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
      taxis="order by Sequence asc"
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
	if rs("ParentID")<>0 then
	Response.Write ""
	rs.movenext
	else
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
      Response.Write "<td nowrap class=""forumRow""><a href='AboutEdit.asp?Result=Modify&ID="&rs("ID")&"' title="""&rs("AboutNameCh")&""">"&StrLeft(rs("AboutNameCh"),28)&" | "&StrLeft(rs("AboutNameEn"),28)&"</a>"& vbCrLf
      Response.Write "</td>"& vbCrLf
	    ViewGroupName(rs("GroupID"))
      if rs("Exclusive")=">=" then
        Response.Write "<td nowrap class=""forumRow""><font color='green'>隶属</font></td>" & vbCrLf
      else
        Response.Write "<td nowrap class=""forumRow""><font color='red'>专属</font></td>" & vbCrLf
	  end if	  
      Response.Write "<td nowrap align='center' class=""forumRow""><font color='blue'>"&rs("Sequence")&"</font></td>" & vbCrLf
	  Response.Write "<td nowrap align='center' class=""forumRow"">"&rs("ClickNumber")&"</td>" & vbCrLf
      Response.Write "<td align=""center""nowrap class=""forumRow""><a href='AboutEdit.asp?Result=Modify&ID="&rs("ID")&"'>修改</a> <a href='AboutList.asp?Result=ModifySequence&ID="&rs("ID")&"'>排序</a></td>" & vbCrLf
 	  Response.Write "<td nowrap align='center' class=""forumRow""><input name='selectID' type='checkbox' value='"&rs("ID")&"'></td>" & vbCrLf
      Response.Write "</tr>" & vbCrLf
sql3="select * from ["& datafrom &"] where ParentID="&rs("id")&" "& taxis
set rs3=server.createobject("adodb.recordset")
rs3.open sql3,conn,1,1
if rs3.bof and rs3.eof then
  response.write("")
else
do while not rs3.eof
	  Response.Write "<tr>" & vbCrLf
      Response.Write "<td nowrap class=""forumRow"">"&rs3("ID")&"</td>" & vbCrLf
set rs2 = server.createobject("adodb.recordset")
sql2="select * from ChinaQJ_Language order by ChinaQJ_Language_Order"
rs2.open sql2,conn,1,1
while(not rs2.eof)

      if rs3("ViewFlag"&rs2("ChinaQJ_Language_File")) then
        Response.Write "<td nowrap align=""center"" class=""forumRow""><a href=""Conversion.asp?id="&rs3("ID")&"&LX="&datafrom&"&Operation=down&ViewLanguage="&rs2("ChinaQJ_Language_File")&"""><font color='blue'>√</font></a></td>" & vbCrLf
      else
        Response.Write "<td nowrap align=""center"" class=""forumRow""><a href=""Conversion.asp?id="&rs3("ID")&"&LX="&datafrom&"&Operation=up&ViewLanguage="&rs2("ChinaQJ_Language_File")&"""><font color='red'>×</font></a></td>" & vbCrLf
	  end If

rs2.movenext
wend
rs2.close
set rs2=nothing
      Response.Write "<td nowrap class=""forumRow"">"
	  Response.Write "&nbsp;&nbsp;<img src=""Images/SortEnd_Folder_Open.gif"" align=""absmiddle"" title=""二级分类"" />"
	  Response.Write "<a href='AboutEdit.asp?Result=Modify&ID="&rs3("ID")&"' title="""&rs3("AboutNameCh")&""">"&StrLeft(rs3("AboutNameCh"),28)&" | "&StrLeft(rs3("AboutNameEn"),28)&"</a>"& vbCrLf
      Response.Write "</td>"& vbCrLf
	    ViewGroupName(rs3("GroupID"))
      if rs("Exclusive")=">=" then
        Response.Write "<td nowrap class=""forumRow""><font color='green'>隶属</font></td>" & vbCrLf
      else
        Response.Write "<td nowrap class=""forumRow""><font color='red'>专属</font></td>" & vbCrLf
	  end if	  
      Response.Write "<td nowrap align='center' class=""forumRow"">"
	  Response.Write "&nbsp;&nbsp;<img src=""Images/SortEnd_Folder_Open.gif"" align=""absmiddle"" title=""二级分类"" />"
	  Response.Write "<font color='blue'>"&rs3("Sequence")&"</font></td>" & vbCrLf
	  Response.Write "<td nowrap align='center' class=""forumRow"">"&rs3("ClickNumber")&"</td>" & vbCrLf
      Response.Write "<td align=""center""nowrap class=""forumRow""><a href='AboutEdit.asp?Result=Modify&ID="&rs3("ID")&"'>修改</a> <a href='AboutList.asp?Result=ModifySequence&ID="&rs3("ID")&"'>排序</a></td>" & vbCrLf
 	  Response.Write "<td nowrap align='center' class=""forumRow""><input name='selectID' type='checkbox' value='"&rs3("ID")&"'></td>" & vbCrLf
      Response.Write "</tr>" & vbCrLf
rs3.movenext
loop
end if
rs3.close
set rs3=nothing
	rs.movenext
	end if
    wend
    Response.Write "<tr>" & vbCrLf
    Response.Write "<td colspan='99' nowrap align=""right"" class=""forumRow""><input type=""submit"" name=""batch"" value=""中文生效"" onClick=""return test();""> <input type=""submit"" name=""batch"" value=""中文失效"" onClick=""return test();""> <input type=""submit"" name=""batch"" value=""英文生效"" onClick=""return test();""> <input type=""submit"" name=""batch"" value=""英文失效"" onClick=""return test();""> <input onClick=""CheckAll(this.form)"" name=""buttonAllSelect"" type=""button"" id=""submitAllSearch"" value=""全选""> <input onClick=""CheckOthers(this.form)"" name=""buttonOtherSelect"" type=""button"" id=""submitOtherSelect"" value=""反选""> <input name='batch' type=""submit"" id='batch' value='删除所选' onClick='ConfirmDel(""是否确定删除？删除后不能恢复！"");'></td>" & vbCrLf
    Response.Write "</tr>" & vbCrLf
  else
    response.write "<tr><td nowrap align='center' colspan='10' class=""forumRow"">暂无企业信息</td></tr>"
  end if
  Response.Write "<tr>" & vbCrLf
  Response.Write "<td colspan='99' nowrap class=""forumRow"">" & vbCrLf
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

sub ViewGroupName(GruopID)
  dim rs,sql
  set rs = server.createobject("adodb.recordset")
  sql="select GroupID,GroupNameCh from ChinaQJ_MemGroup where GroupID='"&GruopID&"'"
  rs.open sql,conn,1,1
  if rs.bof and rs.eof then
    response.write("<td nowrap class=""forumRow"">未设组别</td>")
  else
    response.write("<td nowrap class=""forumRow"">"&rs("GroupNameCh")&"</td>")
  end if
  rs.close
  set rs=nothing
end sub

sub ModifySequence()
  dim rs,sql,ID,AboutNameCh,Sequence
  ID=request.QueryString("ID")
  set rs = server.createobject("adodb.recordset")
  sql="select * from ChinaQJ_About where ID="& ID
  rs.open sql,conn,1,1
  AboutName=rs("AboutNameCh")
  Sequence=rs("Sequence")
  rs.close
  set rs=nothing
  response.write "<br />"
  response.write "<table width='100%' border='0' cellpadding='3' cellspacing='0'>"
  response.write "<form action='AboutList.asp?Result=SaveSequence' method='post' name='formSequence'>"
  response.write "<tr>"
  response.write "<td height='24' align='center' nowrap>ID：<input name='ID' type='text' style='width: 28;' value='"&ID&"' maxlength='4' readonly> 企业信息名称：<input name='AboutName' type='text' id='AboutName' style='width: 180;' value='"&AboutName&"' maxlength='35' readonly> 排序号：<input name='Sequence' type='text' style='width: 60;' value='"&Sequence&"' maxlength='4' onKeyDown='if(event.keyCode==13)event.returnValue=false' onchange=""if(/\D/.test(this.value)){alert('序号必须为整数！');this.value='"&Sequence&"';}""> <input name='submitSequence' type='submit' class='button' value='保存'></td>"
  response.write "</tr>"
  response.write "</form>"
  response.write "</table>"
end sub

sub SaveSequence()
  dim rs,sql
  set rs = server.createobject("adodb.recordset")
  sql="select * from ChinaQJ_About where ID="& request.form("ID")
  rs.open sql,conn,1,3
  rs("Sequence")=request.form("Sequence")
  rs.update
  rs.close
  set rs=nothing
  response.redirect "AboutList.asp"
end sub
%>