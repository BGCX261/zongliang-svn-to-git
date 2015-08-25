<!--#include file="../Include/Const.asp" -->
<!--#include file="../Include/ConnSiteData.asp" -->

<%
	
	Language="Ch"
	mykey="请填写"
	If request.QueryString("Lan")<>"" Then Language=request.QueryString("Lan") End If
	If request.QueryString("key")<>"" Then mykey=request.QueryString("key") End If

	'MySql="SELECT * FROM ChinaQJ_Products WHERE ViewFlag"&Language&" AND (ProName"&Language&"='' OR ProInfo"&Language&"=''  OR ProInfo"&Language&" LIKE '%%')"
	
	MySql="SELECT * FROM ChinaQJ_Products WHERE ViewFlag"&Language&" AND (ProName"&Language&" = """" OR ProName"&Language&" IS Null OR ProInfo"&Language&" = """" OR ProInfo"&Language&" IS Null OR ProInfo"&Language&" LIKE '%"&mykey&"%' ) ORDER BY UpdateTime DESC"

	'Response.write(MySql)

	Dim ObjList
	Set ObjList=SQL_Query(MySql)


%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Test</title>
</script>
</head>

<body>
	<div style="width:100%; margin-top:20px;" align="center"><h3>共计<span style="color:red"><%=ObjList.Count%></span>款产品</div>
	<div style="width:100%; height:100%; border:1px solid #ccc;" align="center">
		<table>
<%
	If ObjList.Count Then
		For i=0 To (ObjList.Count-1)
			ProductName=ObjList(""&i&"")("ProductName"&Language)
			AutoLink = ""&SysRootDir&Language&"/ProductView.Asp?ID="&ObjList(""&i&"")("ID")&""
			SmallPicPath=HtmlSmallPic(ObjList(""&i&"")("GroupID"),ObjList(""&i&"")("SmallPic"),ObjList(""&i&"")("Exclusive"))	' img
			If i Mod 5=0 Then
				Response.write("<tr>")
			End If	
%>
			<td align="center" valign="top">
			<table width="150" border="0" cellspacing="0" cellpadding="0" style="float:left; margin:22px;">
				  <tbody>
				    <tr>
					  <td width="150" align="center">
					    <a href="<%=AutoLink%>" target="_blank" title="<%=ProductName%>"><img src="<%=SmallPicPath%>" width="150" height="113" border="0" style="padding: 3px; border: 1px solid #ccc" alt=""></a>
					  </td>
					</tr>
					<tr><td><img src="<%=StylePath%>t.gif" width="1" height="2"></td></tr>
					<tr><td bgcolor="#EFEFEF" style="padding:4px 7px 4px 7px;">
					  <table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tbody>
						  <tr>
							<td height="19" align="left">
							  <a href="<%=AutoLink%>" title="<%=ProductName%>"><font color=""><%=ProductName%></font></a>
							</td>
						  </tr>
						  <tr>
							<td height="19" align="left">
							  Time:<span style="font-size: 11px"><%=FormatDate(ObjList(""&i&"")("UpdateTime"),13)%></span>&nbsp;&nbsp;
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
			If (i+1) Mod 5=0 Then
				Response.write("</tr>")
			End If
		Next
	End If
%>
		</table>
	</div>
</body>
</html>