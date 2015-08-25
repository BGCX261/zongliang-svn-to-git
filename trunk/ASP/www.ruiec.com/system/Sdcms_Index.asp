<!--#include file="sdcms_check.asp"-->
<!--#include file="../plug/Config.asp"-->
<%
Dim Sdcms
Set Sdcms=New Sdcms_Admin
Sdcms.Check_admin
Sdcms.Check_lever ""
Set Sdcms=Nothing
Sdcms_Head
%>
<script type="text/javascript">
	$(document).ready(
	function() 
	{
		$(".left_title").click(function(){
			$(this).next("ul").slideToggle()
			.siblings(".dis:visible").slideUp();
			$(this).toggleClass("left_title_over");
			$(this).siblings(".left_title_over").removeClass("left_title_over");
		});
	});
</script>
<Script>if(self!=top){top.location=self.location;}</script>
	<div id="head">
		<div class="left"><img src="images/sdcms_logo.gif" alt="中瑞传媒网站信息管理系统"/></div>
		<div class="left head_txt">您好：<%=sdcms_adminname%>　[ <a href="sdcms_admin.asp?id=<%=sdcms_adminid%>&action=edit" target="main">我的帐户</a> <span><a href="index.asp?action=out">退出</a></span> ]</div>
		<div class="right head_menu">
		  <ul id="head_menu">
			  <li><a href="../" target="_blank">预览网站</a></li>
			  <li><a href="sdcms_index.asp">刷新后台</a></li>
			  <li><a href="sdcms_set.asp" target="main">系统设置</a></li>
			  <li><a href="sdcms_info.asp" target="main">信息管理</a></li>
			  <li><a href="sdcms_cache.asp" target="main">更新缓存</a></li>
		  </ul>
		</div>	
	</div>
<!--head is over-->
	 <div id="content">
	 <div id="left">
          <div class="left_title">系统管理</div>
		  <ul class="dis">
		  <li class="left_link" onClick="DoLocation(this)"><a href="sdcms_set.asp" target="main">系统设置</a>　　<a href="sdcms_log.asp" target="main">日志</a></li>
		  <li class="left_link" onClick="DoLocation(this)"><a href="sdcms_admin.asp?action=add" target="main">添加帐户</a>　　<a href="sdcms_admin.asp" target="main">管理</a></li>
		  </ul>
		  
		  <div class="left_title">信息管理</div>
		  <ul class="dis">
		  <li class="left_link" onClick="DoLocation(this)"><a href="sdcms_class.asp?action=add" target="main">添加分类</a>　　<a href="sdcms_class.asp" target="main">管理</a></li>
		  <li class="left_link" onClick="DoLocation(this)"><a href="Sdcms_Topic.asp?action=add" target="main">添加专题</a>　　<a href="Sdcms_Topic.asp" target="main">管理</a></li>
		  <li class="left_link" onClick="DoLocation(this)"><a href="sdcms_info.asp?action=add" target="main">添加信息</a>　　<a href="sdcms_info.asp" target="main">管理</a></li>
		  <li class="left_link" onClick="DoLocation(this)"><a href="sdcms_Page.asp?action=add" target="main">添加单页</a>　　<a href="sdcms_Page.asp" target="main">管理</a></li>
		  </ul>
		  
		  <div class="left_title">附加工具</div>
		  <ul class="dis">
		  <li class="left_link" onClick="DoLocation(this)"><a href="sdcms_sitelink.asp" target="main">内链管理</a>　<a href="sdcms_tags.asp" target="main">Tags管理</a></li>
		  <li class="left_link" onClick="DoLocation(this)"><a href="sdcms_search.asp" target="main">搜索管理</a>　<a href="sdcms_outsite.asp" target="main">站外调用</a></li>
		  </ul>
		  
		  <div class="left_title">插件管理</div>
		  <ul class="dis">
		  <%=Plug_menu%>
		  </ul>
		  
		  <div class="left_title">界面管理</div>
		  <ul class="dis">
		  <li class="left_link" onClick="DoLocation(this)"><a href="sdcms_label.asp?action=add" target="main">添加碎片</a>　　<a href="sdcms_label.asp" target="main">管理</a></li>
		  <li class="left_link" onClick="DoLocation(this)"><a href="sdcms_skins.asp" target="main">网站模板管理</a></li>
		  </ul>
		  <%IF Sdcms_Mode=2 Then%>
		  <div class="left_title">生成管理</div>
		  <ul class="dis">
		  <li class="left_link" onClick="DoLocation(this)"><a href="sdcms_create.asp?Stype=1"  target="main">生成首页</a></li>
		  <li class="left_link" onClick="DoLocation(this)"><a href="sdcms_create.asp?Stype=2"  target="main">生成栏目</a></li>
		  <li class="left_link" onClick="DoLocation(this)"><a href="sdcms_create.asp?Stype=3"  target="main">生成信息</a></li>
		  <li class="left_link" onClick="DoLocation(this)"><a href="sdcms_create.asp?Stype=4"  target="main">生成单页</a></li>
		  <li class="left_link" onClick="DoLocation(this)"><a href="sdcms_create.asp?Stype=5"  target="main">生成地图</a></li>
		  </ul>  
		  <%End IF%>
     </div>
	   
	<div id="right">
		<iframe id="Main_Content" scrolling="auto" name="main" src="sdcms_main.asp" frameborder="0"></iframe>
	</div>

	</div>
</div>
<script language="javascript">window.setInterval("reinitIframe('Main_Content')",300);</script>
</body>
</html>
