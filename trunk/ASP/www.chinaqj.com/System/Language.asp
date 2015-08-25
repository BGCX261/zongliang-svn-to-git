<!--#include file="../Include/Const.asp" -->
<!--#include file="../Include/ConnSiteData.asp" -->
<!--#include file="CheckAdmin.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="Images/Admin_style.css">
<script language="javascript" src="../Scripts/Admin.js"></script>
<%
if Instr(session("AdminPurview"),"|41,")=0 then
  response.write "<center>您没有管理该模块的权限！</center>"
  response.end
end If
LanguageType=Request("LanguageType")
Action=Request("Action")
if LanguageType<>"" then
Incconststr = Server.Mappath(Sysrootdir & LanguageType & "/Language.Asp")
If Checkfile(Incconststr) Then
	Writestr = Readtext(Incconststr,"utf-8")
End If
end if

if Action="Save" then
Set objStream = Server.CreateObject("ADODB.Stream") 
With objStream 
.Open 
.Charset = "utf-8" 
.Position = objStream.Size
hf = ""&trim(request.Form("LanguageContent"))&""
.WriteText=hf 
.SaveToFile Server.mappath("../"&LanguageType&"/Language.asp"),2 
.Close 
End With 
Set objStream = Nothing
response.Write "<script language=javascript>alert('语言包设置成功！');location.href='Language.asp';</script>"
end if
%>
<br />
<table class="tableBorder" width="95%" border="0" align="center" cellpadding="5" cellspacing="1">
  <form name="editForm" method="post" action="Language.asp?Action=Save&LanguageType=<%= LanguageType %>">
    <tr>
      <th height="22" colspan="2" sytle="line-height:150%">【系统语言包】</th>
    </tr>
    <tr>
      <td class="centerRow">
<% 
set rs = server.createobject("adodb.recordset")
sql="select * from ChinaQJ_Language order by ChinaQJ_Language_Order"
rs.open sql,conn,1,1
while(not rs.eof)
%>
<a href="Language.asp?Action=<%= rs("ChinaQJ_Language_File") %>&LanguageType=<%= rs("ChinaQJ_Language_File") %>"><font style="color: red;"><u><%=rs("ChinaQJ_Language_Name")%></u></font></a>&nbsp;&nbsp;&nbsp;&nbsp;
<% 
rs.movenext
wend
rs.close
set rs=nothing
%>
      </td>
    </tr>
    <tr>
      <td class="centerRow">通过翻译系统内置语言包，您可以轻松将前台界面定义为任何语种。对语言包定义有任何疑问请联系<a href="http://www.ChinaQJ.com" target="_blank">官方客服</a>获取支持。</td>
    </tr>
<% if LanguageType<>"" then %>
    <tr>
      <td class="forumRow"><textarea name="LanguageContent" id="LanguageContent" rows="35" style="width: 100%;"><% = Writestr %></textarea></td>
    </tr>
    <tr>
      <td class="centerRow"><input name="submitSaveEdit" type="submit" id="submitSaveEdit" value="保存语言包定义"></td>
    </tr>
<% End If %>
  </form>
</table>
<table width="95%" border="0" align="center" cellpadding="5" cellspacing="1">
  <tr>
    <td><font color="#CC0000">提示：<br />如果您增加了新的系统语言，请在操作后转至 <a href="SelectTemplate.Asp" style="color: blue;"><u>前台模板应用设置</u></a> 发布您所选择的模板，以更新前台语言包、内核。</font></td>
  </tr>
</table>
<br />