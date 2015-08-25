<!--#include file="../Include/Const.asp" -->
<!--#include file="../Include/ConnSiteData.asp" -->
<!--#include file="CheckAdmin.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="Images/Admin_style.css">
<script language="javascript" src="../Scripts/Admin.js"></script>
<%
On Error Resume Next	'-----------Error

If request.QueryString("ID")<>"" Then
	Dim id
		id = request.QueryString("ID")
	
	If request.form("v_hidden_ID")<>"" And request.form("v_hidden_ID")=id Then
		Dim ObjDict
		Set ObjDict = Server.CreateObject("Scripting.Dictionary")
		If request.form("v_hidden_Type")=0 Then
			'改为未解决
			ObjDict.Add "Type",0
			Call SQL_UPDATE("ChinaQJ_Bug",ObjDict,"ID",id)
		Else
			'改为已解决
			ObjDict.Add "Type",-1
			Call SQL_UPDATE("ChinaQJ_Bug",ObjDict,"ID",id)
		End If
	End If

	'Response.write(id)
	'Response.End

	Dim BugInfo
	Set BugInfo = SQL_Query("SELECT * FROM ChinaQJ_Bug WHERE ID = "&id)
	If BugInfo.Count Then
		arr_tags=Split(Replace(BugInfo("0")("Bugs"),"&nbsp;",""),",")
