<!--#include file="../Include/Const.asp" -->
<!--#include file="../Include/ConnSiteData.asp" -->
<!--#include file="CheckAdmin.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="Images/Admin_style.css">
<script language="javascript" src="../Scripts/Admin.js"></script>
<%
if Instr(session("AdminPurview"),"|23,")=0 then
  response.write ("<br /><br /><div align=""center""><font style=""color:red; font-size:9pt; "")>您没有管理该模块的权限！</font></div>")
  response.end
end if
dim Result
Result=request.QueryString("Result")
dim ReplyContent,ReplyTime,ID,MesName,Content,ViewFlagCh,SecretFlag
dim mLinkman,mCompany,mAddress,mZipCode,mTelephone,mFax,mMobile,mEmail,AddTime
ID=request.QueryString("ID")
call MesEdit()
%>
<br />
<table class="tableBorder" width="95%" border="0" align="center" cellpadding="5" cellspacing="1">
  <form name="editForm" method="post" action="MessageEdit.asp?Action=SaveEdit&Result=<%=Result%>&ID=<%=ID%>">
    <tr>
      <th height="22" colspan="2" sytle="line-height:150%">【审核、回复留言】</th>
    </tr>
    <tr>
      <td width="20%" align="right" class="forumRow">留言标题：</td>
      <td width="80%" class="forumRowHighlight"><input name="MesName" type="text" id="MesName" style="width: 280" value="<%=MesName%>" maxlength="250"> <font color="red">*</font></td>
    </tr>
    <tr>
      <td align="right" class="forumRow">留言内容：</td>
      <td class="forumRowHighlight"><textarea name="Content" rows="8" id="Content" style="width: 500"><%=Content%></textarea> <font color="red">*</font></td>
    </tr>
    <tr>
      <td align="right" class="forumRow">留言人：</td>
      <td class="forumRowHighlight"><%=mLinkman%></td>
    </tr>
	<tr>
      <td align="right" class="forumRow">单位名称：</td>
      <td class="forumRowHighlight"><input name="Company" type="text" style="width: 250" value="<%=mCompany%>" maxlength="250" readonly></td>
    </tr>
	<tr>
      <td align="right" class="forumRow">通信地址：</td>
      <td class="forumRowHighlight"><input name="Address" type="text" style="width: 250" value="<%=mAddress%>" maxlength="250" readonly></td>
    </tr>
	<tr>
      <td align="right" class="forumRow">邮政编码：</td>
      <td class="forumRowHighlight"><input name="ZipCode" type="text" style="width: 80" value="<%=mZipCode%>" maxlength="80" readonly></td>
    </tr>
	<tr>
      <td align="right" class="forumRow">联系电话：</td>
      <td class="forumRowHighlight"><input name="Telephone" type="text" style="width: 180" value="<%=mTelephone%>" maxlength="180" readonly></td>
    </tr>
	<tr>
      <td align="right" class="forumRow">传真号码：</td>
      <td class="forumRowHighlight"><input name="Fax" type="text" style="width: 180" value="<%=mFax%>" maxlength="180" readonly></td>
    </tr>
	<tr>
      <td align="right" class="forumRow">手机号码：</td>
      <td class="forumRowHighlight"><input name="Mobile" type="text" style="width: 180" value="<%=mMobile%>" maxlength="180" readonly></td>
    </tr>
	<tr>
      <td align="right" class="forumRow">电子信箱：</td>
      <td class="forumRowHighlight"><input name="Email" type="text" style="width: 180" value="<%=mEmail%>" maxlength="180" readonly></td>
    </tr>
	<tr>
      <td align="right" class="forumRow">当前状态：</td>
      <td class="forumRowHighlight"><input name="SecretFlag" type="checkbox" id="SecretFlag" value="1" <%if SecretFlag then response.write ("checked")%>> 悄悄话 
