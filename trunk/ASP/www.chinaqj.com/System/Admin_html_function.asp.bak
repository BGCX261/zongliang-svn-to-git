<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%
Sub HtmlProSort_old
'-----------------------------------------------------循环生成各版HTML
set rsh = server.createobject("adodb.recordset")
sqlh="select * from ChinaQJ_Language order by ChinaQJ_Language_Order"
rsh.open sqlh,conn,1,1
while(not rsh.eof)
ThisLanguage=rsh("ChinaQJ_Language_File")
LanguageFolder=rsh("ChinaQJ_Language_File")&"/"
'-----------------------------------------------------循环生成各版HTML
totalrec=Conn.Execute("Select count(*) from ChinaQJ_Products Where ViewFlag"&ThisLanguage&"")(0)
totalpage=int(totalrec/ProInfo)
If (totalpage * ProInfo)<totalrec Then
totalpage=totalpage+1
End If
if totalpage<=1 then
call htmll("","",""&LanguageFolder&""&ProSortName&""&Separated&"1."&HTMLName&"",""&LanguageFolder&"ProductList.asp","Page=",1,"","")
else
for i=1 to totalpage
call htmll("","",""&LanguageFolder&""&ProSortName&""&Separated&""&i&"."&HTMLName&"",""&LanguageFolder&"ProductList.asp","Page=",i,"","")
'Response.end
next
end if
Set rs=Server.CreateObject("ADODB.Recordset")
sql="select * from ChinaQJ_ProductSort where ViewFlag"&ThisLanguage&" order by ID desc"
rs.open sql,conn,1,1
If rs.eof Then
	Class_Num=0
Else
	Class_Num=1
do while not rs.eof
ID=rs("ID")
SortPath=conn.execute("select * from ChinaQJ_ProductSort Where ViewFlag"&ThisLanguage&" And ID="&ID)("SortPath")
ProSortNameSeo=conn.execute("select * from ChinaQJ_ProductSort Where ViewFlag"&ThisLanguage&" And ID="&ID)("ClassSeo")
totalrec=Conn.Execute("Select count(*) from ChinaQJ_Products where ViewFlag"&ThisLanguage&" and SortPath Like '%"&SortPath&"%'")(0)
totalpage=int(totalrec/ProInfo)
If (totalpage * ProInfo)<totalrec Then
totalpage=totalpage+1
End If
if totalpage<=1 then
call htmll("","",""&LanguageFolder&""&ProSortNameSeo&""&Separated&""&ID&""&Separated&"1."&HTMLName&"",""&LanguageFolder&"ProductList.asp","SortID=",ID,"Page=",1)
else
for i=1 to totalpage
call htmll("","",""&LanguageFolder&""&ProSortNameSeo&""&Separated&""&ID&""&Separated&""&i&"."&HTMLName&"",""&LanguageFolder&"ProductList.asp","SortID=",ID,"Page=",i)
next
end If
Response.Write "<script>bar_img.width="&Fix((Class_Num/rs.recordcount)*300)&";"
Response.Write "bar_txt1.innerHTML=""成功生成"&Class_Num&"个分类的HTML静态页面。完成比例：" & formatnumber(Class_Num/rs.recordcount*100) & """;</script>"
Response.Flush
rs.movenext
Class_Num=Class_Num+1
Loop
End If
rs.close
set rs=nothing
'------------------------循环结束
rsh.movenext
wend
rsh.close
set rsh=nothing
'------------------------循环结束
End Sub

'-	图片案例
Sub HtmlimageSort_old
'-----------------------------------------------------循环生成各版HTML
set rsh = server.createobject("adodb.recordset")
sqlh="select * from ChinaQJ_Language order by ChinaQJ_Language_Order"
rsh.open sqlh,conn,1,1
while(not rsh.eof)
ThisLanguage=rsh("ChinaQJ_Language_File")
LanguageFolder=rsh("ChinaQJ_Language_File")&"/"
'-----------------------------------------------------循环生成各版HTML
totalrec=Conn.Execute("Select count(*) from ChinaQJ_image Where ViewFlag"&ThisLanguage&"")(0)
call htmll("","",""&LanguageFolder&""&ImageSortName&""&Separated&"1."&HTMLName&"",""&LanguageFolder&"ImageList.asp","","","","")
Set rs=Server.CreateObject("ADODB.Recordset")
sql="select * from ChinaQJ_ImageSort where ViewFlag"&ThisLanguage&" order by ID desc"
rs.open sql,conn,1,1
If rs.eof Then
	Class_Num=0
Else
	Class_Num=1
do while not rs.eof
ID=rs("ID")
SortPath=conn.execute("select * from ChinaQJ_ImageSort Where ViewFlag"&ThisLanguage&" And ID="&ID)("SortPath")
ImageNameSeo=conn.execute("select * from ChinaQJ_ImageSort Where ViewFlag"&ThisLanguage&" And ID="&ID)("ClassSeo")
totalrec=Conn.Execute("Select count(*) from ChinaQJ_Image where ViewFlag"&ThisLanguage&" and SortPath Like '%"&SortPath&"%'")(0)
call htmll("","",""&LanguageFolder&""&ImageNameSeo&""&Separated&""&ID&""&Separated&"1."&HTMLName&"",""&LanguageFolder&"ImageList.asp","SortID=",ID,"","")
Response.Write "<script>bar_img.width="&Fix((Class_Num/rs.recordcount)*300)&";"
Response.Write "bar_txt1.innerHTML=""成功生成"&Class_Num&"个分类的HTML静态页面。完成比例：" & formatnumber(Class_Num/rs.recordcount*100) & """;</script>"
Response.Flush
rs.movenext
Class_Num=Class_Num+1
Loop
End If
rs.close
set rs=nothing
'------------------------循环结束
rsh.movenext
wend
rsh.close
set rsh=nothing
'------------------------循环结束
End Sub

'-	其它分类
Sub HtmlOtherSort_old
'-----------------------------------------------------循环生成各版HTML
set rsh = server.createobject("adodb.recordset")
sqlh="select * from ChinaQJ_Language order by ChinaQJ_Language_Order"
rsh.open sqlh,conn,1,1
while(not rsh.eof)
ThisLanguage=rsh("ChinaQJ_Language_File")
LanguageFolder=rsh("ChinaQJ_Language_File")&"/"
'-----------------------------------------------------循环生成各版HTML
totalrec=Conn.Execute("Select count(*) from ChinaQJ_Others Where ViewFlag"&ThisLanguage&"")(0)
totalpage=int(totalrec/OtherInfo)
If (totalpage * OtherInfo)<totalrec Then
totalpage=totalpage+1
End If
if totalpage<=1 then
call htmll("","",""&LanguageFolder&""&OtherSortName&""&Separated&"1."&HTMLName&"",""&LanguageFolder&"OtherList.asp","Page=",1,"","")
else
for i=1 to totalpage
call htmll("","",""&LanguageFolder&""&OtherSortName&""&Separated&""&i&"."&HTMLName&"",""&LanguageFolder&"OtherList.asp","Page=",i,"","")
next
end If
Set rs=Server.CreateObject("ADODB.Recordset")
sql="select * from ChinaQJ_OthersSort where ViewFlag"&ThisLanguage&" order by ID desc"
rs.open sql,conn,1,1
If rs.eof Then
	Class_Num=0
Else
	Class_Num=1
do while not rs.eof
ID=rs("ID")
OtherSortNameSeo=rs("ClassSeo")
SortPath=conn.execute("select * from ChinaQJ_OthersSort Where ViewFlag"&ThisLanguage&" And ID="&ID)("SortPath")
totalrec=Conn.Execute("Select count(*) from ChinaQJ_Others where ViewFlag"&ThisLanguage&" and SortPath Like '%"&SortPath&"%'")(0)
totalpage=int(totalrec/OtherInfo)
If (totalpage * OtherInfo)<totalrec Then
totalpage=totalpage+1
End If
if totalpage<=1 then
call htmll("","",""&LanguageFolder&""&OtherSortNameSeo&""&Separated&""&ID&""&Separated&"1."&HTMLName&"",""&LanguageFolder&"OtherList.asp","SortID=",ID,"Page=",1)
else
for i=1 to totalpage
call htmll("","",""&LanguageFolder&""&OtherSortNameSeo&""&Separated&""&ID&""&Separated&""&i&"."&HTMLName&"",""&LanguageFolder&"OtherList.asp","SortID=",ID,"Page=",i)
next
end If
Response.Write "<script>bar_img.width="&Fix((Class_Num/rs.recordcount)*300)&";"
Response.Write "bar_txt1.innerHTML=""成功生成"&Class_Num&"个分类的HTML静态页面。完成比例：" & formatnumber(Class_Num/rs.recordcount*100) & """;</script>"
Response.Flush
rs.movenext
Class_Num=Class_Num+1
Loop
End If
rs.close
set rs=nothing
'------------------------循环结束
rsh.movenext
wend
rsh.close
set rsh=nothing
'------------------------循环结束
End Sub

Sub HtmlNewSort_old
'-----------------------------------------------------循环生成各版HTML
set rsh = server.createobject("adodb.recordset")
sqlh="select * from ChinaQJ_Language order by ChinaQJ_Language_Order"
rsh.open sqlh,conn,1,1
while(not rsh.eof)
ThisLanguage=rsh("ChinaQJ_Language_File")
LanguageFolder=rsh("ChinaQJ_Language_File")&"/"
'-----------------------------------------------------循环生成各版HTML
totalrec=Conn.Execute("Select count(*) from ChinaQJ_News Where ViewFlag"&ThisLanguage&"")(0)
totalpage=int(totalrec/NewInfo)
If (totalpage * NewInfo)<totalrec Then
totalpage=totalpage+1
End If
if totalpage<=1 then
call htmll("","",""&LanguageFolder&""&NewSortName&""&Separated&"1."&HTMLName&"",""&LanguageFolder&"NewsList.asp","Page=",1,"","")
else
for i=1 to totalpage
call htmll("","",""&LanguageFolder&""&NewSortName&""&Separated&""&i&"."&HTMLName&"",""&LanguageFolder&"NewsList.asp","Page=",i,"","")
next
end If
Set rs=Server.CreateObject("ADODB.Recordset")
sql="select * from ChinaQJ_NewsSort where ViewFlag"&ThisLanguage&" order by ID desc"
rs.open sql,conn,1,1
If rs.eof Then
	Class_Num=0
Else
	Class_Num=1
do while not rs.eof
ID=rs("ID")
SortPath=conn.execute("select * from ChinaQJ_NewsSort Where ViewFlag"&ThisLanguage&" And ID="&ID)("SortPath")
NewSortNameSeo=conn.execute("select * from ChinaQJ_NewsSort Where ViewFlag"&ThisLanguage&" And ID="&ID)("ClassSeo")
totalrec=Conn.Execute("Select count(*) from ChinaQJ_News where ViewFlag"&ThisLanguage&" and SortPath Like '%"&SortPath&"%'")(0)
totalpage=int(totalrec/NewInfo)
If (totalpage * NewInfo)<totalrec Then
totalpage=totalpage+1
End If
if totalpage<=1 then
call htmll("","",""&LanguageFolder&""&NewSortNameSeo&""&Separated&""&ID&""&Separated&"1."&HTMLName&"",""&LanguageFolder&"NewsList.asp","SortID=",ID,"Page=",1)
else
for i=1 to totalpage
call htmll("","",""&LanguageFolder&""&NewSortNameSeo&""&Separated&""&ID&""&Separated&""&i&"."&HTMLName&"",""&LanguageFolder&"NewsList.asp","SortID=",ID,"Page=",i)
next
End If
Response.Write "<script>bar_img.width="&Fix((Class_Num/rs.recordcount)*300)&";"
Response.Write "bar_txt1.innerHTML=""成功生成"&Class_Num&"个分类的HTML静态页面。完成比例：" & formatnumber(Class_Num/rs.recordcount*100) & """;</script>"
Response.Flush
rs.movenext
Class_Num=Class_Num+1
Loop
End If
rs.close
set rs=nothing
'------------------------循环结束
rsh.movenext
wend
rsh.close
set rsh=nothing
'------------------------循环结束
End Sub

