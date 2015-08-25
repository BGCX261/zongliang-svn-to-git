<table width="980" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td valign="top" width="235">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td class="leftnavtop"><%= ChinaQJLanguageTxt240 %></td>
  </tr>
  <tr>
    <td class="leftnavcenter"><div class="SortBg"><%ChinaQJProductFolder(0)%></div></td>
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
    <td class="contentcenter"><div class="contentnav"><%=ChinaQJProductWebLocation()%></div></td>
  </tr>
  <tr>
	<td class="contentcenter">

<%
	If pInfo.Count Then
%>
		<div>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
				<tbody>
					<tr>
						<td>
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tbody>
									<tr>
										<td width="30" height="36"><img src="<%=StylePath%>title_bg1.gif" width="30" height="36"></td>
										<td width="100%" align="center" background="<%=StylePath%>title_bg_center.jpg" style="color:#000000; font-size:14px; font-weight:bold">
											<%=pInfo("0")("ProductName"&Language)%>
										</td>
										<td width="30"><img src="<%=StylePath%>title_bg2.gif" width="30" height="36"></td>
									</tr>
									<tr>
										<td><img src="<%=StylePath%>title_bg3.gif" width="30" height="14"></td>
										<td background="<%=StylePath%>title_bg_center2.jpg">&nbsp;</td>
										<td><img src="<%=StylePath%>title_bg4.gif" width="30" height="14"></td>
									</tr>
								</tbody>
							</table>
						</td>
					</tr>
					<tr>
						<td>
							<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
								<tbody>
									<tr>
										<td style="line-height:200%; padding-top:10px;">产品名称：<%=pInfo("0")("ProductName"&Language)%><br>
										产品编号：<%=pInfo("0")("ProductNo")%><br>
										更新时间：<%=FormatDate(pInfo("0")("UpdateTime"),13)%><br />
<%
								attribute1=pInfo("0")("ProName"&Language)
								attribute1_value=pInfo("0")("ProInfo"&Language)
								If attribute1 <> "" And attribute1_value <> "" Then
									attribute1_1=Split(attribute1,"§§§")
									attribute1_value_1=Split(attribute1_value,"§§§")
									For i=0 To ubound(attribute1_value_1)
%>
										<%=attribute1_1(i)%>：<%=attribute1_value_1(i)%><br />
<%
									Next
								End If
%>
										分享次数：<script language="javascript" src="HitCount.Asp?id=<%=pInfo("0")("ID")%>&LX=ChinaQJ_Products"></script>
										<script language="javascript" src="HitCount.Asp?action=count&LX=ChinaQJ_Products&id=<%=pInfo("0")("ID")%>"></script><br>
										<strong style="color:red">更多产品图片：</strong><br>
										<a href="<%=pInfo("0")("BigPic")%>" title="<%=pInfo("0")("ProductName"&Language)%>" rel="clearbox[gallery=Green,,title=<%=pInfo("0")("ProductName"&Language)%>,,comment=<%=pInfo("0")("ProductName"&Language)%>]" target="_blank"><img onMouseOver="document.rImage.src='<%=pInfo("0")("BigPic")%>'; pid='<%=pInfo("0")("BigPic")%>'" src="<%=pInfo("0")("BigPic")%>" onload="javascript:DrawImage(this,110,110);" style="border:1px solid #ccc; margin-left:5px; margin-right:5px; margin-top:5px"></a>
<%
								If Len(pInfo("0")("OtherPic")) > 0 Then
									OtherPic=Split(pInfo("0")("OtherPic"),"*")
									For imgi = 0 to ubound(OtherPic)-1
%>
										<a href="<%=trim(OtherPic(imgi))%>" title="<%=pInfo("0")("ProductName"&Language)%>" rel="clearbox[gallery=Green,,title=<%=pInfo("0")("ProductName"&Language)%>,,comment=<%=pInfo("0")("ProductName"&Language)%>]" target="_blank"><img onMouseOver="document.rImage.src='<%=trim(OtherPic(imgi))%>'; pid='<%=trim(OtherPic(imgi))%>'" src="<%=trim(OtherPic(imgi))%>" onload="javascript:DrawImage(this,110,110);" style="border:1px solid #ccc; margin-left:5px; margin-right:5px; margin-top:5px"></a>
<%
									Next
								End If
%>
										<br>
									</td>
									<td style="width:280px; text-align:center; padding-top:10px;">
										<a href="<%=pInfo("0")("BigPic")%>" rel="clearbox[gallery=Green,,title=<%=pInfo("0")("ProductName"&Language)%>,,comment=<%=pInfo("0")("ProductName"&Language)%>]" target="_blank">
											<img src="<%=HtmlSmallPic(pInfo("0")("GroupID"),pInfo("0")("BigPic"),pInfo("0")("Exclusive"))%>" title="<%=pInfo("0")("ProductName"&Language)%>" style="padding: 3px; border: 1px solid #ccc" onload="javascript:DrawImage(this,280,280);" name="rImage" border="0" width="280" height="210"></a>
										<br><br>
										<a href="ProductBuy.Asp?ProductNo=<%=pInfo("0")("ProductNo")%>" title="立即订购：<%=pInfo("0")("ProductName"&Language)%>">
											<img src="<%=StylePath&"buy_"&Language&".gif"%>" border="0"></a>
										<br><br>
