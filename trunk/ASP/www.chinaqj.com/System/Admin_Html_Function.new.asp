﻿<%
'===================================================================================================================================================
'	系统生成静态页面函数集合
'===================================================================================================================================================

'==============================================
'	输出信息.即时
'	bicW	进度条宽
'	bic		百分比
'	pid		页数
'==================================================
Function mShowMI(bicW,bic,pid)
	Response.write("<script>bar_img.width="&bicW&";</script>")
	Response.write("<script>bar_txtbai.innerHTML=""完成比例:"&bic&"%"";</script>")
	Response.Write("<script>sp_newinfo.innerHTML=""已经生成 "&pid&" 个页面."";</script>")
	Response.Flush
End Function

'=========================================
'	测试函数(获取指定值)
'	value	值
'	key		条件
'=========================================
Function BetaGetKeyValue(value,key)
	isTF=False
	BetaGetKeyValue=""
	arrstr=Split(value," ")
	For i=0 To UBound(arrstr)
		If isTF Then
			If arrstr(i)<>"=" Then 
				isTF=False 
				BetaGetKeyValue=arrstr(i) 
			End If
		End If
		If arrstr(i)=key Then isTF=true End If
	Next
End Function

'===============================================
'	生成所有列表静态页面[2]
'	TabName		数据表名
'	Lan			语言
'	Sql			SQL语句(WHERE条件)
'	aspFile		Asp动态文件名
'	htmlFile	html静态文件名
'===============================================
Function CallListHtml(TabName,Lan,Sql,aspFile,htmlFile)
	Dim PageShowCount
		PageShowCount=12
	If Sql="" Then Sql=" ViewFlag"&Lan Else Sql=Sql&" AND ViewFlag"&Lan End If
	dim rs
	set rs = server.createobject("adodb.recordset")
	rs.open "SELECT COUNT(*) FROM "&TabName&" WHERE "&Sql,conn,0,1
	If rs.eof Then 
		Response.write("<hr /><span style=""color:red"">Error:获取数据时出错!</span><hr />")
		exit Function
	Else
		Dim TPCount
			TPCount=rs(0)
		If TPCount Mod PageShowCount=0 Then 
			IPageMax=Int(TPCount/PageShowCount)
		Else 
			IPageMax=Int(TPCount/PageShowCount)+1
		End If
		If IPageMax=0 Then IPageMax=1 End If 
		hurl="http://"&Request.ServerVariables("Http_Host")&"/"&Lan&"/"&aspFile
		furl=Server.MapPath("/")&"\"&Lan&"\"&htmlFile
		For i=1 To IPageMax
			If i=1 Then 
				call CHtmlPage(hurl,furl&"."&HTMLName)
				call mShowMI(Fix((i/(IPageMax+1))*100),Fix((i/(IPageMax+1)*100)),i)
			End If
			sid=BetaGetKeyValue(Sql,"SortID")
			bict=Fix((i/IPageMax)*300)
			If sid="" Then
				call CHtmlPage(hurl&"?page="&i,furl&"-"&i&"."&HTMLName)
				call mShowMI(bict,Fix(bict/3),i+1)
			Else
				call CHtmlPage(hurl&"?page="&i&"&SortID="&sid,furl&"-"&sid&"-"&i&"."&HTMLName)
				call mShowMI(bict,Fix(bict/3),i+1)
			End If
		Next
	End If
End Function

'===============================================
'	生成所有列表静态页面[1]
'	TabName		数据表名(分类)
'	TabNames	数据表名(详细)
'	aspFile		Asp动态文件名
'	otherAry	其它(数组)
'===============================================
Function CListHtml(TabName,TabNames,aspFile,otherAry)
	Dim rsh
	set rsh = server.createobject("adodb.recordset")
	Dim sqlh
		sqlh="SELECT * FROM ChinaQJ_Language WHERE ChinaQJ_Language_State ORDER BY ChinaQJ_Language_Order"	'--	获取所有语言类别[设置为显示的]
	rsh.open sqlh,conn,0,1
	If rsh.eof Then 
		Response.write("<div class=""page""><strong style=""color:red"">Error:获取语言信息时出错!</strong></div>")	'--木有
		exit Function
	Else
		Do While Not rsh.eof							'-----------循环所有语言类别
			ThisLanguage=rsh("ChinaQJ_Language_File")	'语言文件目录
			ThisLanName=rsh("ChinaQJ_Language_Name")	'语言名称
			
			If IsArray(otherAry) Then
				For row = 0 To UBound(otherAry,1)
					Response.Write("<script>bar_txt1.innerHTML=""正在生成【"&ThisLanName&"】版【"&otherAry(row,0)&"】页面,请稍等...""</script>")
					Response.Flush
					Call CallProHtml(otherAry(row,1),ThisLanguage,"NewFlag"&ThisLanguage,otherAry(row,2),otherAry(row,3))		
				Next
			End If
		
			Dim myrs
			Set myrs = server.createobject("adodb.recordset")
			Dim myStrSql
				myStrSql="select * from "&TabNames&" WHERE ViewFlag"&ThisLanguage&" order by ID desc"	'--获取所有分类信息
			myrs.open myStrSql,conn,0,1
			If myrs.eof Then 
				Response.write("<div class=""page""><strong style=""color:red"">Error:获取分类信息时出错!</strong></div>")	'--木有分类
				exit Function
			Else
				Do While Not myrs.eof			'-----------------------------------------------------循环生成各分类版HTML
					Response.Write("<script>bar_txt1.innerHTML=""正在生成【"&ThisLanName&"】版【"&myrs("SortName"&ThisLanguage)&"】页面,请稍等...""</script>")
					Response.Flush
					Call CallProHtml(TabName,ThisLanguage,"SortID = "&myrs("ID"),aspFile,myrs("ClassSeo"))	'--生成分类html
					myrs.movenext	'--下一个分类
				Loop
			End If
			myrs.close		'--关闭分类数据连接
			rsh.movenext	'-- 下一个语言
		Loop
	End If
	rsh.close		'--关闭语言数据连接
