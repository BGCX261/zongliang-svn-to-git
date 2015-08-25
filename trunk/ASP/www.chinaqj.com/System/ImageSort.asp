<!--#include file="../Include/Const.asp" -->
<!--#include file="../Include/ConnSiteData.asp" -->
<!--#include file="CheckAdmin.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%
if Instr(session("AdminPurview"),"|6,")=0 then
  response.write ("<br /><br /><div align=""center""><font style=""color:red; font-size:9pt; "")>您没有管理该模块的权限！</font></div>")
  response.end
end if
%>
<link rel="stylesheet" href="Images/Admin_style.css">
<script language="javascript" src="../Scripts/Admin.js"></script>
<script language="javascript" src="JavaScript/Tab.js"></script>
<%
Dim Action
Action=request.QueryString("Action")
Select Case Action
  Case "Add"
	addFolder
  	CallFolderView()
  Case "Del"
    Dim rs,sql,SortPath
    Set rs=server.CreateObject("adodb.recordset")
    sql="Select * From ChinaQJ_ImageSort where ID="&request.QueryString("id")
    rs.open sql,conn,1,1
	SortPath=rs("SortPath")
	conn.execute("delete from ChinaQJ_ImageSort where Instr(SortPath,'"&SortPath&"')>0")
    conn.execute("delete from ChinaQJ_Image where Instr(SortPath,'"&SortPath&"')>0")
    response.write ("<script language='javascript'>alert('成功删除本类、子类及所有下属信息条目！');location.replace('ImageSort.asp');</script>")
  Case "Save"
	saveFolder ()
  Case "Edit"
	editFolder
  	CallFolderView()
  Case "Move"
	moveFolderForm ()
  	CallFolderView()
  Case "MoveSave"
	saveMoveFolder ()
  Case Else
	CallFolderView()
End Select
%>
<%Function CallFolderView()%>
<br />
<table class="tableBorder" width="95%" border="0" align="center" cellpadding="0" cellspacing="1">
  <tr>
    <th height="22" sytle="line-height:150%">【管理新闻类别】</th>
  </tr>
  <tr>
    <td align="center" nowrap class="forumRow"><a href="ImageSort.asp?Action=Add&ParentID=0">添加一级分类</a> | <a href="ImageList.asp">查看所有新闻</a></td>
  </tr>
  <tr>
    <td nowrap class="forumRow"><%Folder(0)%></td>
  </tr>
</table>
<%
End Function
Function Folder(id)
  Dim rs,sql,i,ChildCount,FolderType,FolderName,onMouseUp,ListType
  Set rs=server.CreateObject("adodb.recordset")
  sql="Select * From ChinaQJ_ImageSort where ParentID="&id&" order by Sequence"
  rs.open sql,conn,1,1
  if id=0 and rs.recordcount=0 then
    response.write ("<center>暂无新闻分类</center>")
    response.end
  end if
  i=1
  response.write("<table border='0' cellspacing='0' cellpadding='0'>")
  while not rs.eof
    ChildCount=conn.execute("select count(*) from ChinaQJ_ImageSort where ParentID="&rs("id"))(0)
    if ChildCount=0 then
	  if i=rs.recordcount then
	    FolderType="SortFileEnd"
	  else
	    FolderType="SortFile"
	  end if
	  FolderName=rs("SortNameCh")
	  onMouseUp=""
    else
	  if i=rs.recordcount then
	 	FolderType="SortEndFolderClose"
		ListType="SortEndListline"
		onMouseUp="EndSortChange('a"&rs("id")&"','b"&rs("id")&"');"
	  else
		FolderType="SortFolderClose"
		ListType="SortListline"
		onMouseUp="SortChange('a"&rs("id")&"','b"&rs("id")&"');"
	  end if
	  FolderName=rs("SortNameCh")
    end If
    datafrom="ChinaQJ_ImageSort"
    response.write("<tr>")
    response.write("<td nowrap id='b"&rs("id")&"' class='"&FolderType&"'></td><td nowrap><font color=red>"&rs("Sequence")&"</font> "&FolderName&"&nbsp;")
