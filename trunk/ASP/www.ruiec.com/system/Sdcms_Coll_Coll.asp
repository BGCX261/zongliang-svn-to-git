<!--#include file="sdcms_check.asp"-->
<!--#include file="../Plug/Coll_Info/Conn.asp"-->
<!--#include file="../Plug/Coll_Info/Function.asp"-->
<%
Dim sdcms,title_Name,Action
Action=Lcase(Trim(Request.QueryString("Action")))
Set sdcms=New Sdcms_Admin
sdcms.Check_admin
sdcms.Check_lever 24
Select Case Action
	Case "coll","demo":title_Name="采集处理"
	Case "collection":title_Name="正在采集"
End Select
Sdcms_Head
%>
<div class="sdcms_notice"><span>管理操作：</span><a href="Sdcms_Coll_Config.asp">采集设置</a>　┊　<a href="Sdcms_Coll_Item.asp">采集管理</a> (<a href="Sdcms_Coll_Item.asp?action=add">添加</a>)　┊　<a href="Sdcms_Coll_Filters.asp">过滤管理</a> (<a href="Sdcms_Coll_Filters.asp?action=add">添加</a>)　┊　<a href="Sdcms_Coll_History.asp">历史记录</a></div>
<br>
<ul id="sdcms_sub_title">
	<li class="sub"><%=title_Name%></li>
</ul>
<div id="sdcms_right_b">
<%
Dim Get_Coll_Configs,Get_Coll_Lists,Get_Info_Configs,Get_Coll_Filters_Config
Dim List_Pic,Title,Author,CopyFrom,AddDate,Keyword,PhotoUrl,Content,SpecialID,Classid,IsPass,SaveFiles,Thumb_WaterMark,Coll_Top,Hits
Collection_Data
Dim ID:ID=IsNum(Trim(Request.QueryString("ID")),0)
'强制缓存
Sdcms_Cache=True
Select Case Action
	Case "demo":Demo
	Case "coll":Coll
	Case "collection":Collection
	Case "config":Config
	Case Else:Echo "参数错误"
End Select
CloseDb
Set Sdcms=nothing

Sub Config
	Get_Coll_Config'获取采集系统配置
	Get_Coll_List(ID)'获取当前ID的所有信息Url
	Get_Info_Config(ID)'获取当前ID采集信息的配置
	Get_Coll_Filters
	IF Not IsArray(Get_Info_Configs) Then Died
End Sub

