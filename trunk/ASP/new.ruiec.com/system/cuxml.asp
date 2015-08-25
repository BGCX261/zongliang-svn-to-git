<%

	
	dim xmlDoc
	set xmlDoc=Server.CreateObject("Microsoft.XMLDOM")
	xmlDoc.async=False
	xmlDoc.load(server.MapPath("config.xml"))
	if xmlDoc.parseError.errorCode = 0 Then
		response.Write xmlDoc.selectSingleNode("//slides/slide/url").Text
	end If
	set xmlDoc=nothing
	
	'dim content
	'	content=Trim(Request.Form("content"))
	'If request("action")="Edit" Then
	'	Set Fso = Server.CreateObject("Scripting.FileSystemObject")
	'	Filen=Server.MapPath("config.xml")
	'	Set Site_Config=FSO.CreateTextFile(Filen,true, False)
	'	Site_Config.Write content
	'	Site_Config.Close
	'	Set Fso = Nothing
	'	Response.Write("<script>alert('\u4fee\u6539\u6210\u529f!');</script>")
	'End If
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB2312" />
<title>生成xml</title>
</head>
<body>
<form method="post" action="?Action=Edit">
<textarea name="content" class="textinput" style="width:800px;height:200px;"><!--#include file="config.xml"--></textarea>
<BR>
<input type="submit" name="Submit" class="submit" value="生成文件">
</form>
</body>
</html>