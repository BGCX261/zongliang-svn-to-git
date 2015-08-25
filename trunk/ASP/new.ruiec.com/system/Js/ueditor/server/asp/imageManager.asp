<%
action = Request.Form("action")

If action="get" Then 
	getfiles("/upload/images/")
	'getfiles(path)
End If

Function getfiles(path)
	On Error Resume Next
	'Dim fso,folder
	'Response.write path
	Set fso = Server.CreateObject("Scripting.FileSystemObject")
	If Not fso.FolderExists(Server.MapPath(path)&"\") Then
		Exit Function
	End If
	'Response.write path
	Set folder = fso.GetFolder(Server.MapPath(path)&"\")
	'Response.write "<br />a<br />"
	For Each dir in folder.SubFolders
		getfiles(path&dir.name&"/")
	Next
	
	Dim fileTypes
	fileTypes = "gif,jpg,jpeg,png,bmp"

	For Each file in folder.Files
		fileExt = mid(file.name, InStrRev(file.name, ".") + 1)
		If instr(lcase(fileTypes), fileExt) > 0 Then
			'Response.write(Replace(path&file.name,"../../","server/")&"ue_separate_ue")
			Response.write(path&file.name&"ue_separate_ue")
		End If 
	Next
	if err.number<>0 Then
	'	Response.write Err.Description
		err.Clear
	End If
End Function

%>