<%
								If Len(pInfo("0")("TheTags"&Language)) > 0 Then
									TheTags=Split(pInfo("0")("TheTags"&Language),",")
%>
										<div style="height:25px;" align="center">
											<font color="#005AA0">产品标签: </font>
<%
									For ti = 0 to ubound(TheTags)-1

%>
											<a href="Search.Asp?Range=Product&Keyword=<%=TheTags(ti)%>"><font color="#CC3C3C"><u><%=TheTags(ti)%></u></font></a>
<%
									Next
%>
										</div>
<%
								End If
%>
										</td>
									</tr>
								</tbody>
							</table>
						</td>
					</tr>
					<tr><td height="18">&nbsp;</td></tr>
					<tr><td><a href="javascript:showCon('1');" class="paA" id="m1"><font color="#ffffff">产品概述</font></a></td></tr>
					<tr>
						<td align="left" style="padding: 12px; background: url(<%=StylePath%>bg2.jpg) repeat-x;">
							<div id="con1" style="line-height: 24px; display: block; "><%=ProcessSitelink(pInfo("0")("Content"&Language))%></div>
							<table border="0" cellpadding="0" cellspacing="0" id="con1" style="display: none;"></table>
							<script type="text/javascript">showCon('1');</script>
						</td>
					</tr>
					<tr><td height="15" style="background: url(<%=StylePath%>bg3.gif) repeat-x left center;">&nbsp;</td></tr>
					<tr><td height="18">&nbsp;</td></tr>
					<tr>
						<td height="18">
							<!-- JiaThis Button BEGIN -->
							<div id="ckepop">
								<span class="jiathis_txt">分享到：</span>
								<a class="jiathis_button_qzone" title="分享到QQ空间"><span class="jiathis_txt jiathis_separator jtico jtico_qzone">QQ空间</span></a>
								<a class="jiathis_button_tsina" title="分享到新浪微博"><span class="jiathis_txt jiathis_separator jtico jtico_tsina">新浪微博</span></a>
								<a class="jiathis_button_tqq" title="分享到腾讯微博"><span class="jiathis_txt jiathis_separator jtico jtico_tqq">腾讯微博</span></a>
								<a class="jiathis_button_t163" title="分享到网易微博"><span class="jiathis_txt jiathis_separator jtico jtico_t163">网易微博</span></a>
								<a href="http://www.jiathis.com/share" class="jiathis jiathis_txt jiathis_separator jtico jtico_jiathis" target="_blank" style="">更多</a>
							</div>
							<script type="text/javascript" src="http://v2.jiathis.com/code/jia.js" charset="utf-8"></script>
							<!-- JiaThis Button END -->
						</td>
					</tr>
<%
					Dim mPrevious,mNext
					Set mPrevious=BetaNewInfoFunction(TabName,"<",Id,Language," ORDER BY ID DESC")
					Set mNext=BetaNewInfoFunction(TabName,">",Id,Language,"")
%>
					<tr><td height="25">上一篇: 
<%
					If mPrevious.Count Then
						If ISHTML = 1 Then
							AutoLink = mPrevious("0")("ClassSeo")&Separated&mPrevious("0")("ID")&"."&HTMLName
						Else
							AutoLink = "ProductView.Asp?ID="&mPrevious("0")("ID")
						End If
%>
							<a href="<%=AutoLink%>" title="<%=mPrevious("0")("ProductName"&Language)%>">
								<font color="<%=mPrevious("0")("TitleColor")%>"><%=mPrevious("0")("ProductName"&Language)%></font>
							</a>
<%
					Else
%>
							<font color="#ccc">没有了.</font>
<%
					End If
%>
						</td>
					</tr>
					<tr><td height="25">下一篇: 
<%
					If mNext.Count Then
						If ISHTML = 1 Then
							AutoLink = mNext("0")("ClassSeo")&Separated&mNext("0")("ID")&"."&HTMLName
						Else
							AutoLink = "ProductView.Asp?ID="&mNext("0")("ID")
						End If
%>
							<a href="<%=AutoLink%>" title="<%=mNext("0")("ProductName"&Language)%>">
								<font color="<%=mNext("0")("TitleColor")%>"><%=mNext("0")("ProductName"&Language)%></font>
							</a>
<%
					Else
%>
							<font color="#ccc">没有了.</font>
<%
					End If
%>
						</td>
					</tr>
					<tr>
						<td height="20">&nbsp;</td>
					</tr>
				</tbody>
			</table>
		</div>
<%
	Else
%>
		<div align="center">对不起,没有找到该产品,可能已经被删除</div>	
<%
	End If
%>
	</td>
  </tr>
  <tr>
    <td class="contentbottom"></td>
  </tr>
</table>

    </td>
  </tr>
</table>