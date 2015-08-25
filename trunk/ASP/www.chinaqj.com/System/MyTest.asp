<!--#include file="../Include/GetUserInfo.asp" -->
<%
'===============================================
'
'	测试专用
'
'===============================================
	Dim Conn, ConnStr
	Set Conn = Server.CreateObject("Adodb.Connection")
	ConnStr = "Provider = Microsoft.Jet.OLEDB.4.0;Data Source = "&Server.MapPath("/Database/#%@ChinaQJCMSV6_2012@%#.mdb")
	Conn.Open ConnStr
	If Err Then
		Err.Clear
		Set Conn = Nothing
		Response.Write("连接数据库出错!")
		Response.End
	End If

	'=======================================
	'	SQL 查询
	'	sql	sql语句
	'======================================
	Function SQL_Query(Conn,sql)
		Dim DataDiction, rs
		Set DataDiction=Server.CreateObject("Scripting.Dictionary")
		Set rs = server.createobject("adodb.recordset")
		rs.open sql,Conn,0,1
		If rs.eof Then 
			
		Else
			Dim dai
				dai=0
			Do While Not rs.eof
				c=rs.Fields.count
				Dim data
				Set data=Server.CreateObject("Scripting.Dictionary")
				For i=0 To (c-1)
					data.Add ""&rs.Fields(i).Name&"",""&rs(rs.Fields(i).Name)&""
				Next
				DataDiction.Add ""&dai&"",data
				dai=dai+1
				Set data=Nothing
				rs.movenext
			Loop
		End If	
		rs.close
		Set SQL_Query=DataDiction
	End Function
	
	Dim fedc
		'fedc = ""

	Set fedc=Server.CreateObject("Scripting.Dictionary")
	fedc.Add "re","Red"
	fedc.Add "gr","Green"
	fedc.Add "bl","Blue"
	fedc.Add "pi","Pink"
	
	For Each Item in fedc
		Response.Write("<br />" & Item & " => " & fedc(Item))
	Next


	Response.end

	Dim sobjs
	Set sobjs=SQL_Query(Conn,"select * from ChinaQJ_News where ID=11110")
	
	If sobjs.Count Then
		For i=0 To sobjs.Count-1
			Response.write(sobjs(""&i&"")("NewsNameCh")&"<br />")
		Next
	Else
		Response.write("Null")
	End If
	
	For Each Item in Request.ServerVariables
		Response.Write("<br />" & Item & " => " & Request.ServerVariables(Item))
	Next

	'Dim obj
	'	obj=SQL_Query("select top 5 * from ChinaQJ_News")
	'If obj="" Then
	'	Response.write("Error: Null")
	'Else
	'	For i=0 To obj.Count-1
	'		Response.write(obj(""&i&"")("NewsNameCh")&"<br />")
	'	Next
	'End If 

	'Function BetaSQL()
	'	Dim rs
	'	Set rs = server.createobject("adodb.recordset")
	'	Dim strsql
	'		strsql="select top 5 * from ChinaQJ_News"
	'	rs.open strsql,Conn,0,1
	'	If rs.eof Then 
	'		Set BetaSQL=""
	'	Else
	'		Dim DataDiction
	'		Set DataDiction=Server.CreateObject("Scripting.Dictionary")
	'		Dim dai
	'			dai=0
	'		Do While Not rs.eof
	'			c=rs.Fields.count
	'			Dim data
	'			Set data=Server.CreateObject("Scripting.Dictionary")
	'			For i=0 To (c-1)
	'				data.Add ""&rs.Fields(i).Name&"",""&rs(rs.Fields(i).Name)&""
	'			Next
	'			DataDiction.Add ""&dai&"",data
	'			dai=dai+1
	'			Set data=Nothing
	'			rs.movenext
	'		Loop
	''		Set BetaSQL=DataDiction
	'	End If
		
	'	rs.close

	'End Function

	'Function ExecuteSQL(byref conn, byval txtSQL)
	'	dim rs
     '   set rs = Server.CreateObject("ADODB.Recordset")
      '  rs.open txtSQL,conn,1,1
		'If rs.eof Then 
		'	Set ExecuteSQL=""