%>
		<span style="margin-left:200px;"><a href="BUG.asp"><font style="margin-top:10px;" >返回列表</font></a></span>
		<br />
		<style>.txt_rd{color:#999;border: 1px solid #ccc;background-color:#fff;width:350px;}</style>
		<table class="tableBorder" width="95%" border="0" align="center" cellpadding="5" cellspacing="1">
		  <form name="editForm" method="post" action="BUG.asp?ID=<%=id%>">
			<tr>
			  <th height="22" colspan="2" sytle="line-height:150%">查看BUG反馈详细</th>
			</tr>
			<tr>
			  <td width="20%" align="right" class="forumRow">ID</td>
			  <td width="80%" class="forumRowHighlight"><input type="text" class="txt_rd" value="<%=BugInfo("0")("ID")%>" readonly></td>
			</tr>
			<tr>
			  <td width="20%" align="right" class="forumRow">标题</td>
			  <td width="80%" class="forumRowHighlight"><input type="text" class="txt_rd" value="<%=BugInfo("0")("Title")%>" readonly></td>
			</tr>
			<tr>
			  <td width="20%" align="right" class="forumRow">BUG页面(来源)</td>
			  <td width="80%" class="forumRowHighlight"><input type="text" class="txt_rd" value="<%=BugInfo("0")("Url")%>" readonly>
			  <%If BugInfo("0")("Url")<>"" Then %><a href="<%=BugInfo("0")("Url")%>" target='_blank'>查看页面</a><%End If%>
			  </td>
			</tr>
			<tr>
			  <td width="20%" align="right" class="forumRow">BUG选项</td>
			  <td width="80%" class="forumRowHighlight">
			  <textarea rows="8" class="txt_rd" readonly>
<%
			For aib=0 To ubound(arr_tags)
%>
				<%=arr_tags(aib)%>. <%=getTagName(arr_tags(aib))%><br />
<%
			Next
%>
			  </textarea>
			  <!--<input type="text" class="txt_rd" value="<%=BugInfo("0")("Bugs")%>" readonly>-->
			  <a href="BUG.asp?TypeSel=yes" >管理选项</a>
			  </td>
			</tr>
			<tr>
			  <td align="right" class="forumRow">其它说明：</td>
			  <td class="forumRowHighlight"><textarea rows="8" class="txt_rd" style="width: 500" readonly><%=BugInfo("0")("Content")%></textarea></td>
			</tr>
			<tr>
			  <td align="center" colspan="2">用户信息</td>
			</tr>
			<tr>
			  <td width="20%" align="right" class="forumRow">姓名</td>
			  <td width="80%" class="forumRowHighlight"><input type="text" class="txt_rd" value="<%=BugInfo("0")("Name")%>" readonly></td>
			</tr>
			<tr>
			  <td width="20%" align="right" class="forumRow">性别</td>
			  <td width="80%" class="forumRowHighlight"><input type="text" class="txt_rd" value="<%=BugInfo("0")("Sex")%>" readonly></td>
			</tr>
			<tr>
			  <td width="20%" align="right" class="forumRow">电话</td>
			  <td width="80%" class="forumRowHighlight"><input type="text" class="txt_rd" value="<%=BugInfo("0")("Phone")%>" readonly></td>
			</tr>
			<tr>
			  <td width="20%" align="right" class="forumRow">邮箱</td>
			  <td width="80%" class="forumRowHighlight"><input type="text" class="txt_rd" value="<%=BugInfo("0")("Email")%>" readonly></td>
			</tr>
			<tr>
			  <td width="20%" align="right" class="forumRow">浏览器</td>
			  <td width="80%" class="forumRowHighlight"><input type="text" class="txt_rd" value="<%=BugInfo("0")("Browser")%>" readonly></td>
			</tr>
			<tr>
			  <td width="20%" align="right" class="forumRow">操作系统</td>
			  <td width="80%" class="forumRowHighlight"><input type="text" class="txt_rd" value="<%=BugInfo("0")("OS")%>" readonly></td>
			</tr>
			<tr>
			  <td width="20%" align="right" class="forumRow">IP</td>
			  <td width="80%" class="forumRowHighlight"><input type="text" class="txt_rd" value="<%=BugInfo("0")("IP")%>" readonly></td>
			</tr>
			<tr>
			  <td align="right" class="forumRow">其它信息：</td>
			  <td class="forumRowHighlight"><textarea rows="8" class="txt_rd" style="width: 500" readonly><%=BugInfo("0")("OtherCInfo")%></textarea></td>
			</tr>
			<tr>
			  <td width="20%" align="right" class="forumRow">提交时间</td>
			  <td width="80%" class="forumRowHighlight"><input type="text" class="txt_rd" value="<%=BugInfo("0")("Time")%>" readonly></td>
			</tr>
			<tr>
			  <td align="right" class="forumRow"></td>
			  <td class="forumRowHighlight">
			  <input type="hidden" name="v_hidden_ID" value="<%=id%>" />
<%
		If BugInfo("0")("Type")=0 Then
%>
 			  <input type="hidden" name="v_hidden_Type" value="1" />
			  <input name="submitSaveEdit" type="submit" id="submitSaveEdit" value="报告该BUG已解决" />
<%
		Else
%>
			  <input type="hidden" name="v_hidden_Type" value="0" />
			  <input name="submitSaveEdit" type="submit" id="submitSaveEdit" value="报告该BUG尚未解决" />
<%
		End If
%>
			  <input type="button" value="返回上一页" onclick="history.back(-1)"></td>
			</tr>
		  </form>
		</table>
<%
		Response.End
	End If
End If

If request.QueryString("TypeSel")<>"" And request.QueryString("TypeSel")="yes" Then
	Dim TypeSel
		TypeSel = request.QueryString("TypeSel")

	'Response.write(TypeSel)
	'Response.End

	If request.form("v_hidden_BugTags")<>"" Then
	'	Dim ObjDict
	'	Set ObjDict = Server.CreateObject("Scripting.Dictionary")
		
		Dim oi
			oi = 0
		
		Do While request.form("txt_id_"&oi)<>"" 
			Dim ObjDicts
			Set ObjDicts = Server.CreateObject("Scripting.Dictionary")
			ObjDicts.Add "Title",request.form("txt_val_"&oi)

			If request.form("txt_id_"&oi)=0 Then
				Call SQL_INSERT("ChinaQJ_Bug_Tags",ObjDicts)
			Else
				Call SQL_UPDATE("ChinaQJ_Bug_Tags",ObjDicts,"ID",request.form("txt_id_"&oi))
			End If

			'Response.write("ID:"&request.form("txt_id_"&oi)&" => "&request.form("txt_val_"&oi))
			oi = oi + 1
		Loop
		'Response.End
		
	End If

	'Response.write(id)
	'Response.End

	Dim BugSel
	Set BugSel = SQL_Query("SELECT * FROM ChinaQJ_Bug_Tags")
	If BugSel.Count Then
%>
		<span style="margin-left:200px;"><a href="BUG.asp"><font style="margin-top:10px;" >返回列表</font></a></span>
		<br />
		<style>.txt_rd{color:#999;border: 1px solid #ccc;background-color:#fff;width:50px;}.txt_ed{border: 1px solid #999;width:350px;}</style>
		<script type="text/javascript" src="JavaScript/BUG.js"></script>
		<form name="editForm" method="post" action="BUG.asp?TypeSel=yes">
		<table id="atb_BTags" class="tableBorder" width="95%" border="0" align="center" cellpadding="5" cellspacing="1">
		  <tbody id="tb_BTags">
			<tr>
			  <th height="22" colspan="2" sytle="line-height:150%">查看BUG反馈选项</th>
			</tr>
			<tr>
			  <td width="20%" align="right" class="forumRow">ID</td>
			  <td width="80%" class="forumRowHighlight">Value</td>
			</tr>
<%
		For i=0 To BugSel.Count-1
			
%>
			<tr>
			  <td width="20%" align="right" class="forumRow">
				<input type="text" id="txt_id_<%=i%>" name="txt_id_<%=i%>" class="txt_rd" value="<%=BugSel(""&i&"")("ID")%>" readonly />
			  </td>
			  <td width="80%" class="forumRowHighlight">
				<input type="text" id="txt_val_<%=i%>" name="txt_val_<%=i%>" class="txt_ed" value="<%=BugSel(""&i&"")("Title")%>" />
			  </td>
			</tr>
<%
		Next
%>
			<tr>
			  <td align="right" class="forumRow"></td>
			  <td class="forumRowHighlight"><a href="javascript:;" onclick="addTab();">添加选项</a></td>
			</tr>
			<tr>
			  <td align="right" class="forumRow"></td>
			  <td class="forumRowHighlight">
			  <input type="hidden" id="v_ids" name="v_hidden_BugTags" value="0" />
			  <input name="submitSaveEdit" type="submit" id="submitSaveEdit" value="提交" />
			  <input type="button" value="返回上一页" onclick="history.back(-1)"></td>
			</tr>
		  </tbody>
		</table>
		</form>
<%
		Response.End
	End If
End If


dim Result,Keyword
Result=request.QueryString("Result")
Keyword=request.QueryString("Keyword")
function PlaceFlag()
  if Result="Search" then
	If Keyword<>"" Then
		Response.Write "BUG：列表 -> 检索 -> 关键字：<font color='red'>"&Keyword&"</font>"
	Else
		Response.Write "BUG：列表 -> 检索 -> 关键字为空(显示全部BUG)"
	End If
  else
    if SortPath<>"" then
      Response.Write "BUG：列表 -> <a href='MessageList.asp'>全部</a>"
	  TextPath(SortID)
	else
      Response.Write "BUG：列表 -> 全部"
	end if
  end if
end function
%>
<br />
<table class="tableBorder" width="95%" border="0" align="center" cellpadding="5" cellspacing="1">
<form name="formSearch" method="post" action="Search.asp?Result=Bug">
  <tr>
    <th height="22" sytle="line-height:150%">【BUG检索查看】</th>
  </tr>
  <tr>
    <td class="forumRow">关键字：<input name="Keyword" type="text" value="<%=Keyword%>" size="20"> <input name="submitSearch" type="submit" value="搜索BUG">
	<span style="margin-left:500px;">&nbsp;</span><a href="BUG.asp?TypeSel=yes">BUG选项管理</a>(<font color="red">New</font>)
	</td>
  </tr>
  <tr>
    <td class="forumRow"><%PlaceFlag()%></td>
  </tr>
  <tr><td class="forumRow">
<%
	'Call BetaNewSo("MessageList.asp","","NewFlagCh","新品")
	'Call BetaNewSo("MessageList.asp","","CommendFlagCh","推荐")
	'Call BetaNewSo("MessageList.asp","NOT ","ViewFlagCh","中文未显示")
	'Call BetaNewSo("MessageList.asp","NOT ","ViewFlagEn","英文未显示")
	'Call BetaNewSo("MessageList.asp","NOT ","ViewFlagJp","日文未显示")
%>
  </td></tr>
  </form>
</table>
<br />
<table class="tableBorder" width="95%" border="0" align="center" cellpadding="5" cellspacing="1">
<form action="DelContent.asp?Result=Bug" method="post" name="formDel">
  <tr>
    <th>ID</th>
	<th>BUG标题</th>
	<th>BUG页面</th>
	<th>BUG状态</th>
	<th>反馈用户</th>
	<th>反馈时间</th>
	<th>操作</th>
	<th>选择</th>
  </tr>
  <% GetBUGList() %>
  </form>
</table>
<%

'=====================================
'
'	获取BUG列表
'
'=======================================
function GetBUGList()
	Dim PageShowCount	'页面显示数量
		PageShowCount=20
	Dim InfoCount		'信息总数量
		InfoCount=0
	Dim PageID			'当前页数
		PageID=BetaIsInt(request.QueryString("Page"))
	Dim IPageMax		'总页数
		IPageMax=0
	Dim TabName			'数据表名
		TabName="ChinaQJ_Bug"
	Dim StrSql
		StrSql="SELECT TOP "&PageShowCount&" * FROM "&TabName
	
	Dim mOrder
		mOrder=" ORDER BY [Time] DESC,ID DESC"	'	排序

	Dim mim
		mim=request.QueryString("im")
	If mim<>"" Then PageID=1 End If

	Dim SqlWhere

	If PageID=0 Then PageID=1 End If

	If request.QueryString("Result")="Search" and request.QueryString("Keyword")<>"" Then				'搜索关键字
		SqlWhere=" Title LIKE '%"&request.QueryString("Keyword")&"%'"	'where
	End If
	
	If request.QueryString("mdiy")<>"" Then			'diy type
		If SqlWhere<>"" Then
			SqlWhere=SqlWhere&" AND "&request.QueryString("mdiy")
		Else
			SqlWhere=request.QueryString("mdiy")
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
	rs.open StrSql,Conn,0,1
	If rs.eof Then
		Response.write("<tr><td align=""center"">暂无相关信息</td></tr>")
		exit function
	Else
		Do While Not rs.eof
			Response.write "<tr><td nowrap="" class=""forumRow"">"&rs("ID")&"</td>"
			Response.Write "<td title="&rs("Title")&" nowrap class=""forumRow""><a href='BUG.asp?id="&rs("ID")&"'>"&StrLeft(rs("Title"),39)&"</a></td>"
			Response.Write "<td title="&rs("Url")&" nowrap class=""forumRow""><a href='"&rs("Url")&"' target='_blank'>"&StrLeft(rs("Url"),39)&"</a></td>"
			If rs("Type")<>0 Then
				Response.Write "<td nowrap class=""forumRow"" style='color:#09F;'>已解决</td>"
			Else
				Response.Write "<td nowrap class=""forumRow"" style='color:#CC3300;'>未解决</td>"
			End If
			Response.Write "<td title="&rs("Name")&" nowrap class=""forumRow"">"&StrLeft(rs("Name"),39)&"</td>"
			Response.Write "<td title="&rs("Time")&" nowrap class=""forumRow"">"&StrLeft(rs("Time"),39)&"</td>"
			Response.Write "<td nowrap class=""forumRow""><a href='BUG.asp?id="&rs("ID")&"'>查看详细</a></td>"
			Response.Write "<td nowrap class=""forumRow""><input name='selectID' type='checkbox' value='"&rs("ID")&"'></td>"
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
		InfoCount=Conn.Execute("SELECT COUNT(*) FROM "&TabName&" WHERE "&SqlWhere)(0)
	Else
		InfoCount=Conn.Execute("SELECT COUNT(*) FROM "&TabName)(0)
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

'============================
'	定义函数,获取选项内容(Beta)
'	id	选项ID
'=============================
Function getTagName(id)
	Dim mryes
	Set myres = SQL_Query("SELECT * FROM ChinaQJ_Bug_Tags WHERE ID="&id)
	If myres.Count Then
		getTagName = myres("0")("Title")
	Else
		getTagName = "未知选项"
	End If
End Function

LogPageError("后台BUG操作页面")			'--log error
%>