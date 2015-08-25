<%
'==============================
'SDCMS常用函数库
'Author：IT平民
'Date:2009-04-17
'LastUpDate:2010-2
'==============================
Function UploadDir(ByVal t0)
	Dim t1:t1=Now()
	Dim t2:t2=Year(t1)&Right("0"&Month(t1),2)
	UploadDir=Sdcms_Root&Sdcms_UpfileDir&"/"&t0&t2&"/"
	Create_Folder UploadDir
End Function

Function DbOpen
	IF Not Isobject(Conn) Then
		On Error Resume Next
		Dim Connstr
		IF Sdcms_DataType Then
			Connstr="Provider=Microsoft.Jet.OLEDB.4.0;Data Source="&Server.MapPath(Sdcms_Root&Sdcms_DataFile&"/"&Sdcms_DataName)
			SqlNowString="Now()"
		Else
			ConnStr="Provider=Sqloledb;User ID="&Sdcms_SqlUser&";Password="&Sdcms_SqlPass&";"
			ConnStr=ConnStr&"Initial CataLog="&Sdcms_SqlData&";Data Source="&Sdcms_SqlHost&";"
			SqlNowString="Getdate()"
		End IF
		Set Conn=Server.CreateObject("Adodb.Connection")
		Conn.Open ConnStr
		IF Err then 
			Echo "数据库连接失败!"
			Err.Clear
			Response.End()
		End IF
	End IF
End Function

Sub CloseDb
	On Error Resume Next
	IF IsObject(Conn) Or Conn.State=1 Then
		Conn.Close
		Set Conn=Nothing
	End IF
End Sub

Sub Echo(ByVal t0)
	Response.Write t0
End Sub

Sub Died
	Response.End()
End Sub

Sub Go(ByVal t0)
	Response.Redirect t0
End Sub

