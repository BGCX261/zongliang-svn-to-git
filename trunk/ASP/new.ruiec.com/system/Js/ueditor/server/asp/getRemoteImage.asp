<%
Dim uri,touri
uri = Request.Form("content")
touri = "/upload/images/"

If CheckURL(uri) Then
	Save2Local(uri,touri)
Else
	Response.write("{'url':'ue_separate_ueerror','tip':'远程图片不存在！','srcUrl':'"&uri&"'}")
End If

function getHTTPimg(url)
	on error resume Next
	dim http
	set http=server.createobject("MSXML2.XMLHTTP")
	Http.open "GET",url,False
	Http.send()
	if Http.readystate<>4 then exit Function
	getHTTPimg=Http.responseBody
	set http=Nothing
	if err.number<>0 then err.Clear
end function

function Save2Local(from,tofile)
	on error resume Next
	dim geturl,objStream,imgs
	geturl=trim(from)
	imgs=getHTTPimg(geturl)
	Set objStream = Server.CreateObject("ADODB.Stream")
	objStream.Type =1
	objStream.Open
	objstream.write imgs
	objstream.SaveToFile tofile,2
	objstream.Close()
	set objstream=Nothing
	if err.number<>0 Then
		Response.write("{'url':'ue_separate_ueerror','tip':'远程图片抓取出错！','srcUrl':'"&from&"'}")
		err.Clear
	Else
		Response.write("{'url':'ue_separate_ueerror','tip':'远程图片抓取成功！','srcUrl':'"&tofile&"'}")
	End If
end function

Function CheckURL(byval A_strUrl)
	set XMLHTTP = Server.CreateObject("Microsoft.XMLHTTP")
	XMLHTTP.open "HEAD",A_strUrl,False
	XMLHTTP.send()
	CheckURL=(XMLHTTP.status=200)
	set XMLHTTP = Nothing
End Function

%>