'		Else
'			Dim DataDiction
'			Set DataDiction=Server.CreateObject("Scripting.Dictionary")
'			Dim dai
'				dai=0
'			Do While Not rs.eof
'				c=rs.Fields.count
'				Dim data
'				Set data=Server.CreateObject("Scripting.Dictionary")
'				For i=0 To (c-1)
'					data.Add ""&rs.Fields(i).Name&"",""&rs(rs.Fields(i).Name)&""
''				Next
'				DataDiction.Add ""&dai&"",data
'				dai=dai+1
'				Set data=Nothing
'				rs.movenext
'			Loop
'			set ExecuteSQL = DataDiction
'		End If
'		rs.close
'	End Function
'	

	Dim DataDiction
	Set DataDiction=Server.CreateObject("Scripting.Dictionary")
	
		
	'Response.write(DataDiction.Count)



	'Dim obj
	
'	'BetaSQL(obj)
'	Set obj=BetaSQL()
	'Set obj=ExecuteSQL(Conn,"select top 5 * from ChinaQJ_News")

	'Set obj=SQL_Query("select * from ChinaQJ_News where ID=100000")

	'If obj="" Then
	'	Response.Write("Null")
	'Else
	'	For i=0 To obj.Count-1
	'		Response.write(obj(""&i&"")("NewsNameCh")&"<br />")
	'	Next
	'End If
	
	
	Response.End
	
	'If obj="" Then
	'	Response.write("Error: Null")
	'Else
	'	For i=0 To obj.Count-1
	'		Response.write(obj(""&i&"")("NewsNameCh")&"<br />")
	'	Next
	'End If 

	Response.end

'====================================================================================================================
'
'	My Add New Function				Start...
'
'====================================================================================================================

'============================
'	记录日志函数(Beta)	[1]
'	FileCOn		日志内容
'==============================
Function MyLog(FileCon)
	On Error Resume Next	'-----------Error
	Dim FilePath,FileName
	FilePath = Request.ServerVariables("APPL_PHYSICAL_PATH") & "log\" & year(now()) & "\" & month(now()) & "\" & day(now()) & "\"
	Call MyLog_(FilePath,"MyLog.TxT",FileCon)
	If Err.Number<>0 Then
		Err.Clear
	End If
End Function

'======================================
'	记录日志函数(Beta)	[2]
'	FilePath	保存文件路径
'	FileName	保存文件名称
'	FileCon		文件内容
'=======================================
Function MyLog_(FilePath,FileName,FileCon)
	On Error Resume Next	'-----------Error
	If FilePath="" Then
		FilePath="F:\\Mylog\"
	End If
	If FileName="" Then
		FileName="MyLog.TxT"
	End If

	BetaVerifyFolder(FilePath)
		
	Dim Fs,Fname
	Set Fs = Server.CreateObject("Scripting.FileSystemObject")
	If Fs.FileExists(FilePath&FileName) = false Then 
		Set Fname = Fs.CreateTextFile(FilePath&FileName,true)
	Else
		Set Fname = Fs.OpenTextFile(FilePath&FileName,8,true)
	End If
	Fname.WriteLine(FileCon)
	Fname.Close
	Set Fname=Nothing
	Set Fs = Nothing
	If Err.Number<>0 Then
		Err.Clear
	End If
End Function

