﻿<table width="980" border="0" cellspacing="0" cellpadding="0" align="center">
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
	<td class="contentcenter">
<%
		SortID=request.QueryString("SortID")
		TabName="ChinaQJ_Download"				'表名
'		WSql=""								'WHERE 条件(sql)
		If SortID="" Then 
			WSql="ViewFlagCh"				'WHERE 条件(sql)
		Else
			If IsNumeric(SortID) Then WSql="ViewFlagCh AND SortID = "&SortID End If 
		End If
		StrOrder=" ORDER BY AddTime DESC,ID DESC"			'排序
		PageShowCount=12					'每页显示数量
		PageId=request.QueryString("page")	'当前页数
		StrL=60								'文字长度(中文=两个字节)
		Language="Ch"						'语言
		Dim quAry 
			quAry = Array("SortID")

		'< % = BetaDownFunction(TbName,WSql,PageShowCount,PageId,StrW,Lan) % >

		Dim allInfo
		Set allInfo=BetaNewFunction(TabName,WSql,StrOrder,PageShowCount,PageId,Language)
		
		If allInfo.Count Then
%>
		<table border="0" cellspacing="0" cellpadding="0" width="100%">
		  <tbody>
<%
		For i=0 To allInfo.Count-1
			If ISHTML = 1 Then
				AutoLink = ""&allInfo(""&i&"")("ClassSeo")&""&Separated&""&allInfo(""&i&"")("ID")&"."&HTMLName
			Else
				AutoLink = "DownView.Asp?ID="&allInfo(""&i&"")("ID")
			End If
%>
			<tr height="28">
				<td style="background:url('<%=StylePath%>bg2.gif') repeat-x left bottom;">&nbsp;
					<img src="<%=StylePath%>arr.gif" align="absmiddle" />&nbsp;&nbsp;
					<a href="<%=AutoLink%>" title="<%=allInfo(""&i&"")("DownName"&Language)%>">
						<font color="<%=allInfo(""&i&"")("TitleColor")%>"><%=StrLeft(allInfo(""&i&"")("DownName"&Language),StrL)%></font></a>
				</td>
				<td style="background:url('<%=StylePath%>bg2.gif') repeat-x left bottom;">&nbsp;&nbsp;&nbsp;<%=allInfo(""&i&"")("FileSize")%></td>
				<td align="center" style="background:url('<%=StylePath%>bg2.gif') repeat-x left bottom; color:#999999">&nbsp;&nbsp;&nbsp;
					<%=FormatDate(allInfo(""&i&"")("UpdateTime"),13)%>
				</td>
			</tr>
<%
		Next
%>
			</tbody>
		</table>		
	<!--		Page		-->
    <%=GetShowPageInfo(TabName,WSql,PageId,PageShowCount,6,"个下载资源",quAry)%>
  	<!--		Page		-->
<%	Else %>
	<div align="center">^_^ 对不起,没有找到相关资源</div>
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