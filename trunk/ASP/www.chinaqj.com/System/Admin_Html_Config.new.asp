<!--#include file="CheckAdmin.asp"-->
<!--#include file="Admin_Html_Function.nwe.asp"-->
<%
Response.write("<meta http-equiv=""Content-Type"" content=""text/html; charset=utf-8"">")
if Instr(session("AdminPurview"),"|34,")=0 then
  response.write ("<br /><br /><div align=""center""><font style=""color:red; font-size:9pt; "")>您没有管理该模块的权限！</font></div>")
  response.end
end If

'==========================================
'	生成静态页面函数 Beta
'	url			动态页面URL
'	PageName	生成页面名称
'==========================================
Function CHtmlPage(url,PageName)	
	set objXmlHttp=Server.createObject("Microsoft.XMLHTTP")
	objXmlHttp.open "GET",url,False
	objXmlHttp.setRequestHeader "Content-Type","text/HTML"
	objXmlHttp.send()
	binFileData=objXmlHttp.ResponseBody
	filesize=objXmlHttp.GetResponseHeader("Content-Length")	'-file size
	Set objXmlHttp=Nothing
	set objAdoStream=Server.CreateObject("Adodb." & "Stream")
	objAdoStream.Type=1
	objAdoStream.Open()
	objAdoStream.Write(binFileData)
	objAdoStream.SaveToFile PageName,2
	objAdoStream.Close()
	set objAdoStream=nothing
	
	If filesize>1024 Then
		filesize=Fix(filesize/1024)+1
		sizetype="KB"
		If filesize>1024*1024 Then
			filesize=Fix(filesize/1024)+1
			sizetype="MB"
			If filesize>1024*1024*1024 Then
				filesize=Fix(filesize/1024)+1
				sizetype="GB"
			End If
		End If
	Else
		sizetype="B"
	End If

	PageName=Replace(PageName,Server.MapPath("/")&"\","http://"&Request.ServerVariables("Http_Host")&"/")
	PageName=Replace(PageName,"\","/")
	
	Response.write("<hr /><div style='margin-left:50px;'><a href="""&url&""" target=""_blank"">"&url&"</a>		-->		<a href="""&PageName&""" target=""_blank"">"&PageName&"("&filesize&sizetype&")</a></div>")

	HtmlPageCounts=HtmlPageCounts+1

	Response.write("<script>txt_ncount.innerHTML=""当前共计生成了(<span style='color:red'>"&HtmlPageCounts&"</span>)个静态页面文件"";</script>")
	
End Function

%>