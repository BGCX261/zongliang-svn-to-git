<!--#include file="../Include/Const.Asp" -->
<!--#include file="../Include/ConnSiteData.Asp" -->
<!--#include file="Language.Asp" -->
document.write("                    <table width='100%' border='0' cellspacing='0' cellpadding='0'>");
document.write("                    <form id='formLogin' name='formLogin' method='post' action='<%= SysRootDir %><%= Language %>/MemberLogin.Asp'>");
document.write("                      <tr>");
document.write("                        <td colspan='3'><img src='<%=StylePath%>/t.gif' width='1' height='10' /></td>");
document.write("                      </tr>");
<%if session("MemName")="" or session("GroupID")="" or session("MemLogin")<>"Succeed" then%>
document.write("                      <tr>");
document.write("                        <td width='68' rowspan='3' align='center' valign='top'><img src='<%=StylePath%>user_bg.gif' width='49' height='50' style='margin-top:5px;' /></td>");
document.write("                        <td width='58' height='28'><%=ChinaQJLanguageTxt11%>：</td>");
document.write("                        <td width='80' height='28'><input name='LoginName' type='text' id='LoginName' style='width:70px;' /></td>");
document.write("                      </tr>");
document.write("                      <tr>");
document.write("                        <td height='28'><%=ChinaQJLanguageTxt12%>：</td>");
document.write("                        <td height='28' colspan='2'><input name='LoginPassword' type='password' id='LoginPassword' style='width:70px;' /></td>");
document.write("                      </tr>");
document.write("                      <tr>");
document.write("                        <td height='28'></td>");
document.write("                        <td height='30' colspan='2'><input type='image' name='imageField' src='<%= StylePath %>btn_login_<%= Language %>.gif' style='border:0px none; background:none;' /></td>");
document.write("                      </tr>");
document.write("    <tr>");
document.write("        <td height='28' colspan='3' align='center'>● <a href='<%= SysRootDir %><%= Language %>/MemberRegister.Asp'><%= ChinaQJLanguageTxt13 %></a>&nbsp;&nbsp;&nbsp;&nbsp;● <a href='<%= SysRootDir %><%= Language %>/MemberGetPass.Asp'><%= ChinaQJLanguageTxt14 %></a></td>");
document.write("    </tr>");
<%Else%>
document.write("                      <tr>");
document.write("                        <td width='68' rowspan='3' align='center' valign='top'><img src='<%=StylePath%>user_bg.gif' width='49' height='50' style='margin-top:5px;' /></td>");
document.write("                        <td height='28' colspan='2'><%=ChinaQJLanguageTxt23%>：<%=session("MemName")%></td>");
document.write("                      </tr>");
document.write("                      <tr>");
document.write("                        <td height='28' colspan='3'><a href='MemberInfo.Asp'><%=ChinaQJLanguageTxt22%></a> <a href='ProductBuy.Asp'><%=ChinaQJLanguageTxt24%></a> <a href='MemberLogin.Asp?Action=Out'><%=ChinaQJLanguageTxt25%></a></td>");
document.write("                      </tr>");
document.write("                      <tr>");
document.write("                        <td height='28' colspan='3'></td>");
document.write("                      </tr>");
<%End If%>
document.write("                      </form>");
document.write("                    </table>");