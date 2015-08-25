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
    <td class="contentcenter"><div class="contentnav"><%=ChinaQJProductListWebLocation()%></div></td>
  </tr>
  <tr>
	<td class="contentcenter">
<%
		SortID=request.QueryString("SortID")
		TabName="ChinaQJ_Products"			'表名
'		WSql=""								'WHERE 条件(sql)
		If SortID="" Then 
			WSql="ViewFlagCh"				'WHERE 条件(sql)
		Else
			If IsNumeric(SortID) Then WSql="ViewFlagCh AND SortID = "&SortID End If 
		End If
		StrOrder=" ORDER BY CommendFlagCh,UpdateTime DESC,ID DESC"							'排序
		PageShowCount=12					'每页显示数量
		PageId=request.QueryString("page")	'当前页数
		ImgW=150							'图片宽
		ImgH=113							'图片高
		StrL=20								'文字长度(中文=两个字节)
		Language="Ch"						'语言
		Dim quAry 
			quAry = Array("SortID")
		
		Dim allPro
		Set allPro=BetaNewFunction(TabName,WSql,StrOrder,PageShowCount,PageId,Language)
		
		If allPro.Count Then
%>
	  <form action="ProductBuy.Asp" method="Post" name="Inquire" target="_blank">
		<table border="0" cellspacing="0" cellpadding="0" width="100%">
		  <tbody>
<%
			For i=0 To allPro.Count-1
				
				ProductName=allPro(""&i&"")("ProductName"&Language)
				ProductName_=StrLeft(ProductName,StrL)				
				SmallPicPath=HtmlSmallPic(allPro(""&i&"")("GroupID"),allPro(""&i&"")("SmallPic"),allPro(""&i&"")("Exclusive"))	' img
				If ISHTML = 1 Then
					AutoLink = ""&SysRootDir&Language&"/"&allPro(""&i&"")("ClassSeo")&""&Separated&""&allPro(""&i&"")("ID")&"."&HTMLName
				Else
					AutoLink = ""&SysRootDir&Language&"/ProductView.Asp?ID="&allPro(""&i&"")("ID")&""
				End If
				If i Mod 4=0 Then
%>
			<tr>
<%
				End If				
%>
			  <td align="center" valign="top">
			    <table width="150" border="0" cellspacing="0" cellpadding="0" style="margin-bottom: 22px">
				  <tbody>
				    <tr>
					  <td width="150" align="center">
					    <a href="<%=AutoLink%>" target="_blank" title="<%=ProductName%>"><img src="<%=SmallPicPath%>" width="<%=ImgW%>" height="<%=ImgH%>" border="0" style="padding: 3px; border: 1px solid #ccc" alt=""></a>
					  </td>
					</tr>
					<tr><td><img src="<%=StylePath%>t.gif" width="1" height="2"></td></tr>
					<tr><td bgcolor="#EFEFEF" style="padding:4px 7px 4px 7px;">
					  <table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tbody>
						  <tr>
							<td height="19" align="left">
							  <a href="<%=AutoLink%>" title="<%=ProductName%>"><font color=""><%=ProductName_%></font></a>
							</td>
						  </tr>
						  <tr>
							<td height="19" align="left">
							  Time：<span style="font-size: 11px"><%=FormatDate(allPro(""&i&"")("UpdateTime"),13)%></span>&nbsp;&nbsp;
							  <a href="<%=allPro(""&i&"")("BigPic")%>" title="点击查看大图" rel="clearbox[gallery=Green,,title='<%=ProductName%>',,comment='<%=ProductName%>']">
							  <img src="<%=StylePath%>zoom.gif" border="0" align="absmiddle" />
							  <img src="<%=allPro(""&i&"")("BigPic")%>" border="0" style="display:none" />
							  </a>
							</td>
						  </tr>
						</tbody>
					  </table>
					</td>
				  </tr>
				</tbody>
			  </table>
		  </td>
<%
			If (ic+1) Mod 4=0 Then
%>
		</tr>
<%
			End If
		Next
%>
		<tr>
		  <td height="50" align="center" colspan="6">
			<table width="100%" border="0" cellpadding="0" cellspacing="0" style="border:1px #ccc solid; margin-top:10px;">
			  <tbody>
				<tr>
				  <td style="padding:8px; background-color:#FFBA00; color:#333; font-weight:bold; width:15px;">友情提示</td>
				  <td width="8" style="background-color:#fff;"><img src="<%= stylepath %>linkpic.gif"></td>
				  <td style="background-color:#fff; padding:8px; color:#999" align="left">
					<li style='border-bootm:#666666 solid 1px;margin-top:5px;'>1.点击产品图片进入产品详细页面</li>
					<li style='border-bootm:#666666 solid 1px;margin-top:5px;'>2.点击产品右下方,点击放大图片</li>
					<li style='border-bootm:#666666 solid 1px;margin-top:5px;'>3.如有侵犯客户隐私信息,请联系我们反馈</li>
				  </td>
				</tr>
			  </tbody>
			</table>
			<!--<input type="image" src="<%=StylePath%>buy_Ch.gif" border="0" class="inputnoborder" />-->
		  </td>
		  </tr>
		</tbody>
	  </table>
	</form>
	  
	<!--		Page		-->
    <%=GetShowPageInfo(TabName,WSql,PageId,PageShowCount,6,"款产品",quAry)%>
  	<!--		Page		-->
<%	Else %>
	<div align="center">对不起,没有找到相关产品</div>
<%	End If %>
	</td>
  </tr>
  <tr>
    <td class="contentbottom"></td>
  </tr>
</table>

    </td>
  </tr>
</table>