'-------人才分类 NEW Error
Sub HtmlJobSort_old
'-----------------------------------------------------循环生成各版HTML
set rsh = server.createobject("adodb.recordset")
sqlh="select * from ChinaQJ_Language order by ChinaQJ_Language_Order"
rsh.open sqlh,conn,1,1
while(not rsh.eof)
ThisLanguage=rsh("ChinaQJ_Language_File")
LanguageFolder=rsh("ChinaQJ_Language_File")&"/"
'-----------------------------------------------------循环生成各版HTML
totalrec=Conn.Execute("Select count(*) from ChinaQJ_Jobs Where ViewFlag"&ThisLanguage&"")(0)
totalpage=int(totalrec/JobInfo)
If (totalpage * JobInfo)<totalrec Then
totalpage=totalpage+1
End If
if totalpage<=1 then
call htmll("","",""&LanguageFolder&""&JobSortName&""&Separated&"1."&HTMLName&"",""&LanguageFolder&"JobsList.asp","Page=",1,"","")
else
for i=1 to totalpage
call htmll("","",""&LanguageFolder&""&JobSortName&""&Separated&""&i&"."&HTMLName&"",""&LanguageFolder&"JobsList.asp","Page=",i,"","")
Response.Write "<script>bar_img.width="&Fix((i/totalpage)*300)&";"
Response.Write "bar_txt1.innerHTML=""成功生成"&i&"个分类的HTML静态页面。完成比例：" & formatnumber(i/totalpage*100) & """;</script>"
Response.Flush
next
end if
'------------------------循环结束
rsh.movenext
wend
rsh.close
set rsh=nothing
'------------------------循环结束
End Sub

'-----------下载分类
Sub HtmlDownSort_old
'-----------------------------------------------------循环生成各版HTML
set rsh = server.createobject("adodb.recordset")
sqlh="select * from ChinaQJ_Language order by ChinaQJ_Language_Order"
rsh.open sqlh,conn,1,1
while(not rsh.eof)
ThisLanguage=rsh("ChinaQJ_Language_File")
LanguageFolder=rsh("ChinaQJ_Language_File")&"/"
'-----------------------------------------------------循环生成各版HTML
totalrec=Conn.Execute("Select count(*) from ChinaQJ_Download Where ViewFlag"&ThisLanguage&"")(0)
totalpage=int(totalrec/DownInfo)
If (totalpage * DownInfo)<totalrec Then
totalpage=totalpage+1
End If
if totalpage<=1 then
call htmll("","",""&LanguageFolder&""&DownSortName&""&Separated&"1."&HTMLName&"",""&LanguageFolder&"DownList.asp","Page=",1,"","")
else
for i=1 to totalpage
call htmll("","",""&LanguageFolder&""&DownSortName&""&Separated&""&i&"."&HTMLName&"",""&LanguageFolder&"DownList.asp","Page=",i,"","")
next
end If
Set rs=Server.CreateObject("ADODB.Recordset")
sql="select * from ChinaQJ_DownSort where ViewFlag"&ThisLanguage&" order by ID desc"
rs.open sql,conn,1,1
If rs.eof Then
	Class_Num=0
Else
	Class_Num=1
do while not rs.eof
ID=rs("ID")
SortPath=conn.execute("select * from ChinaQJ_DownSort Where ViewFlag"&ThisLanguage&" And ID="&ID)("SortPath")
DownSortNameSeo=conn.execute("select * from ChinaQJ_DownSort Where ViewFlag"&ThisLanguage&" And ID="&ID)("ClassSeo")
totalrec=Conn.Execute("Select count(*) from ChinaQJ_Download where ViewFlag"&ThisLanguage&" and SortPath Like '%"&SortPath&"%'")(0)
totalpage=int(totalrec/DownInfo)
If (totalpage * DownInfo)<totalrec Then
totalpage=totalpage+1
End If
if totalpage<=1 then
call htmll("","",""&LanguageFolder&""&DownSortNameSeo&""&Separated&""&ID&""&Separated&"1."&HTMLName&"",""&LanguageFolder&"DownList.asp","SortID=",ID,"Page=",1)
else
for i=1 to totalpage
call htmll("","",""&LanguageFolder&""&DownSortNameSeo&""&Separated&""&ID&""&Separated&""&i&"."&HTMLName&"",""&LanguageFolder&"DownList.asp","SortID=",ID,"Page=",i)
next
end If
Response.Write "<script>bar_img.width="&Fix((Class_Num/rs.recordcount)*300)&";"
Response.Write "bar_txt1.innerHTML=""成功生成"&Class_Num&"个分类的HTML静态页面。完成比例：" & formatnumber(Class_Num/rs.recordcount*100) & """;</script>"
Response.Flush
rs.movenext
Class_Num=Class_Num+1
Loop
End If
rs.close
set rs=nothing
'------------------------循环结束
rsh.movenext
wend
rsh.close
set rsh=nothing
'------------------------循环结束
End Sub

Sub HtmlPro_old
'-----------------------------------------------------循环生成各版HTML
set rsh = server.createobject("adodb.recordset")
sqlh="select * from ChinaQJ_Language order by ChinaQJ_Language_Order"
rsh.open sqlh,conn,1,1
while(not rsh.eof)
ThisLanguage=rsh("ChinaQJ_Language_File")
LanguageFolder=rsh("ChinaQJ_Language_File")&"/"
'-----------------------------------------------------循环生成各版HTML
totalrec=Conn.Execute("select count(*) from ChinaQJ_Products where ViewFlag"&ThisLanguage&"")(0)
sql="Select * from ChinaQJ_Products where ViewFlag"&ThisLanguage&" order by ID desc"
Set Rs=Conn.Execute(sql)
if totalrec=0 then
Detail_Num=0
Else
Detail_Num=1
do while not rs.eof
ID=rs("ID")
ProNameSeo=rs("ClassSeo")
call htmll("","",""&LanguageFolder&""&ProNameSeo&""&Separated&""&ID&"."&HTMLName&"",""&LanguageFolder&"ProductView.asp","ID=",ID,"","")
Response.Write "<script>bar_img.width="&Fix((Detail_Num/totalrec)*300)&";"
Response.Write "bar_txt1.innerHTML=""已成功生成静态页"&Detail_Num&"页，完成比例：" & formatnumber(Detail_Num/totalrec*100) & """;</script>"
Response.Flush
rs.movenext
Detail_Num=Detail_Num+1
loop
end if
rs.close
set rs=Nothing
'------------------------循环结束
rsh.movenext
wend
rsh.close
set rsh=nothing
'------------------------循环结束
End Sub

'--	图片案例详细
Sub HtmlImage_old
'-----------------------------------------------------循环生成各版HTML
set rsh = server.createobject("adodb.recordset")
sqlh="select * from ChinaQJ_Language order by ChinaQJ_Language_Order"
rsh.open sqlh,conn,1,1
while(not rsh.eof)
ThisLanguage=rsh("ChinaQJ_Language_File")
LanguageFolder=rsh("ChinaQJ_Language_File")&"/"
'-----------------------------------------------------循环生成各版HTML
totalrec=Conn.Execute("select count(*) from ChinaQJ_Image where ViewFlag"&ThisLanguage&"")(0)
sql="Select * from ChinaQJ_Image where ViewFlag"&ThisLanguage&" order by ID desc"
Set Rs=Conn.Execute(sql)
if totalrec=0 then
Detail_Num=0
Else
Detail_Num=1
do while not rs.eof
ID=rs("ID")
ImageNameSeo=rs("ClassSeo")
call htmll("","",""&LanguageFolder&""&ImageNameSeo&""&Separated&""&ID&"."&HTMLName&"",""&LanguageFolder&"ImageView.asp","ID=",ID,"","")
Response.Write "<script>bar_img.width="&Fix((Detail_Num/totalrec)*300)&";"
Response.Write "bar_txt1.innerHTML=""已成功生成静态页"&Detail_Num&"页，完成比例：" & formatnumber(Detail_Num/totalrec*100) & """;</script>"
Response.Flush
rs.movenext
Detail_Num=Detail_Num+1
loop
end if
rs.close
set rs=Nothing
'------------------------循环结束
rsh.movenext
wend
rsh.close
set rsh=nothing
'------------------------循环结束
End Sub

