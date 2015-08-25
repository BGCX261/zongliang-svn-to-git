<table width="980" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td valign="top" width="235">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td class="leftnavtop"><%= ChinaQJLanguageTxt134 %></td>
  </tr>
  <tr>
    <td class="leftnavcenter"><div id="nav"><%=ChinaQJMessageWebMenu()%></div></td>
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
    <td class="contentcenter"><div class="contentnav"><%=ChinaQJMessageListWebLocation()%></div></td>
  </tr>
  <tr>
	<td class="contentcenter">
<%
		SortID=request.QueryString("SortID")
		TabName="ChinaQJ_Message"				'表名
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
		  For i=0 To allInfo.Count-1
			If ISHTML = 1 Then
				AutoLink = ""&allInfo(""&i&"")("ClassSeo")&""&Separated&""&allInfo(""&i&"")("ID")&"."&HTMLName
			Else
				AutoLink = "Message.Asp?ID="&allInfo(""&i&"")("ID")
			End If				
%>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
			  <tr>
			    <td width="5%" height="25" bgcolor="#820000" align="center">
					<font color="#FFFFFF"><b><%=allInfo(""&i&"")("ID")%></b></font>
				</td>
			    <td width="50%" height="25" bgcolor="#EDEEEF" align="left" style="padding-left: 8px">
					<font color="#333333"><b><%=allInfo(""&i&"")("Company")%></b></font>(<%=allInfo(""&i&"")("Linkman")&allInfo(""&i&"")("Sex")%>)
				</td>
			    <td width="45%" height="25" bgcolor="#EDEEEF" align="right" style="padding-right: 8px">
					<font color="#808080">留言时间：<%=FormatDate(allInfo(""&i&"")("AddTime"),13)%></font>
				</td>
			  </tr>
			</table>
			<table width="100%" border="0" cellspacing="0" cellpadding="1">
			  <tr align="left">
			    <td width="15%" height="20" align="right" style="padding-right: 8px">咨询主题：</td>
			    <td><b><%=allInfo(""&i&"")("MesName")%></b></td>
			  </tr>
			  <tr align="left">
			    <td height="20" align="right" style="padding-right: 8px">咨询内容：</td>
			    <td style="padding-right: 5px">
					<%=ChinaQJMessageListMessageContent(allInfo(""&i&"")("MemID"),allInfo(""&i&"")("SecretFlag"),HtmlStrReplace(allInfo(""&i&"")("Content")))%>
				</td>
			  </tr>
<%			If allInfo(""&i&"")("ReplyContent") <> "" Then	%>
			  <tr>
			    <td>&nbsp;</td>
			    <td bgcolor="#F7F7F7" style="line-height: 200%"><font color="#333333"><b>管理员回复：</b></font><br />
				<%=ChinaQJMessageListMessageReply(allInfo(""&i&"")("MemID"),allInfo(""&i&"")("MesName"),allInfo(""&i&"")("SecretFlag"),allInfo(""&i&"")("ReplyContent"))%>
				</td>
			  </tr>
<%			End If	%>
			  <tr>
			    <td colspan="2" height="5"></td>
			  </tr>
			</table>
<%
		Next
%>
	<!--		Page		-->
    <%=GetShowPageInfo(TabName,WSql,PageId,PageShowCount,6,"条留言",quAry)%>
  	<!--		Page		-->
<%	Else %>
	<div align="center">^_^ 还木有人留言哦,赶紧抢个沙发吧...</div>
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