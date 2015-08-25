<%
'==============================
'SDCMS模板解析引擎
'Author:IT平民
'Date:2009年4-5月
'UpDate:2011-1
'==============================
Dim Rs
Class Templates
	Private Reg,LabelData,TemplateData
	
	Dim Page_Field,Page_Table,Page_Where,Page_Order,Page_PageSize,Page_Eof,Page_Loop,Page_Html
	
	Private Sub Class_Initialize()
		Set Reg=New Regexp
		Reg.Ignorecase=True
		Reg.Global=True
		Set LabelData=Server.CreateObject("Scripting.Dictionary")
	End Sub
	
	Private Sub Class_Terminate()
		Set LabelData=Nothing
		Set Reg=Nothing
	End Sub
	
	'重新设置模板内容
	Public Property Let TemplateContent(t0)
		TemplateData=t0
	End Property
	
	Public Function Sql_Err(ByVal t0)
		Sql_Err="SQL语句：""<b>"&t0&"</b>""执行失败"
	End Function
	
	Public Function IF_Err(ByVal t0)
		IF_Err="IF标签：""<b>"&t0&"</b>""执行失败"
	End Function
	
	Public Function IIF_Err(ByVal t0)
		IIF_Err="IIF标签：""<b>"&t0&"</b>""执行失败"
	End Function
	
	'==============================
	'解析模板
	'==============================
	Public Sub Load(ByVal t0)
		Sdcms_Templates(t0)
	End Sub
	
	'==============================
	'显示解析后的模板
	'==============================
	Public Function Display()
		Display=TemplateData
	End Function
	
	Public Function Gzip
		TemplateData = Replace(TemplateData, Chr(8), "")'回格
		TemplateData = Replace(TemplateData, Chr(9), "")'tab(水平制表符)
		TemplateData = Replace(TemplateData, Chr(10), "")'换行
		TemplateData = Replace(TemplateData, Chr(11), "")'tab(垂直制表符) 
		TemplateData = Replace(TemplateData, Chr(12), "")'换页
		TemplateData = Replace(TemplateData, Chr(13), "")'回车 chr(13)&chr(10) 回车和换行的组合
		TemplateData = Replace(TemplateData, Chr(22), "")
		'TemplateData = Replace(TemplateData, "  ", "")
	End Function
	
	Public Sub Sdcms_Templates(ByVal t0)
		TemplateData=Sdcms_Load(t0)
		Analysis_Static
		Analysis_Loop
		Analysis_IIF
	End Sub
	
	'==============================
	'读取模板并处理包含文件
	'==============================
	Public Function Sdcms_Load(ByVal t0)
		IF IsNull(t0) Or Len(t0)="" Then
			Sdcms_Load=""
			Exit Function
		End IF
		t0=LoadFile(t0)'读取模板
		t0=Sdcms_Include(t0)'解析包含文件
		Sdcms_Load=t0
	End Function
	
	'==============================
	'解析静态变量和常用函数
	'==============================
	Public Sub Analysis_Static()
		Dim Labeltag,Labelval,I
		Sdcms_Lable'解析静态变量
		Labeltag=LabelData.keys
		Labelval=LabelData.items
		IF LabelData.Count>=1 Then
			For I=0 To LabelData.Count-1
				TemplateData=Re(TemplateData,Labeltag(I),Labelval(I))
			Next
		End IF
		Sdcms_allclassid()'解析常用函数
		Sdcms_category()'解析常用函数
	End Sub
	
	'==============================
	'解析循环标签
	'==============================
	Public Sub Analysis_Loop()
		Sdcms_Loop(True)'解析循环语句
		Sdcms_Loop(False)
	End Sub
	
	Public Sub Analysis_IIF()
		Sdcms_IIF
		Sdcms_DIY
		TemplateData=Replace(TemplateData,"{sdcms:runtime}",Runtime)
		TemplateData=Replace(TemplateData,"{sdcms:dbquery}",DbQuery)
	End Sub
		
	Public Function Label(t0,t1)
		IF Len(t0)<=0 Then Exit Function
		IF LabelData.Exists(t0) Then LabelData.Item(t0)=t1 Else LabelData.Add t0,t1
	End Function
 
	'==============================
	'包含文件解析,支持嵌套
	'==============================
	Public Function Sdcms_Include(ByVal t0)
		Dim Matches,Match
		Reg.Pattern="{sdcms:include\(['""]([\s\S]+?)['""]\)}"
		Set Matches=Reg.Execute(t0)
		IF Matches.Count>0 Then
			For Each Match In Matches
				t0=Replace(t0,Match.value,Sdcms_Include(LoadFile(Load_temp_dir&Match.SubMatches(0))))
			Next
		End IF
		Sdcms_Include=t0
	End Function

	'==============================
	'静态标签解析
	'==============================
	Public Sub Sdcms_Lable()
		Dim t1
		'先解析自定义标签
		t1=Load_Freelabel
		IF Isarray(t1) Then
			Dim I
			For I=0 To UBound(t1,2)
				TemplateData=Replace(TemplateData,"{sdcms_"&t1(0,I)&"}",t1(1,I))
			Next
		End IF
		Dim Sdcms_webkey,Sdcms_webdec,Get_WebsiteConfig
		Get_WebsiteConfig=Get_Website_Config
		Sdcms_webkey=Empty
		Sdcms_webdec=Empty
		IF IsArray(Get_WebsiteConfig) Then
			Sdcms_webkey=Get_WebsiteConfig(0,0)
			Sdcms_webdec=Get_WebsiteConfig(1,0)
		End IF
		TemplateData=Replace(TemplateData,"{date()}",Sdcms_date())
		TemplateData=Replace(TemplateData,"{now()}",Now())
		TemplateData=Replace(TemplateData,"{sdcms:webname}",Sdcms_webname)
		TemplateData=Replace(TemplateData,"{sdcms:mode}",Sdcms_Mode)
		TemplateData=Replace(TemplateData,"{sdcms:weburl}",Sdcms_weburl)
		TemplateData=Replace(TemplateData,"{sdcms:webkey}",Sdcms_webkey)
		TemplateData=Replace(TemplateData,"{sdcms:webdec}",Sdcms_webdec)
		TemplateData=Replace(TemplateData,"{sdcms:root}",Sdcms_root)
		TemplateData=Replace(TemplateData,"{sdcms:htmdir}",Sdcms_htmdir)
		TemplateData=Replace(TemplateData,"{sdcms:filetxt}",Sdcms_filetxt)
		TemplateData=Replace(TemplateData,"{sdcms:comment_pass}",Sdcms_Comment_Pass)
		TemplateData=Replace(TemplateData,"{sdcms:length}",Sdcms_length)
		TemplateData=Replace(TemplateData,"{sdcms:skins}",Sdcms_skin_author)
		TemplateData=Replace(TemplateData,"{sdcms:skin}",Sdcms_weburl&"/skins/"&Sdcms_Skins_Root&"/")
		TemplateData=Replace(TemplateData,"{sdcms:version}",Sdcms_version)
		TemplateData=Replace(TemplateData,"{sdcms:spider}","<script language=""javascript"" src="""&Sdcms_Root&"Inc/Spider.asp""></script>")
	End Sub

	'---------------------------------INT
	Function BetaIsInt(value,dfl)
		on error resume next
		dim str 
		dim l,i 
		if isNUll(value) then 
			BetaIsInt=dfl 
			exit function 
		end if 
		str=cstr(value) 
		if trim(str)="" then 
			BetaIsInt=dfl 
			exit function 
		end if 
		l=len(str) 
		for i=1 to l 
			if mid(str,i,1)>"9" or mid(str,i,1)<"0" then 
				BetaIsInt=dfl
				exit function 
			end if 
		next 
		BetaIsInt=value 
		if err.number<>0 then err.clear 
	End Function
	
	'==============================
	'循环标签解析
	'==============================
	Public Sub Sdcms_Loop(ByVal t0)
		Dim Matches,Match,t2,t3,t4,t5,tag_field,tag_table,tag_top,tag_where,tag_order,tag_group,showpage,pageid,tgwhere_s,txtinfo
		IF t0 Then Reg.Pattern="\{@sdcms:loop([\s\S]+?)\}([\s\S]+?)\{/@sdcms:loop\}" Else Reg.Pattern="\{sdcms:loop([\s\S]+?)\}([\s\S]+?)\{/sdcms:loop\}"
		Set Matches=Reg.Execute(TemplateData)
		IF Matches.Count>0 Then
			For Each Match In Matches
				t2=Match.SubMatches(0)
				t3=Getloop(Match.SubMatches(1),0,t0)
				t4=Getloop(Match.SubMatches(1),1,t0)
				'tag_field=Getlable(t2,"field")
				'tag_table=Getlable(t2,"table")
				'tag_top=Getlable(t2,"top")
				'tag_where=Getlable(t2,"where")
				'tag_order=Getlable(t2,"order")
				tag_field=""
				tag_table=""
				tag_top=""
				tag_where=""
				tag_order=""
				tag_group=""
				showpage=""
				txtinfo="条信息"
				pageid=1
				t5=Getlables(t2)
				If request("Page")<>"" Then 
					pageid=request("Page")
				End If
				Dim I
				For I=0 To Ubound(t5)
					Select Case t5(I,0)
						Case "field":tag_field=t5(I,1)
						Case "table":tag_table=t5(I,1)
						Case "top":tag_top=t5(I,1)
						Case "where":tag_where=t5(I,1)
						Case "order":tag_order=t5(I,1)
						Case "group":tag_group=t5(I,1)
						Case "showpage":showpage=t5(I,1)
						Case "pageid":pageid=t5(I,1)
						Case "txtinfo":txtinfo=t5(I,1)
					End Select
				Next
				IF Len(tag_field)=0 Then tag_field="*"
				IF Len(tag_top)=0 Then tag_top=10
				IF Len(tag_order)=0 then tag_order="id desc"
				IF Len(tag_table)=0 Then tag_table="sd_comment"
				IF Len(tag_group)>0 Then tag_group="group by "&tag_group
				IF Len(tag_where)>0 Then tag_where="Where "&tag_where
				tgwhere_s = tag_where
				pageid = BetaIsInt(pageid,0)
				tag_top = BetaIsInt(tag_top,10)

				If pageid > 1 And tag_table<>"sd_class" And Len(showpage)>0 Then
					If Len(tag_where)>0 Then 
						tag_where=tag_where&" AND ID NOT IN (SELECT TOP "&((pageid*tag_top)-tag_top)&" ID from "&tag_table&" "&tag_where&""
					Else 
						tag_where=" WHERE ID NOT IN (SELECT TOP "&(pageid*tag_top)&" ID from "&tag_table&" "&tag_where&""
					End If
					IF Len(tag_order)>0 Then tag_where=tag_where&" Order By "&tag_order
					IF Len(tag_group)>0 Then tag_where=tag_where&" "&tag_group
					tag_where=tag_where&")"
				End If
				IF Lcase(tag_table)="sd_info" Then tag_table="View_Info"
				
				IF Len(showpage)>0 Then
					TemplateData=Replace(TemplateData,"{sdcms:showpages}",GetShowPageInfo(tag_table,tgwhere_s,pageid,tag_top,5,txtinfo))
				End If

				IF t0 Then
					TemplateData=Replace(TemplateData,Match.Value,Get_Table(t3,t4,tag_top,tag_where,tag_order,tag_table,True,tag_field,tag_group))
				Else
					TemplateData=Replace(TemplateData,Match.Value,Get_Table(t3,t4,tag_top,tag_where,tag_order,tag_table,False,tag_field,tag_group))
				End IF
			Next
		End IF
	End Sub

	Function testa(size)
		testa = size
	End Function
	
	'====================================================================
	'	分页函数(Beta)
	'	TabName			数据表名(*)
	'	StrWhere		SQL语句WHERE
	'	PageId			当前页数
	'	PageShowCount	每页显示的数量
	'	showListCount	显示分页数量
	'	countText		形容词
	'====================================
	Function GetShowPageInfo(TabName,StrWhere,PageId,PageShowCount,showListCount,countText)
		If TabName="" Then
			Response.write("Error:调用参数错误!")
			Exit Function
		End If
		If PageId=0 Then PageId=1 End If
		If PageShowCount=0 Then PageShowCount=20 End If
		If showListCount=0 Then showListCOunt=5 End If 
		If countText="" Then countText="条数据" End If 
		
		Dim myrs,myStrSql,uQ,huQ,mSortID,it,IPageMax,obj,myself,i
		
		Set myrs = server.createobject("adodb.recordset")
		If StrWhere="" Then
			myStrSql="SELECT COUNT(*) FROM "&TabName
		Else
			myStrSql="SELECT COUNT(*) FROM "&TabName&" "&StrWhere
		End If
		
		myrs.open myStrSql,conn,0,1
		If myrs.eof Then 
			GetShowPageInfo = "<div class=""page""><strong style=""color:red"">Error:获取分页信息时出错!</strong></div>"
			exit function
		Else
			Dim InfoCount
				InfoCount=myrs(0)
			
			If InfoCount=0 Then Exit Function End If

			If InfoCount Mod PageShowCount=0 Then 
				IPageMax=Int(InfoCount/PageShowCount)
			Else 
				IPageMax=Int(InfoCount/PageShowCount)+1
			End If
			myself=request.servervariables("script_name")	'addres
			
			uQ=Request.ServerVariables("Query_String")
			If request("Page")<>"" Then
				uQ=Replace(uQ,"Page="&request("Page"),"") 
			Else
				uQ="&"&uQ
			End If

			If (IPageMax-PageId) < 0 Then
				GetShowPageInfo = "<div class=""page""><strong style=""color:red"">Error:</strong> 页数出错了哦.<br />总共才<strong style=""color:red"">"&InfoCount&"</strong>"&countText&"&nbsp;<br />每页显示 <strong style=""color:red"">"&PageShowCount&"</strong> 条 <br />共<strong style=""color:red"">"&IPageMax&"</strong>页,<br />貌似木有第 <strong style=""color:red"">"&PageId&"</strong> 页&nbsp;<br />所以,你是不是<strong style=""color:red"">非法传参</strong>了?</strong><br />算了,让你<a href="""&myself&"?Page=1"&uQ&""" title=""下次不许这样做了哦!..."">返回第一页</a>吧</div>"
				exit function
			End If
			
			GetShowPageInfo = GetShowPageInfo&"<div class=""page"">共计<strong style=""color:red"">"&InfoCount&"</strong>"&countText&"&nbsp;每页显示 <strong style=""color:red"">"&PageShowCount&"</strong> 条&nbsp;&nbsp;"

	'================================首页 上一页===============================
			If PageId=1 Then
				GetShowPageInfo = GetShowPageInfo&"<a href=""javascript:;"" class=""mPage"" style=""cursor: not-allowed; text-decoration: none; color: #CCC;"" title=""木有了"">首页</a><a href=""javascript:;"" class=""mPage"" style=""cursor: not-allowed; text-decoration: none; color: #CCC;"" title=""木有了"">上一页</a>"
			Else
				GetShowPageInfo = GetShowPageInfo&"<a href="""&myself&"?Page=1"&uQ&""" class=""mPage"">首页</a><a href="""&myself&"?Page="&(PageId-1)&uQ&""" class=""mPage"">上一页</a>"
			End If
	'===================================中间部分====================================
			it=(PageId-2)
			If PageId<=2 Then it=1 End If
			If IPageMax<showListCount Then
				showListCount=IPageMax
			Else
				If PageId+2>=IPageMax Then it=(PageId-(showListCount-(IPageMax-PageId))) End If
				showListCount=(it+showListCount)
			End If
			For i=it To showListCount
				If i>0 And i<=IPageMax Then
					If (i-PageId)=0 Then
						GetShowPageInfo = GetShowPageInfo&"<a class=""mPage"" style=""background-color:#FFBA00; color:#000;"" >"&i&"</a>"
					Else
						GetShowPageInfo = GetShowPageInfo&"<a href="""&myself&"?Page="&i&uQ&""" class=""mPage"">"&i&"</a>"
					End If
				End If
			Next
	'======================================下一页 尾页=================================
			If (IPageMax-PageId)<1 Then
				GetShowPageInfo = GetShowPageInfo&"<a href=""javascript:;"" class=""mPage"" style=""cursor: not-allowed; text-decoration: none; color: #CCC;"" title=""木有了"">下一页</a><a href=""javascript:;"" class=""mPage"" style=""cursor: not-allowed; text-decoration: none; color: #CCC;"" title=""木有了"">尾页</a>"
			Else
				GetShowPageInfo = GetShowPageInfo&"<a href="""&myself&"?Page="&(PageId+1)&uQ&""" class=""mPage"">下一页</a><a href="""&myself&"?Page="&IPageMax&uQ&""" class=""mPage"">尾页</a>"
			End If

			GetShowPageInfo = GetShowPageInfo&"&nbsp;&nbsp;&nbsp;(<strong style=""color:red"">"&PageId&"</strong>/<strong style=""color:#999"">"&IPageMax&"</strong>)</div>"
		End if
		myrs.close
		set myrs=Nothing

	End Function

	'==============================
	'分页循环标签解析
	'==============================
	Public Sub Page_Mark(ByVal t0)
		Page_Field=""
		Page_Table=""
		Page_Where=""
		Page_Order=""
		Page_PageSize=""
		
		Dim Matches,Match,t1,t2,t3,t4,I
		Dim tag_field,tag_table,tag_where,tag_order,tag_pagesize

		Reg.Pattern="\{@sdcms:page([\s\S]+?)\}([\s\S]+?)\{/@sdcms:page\}"
		Set Matches=Reg.Execute(t0)
		IF Matches.Count>0 Then
			For Each Match In Matches
				t1=Match.SubMatches(0)
				t2=Getloop(Match.SubMatches(1),0,true)
				t3=Getloop(Match.SubMatches(1),1,true)
				tag_field=""
				tag_table=""
				tag_where=""
				tag_order=""
				tag_pagesize=""
			
				t4=Getlables(t1)
				For I=0 To Ubound(t4)
					Select Case Lcase(t4(I,0))
						Case "field":tag_field=t4(I,1)
						Case "table":tag_table=t4(I,1)
						Case "where":tag_where=t4(I,1)
						Case "order":tag_order=t4(I,1)
						Case "pagesize":tag_pagesize=t4(I,1)
					End Select
				Next
				
				IF Len(tag_field)=0 Then tag_field="*"
				IF tag_order="" Then tag_order="id desc"
				tag_pagesize=IsNum(tag_pagesize,20)

				Page_Eof=t2
				Page_Loop=t3
				Page_Field=tag_field
				Page_Table=tag_table
				Page_Where=tag_where
				Page_Order=tag_order
				Page_PageSize=tag_pagesize
				Page_Html=Match.value
			Next
		End IF

		Set Matches=Nothing
	End Sub
	
	'==============================
	'循环标签参数解析，此函数准备作废
	'==============================
	Public Function Getlable(ByVal t0,ByVal t1)
		Dim Matches,Match
		t0=Lcase(t0)
		IF Len(t0)<=3 or Instr(t0,"=")=0  then Getlable="":Exit Function
		Reg.Pattern=""&t1&"=[""]([\s\S]+?)[""]"
		Set Matches=Reg.Execute(t0)
		IF Matches.Count>0 Then
			For Each Match In Matches
				Getlable=Lcase(Match.SubMatches(0))
			Next
		End IF
		Set Matches=Nothing
	End Function
	
	'==============================
	'循环标签参数解析
	'==============================
	Public Function Getlables(ByVal t0)
		Dim Arr:Arr=False
		Dim I:I=0
		Dim Matches,Match
		Reg.Pattern="\s?(\w.+?)\s*=\s*[""]([\s\S.]*?)[""]\s+"
		Set Matches=Reg.Execute(t0&" ")'必须加空格，否则无法获取最后一个标签

		IF Matches.Count Then
			ReDim Arr(Matches.Count-1,1)
			'0=属性,1=属性值
			For Each Match In Matches
				Arr(I,0)=Match.SubMatches(0)
				Arr(I,1)=Match.SubMatches(1)
				I=I+1
			Next
		End IF
		Getlables=Arr
	End Function
	
	'==============================
	'循环标签主体解析
	'==============================
	Public Function Getloop(ByVal t0,ByVal t1,ByVal t2)
		Dim Matches,Match
		IF t2 Then Reg.Pattern="{@eof}([\s\S]+?){/@eof}" Else Reg.Pattern="{eof}([\s\S]+?){/eof}"
		Set Matches=Reg.Execute(t0)
		IF Matches.Count>0 Then
			For Each Match In Matches
				Select Case t1
					Case "0":Getloop=Match.SubMatches(0)
					Case Else:Getloop=Reg.Replace(t0, "")
				End Select
			Next
		Else
			Select Case t1
					Case "0":Getloop=""
					Case Else:Getloop=t0
			End Select
		End IF
		Set Matches=Nothing
	End Function
	
	'==============================
	'一维单标签属性解析
	'==============================
	Public Function Single_tag(ByVal t0,ByVal t1)
		Dim t2,t3,t4,Tag_len,Tag_date,Tag_function,Tag_functions,Matches,Match
		On Error Resume Next
		IF t1 Then Reg.Pattern="{@([\s\S]+?)}" Else Reg.Pattern="{([\s\S]+?)}"
		Set Matches=Reg.Execute(t0)
		IF Matches.Count>0 Then
			For Each Match In Matches
				t2=Match.SubMatches(0)
				
				Tag_len=Getlable(t2,"len")
				Tag_date=Getlable(t2,"date")
				Tag_function=Getlable(t2,"function")
				
				t3=Split(t2," ")(0)
				t3=Rs(t3)
				IF IsNull(t3) Then t3=""'防止字段内容Null
				
				IF Err Then Err.Clear
 				IF Len(Tag_function)>0 Then
					Tag_functions=Split(Tag_function,",")
					Select Case Lcase(Tag_functions(0))
						Case "nohtml":t3=Removehtml(t3)
						Case "ubound":t3=Ubound(Split(t3,"|"))
						Case "len":IF IsNull(t3) Or Len(t3)=0 Then t3=0 Else t3=Len(t3)
						Case "urlencode":t3=Server.UrlEncode(t3)
						Case "urldecode":t3=UrlDecode(t3)
						Case "total":t3=Eval(Replace(Left(t3,Len(t3)-1),"|","+"))
						Case "keyword":t3=Highlight(t3,Tag_functions(1))
						Case "v":t3=v(t3)
						Case "rv":t3=rv(t3)
						Case "rev":t3=rev(t3)
					End Select
				End IF
				
				IF Len(Tag_Len)>0 Then
					IF IsNumeric(Tag_Len) Then
						t3=GotTopic(t3,Clng(Tag_Len))
					End IF
				End IF
				
				IF Len(Tag_date)>0 Then
					t4=Tag_date
					t4=Replace(t4,"week",WeekDayName(weekday(t3)))
					t4=Replace(t4,"yyyy",Year(t3))
					t4=Replace(t4,"yy",Right(Year(t3),2))
					t4=Replace(t4,"mm",Right("0"&Month(t3),2))
					t4=Replace(t4,"dd",Right("0"&Day(t3),2))
					t4=Replace(t4,"hh",Right("0"&Hour(t3),2))
					t4=Replace(t4,"ff",Right("0"&Minute(t3),2))
					t4=Replace(t4,"ss",Right("0"&Second(t3),2))
					t4=Replace(t4,"m",Month(t3))
					t4=Replace(t4,"d",Day(t3))
					t4=Replace(t4,"h",Hour(t3))
					t4=Replace(t4,"f",Minute(t3))
					t4=Replace(t4,"s",Second(t3))
					t3=t4
				End IF
				
				t0=Replace(t0,Match.Value,t3)
			Next
			End IF
			'IF Instr(t0,"[for k=0")>0 Then Single_tag=Loop_For(Loop_IF(t0,t1)) Else Single_tag=Loop_IF(t0,t1)
			Single_tag=Loop_For(Loop_IF(t0,t1))
			Set Matches=Nothing
	End Function
	
	'==============================
	'Loop里的IF解析
	'==============================
	Public Function Loop_IF(ByVal t0,ByVal t1)
		On Error Resume Next
		Dim Matches,Match,t2,t3,t4,t5
		IF t1 Then Reg.Pattern="\[@IF([\s\S]+?)\]([\s\S]+?)\[@End IF\]" Else Reg.Pattern="\[IF([\s\S]+?)\]([\s\S]+?)\[End IF\]"
		Set Matches=Reg.Execute(t0)
		IF Matches.Count>0 Then
			For Each Match In Matches
				IF t1 Then t3=Split(Match.SubMatches(1),"[@else]") Else t3=Split(Match.SubMatches(1), "[else]")
				IF Ubound(t3) Then t4=t3(1):t5=t3(0) Else t4="":t5=Match.SubMatches(1)
				Execute ("IF "&Match.SubMatches(0)&" Then t2 = True Else t2 = False")
				IF t2 Then t0=Replace(t0,Match.Value,t5) Else t0=Replace(t0,Match.Value,t4)
				IF Err Then Echo ""&IF_Err(Match.SubMatches(0)&"错误提示："&Err.Description) & "]":Err.Clear:Exit Function
			Next
		End IF
		Loop_IF=t0
		Set Matches=Nothing
	End Function
	
	'==============================
	'Loop里的For Next解析,只用于投票
	'==============================
	Public Function Loop_For(ByVal t0)
		Dim Matches,Match,t1,t2,t3,t4,t5,t6,t7,k
		Reg.Pattern="\[for k=([\s\S]+?)to([\s\S]+?)\]([\s\S]+?)\[vote=([\s\S]+?)\]\[result=([\s\S]+?)\]\[Next\]"
		Set Matches=Reg.Execute(t0)
		IF Matches.Count>0 Then
			For Each Match In Matches
				t1=Trim(Match.SubMatches(0))
				t2=Trim(Match.SubMatches(1))
				t3=Trim(Match.SubMatches(2))
				t4=Trim(Match.SubMatches(3))
				t5=Trim(Match.SubMatches(4))
				t4=Split(t4,"|"):t7=Eval(Replace(Left(t5,Len(t5)-1),"|","+")):t5=Split(t5,"|")
				t6=""
				For k=t1 To t2-1
					t6=t6&Replace(t3,"[k]",k)
					IF InStr(t6,"[votename]")>0 Then t6=Replace(t6,"[votename]",t4(k))
					IF InStr(t6,"[votenum]")>0 Then t6=Replace(t6,"[votenum]",t5(k))
					IF t5(k)>0 Then
						t6=Replace(t6,"[percent]",Formatpercent(t5(k)/t7,0))
					Else
						t6=Replace(t6,"[percent]","0%")
					End IF
				Next
				t0=Replace(t0,Match.Value,t6)
			Next
		End IF
		Loop_For=t0
		Set Matches=Nothing
	End Function
	
	'==============================
	'IIF解析
	'==============================
	Public Sub Sdcms_IIF()
		On Error Resume Next
		Dim Matches,Match,t1,t2,t3,t4
		Reg.Pattern="\{iif([\s\S]+?)\}([\s\S]+?)\{/iif\}"
		Set Matches=Reg.Execute(TemplateData)
		IF Matches.Count>0 Then
			For Each Match In Matches
				t1=Split(Match.SubMatches(1), "{else}")
				IF Ubound(t1) Then t2=t1(1):t3=t1(0) Else t2="":t3=Match.SubMatches(1)
				Execute("IF "&Match.SubMatches(0)&" Then t4=True Else t4=False")
				IF t4 Then TemplateData=Replace(TemplateData,Match.Value,t3) Else TemplateData=Replace(TemplateData,Match.Value,t2)
				IF Err Then Echo ""&IIF_Err(Match.SubMatches(0)&"错误提示："&Err.Description) & "]":Err.Clear:Exit Sub
			Next
		End IF
		Set Matches=Nothing
	End Sub
	
	'==============================
	'子类别信息解析
	'==============================
	Public Sub Sdcms_AllClassid()
		Dim Matches,Match
		Reg.Pattern="{sdcms:allclassid\(([\s\S]+?)\)}"
		Set Matches=Reg.Execute(TemplateData)
		IF Matches.Count>0 Then
			For Each Match In Matches
				TemplateData=Replace(TemplateData,Match.value,get_son_classid(Match.SubMatches(0)))
			Next
		End IF
		Set Matches=Nothing
	End Sub
	
	'==============================
	'类别连接解析
	'==============================
	Public Sub Sdcms_Category()
		Dim Matches,Match
		Reg.Pattern="{sdcms:category\(([\s\S]+?)\)}"
		Set Matches=Reg.Execute(TemplateData)
		IF Matches.Count>0 Then
			For Each Match In Matches
				TemplateData=Replace(TemplateData,Match.value,get_category(Match.SubMatches(0)))
			Next
		End IF
		Set Matches=Nothing
	End Sub

	'==============================
	'单表循环解析
	'==============================
	Public Function Get_Table(ByVal t0,ByVal t1,ByVal t2,ByVal t3,ByVal t4,ByVal t5,ByVal t6,ByVal t7,ByVal t8)
		IF Sdcms_Cache Then
			IF Check_Cache("Get_Table_"&t0&t1&t2&t3&t4&t5&t6&t7&t8) Then
				Create_Cache "Get_Table_"&t0&t1&t2&t3&t4&t5&t6&t7&t8,Get_Table_Cache(t0,t1,t2,t3,t4,t5,t6,t7,t8)
			End IF
			Get_Table=Load_Cache("Get_Table_"&t0&t1&t2&t3&t4&t5&t6&t7&t8)
		Else
			Get_Table=Get_Table_Cache(t0,t1,t2,t3,t4,t5,t6,t7,t8)
		End IF
	End Function
	
	Public Function Get_Table_Cache(ByVal t0,ByVal t1,ByVal t2,ByVal t3,ByVal t4,ByVal t5,ByVal t6,ByVal t7,ByVal t8)
		On Error Resume Next
		Dim Sql,i,j,t9,get_loops
		Get_Table_Cache=""
 
		IF t2>0 Then t9="top "&t2&""
		Sql="Select "&t9&" "&t7&" From "&t5&" "&t3&" "&t8&""
		DbQuery=DbQuery+1
		IF t4="rnd" Then
			IF Sdcms_DataType Then
				Randomize
				Sql=Sql&" Order By rnd(-(id +" & rnd() & "))"
			Else
				Sql=Sql&" Order By newid()"
			End IF
		Else
			IF t4<>"0" Then
				Sql=Sql&" Order By "&t4
			End IF
		End IF
		DbOpen
		Set Rs=Conn.Execute(Sql)
		IF Err Then Err.Clear:Get_Table_Cache=Sql_Err(Sql):Exit Function
		IF Rs.Eof Then
			Get_Table_Cache=t0
		End if
		i=1:j=0
		While Not Rs.Eof
			Get_Loops=t1
			
			Dim dl
			IF t6 Then dl="@" Else dl=""
			IF Instr(Get_Loops,"{"&dl&"i}")>0 Then Get_Loops=Replace(get_loops,"{"&dl&"i}",i)
			IF Instr(Get_Loops,"{"&dl&"j}")>0 Then Get_Loops=Replace(get_loops,"{"&dl&"j}",j)

			IF Instr(Lcase(get_loops),"{classurl}")>0 Then
				Select Case Sdcms_Mode
					Case "0":Get_Loops=Replace(Get_Loops,"{classurl}",Sdcms_Root&"Info/?id="&Rs("classID"))
					'修改
					'Case "1":Get_Loops=Replace(Get_Loops,"{classurl}",Sdcms_Root&"Info/"&Rs("classurl")&Sdcms_Filetxt)
					Case "1":Get_Loops=Replace(Get_Loops,"{classurl}",Sdcms_Root&"html/"&Rs("classurl"))
					Case Else:Get_Loops=Replace(Get_Loops,"{classurl}",Sdcms_Root&Sdcms_HtmDir&Rs("ClassUrl"))
				End Select
			End IF
			
			IF Instr(get_loops,"{"&dl&"link}")>0 Then
				Dim ReUrl
	 
				Select Case Sdcms_Mode
					Case "2"
						Select Case Lcase(t5)
							Case "sd_class":ReUrl=Rs("ClassUrl")
							Case "view_info":ReUrl=Rs("ClassUrl")&Rs("htmlname")
							Case "sd_other":ReUrl=Rs("pagedir")&Rs("htmlname")
							Case "sd_topic":ReUrl=Rs("ID")
							Case "sd_tags":ReUrl=Server.URLEncode(Rs("title"))
							Case Else:ReUrl=Rs("ID")
						End Select
					Case "1"
						Select Case Lcase(t5)
							Case "sd_tags":ReUrl=Server.URLEncode(Rs("title"))
							Case "view_info":ReUrl=Rs("ClassUrl")&Rs("id")
							Case "sd_class":ReUrl=Rs("ClassUrl")
							Case Else:ReUrl=Rs("ID")
						End Select
					Case "0"
						Select Case Lcase(t5)
							Case "sd_tags":ReUrl=Server.URLEncode(Rs("title"))
							Case Else:ReUrl=Rs("ID")
						End Select
					Case Else
					ReUrl=Rs("ID")
				End Select
				
				Get_Loops=Replace(Get_Loops,"{"&dl&"link}",Get_Link(t5,ReUrl))
			End IF
			
			Get_Table_Cache=Get_Table_Cache&Single_tag(Get_Loops,t6)
		i=i+1:j=j+1
		Rs.Movenext
		Wend
		Rs.Close
		Set Rs=Nothing
	End Function
	
	'==============================
	'分页循环解析
	'==============================
	Public Function Get_Page(ByVal t0,ByVal t1,ByVal t2)
			Dim t3
			t3=t0
			t3=Replace(t3,"{@i}",t2)
			IF Instr(t3,"{@link}")>0 Then
		
				Select Case Lcase(t1)
					Case "sd_tags"
						t3=Replace(t3,"{@link}",Get_Link(t1,Server.URLEncode(Rs("title"))))
					Case "view_info"
						Select Case Sdcms_Mode
							Case "0"
								t3=Replace(t3,"{@link}",Get_Link(t1,Rs("ID")))
							Case "1"
								t3=Replace(t3,"{@link}",Get_Link(t1,Rs("ClassUrl")&Rs("ID")))
							Case "2"
							t3=Replace(t3,"{@link}",Get_Link(t1,Rs("ClassUrl")&Rs("htmlname")))
						End Select
					Case Else
						t3=Replace(t3,"{@link}",Get_Link(t1,Rs("ID")))
				End Select
			End IF
			
			IF Instr(Lcase(t3),"{@classurl}")>0 Then
				Select Case Sdcms_Mode
					Case "0":t3=Replace(t3,"{@classurl}",Sdcms_Root&"Info/?id="&Rs("classID"))
					'修改
					'Case "1":t3=Replace(t3,"{@classurl}",Sdcms_Root&"Info/"&Rs("classID")&Sdcms_Filetxt)
					Case "1":t3=Replace(t3,"{@classurl}",Sdcms_Root&"html/"&Rs("classurl"))
					Case Else:t3=Replace(t3,"{@classurl}",Sdcms_Root&Sdcms_HtmDir&Rs("ClassUrl"))
				End Select
			End IF
			
			IF Instr(t3,"{@tags}")>0 Then
				t3=Replace(t3,"{@tags}",get_tags(Rs("tags")))
			End IF
			
			Get_Page=Single_tag(t3,True)
	End Function

	'==============================
	'自定义解析
	'==============================
	Public Sub Sdcms_DIY()
		On Error Resume Next
		Dim Matches,Match,reobj
		Reg.Pattern="\{diy\}([\s\S]+?)\{/diy\}"
		Set Matches=Reg.Execute(TemplateData)
		IF Matches.Count>0 Then
			For Each Match In Matches
				'Execute("Set reobj = "&Match.SubMatches(0)&"")
				'Execute(""&Match.SubMatches(0)&"")
				'reobj = Execute("LabelData.Item(""sdcms:class_title"")")
				'Response.write reobj

				'TemplateData=Replace(TemplateData,Match.Value,Execute("LabelData.Item(""sdcms:class_title"")"))'reobj)

				IF Err Then Echo "自定义标签: ["&(Match.SubMatches(0)&"错误提示："&Err.Description) & "]<br />":Err.Clear:Exit Sub
			Next
		End IF
		Set Matches=Nothing
	End Sub

End Class

Function Get_Link(ByVal t0,ByVal t1)
	Select Case Lcase(t0)
		Case "view_info","sd_info"
				Select Case Sdcms_Mode
					Case "0":Get_Link=Sdcms_Root&"Info/View.Asp?id="&t1
					Case "1":Get_Link=Sdcms_Root&"html/"&t1&Sdcms_Filetxt
					Case Else:Get_Link=Sdcms_Root&Sdcms_HtmDir&t1&Sdcms_Filetxt
				End Select
		Case "sd_class"
			Select Case Sdcms_Mode
				Case "0":Get_Link=Sdcms_Root&"Info/?id="&t1
				'Case "1":Get_Link=Sdcms_Root&"Info/"&t1&Sdcms_Filetxt
				'修改
				Case "1":Get_Link=Sdcms_Root&"html/"&t1
				Case Else:Get_Link=Sdcms_Root&Sdcms_HtmDir&t1
			End Select
		Case "sd_other"
			Select Case Sdcms_Mode
				Case "0":Get_Link=Sdcms_Root&"Page/?id="&t1
				Case "1":Get_Link=Sdcms_Root&"Page/"&t1&Sdcms_Filetxt
				Case Else:Get_Link=Sdcms_Root&t1&Sdcms_Filetxt
			End Select
		Case "sd_topic"
			Select Case Sdcms_Mode
				Case "1":Get_Link=Sdcms_Root&"Topic/List_"&t1&Sdcms_Filetxt
				Case Else:Get_Link=Sdcms_Root&"Topic/List.Asp?id="&t1
			End Select
		Case "sd_tags"
			Select Case Sdcms_Mode
				Case "1":Get_Link=Sdcms_Root&"tags/"&t1&Sdcms_Filetxt
				Case Else:Get_Link=Sdcms_Root&"tags/?tag="&t1&""
			End Select
	End Select
End Function
%>