'----其它详细
Sub HtmlOther_old
'-----------------------------------------------------循环生成各版HTML
set rsh = server.createobject("adodb.recordset")
sqlh="select * from ChinaQJ_Language order by ChinaQJ_Language_Order"
rsh.open sqlh,conn,1,1
while(not rsh.eof)
ThisLanguage=rsh("ChinaQJ_Language_File")
LanguageFolder=rsh("ChinaQJ_Language_File")&"/"
'-----------------------------------------------------循环生成各版HTML
totalrec=Conn.Execute("select count(*) from ChinaQJ_Others where ViewFlag"&ThisLanguage&"")(0)
sql="Select * from ChinaQJ_Others where ViewFlag"&ThisLanguage&" order by ID desc"
Set Rs=Conn.Execute(sql)
if totalrec=0 then
Detail_Num=0
Else
Detail_Num=1
do while not rs.eof
ID=rs("ID")
OtherNameSeo=rs("ClassSeo")
call htmll("","",""&LanguageFolder&""&OtherNameSeo&""&Separated&""&ID&"."&HTMLName&"",""&LanguageFolder&"OtherView.asp","ID=",ID,"","")
Response.Write "<script>bar_img.width="&Fix((Detail_Num/totalrec)*300)&";"
Response.Write "bar_txt1.innerHTML=""已成功生成【常见问题内容】静态页"&Detail_Num&"页，完成比例：" & formatnumber(Detail_Num/totalrec*100) & """;</script>"
Response.Flush
rs.movenext
Detail_Num=Detail_Num+1
loop
end if
rs.close
set rs=Nothing
'------------------------循环结束
rsh.movenext
wend
rsh.close
set rsh=nothing
'------------------------循环结束
End Sub

'---新闻详细
Sub HtmlNews_old
'-----------------------------------------------------循环生成各版HTML
set rsh = server.createobject("adodb.recordset")
sqlh="select * from ChinaQJ_Language order by ChinaQJ_Language_Order"
rsh.open sqlh,conn,1,1
while(not rsh.eof)
ThisLanguage=rsh("ChinaQJ_Language_File")
LanguageFolder=rsh("ChinaQJ_Language_File")&"/"
'-----------------------------------------------------循环生成各版HTML
totalrec=Conn.Execute("select count(*) from ChinaQJ_News where ViewFlag"&ThisLanguage&"")(0)
sql="Select * from ChinaQJ_News where ViewFlag"&ThisLanguage&" order by ID desc"
Set Rs=Conn.Execute(sql)
if totalrec=0 then
Detail_Num=0
Else
Detail_Num=1
do while not rs.eof
ID=rs("ID")
NewNameSeo=rs("ClassSeo")
call htmll("","",""&LanguageFolder&""&NewNameSeo&""&Separated&""&ID&"."&HTMLName&"",""&LanguageFolder&"NewsView.asp","ID=",ID,"","")
Response.Write "<script>bar_img.width="&Fix((Detail_Num/totalrec)*300)&";"
Response.Write "bar_txt1.innerHTML=""已成功生成【新闻动态内容】静态页"&Detail_Num&"页，完成比例：" & formatnumber(Detail_Num/totalrec*100) & """;</script>"
Response.Flush
rs.movenext
Detail_Num=Detail_Num+1
loop
end if
rs.close
set rs=Nothing
'------------------------循环结束
rsh.movenext
wend
rsh.close
set rsh=nothing
'------------------------循环结束
End Sub

'--------生成招聘详细
Sub HtmlJob
'-----------------------------------------------------循环生成各版HTML
set rsh = server.createobject("adodb.recordset")
sqlh="select * from ChinaQJ_Language order by ChinaQJ_Language_Order"
rsh.open sqlh,conn,1,1
while(not rsh.eof)
ThisLanguage=rsh("ChinaQJ_Language_File")
LanguageFolder=rsh("ChinaQJ_Language_File")&"/"
'-----------------------------------------------------循环生成各版HTML
totalrec=Conn.Execute("select count(*) from ChinaQJ_Jobs where ViewFlag"&ThisLanguage&"")(0)
sql="Select * from ChinaQJ_Jobs where ViewFlag"&ThisLanguage&" order by ID desc"
Set Rs=Conn.Execute(sql)
if totalrec=0 then
Detail_Num=0
Else
Detail_Num=1
do while not rs.eof
ID=rs("ID")
JobNameDiySeo=rs("ClassSeo")
call htmll("","",""&LanguageFolder&""&JobNameDiySeo&""&Separated&""&ID&"."&HTMLName&"",""&LanguageFolder&"JobsView.asp","ID=",ID,"","")
Response.Write "<script>bar_img.width="&Fix((Detail_Num/totalrec)*300)&";"
Response.Write "bar_txt1.innerHTML=""已成功生成【求贤纳士内容】静态页"&Detail_Num&"页，完成比例：" & formatnumber(Detail_Num/totalrec*100) & """;</script>"
Response.Flush
rs.movenext
Detail_Num=Detail_Num+1
loop
end if
rs.close
set rs=Nothing
'------------------------循环结束
rsh.movenext
wend
rsh.close
set rsh=nothing
'------------------------循环结束
End Sub

'--	企业信息列表
Sub HtmlInfo_old
'-----------------------------------------------------循环生成各版HTML
set rsh = server.createobject("adodb.recordset")
sqlh="select * from ChinaQJ_Language order by ChinaQJ_Language_Order"
rsh.open sqlh,conn,1,1
while(not rsh.eof)
ThisLanguage=rsh("ChinaQJ_Language_File")
LanguageFolder=rsh("ChinaQJ_Language_File")&"/"
'-----------------------------------------------------循环生成各版HTML
totalrec=Conn.Execute("select count(*) from ChinaQJ_About where ViewFlag"&ThisLanguage&"")(0)
sql="Select * from ChinaQJ_About where ViewFlag"&ThisLanguage&" order by ID desc"
Set Rs=Conn.Execute(sql)
if totalrec=0 then
Detail_Num=0
Else
Detail_Num=1
do while not rs.eof
ID=rs("ID")
AboutNameDiyseo=rs("classseo")
call htmll("","",""&LanguageFolder&""&AboutNameDiyseo&""&Separated&""&ID&"."&HTMLName&"",""&LanguageFolder&"About.asp","ID=",ID,"","")
Response.Write "<script>bar_img.width="&Fix((Detail_Num/totalrec)*300)&";"
Response.Write "bar_txt1.innerHTML=""已成功生成【关于我们内容】静态页"&Detail_Num&"页，完成比例：" & formatnumber(Detail_Num/totalrec*100) & """;</script>"
Response.Flush
rs.movenext
Detail_Num=Detail_Num+1
loop
end if
rs.close
set rs=Nothing
'------------------------循环结束
rsh.movenext
wend
rsh.close
set rsh=nothing
'------------------------循环结束
End Sub

'--------下载详细
Sub HtmlDown_old
'-----------------------------------------------------循环生成各版HTML
set rsh = server.createobject("adodb.recordset")
sqlh="select * from ChinaQJ_Language order by ChinaQJ_Language_Order"
rsh.open sqlh,conn,1,1
while(not rsh.eof)
ThisLanguage=rsh("ChinaQJ_Language_File")
LanguageFolder=rsh("ChinaQJ_Language_File")&"/"
'-----------------------------------------------------循环生成各版HTML
totalrec=Conn.Execute("select count(*) from ChinaQJ_Download where ViewFlag"&ThisLanguage&"")(0)
sql="Select * from ChinaQJ_Download where ViewFlag"&ThisLanguage&" order by ID desc"
Set Rs=Conn.Execute(sql)
if totalrec=0 then
Detail_Num=0
Else
Detail_Num=1
do while not rs.eof
ID=rs("ID")
DownNameDiySeo=rs("ClassSeo")
call htmll("","",""&LanguageFolder&""&DownNameDiySeo&""&Separated&""&ID&"."&HTMLName&"",""&LanguageFolder&"DownView.asp","ID=",ID,"","")
Response.Write "<script>bar_img.width="&Fix((Detail_Num/totalrec)*300)&";"
Response.Write "bar_txt1.innerHTML=""已成功生成【下载中心内容】静态页"&Detail_Num&"页，完成比例：" & formatnumber(Detail_Num/totalrec*100) & """;</script>"
Response.Flush
rs.movenext
Detail_Num=Detail_Num+1
loop
end if
rs.close
set rs=Nothing
'------------------------循环结束
rsh.movenext
wend
rsh.close
set rsh=nothing
'------------------------循环结束
End Sub

'--------生成首页
Sub HtmlIndex_old
'-----------------------------------------------------循环生成各版HTML
set rsh = server.createobject("adodb.recordset")
sqlh="select * from ChinaQJ_Language order by ChinaQJ_Language_Order"
rsh.open sqlh,conn,1,1
while(not rsh.eof)
ThisLanguage=rsh("ChinaQJ_Language_File")
LanguageFolder=rsh("ChinaQJ_Language_File")&"/"
'-----------------------------------------------------循环生成各版HTML
call htmll("","",""&LanguageFolder&"Index."&HTMLname&"",""&LanguageFolder&"Index.asp","","","","")
Response.Write "<script>bar_img.width="&Fix((1/8)*300)&";bar_txt1.innerHTML=""成功生成【首页】静态页面。完成比例" & formatnumber(1/8*100) & """;</script>"
Response.Flush
call htmll("","",""&LanguageFolder&""&ContactUsDiy&"."&HTMLname&"",""&LanguageFolder&"Company.asp","","","","")
Response.Write "<script>bar_img.width="&Fix((2/8)*300)&";bar_txt1.innerHTML=""成功生成【关于我们分类】静态页面。完成比例：" & formatnumber(2/8*100) & """;</script>"
Response.Flush
call htmll("","",""&LanguageFolder&""&NewSortName&"."&HTMLname&"",""&LanguageFolder&"NewsList.asp","","","","")
Response.Write "<script>bar_img.width="&Fix((3/8)*300)&";bar_txt1.innerHTML=""成功生成【新闻动态分类】静态页面。完成比例：" & formatnumber(3/8*100) & """;</script>"
Response.Flush
call htmll("","",""&LanguageFolder&""&ProSortName&"."&HTMLname&"",""&LanguageFolder&"ProductList.asp","","","","")
Response.Write "<script>bar_img.width="&Fix((4/8)*300)&";bar_txt1.innerHTML=""成功生成【产品展示分类】静态页面。完成比例：" & formatnumber(4/8*100) & """;</script>"
Response.Flush
call htmll("","",""&LanguageFolder&""&JobSortName&"."&HTMLname&"",""&LanguageFolder&"JobsList.asp","","","","")
Response.Write "<script>bar_img.width="&Fix((5/8)*300)&";bar_txt1.innerHTML=""成功生成【求贤纳士分类】静态页面。完成比例：" & formatnumber(5/8*100) & """;</script>"
Response.Flush
call htmll("","",""&LanguageFolder&""&DownSortName&"."&HTMLname&"",""&LanguageFolder&"DownList.asp","","","","")
Response.Write "<script>bar_img.width="&Fix((6/8)*300)&";bar_txt1.innerHTML=""成功生成【下载中心分类】静态页面。完成比例：" & formatnumber(6/8*100) & """;</script>"
Response.Flush
call htmll("","",""&LanguageFolder&""&OtherSortName&"."&HTMLname&"",""&LanguageFolder&"OtherList.asp","","","","")
Response.Write "<script>bar_img.width="&Fix((7/8)*300)&";bar_txt1.innerHTML=""成功生成【常见问题分类】静态页面。完成比例：" & formatnumber(7/8*100) & """;</script>"
Response.Flush
'------------------------循环结束
rsh.movenext
wend
rsh.close
set rsh=nothing
'------------------------循环结束
End Sub