set rs2 = server.createobject("adodb.recordset")
sql2="select * from ChinaQJ_Language order by ChinaQJ_Language_Order"
rs2.open sql2,conn,1,1
while(not rs2.eof)

      if rs("ViewFlag"&rs2("ChinaQJ_Language_File")) then
        Response.Write "<a href=""Conversion.asp?id="&rs("ID")&"&LX="&datafrom&"&Operation=down&ViewLanguage="&rs2("ChinaQJ_Language_File")&"""><font color='blue'>√</font></a>" & vbCrLf
      else
        Response.Write "<a href=""Conversion.asp?id="&rs("ID")&"&LX="&datafrom&"&Operation=up&ViewLanguage="&rs2("ChinaQJ_Language_File")&"""><font color='red'>×</font></a>" & vbCrLf
	  end If

rs2.movenext
wend
rs2.close
set rs2=nothing
    response.write("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color='red'>操作：</font><a href='ImageSort.asp?Action=Add&ParentID="&rs("id")&"'>添加</a>")
    response.write(" | <a href='ImageSort.asp?Action=Edit&ID="&rs("id")&"'>修改</a>")
    response.write(" | <a href='ImageSort.asp?Action=Move&ID="&rs("id")&"&ParentID="&rs("Parentid")&"&SortName="&rs("SortNameCh")&"&SortPath="&rs("SortPath")&"'>移</a>")
    response.write("→<a href='#' onclick='SortFromTo.rows[4].cells[0].innerHTML=""→ "&rs("SortNameCh")&""";MoveForm.toID.value="&rs("ID")&";MoveForm.toParentID.value="&rs("ParentID")&";MoveForm.toSortPath.value="""&rs("SortPath")&""";'>至</a>")
	response.write(" | <a href=javascript:ConfirmDelSort('ImageSort',"&rs("id")&")>删除</a>")
    response.write("&nbsp;&nbsp;&nbsp;&nbsp;<font color='red'>新闻：</font><a href='ImageEdit.asp?Result=Add'>添加</a>")
    response.write(" | <a href='ImageList.asp?SortID="&rs("ID")&"&SortPath="&rs("SortPath")&"'>列表</a>")
    response.write("</td></tr>")
    if ChildCount>0 then
%>
<tr id="a<%= rs("id")%>" style="display:yes">
  <td class="<%= ListType%>" nowrap></td>
  <td ><% Folder(rs("id")) %></td>
</tr>
<%
	end if
    rs.movenext
    i=i+1
	wend
	response.write("</table>")
	rs.close
	set rs=nothing
end Function

Function addFolder()
  Dim ParentID
  ParentID=request.QueryString("ParentID")
  addFolderForm ParentID
end Function

Function addFolderForm(ParentID)
  Dim ParentPath,SortTextPath,rs,sql
  if ParentID=0 then
    ParentPath="0,"
	SortTextPath=""
  else
    Set rs=server.CreateObject("adodb.recordset")
    sql="Select * From ChinaQJ_ImageSort where ID="&ParentID
    rs.open sql,conn,1,1
	ParentPath=rs("SortPath")
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
  <form name="FolderForm" method="post" action="ImageSort.asp?Action=Save&From=Add">
    <tr>
      <th height="22" sytle="line-height:150%" colspan="2">【添加新闻类别】</th>
    </tr>
    <tr height="35">
      <td class="forumRow" colspan="2">| 根类 →
        <% if ParentID<>0 then TextPath(ParentID)%></td>
    </tr>
  <tr><td class="leftRow" colspan="2">
<% 
set rs = server.createobject("adodb.recordset")
sql="select * from ChinaQJ_Language order by ChinaQJ_Language_Order"
rs.open sql,conn,1,1
lani=1
while(not rs.eof)
%>
<div id="tcontent<%= lani %>" class="tabcontent">
<table class="tableborderOther" width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr height="35">
      <td width="20%" class="forumRowOther"><%=rs("ChinaQJ_Language_Name")%>类别名称：</td>
      <td class="forumRowHighlightOther">
        <input name="SortName<%= rs("ChinaQJ_Language_File") %>" type="text" id="SortName<%= rs("ChinaQJ_Language_File") %>" size="28">
        显示：
        <input name="ViewFlag<%= rs("ChinaQJ_Language_File") %>" type="radio" value="1" checked="checked" />
        是
        <input name="ViewFlag<%= rs("ChinaQJ_Language_File") %>" type="radio" value="0" />
        否</td>
    </tr>
    <tr height="35">
      <td class="forumRowOther"><%=rs("ChinaQJ_Language_Name")%>关键字：</td>
      <td class="forumRowHighlightOther"><input name="SeoKeywords<%= rs("ChinaQJ_Language_File") %>" type="text" id="SeoKeywords<%= rs("ChinaQJ_Language_File") %>" style="width: 500px;"> (Keywords)</td>
    </tr>
    <tr height="35">
      <td class="forumRowA"><%=rs("ChinaQJ_Language_Name")%>描述：</td>
      <td class="forumRowHighlight"><input name="SeoDescription<%= rs("ChinaQJ_Language_File") %>" type="text" id="SeoDescription<%= rs("ChinaQJ_Language_File") %>" style="width: 500px;"> (Description)</td>
    </tr>
</table>
</div>
<% 
rs.movenext
lani=lani+1
wend
rs.close
set rs=nothing
%>
  <script>showtabcontent("tablist")</script></td></tr>
    <tr>
      <td width="20%" class="forumRowOther" height="35"><%if ClassSeoISPY = 1 then%>静态名称：</td>
      <td class="forumRowHighlightOther">
    <input name="ClassSeo" type="text" id="ClassSeo" style="width: 500px;" value="" maxlength="100"> <input name="oAutopinyin" type="checkbox" id="oAutopinyin" value="Yes" checked><font color="red">将标题转换为拼音（已填写"静态文件名"则该功能无效）</font> <% End If %></td>
    </tr>
    <tr>
    <td class="forumRowOther" height="35">根目录ID：</td>
    <td class="forumRowHighlightOther">
        <input readonly name="ParentID" type="text" id="ParentID" size="6" value="<%=ParentID %>">
        父类数字路径：
        <input readonly name="ParentPath" type="text" id="ParentPath" size="18" value="<%=ParentPath%>">  排序：<input name="Sequence" type="text" id="Sequence" size="6" value="0" onKeyDown="if(event.keyCode==13)event.returnValue=false" onChange="if(/\D/.test(this.value)){alert('类别排序必须为整数！');this.value='0';}">
        </td>
    </tr>
    <tr height="35">
      <td class="forumRowOther"></td>
      <td class="forumRowHighlightOther"><input name="submitSave" type="submit" id="保存" value="保存设置"></td>
    </tr>

  </form>
</table>
<%
End Function
Function TextPath(ID)
  Dim rs,sql,SortTextPath
  Set rs=server.CreateObject("adodb.recordset")
  sql="Select * From ChinaQJ_ImageSort where ID="&ID
  rs.open sql,conn,1,1
  SortTextPath=rs("SortNameCh")&"&nbsp;→&nbsp;"
  if rs("ParentID")<>0 then TextPath rs("ParentID")
  response.write(SortTextPath)
End Function
Function saveFolder
  if len(trim(request.Form("SortNameCh")))=0 then
      response.write ("<script language='javascript'>alert('请填写类别名称！');history.back(-1);</script>")
      response.end
  end if
  if ClassSeoISPY = 1 then
  if request("oAutopinyin")="" and request.Form("ClassSeo")="" then
      response.write ("<script language='javascript'>alert('请填写静态文件名！');history.back(-1);</script>")
      response.end
  end if
  end if
  Dim From,Action,rs,sql,SortTextPath
  From=request.QueryString("From")
  Set rs=server.CreateObject("adodb.recordset")
  if From="Add" then
    sql="Select * From ChinaQJ_ImageSort"
    rs.open sql,conn,1,3
    rs.addnew
	Action="添加新闻类别"
  else
    sql="Select * From ChinaQJ_ImageSort where ID="&request.QueryString("ID")
    rs.open sql,conn,1,3
	Action="修改新闻类别"
  end if
  '多语言循环保存数据
set rsl = server.createobject("adodb.recordset")
sqll="select * from ChinaQJ_Language order by ChinaQJ_Language_Order"
rsl.open sqll,conn,1,1
while(not rsl.eof)
  rs("SortName"&rsl("ChinaQJ_Language_File"))=trim(Request.Form("SortName"&rsl("ChinaQJ_Language_File")))
  if Request.Form("ViewFlag"&rsl("ChinaQJ_Language_File"))=1 then
	rs("ViewFlag"&rsl("ChinaQJ_Language_File"))=Request.Form("ViewFlag"&rsl("ChinaQJ_Language_File"))
  else
	rs("ViewFlag"&rsl("ChinaQJ_Language_File"))=0
  end if
  rs("SeoKeywords"&rsl("ChinaQJ_Language_File"))=trim(Request.Form("SeoKeywords"&rsl("ChinaQJ_Language_File")))
  rs("SeoDescription"&rsl("ChinaQJ_Language_File"))=trim(Request.Form("SeoDescription"&rsl("ChinaQJ_Language_File")))
rsl.movenext
wend
rsl.close
set rsl=nothing
  rs("Sequence")=request.Form("Sequence")
  If Request.Form("oAutopinyin") = "Yes" And Len(Request("ClassSeo")) = 0 Then
	rs("ClassSeo") = left(Pinyin(request("SortNameCh")),200)
  Else
	rs("ClassSeo") = trim(Request.form("ClassSeo"))
  End If
  rs("ParentID")=request.Form("ParentID")
  rs.update
  rs.MoveLast
  if From="Add" then
  rs("SortPath")=request.Form("ParentPath") & rs("ID") &","
  else
  rs("SortPath")=request.Form("SortPath")
  end if
  rs.Update
  response.write ("<script language='javascript'>alert('"&Action&"成功！');location.replace('ImageSort.asp');</script>")
End Function

Function editFolder()
  Dim ID
  ID=request.QueryString("ID")
  editFolderForm ID
end function

Function editFolderForm(ID)
  Dim SortName,ViewFlag,ParentID,SortPath,rs,sql
  Set rs=server.CreateObject("adodb.recordset")
  sql="Select * From ChinaQJ_ImageSort where ID="&ID
  rs.open sql,conn,1,1
  '多语言循环拾取数据
set rsl = server.createobject("adodb.recordset")
sqll="select * from ChinaQJ_Language order by ChinaQJ_Language_Order"
rsl.open sqll,conn,1,1
while(not rsl.eof)
  Lanl=rsl("ChinaQJ_Language_File")
  SortName=rs("SortName"&Lanl)
  ViewFlag=rs("ViewFlag"&Lanl)
  SeoKeywords=rs("SeoKeywords"&Lanl)
  SeoDescription=rs("SeoDescription"&Lanl)
  execute("SeoKeywords"&Lanl&"=SeoKeywords")
  execute("SeoDescription"&Lanl&"=SeoDescription")
  execute("SortName"&Lanl&"=SortName")
  execute("ViewFlag"&Lanl&"=ViewFlag")
rsl.movenext
wend
rsl.close
set rsl=nothing
  ClassSeo=rs("ClassSeo")
  ParentID=rs("ParentID")
  SortPath=rs("SortPath")
  Sequence=rs("Sequence")
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
  <form name="FolderForm" method="post" action="ImageSort.asp?Action=Save&From=Edit&ID=<%=ID%>">
    <tr>
      <th height="22" sytle="line-height:150%" colspan="2">【修改新闻类别】</th>
    </tr>
    <tr height="35">
      <td class="forumRow" colspan="2">| 根类 →
        <% if ParentID<>0 then TextPath(ParentID)%></td>
    </tr>
  <tr><td class="leftRow" colspan="2">
<% 
set rs = server.createobject("adodb.recordset")
sql="select * from ChinaQJ_Language order by ChinaQJ_Language_Order"
rs.open sql,conn,1,1
lani=1
while(not rs.eof)
%>
<div id="tcontent<%= lani %>" class="tabcontent">
<table class="tableborderOther" width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr height="35">
      <td width="20%" class="forumRowOther"><%=rs("ChinaQJ_Language_Name")%>类别名称：</td>
      <td class="forumRowHighlightOther">
        <input name="SortName<%= rs("ChinaQJ_Language_File") %>" type="text" id="SortName<%= rs("ChinaQJ_Language_File") %>" size="28" value="<%=eval("SortName"&rs("ChinaQJ_Language_File")) %>">
        显示：
        <input name="ViewFlag<%= rs("ChinaQJ_Language_File") %>" type="radio" value="1" <%if eval("ViewFlag"&rs("ChinaQJ_Language_File")) then response.write ("checked")%> />
        是
        <input name="ViewFlag<%= rs("ChinaQJ_Language_File") %>" type="radio" value="0" <%if not eval("ViewFlag"&rs("ChinaQJ_Language_File")) then response.write ("checked")%>/>
        否
         </td>
    </tr>
    <tr height="35">
      <td class="forumRowOther"><%=rs("ChinaQJ_Language_Name")%>关键字：</td>
      <td class="forumRowHighlightOther"><input name="SeoKeywords<%= rs("ChinaQJ_Language_File") %>" type="text" id="SeoKeywords<%= rs("ChinaQJ_Language_File") %>" style="width: 500px;" value="<%=eval("SeoKeywords"&rs("ChinaQJ_Language_File")) %>"> (Keywords)</td>
    </tr>
    <tr height="35">
      <td class="forumRowOther"><%=rs("ChinaQJ_Language_Name")%>描述：</td>
      <td class="forumRowHighlight"><input name="SeoDescription<%= rs("ChinaQJ_Language_File") %>" type="text" id="SeoDescription<%= rs("ChinaQJ_Language_File") %>" style="width: 500px;" value="<%=eval("SeoDescription"&rs("ChinaQJ_Language_File")) %>"> (Description)</td>
    </tr>
</table>
</div>
<% 
rs.movenext
lani=lani+1
wend
rs.close
set rs=nothing
%>
  <script>showtabcontent("tablist")</script></td></tr>
    <%if ClassSeoISPY = 1 then%>
    <tr height="35">
    <td width="20%" class="forumRowOther">静态名称：</td>
    <td width="80%" class="forumRowHighlight">
    <input name="ClassSeo" type="text" id="ClassSeo" style="width: 180" value="<%= ClassSeo %>" maxlength="100"> <input name="oAutopinyin" type="checkbox" id="oAutopinyin" value="Yes" checked><font color="red">将标题转换为拼音（已填写"静态文件名"则该功能无效）</font>
    </td></tr>
	<% End If %>
    <tr height="35">
    <td class="forumRowOther">根目录ID：</td>
    <td width="80%" class="forumRowHighlight">
        <input readonly name="ParentID" type="text" id="ParentID" size="6" value="<%=ParentID %>">父类数字路径：
        <input readonly name="SortPath" type="text" id="SortPath" size="18" value="<%=SortPath%>">  排序：<input name="Sequence" type="text" id="Sequence" size="6" value="<%= Sequence %>" onKeyDown="if(event.keyCode==13)event.returnValue=false" onChange="if(/\D/.test(this.value)){alert('类别排序必须为整数！');this.value='0';}"></td>
    </tr>
    <tr height="35">
    <td class="forumRowOther"></td>
      <td  class="forumRowHighlight"><input name="submitSave" type="submit" id="保存" value="保存设置"></td>
    </tr>
  </form>
</table>
<%
End Function

Function moveFolderForm()
  Dim ID,ParentID,SortName,SortPath
  ID=request.QueryString("ID")
  ParentID=request.QueryString("ParentID")
  SortName=request.QueryString("SortNameCh")
  SortPath=request.QueryString("SortPath")
%>
<br />
<table id="SortFromTo" class="tableBorder" width="95%" border="0" align="center" cellpadding="0" cellspacing="1">
  <form name="MoveForm" method="post" action="ImageSort.asp?Action=MoveSave">
    <tr>
      <th height="22" sytle="line-height:150%">【移动新闻类别】</th>
    </tr>
    <tr>
      <td class="forumRow">→
        <% response.write (SortName) %></td>
    </tr>
    <tr>
      <td class="forumRow">移动类ID：
        <input readonly name="ID" type="text" id="ID" size="8" value="<%=ID%>">
        移动类父ID：
        <input readonly name="ParentID" type="text" id="ParentID" size="8" value="<%=ParentID%>">
        移动类数字路径：
        <input readonly name="SortPath" type="text" id="SortPath" size="28" value="<%=SortPath%>">
        </th>
    </tr>
    <tr>
      <td align="center" class="forumRow"><strong>目标位置：通过点击"至"选择将要放置到的类别。</strong></td>
    </tr>
    <tr>
      <td class="forumRow">→ 请选择…</td>
    </tr>
    <tr>
      <td class="forumRow">目标类ID：
        <input readonly name="toID" type="text" id="toID" size="8" value="">
        目标类父ID：
        <input readonly name="toParentID" type="text" id="toParentID" size="8" value="">
        目标类数字路径：
        <input readonly name="toSortPath" type="text" id="toSortPath" size="28" value=""></td>
    </tr>
    <tr>
      <td align="center" class="forumRow"><input name="submitMove" type="submit" id="转移" value="转移">
        </th>
    </tr>
  </form>
</table>
<%
End Function

Function saveMoveFolder()
  Dim rs,sql,fromID,fromParentID,fromSortPath,toID,toParentID,toSortPath,fromParentSortPath
  fromID=request.Form("ID")
  fromParentID=request.Form("ParentID")
  fromSortPath=request.Form("SortPath")
  toID=request.Form("toID")
  toParentID=request.Form("toParentID")
  toSortPath=request.Form("toSortPath")
  if toID="" or toParentID="" or toSortPath="" then
    response.write ("<script language='javascript'>alert('请选择移动的目标位置！');history.back(-1);</script>")
    response.end
  end if
  if fromParentID=0 then
    response.write ("<script language='javascript'>alert('一级分类无法被移动！');history.back(-1);</script>")
    response.end
  end if
  if fromSortPath=toSortPath then
    response.write ("<script language='javascript'>alert('当前选择的移动类别和目标位置相同，操作无效！');history.back(-1);</script>")
    response.end
  end if
  if Instr(toSortPath,fromSortPath)>0 or fromParentID=toID then
    response.write ("<script language='javascript'>alert('不能将类别移动到本类或下属类里，操作无效！');history.back(-1);</script>")
    response.end
  end if
  Set rs=server.CreateObject("adodb.recordset")
  sql="Select * From ChinaQJ_ImageSort where ID="&fromParentID
  rs.open sql,conn,0,1
  fromParentSortPath=rs("SortPath")
  conn.execute("update ChinaQJ_ImageSort set SortPath='"&toSortPath&"'+Mid(SortPath,Len('"&fromParentSortPath&"')+1) where Instr(SortPath,'"&fromSortPath&"')>0")
  conn.execute("update ChinaQJ_ImageSort set ParentID='"&toID&"' where ID="&fromID)
  conn.execute("update ChinaQJ_Image set SortPath='"&toSortPath&"'+Mid(SortPath,Len('"&fromParentSortPath&"')+1) where Instr(SortPath,'"&fromSortPath&"')>0")
  response.write ("<script language='javascript'>alert('新闻类别移动成功！');location.replace('ImageSort.asp');</script>")
End Function
%>