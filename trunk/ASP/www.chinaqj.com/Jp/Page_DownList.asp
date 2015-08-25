<table width="980" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td valign="top" width="235">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td class="leftnavtop"><%= ChinaQJLanguageTxt52 %></td>
  </tr>
  <tr>
    <td class="leftnavcenter"><div class="SortBg"><%ChinaQJDownFolder(0)%></div></td>
  </tr>
  <tr>
    <td class="leftnavbottom1"></td>
  </tr>
  <tr>
    <td><!--#include file="Page_Left.asp" --></td>
  </tr>
</table>
    </td>
    <td>&nbsp;</td>
    <td valign="top" width="736">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td class="contenttop"></td>
  </tr>
  <tr>
    <td class="contentcenter"><div class="contentnav"><%=ChinaQJDownListWebLocation()%></div></td>
  </tr>
  <tr>
    <td class="contentcenter"><%=ChinaQJDownListWebContent("ChinaQJ_DownSort",request.QueryString("SortID"),"")%></td>
  </tr>
  <tr>
    <td class="contentbottom"></td>
  </tr>
</table>

    </td>
  </tr>
</table>