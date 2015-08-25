<%
'以下为采集数据库配置设置，请根据自己的需要修改
Dim Coll_Conn
Sub Collection_Data
	Dim Collection_DbFile,Collection_DbName,Connstr

	'存放目录同主程序
	Collection_DbFile=Sdcms_DataFile
	Collection_DbName="Collection.Mdb"

	Connstr="Provider=Microsoft.Jet.OLEDB.4.0;Data Source="&Server.MapPath(Sdcms_root&Collection_DbFile&"/"&Collection_DbName)
	
	On Error Resume Next
	Set Coll_Conn=Server.CreateObject("ADODB.Connection")
	Coll_Conn.Open Connstr
	IF Err Then
		Err.Clear
		Set Coll_Conn=Nothing
		Echo "采集数据库连接出错，请检查Plug/Coll_Info/Conn.asp配置文件"
		Died
	End If
End Sub
%>