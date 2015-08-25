<!--#include file="../Include/Const.asp" -->
<!--#include file="../Include/ConnSiteData.asp" -->
<!--#include file="CheckAdmin.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="Images/Admin_style.css">
<script language="javascript" src="../Scripts/Admin.js"></script>
<%
if Instr(session("AdminPurview"),"|25,")=0 then
  response.write ("<br /><br /><div align=""center""><font style=""color:red; font-size:9pt; "")>您没有管理该模块的权限！</font></div>")
  response.end
end if
dim Result
Result=request.QueryString("Result")
dim ReplyContent,ReplyTime,ID,OrderName,Remark
dim mLinkman,mCompany,mAddress,mZipCode,mTelephone,mFax,mMobile,mEmail,mAddTime
ID=request.QueryString("ID")
call OrderEdit()
%>
<br />
<table class="tableBorder" width="95%" border="0" align="center" cellpadding="5" cellspacing="1">
  <form name="editForm" method="post" action="OrderEdit.asp?Action=SaveEdit&Result=<%=Result%>&ID=<%=ID%>">
    <tr>
      <th height="22" colspan="2" sytle="line-height:150%">【<%If Result = "Add" then%>添加<%ElseIf Result = "Modify" then%>修改<%End If%>订单】</th>
    </tr>
    <tr>
      <td width="20%" align="right" class="forumRow">订单标题：</td>
      <td width="80%" class="forumRowHighlight"><input name="OrderName" type="text" id="OrderName" style="width: 280" value="<%=OrderName%>" readonly></td>
    </tr>
    <tr>
      <td align="right" class="forumRow">简短说明：</td>
      <td class="forumRowHighlight"><textarea name="Remark" rows="8" id="Remark" style="width: 500"><%=Remark%></textarea></td>
    </tr>
    <tr>
      <td align="right" class="forumRow">订购人：</td>
      <td class="forumRowHighlight"><%=mLinkman%></td>
    </tr>
	<tr>
      <td align="right" class="forumRow">单位名称：</td>
      <td class="forumRowHighlight"><input name="Company" type="text" style="width: 180" value="<%=mCompany%>" maxlength="180" readonly></td>
    </tr>
	<tr>
      <td align="right" class="forumRow">通信地址：</td>
      <td class="forumRowHighlight"><input name="Address" type="text" style="width: 500" value="<%=mAddress%>" maxlength="250" readonly></td>
    </tr>
	<tr>
      <td align="right" class="forumRow">邮政编码：</td>
      <td class="forumRowHighlight"><input name="ZipCode" type="text" style="width: 80" value="<%=mZipCode%>" maxlength="80" readonly></td>
    </tr>
	<tr>
      <td align="right" class="forumRow">联系电话：</td>
      <td class="forumRowHighlight"><input name="Telephone" type="text" style="width: 250" value="<%=mTelephone%>" maxlength="80" readonly></td>
    </tr>
	<tr>
      <td align="right" class="forumRow">传真号码：</td>
      <td class="forumRowHighlight"><input name="Fax" type="Fax" style="width: 250" value="<%=mFax%>" maxlength="80" readonly></td>
    </tr>
	<tr>
      <td align="right" class="forumRow">手机号码：</td>
      <td class="forumRowHighlight"><input name="Mobile" type="text" style="width: 250" value="<%=mMobile%>" maxlength="250" readonly></td>
    </tr>
	<tr>
      <td align="right" class="forumRow">电子信箱：</td>
      <td class="forumRowHighlight"><input name="Email" type="text" style="width: 250" value="<%=mEmail%>" maxlength="250" readonly></td>
    </tr>
	<tr>
      <td align="right" class="forumRow">订购时间：</td>
      <td class="forumRowHighlight"><input name="AddTime" type="text" style="width: 250" value="<%=mAddTime%>" maxlength="250" readonly></td>
    </tr>
	<tr>
      <td align="right" class="forumRow">回复时间：</td>
      <td class="forumRowHighlight"><input name="ReplyTime" type="text" style="width: 250" value="<%=ReplyTime%>" maxlength="250" readonly></td>
    </tr>
	<tr>
      <td align="right" class="forumRow">回复内容：</td>
      <td class="forumRowHighlight"><textarea name="ReplyContent" rows="8" id="ReplyContent" style="width: 500"><%=ReplyContent%></textarea></td>
    </tr>
    <tr>
      <td align="right" class="forumRow"></td>
      <td class="forumRowHighlight"><input name="submitSaveEdit" type="submit" id="submitSaveEdit" value="保存"> <input type="button" value="返回上一页" onclick="history.back(-1)"></td>
    </tr>
  </form>
</table>
<%
sub OrderEdit()
  dim Action,rsCheckAdd,rs,sql
  Action=request.QueryString("Action")
  if Action="SaveEdit" then
    set rs = server.createobject("adodb.recordset")
	if Result="Modify" then
    sql="select * from ChinaQJ_Order where ID="&ID
    rs.open sql,conn,1,3
	  rs("ReplyContent")=StrReplace(Request.Form("ReplyContent"))
	  if not (trim(request.Form("ReplyContent"))="" or trim(request.Form("ReplyTime"))<>"") then
	    rs("ReplyTime")=now()
    end if
	end if
	rs.update
	rs.close
    set rs=nothing
    response.write "<script language='javascript'>alert('编辑、回复订单信息成功！');location.replace('OrderList.asp');</script>"
  else
	if Result="Modify" then
      set rs = server.createobject("adodb.recordset")
      sql="select * from ChinaQJ_Order where ID="& ID
      rs.open sql,conn,1,1
	  OrderName=rs("OrderName")
	  Remark=ReStrReplace(rs("Remark"))
	  mLinkman=GuestInfo(rs("MemID"),rs("Linkman"),rs("Sex"))
	  mCompany=rs("Company")
	  mAddress=rs("Address")
	  mZipCode=rs("ZipCode")
	  mTelephone=rs("Telephone")
	  mFax=rs("Fax")
	  mMobile=rs("Mobile")
	  mEmail=rs("Email")
	  mAddTime=rs("AddTime")
	  ReplyContent=ReStrReplace(rs("ReplyContent"))
	  ReplyTime=rs("ReplyTime")
	  rs.close
      set rs=nothing
	end if
  end if
end sub

function GuestInfo(ID,Guest,Sex)
  Dim rs,sql
  Set rs=server.CreateObject("adodb.recordset")
  sql="Select * From ChinaQJ_Members where ID="&ID
  rs.open sql,conn,1,1
  if rs.bof and rs.eof then
    GuestInfo=Guest & "&nbsp;" & Sex
  else
    GuestInfo="<a href='MemEdit.asp?Result=Modify&ID="&ID&"'>"&Guest&"</a>"&Sex
  end if
  rs.close
  set rs=nothing
end function
%>