'-	服务范围分类 NEW Error
Sub HtmlKeySort
'-----------------------------------------------------循环生成各版HTML
set rsh = server.createobject("adodb.recordset")
sqlh="select * from ChinaQJ_Language order by ChinaQJ_Language_Order"
rsh.open sqlh,conn,1,1
while(not rsh.eof)
ThisLanguage=rsh("ChinaQJ_Language_File")
LanguageFolder=rsh("ChinaQJ_Language_File")&"/"
'-----------------------------------------------------循环生成各版HTML
totalrec=Conn.Execute("Select count(*) from ChinaQJ_Key Where ViewFlag='"&ThisLanguage&"'")(0)
totalpage=int(totalrec/KeyInfo)
If (totalpage * KeyInfo)<totalrec Then
totalpage=totalpage+1
End If
if totalpage<=1 then
call htmll("","",""&LanguageFolder&""&KeySortName&""&Separated&"1."&HTMLName&"",""&LanguageFolder&"KeyList.asp","Page=",1,"","")
Response.Write "<script>bar_img.width="&Fix(300)&";"
Response.Write "bar_txt1.innerHTML=""成功生成1个分类的HTML静态页面。完成比例：" & formatnumber(100) & """;</script>"
Response.Flush
else
for i=1 to totalpage
call htmll("","",""&LanguageFolder&""&KeySortName&""&Separated&""&i&"."&HTMLName&"",""&LanguageFolder&"KeyList.asp","Page=",i,"","")
Response.Write "<script>bar_img.width="&Fix((i/totalpage)*300)&";"
Response.Write "bar_txt1.innerHTML=""成功生成"&i&"个分类的HTML静态页面。完成比例：" & formatnumber(i/totalpage*100) & """;</script>"
Response.Flush
next
end If
'------------------------循环结束
rsh.movenext
wend
rsh.close
set rsh=nothing
'------------------------循环结束
End Sub

'---服务范围详细	NEW Error
Sub HtmlKey
'-----------------------------------------------------循环生成各版HTML
set rsh = server.createobject("adodb.recordset")
sqlh="select * from ChinaQJ_Language order by ChinaQJ_Language_Order"
rsh.open sqlh,conn,1,1
while(not rsh.eof)
ThisLanguage=rsh("ChinaQJ_Language_File")
LanguageFolder=rsh("ChinaQJ_Language_File")&"/"
'-----------------------------------------------------循环生成各版HTML
totalrec=Conn.Execute("select count(*) from ChinaQJ_Key where viewflag='"&ThisLanguage&"'")(0)
sql="Select * from ChinaQJ_Key where viewflag='"&ThisLanguage&"' order by ID desc"
Set Rs=Conn.Execute(sql)
if totalrec=0 then
Detail_Num=0
Else
Detail_Num=1
do while not rs.eof
ID=rs("ID")
call htmll("","",""&LanguageFolder&""&KeysName&""&Separated&""&ID&"."&HTMLName&"",""&LanguageFolder&"KeyView.asp","ID=",ID,"","")
Response.Write "<script>bar_img.width="&Fix((Detail_Num/totalrec)*300)&";"
Response.Write "bar_txt1.innerHTML=""已成功生成静态页"&Detail_Num&"页，完成比例：" & formatnumber(Detail_Num/totalrec*100) & """;</script>"
Response.Flush
rs.movenext
Detail_Num=Detail_Num+1
loop
end if
rs.close
set rs=Nothing
'------------------------循环结束
rsh.movenext
wend
rsh.close
set rsh=nothing
'------------------------循环结束
End Sub

Sub HtmlNewProSort_old
'-----------------------------------------------------循环生成各版HTML
set rsh = server.createobject("adodb.recordset")
sqlh="select * from ChinaQJ_Language order by ChinaQJ_Language_Order"
rsh.open sqlh,conn,1,1
while(not rsh.eof)
ThisLanguage=rsh("ChinaQJ_Language_File")
LanguageFolder=rsh("ChinaQJ_Language_File")&"/"
'-----------------------------------------------------循环生成各版HTML
totalrec=Conn.Execute("Select count(*) from ChinaQJ_Products Where NewFlag"&ThisLanguage&" and ViewFlag"&ThisLanguage&"")(0)
totalpage=int(totalrec/ProInfo)
If (totalpage * ProInfo)<totalrec Then
totalpage=totalpage+1
End If
if totalpage<=1 then
call htmll("","",""&LanguageFolder&""&NewProSortName&""&Separated&"1."&HTMLName&"",""&LanguageFolder&"NewProductList.Asp","Page=",1,"","")
else
for i=1 to totalpage
call htmll("","",""&LanguageFolder&""&NewProSortName&""&Separated&""&i&"."&HTMLName&"",""&LanguageFolder&"NewProductList.Asp","Page=",i,"","")
next
end if
Set rs=Server.CreateObject("ADODB.Recordset")
sql="select * from ChinaQJ_ProductSort where ViewFlag"&ThisLanguage&" order by ID desc"
rs.open sql,conn,1,1
If rs.eof Then
	Class_Num=0
Else
	Class_Num=1
do while not rs.eof
ID=rs("ID")
SortPath=conn.execute("select * from ChinaQJ_ProductSort Where ViewFlag"&ThisLanguage&" And ID="&ID)("SortPath")
ProSortNameSeo=conn.execute("select * from ChinaQJ_ProductSort Where ViewFlag"&ThisLanguage&" And ID="&ID)("ClassSeo")
totalrec=Conn.Execute("Select count(*) from ChinaQJ_Products where NewFlag"&ThisLanguage&" and  ViewFlag"&ThisLanguage&" and SortPath Like '%"&SortPath&"%'")(0)
totalpage=int(totalrec/ProInfo)
If (totalpage * ProInfo)<totalrec Then
totalpage=totalpage+1
End If
if totalpage<=1 then
call htmll("","",""&LanguageFolder&""&ProSortNameSeo&""&Separated&""&ID&""&Separated&"1."&HTMLName&"",""&LanguageFolder&"NewProductList.Asp","SortID=",ID,"Page=",1)
else
for i=1 to totalpage
call htmll("","",""&LanguageFolder&""&ProSortNameSeo&""&Separated&""&ID&""&Separated&""&i&"."&HTMLName&"",""&LanguageFolder&"NewProductList.Asp","SortID=",ID,"Page=",i)
next
end If
Response.Write "<script>bar_img.width="&Fix((Class_Num/rs.recordcount)*300)&";"
Response.Write "bar_txt1.innerHTML=""成功生成【新开模产品分类】"&Class_Num&"个静态页面。完成比例：" & formatnumber(Class_Num/rs.recordcount*100) & """;</script>"
Response.Flush
rs.movenext
Class_Num=Class_Num+1
Loop
End If
rs.close
set rs=nothing
'------------------------循环结束
rsh.movenext
wend
rsh.close
set rsh=nothing
'------------------------循环结束
End Sub


'=========================================================================================================================================================
'	start...
'=========================================================================================================================================================

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
'	生成所有列表静态页面
'	TabName		数据表名
'	Lan			语言
'	Sql			SQL语句(WHERE条件)
'	aspFile		Asp动态文件名
'	htmlFile	html静态文件名
'===============================================
Function CallProHtml(TabName,Lan,Sql,aspFile,htmlFile)
	Dim PageShowCount
		PageShowCount=12
	If Sql="" Then Sql=" ViewFlag"&Lan Else Sql=Sql&" AND ViewFlag"&Lan End If
	dim rs
	set rs = server.createobject("adodb.recordset")
	rs.open "SELECT COUNT(*) FROM "&TabName&" WHERE "&Sql,conn,0,1
	If rs.eof Then 
		Response.write("<hr /><span style=""color:red"">Error:获取数据时出错!</span><hr />")
		exit function
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


'=========================================
'	生成所有产列表品静态页面
'	所有语言以及分类
'=========================================
Sub HtmlAllProSort
	set rsh = server.createobject("adodb.recordset")
	sqlh="SELECT * FROM ChinaQJ_Language WHERE ChinaQJ_Language_State ORDER BY ChinaQJ_Language_Order"	'--	获取所有语言类别[设置为显示的]
	rsh.open sqlh,conn,0,1
	If rsh.eof Then 
		Response.write("<div class=""page""><strong style=""color:red"">Error:获取语言信息时出错!</strong></div>")	'--木有
		exit Sub
	Else
		Do While Not rsh.eof							'-----------循环所有语言类别
			ThisLanguage=rsh("ChinaQJ_Language_File")	'语言文件目录
			ThisLanName=rsh("ChinaQJ_Language_Name")	'语言名称
			Response.Write("<script>bar_txt1.innerHTML=""正在生成【"&ThisLanName&"】版【所有产品列表】页面,请稍等...""</script>")
			Response.Flush
			Call CallProHtml("ChinaQJ_Products",ThisLanguage,"","ProductList.asp","Product")							'--生成所有
			Response.Write("<script>bar_txt1.innerHTML=""正在生成【"&ThisLanName&"】版【新开模产品】页面,请稍等...""</script>")
			Response.Flush
			Call CallProHtml("ChinaQJ_Products",ThisLanguage,"NewFlag"&ThisLanguage,"NewProductList.asp","NewProduct")	'--生成最新			
			Dim myrs
			Set myrs = server.createobject("adodb.recordset")
			myStrSql="select * from ChinaQJ_ProductSort WHERE ViewFlag"&ThisLanguage&" order by ID desc"	'--获取所有分类信息
			myrs.open myStrSql,conn,0,1
			If myrs.eof Then 
				Response.write("<div class=""page""><strong style=""color:red"">Error:获取分类信息时出错!</strong></div>")	'--木有分类
				exit Sub
			Else
				Do While Not myrs.eof			'-----------------------------------------------------循环生成各分类版HTML
					Response.Write("<script>bar_txt1.innerHTML=""正在生成【"&ThisLanName&"】版【"&myrs("SortName"&ThisLanguage)&"】页面,请稍等...""</script>")
					Response.Flush
					Call CallProHtml("ChinaQJ_Products",ThisLanguage,"SortID = "&myrs("ID"),"ProductList.asp",myrs("ClassSeo"))	'--生成分类html
					myrs.movenext	'--下一个分类
				Loop
			End If
			myrs.close		'--关闭分类数据连接
			rsh.movenext	'-- 下一个语言
		Loop
	End If
	rsh.close		'--关闭语言数据连接
End Sub

