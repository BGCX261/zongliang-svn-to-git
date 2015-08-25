<!--#include file="../Include/Const.asp" -->
<!--#include file="../Include/ConnSiteData.asp" -->
<!--#include file="Admin_Htmlconfig.asp"-->
<%
	Dim runTimeCount
		runTimeCount=0
	If request.QueryString("rtm")<>"" Then runTimeCount = request.QueryString("rtm") End If
%>
<script>
	var runTimeCount=<%=runTimeCount%>;
	var showTM = setInterval("showTime()", 1000);
	function showTime()	{
		runTimeCount=runTimeCount+1;
		var h = m = s = 0;
		if (runTimeCount >= 60){
			if((runTimeCount/60) >= 60){
				h=parseInt((runTimeCount/60)/60);
				m=parseInt((runTimeCount-((h*60))/60));
				s=parseInt(runTimeCount-((h*60*60)+(m*60)));
			}else{
				m=parseInt(runTimeCount/60);
				s=runTimeCount-(m*60);
			}
		} else{
			s=runTimeCount;
		}
		
		txt_runtm.innerHTML="当前生成共计用时: <span style='color:red'>"+h+"</span>:<span style='color:red'>"+m+"</span>:<span style='color:red'>"+s+"</span>";
	}

	//showTime();
</script>
<link rel="stylesheet" href="Images/Admin_style.css">
<style>
body {overflow:hidden;}
li {list-style: none; height: 22px; line-height:22px;}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%
if Instr(session("AdminPurview"),"|34,")=0 then
  response.write ("<br /><br /><div align=""center""><font style=""color:red; font-size:9pt; "")>您没有管理该模块的权限！</font></div>")
  response.end
end if
if ISHTML = 0 Then
  'Response.Redirect("/404.html")
  response.Write "<script language='javascript'>alert('请先在【系统参数配置】中将静态HTML设置为开启！');history.go(-1);</script>"
  response.End
end If
'==========================================
'	测试函数(判断是否为数字)
'	value	值
'==========================================
Function BetaIsInt(value)
	on error resume next 
	dim str 
	dim l,i 
	if isNUll(value) then 
		BetaIsInt=0 
		exit function 
	end if 
	str=cstr(value) 
	if trim(str)="" then 
		BetaIsInt=0 
		exit function 
	end if 
	l=len(str) 
	for i=1 to l 
		if mid(str,i,1)>"9" or mid(str,i,1)<"0" then 
			BetaIsInt=0 
			exit function 
		end if 
	next 
	BetaIsInt=value 
	if err.number<>0 then err.clear 
End Function

%>

<br />
<table width="98%" height="100px" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
	<td width="10%">&nbsp;</td>
    <td width="300"><table width="100%" border="0" cellspacing="0" cellpadding="1">
        <tr>
          <td style="border-bottom: #ccc 1px solid; border-top: #ccc 1px solid; border-left: #ccc 1px solid; border-right: #ccc 1px solid"><img src="Images/Survey_1.gif" width="0" height="16" id="bar_img" name="bar_img" align="absmiddle"></td>
        </tr>
      </table></td>
    <td style="padding-left:20px">
		<span id="bar_txt2" name="bar_txt2" style="font-size:12px; color:red;"></span>
		<span id="bar_txt1" name="bar_txt1" style="font-size:12px"></span><br />
		<span id="sp_newinfo" name="sp_newinfo" style="font-size:12px"></span>
		<span id="bar_txtbai" name="bar_txtbai" style="font-size:12px"></span><br />
		<span id="txt_ncount" name="txt_ncount" style="font-size:12px"></span>
		<span id="txt_runtm" name="txt_runtm" style="font-size:12px;margin-left:50px;"></span>
	</td>
  </tr>
</table>
<div style="width:100%;height:60%;margin:0px;" align="center">
	<div id="div_showInfo" style="width:80%; height:100%; overflow:auto; border: 3px solid #CCC; padding:5px;" align="left">
		<a id="tst" name="tst" href="#tst">&nbsp;</a>
