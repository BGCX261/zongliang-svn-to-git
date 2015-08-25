﻿<!--#include file="../Include/Const.asp" -->
<!--#include file="../Include/ConnSiteData.asp" -->
<!--#include file="CheckAdmin.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%
if Instr(session("AdminPurview"),"|26,")=0 then
  response.write ("<br /><br /><div align=""center""><font style=""color:red; font-size:9pt; "")>您没有管理该模块的权限！</font></div>")
  response.end
end if
%>
<link rel="stylesheet" href="Images/Admin_style.css">
<script language="javascript" src="../Scripts/Admin.js"></script>
<%
dim Result,Keyword
Result=request.QueryString("Result")
Keyword=request.QueryString("Keyword")
function PlaceFlag()
  if Result="Search" then
	If Keyword<>"" Then
		Response.Write "人才：列表 -> 检索 -> 关键字：<font color='red'>"&Keyword&"</font>"
	Else
		Response.Write "人才：列表 -> 检索 -> 关键字为空(显示全部人才)"
	End If
  else
    if SortPath<>"" then
      Response.Write "人才：列表 -> <a href='TalentsList.asp'>全部</a>"
	  TextPath(SortID)
	else
      Response.Write "人才：列表 -> 全部"
	end if
  end if
end function
%>
<br />
<table class="tableBorder" width="95%" border="0" align="center" cellpadding="5" cellspacing="1">
<form name="formSearch" method="post" action="Search.asp?Result=Talents">
  <tr>
    <th height="22" sytle="line-height:150%">【人才检索、查看】</th>
  </tr>
  <tr>
    <td class="forumRow">关键字：<input name="Keyword" type="text" value="<%=Keyword%>" size="20"> <input name="submitSearch" type="submit" value="搜索人才"></td>
  </tr>
  <tr>
    <td class="forumRow"><%PlaceFlag()%></td>
  </tr>
  <tr><td class="forumRow">
<%
	'Call BetaNewSo("","","NewFlagCh","新品")
	'Call BetaNewSo("","","CommendFlagCh","推荐")
	'Call BetaNewSo("","NOT ","ViewFlagCh","中文未显示")
	'Call BetaNewSo("","NOT ","ViewFlagEn","英文未显示")
	'Call BetaNewSo("","NOT ","ViewFlagJp","日文未显示")
%>
  </td></tr>
  </form>
</table>
<br />
<table class="tableBorder" width="95%" border="0" align="center" cellpadding="5" cellspacing="1">
<form action="DelContent.asp?Result=Talents" method="post" name="formDel">
  <tr>
    <th>ID</th>
	<th>姓名</th>
	<th>职位名称</th>
	<th>电子信箱</th>
	<th>提交时间</th>
	<th>回复时间</th>
	<th>操作</th>
	<th>选择</th>
  </tr>
  <% GetTalentsList() %>
  </form>
</table>
<%

'=====================================
'
'	获取人才列表
'
'=======================================
function GetTalentsList()
	Dim PageShowCount	'页面显示数量
		PageShowCount=20
	Dim InfoCount		'信息总数量
		InfoCount=0
	Dim PageID			'当前页数
		PageID=BetaIsInt(request.QueryString("Page"))
	Dim IPageMax		'总页数
		IPageMax=0
	Dim TabName			'数据表名
		TabName="ChinaQJ_Talents"
	Dim StrSql
		StrSql="SELECT TOP "&PageShowCount&" * FROM "&TabName
	
	Dim mOrder
		mOrder=" ORDER BY AddTime DESC,ID DESC"	'	排序

	Dim mim
		mim=request.QueryString("im")
	If mim<>"" Then PageID=1 End If

	Dim SqlWhere

	If PageID=0 Then PageID=1 End If

	If request.QueryString("Result")="Search" and request.QueryString("Keyword")<>"" Then				'搜索关键字
		SqlWhere=" TalentsName LIKE '%"&request.QueryString("Keyword")&"%'"	'where
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
			Response.Write "<tr>"
			Response.Write "<td nowrap class=""forumRow"">"&rs("ID")&"</td>"
			Response.Write "<td nowrap class=""forumRow"">"&Guest(rs("MemID"),rs("Linkman"))&"</td>"
			if StrLen(rs("TalentsName"))>33 Then
				Response.Write "<td title="&rs("TalentsName")&" nowrap class=""forumRow"">"&StrLeft(rs("TalentsName"),30)&"</td>"
			Else
				Response.Write "<td title="&rs("TalentsName")&" nowrap class=""forumRow"">"&rs("TalentsName")&"</td>"
			end if 
			if StrLen(rs("Email"))>21 Then
				Response.Write "<td title="&rs("Email")&" nowrap class=""forumRow"">"&StrLeft(rs("Email"),18)&"</td>"
			Else
				Response.Write "<td title="&rs("Email")&" nowrap class=""forumRow"">"&rs("Email")&"</td>"
			end If
			If rs("ReplyTime") <> "" Then
				ReplyTime = rs("ReplyTime")
			Else
				ReplyTime = "<font color=""#CC0000"">暂无回复</font>"
			End If
			Response.Write "<td nowrap class=""forumRow"">"&rs("AddTime")&"</td>"
			Response.Write "<td nowrap class=""forumRow"">"&ReplyTime&"</td>"
			Response.Write "<td align=""center""nowrap class=""forumRow""><a href='TalentsEdit.asp?Result=Modify&ID="&rs("ID")&"'>查看、回复</a></td>"
			Response.Write "<td nowrap align='center' class=""forumRow""><input name='selectID' type='checkbox' value='"&rs("ID")&"'></td>"
			Response.Write "</tr>"

			rs.movenext
		Loop
	End if
	rs.close
	set rs=Nothing

	Response.Write("		<tr>")
	Response.Write("			<td colspan=""99"" nowrap align=""right"" class=""forumRow"">")
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

