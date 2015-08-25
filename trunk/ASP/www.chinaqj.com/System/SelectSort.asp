<!--#include file="../Include/Const.asp" -->
<!--#include file="../Include/ConnSiteData.asp" -->
<!--#include file="CheckAdmin.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="Images/Admin_style.css">
<script language="javascript" src="../Scripts/Admin.js"></script>
<body>
<br />
<table class="tableBorder" width="95%" border="0" align="center" cellpadding="5" cellspacing="1">
  <tr>
    <th height="22" colspan="2" sytle="line-height:150%">【选择所属类别】</th>
  </tr>
  <tr>
    <td class="forumRow">
<%
Dim Result,Datafrom
Result=request.QueryString("Result")
Select Case Result
	Case "Products"
		Datafrom="ChinaQJ_ProductSort"
	Case "News"
		Datafrom="ChinaQJ_NewsSort"
	Case "Download"
		Datafrom="ChinaQJ_DownSort"
	Case "Others"
		Datafrom="ChinaQJ_OthersSort"
	Case "Image"
		Datafrom="ChinaQJ_ImageSort"
	Case "Magazine"
		Datafrom="ChinaQJ_MagazineSort"
	Case "Video"
		Datafrom="ChinaQJ_VideoSort"
	Case Else
End Select
ListSort(0)
%>
    </td>
  </tr>
</table>
<%
Function ListSort(id)
  Dim rs,sql,i,ChildCount,FolderType,FolderName,onMouseUp,ListType
  Set rs=server.CreateObject("adodb.recordset")
  sql="Select * From "&Datafrom&" where ParentID="&id&" order by Sequence"
  rs.open sql,conn,1,1
  if id=0 and rs.recordcount=0 then
    response.write ("<center>暂无相关分类</center>")
    response.end
  end if
  i=1
  response.write("<table border='0' cellspacing='0' cellpadding='0'>")
  while not rs.eof
    ChildCount=conn.execute("select count(*) from "&Datafrom&" where ParentID="&rs("id"))(0)
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
    end if
    response.write("<tr>")
    response.write("<td nowrap id='b"&rs("id")&"' class='"&FolderType&"' onMouseUp="&onMouseUp&"></td><td nowrap>"&FolderName&"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")
    response.write("<a href=javaScript:AddSort('"&SortText(rs("ID"))&"','"&rs("ID")&"','"&rs("SortPath")&"')><font color='#ff6600'>选择</font></a>")
    response.write("</td></tr>")
    if ChildCount>0 then
%>
      <tr id="a<%= rs("id")%>" style="display:yes"><td class="<%= ListType%>" nowrap></td><td ><% ListSort(rs("id")) %></td></tr>
<%
    end if
    rs.movenext
    i=i+1
  wend
  response.write("</table>")
  rs.close
  set rs=nothing
end function

Function SortText(ID)
  Dim rs,sql
  Set rs=server.CreateObject("adodb.recordset")
  sql="Select * From "&Datafrom&" where ID="&ID
  rs.open sql,conn,1,1
  SortText=rs("SortNameCh")
  SortText=replace(SortText," ","&nbsp;")
  rs.close
  set rs=nothing
End Function
%>