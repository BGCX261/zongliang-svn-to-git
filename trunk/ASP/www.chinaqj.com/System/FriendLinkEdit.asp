<!--#include file="../Include/Const.asp" -->
<!--#include file="../Include/ConnSiteData.asp" -->
<!--#include file="CheckAdmin.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%
if Instr(session("AdminPurview"),"|4,")=0 then
  response.write ("<br /><br /><div align=""center""><font style=""color:red; font-size:9pt; "")>您没有管理该模块的权限！</font></div>")
  response.end
End If
dim Result
Result=request.QueryString("Result")
dim ID,LinkNameCh,LinkNameEn,ViewFlagCh,ViewFlagEn,LinkType,LinkFaceCh,LinkFaceEn,LinkUrl,Remark
ID=request.QueryString("ID")
call FriendLinkEdit()
%>
<link rel="stylesheet" href="Images/Admin_style.css">
<script language="javascript" src="../Scripts/Admin.js"></script>
<script language="javascript" src="JavaScript/Tab.js"></script>
<script language="javascript">
<!--
function showUploadDialog(s_Type, s_Link, s_Thumbnail){
    var arr = showModalDialog("eWebEditor/dialog/i_upload.htm?style=coolblue&type="+s_Type+"&link="+s_Link+"&thumbnail="+s_Thumbnail, window, "dialogWidth: 0px; dialogHeight: 0px; help: no; scroll: no; status: no");
}
//-->
</script>
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
<table class="tableBorder" width="95%" border="0" align="center" cellpadding="" cellspacing="1">
<form name="editForm" method="post" action="FriendLinkEdit.asp?Action=SaveEdit&Result=<%=Result%>&ID=<%=ID%>">
  <tr height="35">
    <th height="22" colspan="2" sytle="line-height:150%">【<%If Result = "Add" then%>添加<%ElseIf Result = "Modify" then%>修改<%End If%>友情链接】</th>
  </tr>
  <tr><td colspan="2">
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
    <td width="20%" align="right" class="forumRow"><%=rs("ChinaQJ_Language_Name")%>标题：</td>
    <td width="80%" class="forumRowHighlight"><input name="LinkName<%= rs("ChinaQJ_Language_File") %>" type="text" id="LinkName<%= rs("ChinaQJ_Language_File") %>" style="width: 180" value="<%=eval("LinkName"&rs("ChinaQJ_Language_File"))%>"> <input name="ViewFlag<%= rs("ChinaQJ_Language_File") %>" type="checkbox" value="1" <%if eval("ViewFlag"&rs("ChinaQJ_Language_File")) then response.write ("checked")%>>是否发布 <font color="red">*</font></td>
  </tr>
  <tr height="35">
    <td width="20%" align="right" class="forumRow"><%=rs("ChinaQJ_Language_Name")%>前台显示：</td>
    <td width="80%" class="forumRowHighlight"><input name="LinkFace<%= rs("ChinaQJ_Language_File") %>" type="text" id="LinkFace<%= rs("ChinaQJ_Language_File") %>" style="width: 280" value="<%=eval("LinkFace"&rs("ChinaQJ_Language_File"))%>"> <input type="button" value="上传图片" onclick="showUploadDialog('image', 'editForm.LinkFace<%= rs("ChinaQJ_Language_File") %>', '')"> <font color="red">*</font></td>
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
  <tr height="35">
    <td align="right" class="forumRow">链接类型：</td>
    <td class="forumRowHighlight"><input name="LinkType" type="radio" value="1" <%if LinkType then response.write ("checked=checked")%> />图片 <input name="LinkType" type="radio" value="0" <%if not LinkType then response.write ("checked=checked")%> />文字</td>
  </tr>
  <tr height="35">
    <td align="right" class="forumRow">链接网址：</td>
    <td class="forumRowHighlight"><input name="LinkUrl" type="text" id="LinkUrl" style="width: 280" value="<%=LinkUrl%>"> <font color="red">*</font></td>
  </tr>
  <tr height="35">
    <td width="20%" align="right" class="forumRow">简短说明：</td>
    <td width="80%" class="forumRowHighlight"><textarea name="Remark" rows="8" id="Remark" style="width: 500"><%=Remark%></textarea></td>
  </tr>
  <tr height="35">
    <td align="right" class="forumRow"></td>
    <td class="forumRowHighlight"><input name="submitSaveEdit" type="submit" id="submitSaveEdit" value="保存"> <input type="button" value="返回上一页" onclick="history.back(-1)"></td>
  </tr>
  </form>