function TalentsList()
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
      datafrom="ChinaQJ_Talents"
  dim datawhere
      if Result="Search" then
	     datawhere="where TalentsName like '%" & Keyword &_
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
      Response.Write "<td nowrap class=""forumRow"">"&rs("ID")&"</td>" & vbCrLf
      Response.Write "<td nowrap class=""forumRow"">"&Guest(rs("MemID"),rs("Linkman"))&"</td>" & vbCrLf
	  if StrLen(rs("TalentsName"))>33 then
        Response.Write "<td title="&rs("TalentsName")&" nowrap class=""forumRow"">"&StrLeft(rs("TalentsName"),30)&"</td>" & vbCrLf
      else
        Response.Write "<td title="&rs("TalentsName")&" nowrap class=""forumRow"">"&rs("TalentsName")&"</td>" & vbCrLf
      end if 
	  if StrLen(rs("Email"))>21 then
        Response.Write "<td title="&rs("Email")&" nowrap class=""forumRow"">"&StrLeft(rs("Email"),18)&"</td>" & vbCrLf
      else
        Response.Write "<td title="&rs("Email")&" nowrap class=""forumRow"">"&rs("Email")&"</td>" & vbCrLf
      end If
      If rs("ReplyTime") <> "" Then
      ReplyTime = rs("ReplyTime")
	  Else
	  ReplyTime = "<font color=""#CC0000"">暂无回复</font>"
	  End If
      Response.Write "<td nowrap class=""forumRow"">"&rs("AddTime")&"</td>" & vbCrLf
      Response.Write "<td nowrap class=""forumRow"">"&ReplyTime&"</td>" & vbCrLf
      Response.Write "<td align=""center""nowrap class=""forumRow""><a href='TalentsEdit.asp?Result=Modify&ID="&rs("ID")&"'>查看、回复</a></td>" & vbCrLf
 	  Response.Write "<td nowrap align='center' class=""forumRow""><input name='selectID' type='checkbox' value='"&rs("ID")&"'></td>" & vbCrLf
      Response.Write "</tr>" & vbCrLf
	  rs.movenext
    wend
    Response.Write "<tr>" & vbCrLf
    Response.Write "<td colspan='8' nowrap align=""right"" class=""forumRow""><input onClick=""CheckAll(this.form)"" name=""buttonAllSelect"" type=""button"" id=""submitAllSearch"" value=""全选""> <input onClick=""CheckOthers(this.form)"" name=""buttonOtherSelect"" type=""button"" id=""submitOtherSelect"" value=""反选""> <input name='submitDelSelect' type='button' id='submitDelSelect' value='删除所选' onClick='ConfirmDel(""是否确定删除？删除后不能恢复！"");'></td>" & vbCrLf
    Response.Write "</tr>" & vbCrLf
  else
    response.write "<tr><td nowrap align='center' colspan='8' class=""forumRow"">暂无人才信息</td></tr>"
  end if
  Response.Write "<tr>" & vbCrLf
  Response.Write "<td colspan='8' nowrap class=""forumRow"">" & vbCrLf
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

function Guest(ID,Linkman)
  Dim rs,sql
  Set rs=server.CreateObject("adodb.recordset")
  sql="Select * From ChinaQJ_Members where ID="&ID
  rs.open sql,conn,1,1
  if rs.bof and rs.eof then
    Guest=Linkman
  else
    Guest="<font color='green'>会员：</font><a href='MemEdit.asp?Result=Modify&ID="&ID&"'>"&Linkman&"</a>"
  end if
  rs.close
  set rs=nothing
end Function

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