<%
	Dim pID
		pID="0"
	Dim HtmlPageCounts
		HtmlPageCounts=0
	If request.QueryString("id")<>"" Then pID = request.QueryString("id") End If
	If request.QueryString("hpCount")<>"" Then HtmlPageCounts = request.QueryString("hpCount") End If

	If pID<>"0" Then
		If pID="1" Then
			pID="2"
			Call HtmlAllProSort			'-	生成产品分类页面
		ElseIf pID="2" Then
			pID="3"
			Call HtmlPro				'-	生成产品详细页面
		ElseIf pID="3" Then
			pID="4"
			Call HtmlNewSort			'-	生成新闻分类页面
		ElseIf pID="4" Then
			pID="5"
			Call HtmlNews				'-	生成新闻详细页面
		ElseIf pID="5" Then
			pID="6"
			Call HtmlInfo				'-	生成企业信息页面
		ElseIf pID="6" Then
			pID="7"
			Call HtmlDownSort			'-	生成下载分类页面
		ElseIf pID="7" Then
			pID="8"
			Call HtmlDown				'-	生成下载详细页面
		ElseIf pID="8" Then
			pID="9"
			Call HtmlJobSort			'-	生成招聘列表页面	--q ?
		ElseIf pID="9" Then
			pID="10"
			'Call HtmlJob				'-	生成招聘详细页面	-- qqq
			Call HtmlOtherSort			'-	生成其它分类页面
		ElseIf pID="10" Then
			pID="11"
			Call HtmlOther				'-	生成其它详细页面
		ElseIf pID="11" Then
			pID="12"
			Call HtmlKeySort			'-	生成服务范围列表	--q	old..
		ElseIf pID="12" Then
			pID="13"
			Call HtmlKey				'-	生成服务范围详细	--q	old..
		ElseIf pID="13" Then
			pID="14"
			'Response.end
			Call HtmlimageSort			'-	生成图片案例列表
		ElseIf pID="14" Then
			pID="15"
			Call HtmlImage				'-	生成图片案例详细
		ElseIf pID="15" Then
			pID="16"
			Call HtmlVideoSort			'-	企业视频列表页面
		ElseIf pID="16" Then
			pID="17"
			Call HtmlMagazineSort		'-	生成电子杂志页面
		ElseIf pID="17" Then
			pID="18"
			Call HtmlIndex				'-	生成首页
		'Else
			Over="Yes"
			'Response.End
		End If
	Else
		pID="1"
		'Call HtmlAllProSort			'-	生成产品分类页面
	End If
	
	If Over="" Then
	
		'Response.write("ID:"&pID&" Count:"&HtmlPageCounts)
		Dim url
			url=""&Request.ServerVariables("Url")&"?id="&pID&"&hpCount="&HtmlPageCounts&""
	
		If pID="1" Then
			Response.write("<script>document.location='"&url&"&rtm='+runTimeCount+'';</script>")
		Else
			Response.write("<script>var tm=3; function Nx(){bar_txt1.innerHTML='当前模块生成成功! 正准备生成下一模块...'+tm+'&nbsp;&nbsp;&nbsp;&nbsp;如果页面没有刷新,请<a href="""&url&"&rtm=""+runTimeCount+"""">点击此处</a>'; tm=tm-1;setTimeout('Nx()',1000);}</script>")
			Response.write("<script>Nx(); setTimeout(function(){document.location='"&url&"&rtm='+runTimeCount+'';},3000);</script>")
		End If
	Else
		Response.write("<script type='text/javascript' src='http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js'></script>")
		Response.write("<script>bar_img.width=300;</script>")
		Response.write("<script>bar_txt1.innerHTML=""已经成功生成所有静态文件<a href='/' target='_blank' style='color:red'>点击查看</a>"";</script>")
		Response.write("<script>bar_txt2.innerHTML='';</script>")
		Response.write("<script>bar_txtbai.innerHTML='';</script>")
		Response.Write("<script>sp_newinfo.innerHTML='';</script>")
		Response.Write("<script>window.clearInterval(showTM);showTime();</script>")
		Response.Write("<script>$('#div_showInfo').hide(3000);</script>")
	End If
	
%>
</div></div>