End Function

'===============================================
'	生成所有详细页面静态页面[2]
'	TabName		数据表名
'	Lan			语言
'	LanName		语言名称
'	aspFile		Asp动态文件名
'	InfoName	页面名称
'===============================================
Function CallDetailedHtml(TabName,Lan,LanName,aspFile,InfoName)
	Dim myrs
	Set myrs = server.createobject("adodb.recordset")
	Dim myStrSql
		myStrSql="select * from "&TabName&" WHERE ViewFlag"&Lan&" order by ID desc"	'--获取所有信息
	myrs.open myStrSql,conn,0,1
	If myrs.eof Then 
		Response.write("<div class=""page""><strong style=""color:red"">Error:获取信息时出错!</strong></div>")	'--木有||Error
		exit Function
	Else
		Dim icount
			icount=conn.Execute("SELECT COUNT(*) FROM "&TabName&" WHERE ViewFlag"&Lan)(0)
		Dim i
			i=0
		Do While Not myrs.eof			'-----------------------------------------------------循环生成各信息HTML
			i=i+1
			Response.Write("<script>bar_txt1.innerHTML=""正在生成【"&LanName&"】版【"&InfoName&"】页面,请稍等...""</script>")
			Response.Flush
			Dim hurl
				hurl="http://"&Request.ServerVariables("Http_Host")&"/"&Lan&"/"&aspFile		'--动态页面URL
			Dim furl
				furl=Server.MapPath("/")&"\"&Lan&"\"&myrs("ClassSeo")&"-"&myrs("ID")		'--保存文件地址(绝对)HTML页面
			call CHtmlPage(hurl&"?ID="&myrs("ID"),furl&"."&HTMLName)
			call mShowMI(int((i/icount)*300),int((i/icount)*100),i)
			myrs.movenext	'--下一个
		Loop
	End If
	myrs.close		'--关闭信息数据连接
End Function

'===============================================
'	生成所有详细页面静态页面[1]
'	TabName		数据表名
'	aspFile		Asp动态文件名
'	InfoName	页面名称
'===============================================
Function CDetailedHtml(TabName,aspFile,InfoName)
	Dim rsh
	set rsh = server.createobject("adodb.recordset")
	Dim sqlh
		sqlh="SELECT * FROM ChinaQJ_Language WHERE ChinaQJ_Language_State ORDER BY ChinaQJ_Language_Order"	'--	获取所有语言类别[设置为显示的]
	rsh.open sqlh,conn,0,1
	If rsh.eof Then 
		Response.write("<div class=""page""><strong style=""color:red"">Error:获取语言信息时出错!</strong></div>")	'--木有
		exit Function
	Else
		Do While Not rsh.eof							'-----------循环所有语言类别
			ThisLanguage=rsh("ChinaQJ_Language_File")	'语言文件目录
			ThisLanName=rsh("ChinaQJ_Language_Name")	'语言名称
			Call CallDetailedHtml(TabName,ThisLanguage,ThisLanName,aspFile,InfoName)	'-- 调用生成
			rsh.movenext	'-- 下一个语言
		Loop
	End If
	rsh.close		'--关闭语言数据连接
End Function

'==================================================================================================================================================
'		Sub Start
'==================================================================================================================================================

'=========================================
'	生成所有产列表品静态页面
'	所有语言以及分类
'=========================================
Sub HtmlAllProSort

	Dim oAry(1,3)
	oAry(0,0)="所有产品列表"
	oAry(0,1)="ChinaQJ_Products"
	oAry(0,2)="ProductList.asp"
	oAry(0,3)="Product"
	oAry(1,0)="新开模产品"
	oAry(1,0)="ChinaQJ_Products"
	oAry(1,0)="NewProductList.asp"
	oAry(1,0)="NewProduct"
	
	Call CListHtml("ChinaQJ_Products","ChinaQJ_ProductSort","ProductList.asp",oAry)

End Sub

'===============================================
'	生成所有产品详细静态页面
'
'===============================================
Sub HtmlPro
	Call CDetailedHtml("ChinaQJ_Products","ProductView.Asp","所有产品详细")
End Sub



'=========================================================================================================================================================
'	...
'=========================================================================================================================================================

%>