Sub Alert(ByVal t0, ByVal t1)
	Response.Write("<script>alert("""&t0&""");location.href="""&t1&""";</script>")
End Sub

'=====================================
'三目运算
'=====================================
Function IIF(ByVal t0,ByVal t1,ByVal t2)
	IF t0 Then IIF=t1 Else IIF=t2
End Function

'=====================================
'执行时间
'=====================================
Function Runtime
	Runtime=FormatNumber(Timer()-Startime,4,True,False,True)
End Function

'=====================================
'Replace替换函数，主要防止Replace出错
'=====================================
Function Re(ByVal t0,ByVal t1,ByVal t2)
	On Error ReSume Next
	IF IsNull(t0) Or Len(t0)=0 Then t0=""
	IF IsNull(t1) Or Len(t1)=0 Then t1=""
	IF IsNull(t2) Or Len(t2)=0 Then t2=""
	Re=Replace(t0,t1,t2)
End Function

'=====================================
'创建/修改缓存
'=====================================
Function Create_Cache(ByVal t0,ByVal t1)
	Dim t2(2)
	t2(0)=t1:t2(1)=Now()
	Application.Lock()
	Application(Sdcms_Cookies&t0)=t2
	Application.UnLock()
End Function

'=====================================
'检测缓存是否存在
'=====================================
Function Check_Cache(ByVal t0)
	Check_Cache=False
	Dim CacheData
	IF IsNull(t0) Or Len(t0)=0 Then Exit Function
	CacheData=Application(Sdcms_Cookies&t0)
	IF IsEmpty(CacheData) Or Not IsArray(CacheData) Then Check_Cache=True:Exit Function
	IF DateDiff("s",CDate(CacheData(1)),Now())>=Sdcms_CacheDate Then Check_Cache=True
End Function

'=====================================
'读取缓存
'=====================================
Function Load_Cache(ByVal t0)
	Dim CacheData
	CacheData=Application(Sdcms_Cookies&t0)
	IF IsArray(CacheData) Then Load_Cache=CacheData(0) Else Load_Cache=t0
End Function

'=====================================
'删除缓存
'=====================================
Function Del_Cache(ByVal t0)
	Application.Lock()
	Application.Contents.Remove Sdcms_Cookies&t0
	Application.UnLock()
End Function

'=====================================
'创建/修改Cookies
'=====================================
Function Add_Cookies(ByVal t0,ByVal t1)
	IF Len(t1)=0 Or IsNull(t1) Then t1=""
	Response.Cookies(sdcms_cookies&t0)=t1
End Function

'=====================================
'读取Cookies
'=====================================
Function Load_Cookies(ByVal t0)
	Load_Cookies=Request.Cookies(sdcms_cookies&t0)
End Function

Function Sdcms_Date
	Sdcms_Date=Year(Date())&Right("0"&Month(Date()),2)&Right("0"&Day(Date()),2)
End Function

'=====================================
'转换数据类型
'=====================================
Function IsNum(ByVal t0,ByVal t1)
	IF t0="" Or Not IsNumeric(t0) Then IsNum=t1 Else IsNum=Clng(t0)
End Function

'=====================================
'获取IP
'=====================================
Function GetIp
	GetIp=Request.ServerVariables("HTTP_X_FORWARDED_FOR")
	IF GetIp="" Then GetIp=Request.ServerVariables("REMOTE_ADDR")
	IF Len(GetIp)>15 Then GetIp="UnKnow"
	GetIp=FilterText(GetIp,0)
End Function

'=====================================
'检查是否外部提交
'=====================================
Function Check_Post
	Check_Post=False
	Dim t0,t1
	t0=Cstr(Request.ServerVariables("HTTP_REFERER"))
	t1=Cstr(Request.ServerVariables("SERVER_NAME"))
	IF Mid(t0,8,Len(t1))<>t1 Then Check_Post=True
End Function

'=====================================
'获取内容中所有图片
'=====================================
Function Get_ImgSrc(ByVal t0)
	Dim t1,Regs,Matches,Match
	t1=""
	IF Not(IsNull(t0) Or Len(t0)=0) Then
		Set Regs=New RegExp
		Regs.Pattern="<img[^>]+src=""([^"">]+)""[^>]*>"
		Regs.Ignorecase=True
		Regs.Global=True
		Set Matches=Regs.Execute(t0)
		IF Matches.Count>0 Then
			For Each Match In Matches
				IF Left(Match.SubMatches(0),7)<>"http://" Then
					t1=t1&"<option value="""&Match.SubMatches(0)&""">"&Match.SubMatches(0)&"</option>"
				End IF
			Next
		End IF
	End IF
	Get_ImgSrc=t1
	Set Matches=Nothing
	Set Regs=Nothing
End Function

'=====================================
'获取内容中第一个图片
'=====================================
Function Frist_Pic(ByVal t0)
	Frist_Pic=""
	Dim Regs,Matches
	Set Regs=New RegExp
	Regs.Ignorecase=True
	Regs.Global=True
	Regs.Pattern="<img[^>]+src=""([^"">]+)""[^>]*>"
	Set Matches=Regs.Execute(t0)
	IF Regs.test(t0) Then
	   Frist_Pic=Matches(0).SubMatches(0)
	End IF
	Set Matches=Nothing
	Set Regs=Nothing
End Function

'=====================================
'转换内容，防止意外
'=====================================
Function Content_Encode(ByVal t0)
	IF IsNull(t0) Or Len(t0)=0 Then
		Content_Encode=""
	Else
		Content_Encode=Replace(t0,"<","&lt;")
		Content_Encode=Replace(Content_Encode,">","&gt;")
	End IF
End Function

'=====================================
'反转换内容
'=====================================
Function Content_Decode(ByVal t0)
	IF IsNull(t0) Or Len(t0)=0 Then
		Content_Decode=""
	Else
		Content_Decode=Replace(t0,"&lt;","<")
		Content_Decode=Replace(Content_Decode,"&gt;",">")
	End IF
End Function

'=====================================
'过滤字符
'=====================================
Function FilterText(ByVal t0,ByVal t1)
	IF Len(t0)=0 Or IsNull(t0) Or IsArray(t0) Then FilterText="":Exit Function
	t0=Trim(t0)
	Select Case t1
		Case "1"
			t0=Replace(t0,Chr(32),"&nbsp;")
			t0=Replace(t0,Chr(13),"")
			t0=Replace(t0,Chr(10)&Chr(10),"<br>")
			t0=Replace(t0,Chr(10),"<br>")
		Case "2"
			t0=Replace(t0,Chr(8),"")'回格
			t0=Replace(t0,Chr(9),"")'tab(水平制表符)
			t0=Replace(t0,Chr(10),"")'换行
			t0=Replace(t0,Chr(11),"")'tab(垂直制表符) 
			t0=Replace(t0,Chr(12),"")'换页
			t0=Replace(t0,Chr(13),"")'回车 chr(13)&chr(10) 回车和换行的组合
			t0=Replace(t0,Chr(22),"")
			t0=Replace(t0,Chr(32),"")'空格 SPACE 
			t0=Replace(t0,Chr(33),"")'! 
			t0=Replace(t0,Chr(34),"")'" 
			t0=Replace(t0,Chr(35),"")'#
			t0=Replace(t0,Chr(36),"")'$ 
			t0=Replace(t0,Chr(37),"")'%  
			t0=Replace(t0,Chr(38),"")'&
			t0=Replace(t0,Chr(39),"")'' 
			t0=Replace(t0,Chr(40),"")'(  
			t0=Replace(t0,Chr(41),"")')
			t0=Replace(t0,Chr(42),"")'*
			t0=Replace(t0,Chr(43),"")'+
			t0=Replace(t0,Chr(44),"")',
			t0=Replace(t0,Chr(45),"")'-
			t0=Replace(t0,Chr(46),"")'.
			t0=Replace(t0,Chr(47),"")'/
			t0=Replace(t0,Chr(58),"")':
			t0=Replace(t0,Chr(59),"")';
			t0=Replace(t0,Chr(60),"")'<
			t0=Replace(t0,Chr(61),"")'=
			t0=Replace(t0,Chr(62),"")'>
			t0=Replace(t0,Chr(63),"")'?
			t0=Replace(t0,Chr(64),"")'@
			t0=Replace(t0,Chr(91),"")'\ 
			t0=Replace(t0,Chr(92),"")'\ 
			t0=Replace(t0,Chr(93),"")']  
			t0=Replace(t0,Chr(94),"")'^
			t0=Replace(t0,Chr(95),"")'_
			t0=Replace(t0,Chr(96),"")'`
			t0=Replace(t0,Chr(123),"")'{   
			t0=Replace(t0,Chr(124),"")'| 
			t0=Replace(t0,Chr(125),"")'}
			t0=Replace(t0,Chr(126),"")'~
	Case Else
		t0=Replace(t0, "'", "&#39;")
		t0=Replace(t0, """", "&#34;")
		t0=Replace(t0, "<", "&lt;")
		t0=Replace(t0, ">", "&gt;")
	End Select
	IF Instr(Lcase(t0),"expression")>0 Then
		t0=Replace(t0,"expression","e&#173;xpression", 1, -1, 0)
	End If
	FilterText=t0  
End Function

'=====================================
'过滤常见字符及Html
'=====================================
Function FilterHtml(ByVal t0)
	IF Len(t0)=0 Or IsNull(t0) Or IsArray(t0) Then FilterHtml="":Exit Function
	IF Len(Sdcms_Badhtml)>0 Then t0=ReplaceText(t0,"("&Sdcms_Badhtml&")",string(len("&$1&"),"*"))
	IF Len(Sdcms_BadEvent)>0 Then t0=ReplaceText(t0,"("&Sdcms_BadEvent&")",string(len("&$1&"),"*"))
	IF Len(Sdcms_BadText)>0 Then t0=ReplaceText(t0,"("&Sdcms_BadText&")",string(len("&$1&"),"*"))
	t0=FilterText(t0,0)
	FilterHtml=t0
End Function

Function GotTopic(ByVal t0,ByVal t1)
	IF Len(t0)=0 Or IsNull(t0) Then
		GotTopic=""
		Exit Function
	End IF
	Dim l,t,c, i
	t0=Replace(Replace(Replace(Replace(t0,"&nbsp;"," "),"&quot;",chr(34)),"&gt;",">"),"&lt;","<")
	l=Len(t0)
	t=0
	For I=1 To l
		c=Abs(Asc(Mid(t0,i,1)))
		IF c>255 Then t=t+2 Else t=t+1
		IF t>=t1 Then
			gotTopic=Left(t0,I)&"…"
		Exit For
		Else
			GotTopic=t0
		End IF
	Next
	GotTopic=Replace(Replace(Replace(Replace(GotTopic," ","&nbsp;"),chr(34),"&quot;"),">","&gt;"),"<","&lt;")
End Function

Function UrlDecode(ByVal t0)
	Dim t1,t2,t3,i,t4,t5,t6
	t1="" 
	t2=False 
	t3="" 
	For I=1 To Len(t0) 
		t4=Mid(t0,I,1) 
		IF t4="+" Then 
			t1=t1&" " 
		ElseIF t4="%" Then 
			t5=Mid(t0,i+1,2) 
			t6=Cint("&H" & t5) 
			IF t2 Then 
				t2=False 
				t1=t1&Chr(Cint("&H"&t3&t5)) 
			Else 
				IF Abs(t6)<=127 then 
					t1=t1&Chr(t6) 
				Else 
					t2=True 
					t3=t5 
				End IF
			End IF 
			I=I+2 
		Else 
			t1=t1&t4 
		End IF 
	Next 
	UrlDecode=t1 
End Function

Function CutStr(byVal t0,byVal t1)
	Dim l,t,c,i
	IF IsNull(t0) Then CutStr="":Exit Function
	l=Len(t0)
	t1=Int(t1)
	t=0
	For I=1 To l
		c=Asc(Mid(t0,I,1))
		IF c<0 Or c>255 Then t=t+2 Else t=t+1
		IF t>=t1 Then
			CutStr=Left(t0,I)&"..."
			Exit For
		Else
			CutStr=t0
		End IF
	Next
End Function

Function CloseHtml(ByVal t0)
    Dim t1,I,t2,t3,Regs,Matches,J,Match
    Set Regs=New RegExp
    Regs.IgnoreCase=True
    Regs.Global=True
    t1=Array("p","div","span","table","ul","font","b","u","i","h1","h2","h3","h4","h5","h6")
    For I=0 To UBound(t1)
        t2=0
        t3=0
        Regs.Pattern="\<"&t1(I)&"( [^\<\>]+|)\>"
        Set Matches=Regs.Execute(t0)
        For Each Match In Matches
            t2=t2+1
        Next
        Regs.Pattern="\</"&t1(I)&"\>"
        Set Matches=Regs.Execute(t0)
        For Each Match In Matches
            t3=t3+1
        Next
        For j=1 To t2-t3
            t0=t0+"</"&t1(I)&">"
        Next
    Next
    CloseHtml=t0
End Function

Function IsObjInstalled(ByVal t0)
	Dim xTestObj
	On Error Resume Next
	IsObjInstalled=False
	Set xTestObj=Server.CreateObject(t0)
		IF 0=Err Then IsObjInstalled=True
	Set xTestObj=Nothing
	On Error GoTo 0
End Function

'============================== 
'格式化HTML，SDCMS加强版
'============================== 
Function Removehtml(ByVal t0)
	IF Len(t0)=0 Or IsNull(t0) Then
		Removehtml=""
		Exit Function
	End IF
	Dim Regs,Matches,Match
	Set Regs=New Regexp
	Regs.Ignorecase=True
	Regs.Global=True
	'过滤掉JS,Iframe
	Regs.pattern ="<script.+?/script>"
	t0=Regs.Replace(t0,"")
	Regs.pattern ="<iframe.+?/iframe>"
	t0=Regs.Replace(t0,"")
	'再过滤其他
	t0=Replace(t0,"&lt;","<")
	t0=Replace(t0,"&gt;",">")
	Regs.Pattern="<.+?>"
	Set Matches=Regs.Execute(t0)
	For Each Match In Matches
		t0=Replace(t0,Match.value,"")
	Next
	t0=Replace(t0,"&amp;nbsp;","")
	t0=Replace(t0,"&nbsp;","")
	t0=Replace(t0,vbCrLf,"")
	t0=Replace(t0,"　","")
	t0=Replace(t0," ","")
	t0=Replace(t0,CHR(9),"")
	t0=Replace(t0,CHR(13),"")
	t0=Replace(t0,CHR(10),"")
	t0=Replace(t0,CHR(22),"")
	Set Regs=Nothing
	Removehtml=t0
End Function

'=====================================
'关键字高亮
'=====================================
Function Highlight(ByVal t0,ByVal t1)  
	IF Len(t1)=0 Then:Highlight=t0:Exit Function
	t1=Replace(t1,"?","？")
	t0=ReplaceText(t0,"("&t1&")","<font color=red>$1</font>" )
	Highlight=t0
End Function

'=====================================
'正则替换
'=====================================
Function ReplaceText(ByVal t0,ByVal t1,ByVal t2)
	Dim regEx
	Set regEx=New RegExp
		regEx.Pattern=t1
		regEx.IgnoreCase=True
		regEx.Global=True
		ReplaceText=regEx.Replace(""&t0&"",""&t2&"")
	Set regEx=nothing
End Function

'=====================================
'事件处理函数，带参数
'=====================================
Function Check_Event(ByVal t0,ByVal t1,ByVal t2)
	Dim I,t3
	t2=IsNum(t2,0)
	IF Len(t0)=0 Then Check_Event=t0:Exit Function
	t0=Replace(t0,"*","")
	t0=Replace(t0,"'","")
	t0=Replace(t0,"""","")
	t0=Split(t0,t1)
	For I=0 To Ubound(t0)
		IF Len(Trim(t0(I)))>0 Then
			IF t2=0 Then t3=t3&t1&Trim(t0(I)) Else  t3=t3&t1&Left(Trim(t0(I)),t2)
		End IF
	Next
	t3=Right(t3,Len(t3)-Len(t1))
	Check_Event=t3
End Function

'=====================================
'检测是否为图片
'=====================================
Function Check_IsPic(ByVal t0)
	Select Case Right(Lcase(t0),3)
		Case "jpg","gif","peg","bmp","png":Check_ispic=1
		Case Else:Check_ispic=0
   End Select
End Function

'=====================================
'获得文件后缀
'=====================================
Function Get_Filetxt(ByVal t0)
	Dim t1
	IF Len(t0)<2 Or Instr(t0,".")=0 Then Get_Filetxt=False:Exit Function
	t1=Split(t0,".")
	Get_Filetxt=Lcase(t1(Ubound(t1)))
End Function

'=====================================
'读取任何文件的纯代码
'=====================================
Function LoadFile(ByVal t0)
	IF Len(t0)=0 Then Exit Function
	IF Sdcms_Cache Then
		IF Check_Cache("LoadFile_"&t0) Then
			Create_Cache "LoadFile_"&t0,LoadFile_Cache(t0)
		End IF
		LoadFile=Load_Cache("LoadFile_"&t0)
	Else
		LoadFile=LoadFile_Cache(t0)
	End IF
End Function

Function LoadFile_Cache(ByVal t0)
	Dim t1,stm
	On Error Resume Next
	IF Len(t0)=0 Then Exit Function
	t1=Empty
	Set Stm=Server.CreateObject("Ado"&"db"&".Str"&"eam")
	With Stm
		.Type=2'以本模式读取
		.mode=3 
		.charset=CharSet
		.Open
		.loadfromfile Server.MapPath(t0)
		t1=.readtext
		.Close
	End With
	Set Stm=Nothing
	IF Err Then
		LoadFile_Cache="“"&t0&"”"&Err.Description:Err.Clear
	Else
		LoadFile_Cache=t1
	End IF
End Function

Function Get_ThisFolder
	Dim a,b,c
	a=Request.ServerVariables("SCRIPT_NAME")
	b=Split(a,"/")
	c=Ubound(b)
	IF c<=1 Then
		Get_ThisFolder=""
	Else
		Get_ThisFolder=b(c-1)&"/"
	End IF
End Function

'=====================================
'检查文件是否存在
'=====================================
Function Check_File(ByVal t0)
	Dim Fso
	t0=Server.MapPath(t0)
	Set Fso=CreateObject("Scrip"&"ting."&"File"&"System"&"Object")
	Check_File=Fso.FileExists(t0)
	Set Fso=Nothing
End Function

'=====================================
'检查文件夹是否存在
'=====================================
Function Check_Folder(ByVal t0)
	Dim Fso
	t0=Server.MapPath(t0)
	Set Fso=CreateObject("Scrip"&"ting."&"File"&"System"&"Object")
	Check_Folder=Fso.FolderExists(t0)
	Set Fso=Nothing
End Function

'=====================================
'创建文件夹（无限级）
'=====================================
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

Sub SaveFile(ByVal t0,ByVal t1,ByVal t2)
	Dim Fso,t3
	Set Fso=CreateObject("Scrip"&"ting."&"File"&"System"&"Object") 
	IF t0="" Then Echo "目录不能为空！":Died
	t3=Server.MapPath(t0)
	IF t2="" Or IsNull(t2) Then t2=""
	IF Fso.FolderExists(t3)=False Then Create_Folder(t0)
	BuildFile t3&"\"&Trim(t1),t2
	Set Fso=Nothing
End Sub

Function BuildFile(ByVal t0,ByVal t1)
	Dim Stm
	On Error Resume Next
	Set Stm=Server.CreateObject("Ado"&"db"&".Str"&"eam")
	With Stm
		.Type=2 '以本模式读取
		.Mode=3
		.Charset=CharSet
		.Open
		.WriteText t1
		.SaveToFile t0,2
		.Close
	End With
	Set Stm=Nothing
	IF Err Then Echo "BuildFile："&Err.Description&"<br>":Err.Clear
End Function

'=====================================
'重命名文件夹
'=====================================
Sub ReName_Folder(ByVal t0,ByVal t1)
	Dim Fso
	On Error Resume Next
	Set Fso=Server.CreateObject("Scrip"&"ting."&"File"&"System"&"Object")
	IF Fso.FolderExists(Server.MapPath(t0)) Then
		Fso.MoveFolder Server.MapPath(t0),Server.MapPath(t1)
	End IF
	Set Fso=Nothing
	IF Err Then
		IF Err.Number<>70 and Err.Number<>424  Then
			Echo "ReName_Folder："&Err.Description&"<br>"
		End IF
		Err.Clear
	End IF
End Sub

'=====================================
'重命名文件
'=====================================
Sub ReName_File(ByVal t0,ByVal t1)
	Dim Fso
	On Error Resume Next
	Set Fso=Server.CreateObject("Scrip"&"ting."&"File"&"System"&"Object")
	IF Fso.FileExists(Server.MapPath(t0)) Then
		Fso.MoveFile Server.MapPath(t0),Server.MapPath(t1)
	End IF
	Set Fso=Nothing
	IF Err Then
		IF Err.Number<>70 Then
			Echo "ReName_File："&Err.Description&"<br>"
		End IF
		Err.Clear
	End IF
End Sub

'=====================================
'删除文件夹
'=====================================
Sub Del_Folder(ByVal t0)
	Dim Fso,F
	On Error Resume Next
	Set Fso=Server.CreateObject("Scrip"&"ting."&"File"&"System"&"Object")
	Set F=Fso.GetFolder(Server.MapPath(t0))
	IF Not IsNull(t0) Then F.Delete True
	IF Err Then
		IF Err.Number<>70 and Err.Number<>424 Then
			Echo "Del_Folder："&Err.Description&"<br>"
		End IF
		Err.Clear
	End IF
	Set Fso=Nothing
End Sub

'=====================================
'删除文件
'=====================================
Sub Del_File(ByVal t0)
	Dim Fso
	On Error Resume Next
	Set Fso=Server.CreateObject("Scrip"&"ting."&"File"&"System"&"Object")
	IF Fso.FileExists(Server.MapPath(t0)) Then Fso.DeleteFile Server.MapPath(t0)
	IF Err Then
		IF Err.Number<>70 and Err.Number<>424  Then
			Echo "Del_File："&Err.Description&"<br>"
		End IF
		Err.Clear
	End IF
End Sub

Function Re_FileName(ByVal t0)
	Dim t1
    t0=Lcase(t0)
	IF Len(t0)=0 Then Re_FileName="{id}":Exit Function 
	t1=Now()
	'处理自定义文件名
	'IF Instr(t0,"{")>0 And Instr(t0,"}")>0 Then
		'IF Instr(t0,"{id}")=0 Then
			't0=t0&"{id}"'尽量防止重复
		'End IF
	'End IF
	t0=Replace(t0,"{y}",Year(t1))
	t0=Replace(t0,"{m}",Right("0"&Month(t1),2))
	t0=Replace(t0,"{d}",Right("0"&Day(t1),2))
	t0=Replace(t0,"{h}",Right("0"&Hour(t1),2))
	t0=Replace(t0,"{mm}",Right("0"&Minute(t1),2))
	t0=Replace(t0,"{s}",Right("0"&Second(t1),2))
	Re_FileName=t0
End Function

Function Re_Html(ByVal t0)
	Dim Ubb,Matchs,Match
	t0=Replace(t0,"$show_page$","")
	IF Len(t0)=0 Then Re_Html="":Exit Function
	Set Ubb=New Regexp
		Ubb.Ignorecase=True
		Ubb.Global=True
		
		Ubb.Pattern="\[quote([\s\S]+?)\]([\s\S]+?)\[\/quote\]"
		Set Matchs=Ubb.Execute(t0)
		For Each Match In Matchs
			t0=Replace(t0,Match.value,"")
		Next
		
		Ubb.Pattern="\[code\][\s\n]*\[\/code\]"
		Set Matchs=Ubb.Execute(t0)
		For Each Match In Matchs
			t0=Replace(t0,Match.value,"")
		Next
		
		Ubb.Pattern="\[Flv([\s\S]+?)\]([\s\S]+?)\[\/Flv\]"
		Set Matchs=Ubb.Execute(t0)
		For Each Match In Matchs
			t0=Replace(t0,Match.value,"")
		Next
	Set Ubb=Nothing
	Re_Html=t0
End Function

'=====================================
'内容分页函数
'=====================================
Function Get_Content_Page(ByVal t0)
	IF IsNull(t0) Or Len(t0)=0 Then Get_Content_Page="":Exit Function
	Dim t1,I,Page
	Page=IsNum(Request.QueryString("Page"),1)
	t1=Split(t0,"$show_page$")
	IF Page>Ubound(t1)+1 Then Page=Ubound(t1)+1
	Get_Content_Page=t1(Page-1)
End Function

Function Get_Content_Page_Page(ByVal t0,ByVal t1)
	IF IsNull(t0) Or Len(t0)=0 Then Get_Content_Page_Page="":Exit Function
	Dim t2
	Dim Page:Page=IsNum(Request.QueryString("Page"),1)
	t2=Split(t0,"$show_page$")
	Dim TotalNum:TotalNum=Ubound(t2)+1
	IF TotalNum=1 Then Get_Content_Page_Page="":Exit Function
	IF Page>Ubound(t2)+1 Then Page=Ubound(t2)+1
	Get_Content_Page_Page=""
	Dim iBegin,iEnd,iCur,I

	Dim Page_Start,Page_End
	Select Case Sdcms_Mode
		Case "0"
			Page_Start="?ID="&ID&"&Page="
			Page_End=""
		Case "1"
			Page_Start=""&t1&""&ID&"_"
			Page_End=Sdcms_Filetxt
	End Select
	
	iCur=Page'当前页
	iBegin=iCur
	iEnd=iCur
	IF iCur>TotalNum Then iCur=TotalNum
	IF iEnd>TotalNum Then iEnd=TotalNum
	I=6'每次总数量
	Do While True 
		IF iBegin>1 Then 
			iBegin=iBegin-1
			i=i-1  
		End If 
		IF I>1 And iEnd<TotalNum Then
			iEnd=iEnd+1
			I=I-1
		End If 
		IF (iBegin<=1 And iEnd>=TotalNum) Or I<=1 Then Exit Do     
	Loop
	
	IF iBegin<>1 Then Get_Content_Page_Page=Get_Content_Page_Page&"<a href="""&Page_Start&"1"&Page_End&""">1..</a>"	
	IF iCur<>1 Then Get_Content_Page_Page=Get_Content_Page_Page&"<a href="""&Page_Start&(iCur-1)&Page_End&""">上一页</a>"
	
	For I=iBegin To iEnd
		IF I=iCur Then 
			Get_Content_Page_Page=Get_Content_Page_Page&"<a class=""on"">"&I&"</a>"
		Else
			Get_Content_Page_Page=Get_Content_Page_Page&"<a href="""&Page_Start&I&Page_End&""">"&I&"</a>"
		End If 
	Next 
	IF iCur<>TotalNum Then Get_Content_Page_Page=Get_Content_Page_Page&"<a href="""&Page_Start&(iCur+1)&Page_End&""">下一页</a>"
	IF iEnd<>TotalNum Then	Get_Content_Page_Page=Get_Content_Page_Page&"<a href="""&Page_Start&TotalNum&Page_End&""">.."&TotalNum&"</a>"

	Get_Content_Page_Page=Get_Content_Page_Page&"<a>页次："&Page&"/"&TotalNum&"</a>"
	
End Function

Function ReplaceRemoteUrl(ByVal t0,ByVal t1,ByVal t2,ByVal t3,ByVal t4)
	Dim t5,t6
	't1为限制文件大小,为0时不限制
	't2为限制的文件类型
	't3为上传目录,为空时为系统目录
	't4为是否水印,只有系统开启水印才生效
	IF t1="" Then t1=Sdcms_upfileMaxSize
	IF t2="" Then t2="gif|jpg|png|bmp"
	IF t3="" Then t3=sdcms_upfiledir
	IF t4="" Then t4=0
	IF t3=sdcms_upfiledir Then
		t6=UploadDir("")
	Else
		t6=sdcms_root&t3&"/"&Year(Now())&Right("0"&Month(Now()),2)&"/"
	End IF
	t5 = t0
	If IsObjInstalled("Microsoft.XMLHTTP") = False then
		ReplaceRemoteUrl = t5
		Exit Function
	End If
	
	Dim reg,RemoteFile, RemoteFileurl,SaveFileName,SaveFileType
	Set reg = new RegExp
	reg.IgnoreCase  = True
	reg.Global = True
	reg.Pattern = "((http|https|ftp|rtsp|mms):(\/\/|\\\\){1}(([A-Za-z0-9_-])+[.]){1,}(net|com|cn|org|cc|tv|[0-9]{1,3})(\S*\/)((\S)+[.]{1}("&t2&")))"

	Set RemoteFile = reg.Execute(t5)
	Dim a_RemoteUrl(), n, i, bRepeat
	n = 0
	' 转入无重复数据
	For Each RemoteFileurl in RemoteFile
		If n = 0 Then
			n = n + 1
			Redim a_RemoteUrl(n)
			a_RemoteUrl(n) = RemoteFileurl
		Else
			bRepeat = False
			For i = 1 To UBound(a_RemoteUrl)
				If UCase(RemoteFileurl) = UCase(a_RemoteUrl(i)) Then
					bRepeat = True
					Exit For
				End If
			Next
			If bRepeat = False Then
				n = n + 1
				Redim Preserve a_RemoteUrl(n)
				a_RemoteUrl(n) = RemoteFileurl
			End If
		End If		
	Next
	Dim nFileNum,sOriginalFileName,sSaveFileName,sPathFileName,sContentPath
	nFileNum = 0
	For i = 1 To n
		SaveFileType = Mid(a_RemoteUrl(i), InstrRev(a_RemoteUrl(i), ".") + 1)
		SaveFileName = GetRndFileName(SaveFileType)
		IF SaveRemoteFile(SaveFileName,a_RemoteUrl(i),t1,t2,t3,t4,True)=True Then
			nFileNum = nFileNum + 1
			If nFileNum>0 Then
				sOriginalFileName = sOriginalFileName & "|"
				sSaveFileName = sSaveFileName & "|"
				sPathFileName = sPathFileName & "|"
			End If
			sOriginalFileName = sOriginalFileName & Mid(a_RemoteUrl(i), InstrRev(a_RemoteUrl(i), "/") + 1)
			sSaveFileName = sSaveFileName & SaveFileName
			sPathFileName = sPathFileName & sContentPath & SaveFileName
			
			t5 =Re(t5,a_RemoteUrl(i),t6&SaveFileName)
		End If
	Next
	ReplaceRemoteUrl=t5
End Function

Function SaveRemoteFile(ByVal t0,ByVal t1,ByVal t2,ByVal t3,ByVal t4,ByVal t5,ByVal t6)
	't0为生成的本地文件
	't1为远程文件
	't2为限制文件大小,为0时不限制
	't3为限制的文件类型
	't4为上传目录,为空时为系统目录
	't5为是否水印,只有系统开启水印才生效
	't6返回值,True为是否,False为图片值
	Dim t7
	IF t6 Then SaveRemoteFile=False
	t7=Get_Filetxt(t0)
	IF Instr(Lcase(t3),Lcase(t7))=0 Then
		IF t6 Then
			SaveRemoteFile=False
		Else
			SaveRemoteFile=t1
		End IF
		Exit Function
	End IF
	IF Len(t4)=0 Then
		t4=UploadDir("")
	Else
		t4=sdcms_root&t4&"/"&Year(Now())&Right("0"&Month(Now()),2)&"/"
	End IF
	Create_Folder(Left(t4,(Len(t4)-1)))
	On Error Resume Next
	Dim Retrieval,GetRemoteData
	Set Retrieval=Server.CreateObject("Micro"&"soft"&"."&"XML"&"HTTP")
	With Retrieval
		.Open "Get",t1,False,"",""
		.Send
		GetRemoteData=.ResponseBody
	End With
	Set Retrieval=Nothing
		IF Clng(t2)>0 Then
			IF Clng(Round(LenB(GetRemoteData)/1024))>Clng(t2) Then
				IF t6 Then
					SaveRemoteFile=False
				Else
					SaveRemoteFile=t1
				End IF
				Exit Function
			End IF
		End IF
		Dim Ads
		Set Ads=Server.CreateObject("ado"&"db"&"."&"str"&"eam")
		With Ads
			.Type = 1
			.Open
			.Write GetRemoteData
			.SaveToFile Server.MapPath(t4&t0), 2
			.Cancel()
			.Close()
		End With
		Set Ads=nothing
		IF Clng(t5)=1 Then
			IF Check_ispic(t7)=1 Then'只有图片才水印
				IF Sdcms_Jpeg_t0 Then
					Sdcms_Jpeg(t4&t0)
				End IF
			End IF
		End IF
	IF Err.Number=0 Then
		IF t6 Then
			SaveRemoteFile=True
		Else
			SaveRemoteFile=t4&t0
		End IF
	Else
		IF t6 Then
			SaveRemoteFile=False
		Else
			SaveRemoteFile=t1
		End IF
		Err.Clear
	End If
	t4=""
End Function

Function GetRndFileName(ByVal t0)
	Dim sRnd
	Randomize
	sRnd=Int(900*Rnd)+100
	GetRndFileName=Year(Now)&Month(Now)&Day(Now)&Hour(Now)&Minute(Now)&Second(Now)&sRnd&"."&t0
End Function

Function Add_tags(ByVal t0)
	Dim tags,i,sql
	t0=Split(t0,",")
	For i=0 to Ubound(t0)
		IF Len(Trim(t0(i)))>0 Then
			Set tags=Server.CreateObject("adodb.recordset")
			Sql="Select title,followid From Sd_tags where title='"&Trim(t0(i))&"'"
			tags.Open Sql,Conn,1,3
			DbQuery=DbQuery+1
			IF tags.Eof Then
				tags.Addnew
				tags(0)=Trim(t0(i))
				tags(1)=1
			Else
				tags.Update
				tags(1)=tags(1)+1
			End IF
			tags.Update
			tags.Close
			Set tags=Nothing
		End IF
	Next
End Function

Function Lost_tags(ByVal t0)
	Dim I,Tags,Sql
	IF Not IsNull(t0) Or Len(t0)=0 Then
		t0=Split(t0,",")
		For I=0 to Ubound(t0)
			IF Len(trim(t0(I)))>0 Then
				Set tags=Server.CreateObject("adodb.recordset")
				Sql="Select Title,Followid From Sd_Tags where title='"&Trim(t0(i))&"'"
				tags.Open Sql,Conn,1,3
				DbQuery=DbQuery+1
				IF Not tags.Eof Then
					IF tags(1)>1 Then
						tags.Update
						tags(1)=tags(1)-1
						tags.Update
					Else
						tags.Delete
					End IF
				End IF
				tags.Close
				Set tags=Nothing
			End IF
		Next
	End IF
End Function

Function Get_Category(ByVal t0)
	Dim t1:t1=Get_Class_Array	
	IF Not IsArray(t1) Then
		Get_Category=""
	Else
		CateTree 0,t1
		Get_Category=Cate_Tree
	End IF
	Get_Category=Cate_Tree
End Function

Dim Cate_Tree
Sub CateTree(ByVal t0,ByVal t1)
	Dim Class_Array,I,J,Rows,t2
	Class_Array=t1
	Rows=UBound(Class_Array,2)
	For I=0 To Rows
		IF Class_Array(3,I)=t0 Then
			For J=0 To Class_Array(2,I)-1
				Cate_Tree=Cate_Tree&"　"
			Next
			Select Case Sdcms_Mode
				Case "0":t2=Sdcms_Root&"Info/?id="&Class_Array(0,I)
				Case "1":t2=Sdcms_Root&"Info/"&Class_Array(0,I)&Sdcms_Filetxt
				Case Else:t2=sdcms_root&sdcms_htmdir&Class_Array(5,I)
			End Select
			Cate_Tree=Cate_Tree&IIF(Class_Array(3,I)>0,"└ ","")&"<a href="""&t2&""">"&Class_Array(1,I)&"</a><br>"
			CateTree Class_Array(0,I),t1
		End IF
	Next
End Sub

'=====================================
'获取某ID的所有子类别
'=====================================
Function Get_Son_Classid(ByVal Classid)
	Dim Rs_Get
	IF Sdcms_Cache Then
		IF Check_Cache("Get_Son_Classid"&classid) Then
			DbOpen
			Set Rs_Get=Conn.Execute("select allclassid from sd_class where id="&classid&"")
			DbQuery=DbQuery+1
			IF Rs_Get.Eof Then Create_Cache "Get_Son_Classid"&classid,0 Else Create_Cache "Get_Son_Classid"&classid,Rs_Get(0)
			Rs_Get.Close
			Set Rs_Get=Nothing
		End IF
		Get_Son_Classid=Load_Cache("Get_Son_Classid"&classid)
	Else
		Set Rs_Get=Conn.Execute("select allclassid from sd_class where id="&classid&"")
		DbQuery=DbQuery+1
		IF Rs_Get.Eof Then Get_Son_Classid=0 Else Get_Son_Classid=Rs_Get(0)
		Rs_Get.Close
		Set Rs_Get=Nothing
	End IF
End Function

Function Sitelinks(ByVal t0)
	Dim LinkDat
	IF Sdcms_Cache Then
		IF Check_Cache("Site_links") Then
			Dim Rs
			Set Rs=Conn.Execute("select title,siteurl,linktype,content,replacenum from sd_sitelink where ispass=1 order by ordnum desc")
			DbQuery=DbQuery+1
			IF Not Rs.Eof Then
				Create_Cache "Sitelinks",Rs.GetRows()
			Else
				Sitelinks=t0:Exit Function
			End IF
			Rs.Close
			Set Rs=Nothing
		End IF
		LinkDat=Load_Cache("Sitelinks")
	Else
		Set Rs=Conn.Execute("Select title,siteurl,linktype,content,replacenum from sd_sitelink where ispass=1 order by ordnum desc")
		DbQuery=DbQuery+1
		IF Not Rs.Eof Then
			LinkDat=Rs.GetRows()
		Else
			Sitelinks=t0:Exit Function
		End IF
		Rs.Close
		Set Rs=Nothing
	End IF
	IF Not Isarray(LinkDat) Then
		Sitelinks=t0:Exit Function
	End IF
	Dim I,Url,t1
	For I=0 to UBound(LinkDat,2)
		IF LinkDat(2,i)=1 Then 
			Url="<a href="""&LinkDat(1,i)&""" title="""&LinkDat(3,i)&""" target=""_blank"" class=""sitelink"">"&LinkDat(0,i)&"</a>" 
		Else 
			Url="<a href="""&LinkDat(1,i)&""" title="""&LinkDat(3,i)&""" class=""sitelink"">"&LinkDat(0,i)&"</a>"
		End if
		IF LinkDat(4,i)=0 Then
			t1=-1
		Else
			t1=LinkDat(4,i)
		End IF
		t0=Site_Link(t0,LinkDat(0,i),Url,t1)
	Next
	Sitelinks=t0
End Function

Function Site_Link(ByVal t0,ByVal t1,ByVal t2,ByVal t3)
	Dim t4,Regs,Matches,Match
	t4=t0
	Set Regs=New Regexp
	Regs.Global=True
	Regs.IgnoreCase=True
	Regs.Pattern="(\<a[^<>]+\>.+?\<\/a\>)|(\<img[^<>]+\>)"
	Set Matches=Regs.Execute(t4)
	Dim I
	I=0
	Dim MyArray()
	IF Matches.Count>0 Then
		For Each Match In Matches
			ReDim Preserve MyArray(I)
			MyArray(I)=Mid(Match.Value,1,Len(Match.Value))
			t4=Replace(t4,Match.Value,"["&I&"]",1,t3)
			i=i+1
		Next
	End IF
	IF I=0 Then
		t0=Replace(t0,t1,t2,1,t3)
		site_link=t0
		Exit Function
	End IF
	t4=Replace(t4,t1,t2,1,t3)
	For I=0 To Ubound(MyArray)
		t4=Replace(t4,"["&I&"]",MyArray(I),1,t3)
	Next
	Set Regs=Nothing
	site_link=t4
End Function

Function UbbCode(ByVal t0)
	Dim QuoteCode_01,QuoteCode_02,QuoteCode_03,Runcode,Flvcode_01,Flvcode_02,Flvcode_03,Flvcode_04,Flvcode_05,Flvcode_06,Ubb,Temp,Matches,Matchs,Match
	IF Len(t0)=0 Then UbbCode="":Exit Function
	QuoteCode_01="<div class=""Quotetitle"">"
	QuoteCode_02="</div><div class=""QuoteCode"">"
	QuoteCode_03="</div>"
	
	Runcode="<div class=""RunCodes""><textarea>{$Code}</textarea><input onclick=""runcode(this)"" type=""button"" value=""运行代码"">"
	Runcode=Runcode&"<input onclick=""copycode(this)"" type=""button"" value=""复制代码"">"
	Runcode=Runcode&"<input onclick=""savecode(this)"" type=""button"" value=""另存代码""><span>提示：复制和保存代码功能在FF下无效。</span></div>"
	
	'Flvcode_01="<div align=""center""><EMBED src="&sdcms_root&"Plug/Flv.swf width="
	'Flvcode_02=" height="

	'Flvcode_03=" type=application/x-shockwave-flash flashvars=""xml=&#13;&#10;&#13;&#10;{vcastr}{channel}{item}{source}"
	
	'Flvcode_04="{/source}&#13;&#10;&#13;&#10;{/item}{/channel}{config}{controlPanelBgColor}52479{/controlPanelBgColor}{isLoadBegin}false{/isLoadBegin}"
	'Flvcode_04=Flvcode_04&"{/config}{/vcastr}"" allowFullScreen=""true"" quality=""high"" wmode=""opaque""></div>"
	'新播放器
	Flvcode_01="<div align=""center""><embed quality=""high"" pluginspage=""http://www.macromedia.com/go/getflashplayer"" type=""application/x-shockwave-flash"" width="""
	Flvcode_02=""" height="""
	Flvcode_03=""" src="""&sdcms_root&"Plug/Flv.swf?CuPlayerImage=&CuPlayerShowImage=true&CuPlayerWidth="
	Flvcode_04="&CuPlayerHeight="
	Flvcode_05="&CuPlayerAutoPlay=true&CuPlayerAutoRepeat=false&CuPlayerShowControl=true&CuPlayerAutoHideControl=false&CuLogo=&CuPlayerFile="
	Flvcode_06=""" allowFullScreen=""true""></embed></div>"
	
	Set Ubb=New Regexp
		Set Temp=New Templates
		Ubb.Ignorecase=True
		Ubb.Global=True	
		
		Ubb.Pattern="\[quote([\s\S]+?)\]"
		Set Matchs=Ubb.Execute(t0)
		For Each Match In Matchs
			Dim Tag_title
			Tag_title=Temp.Getlable(Match.SubMatches(0),"title")
			t0=Replace(t0,Match.value,QuoteCode_01&Tag_title&QuoteCode_02)
		Next
		
		Ubb.Pattern="\[\/quote\]"
		t0=Ubb.replace(t0,QuoteCode_03)

		Ubb.Pattern="\[code\][\s\n]*\[\/code\]"
		t0=Ubb.replace(t0,"")
		
		Ubb.Pattern="\[\/code\]"
		t0=Ubb.replace(t0,Chr(1)&"/code]")
		
		Ubb.Pattern="\[code\]([^\x01]*)\x01\/code\]"
		Set Matches=Ubb.Execute(t0)
		Ubb.Global=False
		For Each Match In matches
			Dim CodeStr
			CodeStr=Match.SubMatches(0)
			CodeStr=Replace(CodeStr,"&nbsp;",Chr(32),1,-1,1)
			CodeStr=Replace(CodeStr,"<p>","",1,-1,1)
			CodeStr=Replace(CodeStr,"</p>","&#13;&#10;",1,-1,1)
			CodeStr=Replace(CodeStr,"<br/>","&#13;&#10;",1,-1,1)
			CodeStr=Replace(CodeStr,"<br>","&#13;&#10;",1,-1,1)
			CodeStr=Replace(CodeStr,"<br />","&#13;&#10;",1,-1,1)
			CodeStr=Replace(CodeStr,vbNewLine,"&#13;&#10;",1,-1,1)
			CodeStr=Replace(Runcode,"{$Code}",CodeStr)
			t0=Ubb.Replace(t0,CodeStr)
		Next
		Ubb.Global=true
		Ubb.Pattern="\x01\/code\]"
		t0=Ubb.Replace(t0,"[/code]")
		
		Ubb.Pattern="\[Flv([\s\S]+?)\]"
		Set Matchs=Ubb.Execute(t0)
		For Each Match In Matchs
			Dim Tag_width,Tag_height
			Tag_width=Temp.Getlable(Match.SubMatches(0),"width")
			Tag_height=Temp.Getlable(Match.SubMatches(0),"height")
			if Tag_width="" then Tag_width=400
			if Tag_height="" then Tag_height=300

			t0=Replace(t0,Match.value,Flvcode_01&Tag_width&Flvcode_02&Tag_height&Flvcode_03&Tag_width&Flvcode_04&Tag_height&Flvcode_05)
			
		Next
		Set Matches=Nothing
		Ubb.Pattern="\[\/Flv\]"
		t0=Ubb.Replace(t0,Flvcode_06)
		Set Temp=Nothing
	Set Ubb=Nothing
	UbbCode=t0
End Function

Function Get_Tags(ByVal t0)
	IF Len(t0)=0 Or IsNull(t0) Then
		Get_Tags=""
		Exit Function
	End IF
	t0=Split(t0,",")
	Get_Tags=""
	Dim I
	For I=0 To Ubound(t0)
		IF Len(Trim(t0(I)))>0 Then
			Select Case Sdcms_Mode
				Case "1"
				Get_Tags=Get_Tags&" "&"<a href="""&sdcms_root&"tags/"&Server.URLEncode(Trim(t0(i)))&Sdcms_FileTxt&""" target=""_blank"">"&Trim(t0(i))&"</a>"
				Case Else
				Get_Tags=Get_Tags&" "&"<a href="""&sdcms_root&"tags/?/"&Server.URLEncode(Trim(t0(i)))&"/"" target=""_blank"">"&Trim(t0(i))&"</a>"
			End Select
		End IF
	Next
	Get_Tags=Mid(Get_Tags,2)
End Function

'=====================================
'获取模板路径
'=====================================
Function Load_Temp_Dir
	Load_Temp_Dir=Sdcms_Root&"Skins/"&Sdcms_Skins_Root&"/"
End Function

'=====================================
'获取模板配置信息
'=====================================
Function Sdcms_Skin_Author
	IF Sdcms_Cache Then
		IF Check_Cache("Sdcms_Skin_Author") Then
			Create_Cache "Sdcms_Skin_Author",Sdcms_Skin_Author_Cache
		End IF
		Sdcms_Skin_Author=Load_Cache("Sdcms_Skin_Author")
	Else
		Sdcms_Skin_Author=Sdcms_Skin_Author_Cache
	End IF
End Function

Function Sdcms_Skin_Author_Cache
	Dim Title,Author,WebSite,Xml
	IF Check_File(Load_temp_dir&"Skin.Xml") Then
		Set Xml=Server.CreateObject("Microsoft.XmlDom")
		With Xml
			.async=False
			.Load(Server.MapPath(Load_temp_dir&"Skin.Xml"))
			Title=.documentElement.childNodes(0).text
			Author=.documentElement.childNodes(2).text
			Website=.documentElement.childNodes(3).text
		End With
		Set Xml=Nothing
	Else
		Title="未知"
		Author="Sdcms.Cn"
		Website="Http://www.Sdcms.cn"
	End IF
	Sdcms_Skin_Author_Cache="<a href="""&Website&""" title=""作者："&Author&""" target=""_blank"">"&Title&"</a>"
End Function

Function LoadRecord(ByVal t0,ByVal t1,ByVal t2)
	IF Sdcms_Cache Then
		IF Check_Cache("LoadRecord_"&t0&t1) Then
			Create_Cache "LoadRecord_"&t0&t1,LoadRecord_Cache(t0,t1,t2)
		End IF
		LoadRecord=Load_Cache("LoadRecord_"&t0&t1)
	Else
		LoadRecord=LoadRecord_Cache(t0,t1,t2)
	End IF
End Function

Function LoadRecord_Cache(ByVal t0,ByVal t1,ByVal t2)
	On Error Resume Next
	LoadRecord_Cache=Conn.Execute("Select "&t0&" From "&t1&" Where Id="&t2&"")(0)
	DbQuery=DbQuery+1
	IF Err Then Echo "LoadRecord("&t0&","&t1&","&t2&",)："&Err.Description&"<br>":Err.Clear
End Function

'=====================================
'获取网站配置
'=====================================
Function Get_Website_Config
	IF Sdcms_Cache Then
		IF Check_Cache("Get_Website_Config") Then
			Create_Cache "Get_Website_Config",Get_Website_Config_Cache
		End IF
		Get_Website_Config=Load_Cache("Get_Website_Config")
	Else
		Get_Website_Config=Get_Website_Config_Cache
	End IF
End Function

Function Get_Website_Config_Cache
	Dim Rs
	Set Rs=Conn.Execute("Select Webkey,Webdec From Sd_Const Where ID=1")
	IF Rs.Eof Then
		Get_Website_Config_Cache=""
	Else
		Get_Website_Config_Cache=Rs.GetRows()
	End IF
	Rs.Close
	Set Rs=Nothing
	DbQuery=DbQuery+1
End Function

Function Load_Freelabel
	IF Sdcms_Cache Then
		IF Check_Cache("Load_Freelabel") Then
			Create_Cache "Load_Freelabel",Custome_Label
		End IF
		Load_Freelabel=Load_Cache("Load_Freelabel")
	Else
		Load_Freelabel=Custome_Label
	End IF
End Function

Function Custome_Label
	DbOpen
	Dim Rs
	Set Rs=Conn.Execute("Select title,content From Sd_Label Where Ispass=1")
	IF Rs.Eof Then
		Custome_Label=""
	Else
		Custome_Label=Rs.GetRows()
	End IF
	Rs.Close
	Set Rs=Nothing
	DbQuery=DbQuery+1
End Function

'=====================================
'读取分类数组
'=====================================
Function Get_Class_Array()
	Dim Rs_Array
	DbOpen
	Set Rs_Array=Conn.Execute("Select Id,Title,Depth,Followid,Class_Type,ClassUrl From Sd_Class Order By Ordnum,ID")
	DbQuery=DbQuery+1
	IF Rs_Array.Eof Then
		Get_Class_Array=""
	Else
		Get_Class_Array=Rs_Array.GetRows()
	End IF
	Rs_Array.Close
	Set Rs_Array=Nothing
	DbQuery=DbQuery+1
End Function

'=====================================
'分解分类数组，并打印
'=====================================
Function Get_Class(ByVal t0)
	Dim t1:t1=Get_Class_Array	
	IF Not IsArray(t1) Then
		Get_Class=""
	Else
		Print_Class 0,t0,t1
		Get_Class=PrintClass
	End IF
End Function

Dim PrintClass
Sub Print_Class(ByVal t0,ByVal t1,ByVal t2)
	Dim Class_Array,I,J,Rows
	Class_Array=t2
	Rows=UBound(Class_Array,2)
	For I=0 To Rows
		IF Class_Array(3,I)=t0 Then
			PrintClass=PrintClass&"<option value="""&Class_Array(0,I)&""" "&IIF(Class_Array(0,I)=t1,"selected","")&">"
				For J=0 To Class_Array(2,I)-1
					PrintClass=PrintClass&"　"
				Next
			PrintClass=PrintClass&IIF(Class_Array(3,I)>0,"└","")&Class_Array(1,I)&"</option>"
			Print_Class Class_Array(0,I),t1,t2
		End IF
	Next
End Sub

'=====================================
'网站地图
'=====================================
Function ShowMap
	Dim t1:t1=Get_Class_Array	
	IF Not IsArray(t1) Then
		ShowMap=""
	Else
		ClassTree 0,t1
		ShowMap=Class_Tree
	End IF
	ShowMap=Class_Tree
End Function

Dim Class_Tree
Sub ClassTree(ByVal t0,ByVal t1)
	Dim Class_Array,I,J,Rows,t2
	Class_Array=t1
	Rows=UBound(Class_Array,2)
	For I=0 To Rows
		IF Class_Array(3,I)=t0 Then
			For J=0 To Class_Array(2,I)-1
				Class_Tree=Class_Tree&"　"
			Next
			Select Case Sdcms_Mode
				Case "0":t2=Sdcms_Root&"Info/?id="&Class_Array(0,I)
				Case "1":t2=Sdcms_Root&"html/"&Class_Array(5,I)
				Case Else:t2=sdcms_root&sdcms_htmdir&Class_Array(5,I)
			End Select
			Class_Tree=Class_Tree&IIF(Class_Array(3,I)>0,"└ ","")&"<a href="""&t2&""">"&Class_Array(1,I)&"</a>　<a href="""&sdcms_root&"plug/rss/?id="&Class_Array(0,I)&"""><img src="""&sdcms_root&"editor/rss.gif"" alt=""订阅RSS"" align=""absmiddle"" vspace=""4"" border=""0"" /></a><br>"
			ClassTree Class_Array(0,I),t1
		End IF
	Next
End Sub

Sub Custom_HtmlName(ByVal t0,ByVal t1,ByVal t2,ByVal t3)
	IF Instr(Lcase(t0),Lcase("{ID}"))>0 Then
		Conn.Execute("Update "&t1&" Set HtmlName='"&Replace(Lcase(t0),Lcase("{ID}"),t3)&"' Where ID="&t3&"")
	End IF
	IF Instr(Lcase(t0),Lcase("{PinYin}"))>0 Then
		Dim P,NewName
		Set P=New Get_Pinyin
		NewName=P.Pinyin(t2)
		Set P=Nothing
		Conn.Execute("Update "&t1&" Set HtmlName='"&Replace(Lcase(t0),Lcase("{PinYin}"),Left(NewName,50))&"' Where ID="&t3&"")
	End IF
	IF Instr(Lcase(t0),Lcase("{YYMMDDID}"))>0 Then
		Dim This_Name:This_Name=Sdcms_Date&t3
		Conn.Execute("Update "&t1&" Set HtmlName='"&Replace(Lcase(t0),Lcase("{YYMMDDID}"),This_Name)&"' Where ID="&t3&"")
	End IF
End Sub

Sub Sdcms_Jpeg(ByVal t0)
	IF Not IsObjInstalled("Persits.Jpeg") Or Not Sdcms_Jpeg_t0 Then Exit Sub
	IF Check_ispic(t0)=0 Then Exit Sub
	Dim AspJpeg
	Set AspJpeg=Server.CreateObject("Persits.Jpeg")
	IF AspJpeg.Expires<Now Then Exit Sub
	AspJpeg.Open Trim(Server.MapPath(t0))
	IF AspJpeg.OriginalWidth>Sdcms_Jpeg_t12(0)*2 Then
		IF Sdcms_Jpeg_t1 Then
			IF Len(Sdcms_Jpeg_t3)>0 And Len(Sdcms_Jpeg_t6)>0 Then
				Dim LogoWidth,LogoHeight,iLeft,iTop
				LogoWidth=(Sdcms_Jpeg_t5+1)*GetStrLen(Sdcms_Jpeg_t3)/2
				LogoHeight=Sdcms_Jpeg_t5+1

				iLeft=GetPosition_X(AspJpeg.OriginalWidth, LogoWidth, Sdcms_Jpeg_t12(0))
				iTop=GetPosition_Y(AspJpeg.OriginalHeight, LogoHeight, Sdcms_Jpeg_t12(1))
				
				AspJpeg.Canvas.Font.COLOR=Sdcms_Jpeg_t6         ' 文字的颜色
				AspJpeg.Canvas.Font.Family=Sdcms_Jpeg_t4         ' 文字的字体
				AspJpeg.Canvas.Font.Size=Sdcms_Jpeg_t5          ' 文字的大小
				AspJpeg.Canvas.Font.Bold=Sdcms_Jpeg_t7              ' 文字是否粗体
				AspJpeg.Canvas.Font.Quality=4                              ' Antialiased
				AspJpeg.Canvas.PrintText iLeft,iTop,Sdcms_Jpeg_t3         ' 加入文字及坐标位置
				AspJpeg.Canvas.Pen.COLOR=&H0               ' 边框的颜色
				AspJpeg.Canvas.Pen.Width=1                 ' 边框的粗细
				AspJpeg.Canvas.Brush.Solid=False           ' 图片边框内是否填充颜色
				AspJpeg.Quality=Sdcms_Jpeg_t2
				AspJpeg.Save Server.MapPath(t0)     ' 生成文件
			End IF
		Else
			Dim Fso
			Set Fso=CreateObject("Scrip"&"ting."&"File"&"System"&"Object")
			IF Not Fso.FileExists(Server.MapPath(Sdcms_Jpeg_t8)) Then
				Exit Sub
			End IF
			Set Fso=Nothing
			Dim AspJpeg2
			Set AspJpeg2=Server.CreateObject("Persits.Jpeg")
			AspJpeg2.Open Server.MapPath(Sdcms_Jpeg_t8)  '打开水印图片
			iLeft=GetPosition_X(AspJpeg.OriginalWidth,AspJpeg2.Width,Sdcms_Jpeg_t12(0))
			iTop=GetPosition_Y(AspJpeg.OriginalHeight,AspJpeg2.Height,Sdcms_Jpeg_t12(1))
			
			IF Sdcms_Jpeg_t10="" Then
				AspJpeg.DrawImage iLeft,iTop,AspJpeg2,Sdcms_Jpeg_t9,100
			Else
				AspJpeg.DrawImage iLeft,iTop,AspJpeg2,Sdcms_Jpeg_t9,Sdcms_Jpeg_t10,100
			End IF
			AspJpeg.Quality=Sdcms_Jpeg_t2
			AspJpeg.Save Server.MapPath(t0)
			Set AspJpeg2=Nothing	
		End IF
	End IF
	Set AspJpeg= Nothing
End Sub

Sub Jpeg_Thumb(ByVal t0)
	IF Not IsObjInstalled("Persits.Jpeg") Or Not Sdcms_Jpeg_t0 Then Exit Sub
	IF Check_ispic(t0)=0 Then Exit Sub
	Dim AspJpeg,AspJpeg2,bl_h,bl_w
	Set AspJpeg=Server.CreateObject("Persits.Jpeg")
	Set AspJpeg2=Server.CreateObject("Persits.Jpeg")
	IF AspJpeg.Expires<Now Then Exit Sub
	AspJpeg.Open Trim(Server.MapPath(t0))
	AspJpeg2.Open Trim(Server.MapPath(t0))	
	bl_w=Sdcms_Jpeg_t13/AspJpeg.OriginalWidth
	bl_h=Sdcms_Jpeg_t14/AspJpeg.OriginalHeight
	IF Sdcms_Jpeg_t13>0 Then
		IF Sdcms_Jpeg_t14>0 Then
			Select Case Sdcms_Jpeg_t15
			Case "0"   '常规算法：宽度和高度都大于0时，直接缩小成指定大小，其中一个为0时，按比例缩小
				IF bl_w<1 Or bl_h<1 Then
					AspJpeg.Width=Sdcms_Jpeg_t13
					AspJpeg.Height=Sdcms_Jpeg_t14
					AspJpeg.Quality=Sdcms_Jpeg_t2
					AspJpeg.save Server.MapPath(t0)
				End IF
			Case "1"    '裁剪法：宽度和高度都大于0时，先按最佳比例缩小再裁剪成指定大小，其中一个为0时，按比例缩小
				IF bl_w<1 Or bl_h<1 Then
					If bl_w<bl_h Then
						AspJpeg.Height=Sdcms_Jpeg_t14
						AspJpeg.Width=Round(AspJpeg.OriginalWidth * bl_h)   '按缩小成大比例者
					Else
						AspJpeg.Width=Sdcms_Jpeg_t13
						AspJpeg.Height=Round(AspJpeg.OriginalHeight * bl_w)
					End IF
					AspJpeg.Crop 0, 0, Sdcms_Jpeg_t13, Sdcms_Jpeg_t14
					AspJpeg.Quality=Sdcms_Jpeg_t2
					AspJpeg.Save Server.MapPath(t0)
				End IF
			Case "2"  '补充法：在指定大小的背景图上附加上按最佳比例缩小的图片
				'创建一个指定大小的背景图
				AspJpeg2.Width=Sdcms_Jpeg_t13
				AspJpeg2.Height=Sdcms_Jpeg_t14
				AspJpeg2.Canvas.Brush.Solid=True            ' 图片边框内是否填充颜色
				AspJpeg2.Canvas.Brush.COLOR="&HFFFFFF"  '设定背景颜色
				AspJpeg2.Canvas.Bar -1, -1, AspJpeg2.Width+1, AspJpeg2.Height+1 '填充

				'按最佳比例缩小图片
				IF bl_w>bl_h Then
					IF bl_h<1 Then
						AspJpeg.Height=Sdcms_Jpeg_t14
						AspJpeg.Width=Round(AspJpeg.OriginalWidth*bl_h)   '按缩小成小比例者
					End IF
				Else
					IF bl_w<1 Then
						AspJpeg.Width=Sdcms_Jpeg_t13
						AspJpeg.Height=Round(AspJpeg.OriginalHeight*bl_w)
					End IF
				End IF

				'得到缩略图的坐标
				iLeft=(AspJpeg2.Width-AspJpeg.Width)/2
				iTop=(AspJpeg2.Height-AspJpeg.Height)/2
				AspJpeg2.DrawImage iLeft,iTop,AspJpeg   '将缩略图附加到背景上
				AspJpeg2.Quality=Sdcms_Jpeg_t2
				AspJpeg2.Save Server.MapPath(t0)
			End Select

		Else
			IF bl_w<1 Then
				AspJpeg.Width=Sdcms_Jpeg_t13
				AspJpeg.Height=Round(AspJpeg.OriginalHeight*bl_w)
				AspJpeg.Quality=Sdcms_Jpeg_t2
				AspJpeg.Save Server.MapPath(t0)
			End IF
		End If

	Else
		IF Sdcms_Jpeg_t14>0 And bl_h<1 Then
			AspJpeg.Height=Sdcms_Jpeg_t14
			AspJpeg.Width=Round(AspJpeg.OriginalWidth*bl_h)
			AspJpeg.Quality=Sdcms_Jpeg_t2
			AspJpeg.Save Server.MapPath(t0)
		End IF
	End If
	Set AspJpeg=Nothing
	Set AspJpeg2=Nothing
End Sub

Function GetPosition_X(ByVal t0,ByVal t1,ByVal t2)
    Select Case Sdcms_Jpeg_t11
		Case 0:GetPosition_X=t2'左上
		Case 1:GetPosition_X=t2'左下
		Case 2:GetPosition_X=(t0-t1)/2'居中
		Case 3:GetPosition_X=t0-t1-t2'右上
		Case 4:GetPosition_X=t0-t1-t2'右下
		Case Else:GetPosition_X=0'不显示
	End Select
End Function

Function GetPosition_Y(ByVal t0,ByVal t1,ByVal t2)
    Select Case Sdcms_Jpeg_t11
		Case 0:GetPosition_Y=t2'左上
		Case 1:GetPosition_Y=t0-t1-t2'左下
		Case 2:GetPosition_Y=(t0-t1)/2'居中
		Case 3:GetPosition_Y=t2'右上
		Case 4:GetPosition_Y=t0-t1-t2'右下
		Case Else:GetPosition_Y=0'不显示
    End Select
End Function

Function GetStrLen(ByVal t0)
    On Error Resume Next
	Dim L,C,WINNT_CHINESE,T,I
    WINNT_CHINESE=(Len("中国")=2)
    IF WINNT_CHINESE Then
        L=Len(t0)
        T=l
        For I=1 To L
            C=Asc(Mid(t0,I,1))
            IF C<0 Then C=C+65536
            IF C>255 Then
                T=T+1
            End IF
        Next
        GetStrLen=T
    Else
        GetStrLen=Len(t0)
    End IF
    IF Err.Number<>0 Then Err.Clear
End Function
%>