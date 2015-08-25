<%@codepage="65001"%>
<%Session.CodePage=65001%>
<!--#include file="Inc/Const.asp"-->
<%
Dim count,turl
If Request.QueryString("c")<>"" Then
	count = IsNum(Trim(Request.QueryString("c")),5)
End If
If Request.QueryString("url")<>"" Then
	turl = (Trim(Request.QueryString("turl")))
End If
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script type='text/javascript'>
$(function(){
	var _wrap=$('ul.list'); 
	var _interval=4000; 
	var _moving; 
	_wrap.hover(function(){
		clearInterval(_moving); 
	},function(){
		_moving=setInterval(function(){
			var _field=_wrap.find('li:first'); 
			var _h=_field.height(); 
			_field.animate({marginTop:-_h+'px'},600,function(){ 
				_field.css('marginTop',0).appendTo(_wrap); 
			})
		},_interval) 
	}).trigger('mouseleave'); 
});
</script>
<style type="text/css">
body,h1,h2,h3,h4,h5,h6,dl,dt,dd,ul,ol,li,th,td,p,blockquote,pre,form,egend,input,button,textarea,hr{margin:0;padding:0;}
h1,h2,h3,h4,h5,h6{font-size:100%;}
ul{list-style:none;}
ul,ol{ padding:0px;}
img{border:0;}
q:before,q:after{content:'';}
abbr[title]{border-bottom:1px dotted;cursor:help;}
cite,dfn,em,var{font-style:normal;}
button,input,select,textarea{font-size:100%;}
code,kbd,samp{font-family:"Courier New",monospace;}
hr{border:none;height:1px;}
html,body{ font:12px/1.8 Arial; color:#000; text-align:left;}
#metnewlist{ color:#e5ecf4; width:498px; }
#metnewlist .title{ float:left; height:25px; line-height:25px;}
#metnewlist .list{ float:left; width:400px; padding:0px; margin:0px;}
#metnewlist .list li{ width:400px; list-style:none; height:25px; line-height:25px; overflow:hidden;}
#metnewlist .list li span{ float:right; margin-right:5px; margin-right:0px\9; }
#metnewlist .list li a{ color:#e5ecf4;}
</style>
</head>
<body style="BACKGROUND-COLOR: transparent">
  <div id='metnewlist'>
	<div class='title'>官方新闻：</div>
	<ul class='list'>
<%
	Connstr="Provider=Microsoft.Jet.OLEDB.4.0;Data Source="&Server.MapPath(Sdcms_Root&Sdcms_DataFile&"/"&Sdcms_DataName)
	Set Conn=Server.CreateObject("Adodb.Connection")
	Conn.Open ConnStr
	IF Err then 
		Echo "数据库连接失败!"
		Err.Clear
		Response.End()
	End IF
	Dim lrs,sql
	Set lrs = server.createobject("adodb.recordset")
	sql = "SELECT TOP 5 * FROM Sd_Info WHERE ClassId = 8 "
	lrs.open sql, Conn, 0, 1
	If lrs.eof Then 
		Response.write("<li><span></span><a href='http://new.ruiec.com/' target=_blank title='not found'>暂无相关通告</a></li>")
	Else
		Do While Not lrs.eof
			Response.write("<li><span>["&lrs("AddDate")&"]</span><a href='http://new.ruiec.com/Info/View.asp?ID="&lrs("ID")&"' target='_blank' title='"&lrs("Title")&"'>"&lrs("Title")&"</a></li>")
			lrs.movenext
		Loop
	End If	
	lrs.close 
	set lrs=Nothing
	Conn.close
	Set Conn=Nothing
%>
	</ul>
	<div style='clear:both;'></div>
  </div>
</body>
</html>