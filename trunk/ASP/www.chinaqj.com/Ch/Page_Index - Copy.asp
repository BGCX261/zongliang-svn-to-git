<table width="980" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="235" valign="top">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td class="leftnavtop2"><%= telephone %></td>
  </tr>
  <tr>
    <td class="leftnavcenter"><table width="85%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td class="leftcontact leftcontacttop">
            <%= comname %><br />
			<%= ChinaQJLanguageTxt100 %>: <%= address %><br />
			<%= ChinaQJLanguageTxt27 %>: <%= telephone %><br />
			<%= ChinaQJLanguageTxt35 %>: <%= Fax %><br />
			<%= ChinaQJLanguageTxt26 %>: <%= telephone2 %><br />
			<%= ChinaQJLanguageTxt101 %>: <%= email %><br />
			<%= ChinaQJLanguageTxt102 %>: <%= siteurl %>
            </td>
          </tr>
        </table></td>
  </tr>
  <tr>
    <td class="leftnavbottom2"></td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td class="lefttitle"><%= ChinaQJLanguageTxt291 %></td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF"><div id="quick"><%=ChinaQJProductIndexFolder(0)%></div></td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:5px;">
  <tr>
    <td class="lefttitle"><%= ChinaQJLanguageTxt303 %></td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF"><%=ChinaQJIndexSelPlay(Video,235,180)%></td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
  <tr>
    <td class="loginbox" style="background-image:url(<%= stylepath %>loginbg_<%= Language %>.png);" width="235"><script type="text/javascript" language="javascript" src="<%=SysRootDir & Language & "/"%>Login.Asp" charset="utf-8" />
          </script></td>
  </tr>
</table>
</td>
    <td valign="top" style="padding:0px 5px;"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td class="centertitle">
		<div style="float:left;"><%= ChinaQJLanguageTxt15 %></div>
		<div style="float:right; font-size:12px; font-weight:normal;"><a href="Introduction-1.html"><%= ChinaQJLanguageTxt30 %></a></div>
        </td>
      </tr>
      <tr>
        <td style="background-color:#FFF; border:1px #ccc solid; padding:8px; line-height:20px; font-weight:bold; height:145px; overflow:hidden;"><%= sitedetail %></td>
      </tr>
    </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:5px;">
        <tr>
          <td class="centertitle"><div style="float:left;"><%= ChinaQJLanguageTxt297 %></div>
            <div style="float:right; font-size:12px; font-weight:normal;"><a href="New.html"><%= ChinaQJLanguageTxt30 %></a></div></td>
        </tr>
        <tr>
          <td style="background-color:#FFF; border:1px #ccc solid; padding:8px; line-height:20px;"><%=ChinaQJIndexNews("0,",6,42)%></td>
        </tr>
    </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:5px;">
        <tr>
          <td class="centertitle"><div style="float:left;"><%= ChinaQJLanguageTxt295 %></div>
            <div style="float:right; font-size:12px; font-weight:normal;"><a href="Product.html"><%= ChinaQJLanguageTxt30 %></a></div></td>
        </tr>
        <tr>
          <td style="background-color:#FFF; border:1px #ccc solid; padding:8px; line-height:20px;"><%=ChinaQJIndexProducts("0,",3,3,144,106,20)%></td>
        </tr>
    </table></td>
    <td width="235" valign="top">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td class="leftnavtop"><%= ChinaQJLanguageTxt38 %></td>
  </tr>
  <tr>
    <td class="leftnavcenter"><form id="Search" name="Search" method="get" action="Search.Asp">
          <table width="93%" border="0" align="center" cellpadding="0" cellspacing="0" style="background:url(<%=StylePath%>bg_sear.gif) no-repeat 2px 24px;">
            <tr>
              <td height="28"><input name="Range" type="radio" value="Product" class="inputnoborder" checked="checked" />
                <%=ChinaQJLanguageTxt8%>
                <input type="radio" name="Range" value="News" class="inputnoborder" />
                <%=ChinaQJLanguageTxt9%>
                <input type="radio" name="Range" value="Down" class="inputnoborder" />
                <%=ChinaQJLanguageTxt10%></td>
              </tr>
            <tr>
              <td height="28" style="padding-left: 60px"><input name="Keyword" type="text" id="Keyword" style="width:102px;" /></td>
              </tr>
            <tr>
              <td height="28" style="padding-left: 60px"><input type="image" name="imageField3" src="<%=StylePath%>btn_sear_<%=Language%>.gif" class="inputnoborder" /></td>
              </tr>
            <tr>
              <td height="28"><%=ChinaQJLanguageTxt264%>
                <%Call ChinaQJSearchCount(10,10,"")%></td>
              </tr>
            <tr>
              <td><img src="<%=StylePath%>t.gif" width="1" height="9" /></td>
              </tr>
            </table>
          </form></td>
  </tr>
  <tr>
    <td class="leftnavbottom1"></td>
  </tr>
  <tr>
    <td class="leftnavcenter"><div id="quick">
                    <%Call ChinaQJEMailSubscriptions()%>
          </div></td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:5px;">
  <tr>
    <td class="lefttitle"><%= ChinaQJLanguageTxt301 %></td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF" style="padding:8px;"><%=ChinaQJIndexImage("0,",3,3,68,68)%></td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:5px;">
  <tr>
    <td class="lefttitle"><%= ChinaQJLanguageTxt144 %></td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF" style="line-height:25px; padding:6px 8px;"><%=ChinaQJOthers("0",8,26)%></td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF" style="text-align:right; padding:0px 8px 8px 8px;"><a href="Info.html"><img src="<%=StylePath%>more3_c.gif" border="0" title="更多常见问题"></a></td>
  </tr>
</table>
    </td>
  </tr>
</table>