'======================================================
'	测试函数 验证目录是否存在,如果不存在则创建
'	StrPath		目录名称
'	无返回
'===================================================
Function BetaVerifyFolder(StrPath)
	On Error Resume Next	'-----------Error
	Dim Fs
	Set Fs = Server.CreateObject("Scripting.FileSystemObject")
	If Fs.FolderExists(StrPath) = false Then
		Dim tempPath
		Dim folderAry
			folderAry = Split(StrPath, "\")
		For i=0 to UBound(folderAry)-1
			If folderAry(i)<>"" Then
				If tempPath = "" Then 
					tempPath = folderAry(i)
				Else
					tempPath = tempPath&"\"&folderAry(i)
				End If
				If Fs.FolderExists(tempPath) = false Then
					Fs.CreateFolder(tempPath)
					'Response.write("Cl -> ")
				End If
				'Response.write(folderAry(i)&" -> Hello  -> "&tempPath&"<br />")
			End If
		Next
		'Response.write(StrPath)
		'Response.end
		'Fs.CreateFolder(StrPath)
	End If
	Set Fs = Nothing
	If Err.Number<>0 Then
		Err.Clear
	End If
End Function


	'Function TestFun(abc)
		
	'	Response.write("<hr /><center><h1>Hello</h1></center>")
	'	abc=array("a","b","c")
	'	TestFun="hello..........."

	'End Function 

	'Dim b
	'	b="bbbbbbbbbbbbbb"

	'ts=TestFun(b)
	
	'Response.write(b(1))
	'Response.write("  FUN: "&ts)

	'Response.write("<hr />")
	

	'Dim d
	'Set d=Server.CreateObject("Scripting.Dictionary")
	'd.Add "re","Red"
	'd.Add "gr","Green"
	'd.Add "bl","Blue"
	'd.Add "pi","Pink"
	'Response.Write("The value of key bl is: " & d.Item("bl"))


	'Dim myRs
	'Set myRs = server.createobject("adodb.recordset")
	'Dim myStrSql
	'	myStrSql="select top 5 * from ChinaQJ_News"
	'myRs.open myStrSql,Conn,0,1
		
	'If myRs.eof Then 
	'	Response.write("Error")
	'Else
	'	Dim DataDiction
	'		Set DataDiction=Server.CreateObject("Scripting.Dictionary")
	'	Dim dai
	'		dai=0
	'	Do While Not myRs.eof
	'		c=myRs.Fields.count
			'Response.Write(myRs("ID"))
			'Response.write("<hr />")
	'		Dim data
	'		Set data=Server.CreateObject("Scripting.Dictionary")
	'		For i=0 To (c-1)
				'data.Add myRs.Fields(i).Name,myRs(myRs.Fields(i).Name)
	'			data.Add ""&myRs.Fields(i).Name&"",""&myRs(myRs.Fields(i).Name)&""
				'Response.write(myRs.Fields(i).Name&" -> "&myRs(myRs.Fields(i).Name)&"<br />")
	'		Next
	'		Response.write("<hr />")
	'		DataDiction.Add ""&dai&"",data
	'		dai=dai+1
	'		Set data=Nothing
	'		myRs.movenext
	'	Loop
		
		
		'obs=DataDiction("0")("ID")

		'Response.write(obs)

		'Response.write("<hr />")

		'Response.write(DataDiction.Item("id_1").Item("ID"))

	'	For i=0 To dai-1
	'		obs=DataDiction(""&i&"")("NewsNameCh")
	'		Response.write(obs)
	'		Response.write("<br />")
	'		'Response.write(" <br />"&DataArray(i).Item("ID"))
	'		'Response.write("<br />"&DataDiction(i).Item("ID"))
	'	Next
	'	Response.write("<hr />")
'
'		Set a1 = CreateObject("scripting.dictionary")
'		For i=1 To 9
'			Set a2 = CreateObject("scripting.dictionary")
'			For j=1 To 12
'				a2.add CStr("aaa"&j),CStr("b"&i&"b"&j*10)
'			Next
'			a1.add ("bbb"&i),a2
'			Set a2=Nothing
'		Next
'	
'		For i=1 To 9
'			For j=1 To 12
'				acs=a1("bbb"&i)("aaa"&j)
'				response.write acs&"&nbsp;&nbsp;&nbsp;&nbsp;"
'			Next
'			response.write "<Br>"
''		Next
'		response.End
'		Set a1=Nothing
		
'
''		'Response.write(myRs("ID"))
		'c=myRs.Fields.count	
'		'ObjMy = array(c-1)
'		'Dim ssi
'		'	ssi=0
'		'Do While Not rs.eof
'			'Dim data
'			'Set data=Server.CreateObject("Scripting.Dictionary")
'		'For i=0 To (c-1)
'		'	Response.write(myRs.Fields(i).Name&" -> "&myRs(myRs.Fields(i).Name)&"<br />")
'				'data.Add myRs.Fields(i).Name,myRs(myRs.Fields(i).Name)
''		'Next
'		
'			'ObjMy(ssi)=data
'			'ssi=ssi+1
'		'	Response.write("<hr />")
			'myRs.movenext
'		'Loop
'	End If
'	myRs.close
''
'	
'	
	'	TestAry = myRs.GetRows(10)
'		
''	'	For row = 0 To UBound(TestAry, 2)
	'		For col = 0 To UBound(TestAry, 1)
'	'			Response.Write(TestAry(col,row))&"<br>"
'	'		Next
'	'		Response.write(TestAry(0,1))&"<br />"
	'	Next

		'For Each ob in TestAry
		'	Response.Write("<br />"&ob&": "&TestAry(ob)&"<br />")
		'next
	'End If
	
	'	MyArray = myRs.GetRows(10)
	'myRs.close
	
	'For Each ob in MyArray
	'	Response.Write("<br />"&ob&": "&MyArray(ob)&"<br />")
	'next 


	'For row = 0 To UBound(MyArray, 2)
	'	For col = 0 To UBound(MyArray, 1)
	'		Response.Write(MyArray(col,row))&"<br>"
	'	Next
	'	'Response.write(MyArray(0,1))&"<br />"
	'Next

'	Response.End
'	
'	Dim NewArray()
'	
'	dim arr(3)
'	arr(0)=array("default","小写默认","hello","Not Hello","aaaaaaaa",0)
'	arr(1)=array("help","小写帮助")
'	arr(2)=array("22help","222222小写帮助")
'	arr(3)=array("he3333333lp","小写帮33333333助")
''
'	Response.write(GetAryKeyValue(arr(0),"hello"))
'
'	Function GetAryKeyValue(ary,key)
'	
'		For i = 0 To UBound(ary)
'			If ary(i)=Key And i<>UBound(ary) Then GetAryKeyValue=ary(i+1) End If
''		Next
	
'	End Function
''
'
'	Response.end
'
'	Function Test(otherAry)
'		If IsArray(otherAry) Then
'			For row = 0 To UBound(otherAry,1)
'				Response.Write("["&otherAry(row,0)&"]["&otherAry(row,1)&"]["&otherAry(row,2)&"]["&otherAry(row,3)&"]<br />")
'			Next
'		End If
'	End Function
'	
'
'	dim MyArray(1,4) '定义了一个二维数组
'	MyArray(0,0)="0-0"
'	MyArray(0,1)="0-1"
'	MyArray(0,2)="0-2"
'	MyArray(0,3)="0-3"
'	MyArray(0,4)="0-4"
''	MyArray(1,0)="1-0"
'	MyArray(1,1)="1-1"
'	MyArray(1,2)="1-2"
'	MyArray(1,3)="1-3"
'	MyArray(1,4)="1-4"
'
'	'Test(MyArray)
	
'	Response.write("<hr />You IP:"&GetUserTrueIP())
'	Response.write("<hr />You Browser:"&GetUserBrowserInfo())
'	Response.write("<hr />You OS:"&GetUserOSInfo())
'	Response.write("<hr />You Other Info:<br />")
'
'	'============================================
'	'	获取浏览器信息
'	'===========================================
'	
'	'Dim	objBC
'	'Set objBC=Server.CreateObject("MSWC.BrowserType")
'	
'	For Each ob in Request.ServerVariables
'		Response.Write("<br />"&ob&": "&Request.ServerVariables(ob)&"<br />")
'	next 
'
'	'Set objBC=Nothing
'
'	'==================================
'	'	正则匹配
'	'	patrn	正则
'	'	strng	字符串
'	'	返回匹配到的内容
'	'==================================
'	Function RegExpTest(patrn,strng)
'		Dim regEx, Matches
'		Set regEx = New RegExp
'		regEx.Pattern = patrn
'		regEx.IgnoreCase = True
'		regEx.Global = True
'		Set Matches = regEx.Execute(strng)
''		RegExpTest=Matches(0)
'	End Function
'
'	'=====================================TITLE
'
	

	

	
%>