'===============================================
'	生成所有产品详细静态页面
'
'===============================================
Sub HtmlPro
	set rsh = server.createobject("adodb.recordset")
	sqlh="SELECT * FROM ChinaQJ_Language WHERE ChinaQJ_Language_State ORDER BY ChinaQJ_Language_Order"	'--	获取所有语言类别[设置为显示的]
	rsh.open sqlh,conn,0,1
	If rsh.eof Then 
		Response.write("<div class=""page""><strong style=""color:red"">Error:获取语言信息时出错!</strong></div>")	'--木有
		exit Sub
	Else
		Do While Not rsh.eof							'-----------循环所有语言类别
			ThisLanguage=rsh("ChinaQJ_Language_File")	'语言文件目录
			ThisLanName=rsh("ChinaQJ_Language_Name")	'语言名称
			Dim myrs
			Set myrs = server.createobject("adodb.recordset")
			myStrSql="select * from ChinaQJ_Products WHERE ViewFlag"&ThisLanguage&" order by ID desc"	'--获取所有产品信息
			myrs.open myStrSql,conn,0,1
			If myrs.eof Then 
				Response.write("<div class=""page""><strong style=""color:red"">Error:获取产品信息时出错!</strong></div>")	'--木有产品
				exit Sub
			Else
				icount=conn.Execute("SELECT COUNT(*) FROM ChinaQJ_Products WHERE ViewFlag"&ThisLanguage)(0)
				i=0
				Do While Not myrs.eof			'-----------------------------------------------------循环生成各产品HTML
					i=i+1
					Response.Write("<script>bar_txt1.innerHTML=""正在生成【"&ThisLanName&"】版【所有产品详细】页面,请稍等...""</script>")
					Response.Flush
					hurl="http://"&Request.ServerVariables("Http_Host")&"/"&ThisLanguage&"/"&"ProductView.Asp"
					furl=Server.MapPath("/")&"\"&ThisLanguage&"\"&myrs("ClassSeo")&"-"&myrs("ID")
					call CHtmlPage(hurl&"?ID="&myrs("ID"),furl&"."&HTMLName)
					call mShowMI(int((i/icount)*300),int((i/icount)*100),i)
					myrs.movenext	'--下一个分类
				Loop
			End If
			myrs.close		'--关闭所有信息数据连接
			rsh.movenext	'-- 下一个语言
		Loop
	End If
	rsh.close		'--关闭语言数据连接
End Sub

'==============================================
'	生成新闻分类页面
'
'==============================================
Sub HtmlNewSort
	set rsh = server.createobject("adodb.recordset")
	sqlh="SELECT * FROM ChinaQJ_Language WHERE ChinaQJ_Language_State ORDER BY ChinaQJ_Language_Order"	'--	获取所有语言类别[设置为显示的]
	rsh.open sqlh,conn,0,1
	If rsh.eof Then 
		Response.write("<div class=""page""><strong style=""color:red"">Error:获取语言信息时出错!</strong></div>")	'--木有
		exit Sub
	Else
		Do While Not rsh.eof							'-----------循环所有语言类别
			ThisLanguage=rsh("ChinaQJ_Language_File")	'语言文件目录
			ThisLanName=rsh("ChinaQJ_Language_Name")	'语言名称
			Response.Write("<script>bar_txt1.innerHTML=""正在生成【"&ThisLanName&"】版【所有新闻列表】页面,请稍等...""</script>")
			Response.Flush
			Call CallProHtml("ChinaQJ_News",ThisLanguage,"","NewsList.asp","New")							'--生成所有
			Dim myrs
			Set myrs = server.createobject("adodb.recordset")
			myStrSql="select * from ChinaQJ_NewsSort WHERE ViewFlag"&ThisLanguage&" order by ID desc"	'--获取所有分类信息
			myrs.open myStrSql,conn,0,1
			If myrs.eof Then 
				Response.write("<div class=""page""><strong style=""color:red"">Error:获取分类信息时出错!</strong></div>")	'--木有分类
				exit Sub
			Else
				Do While Not myrs.eof			'-----------------------------------------------------循环生成各分类版HTML
					Response.Write("<script>bar_txt1.innerHTML=""正在生成【"&ThisLanName&"】版【"&myrs("SortName"&ThisLanguage)&"】页面,请稍等...""</script>")
					Response.Flush
					Call CallProHtml("ChinaQJ_News",ThisLanguage,"SortID = "&myrs("ID"),"NewsList.asp",myrs("ClassSeo"))	'--生成分类html
					myrs.movenext	'--下一个分类
				Loop
			End If
			myrs.close		'--关闭分类数据连接
			rsh.movenext	'-- 下一个语言
		Loop
	End If
	rsh.close		'--关闭语言数据连接
End Sub

'===============================================
'	生成所有新闻详细静态页面
'
'===============================================
Sub HtmlNews
	set rsh = server.createobject("adodb.recordset")
	sqlh="SELECT * FROM ChinaQJ_Language WHERE ChinaQJ_Language_State ORDER BY ChinaQJ_Language_Order"	'--	获取所有语言类别[设置为显示的]
	rsh.open sqlh,conn,0,1
	If rsh.eof Then 
		Response.write("<div class=""page""><strong style=""color:red"">Error:获取语言信息时出错!</strong></div>")	'--木有
		exit Sub
	Else
		Do While Not rsh.eof							'-----------循环所有语言类别
			ThisLanguage=rsh("ChinaQJ_Language_File")	'语言文件目录
			ThisLanName=rsh("ChinaQJ_Language_Name")	'语言名称
			Dim myrs
			Set myrs = server.createobject("adodb.recordset")
			myStrSql="select * from ChinaQJ_News where ViewFlag"&ThisLanguage&" order by ID desc"	'--获取所有信息
			myrs.open myStrSql,conn,0,1
			If myrs.eof Then 
				Response.write("<div class=""page""><strong style=""color:red"">Error:获取新闻信息时出错!</strong></div>")	'--木有
				exit Sub
			Else
				icount=conn.Execute("SELECT COUNT(*) FROM ChinaQJ_News WHERE ViewFlag"&ThisLanguage)(0)
				i=0
				Do While Not myrs.eof			'-----------------------------------------------------循环生成各产品HTML
					i=i+1
					Response.Write("<script>bar_txt1.innerHTML=""正在生成【"&ThisLanName&"】版【所有新闻详细】页面,请稍等...""</script>")
					Response.Flush
					hurl="http://"&Request.ServerVariables("Http_Host")&"/"&ThisLanguage&"/"&"NewsView.Asp"
					furl=Server.MapPath("/")&"\"&ThisLanguage&"\"&myrs("ClassSeo")&"-"&myrs("ID")
					call CHtmlPage(hurl&"?ID="&myrs("ID"),furl&"."&HTMLName)
					call mShowMI(int((i/icount)*300),int((i/icount)*100),i)
					myrs.movenext	'--下一个分类
				Loop
			End If
			myrs.close		'--关闭所有信息数据连接
			rsh.movenext	'-- 下一个语言
		Loop
	End If
	rsh.close		'--关闭语言数据连接
End Sub

'===============================================
'	生成所有企业信息静态页面
'
'===============================================
Sub HtmlInfo
	set rsh = server.createobject("adodb.recordset")
	sqlh="SELECT * FROM ChinaQJ_Language WHERE ChinaQJ_Language_State ORDER BY ChinaQJ_Language_Order"	'--	获取所有语言类别[设置为显示的]
	rsh.open sqlh,conn,0,1
	If rsh.eof Then 
		Response.write("<div class=""page""><strong style=""color:red"">Error:获取语言信息时出错!</strong></div>")	'--木有
		exit Sub
	Else
		Do While Not rsh.eof							'-----------循环所有语言类别
			ThisLanguage=rsh("ChinaQJ_Language_File")	'语言文件目录
			ThisLanName=rsh("ChinaQJ_Language_Name")	'语言名称
			Dim myrs
			Set myrs = server.createobject("adodb.recordset")
			myStrSql="select * from ChinaQJ_About WHERE ViewFlag"&ThisLanguage&" order by ID desc"	'--获取所有信息
			myrs.open myStrSql,conn,0,1
			If myrs.eof Then 
				Response.write("<div class=""page""><strong style=""color:red"">Error:获取企业信息时出错!</strong></div>")	'--木有
				exit Sub
			Else
				icount=conn.Execute("SELECT COUNT(*) FROM ChinaQJ_About WHERE ViewFlag"&ThisLanguage)(0)
				i=0
				Do While Not myrs.eof			'-----------------------------------------------------循环生成各产品HTML
					i=i+1
					Response.Write("<script>bar_txt1.innerHTML=""正在生成【"&ThisLanName&"】版【所有企业信息详细】页面,请稍等...""</script>")
					Response.Flush
					hurl="http://"&Request.ServerVariables("Http_Host")&"/"&ThisLanguage&"/"&"About.Asp"
					furl=Server.MapPath("/")&"\"&ThisLanguage&"\"&myrs("ClassSeo")&"-"&myrs("ID")
					call CHtmlPage(hurl&"?ID="&myrs("ID"),furl&"."&HTMLName)
					call mShowMI(int((i/icount)*300),int((i/icount)*100),i)
					myrs.movenext	'--下一个分类
				Loop
			End If
			myrs.close		'--关闭所有信息数据连接
			rsh.movenext	'-- 下一个语言
		Loop
	End If
	rsh.close		'--关闭语言数据连接
End Sub

'==============================================
'	生成下载分类页面
'
'==============================================
Sub HtmlDownSort
	set rsh = server.createobject("adodb.recordset")
	sqlh="SELECT * FROM ChinaQJ_Language WHERE ChinaQJ_Language_State ORDER BY ChinaQJ_Language_Order"	'--	获取所有语言类别[设置为显示的]
	rsh.open sqlh,conn,0,1
	If rsh.eof Then 
		Response.write("<div class=""page""><strong style=""color:red"">Error:获取语言信息时出错!</strong></div>")	'--木有
		exit Sub
	Else
		Do While Not rsh.eof							'-----------循环所有语言类别
			ThisLanguage=rsh("ChinaQJ_Language_File")	'语言文件目录
			ThisLanName=rsh("ChinaQJ_Language_Name")	'语言名称
			Response.Write("<script>bar_txt1.innerHTML=""正在生成【"&ThisLanName&"】版【所有所有下载列表】页面,请稍等...""</script>")
			Response.Flush
			Call CallProHtml("ChinaQJ_Download",ThisLanguage,"","DownList.asp","Download")							'--生成所有
			Dim myrs
			Set myrs = server.createobject("adodb.recordset")
			myStrSql="select * from ChinaQJ_DownSort WHERE ViewFlag"&ThisLanguage&" order by ID desc"	'--获取所有分类信息
			myrs.open myStrSql,conn,0,1
			If myrs.eof Then 
				Response.write("<div class=""page""><strong style=""color:red"">Error:获取分类信息时出错!</strong></div>")	'--木有分类
				exit Sub
			Else
				Do While Not myrs.eof			'-----------------------------------------------------循环生成各分类版HTML
					Response.Write("<script>bar_txt1.innerHTML=""正在生成【"&ThisLanName&"】版【"&myrs("SortName"&ThisLanguage)&"】页面,请稍等...""</script>")
					Response.Flush
					Call CallProHtml("ChinaQJ_Download",ThisLanguage,"SortID = "&myrs("ID"),"DownList.asp",myrs("ClassSeo"))	'--生成分类html
					myrs.movenext	'--下一个分类
				Loop
			End If
			myrs.close		'--关闭分类数据连接
			rsh.movenext	'-- 下一个语言
		Loop
	End If
	rsh.close		'--关闭语言数据连接
End Sub

