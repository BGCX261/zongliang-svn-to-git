<%
Dim ClassPage
Class Sdcms_Create
	Public Sub Create_Index()
		Dim FileName,Temp,Show
	    FileName="index"&Sdcms_FileTxt
		Set Temp=New Templates
			Temp.Load(Load_temp_dir&sdcms_skins_index)
			Show=Temp.Gzip
			Show=Temp.Display
			IF Sdcms_Mode=2 Then
				SaveFile Sdcms_Root,FileName,show
				Echo "首页生成成功：<a href="&Sdcms_Root&FileName&" target=_blank>"&FileName&"</a><br>"
			Else
				Echo Show
			End IF
		Set Temp=Nothing
	End Sub

	Public Sub Create_Map
		Dim Temp,FileName,show
		Set Temp=New Templates
	    FileName="sitemap"&Sdcms_FileTxt
		Temp.Label "{sdcms:map}",showmap
		Temp.Load(Load_temp_dir&sdcms_skins_map)
		Show=Temp.Gzip
		Show=Temp.Display
		IF Sdcms_Mode=2 Then
			SaveFile Sdcms_Root,FileName,show
			Echo "地图生成成功：<a href="&Sdcms_Root&FileName&" target=_blank>"&FileName&"</a><br>"
		Else
			Echo Show
		End IF
		Set Temp=Nothing
	End sub
	
	Public Sub Create_Google_Map(t0,t1,t2)
		SaveFile Sdcms_Root,"SiteMap.Xml",sitemap_google(t0,t1,t2)
		Echo "Google地图生成成功：<a href="&Sdcms_Root&"SiteMap.Xml target=_blank>SiteMap.Xml</a><br>"
	End Sub
	
	Public Function Sitemap_Google(t0,t1,t2)
		Dim t3,t4,t5,Rs
		t0=IsNum(t0,0)
		IF t1="" then t1="daily"
		IF t2="" then t2="0.8"
		t5="<?xml version=""1.0"" encoding=""UTF-8""?>"&vbcrlf
		t5=t5&"<urlset xmlns=""http://www.google.com/schemas/sitemap/0.84"">"&vbcrlf
		t5=t5&"<url>"&vbcrlf
		t5=t5&"<loc>"&Sdcms_WebUrl&"</loc>"
		t5=t5&"<lastmod>"&Year(Now())&"-"&Right("0"&Month(Now()),2)&"-"&Right("0"&Day(Now()),2)&"T"&Right("0"&Hour(Now()),2)&":"&Right("0"&Minute(Now()),2)&":"&Right("0"&Second(Now()),2)&"+08:00</lastmod>"&vbcrlf
		t5=t5&"<changefreq>"&t1&"</changefreq>"&vbcrlf
		t5=t5&"<priority>"&t2&"</priority>"&vbcrlf
		t5=t5&"</url>"&vbcrlf
		IF t0>0 Then t3=" top "&t0
		Set Rs=Conn.Execute("Select "&t3&" id,ClassUrl,htmlname,lastupdate,ClassUrl From View_Info Where ispass=1 order by lastupdate desc,id desc")
		While Not Rs.Eof
		t5=t5&"<url>"&vbcrlf
		Select Case Sdcms_Mode
			Case "0"
				t5=t5&"<loc>"&sdcms_weburl&Sdcms_Root&"Info/View.Asp?ID="&Rs(0)&"</loc>"&vbcrlf
			Case "1"
				t5=t5&"<loc>"&sdcms_weburl&Sdcms_Root&"html/"&Rs(4)&Rs(0)&Sdcms_FileTxt&"</loc>"&vbcrlf
			Case "2"
				t5=t5&"<loc>"&sdcms_weburl&Sdcms_Root&Sdcms_HtmDir&Rs(1)&Rs(2)&Sdcms_FileTxt&"</loc>"&vbcrlf
		End Select
		t4=Year(Rs(3))&"-"&Right("0"&Month(Rs(3)),2)&"-"&Right("0"&Day(Rs(3)),2)&"T"&Right("0"&Hour(Rs(3)),2)&":"&Right("0"&Minute(Rs(3)),2)&":"&Right("0"&Second(Rs(3)),2)&"+08:00"
		t5=t5&"<lastmod>"&t4&"</lastmod>"&vbcrlf
		t5=t5&"</url>"&vbcrlf
		Rs.MoveNext
		Wend
		Rs.Close
		Set Rs=Nothing
		t5=t5&"</urlset>"&vbcrlf
		sitemap_google=t5
	End Function
	
	Public Sub Create_Class_List(ID)
		Dim Rs_Class
		Set Rs_Class=Conn.Execute("Select ClassUrl,Class_Type From Sd_Class Where Id="&ID&"")
		IF Rs_Class.Eof Then
			Rs_Class.Close:Set Rs_Class=Nothing
			Exit Sub
		Else
			IF Sdcms_Mode=2 Then Create_Folder(Sdcms_Root&Sdcms_HtmDir&Rs_Class(0))
			Select Case Rs_Class(1)
				Case "0":Create_I_list ID
				Case Else:Create_channel ID
			End Select
			'Rs_Class.Close:Set Rs_Class=Nothing
		End IF
	End Sub
	
	Public Sub Create_Channel(t0)
		t0=IsNum(t0,0)
		Dim Temp,Rs,classname,t1,classkey,classdesc,ClassUrl,channel_temp,classfollowid,show_class_position,partentids,i,rs_p,rs_n,FileName,show,Classdir
		Set Temp=New Templates
		Set Rs=Conn.Execute("Select title,allclassid,keyword,class_desc,PageNum,ClassUrl,Channel_temp,followid,partentid,id From Sd_Class Where Id="&t0&"")
		IF Rs.Eof Then
			Rs.Close:Set Rs=Nothing
			Exit Sub
		End IF
		classname=Rs(0)
		t1=Rs(1)
		classkey=Rs(2)
		classdesc=Rs(3)
		classpage=Rs(4)
		ClassUrl=Rs(5)
		ClassDir=ClassUrl
		Channel_Temp=Rs(6)
		ClassFollowid=Rs(7)
		
		Select Case Sdcms_Mode
			Case "0":ClassUrl=Sdcms_Root&"Info/?ID="&Rs(9)
			Case "1":ClassUrl=Sdcms_Root&"Info/"&Rs(9)&Sdcms_FileTxt
			Case Else:ClassUrl=Sdcms_Root&Sdcms_HtmDir&ClassUrl
		End Select
		
		Show_Class_Position=""
		partentids=Rs(8)
		Rs.Close:Set Rs=Nothing
		
		Dim ClassRoot
		partentids=Split(partentids,",")
		For I=Ubound(partentids) To 0 Step -1 
			Set Rs_P=Conn.Execute("Select ClassUrl,title,ID From Sd_Class Where Id="&partentids(i)&"")
			IF Not Rs_P.eof Then
				Select Case Sdcms_Mode
					Case "0":ClassRoot=Sdcms_Root&"Info/?Id="&Rs_P(2)
					Case "1":ClassRoot=Sdcms_Root&"Info/"&Rs_P(2)&Sdcms_Filetxt
					Case "2":ClassRoot=Sdcms_Root&Sdcms_HtmDir&Rs_P(0)
				End Select
				Show_Class_Position=Show_Class_Position&" > <a href="&ClassRoot&">"&Rs_P(1)&"</a>"
				Rs_P.Close:Set Rs_P=Nothing
			End IF
		Next
		
		Temp.Label "{sdcms:class_id}",t0
		Temp.Label "{sdcms:class_title}",classname
		Temp.Label "{sdcms:class_key}",classkey
		Temp.Label "{sdcms:class_desc}",classdesc
		Temp.Label "{sdcms:class_allclassid}",t1
		Temp.Label "{sdcms:class_classurl}",ClassUrl
		Temp.Label "{sdcms:class_url}",classurl
		Temp.Label "{sdcms:class_followid}",classfollowid
		Temp.Label "{sdcms:class_position}",show_class_position
		
		FileName="Index"&Sdcms_FileTxt

		IF Len(channel_temp)=0 Then
			Temp.Load(Load_temp_dir&sdcms_skins_info_channel)
		Else
			Temp.Load(Sdcms_Root&channel_temp)
		End IF
		Show=Temp.Gzip
		Show=Temp.Display
		IF Sdcms_Mode=2 Then
			SaveFile Sdcms_Root&Sdcms_HtmDir&ClassDir,FileName,Show
			Echo "频道首页生成成功：<a href="&Sdcms_Root&Sdcms_HtmDir&ClassDir&" target=_blank>"&FileName&"</a><br>"
		Else
			Echo Show
		End IF
		
		Set Temp=Nothing
	End Sub
	
	'-----------------------------------------------------------
	Public Sub Create_I_List(t0)
		Dim Temp,classname,t1,classkey,classdesc,ClassUrl,ClassDir,ClassTemp,ClassFollowid
		Dim Show_Class_Position,partentids,I,Rs_P,Rs_N
		Set Temp=New Templates
		Set Rs=Conn.Execute("Select title,allclassid,keyword,class_desc,pagenum,ClassUrl,list_temp,followid,partentid,id From Sd_Class Where Id="&t0&"")
		IF Rs.Eof Then
			Rs.Close:Set Rs=Nothing
			Exit Sub
		End IF
		classname=Rs(0)
		t1=Rs(1)
		ClassKey=Rs(2)
		ClassDesc=Gottopic(Rs(3),150)
		ClassPage=Rs(4)
		ClassUrl=Rs(5)
		ClassDir=ClassUrl
		ClassTemp=Rs(6)
		ClassFollowid=Rs(7)
		
		Select Case Sdcms_Mode
			Case "0":classurl=Sdcms_Root&"Info/?ID="&Rs(9)
			Case "1":classurl=Sdcms_Root&"Info/"&Rs(9)&Sdcms_FileTxt
			Case Else:classurl=Sdcms_Root&Sdcms_HtmDir&ClassUrl
		End Select
		
		Show_Class_Position=""
		Partentids=Rs(8)
		
		Dim ClassRoot
		Partentids=Split(Partentids,",")
		For I=Ubound(Partentids) To 0 Step -1 
			Set Rs_P=Conn.Execute("Select ClassUrl,title,ID From Sd_Class Where Id="&partentids(I)&"")
			IF Not Rs_P.eof Then
				Select Case Sdcms_Mode
					Case "0":ClassRoot=Sdcms_Root&"Info/?Id="&Rs_P(2)
					'修改
					'Case "1":ClassRoot=Sdcms_Root&"Info/"&Rs_P(2)&Sdcms_Filetxt
					Case "1":ClassRoot=Sdcms_Root&"category/"&Rs_P(0)
					Case "2":ClassRoot=Sdcms_Root&Sdcms_HtmDir&Rs_P(0)
				End Select
				Show_Class_Position=Show_Class_Position&" > <a href="&ClassRoot&">"&Rs_P(1)&"</a>"
				Rs_P.Close:Set Rs_P=Nothing
			End IF
		Next
		
		Temp.Label "{sdcms:class_id}",t0
		Temp.Label "{sdcms:class_title}",ClassName
		Temp.Label "{sdcms:class_key}",ClassKey
		Temp.Label "{sdcms:class_desc}",ClassDesc
		Temp.Label "{sdcms:class_allclassid}",t1
		Temp.Label "{sdcms:class_classurl}",ClassUrl
		Temp.Label "{sdcms:class_url}",ClassUrl
		Temp.Label "{sdcms:class_followid}",ClassFollowid
		Temp.Label "{sdcms:class_position}",Show_Class_Position
		Rs.Close
		Set Rs=Nothing
		Dim Sql,IndexName,Show
		Dim Page
		Page=IsNum(Trim(Request.QueryString("Page")),1)
		
		'===========================
		IF Len(Classtemp)=0 Then
			Show=Temp.Sdcms_Load(Load_temp_dir&sdcms_skins_info_list_text)
		Else
			Show=Temp.Sdcms_Load(Sdcms_Root&Classtemp)
		End IF
		
		Temp.TemplateContent=Show
		Temp.Analysis_Static()
		Show=Temp.Display
		Temp.Page_Mark(Show)
		
		Dim PageField,PageTable,PageWhere,PageOrder,PagePageSize,PageEof,PageLoop,PageHtml
		PageHtml=Temp.Page_Html
		PageField=Temp.Page_Field
		PageTable=Temp.Page_Table
		PageWhere=Temp.Page_Where
		PageOrder=Temp.Page_Order
		PagePageSize=Temp.Page_PageSize
		PageEof=Temp.Page_Eof
		PageLoop=Temp.Page_Loop
		IF Len(PagePageSize)=0 Then
			Echo "请正确使用列表模板":Exit Sub
		End IF
		IF PagePageSize=20 Then PagePageSize=ClassPage
	
		Dim P
		Set P=New Sdcms_Page
			With P
				.Conn=Conn
				.Pagesize=PagePageSize
				.PageNum=Page
				.Table=PageTable
				.Field=PageField
				.Where=PageWhere
				.Key="ID"
				.Order=PageOrder
				Select Case Sdcms_Mode
					Case "0"
						.PageStart="?ID="&ID&"&Page="
					Case "1"
					'修改
						'.PageStart=""&ID&"_"
						'.PageEnd=Sdcms_Filetxt
						.PageStart=""
						.PageEnd=""
					Case "2"
						.PageStart="Index_"
						.PageEnd=Sdcms_Filetxt
						IF Page=1 Then
							IndexName="Index"&Sdcms_FileTxt
						Else
							IndexName="Index_"&Page&Sdcms_FileTxt
						End IF
				End Select
			End With
			Set Rs=P.Show
			
			IF Err Then
				Temp.Label "{sdcms:listpage}",""
				Show=Replace(Show,PageHtml,PageEof)
				Temp.Label "{sdcms:listpage}",""
				Err.Clear
			Else
				Dim Get_Loop,t2
				Get_Loop=""
				t2=""
				For I=1 To P.PageSize
					IF Rs.Eof Or Rs.Bof Then Exit For
						t2=PageLoop
						t2=t2&Temp.Get_Page(t2,PageTable,I)
						Get_Loop=Get_Loop&t2
					Rs.MoveNext
				Next
				Get_Loop=Replace(Get_Loop,PageLoop,"")
				Show=Replace(Show,PageHtml,Get_Loop)
				Temp.Label "{sdcms:listpage}",P.PageList
			End IF
			Temp.TemplateContent=Show
			Temp.Analysis_Static()
			Temp.Analysis_Loop()
			Temp.Analysis_IIF()
			Show=Temp.Gzip
			Show=Temp.Display
			IF Sdcms_Mode=2 Then
				SaveFile Sdcms_Root&Sdcms_HtmDir&ClassDir,IndexName,Show
				Echo "列表生成成功：<a href="&Sdcms_Root&Sdcms_HtmDir&ClassDir&" target=_blank>"&IndexName&"</a><br>"
			Else
				Echo Show
			End IF
		'=============
		Set P=Nothing
		Set Temp=Nothing
	End Sub
	
	Public Sub Create_Info_Show(t0)
		t0=IsNum(t0,0)
		Dim FileName,Temp,rs_n,show_i_id,show_i_title,show_i_author,show_i_date,show_i_hits_hits,show_i_hits_day,show_i_hits_week,show_i_hits_month,show_i_commentnum
		Dim show_i_content,show_i_classid,show_i_keyword,show_i_jj,show_i_htmlname,show_i_tags,show_i_comefrom,show_i_Likeid,show_i_Pic,show_i_update,show_i_position
		Dim partentids,i,content_page,pagenums,k,Info_Class_Url,sql,show_i_classid_followid,rs_p,getcontent,infoname,show,Info_Web_Url,show_IsComment
		Dim Show_I_Style,Show_I_ClassName,Show_I_Show_Temp
		FileName="index"&Sdcms_FileTxt
		Set Temp=New Templates
		
		Sql="Select id,title,author,adddate,hits,content,url,isurl,classid,keyword,jj,htmlname,tags,comefrom,LikeID,pic,lastupdate,classurl,IsComment,"
		Sql=Sql&"Followid,Partentid,Style,ClassName,Show_Temp From View_info Where id="&t0&" And IsPass=1"
		Set Rs_N=Conn.Execute(Sql)
		IF Rs_N.Eof Then
			Echo "提示：信息未通过审核，不能查阅"
			Rs_n.Close:Set Rs_n=Nothing
			Exit Sub
		Else
		    show_i_id=Rs_N(0)
			show_i_title=Rs_N(1)
			show_i_author=Rs_N(2)
			show_i_date=Rs_N(3)
			show_i_hits_hits=Rs_N(0)&",1,0"
			show_i_hits_day=Rs_N(0)&",1,1"
			show_i_hits_week=Rs_N(0)&",1,2"
			show_i_hits_month=Rs_N(0)&",1,3"
			show_i_commentnum=Rs_N(0)
			IF Rs_N(7)=0 Then
				show_i_content=UbbCode(SiteLinks(Rs_N(5)))
			Else
				show_i_content="<script>window.location.href='"&Rs_N(6)&"';</script>"
			End IF
			show_i_classid=rs_n(8)
			show_i_classid_followid=Rs_N(19)
			show_i_keyword=Rs_N(9)
			show_i_jj=Gottopic(removehtml(Rs_N(10)),200)
			show_i_htmlname=Rs_N(11)
			show_i_tags=get_tags(Rs_N(12))
			show_i_comefrom=Rs_N(13)
			show_i_Likeid=Rs_N(14)
			show_i_Pic=Rs_N(15)
			show_i_update=Rs_N(16)
			 
			Select Case Sdcms_Mode
				Case "0"
				Info_Class_Url=Sdcms_Root&"Info/?Id="&Rs_N(8)
				Info_Web_Url=Sdcms_WebUrl&Sdcms_Root&"Info/View.Asp?Id="&Rs_N(0)
				Case "1"
				Info_Class_Url=Sdcms_Root&"html/"&Rs_N(17)
				Info_Web_Url=Sdcms_WebUrl&Sdcms_Root&"html/"&Rs_N(17)&Rs_N(0)&Sdcms_Filetxt
				Case "2"
				Info_Class_Url=Sdcms_Root&Sdcms_HtmDir&Rs_N(17)
				Info_Web_Url=Sdcms_WebUrl&Sdcms_Root&Sdcms_HtmDir&Rs_N(17)&show_i_htmlname&Sdcms_FileTxt
			End Select
			
			show_IsComment=Rs_N(18)
			partentids=Rs_N(20)
			Show_I_Style=Rs_N(21)
			Show_I_ClassName=Rs_N(22)
			Show_I_Show_Temp=Rs_N(23)
			
			Rs_N.Close
			Set Rs_N=Nothing
		End IF
		show_i_position=""

		Dim ClassRoot
		partentids=Split(partentids,",")
		For I=ubound(partentids) To 0 Step -1 
			Set Rs_P=Conn.Execute("Select ClassUrl,title,ID From Sd_class Where Id="&partentids(I)&"")
			IF Not Rs_P.Eof Then
				Select Case Sdcms_Mode
					Case "0"
						ClassRoot=Sdcms_Root&"Info/?Id="&Rs_P(2)
					'修改
					'Case "1"
						'ClassRoot=Sdcms_Root&"Info/"&Rs_P(2)&Sdcms_Filetxt
					Case "1"
						ClassRoot=Sdcms_Root&"html/"&Rs_P(0)
					Case "2"
						ClassRoot=Sdcms_Root&Sdcms_HtmDir&Rs_P(0)
				End Select
				show_i_position=show_i_position&" > <a href="&ClassRoot&">"&Rs_P(1)&"</a>"
				Rs_P.Close:Set Rs_P=Nothing
			End IF
		Next

		Temp.Label "{sdcms:info_id}",show_i_id
		Temp.Label "{sdcms:info_title}",show_i_title
		Temp.Label "{sdcms:info_keyword}",show_i_keyword
		Temp.Label "{sdcms:info_desc}",show_i_jj
		Temp.Label "{sdcms:info_author}",show_i_author
		Temp.Label "{sdcms:info_comefrom}",show_i_comefrom
		Temp.Label "{sdcms:info_date}",show_i_date
		Temp.Label "{sdcms:info_hits}",show_i_hits_hits
		Temp.Label "{sdcms:info_dayhits}",show_i_hits_day
		Temp.Label "{sdcms:info_weekhits}",show_i_hits_week
		Temp.Label "{sdcms:info_monthhits}",show_i_hits_month
		Temp.Label "{sdcms:info_commentnum}",show_i_commentnum
		Temp.Label "{sdcms:info_tags}",show_i_tags
		Temp.Label "{sdcms:info_classid}",show_i_classid
		'信息所在类别所属的父类别ID
		Temp.Label "{sdcms:info_followid}",show_i_classid_followid
		Temp.Label "{sdcms:info_classname}",Show_I_ClassName
		Temp.Label "{sdcms:info_classurl}",Info_Class_Url
		Temp.Label "{sdcms:info_position}",show_i_position
		Temp.Label "{sdcms:info_likeid}",show_i_likeid
		Temp.Label "{sdcms:info_pic}",show_i_pic
		Temp.Label "{sdcms:info_update}",show_i_update
		Temp.Label "{sdcms:info_url}",Info_Web_Url
		Temp.Label "{sdcms:info_iscomment}",show_IsComment
		Temp.Label "{sdcms:info_style}",Show_I_Style
		IF Sdcms_Mode=2 Then
			FileName=show_i_id&Sdcms_FileTxt
			'======================================
			'增加的分页标签内容
			getcontent=Split(show_i_content,"$show_page$")
			pagenums=Ubound(getcontent)
			For I=0 to pagenums  
				IF I=0 then infoname=show_i_htmlname&Sdcms_FileTxt Else infoname=show_i_htmlname&"_"&i&Sdcms_FileTxt
				show_i_content=getcontent(i)
				content_page=""
				
				IF I=0 Then
					content_page=content_page&"<a>首页</a>"
				Else
					content_page=content_page&"<a href="&show_i_htmlname&""&Sdcms_FileTxt&">首页</a>"
				End IF
				
				IF I=0 Then
					content_page=content_page&"<a>上一页</a>"
				ElseIF i=1 Then
					content_page=content_page&"<a href="&show_i_htmlname&""&Sdcms_FileTxt&">上一页</a>"
				Else
					content_page=content_page&"<a href="&show_i_htmlname&"_"&i-1&""&Sdcms_FileTxt&">上一页</a>"
				End IF
				
				IF I=0 then
					content_page=content_page&"<a class=""on"">1</a>"
				Else
					content_page=content_page&"<a href="&show_i_htmlname&""&Sdcms_FileTxt&">1</a>"
				End IF
				
				For k=1 to pagenums-1
					IF pagenums<>1  and pagenums>i then
						IF i=k then
							content_page=content_page&"<a class=""on"">"&k+1&"</a>"
						Else
							content_page=content_page&"<a href='"&show_i_htmlname&"_"&k&Sdcms_FileTxt&"'>"&k+1&"</a>"
						End if
					End if
					IF i=pagenums then
						IF i=k then
							content_page=content_page&"<a class=""on"">"&k&"</a>"
						Else
							content_page=content_page&"<a href='"&show_i_htmlname&"_"&k&Sdcms_FileTxt&"'>"&k+1&"</a>"
						End if
					End if
				Next
				
				if i<pagenums or i>k then
					content_page=content_page&"<a href='"&show_i_htmlname&"_"&pagenums&Sdcms_FileTxt&"'>"&pagenums+1&"</a>"
				else
					content_page=content_page&"<a class=""on"">"&pagenums+1&"</a>"
				end if
				
				if i<pagenums or i>k then
					content_page=content_page&"<a href="&show_i_htmlname&"_"&i+1&""&Sdcms_FileTxt&">下一页</a>"
				else
					content_page=content_page&"<a>下一页</a>"
				end if
				
				if i>=pagenums then
					content_page=content_page&"<a>末页</a>"
				else
					content_page=content_page&"<a href="&show_i_htmlname&"_"&k&Sdcms_FileTxt&">末页</a>"
				end if
				
				if pagenums<=0 then
					content_page=""
				end if
				
				Temp.Label "{sdcms:info_content}",show_i_content
				Temp.Label "{sdcms:info_page}",content_page
				IF Len(Show_I_Show_Temp)=0 Then
					Temp.Load(Load_temp_dir&sdcms_skins_info_show)
				Else
					Temp.Load(Sdcms_Root&Show_I_Show_Temp)
				End IF
				Show=Temp.Gzip
				Show=Temp.Display
				SaveFile Info_Class_Url,InfoName,Show
				Echo "生成成功：<a href="&Info_Class_Url&show_i_htmlname&Sdcms_FileTxt&" target=_blank>"&InfoName&"</a><BR>"
			Next
			
			'增加内分页标签$show_page$结束
			'======================================
		Else
			Temp.Label "{sdcms:info_content}",Get_Content_Page(show_i_content)
			Temp.Label "{sdcms:info_page}",Get_Content_Page_Page(show_i_content,"")
			IF Len(Show_I_Show_Temp)=0 Then
				Temp.Load(Load_temp_dir&sdcms_skins_info_show)
			Else
				Temp.Load(Sdcms_Root&Show_I_Show_Temp)
			End IF
			Show=Temp.Gzip
			Echo Temp.Display
		End IF
		Set Temp=Nothing	
	End Sub
	
	Public Sub Create_Other(t0)
		t0=IsNum(t0,0)
		Dim temp,sql,Rs_P,other_id,other_title,other_content,other_url,other_pagedir,other_page_temp,other_followid,other_Key,other_Desc
	    Set Temp=New Templates
		Sql="Select title,content,htmlname,pagedir,page_temp,followid,Page_Key,Page_Desc from sd_other where id="&t0
		Set Rs_P=Conn.Execute(Sql)
		IF Rs_P.eof Then
			Rs_P.Close:Set rs_P=Nothing
			Exit Sub
		Else
		    other_id=t0
		    other_title=Rs_P(0)
			other_content=UbbCode(sitelinks(Rs_P(1)))
			other_url=Rs_P(2)
			other_pagedir=Rs_P(3)
			other_page_temp=Rs_P(4)
			other_followid=Rs_P(5)
			other_Key=Rs_P(6)
			other_Desc=Rs_P(7)
			Rs_P.close
			Set Rs_P=Nothing
		End IF
		other_pagedir=Sdcms_Root&other_pagedir
		Create_Folder(other_pagedir)
		'======================================
		'增加的分页标签内容
		Temp.Label "{sdcms:other_id}",other_id
		Temp.Label "{sdcms:other_title}",other_title
		Temp.Label "{sdcms:other_url}",other_url
		Temp.Label "{sdcms:other_pagedir}",other_pagedir
		Temp.Label "{sdcms:other_followid}",other_followid
		Temp.Label "{sdcms:other_key}",other_Key
		Temp.Label "{sdcms:other_desc}",other_Desc
		IF Sdcms_Mode=2 Then
		Dim getcontent,pagenums,i,FileName,k,show,content_page
		getcontent=split(other_content,"$show_page$")
		pagenums=ubound(getcontent)
		for i=0 to pagenums  
			if i=0 then
				FileName=other_url&Sdcms_FileTxt
			else
				FileName=other_url&"_"&i&Sdcms_FileTxt
			end if   
			other_content=getcontent(i)
			content_page=""
			if i=0 then
				content_page=content_page&"<a>首页</a>"
			else
				content_page=content_page&"<a href="&other_url&""&Sdcms_FileTxt&">首页</a>"
			end if
			if i=0 then
				content_page=content_page&"<a>上一页</a>"
			elseif i=1 then
				content_page=content_page&"<a href="&other_url&""&Sdcms_FileTxt&">上一页</a>"
			else
				content_page=content_page&"<a href="&other_url&"_"&i-1&""&Sdcms_FileTxt&">上一页</a>"
			end if
			if i=0 then
				content_page=content_page&"<a class=""on"">1</a>"
			else
				content_page=content_page&"<a href="&other_url&""&Sdcms_FileTxt&">1</a>"
			end if
			for k=1 to pagenums-1
				if pagenums<>1  and pagenums>i then
					if i=k then
						content_page=content_page&"<a class=""on"">"&k+1&"</a>"
					else
						content_page=content_page&"<a href='"&other_url&"_"&k&Sdcms_FileTxt&"'>"&k+1&"</a>"
					end if
				end if
				if i=pagenums then
					if i=k then
						content_page=content_page&"<a class=""on"">"&k&"</a>"
					else
						content_page=content_page&"<a href='"&other_url&"_"&k&Sdcms_FileTxt&"'>"&k+1&"</a>"
					end if
				end if
			next
			if i<pagenums or i>k then
				content_page=content_page&"<a href='"&other_url&"_"&pagenums&Sdcms_FileTxt&"'>"&pagenums+1&"</a>"
			else
				content_page=content_page&"<a class=""on"">"&pagenums+1&"</a>"
			end if
			if i<pagenums or i>k then
				content_page=content_page&"<a href="&other_url&"_"&i+1&""&Sdcms_FileTxt&">下一页</a>"
			else
				content_page=content_page&"<a>下一页</a>"
			end if
			if i>=pagenums then
				content_page=content_page&"<a>末页</a>"
			else
				content_page=content_page&"<a href="&other_url&"_"&k&Sdcms_FileTxt&">末页</a>"
			end if
			if pagenums<=0 then 
				content_page=""
			end if

			Temp.Label "{sdcms:other_content}",other_content
			Temp.Label "{sdcms:other_page}",content_page
			IF Len(other_page_temp)=0 Then
				Temp.Load(Load_temp_dir&sdcms_skins_page)
			Else
				Temp.Load(Sdcms_Root&other_page_temp)
			End IF
			Show=Temp.Gzip
			Show=Temp.Display	
			SaveFile other_pagedir,FileName,show 
			Echo "生成成功：<a href="&other_pagedir&FileName&" target=_blank>"&FileName&"</a><br>"
		next
        '增加内分页标签$show_page$结束
		'======================================
		Else
			Temp.Label "{sdcms:other_content}",Get_Content_Page(other_content)
			Temp.Label "{sdcms:other_page}",Get_Content_Page_Page(other_content,"")
			IF Len(other_page_temp)=0 Then
				Temp.Load(Load_temp_dir&sdcms_skins_page)
			Else
				Temp.Load(Sdcms_Root&other_page_temp)
			End IF
			Show=Temp.Gzip
			Show=Temp.Display	
			Echo Show
		End IF
	End Sub
End Class
%>