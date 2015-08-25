<%
Dim Conn, ConnStr
Set Conn = Server.CreateObject("Adodb.Connection")
If IsDatabaseType = 1 Then
    ConnStr = "Provider = Sqloledb; User ID = " & DEF_SQLusername & "; Password = " & DEF_SQLpassword & "; Initial Catalog = " & DEF_SQLdatabase & "; Data Source = " & DEF_SQLserver & ";"
Else
    ConnStr = "Provider = Microsoft.Jet.OLEDB.4.0;Data Source = " & Server.MapPath(""&SysRootDir&""&SiteDataPath&"/"&SiteDataAccess&"")
End If
Conn.Open ConnStr
If Err Then
    Err.Clear
    Set Conn = Nothing
    Response.Write ChinaQJLanguageTxt1
    Response.End
End If

'Conn.close
'Set Conn = Nothing

'==========================================
'	SQL 函数 (Beta)
'	Null	暂时无传参
'	返回Access数据连接
'===========================================
Function GetConnection()
	On Error Resume Next	'-----------Error
	
	Dim Conn, ConnStr
	Set Conn = Server.CreateObject("Adodb.Connection")
	If IsDatabaseType = 1 Then
		ConnStr = "Provider = Sqloledb; User ID = " & DEF_SQLusername & "; Password = " & DEF_SQLpassword & "; Initial Catalog = " & DEF_SQLdatabase & "; Data Source = " & DEF_SQLserver & ";"
	Else
		ConnStr = "Provider = Microsoft.Jet.OLEDB.4.0;Data Source = " & Server.MapPath(""&SysRootDir&""&SiteDataPath&"/"&SiteDataAccess&"")
	End If
	Conn.Open ConnStr
	Set GetConnection = Conn

	Call LogError("GetConnection",GetConnection,Nothing)
End Function

'============================================
'	关闭数据库连接(Beta)
'============================================
Function CloseConnection(Conn)
	'On Error Resume Next	'-----------Error
	
	Conn.close
	Set Conn=Nothing
	
	'cError()
End Function

'=======================================
'	SQL 查询 通用 函数 (Beta)
'	sql		sql语句
'	返回一个字典集,如果没有返回空字典集
'======================================
Function SQL_Query(sql)
	On Error Resume Next	'-----------Error
 	Dim DataDiction,Conn,rs
	Set DataDiction=Server.CreateObject("Scripting.Dictionary")
	Set Conn = GetConnection()
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
	Set rs=Nothing
	CloseConnection(Conn)		'close connection

	Set SQL_Query=DataDiction
	
	Call LogError("SQL_Query",SQL_Query,Server.CreateObject("Scripting.Dictionary"))
End Function

'==========================================
'	防SQL注入[简单版]
'	sql		语句
'	返回	替换结果
'===========================================
Function V(sql)
	V=replace(sql,"'","''")
End Function

'=============================================
'	SQL 操作通用函数[添加,修改,删除]	[Error]
'	sql			sql 语句
'	返回结果,受影响的行数
'===============================================
Function SQL_Other(sql)
	On Error Resume Next	'-----------Error
	
	Dim Conn
	Set Conn = GetConnection()
	Conn.Execute(sql)
	Set SQL_Other=1
	CloseConnection(Conn)	'close connection

	'Dim Conn,rs
	'Set Conn = GetConnection()
	'Set rs = server.createobject("adodb.recordset")
	'rs.open sql,Conn,1,3
	'rs.update
	'rs.close
	'Set rs=Nothing
	'Set SQL_Other=1
	
	'CloseConnection(Conn)	'close connection
	
	Call LogError("SQL_Other",SQL_Other,0)
End Function

'==================================================
'	SQL 单独 INSERT 操作
'	TabName			表名
'	ObjDict			参数集(key=>val)[字典]
'	返回	
'==================================================
Function SQL_INSERT(TabName,ObjDict)
	On Error Resume Next	'-----------Error
	Dim Conn,rs
	Set Conn = GetConnection()
	Set rs = server.createobject("adodb.recordset")
	rs.open "SELECT * FROM "&TabName,Conn,1,3
	'If rs.eof Then 
	'	SQL_INSERT = 0
	'Else
		Dim ObjDict_bak
		Set ObjDict_bak = ObjDict
		rs.addnew
		For Each o in ObjDict
			rs(o) = ObjDict_bak.Item(o) 'ObjDice(o)
			'Response.write(o & " => " & ObjDict(o) & "<br />")
		Next
		'Response.end
		rs.update
		SQL_INSERT = 1
	'End If
	rs.close
	Set rs=Nothing	
	CloseConnection(Conn)	'close connection
	
	Call LogError("SQL_INSERT",SQL_INSERT,0)
End Function

'==================================================
'	SQL 单独 UPDATE 操作
'	TabName			表名
'	ObjDict			参数集(key=>val)[字典]
'	wKey			WHERE name
'	wVal			WHERE value
'	返回	
'==================================================
Function SQL_UPDATE(TabName,ObjDict,wKey,wVal)
	On Error Resume Next	'-----------Error
	Dim Conn,rs
	Set Conn = GetConnection()
	Set rs = server.createobject("adodb.recordset")
	rs.open "SELECT * FROM "&TabName&" WHERE "&wKey&"="&wVal,Conn,1,3
	'If rs.eof Then 
	'	SQL_UPDATE = 0
	'Else
		Dim ObjDict_bak
		Set ObjDict_bak = ObjDict
	
		For Each o in ObjDict
			rs(o) = ObjDict_bak.Item(o) 'ObjDice(o)
			'Response.write(o & " => " & ObjDict(o) & "<br />")
		Next
		'Response.end
		rs.update
		SQL_UPDATE = 1
	'End If
	rs.close
	Set rs=Nothing	
	CloseConnection(Conn)	'close connection
	
	Call LogError("SQL_UPDATE",SQL_UPDATE,0)
End Function



%>
<!--#include file="GetUserInfo.asp" -->
<!--#include file="Function.Asp" -->