</table>
<%
sub FriendLinkEdit()
  dim Action,rsCheckAdd,rs,sql
  Action=request.QueryString("Action")
  if Action="SaveEdit" then
    set rs = server.createobject("adodb.recordset")
    if len(trim(request.Form("LinkNameCh")))<2 then
      response.write ("<script language='javascript'>alert('请填写网站名称并保持至少在两个汉字以上！');history.back(-1);</script>")
      response.end
    end if
    if trim(request.Form("LinkFaceCh"))="" then
      response.write ("<script language='javascript'>alert('请填写前台显示文字或上传友情链接LOGO图片！');history.back(-1);</script>")
      response.end
    end if
    if request.Form("LinkType")=0 then
      if trim(request.Form("LinkFaceCh"))="" then
      response.write ("<script language='javascript'>alert('请填写前台显示文字或图片地址！');history.back(-1);</script>")
      response.end
      end if
    end if
    if trim(request.Form("LinkUrl"))="" then
      response.write ("<script language='javascript'>alert('请填写友情链接网址！');history.back(-1);</script>")
      response.end
    end if
    if Result="Add" then
	  sql="select * from ChinaQJ_FriendLink"
      rs.open sql,conn,1,3
      rs.addnew
  '多语言循环保存数据
set rsl = server.createobject("adodb.recordset")
sqll="select * from ChinaQJ_Language order by ChinaQJ_Language_Order"
rsl.open sqll,conn,1,1
while(not rsl.eof)
  rs("LinkName"&rsl("ChinaQJ_Language_File"))=trim(Request.Form("LinkName"&rsl("ChinaQJ_Language_File")))
  if Request.Form("ViewFlag"&rsl("ChinaQJ_Language_File"))=1 then
	rs("ViewFlag"&rsl("ChinaQJ_Language_File"))=Request.Form("ViewFlag"&rsl("ChinaQJ_Language_File"))
  else
	rs("ViewFlag"&rsl("ChinaQJ_Language_File"))=0
  end if
  rs("LinkFace"&rsl("ChinaQJ_Language_File"))=trim(Request.Form("LinkFace"&rsl("ChinaQJ_Language_File")))
rsl.movenext
wend
rsl.close
set rsl=nothing
      rs("LinkUrl")=trim(Request.Form("LinkUrl"))
	  if Request.Form("LinkType")=1 then
        rs("LinkType")=Request.Form("LinkType")
	  else
        rs("LinkType")=0
	  end if
	  rs("Remark")=trim(Request.Form("Remark"))
	  rs("AddTime")=now()
	end if
	if Result="Modify" then
      sql="select * from ChinaQJ_FriendLink where ID="&ID
      rs.open sql,conn,1,3
  '多语言循环保存数据
set rsl = server.createobject("adodb.recordset")
sqll="select * from ChinaQJ_Language order by ChinaQJ_Language_Order"
rsl.open sqll,conn,1,1
while(not rsl.eof)
  rs("LinkName"&rsl("ChinaQJ_Language_File"))=trim(Request.Form("LinkName"&rsl("ChinaQJ_Language_File")))
  if Request.Form("ViewFlag"&rsl("ChinaQJ_Language_File"))=1 then
	rs("ViewFlag"&rsl("ChinaQJ_Language_File"))=Request.Form("ViewFlag"&rsl("ChinaQJ_Language_File"))
  else
	rs("ViewFlag"&rsl("ChinaQJ_Language_File"))=0
  end if
  rs("LinkFace"&rsl("ChinaQJ_Language_File"))=trim(Request.Form("LinkFace"&rsl("ChinaQJ_Language_File")))
rsl.movenext
wend
rsl.close
set rsl=nothing
      rs("LinkUrl")=trim(Request.Form("LinkUrl"))
	  if Request.Form("LinkType")=1 then
        rs("LinkType")=Request.Form("LinkType")
	  else
        rs("LinkType")=0
	  end if
	  rs("Remark")=trim(Request.Form("Remark"))
	end if
	rs.update
	rs.close
    set rs=nothing
    response.write "<script language='javascript'>alert('设置成功！');location.replace('FriendLinkList.asp');</script>"
  else
	if Result="Modify" then
      set rs = server.createobject("adodb.recordset")
      sql="select * from ChinaQJ_FriendLink where ID="& ID
      rs.open sql,conn,1,1
  '多语言循环拾取数据
set rsl = server.createobject("adodb.recordset")
sqll="select * from ChinaQJ_Language order by ChinaQJ_Language_Order"
rsl.open sqll,conn,1,1
while(not rsl.eof)
  Lanl=rsl("ChinaQJ_Language_File")
  LinkName=rs("LinkName"&Lanl)
  ViewFlag=rs("ViewFlag"&Lanl)
  LinkFace=rs("LinkFace"&Lanl)
  execute("LinkName"&Lanl&"=LinkName")
  execute("ViewFlag"&Lanl&"=ViewFlag")
  execute("LinkFace"&Lanl&"=LinkFace")
rsl.movenext
wend
rsl.close
set rsl=nothing
	  LinkType=rs("LinkType")
      LinkUrl=rs("LinkUrl")
      Remark=rs("Remark")
	  rs.close
      set rs=nothing
	end if
  end if
end sub
%>