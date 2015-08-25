<!--#include file="../Include/Const.Asp" -->
<!--#include file="../Include/NoSQL.Asp" -->
<!--#include file="../Include/ConnSiteData.Asp" -->
<!--#include file="Function.Asp" -->
<%
On Error Resume Next	'-----------Error

Call SiteInfo
If ISHTML = 1 Then
Response.expires = 0
Response.expiresabsolute = Now() - 1
Response.addHeader "pragma", "no-cache"
Response.addHeader "cache-control", "private"
Response.CacheControl = "no-cache"
End If
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="shortcut icon" href="favicon.ico"/>
<title><% =SiteTitle %></title>
<meta name="keywords" content="<% =Keywords %>" />
<meta name="description" content="<% =Descriptions %>" />
<!--#include file="Page_CSS.asp" -->
<script type="text/javascript" src="<%= SysRootDir %>Scripts/Flash.js"></script>
<script language="javascript" src="<%= SysRootDir %>Scripts/Admin.js"></script>

<script type="text/javascript" src="<%=StylePath%>js/jquery.v1.4.2.js"></script>
<script type="text/javascript" src="<%=StylePath%>js/jquery.cycle.all.min.js"></script>
<script type="text/javascript" src="<%=StylePath%>js/custom.js"></script>
<script type='text/javascript' src='<%=StylePath%>js/dd_belated_png.js'></script>
<script type='text/javascript' src='<%=StylePath%>js/htmljs1.js'></script>
<script type='text/javascript' src='<%=StylePath%>js/browser.js'></script>
<!--[if IE 6]> <script>DD_belatedPNG.fix('.ie6fix');</script> <![endif]-->

<script language="JavaScript">
<!--
function killErrors() {
    return true;
}
window.onerror = killErrors;
//-->
</script>
</head>
<% menuname="首页" %>
<!--#include file="page_Header.asp" -->
<!--#include file="Page_Index.asp" -->
<!--#include file="Page_footer.asp" -->
<%= ChinaQJIndexNotice() %>
<% If JMailDisplay="1" Then %>
<% if MessageSkin="1" then %>
<script type="text/javascript" src="../scripts/Message.js?SkinA=default&SkinB=Black" charset="gb2312"></script>
<% elseif MessageSkin="2" then %>
<script type="text/javascript" src="../scripts/Message.js?SkinA=default&SkinB=Blue" charset="gb2312"></script>
<% elseif MessageSkin="3" then %>
<script type="text/javascript" src="../scripts/Message.js?SkinA=default&SkinB=Gray" charset="gb2312"></script>
<% elseif MessageSkin="4" then %>
<script type="text/javascript" src="../scripts/Message.js?SkinA=default&SkinB=red" charset="gb2312"></script>
<% elseif MessageSkin="5" then %>
<script type="text/javascript" src="../scripts/Message.js?SkinA=honey&SkinB=Green" charset="gb2312"></script>
<% elseif MessageSkin="6" then %>
<script type="text/javascript" src="../scripts/Message.js?SkinA=honey&SkinB=Blue" charset="gb2312"></script>
<% elseif MessageSkin="7" then %>
<script type="text/javascript" src="../scripts/Message.js?SkinA=honey&SkinB=Gray" charset="gb2312"></script>
<% elseif MessageSkin="8" then %>
<script type="text/javascript" src="../scripts/Message.js?SkinA=honey&SkinB=Red" charset="gb2312"></script>
<% End If %>
<% End If %>
<% If QQKeFu="1" Then %>
<script type="text/javascript">kfguin="<%= QQKeFuH %>";ws="<%=SiteUrl%>"; companyname="<%= QQKeFuCompany %>"; welcomeword="<%= QQKeFuDemo %>"; type="1";</script> <script type="text/javascript" src="../Scripts/kf.js"></script>
<% End If %>
<% If SysKefuSwitch="1" Then %>
<link rel="stylesheet" rev="stylesheet" href="<%= SysRootDir %>Scripts/Kefu/<%= SysKefuSkin %>/default.css" type="text/css" />
<%
if SysKefuFloat=1 then
ChinaQJKefuFloat="right"
else
ChinaQJKefuFloat="left"
end if
%>
<div id="kefu_pannel" style="<%= ChinaQJKefuFloat %>: 0px; top: 130px; z-index: 30000; position: absolute; Filter: alpha(opacity=<%= SysKefuAlpla %>);">
  <table border="0" cellpadding="0" cellspacing="0">
    <thead id="kefu_pannel_top">
      <tr>
        <th class="kefu_Title"><span class="kefu_shut" id="kefu_ctrl" onClick="HideKefu()"></span>
          <h2 class="txtCut">在线客服</h2></th>
      </tr>
    </thead>
    <tbody id="kefu_pannel_mid">
      <tr>
        <td height="3"></td>
      </tr>
      <tr>
        <td>
<%
sql="select * from ChinaQJ_Kefu where ViewFlag"&Language&" order by id"
set rs=server.createobject("adodb.recordset")
rs.open sql,conn,0,1
if rs.eof and rs.bof then
Response.Write("无客服列表")
else
while(not rs.eof)
%>
        <div class="kefu_box" onMouseOver="this.className='kefu_boxOver'" onMouseOut="this.className='kefu_box'">
        <span class="kefu_image">
        <img src="<%= SysRootDir %>Scripts/Kefu/gray/icon_person_stat_online.gif "/></span><span class="kefu_person"><%= rs("KefuName"&Language) %></span> <a href="tencent://message/?uin=<%= rs("KefuQQ") %>&Menu=yes" class="kefu_Type_qq"><img src="<%= SysRootDir %>Scripts/Kefu/gray/icon_person_qq.gif"></a> <a href="msnim:chat?contact=<%= rs("KefuMSN") %>" class="kefu_Type_msn"><img src="<%= SysRootDir %>Scripts/Kefu/gray/icon_person_msn.gif"></a> <a href="skype:<%= rs("KefuSkype") %>?call" class="kefu_Type_skype"><img src="<%= SysRootDir %>Scripts/Kefu/gray/icon_person_skype.gif"></a>
        </div>
<%
rs.movenext
wend
end if
rs.close
set rs=nothing
%>
       </td>
      </tr>
      <tr>
        <td height="3"></td>
      </tr>
    </tbody>
    <tfoot id="kefu_pannel_btm">
      <tr onClick="parent.location='<%= SysRootDir %><%= Language %>/Company.Asp';" style="cursor: hand;">
        <td class="kefu_other"></td>
      </tr>
  </table>
</div>
<script language="JavaScript" src="<%= SysRootDir %>Scripts/ChinaQJKeFu.js"></script>
<% End If %>
</body>
</html>
<%
	LogPageError("首页")			'--log error
%>