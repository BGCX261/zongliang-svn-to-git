<%
'============================================================
'插件配置：后台管理菜单等项目
'Website：http://www.sdcms.cn
'Author：IT平民
'Date：2008-11-15
'LastUpDate:2011-10
'============================================================
Function Plug_menu
	Plug_menu=""
	Plug_menu=Plug_menu&"<li class=""left_link"" onClick=""DoLocation(this)""><a href=""sdcms_link.asp"" target=""main"">链接管理</a>　　<a href=""sdcms_vote.asp"" target=""main"">投票管理</a></li>"
	Plug_menu=Plug_menu&"<li class=""left_link"" onClick=""DoLocation(this)""><a href=""sdcms_ad.asp"" target=""main"">广告管理</a>　　<a href=""sdcms_comment.asp"" target=""main"">评论管理</a></li>"
	Plug_menu=Plug_menu&"<li class=""left_link"" onClick=""DoLocation(this)""><a href=""sdcms_book.asp"" target=""main"">留言管理</a>　　<a href=""Sdcms_Spider.asp"" target=""main"">蜘蛛来访</a></li>"
	Plug_menu=Plug_menu&"<li class=""left_link"" onClick=""DoLocation(this)""><a href=""Sdcms_Coll_Item.asp"" target=""main"">采集管理</a></li>"
End Function
%>