'===============================================
'	生成下载详细静态页面
'
'===============================================
Sub HtmlDown
	set rsh = server.createobject("adodb.recordset")
	sqlh="SELECT * FROM ChinaQJ_Language WHERE ChinaQJ_Language_State ORDER BY ChinaQJ_Language_Order"	'--	获取所有语言类别[设置为显示的]
	rsh.open sqlh,conn,0,1
	If rsh.eof Then 
		Response.write("<div class=""page""><strong style=""color:red"">Error:获取语言信息时出错!</strong></div>")	'--木有
		exit Sub
	Else
		Do While Not rsh.eof							'-----------循环所有语言类别
			ThisLanguage=rsh("ChinaQJ_Language_File")	'语言文件目录
			ThisLanName=rsh("ChinaQJ_Language_Name")	'语言名称
			Dim myrs
			Set myrs = server.createobject("adodb.recordset")
			myStrSql="select * from ChinaQJ_Download WHERE ViewFlag"&ThisLanguage&" order by ID desc"	'--获取所有信息
			myrs.open myStrSql,conn,0,1
			If myrs.eof Then 
				Response.write("<div class=""page""><strong style=""color:red"">Error:获取企业信息时出错!</strong></div>")	'--木有
				exit Sub
			Else
				icount=conn.Execute("SELECT COUNT(*) FROM ChinaQJ_Download WHERE ViewFlag"&ThisLanguage)(0)
				i=0
				Do While Not myrs.eof			'-----------------------------------------------------循环生成各产品HTML
					i=i+1
					Response.Write("<script>bar_txt1.innerHTML=""正在生成【"&ThisLanName&"】版【所有下载详细】页面,请稍等...""</script>")
					Response.Flush
					hurl="http://"&Request.ServerVariables("Http_Host")&"/"&ThisLanguage&"/"&"DownView.Asp"
					furl=Server.MapPath("/")&"\"&ThisLanguage&"\"&myrs("ClassSeo")&"-"&myrs("ID")
					call CHtmlPage(hurl&"?ID="&myrs("ID"),furl&"."&HTMLName)
					call mShowMI(int((i/icount)*300),int((i/icount)*100),i)
					myrs.movenext	'--下一个分类
				Loop
			End If
			myrs.close		'--关闭所有信息数据连接
			rsh.movenext	'-- 下一个语言
		Loop
	End If
	rsh.close		'--关闭语言数据连接
End Sub

'===============================================
'	生成招聘列表静态页面(Error)
'
'===============================================
Sub HtmlJobSort
	set rsh = server.createobject("adodb.recordset")
	sqlh="SELECT * FROM ChinaQJ_Language WHERE ChinaQJ_Language_State ORDER BY ChinaQJ_Language_Order"	'--	获取所有语言类别[设置为显示的]
	rsh.open sqlh,conn,0,1
	If rsh.eof Then 
		Response.write("<div class=""page""><strong style=""color:red"">Error:获取语言信息时出错!</strong></div>")	'--木有
		exit Sub
	Else
		Do While Not rsh.eof							'-----------循环所有语言类别
			ThisLanguage=rsh("ChinaQJ_Language_File")	'语言文件目录
			ThisLanName=rsh("ChinaQJ_Language_Name")	'语言名称
			Response.Write("<script>bar_txt1.innerHTML=""正在生成【"&ThisLanName&"】版【所有所有招聘列表】页面,请稍等...""</script>")
			Response.Flush
			Call CallProHtml("ChinaQJ_Jobs",ThisLanguage,"","JobsList.asp","job")							'--生成所有
			'Dim myrs
			'Set myrs = server.createobject("adodb.recordset")
			'myStrSql="select * from ChinaQJ_Jobs WHERE ViewFlag"&ThisLanguage&" order by ID desc"	'--获取所有分类信息
			'myrs.open myStrSql,conn,0,1
			'If myrs.eof Then 
			'	Response.write("<div class=""page""><strong style=""color:red"">Error:获取分类信息时出错!</strong></div>")	'--木有分类
			'	exit Sub
			'Else
			'	Do While Not myrs.eof			'-----------------------------------------------------循环生成各分类版HTML
			'		Response.Write("<script>bar_txt1.innerHTML=""正在生成【"&ThisLanName&"】版【"&myrs("SortName"&ThisLanguage)&"】页面,请稍等...""</script>")
			'		Response.Flush
			'		Call CallProHtml("ChinaQJ_Jobs",ThisLanguage,"SortID = "&myrs("ID"),"JobsList.asp",myrs("ClassSeo"))	'--生成分类html
			'		myrs.movenext	'--下一个分类
			'	Loop
			'End If
			'myrs.close		'--关闭分类数据连接
			rsh.movenext	'-- 下一个语言
		Loop
	End If
	rsh.close		'--关闭语言数据连接
End Sub

'===============================================
'	生成招聘详细静态页面
'
'===============================================
Sub HtmlJob_New
	set rsh = server.createobject("adodb.recordset")
	sqlh="SELECT * FROM ChinaQJ_Language WHERE ChinaQJ_Language_State ORDER BY ChinaQJ_Language_Order"	'--	获取所有语言类别[设置为显示的]
	rsh.open sqlh,conn,0,1
	If rsh.eof Then 
		Response.write("<div class=""page""><strong style=""color:red"">Error:获取语言信息时出错!</strong></div>")	'--木有
		exit Sub
	Else
		Do While Not rsh.eof							'-----------循环所有语言类别
			ThisLanguage=rsh("ChinaQJ_Language_File")	'语言文件目录
			ThisLanName=rsh("ChinaQJ_Language_Name")	'语言名称
			Dim myrs
			Set myrs = server.createobject("adodb.recordset")
			myStrSql="select * from ChinaQJ_Jobs WHERE ViewFlag"&ThisLanguage&" order by ID desc"	'--获取所有信息
			myrs.open myStrSql,conn,0,1
			If myrs.eof Then 
				Response.write("<div class=""page""><strong style=""color:red"">Error:获取招聘信息时出错!</strong></div>")	'--木有
				exit Sub
			Else
				icount=conn.Execute("SELECT COUNT(*) FROM ChinaQJ_Jobs WHERE ViewFlag"&ThisLanguage)(0)
				i=0
				Do While Not myrs.eof			'-----------------------------------------------------循环生成各产品HTML
					i=i+1
					Response.Write("<script>bar_txt1.innerHTML=""正在生成【"&ThisLanName&"】版【所有人才详细】页面,请稍等...""</script>")
					Response.Flush
					hurl="http://"&Request.ServerVariables("Http_Host")&"/"&ThisLanguage&"/"&"JobsView.Asp"
					furl=Server.MapPath("/")&"\"&ThisLanguage&"\"&myrs("ClassSeo")&"-"&myrs("ID")
					call CHtmlPage(hurl&"?ID="&myrs("ID"),furl&"."&HTMLName)
					call mShowMI(int((i/icount)*300),int((i/icount)*100),i)
					myrs.movenext	'--下一个分类
				Loop
			End If
			myrs.close		'--关闭所有信息数据连接
			rsh.movenext	'-- 下一个语言
		Loop
	End If
	rsh.close		'--关闭语言数据连接
End Sub

'===============================================
'	生成其它列表静态页面
'
'===============================================
Sub HtmlOtherSort
	set rsh = server.createobject("adodb.recordset")
	sqlh="SELECT * FROM ChinaQJ_Language WHERE ChinaQJ_Language_State ORDER BY ChinaQJ_Language_Order"	'--	获取所有语言类别[设置为显示的]
	rsh.open sqlh,conn,0,1
	If rsh.eof Then 
		Response.write("<div class=""page""><strong style=""color:red"">Error:获取语言信息时出错!</strong></div>")	'--木有
		exit Sub
	Else
		Do While Not rsh.eof							'-----------循环所有语言类别
			ThisLanguage=rsh("ChinaQJ_Language_File")	'语言文件目录
			ThisLanName=rsh("ChinaQJ_Language_Name")	'语言名称
			Response.Write("<script>bar_txt1.innerHTML=""正在生成【"&ThisLanName&"】版【所有其它分类列表】页面,请稍等...""</script>")
			Response.Flush
			Call CallProHtml("ChinaQJ_Others",ThisLanguage,"","OtherList.asp","Info")							'--生成所有
			Dim myrs
			Set myrs = server.createobject("adodb.recordset")
			myStrSql="select * from ChinaQJ_OthersSort WHERE ViewFlag"&ThisLanguage&" order by ID desc"	'--获取所有分类信息
			myrs.open myStrSql,conn,0,1
			If myrs.eof Then 
				Response.write("<div class=""page""><strong style=""color:red"">Error:获取分类信息时出错!</strong></div>")	'--木有分类
				exit Sub
			Else
				Do While Not myrs.eof			'-----------------------------------------------------循环生成各分类版HTML
					Response.Write("<script>bar_txt1.innerHTML=""正在生成【"&ThisLanName&"】版【"&myrs("SortName"&ThisLanguage)&"】页面,请稍等...""</script>")
					Response.Flush
					Call CallProHtml("ChinaQJ_Others",ThisLanguage,"SortID = "&myrs("ID"),"OtherList.asp",myrs("ClassSeo"))	'--生成分类html
					myrs.movenext	'--下一个分类
				Loop
			End If
			myrs.close		'--关闭分类数据连接
			rsh.movenext	'-- 下一个语言
		Loop
	End If
	rsh.close		'--关闭语言数据连接
End Sub

'===============================================
'	生成其它详细静态页面
'
'===============================================
Sub HtmlOther
	set rsh = server.createobject("adodb.recordset")
	sqlh="SELECT * FROM ChinaQJ_Language WHERE ChinaQJ_Language_State ORDER BY ChinaQJ_Language_Order"	'--	获取所有语言类别[设置为显示的]
	rsh.open sqlh,conn,0,1
	If rsh.eof Then 
		Response.write("<div class=""page""><strong style=""color:red"">Error:获取语言信息时出错!</strong></div>")	'--木有
		exit Sub
	Else
		Do While Not rsh.eof							'-----------循环所有语言类别
			ThisLanguage=rsh("ChinaQJ_Language_File")	'语言文件目录
			ThisLanName=rsh("ChinaQJ_Language_Name")	'语言名称
			Dim myrs
			Set myrs = server.createobject("adodb.recordset")
			myStrSql="select * from ChinaQJ_Others WHERE ViewFlag"&ThisLanguage&" order by ID desc"	'--获取所有信息
			myrs.open myStrSql,conn,0,1
			If myrs.eof Then 
				Response.write("<div class=""page""><strong style=""color:red"">Error:获取招聘信息时出错!</strong></div>")	'--木有
				exit Sub
			Else
				icount=conn.Execute("SELECT COUNT(*) FROM ChinaQJ_Others WHERE ViewFlag"&ThisLanguage)(0)
				i=0
				Do While Not myrs.eof			'-----------------------------------------------------循环生成各产品HTML
					i=i+1
					Response.Write("<script>bar_txt1.innerHTML=""正在生成【"&ThisLanName&"】版【所有其它详细】页面,请稍等...""</script>")
					Response.Flush
					hurl="http://"&Request.ServerVariables("Http_Host")&"/"&ThisLanguage&"/"&"OtherView.Asp"
					furl=Server.MapPath("/")&"\"&ThisLanguage&"\"&myrs("ClassSeo")&"-"&myrs("ID")
					call CHtmlPage(hurl&"?ID="&myrs("ID"),furl&"."&HTMLName)
					call mShowMI(int((i/icount)*300),int((i/icount)*100),i)
					myrs.movenext	'--下一个分类
				Loop
			End If
			myrs.close		'--关闭所有信息数据连接
			rsh.movenext	'-- 下一个语言
		Loop
	End If
	rsh.close		'--关闭语言数据连接
