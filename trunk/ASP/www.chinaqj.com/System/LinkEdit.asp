<!--#include file="../Include/Const.asp" -->
<!--#include file="../Include/ConnSiteData.asp" -->
<!--#include file="CheckAdmin.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="Images/Admin_style.css">
<script language="javascript" src="../Scripts/Admin.js"></script>
<br />
<%
if Instr(session("AdminPurview"),"|37,")=0 then
  response.write "<center>您没有管理该模块的权限！</center>"
  response.end
end If
dim Result
Result=request.QueryString("Result")
dim ID,mText,mDescription,mLink,mOrder,mReplace,mTarget,mState
ID=request.QueryString("ID")
call LinkEdit()
%>
<table class="tableBorder" width="95%" border="0" align="center" cellpadding="5" cellspacing="1">
  <form name="editForm" method="post" action="LinkEdit.asp?Action=SaveEdit&Result=<%=Result%>&ID=<%=ID%>">
    <tr>
      <th height="22" colspan="2" sytle="line-height:150%">【<%If Result = "Add" then%>添加<%ElseIf Result = "Modify" then%>修改<%End If%>站内链接】</th>
    </tr>
    <tr>
      <td width="200" class="forumRow" align="right">链接文字：</td>
      <td class="forumRowHighlight"><input name="mText" type="text" id="mText" style="width: 300" value="<%=mText%>"> 需要替换的文本 <font color="red">*</font></td>
    </tr>
    <tr>
      <td class="forumRow" align="right">链接描述：</td>
      <td class="forumRowHighlight"><input name="mDescription" type="text" id="mDescription" style="width: 500" value="<%=mDescription%>"><br />
	  链接的描述内容，留空则使用链接文字，随机选择描述请用|分隔不同的描述。</td>
    </tr>
	<tr>
      <td class="forumRow" align="right">链接地址：</td>
      <td class="forumRowHighlight"><input name="mLink" type="text" id="mLink" style="width: 500" value="<%=mLink%>" maxlength="100"> 链接文字对应的链接地址 <font color="red">*</font></td>
    </tr>
    <tr>
      <td class="forumRow" align="right">优先级别：</td>
      <td class="forumRowHighlight"><input name="mOrder" type="text" id="mOrder" style="width: 300" value="<%If mOrder <> "" Then Response.Write ""&mOrder&"" Else Response.Write "1" End If%>"> 数字越大优先权越高 <font color="red">*</font></td>
    </tr>
    <tr>
      <td class="forumRow" align="right">替换次数：</td>
      <td class="forumRowHighlight"><input name="mReplace" type="text" id="mReplace" style="width: 300" value="<%If mReplace <> "" Then Response.Write ""&mReplace&"" Else Response.Write "1" End If%>"> 替换链接的次数(为0时则替换全部) <font color="red">*</font></td>
    </tr>
    <tr>
      <td class="forumRow" align="right">打开方式：</td>
      <td class="forumRowHighlight"><input <%If mTarget = 0 Then Response.Write "checked='checked'"%> name="mTarget" type="radio" value="0" />原窗口 <input <%If mTarget = "" Or mTarget = 1 Then Response.Write "checked='checked'"%> name="mTarget" type="radio" value="1" />新窗口 <font color="red">*</font></td>
    </tr>
    <tr>
      <td class="forumRow" align="right">状态：</td>
      <td class="forumRowHighlight"><input <%If mState = 0 Then Response.Write "checked='checked'"%> name="mState" type="radio" value="0" />禁用 <input <%If mState = "" Or mState = 1 Then Response.Write "checked='checked'"%> name="mState" type="radio" value="1" />启用 <font color="red">*</font></td>
    </tr>
    <tr>
      <td class="forumRow"></td>
      <td class="forumRowHighlight"><input name="submitSaveEdit" type="submit" id="submitSaveEdit" value="保存设置">
        <input type="button" value="返回上一页" onclick="history.back(-1)"></td>
    </tr>
  </form>
</table>
<br />
<%
sub LinkEdit()
  dim Action,rsCheckAdd,rs,sql
  Action=request.QueryString("Action")
  if Action="SaveEdit" then
    set rs = server.createobject("adodb.recordset")
    if len(trim(request.Form("mText")))<1 or len(trim(request.Form("mLink")))<1 or len(trim(request.Form("mOrder")))<1 or len(trim(request.Form("mReplace")))<1 then
      response.write ("<script language='javascript'>alert('请完整填写站内链接各项内容！');history.back(-1);</script>")
      response.end
    end if
    if Result="Add" then
	  sql="select * from ChinaQJ_Link"
      rs.open sql,conn,1,3
      rs.addnew
	  rs("Text")=trim(Request.Form("mText"))
	  rs("Description")=trim(Request.Form("mDescription"))
	  rs("Link")=trim(Request.Form("mLink"))
	  rs("Order")=trim(Request.Form("mOrder"))
	  rs("Replace")=trim(Request.Form("mReplace"))
	  rs("Target")=trim(Request.Form("mTarget"))
	  rs("State")=trim(Request.Form("mState"))
	end if
	if Result="Modify" then
      sql="select * from ChinaQJ_Link where ID="&ID
      rs.open sql,conn,1,3
	  rs("Text")=trim(Request.Form("mText"))
	  rs("Description")=trim(Request.Form("mDescription"))
	  rs("Link")=trim(Request.Form("mLink"))
	  rs("Order")=trim(Request.Form("mOrder"))
	  rs("Replace")=trim(Request.Form("mReplace"))
	  rs("Target")=trim(Request.Form("mTarget"))
	  rs("State")=trim(Request.Form("mState"))
	end if
	rs.update
	rs.close
    set rs=nothing
    response.write "<script language='javascript'>alert('设置成功！');location.replace('SetKey.asp');</script>"
  else
	if Result="Modify" then
      set rs = server.createobject("adodb.recordset")
      sql="select * from ChinaQJ_Link where ID="& ID
      rs.open sql,conn,1,1
	  mText=rs("Text")
	  mDescription=rs("Description")
	  mLink=rs("Link")
	  mOrder=rs("Order")
	  mReplace=rs("Replace")
	  mTarget=rs("Target")
	  mState=rs("State")
	  rs.close
      set rs=nothing
	end if
  end if
end sub
%>