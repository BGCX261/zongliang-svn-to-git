<!--#include FILE="upload.inc"-->
<%
	Function Create_Folder(ByVal t0)
		Dim t1,t2,Fso,I
		On Error Resume Next
		t0=Server.MapPath(t0)
		Set Fso=CreateObject("Scrip"&"ting."&"File"&"System"&"Object") 
			IF Fso.FolderExists(t0) Then Exit Function  
			t1=Split(t0,"\"):t2="" 
			For I=0 To Ubound(t1)  
				t2=t2&t1(I)&"\"
				IF Not Fso.FolderExists(t2) Then Fso.CreateFolder(t2)
				IF Err Then
					IF Err.Number<>70 And Err.Number<>58 Then
						Response.Write "Create_Folder："&Err.Description&"<br>"
					End IF
					Err.Clear
				End IF
			Next
		Set Fso=Nothing
	End Function

	Function Check_Folder(ByVal t0)
		Dim Fso
		t0=Server.MapPath(t0)
		Set Fso=CreateObject("Scrip"&"ting."&"File"&"System"&"Object")
		Check_Folder=Fso.FolderExists(t0)
		Set Fso=Nothing
	End Function

    dim upload,file,formName,title,state,picSize,picType,uploadPath,fileExt,fileName,prefix

    uploadPath = "/upload/file/"&date()&"/"			'上传保存路径
	
	If Check_Folder(uploadPath) Then
		'Create_Folder(uploadPath)
	Else
		Create_Folder(uploadPath)
	End If

    picSize = 500                        '允许的文件大小，单位KB
    picType = ".rar,.doc,.docx,.zip,.pdf,.txt,.swf,.wmv"      '允许的图片格式
    
    '文件上传状态,当成功时返回SUCCESS，其余值将直接返回对应字符窜并显示在图片预览框，同时可以在前端页面通过回调函数获取对应字符窜
    state="SUCCESS"
    
    set upload=new upload_5xSoft         '建立上传对象
    title = htmlspecialchars(upload.form("pictitle"))

    for each formName in upload.file
        set file=upload.file(formName)

        '大小验证
        if file.filesize > picSize*1024 then
            state="附件大小超出限制"
        end if

        '格式验证
        fileExt = lcase(mid(file.FileName, instrrev(file.FileName,".")))
        if instr(picType, fileExt)=0 then
            state = "附件类型错误"
        end If

        '保存图片
        prefix = int(900000*Rnd)+1000
        if state="SUCCESS" then
            fileName = uploadPath & prefix & second(now) & fileExt
            file.SaveAs Server.mappath( fileName)
        end if
        
        '返回数据
        response.Write "{'url':'" & FileName & "','title':'"& title &"','state':'"& state &"'}"
        set file=nothing

    next
    set upload=nothing

    function htmlspecialchars(someString)
        htmlspecialchars = replace(replace(replace(replace(someString, "&", "&amp;"), ">", "&gt;"), "<", "&lt;"), """", "&quot;")
    end function
%>