<table width="980" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td valign="top" width="235">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td class="leftnavtop"><%= ChinaQJLanguageTxt65 %></td>
  </tr>
  <tr>
    <td class="leftnavcenter"><div id="nav"><%=ChinaQJTalentWebMenu()%></div></td>
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
    <td class="contentcenter"><div class="contentnav"><%=ChinaQJJobsViewWebLocation()%></div></td>
  </tr>
  <tr>
	<td class="contentcenter">
<%
		SortID=request.QueryString("SortID")
		TabName="ChinaQJ_Jobs"				'表名
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
				AutoLink = "JobsView.Asp?ID="&allInfo(""&i&"")("ID")
			End If
			If allInfo(""&i&"")("EndDate")>now() Then
				mStatu=ChinaQJLanguageTxt72
			Else
				mStatu=ChinaQJLanguageTxt73
			End If 
%>
			<tr height="28">
			  <td style="background:url('<%=StylePath%>bg2.gif') repeat-x left bottom;">&nbsp;
					<img src="<%=StylePath%>arr.gif" width="11" height="14" align="absmiddle" />&nbsp;&nbsp;
					<a href="<%=AutoLink%>" title="<%=allInfo(""&i&"")("JobName"&Language)%>"><%=StrLeft(allInfo(""&i&"")("JobName"&Language),StrL)%></a>
			  </td>
			  <td style="background:url('<%=StylePath%>bg2.gif') repeat-x left bottom; color:#999999">&nbsp;&nbsp;&nbsp;
				<%=allInfo(""&i&"")("eEmployer"&Language)%>
			  </td>
			  <td style="background:url('<%=StylePath%>bg2.gif') repeat-x left bottom; color:#999999">&nbsp;&nbsp;&nbsp;
				<%=allInfo(""&i&"")("JobAddress"&Language)%>
			  </td>
			  <td style="background:url('<%=StylePath%>bg2.gif') repeat-x left bottom; color:#999999">&nbsp;&nbsp;&nbsp;
				<%=allInfo(""&i&"")("JobNumber")%>
			  </td>
			  <td style="background:url('<%=StylePath%>bg2.gif') repeat-x left bottom; color:#999999">&nbsp;&nbsp;&nbsp;
				<%=mStatu%>
			  </td>
			  <td style="background:url('<%=StylePath%>bg2.gif') repeat-x left bottom; color:#999999">&nbsp;&nbsp;&nbsp;
				<%=FormatDate(allInfo(""&i&"")("Addtime"),13)%>
			  </td>
			</tr>
<%
		Next
%>
			</tbody>
		</table>		
	<!--		Page		-->
    <%=GetShowPageInfo(TabName,WSql,PageId,PageShowCount,6,"条信息",quAry)%>
  	<!--		Page		-->
<%	Else %>
	<div align="center">^_^ 对不起,没有找到相关信息</div>
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