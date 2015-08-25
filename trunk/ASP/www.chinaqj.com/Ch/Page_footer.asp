<% If menuname="首页" Then %>
<table width="980" border="0" align="center" cellpadding="0" cellspacing="0" style="border:1px #ccc solid; margin-top:10px;">
  <tr>
    <td style="padding:8px; background-color:#ccc; color:#333; font-weight:bold; width:15px;"><%= ChinaQJLanguageTxt293 %></td>
    <td width="8" style="background-color:#fff;"><img src="<%= stylepath %>linkpic1.gif" /></td>
    <td style="background-color:#fff; padding:8px;"><%= ChinaQJIndexFriendLinks(3,7) %></td>
  </tr>
</table>
<% End If %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#c3cbce" style="border-top:2px solid #bbc6c8; margin-top:10px;">
<tr>
          <td height="25" align="center" style="padding-top:10px;"><%=ChinaQJHeadNavigationfoot()%></td>
        </tr>
        <tr>
          <td height="25" align="center" style="line-height:25px; padding-bottom:10px;"><%=ChinaQJLanguageTxt4%>：<a href="http://<%= siteurl %>" title="<%=ChinaQJLanguageTxt5%>" target="_blank"><%=ChinaQJLanguageTxt6%></a> Copyright 2007 - <%=Year(Now())%> <a href="http://<%=SiteUrl%>" title="<%=SiteTitle%>" target="_blank"><%=SiteUrl%></a> All rights reserved.&nbsp;&nbsp;<%= ChinaQJ_Stat %><br /><%= IcpNumber %></td>
  </tr>
</table>