End Sub

'===============================================
'	生成服务范围列表静态页面	(Error)
'
'===============================================
Sub HtmlKeySort_New
	set rsh = server.createobject("adodb.recordset")
	sqlh="SELECT * FROM ChinaQJ_Language WHERE ChinaQJ_Language_State ORDER BY ChinaQJ_Language_Order"	'--	获取所有语言类别[设置为显示的]
	rsh.open sqlh,conn,0,1
	If rsh.eof Then 
		Response.write("<div class=""page""><strong style=""color:red"">Error:获取语言信息时出错!</strong></div>")	'--木有
		exit Sub
	Else
		Do While Not rsh.eof							'-----------循环所有语言类别
			ThisLanguage=rsh("ChinaQJ_Language_File")	'语言文件目录
			ThisLanName=rsh("ChinaQJ_Language_Name")	'语言名称

			'Call CallProHtml("ChinaQJ_Key",ThisLanguage,"","KeyList.asp","key")

			rsh.movenext	'-- 下一个语言
		Loop
	End If
	rsh.close		'--关闭语言数据连接
End Sub

'===============================================
'	生成服务范围详细静态页面	(Error)
'
'===============================================
Sub HtmlKey_New
	set rsh = server.createobject("adodb.recordset")
	sqlh="SELECT * FROM ChinaQJ_Language WHERE ChinaQJ_Language_State ORDER BY ChinaQJ_Language_Order"	'--	获取所有语言类别[设置为显示的]
	rsh.open sqlh,conn,0,1
	If rsh.eof Then 
		Response.write("<div class=""page""><strong style=""color:red"">Error:获取语言信息时出错!</strong></div>")	'--木有
		exit Sub
	Else
		Do While Not rsh.eof							'-----------循环所有语言类别
			ThisLanguage=rsh("ChinaQJ_Language_File")	'语言文件目录
			ThisLanName=rsh("ChinaQJ_Language_Name")	'语言名称
			Dim myrs
			Set myrs = server.createobject("adodb.recordset")
			myStrSql="select * from ChinaQJ_Key WHERE ViewFlag"&ThisLanguage&" order by ID desc"	'--获取所有信息
			myrs.open myStrSql,conn,0,1
			If myrs.eof Then 
				Response.write("<div class=""page""><strong style=""color:red"">Error:获取信息时出错!</strong></div>")	'--木有
				exit Sub
			Else
				icount=conn.Execute("SELECT COUNT(*) FROM ChinaQJ_Key WHERE ViewFlag"&ThisLanguage)(0)
				i=0
				Do While Not myrs.eof			'-----------------------------------------------------循环生成各产品HTML
					i=i+1
					Response.Write("<script>bar_txt1.innerHTML=""正在生成【"&ThisLanName&"】版【所有服务范围详细】页面,请稍等...""</script>")
					Response.Flush
					hurl="http://"&Request.ServerVariables("Http_Host")&"/"&ThisLanguage&"/"&"KeyView.Asp"
					furl=Server.MapPath("/")&"\"&ThisLanguage&"\"&myrs("ClassSeo")&"-"&myrs("ID")
					call CHtmlPage(hurl&"?ID="&myrs("ID"),furl&"."&HTMLName)
					call mShowMI(int((i/icount)*300),int((i/icount)*100),i)
					myrs.movenext	'--下一个分类
				Loop
			End If
			myrs.close		'--关闭所有信息数据连接
			rsh.movenext	'-- 下一个语言
		Loop
	End If
	rsh.close		'--关闭语言数据连接
End Sub

'===============================================
'	生成图片案例列表静态页面
'
'===============================================
Sub HtmlimageSort
	set rsh = server.createobject("adodb.recordset")
	sqlh="SELECT * FROM ChinaQJ_Language WHERE ChinaQJ_Language_State ORDER BY ChinaQJ_Language_Order"	'--	获取所有语言类别[设置为显示的]
	rsh.open sqlh,conn,0,1
	If rsh.eof Then 
		Response.write("<div class=""page""><strong style=""color:red"">Error:获取语言信息时出错!</strong></div>")	'--木有
		exit Sub
	Else
		Do While Not rsh.eof							'-----------循环所有语言类别
			ThisLanguage=rsh("ChinaQJ_Language_File")	'语言文件目录
			ThisLanName=rsh("ChinaQJ_Language_Name")	'语言名称
			Response.Write("<script>bar_txt1.innerHTML=""正在生成【"&ThisLanName&"】版【所有其它分类列表】页面,请稍等...""</script>")
			Response.Flush
			Call CallProHtml("ChinaQJ_image",ThisLanguage,"","ImageList.asp","Image")							'--生成所有
			Dim myrs
			Set myrs = server.createobject("adodb.recordset")
			myStrSql="select * from ChinaQJ_ImageSort WHERE ViewFlag"&ThisLanguage&" order by ID desc"	'--获取所有分类信息
			myrs.open myStrSql,conn,0,1
			If myrs.eof Then 
				Response.write("<div class=""page""><strong style=""color:red"">Error:获取分类信息时出错!</strong></div>")	'--木有分类
				exit Sub
			Else
				Do While Not myrs.eof			'-----------------------------------------------------循环生成各分类版HTML
					Response.Write("<script>bar_txt1.innerHTML=""正在生成【"&ThisLanName&"】版【"&myrs("SortName"&ThisLanguage)&"】页面,请稍等...""</script>")
					Response.Flush
					Call CallProHtml("ChinaQJ_image",ThisLanguage,"SortID = "&myrs("ID"),"ImageList.asp",myrs("ClassSeo"))	'--生成分类html
					myrs.movenext	'--下一个分类
				Loop
			End If
			myrs.close		'--关闭分类数据连接
			rsh.movenext	'-- 下一个语言
		Loop
	End If
	rsh.close		'--关闭语言数据连接
End Sub

'===============================================
'	生成图片案例详细静态页面
'
'===============================================
Sub HtmlImage
	set rsh = server.createobject("adodb.recordset")
	sqlh="SELECT * FROM ChinaQJ_Language WHERE ChinaQJ_Language_State ORDER BY ChinaQJ_Language_Order"	'--	获取所有语言类别[设置为显示的]
	rsh.open sqlh,conn,0,1
	If rsh.eof Then 
		Response.write("<div class=""page""><strong style=""color:red"">Error:获取语言信息时出错!</strong></div>")	'--木有
		exit Sub
	Else
		Do While Not rsh.eof							'-----------循环所有语言类别
			ThisLanguage=rsh("ChinaQJ_Language_File")	'语言文件目录
			ThisLanName=rsh("ChinaQJ_Language_Name")	'语言名称
			Dim myrs
			Set myrs = server.createobject("adodb.recordset")
			myStrSql="select * from ChinaQJ_Image WHERE ViewFlag"&ThisLanguage&" order by ID desc"	'--获取所有信息
			myrs.open myStrSql,conn,0,1
			If myrs.eof Then 
				Response.write("<div class=""page""><strong style=""color:red"">Error:获取信息时出错!</strong></div>")	'--木有
				exit Sub
			Else
				icount=conn.Execute("SELECT COUNT(*) FROM ChinaQJ_Image WHERE ViewFlag"&ThisLanguage)(0)
				i=0
				Do While Not myrs.eof			'-----------------------------------------------------循环生成各产品HTML
					i=i+1
					Response.Write("<script>bar_txt1.innerHTML=""正在生成【"&ThisLanName&"】版【所有图片案例详细】页面,请稍等...""</script>")
					Response.Flush
					hurl="http://"&Request.ServerVariables("Http_Host")&"/"&ThisLanguage&"/"&"ImageView.Asp"
					furl=Server.MapPath("/")&"\"&ThisLanguage&"\"&myrs("ClassSeo")&"-"&myrs("ID")
					call CHtmlPage(hurl&"?ID="&myrs("ID"),furl&"."&HTMLName)
					call mShowMI(int((i/icount)*300),int((i/icount)*100),i)
					myrs.movenext	'--下一个分类
				Loop
			End If
			myrs.close		'--关闭所有信息数据连接
			rsh.movenext	'-- 下一个语言
		Loop
	End If
	rsh.close		'--关闭语言数据连接
End Sub

'===============================================
'	生成视频分类列表静态页面
'
'===============================================
Sub HtmlVideoSort
	set rsh = server.createobject("adodb.recordset")
	sqlh="SELECT * FROM ChinaQJ_Language WHERE ChinaQJ_Language_State ORDER BY ChinaQJ_Language_Order"	'--	获取所有语言类别[设置为显示的]
	rsh.open sqlh,conn,0,1
	If rsh.eof Then 
		Response.write("<div class=""page""><strong style=""color:red"">Error:获取语言信息时出错!</strong></div>")	'--木有
		exit Sub
	Else
		Do While Not rsh.eof							'-----------循环所有语言类别
			ThisLanguage=rsh("ChinaQJ_Language_File")	'语言文件目录
			ThisLanName=rsh("ChinaQJ_Language_Name")	'语言名称
			Response.Write("<script>bar_txt1.innerHTML=""正在生成【"&ThisLanName&"】版【所有其它分类列表】页面,请稍等...""</script>")
			Response.Flush
			Call CallProHtml("ChinaQJ_Video",ThisLanguage,"","VideoList.asp","Video")							'--生成所有
			Dim myrs
			Set myrs = server.createobject("adodb.recordset")
			myStrSql="select * from ChinaQJ_VideoSort WHERE ViewFlag"&ThisLanguage&" order by ID desc"	'--获取所有分类信息
			myrs.open myStrSql,conn,0,1
			If myrs.eof Then 
				Response.write("<div class=""page""><strong style=""color:red"">Error:获取分类信息时出错!</strong></div>")	'--木有分类
				exit Sub
			Else
				Do While Not myrs.eof			'-----------------------------------------------------循环生成各分类版HTML
					Response.Write("<script>bar_txt1.innerHTML=""正在生成【"&ThisLanName&"】版【"&myrs("SortName"&ThisLanguage)&"】页面,请稍等...""</script>")
					Response.Flush
					Call CallProHtml("ChinaQJ_Video",ThisLanguage,"SortID = "&myrs("ID"),"VideoList.asp",myrs("ClassSeo"))	'--生成分类html
					myrs.movenext	'--下一个分类
				Loop
			End If
			myrs.close		'--关闭分类数据连接
			rsh.movenext	'-- 下一个语言
		Loop
	End If
	rsh.close		'--关闭语言数据连接
