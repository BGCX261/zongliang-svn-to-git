<!--#include file="Sdcms_Check.asp"-->
<!--#include file="../Inc/Upload.asp"-->
<!--#include file="../Inc/AspJpeg.asp"-->
<%
Dim Act:Act=Trim(Request.QueryString("Act"))
Dim Alow_FileType
Select Case Act
	Case "1":Alow_FileType="doc|docx|rar|zip|7z|xls|pdf|ppt|flv"
	Case Else:Act=0:Alow_FileType="jpg|gif|jpeg"
End Select
Const IsOldName=0'0为自动重命名，1为原文件名

Dim UpLoad,FileName
Set UpLoad=New UpLoadClass
	UpLoad.FileType=Alow_FileType'允许上传的文件类型
	UpLoad.SavePath=UploadDir("")'文件上传的目录，参数：art/，带/为放art文件夹内，否则将和日期一起作为文件夹名
	UpLoad.Charset="gb2312"
	UpLoad.MaxSize=Sdcms_upfileMaxSize'200*1024为200K
	UpLoad.AutoSave=IsOldName
	UpLoad.Open()
	'保存文件
	IF IsOldName=0 Then
		FileName=UpLoad.SavePath&UpLoad.Form("imgFile")
	Else
		FileName=UpLoad.SavePath&UpLoad.Form("imgFile_Name")
	End IF
	Select Case UpLoad.Form("imgFile_Err")
		Case -1:Set_Json 1,"文件为空，上传失败"
		Case  1:Set_Json 1,"文件过大，上传失败"
		Case  2:Set_Json 1,"不允许被上传的文件"
		Case  3:Set_Json 1,"文件过大，且不允许被上传而未被保存"
		Case  4:Set_Json 1,"文件保存失败"
	End Select
	
	Dim File_Type
	Select Case Lcase(Right(Filename,3))
		Case "jpg","gif","png","peg","bmp":File_Type=0
		Case "swf",".rm","wma","mp3","wmv","mvb","avi":File_Type=1
		Case "flv":File_Type=2
		Case Else:File_Type=3
	End Select
	IF File_Type=0 Then
		Sdcms_Jpeg(Filename)
	End IF
	
	Set_Json 0,FileName
Set UpLoad=Nothing

Sub Set_Json(ByVal t0,ByVal t1)
	IF t0=1 Then
		Response.Write("{""error"":"&t0&",""message"":"""&t1&"""}")
		Response.End()
	Else
		Response.Write("{""error"":"&t0&",""url"":"""&t1&"""}")
	End IF
End Sub
%>