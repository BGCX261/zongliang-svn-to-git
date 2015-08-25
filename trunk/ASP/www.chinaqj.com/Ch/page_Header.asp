<body>
<table width="980" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
      <td height="68">
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="250"><a href="index.asp"><img src="<%=StylePath%>logo.png" border="0"  title="<%= ChinaQJLanguageTxt6 %>"></a></td>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td>&nbsp;</td>
        <td width="220" height="30" style="color:#000000;"><%= ChinaQJLanguageTxt312 %>：
          <%For LangT = 0 To TotalLang%>
          <a href="<%=SysRootDir&Language_File(LangT)%>"><img src="<%= Language_Ico(LangT) %>" align="absmiddle" height="18" border="0" title="<%=Language_FrontName(LangT)%>"></a>   
          <%Next%>
        </td>
      </tr>
      <tr>
        <td><marquee width="95%" direction="left" behavior="scroll" scrollamount="5"><font class="whitext"><%= ChinaQJIndexNewskin02() %></font></marquee></td>
        <td height="30" style="color:#000000;"><%= ChinaQJLanguageTxt27 %>： <a href="company.asp"><font style="color:#000000;"><%= telephone2 %></font></a></td>
      </tr>
</table></td>
  </tr>
        </table>
      </td>
  </tr>
</table>

<table width="980" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td height="53"><div id="mainMenu"> <%= ChinaQJHeadNavigation %> </div></td>
      </tr>
</table>

<% If menuname="首页" Then %>
<table width="980" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td style="padding-bottom:5px;"><% Call ChinaQJSlide() %></td>
  </tr>
</table>
<% Else %>
<table width="980" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td class="bannerbg" valign="top"><%Call ChinaQJSlide2(948,250)%></td>
  </tr>
</table>
<% End If %>