End Sub

'===============================================
'	生成电子杂志静态页面
'
'===============================================
Sub HtmlMagazineSort
	set rsh = server.createobject("adodb.recordset")
	sqlh="SELECT * FROM ChinaQJ_Language WHERE ChinaQJ_Language_State ORDER BY ChinaQJ_Language_Order"	'--	获取所有语言类别[设置为显示的]
	rsh.open sqlh,conn,0,1
	If rsh.eof Then 
		Response.write("<div class=""page""><strong style=""color:red"">Error:获取语言信息时出错!</strong></div>")	'--木有
		exit Sub
	Else
		Do While Not rsh.eof							'-----------循环所有语言类别
			ThisLanguage=rsh("ChinaQJ_Language_File")	'语言文件目录
			ThisLanName=rsh("ChinaQJ_Language_Name")	'语言名称
			Response.Write("<script>bar_txt1.innerHTML=""正在生成【"&ThisLanName&"】版【所有其它分类列表】页面,请稍等...""</script>")
			Response.Flush
			Call CallProHtml("ChinaQJ_Magazine",ThisLanguage,"","MagazineList.asp","Magazine")							'--生成所有
			Dim myrs
			Set myrs = server.createobject("adodb.recordset")
			myStrSql="select * from ChinaQJ_MagazineSort WHERE ViewFlag"&ThisLanguage&" order by ID desc"	'--获取所有分类信息
			myrs.open myStrSql,conn,0,1
			If myrs.eof Then 
				Response.write("<div class=""page""><strong style=""color:red"">Error:获取分类信息时出错!</strong></div>")	'--木有分类
				exit Sub
			Else
				Do While Not myrs.eof			'-----------------------------------------------------循环生成各分类版HTML
					Response.Write("<script>bar_txt1.innerHTML=""正在生成【"&ThisLanName&"】版【"&myrs("SortName"&ThisLanguage)&"】页面,请稍等...""</script>")
					Response.Flush
					Call CallProHtml("ChinaQJ_Magazine",ThisLanguage,"SortID = "&myrs("ID"),"MagazineList.asp",myrs("ClassSeo"))	'--生成分类html
					myrs.movenext	'--下一个分类
				Loop
			End If
			myrs.close		'--关闭分类数据连接
			rsh.movenext	'-- 下一个语言
		Loop
	End If
	rsh.close		'--关闭语言数据连接
End Sub

'===============================================
'	生成首页及其它静态页面
'
'===============================================
Sub HtmlIndex
	set rsh = server.createobject("adodb.recordset")
	sqlh="SELECT * FROM ChinaQJ_Language WHERE ChinaQJ_Language_State ORDER BY ChinaQJ_Language_Order"	'--	获取所有语言类别[设置为显示的]
	rsh.open sqlh,conn,0,1
	If rsh.eof Then 
		Response.write("<div class=""page""><strong style=""color:red"">Error:获取语言信息时出错!</strong></div>")	'--木有
		exit Sub
	Else
		Do While Not rsh.eof							'-----------循环所有语言类别
			ThisLanguage=rsh("ChinaQJ_Language_File")	'语言文件目录
			ThisLanName=rsh("ChinaQJ_Language_Name")	'语言名称
			
			hurl="http://"&Request.ServerVariables("Http_Host")&"/"&ThisLanguage&"/"
			furl=Server.MapPath("/")&"\"&ThisLanguage&"\"

			Response.Write("<script>bar_txt1.innerHTML=""正在生成【"&ThisLanName&"】版【首页】页面,请稍等...""</script>")
			Response.Flush
			call CHtmlPage(hurl&"Index.Asp",furl&"Index."&HTMLName)
			call mShowMI(int((1/2)*300),int((1/2)*100),1)

			Response.Write("<script>bar_txt1.innerHTML=""正在生成【"&ThisLanName&"】版【关于我们分类】页面,请稍等...""</script>")
			Response.Flush
			call CHtmlPage(hurl&"Company.Asp",furl&"Company."&HTMLName)
			call mShowMI(int((2/2)*300),int((2/2)*100),2)

			rsh.movenext	'-- 下一个语言
		Loop
	End If
	rsh.close		'--关闭语言数据连接
End Sub

'===================================================================================================


'=========================================================================================================================================================
'	...
'=========================================================================================================================================================

'--视频分类
Sub HtmlVideoSort_old
VideoSortName="VideoList"
'-----------------------------------------------------循环生成各版HTML
set rsh = server.createobject("adodb.recordset")
sqlh="select * from ChinaQJ_Language order by ChinaQJ_Language_Order"
rsh.open sqlh,conn,1,1
while(not rsh.eof)
ThisLanguage=rsh("ChinaQJ_Language_File")
LanguageFolder=rsh("ChinaQJ_Language_File")&"/"
'-----------------------------------------------------循环生成各版HTML
totalrec=Conn.Execute("Select count(*) from ChinaQJ_Video Where ViewFlag"&ThisLanguage&"")(0)
totalpage=int(totalrec/ProInfo)
If (totalpage * ProInfo)<totalrec Then
totalpage=totalpage+1
End If
if totalpage<=1 then
call htmll("","",""&LanguageFolder&""&VideoSortName&""&Separated&"1."&HTMLName&"",""&LanguageFolder&"VideoList.Asp","Page=",1,"","")
else
for i=1 to totalpage
call htmll("","",""&LanguageFolder&""&VideoSortName&""&Separated&""&i&"."&HTMLName&"",""&LanguageFolder&"VideoList.Asp","Page=",i,"","")
next
end if
Set rs=Server.CreateObject("ADODB.Recordset")
sql="select * from ChinaQJ_VideoSort where ViewFlag"&ThisLanguage&" order by ID desc"
rs.open sql,conn,1,1
If rs.eof Then
	Class_Num=0
Else
	Class_Num=1
do while not rs.eof
ID=rs("ID")
SortPath=conn.execute("select * from ChinaQJ_VideoSort Where ViewFlag"&ThisLanguage&" And ID="&ID)("SortPath")
VideoSortNameSeo=conn.execute("select * from ChinaQJ_VideoSort Where ViewFlag"&ThisLanguage&" And ID="&ID)("ClassSeo")
totalrec=Conn.Execute("Select count(*) from ChinaQJ_Video where ViewFlag"&ThisLanguage&" and SortPath Like '%"&SortPath&"%'")(0)
totalpage=int(totalrec/ProInfo)
If (totalpage * ProInfo)<totalrec Then
totalpage=totalpage+1
End If
if totalpage<=1 then
call htmll("","",""&LanguageFolder&""&VideoSortNameSeo&""&Separated&""&ID&""&Separated&"1."&HTMLName&"",""&LanguageFolder&"VideoList.Asp","SortID=",ID,"Page=",1)
else
for i=1 to totalpage
call htmll("","",""&LanguageFolder&""&VideoSortNameSeo&""&Separated&""&ID&""&Separated&""&i&"."&HTMLName&"",""&LanguageFolder&"VideoList.Asp","SortID=",ID,"Page=",i)
next
end If
Response.Write "<script>bar_img.width="&Fix((Class_Num/rs.recordcount)*300)&";"
Response.Write "bar_txt1.innerHTML=""成功生成【视频分类】"&Class_Num&"个静态页面。完成比例：" & formatnumber(Class_Num/rs.recordcount*100) & """;</script>"
Response.Flush
rs.movenext
Class_Num=Class_Num+1
Loop
End If
rs.close
set rs=nothing
'------------------------循环结束
rsh.movenext
wend
rsh.close
set rsh=nothing
'------------------------循环结束
End Sub

'------------电子杂志
Sub HtmlMagazineSort_olc
MagazineSortName="MagazineList"
'-----------------------------------------------------循环生成各版HTML
set rsh = server.createobject("adodb.recordset")
sqlh="select * from ChinaQJ_Language order by ChinaQJ_Language_Order"
rsh.open sqlh,conn,1,1
while(not rsh.eof)
ThisLanguage=rsh("ChinaQJ_Language_File")
LanguageFolder=rsh("ChinaQJ_Language_File")&"/"
'-----------------------------------------------------循环生成各版HTML
totalrec=Conn.Execute("Select count(*) from ChinaQJ_Magazine Where ViewFlag"&ThisLanguage&"")(0)
totalpage=int(totalrec/ProInfo)
If (totalpage * ProInfo)<totalrec Then
totalpage=totalpage+1
End If
if totalpage<=1 then
call htmll("","",""&LanguageFolder&""&MagazineSortName&""&Separated&"1."&HTMLName&"",""&LanguageFolder&"MagazineList.Asp","Page=",1,"","")
else
for i=1 to totalpage
call htmll("","",""&LanguageFolder&""&MagazineSortName&""&Separated&""&i&"."&HTMLName&"",""&LanguageFolder&"MagazineList.Asp","Page=",i,"","")
next
end if
Set rs=Server.CreateObject("ADODB.Recordset")
sql="select * from ChinaQJ_MagazineSort where ViewFlag"&ThisLanguage&" order by ID desc"
rs.open sql,conn,1,1
If rs.eof Then
	Class_Num=0
Else
	Class_Num=1
do while not rs.eof
ID=rs("ID")
SortPath=conn.execute("select * from ChinaQJ_MagazineSort Where ViewFlag"&ThisLanguage&" And ID="&ID)("SortPath")
MagazineSortNameSeo=conn.execute("select * from ChinaQJ_MagazineSort Where ViewFlag"&ThisLanguage&" And ID="&ID)("ClassSeo")
totalrec=Conn.Execute("Select count(*) from ChinaQJ_Magazine where ViewFlag"&ThisLanguage&" and SortPath Like '%"&SortPath&"%'")(0)
totalpage=int(totalrec/ProInfo)
If (totalpage * ProInfo)<totalrec Then
totalpage=totalpage+1
End If
if totalpage<=1 then
call htmll("","",""&LanguageFolder&""&MagazineSortNameSeo&""&Separated&""&ID&""&Separated&"1."&HTMLName&"",""&LanguageFolder&"MagazineList.Asp","SortID=",ID,"Page=",1)
else
for i=1 to totalpage
call htmll("","",""&LanguageFolder&""&MagazineSortNameSeo&""&Separated&""&ID&""&Separated&""&i&"."&HTMLName&"",""&LanguageFolder&"MagazineList.Asp","SortID=",ID,"Page=",i)
next
end If
Response.Write "<script>bar_img.width="&Fix((Class_Num/rs.recordcount)*300)&";"
Response.Write "bar_txt1.innerHTML=""成功生成【企业电子杂志分类】"&Class_Num&"个静态页面。完成比例：" & formatnumber(Class_Num/rs.recordcount*100) & """;</script>"
Response.Flush
rs.movenext
Class_Num=Class_Num+1
Loop
End If
rs.close
set rs=nothing
'------------------------循环结束
rsh.movenext
wend
rsh.close
set rsh=nothing
'------------------------循环结束
End Sub
%>