<% 
set rs = server.createobject("adodb.recordset")
sql="select * from ChinaQJ_Language order by ChinaQJ_Language_Order"
rs.open sql,conn,1,1
while(not rs.eof)
%>
<input name="ViewFlag<%=rs("ChinaQJ_Language_File")%>" type="checkbox" id="ViewFlag<%=rs("ChinaQJ_Language_File")%>" value="1" <%if eval("ViewFlag"&rs("ChinaQJ_Language_File")) then response.write ("checked")%>><%=rs("ChinaQJ_Language_Name")%>通过审核  
<% 
rs.movenext
wend
rs.close
set rs=nothing
%>
      </td>
    </tr>
	<tr>
      <td align="right" class="forumRow">留言时间：</td>
      <td class="forumRowHighlight"><input name="AddTime" type="text" style="width: 180" value="<%=AddTime%>" maxlength="180" readonly></td>
    </tr>
	<tr>
      <td align="right" class="forumRow">回复时间：</td>
      <td class="forumRowHighlight"><input name="ReplyTime" type="text" style="width: 180" value="<%=ReplyTime%>" maxlength="180" readonly></td>
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
sub MesEdit()
  dim Action,rsCheckAdd,rs,sql
  Action=request.QueryString("Action")
  if Action="SaveEdit" then
    set rs = server.createobject("adodb.recordset")
    if len(trim(request.Form("MesName")))<1 then
      response.write ("<script language='javascript'>alert('请填写留言标题！');history.back(-1);</script>")
      response.end
    end if
    if len(trim(request.Form("Content")))<1 then
      response.write ("<script language='javascript'>alert('请填写留言内容！');history.back(-1);</script>")
      response.end
    end if
	if Result="Modify" then
      sql="select * from ChinaQJ_Message where ID="&ID
      rs.open sql,conn,1,3
      rs("MesName")=trim(Request.Form("MesName"))
      rs("Content")= StrReplace(Request.Form("Content"))
  '多语言循环保存数据
set rsl = server.createobject("adodb.recordset")
sqll="select * from ChinaQJ_Language order by ChinaQJ_Language_Order"
rsl.open sqll,conn,1,1
while(not rsl.eof)
  if Request.Form("ViewFlag"&rsl("ChinaQJ_Language_File"))=1 then
	rs("ViewFlag"&rsl("ChinaQJ_Language_File"))=Request.Form("ViewFlag"&rsl("ChinaQJ_Language_File"))
  else
	rs("ViewFlag"&rsl("ChinaQJ_Language_File"))=0
  end if
rsl.movenext
wend
rsl.close
set rsl=nothing
	  if Request.Form("SecretFlag")=1 then
        rs("SecretFlag")=Request.Form("SecretFlag")
	  else
        rs("SecretFlag")=0
	  end if
	  rs("ReplyContent")=StrReplace(Request.Form("ReplyContent"))
	  if not (trim(request.Form("ReplyContent"))="" or trim(request.Form("ReplyTime"))<>"") then
	    rs("ReplyTime")=now()
    end if
	end if
	rs.update
	rs.close
    set rs=nothing
    response.write "<script language='javascript'>alert('审核、回复成功！');location.replace('MessageList.asp');</script>"
  else
	if Result="Modify" then
      set rs = server.createobject("adodb.recordset")
      sql="select * from ChinaQJ_Message where ID="& ID
      rs.open sql,conn,1,1
	  MesName=rs("MesName")
	  Content=ReStrReplace(rs("Content"))
	  mLinkman=GuestInfo(rs("MemID"),rs("Linkman"),rs("Sex"))
	  mCompany=rs("Company")
	  mAddress=rs("Address")
	  mZipCode=rs("ZipCode")
	  mTelephone=rs("Telephone")
	  mFax=rs("Fax")
	  mMobile=rs("Mobile")
	  mEmail=rs("Email")
  '多语言循环拾取数据
set rsl = server.createobject("adodb.recordset")
sqll="select * from ChinaQJ_Language order by ChinaQJ_Language_Order"
rsl.open sqll,conn,1,1
while(not rsl.eof)
  Lanl=rsl("ChinaQJ_Language_File")
  ViewFlag=rs("ViewFlag"&Lanl)
  execute("ViewFlag"&Lanl&"=ViewFlag")
rsl.movenext
wend
rsl.close
set rsl=nothing
	  SecretFlag=rs("SecretFlag")
	  AddTime=rs("AddTime")
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
    GuestInfo="<font color='green'>会员：</font><a href='MemEdit.asp?Result=Modify&ID="&ID&"'>"&Guest&"</a>"&Sex
  end if
  rs.close
  set rs=nothing
end function
%>