Sub Demo
	Dim This_ID,Coll_List_Url_Num,Info_Config_Data,I,Info_Code
	Echo "正在读取采集信息配置<br><br>":Response.Flush()
	Config
	Echo "读取采集信息配置完成<br>":Response.Flush()
	This_ID=1
	Coll_List_Url_Num=Ubound(Get_Coll_Lists)
	Info_Config_Data=Get_Info_Configs
	For I=0 To UBound(Info_Config_Data,2)
	Next
	Echo "<dl class=""dl"">"
	'开始采集，不入库
		IF Sdcms_Cache Then
			List_Pic=Load_Cache("Coll_Pic_List_"&ID)
		End IF
		PhotoUrl=""
		IF IsArray(List_Pic) Then
			IF Ubound(List_Pic)>0 Then
				PhotoUrl=List_Pic(This_ID-1)
			End IF
		End IF
		Echo "<dt><span>小　　图：</span>　"&PhotoUrl&"</dt>"
				
		Info_Code=GetHttpPage(Get_Coll_Lists(This_ID-1),Info_Config_Data(1,0))'获取内容页代码
		Coll_Action Info_Code
	
		'获取标题
		Title=""
		Title=GetBody(Info_Code,Info_Config_Data(2,0),Info_Config_Data(3,0),False,False)
		Coll_Action Title
		Echo "<dt><span>标　　题：</span>"&title&"</dt>"
		
		'获取正文
		Content=""
		Content=GetBody(Info_Code,Info_Config_Data(4,0),Info_Config_Data(5,0),False,False)
		Coll_Action Content
		
		IF Info_Config_Data(21,0)=1 Then'如果设置了正文分页,要先获取分页网址,然后依次处理
			Dim Content_Code,This_Url,Last_Url,New_Url
			Content_Code=GetBody(Info_Code,Info_Config_Data(22,0),Info_Config_Data(23,0),False,False)'获取剔除无用内容
			Content_Code=GetArray(Content_Code,Info_Config_Data(24,0),Info_Config_Data(25,0),False,False)'获取所有路径的Url
			Content_Code=ReRepeat(Content_Code)
			'处理当前页面URL,剔除文件名部分
			This_Url=Get_Coll_Lists(This_ID-1)
			This_Url=Split(This_Url,"/")
			Last_Url=This_Url(Ubound(This_Url))
			New_Url=Re(Get_Coll_Lists(This_ID-1),Last_Url,"")'这是剔除掉的结果
			
			IF Content_Code<>"$False$" Then
				'如果存在分页就采集各分页的内容
				Dim Content_Url,J
				Content_Url=Split(Content_Code,"$Array$")
				For J=0 To Ubound(Content_Url)
					Content_Other_Code=GetHttpPage(New_Url&Content_Url(J),Info_Config_Data(1,0))'获取页面内容
					
					IF Content_Other_Code="$False$" Then
						Echo New_Url&Content_Url(J)&"页面采集失败<br>":Exit For
					End IF
	
					Content=Content&GetBody(Content_Other_Code,Re(Info_Config_Data(4,0),"\",""),Re(Info_Config_Data(5,0),"\",""),False,False)'获取剔除无用内容
					IF Content="$False$" Then
						Echo New_Url&Content_Url(J)&"页面剔除失败<br>":Exit For
					End IF
					
				Next
			End IF
			
		End IF
		'处理正文路径,将图片相对路径转化为绝对路径
		Content=Reurl(Content,Info_Config_Data(48,0))
		Echo "<dt><span>正　　文：</span>　"&Gottopic(Content_Encode(Content),500)&"</dt>"
		
		
		
		'获取作者，如果设置了
		Author=""
		IF Info_Config_Data(6,0)=1 Then
			Author=GetBody(Info_Code,Info_Config_Data(7,0),Info_Config_Data(8,0),False,False)
			Coll_Action Content
		ElseIF Info_Config_Data(6,0)=2 Then
			Author=Info_Config_Data(9,0)
		End IF
		Echo "<dt><span>作　　者：</span>　"&Author&"</dt>"
		
		'获取来源，如果设置了
		Copyfrom=""
		IF Info_Config_Data(10,0)=1 Then
			Copyfrom=GetBody(Info_Code,Info_Config_Data(11,0),Info_Config_Data(12,0),False,False)
			Coll_Action Copyfrom
		ElseIF Info_Config_Data(10,0)=2 Then
			Copyfrom=Info_Config_Data(13,0)
		End IF
		Echo "<dt><span>来　　源：</span>　"&Copyfrom&"</dt>"
		
		'获取日期，如果设置了
		AddDate=""
		IF Info_Config_Data(14,0)=1 Then
			AddDate=GetBody(Info_Code,Info_Config_Data(15,0),Info_Config_Data(16,0),False,False)
			Coll_Action AddDate
			Echo "<dt><span>日　　期：</span>　"&AddDate&"</dt>"
		End IF
		
		'获取关键字，如果设置了
		Keyword=""
		IF Info_Config_Data(17,0)=0 Then
			Keyword=CreateKeyWord(Title,2)
		ElseIF Info_Config_Data(17,0)=1 Then
			Keyword=GetBody(Info_Code,Info_Config_Data(18,0),Info_Config_Data(19,0),False,False)
			Coll_Action Keyword
			IF Keyword="$False$" Then Keyword=""
		ElseIF Info_Config_Data(17,0)=2 Then
			Keyword=Info_Config_Data(20,0)
		End IF
		Echo "<dt><span>关 键 字：</span>　"&Keyword&"</dt>"
		Dim Test_Msg
		IF title="$False$" Or Content="$False$" Then Test_Msg="，<span>结果：</span>采集失败<span><script>alert(""部分数据采集失败，请检查设置"");</script>" 
		Echo "<dt>测试采集完毕"&Test_Msg&"　耗时: </span>　"&Runtime&" 秒</dt></dl><div></div><br>":Response.Flush()
	
End Sub

Sub Coll
	Dim Total,Success,Failure,This_ID
	Echo "正在读取采集信息配置<br><br>":Response.Flush()
	Config
	Total=Ubound(Get_Coll_Lists)+1'要采集的总数量
	Success=0
	Failure=0
	This_ID=1
	Echo "采集信息配置读取完成，5 秒后开始采集信息!<br><br><div id=""outtime"">剩余 <span class='red'>5</span> 秒　　<a href=""Sdcms_Coll_Item.asp"">取消采集</a>，<a href='?Action=Collection&ID="&ID&"&Total="&Total&"&Success="&Success&"&Failure="&Failure&"&This_ID="&This_ID&"'><b>跳过等待</b></a></div>":Response.Flush()
		Echo "<script language=JavaScript>"
		Echo "var secs=5;var wait=secs * 1000;"
		Echo "for(i=1; i<=secs;i++){window.setTimeout(""Update("" + i + "")"", i * 1000);}"
		Echo "function Update(num){if(num != secs){printnr = (wait / 1000) - num;"
		Echo "$(""#outtime"")[0].style.width=(num/secs)*100+""%"";"
		Echo "$(""#outtime"").html(""剩余 <span class='red'>""+printnr+""</span> 秒　　<a href='Sdcms_Coll_Item.asp'>取消采集</a>，<a href='?Action=Collection&ID="&ID&"&Total="&Total&"&Success="&Success&"&Failure="&Failure&"&This_ID="&This_ID&"'><b>跳过等待</b></a>"");}}"
		Echo "setTimeout(""window.location='?Action=Collection&ID="&ID&"&Total="&Total&"&Success="&Success&"&Failure="&Failure&"&This_ID="&This_ID&"'"","&Int(5*1000)&");</script>"
		Response.Flush()
End Sub

Sub Collection
	Dim Total,Success,Failure,This_ID,This_Msg,Coll_List_Url_Num,Info_Config_Data,I,Info_Code,Rs,Sql
	Config
	Total=IsNum(Trim(Request("Total")),0)
	Success=IsNum(Trim(Request("Success")),0)
	Failure=IsNum(Trim(Request("Failure")),0)
	This_ID=IsNum(Trim(Request("This_ID")),0)
	IF This_ID<=Total Then This_Msg="正在采集第 "&This_ID&" 条，"
	Echo This_Msg&"总共: "&Total&" 条，成功: <span id=""Success"">"&Success&"</span> 条，失败: <span id=""Failure"">"&Failure&"</span> 条　　<a href=""Sdcms_Coll_Item.asp"">停止采集</a><br><br>":Response.Flush()
	IF This_ID>Total Then Echo "全部采集完毕!":Response.Flush():Died
	Coll_List_Url_Num=Ubound(Get_Coll_Lists)
	Info_Config_Data=Get_Info_Configs
	For I=0 To UBound(Info_Config_Data,2)
	Next
	Echo "<dl class=""dl"">"
	Set Rs=Coll_Conn.Execute("Select ID From Sd_Coll_History Where NewsUrl='"&Get_Coll_Lists(This_ID-1)&"'")
	IF Rs.Eof Then
	
		'开始采集，并入库
		IF Sdcms_Cache Then
			List_Pic=Load_Cache("Coll_Pic_List_"&ID)
		End IF
		PhotoUrl=""
		IF IsArray(List_Pic) Then
			IF Ubound(List_Pic)>0 Then
				PhotoUrl=List_Pic(This_ID-1)
			End IF
			'Echo "<dt><span>小　　图：</span>　"&PhotoUrl&"</dt>"
		End IF
			
		Info_Code=GetHttpPage(Get_Coll_Lists(This_ID-1),Info_Config_Data(1,0))'获取内容页代码
		Coll_Action Info_Code
	
		'获取标题
		Title=""
		Title=GetBody(Info_Code,Info_Config_Data(2,0),Info_Config_Data(3,0),False,False)
		Coll_Action Title
		'Echo "<dt><span>标　　题：　</span>"&title&"</dt>"
		
		'获取正文
		Content=""
		Content=GetBody(Info_Code,Info_Config_Data(4,0),Info_Config_Data(5,0),False,False)
		Coll_Action Content
		
		IF Info_Config_Data(21,0)=1 Then'如果设置了正文分页,要先获取分页网址,然后依次处理
			Dim Content_Code,This_Url,Last_Url,New_Url
			Content_Code=GetBody(Info_Code,Info_Config_Data(22,0),Info_Config_Data(23,0),False,False)'获取剔除无用内容
			Content_Code=GetArray(Content_Code,Info_Config_Data(24,0),Info_Config_Data(25,0),False,False)'获取所有路径的Url
			'处理当前页面URL,剔除文件名部分
			This_Url=Get_Coll_Lists(This_ID-1)
			This_Url=Split(This_Url,"/")
			Last_Url=This_Url(Ubound(This_Url))
			New_Url=Re(Get_Coll_Lists(This_ID-1),Last_Url,"")'这是剔除掉的结果
			
			IF Content_Code<>"$False$" Then
				'如果存在分页就采集各分页的内容
				Dim Content_Url,J
				Content_Url=Split(Content_Code,"$Array$")
				For J=0 To Ubound(Content_Url)
					IF Content_Url(J)<>Last_Url Then
						Content_Other_Code=GetHttpPage(New_Url&Content_Url(J),Info_Config_Data(1,0))'获取页面内容
						
						IF Content_Other_Code="$False$" Then
							Echo New_Url&Content_Url(J)&"页面采集失败<br>":Exit For
						End IF
		
						Content=Content&"$show_page$"&GetBody(Content_Other_Code,Re(Info_Config_Data(4,0),"\",""),Re(Info_Config_Data(5,0),"\",""),False,False)'获取剔除无用内容
						IF Content="$False$" Then
							Echo New_Url&Content_Url(J)&"页面剔除失败<br>":Exit For
						End IF		
					End IF			
				Next
			End IF
			
		End IF
		
		'处理正文路径,将图片相对路径转化为绝对路径
		Content=Reurl(Content,Info_Config_Data(48,0))
		Dim Script_Str
		IF Info_Config_Data(32,0)=1 Then'如果开启了高级属性
			IF Info_Config_Data(34,0)=1 Then Script_Str="Iframe|"
			IF Info_Config_Data(35,0)=1 Then Script_Str=Script_Str&"Object|"
			IF Info_Config_Data(36,0)=1 Then Script_Str=Script_Str&"Script|"
			IF Info_Config_Data(37,0)=1 Then Script_Str=Script_Str&"Div|"
			IF Info_Config_Data(38,0)=1 Then Script_Str=Script_Str&"Class|"
			IF Info_Config_Data(39,0)=1 Then Script_Str=Script_Str&"table|"
			IF Info_Config_Data(40,0)=1 Then Script_Str=Script_Str&"tr|"
			IF Info_Config_Data(41,0)=1 Then Script_Str=Script_Str&"Span|"
			IF Info_Config_Data(42,0)=1 Then Script_Str=Script_Str&"Img|"
			IF Info_Config_Data(43,0)=1 Then Script_Str=Script_Str&"Font|"
			IF Info_Config_Data(44,0)=1 Then Script_Str=Script_Str&"A|"
			IF Info_Config_Data(45,0)=1 Then Script_Str=Script_Str&"Html|"
			IF Info_Config_Data(46,0)=1 Then Script_Str=Script_Str&"Td|"
			IF Len(Script_Str)>0 Then
				Script_Str=Left(Script_Str,Len(Script_Str)-1)
				Content=Get_Script(Content,Script_Str)
			End IF
			IF Len(Info_Config_Data(47,0))>0 Then
				Get_Coll_Replace(Info_Config_Data(47,0))
			End IF
		End IF
		'Echo "<dt><span>正　　文：</span>　"&Gottopic(Removehtml(Content),80)&"</dt>"
		
		'获取作者，如果设置了
		Author=""
		IF Info_Config_Data(6,0)=1 Then
			Author=GetBody(Info_Code,Info_Config_Data(7,0),Info_Config_Data(8,0),False,False)
			Coll_Action Content
			IF Author="$False$" Then Author=""
		ElseIF Info_Config_Data(6,0)=2 Then
			Author=Info_Config_Data(9,0)
		End IF
		'Echo "<dt><span>作　　者：</span>　"&Author&"</dt>"
		
		'获取来源，如果设置了
		Copyfrom=""
		IF Info_Config_Data(10,0)=1 Then
			Copyfrom=GetBody(Info_Code,Info_Config_Data(11,0),Info_Config_Data(12,0),False,False)
			Coll_Action Copyfrom
			IF Copyfrom="$False$" Then Copyfrom=""
		ElseIF Info_Config_Data(10,0)=2 Then
			Copyfrom=Info_Config_Data(13,0)
		End IF
		'Echo "<dt><span>来　　源：</span>　"&Copyfrom&"</dt>"
		
		'获取日期，如果设置了
		AddDate=""
		IF Info_Config_Data(14,0)=1 Then
			AddDate=GetBody(Info_Code,Info_Config_Data(15,0),Info_Config_Data(16,0),False,False)
			Coll_Action AddDate
			IF AddDate="$False$" Then AddDate=""
			'Echo "<dt><span>日　　期：</span>　"&AddDate&"</dt>"
		End IF
		
		'获取关键字，如果设置了
		Keyword=""
		IF Info_Config_Data(17,0)=0 Then
			Keyword=CreateKeyWord(Title,2)
		ElseIF Info_Config_Data(17,0)=1 Then
			Keyword=GetBody(Info_Code,Info_Config_Data(18,0),Info_Config_Data(19,0),False,False)
			Coll_Action Keyword
			IF Keyword="$False$" Then Keyword=""
		ElseIF Info_Config_Data(17,0)=2 Then
			Keyword=Info_Config_Data(20,0)
		End IF
		'Echo "<dt><span>关 键 字：</span>　"&Keyword&"</dt>"
		
		Echo "<dt><span>进　　度：</span>　第 "&This_ID&" 条信息采集完毕,"
		Success=Success+1
		This_ID=This_ID+1
		IF Info_Config_Data(32,0)=1 Then'如果开启了高级属性
			IF Info_Config_Data(26,0)>0 Then
				IF Success>Info_Config_Data(26,0) Then
					Echo "超过系统数量限制,停止采集</dt>":Died
				End IF
			End IF
		End IF
		Echo " 1 秒后继续采集下一条!</dt>"
		Classid=Info_Config_Data(27,0)
		SpecialID=Info_Config_Data(28,0)
		IsPass=Info_Config_Data(29,0)
		SaveFiles=Info_Config_Data(30,0)'是否保存文件
		Thumb_WaterMark=Info_Config_Data(31,0)'是否水印
		Coll_Top=Info_Config_Data(32,0)
		IF Coll_Top>0 Then
			Hits=Info_Config_Data(33,0)
		Else
			Hits=0
		End IF
		IF title<>"$False$" Then
			IF SaveData Then
			'写成功记录
			Coll_Conn.Execute("Insert Into Sd_Coll_History (Title,NewsUrl,Result,ItemID,Classid,SpecialID,adddate) Values ('"&title&"','"&Get_Coll_Lists(This_ID-2)&"',1,"&ID&","&Classid&","&SpecialID&",'"&Dateadd("h",Sdcms_TimeZone,Now())&"')")
			Else
			Echo "　<span>记录已存在，不予入库</span>"
			End IF
		End IF
	Else
		Failure=Failure+1
		This_ID=This_ID+1
		Echo "<dt><span>进　　度：</span>　第 "&This_ID-1&" 条信息采集失败,原因:记录已存在, 1 秒后继续采集下一条!</dt>"
	End IF
	Echo "<dt><span>耗　　时：</span>　"&Runtime&" 秒</dt></dl><div></div><br>":Response.Flush()
	Echo "<script>setTimeout(""location.href='?Action=Collection&ID="&ID&"&Total="&Total&"&Success="&Success&"&Failure="&Failure&"&This_ID="&This_ID&"';"",""1000"");</script>"
	
End Sub

Sub Get_Coll_Filters
	IF Sdcms_Cache Then
		IF Check_Cache("Get_Coll_Filters") Then
			Create_Cache "Get_Coll_Filters",Filters_Config
		End IF
		Get_Coll_Filters_Config=Load_Cache("Get_Coll_Filters")
	Else
		Get_Coll_Filters_Config=Filters_Config
	End IF
End Sub

Function Filters_Config
	Dim Rs
	Set Rs=Coll_Conn.Execute("Select ItemID,FilterObject,FilterType,FilterContent,FisString,FioString,FilterRep From Sd_Coll_Filters Where Flag=1")
	IF Rs.Eof Then
		Filters_Config=""
	Else
		Filters_Config=Rs.GetRows
	End IF
End Function


Sub Coll_Msg(t0,t1,t2)
	IF t0="$False$" Then
		Echo "在"&t1&": "&t2&" 时发生错误!<br>"
	End IF
End Sub

Function Coll_Action(t0)
	Coll_Action=False
	IF t0="$False$" Then Coll_Action=True
End Function

Function SaveData
	Dim Sql,Rs
	SaveData=False
	IF IsArray(Get_Coll_Filters_Config) Then
		Coll_Filters(Get_Coll_Filters_Config)
	End IF
	Sql="Select title,classid,Topic,pic,ispic,author,comefrom,hits,keyword,content,jj,ispass,lastupdate,iscomment,ID,adddate From Sd_info Where title='"&FilterText(title,1)&"'"
	Set Rs=Server.CreateObject("adodb.recordset")
	Rs.Open Sql,Conn,1,3
	IF Rs.Eof Then	
		IF SaveFiles=1 Then
			Dim New_file
			New_file=GetRndFileName(Get_Filetxt(PhotoUrl))
			PhotoUrl=SaveRemoteFile(New_file,PhotoUrl,Get_Coll_Configs(2),Get_Coll_Configs(3),Get_Coll_Configs(1),Thumb_WaterMark,False)
			Content=ReplaceRemoteUrl(Content,Get_Coll_Configs(2),Get_Coll_Configs(3),Get_Coll_Configs(1),Thumb_WaterMark)
		End IF
		Rs.Addnew
		Rs(0)=Left(Trim(Title),255)
		Rs(1)=Classid
		Rs(2)=SpecialID
		Rs(3)=Left(FilterText(PhotoUrl,0),255)
		Rs(4)=Check_ispic(PhotoUrl)
		Rs(5)=Left((author),50)
		Rs(6)=Left((copyfrom),50)
		Rs(7)=Hits
		Rs(8)=Left((keyword),255)
		Rs(9)=Content
		Rs(10)=CloseHtml(CutStr(Content,Sdcms_Length))
		Rs(11)=IsPass
		Rs(12)=Now()
		Rs(13)=Sdcms_Comment_Pass
		IF Len(AddDate)>0 Then
			Rs(15)=AddDate
		Else
			Rs(15)=Dateadd("h",Sdcms_TimeZone,Now())
		End IF
		Rs.Update
		Rs.MoveLast 
		Dim Info_ID
		Info_ID=Rs(14)
		Custom_HtmlName Sdcms_Filename,"sd_Info",Title,Info_ID
		SaveData=True
	End IF
	
End Function
%>
 
</div>
</body>
</html>