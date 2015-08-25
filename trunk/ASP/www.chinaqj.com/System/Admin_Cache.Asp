<%
Response.Buffer = True 
Response.ExpiresAbsolute = Now() - 1 
Response.Expires = 0 
Response.CacheControl = "no-cache" 
Response.AddHeader "Pragma", "No-Cache" 
%>

<HEAD>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="Images/Admin_style.css">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache"> 
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache"> 
<META HTTP-EQUIV="Expires" CONTENT="0"> 
</HEAD>
<br />
<table width="95%" border="0" align="center" cellpadding="5" cellspacing="1">
  <tr>
    <td><li>开始执行清理当前站点缓存…</li><li>当前站点全部缓存清理完成</li></td>
  </tr>
</table>
<br />