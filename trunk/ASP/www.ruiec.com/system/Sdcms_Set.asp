<!--#include file="sdcms_check.asp"-->
<!--#include file="../Inc/AspJpeg.asp"-->
<%
Dim Sdcms,title,Sd_Table,Action,ID
ID=IsNum(Trim(Request.QueryString("ID")),0)
Action=Lcase(Trim(Request.QueryString("Action")))
Set Sdcms=New Sdcms_Admin
Sdcms.Check_admin
Sdcms.Check_lever 1
Set sdcms=Nothing
title="系统设置"
Sd_Table="sd_const"
Sdcms_Head
%>
<div class="sdcms_notice"><span>管理操作：</span><a href="?">系统设置</a><!--　┊　<a href="?">会员设置</a>--></div>
<br>
<ul id="sdcms_sub_title">
	<li class="sub"><a href="javascript:void(0)" onClick="selectTag('tagContent0',this)"><%=title%></a></li>
	<li class="unsub"><a href="javascript:void(0)" onClick="selectTag('tagContent1',this)">过滤设置</a></li>
	<li class="unsub"><a href="javascript:void(0)" onClick="selectTag('tagContent2',this)">生成设置</a></li>
	<li class="unsub"><a href="javascript:void(0)" onClick="selectTag('tagContent3',this)">上传设置</a></li>
</ul>
<div id="sdcms_right_b">
<%
Select Case Action
	Case "save":save
	Case Else:main
End Select
Db_Run
Closedb
Sub Main
	Dim Rs,i,all_set,FontArr
	Set Rs=Conn.Execute("Select id,webname,weburl,webkey,webdec From "&Sd_Table&" Where Id=1")
	DbQuery=DbQuery+1
	IF Rs.eof then
		Echo "请勿非法提交参数":Exit Sub
	End IF
	Echo Check_Add
%><form name="add" method="post" action="?action=save" onSubmit="return checkadd()">
  <table width="98%" border="0" align="center" cellpadding="3" cellspacing="1" id="tagContent0">
    <tr>
      <td width="150" align="center" class="tdbg">网站名称：</td>
      <td class="tdbg"><input name="t0" type="text" class="input" value="<%=rs(1)%>" size="30"></td>
    </tr>
    <tr class="tdbg">
      <td align="center">网站域名：</td>
      <td><input name="t1" type="text" class="input" value="<%=rs(2)%>"  size="30">　<span>形式为：http://www.sdcms.cn　不需要加“/”</span></td>
    </tr>
	<tr class="tdbg">
      <td align="center">运行模式：</td>
      <td><input name="t23" type="radio" value="0" <%=IIF(Sdcms_Mode=0,"Checked","")%> id="t23_0" onclick="$('#t3')[0].value='.asp';$('#modetip')[0].style.display='none'"><label for="t23_0">动态</label> <input name="t23" type="radio"  value="1" <%=IIF(Sdcms_Mode=1,"Checked","")%> id="t23_1"  onclick="$('#t3')[0].value='.html';$('#modetip')[0].style.display='inline'" <%if len(request.ServerVariables("HTTP_X_REwrite_url"))=0 then%>disabled="disabled"<%end if%>><label for="t23_1">伪静态</label> <input name="t23" type="radio"  value="2" <%=IIF(Sdcms_Mode=2,"Checked","")%> id="t23_2" onclick="$('#t3')[0].value='.html';$('#modetip')[0].style.display='none'"><label for="t23_2">静态</label>　<span id="modetip" class="<%=IIF(Sdcms_Mode<>1,"dis","")%>">伪静态模式需要空间支持Rewrite组件</span></td>
    </tr>
    <tr class="tdbg">
      <td align="center">博客模式：</td>
      <td><input name="t26" type="radio" value="true" <%=IIF(blogmode,"Checked","")%> id="t26_0"  ><label for="t26_0">开启</label> <input name="t26" type="radio"  value="false" <%=IIF(not(blogmode),"Checked","")%> id="t26_1"><label for="t26_1">关闭</label></td>
    </tr>
	<tr class="tdbg">
      <td align="center">文件后缀：</td>
      <td><select name="t3" id="t3">
	    <option selected>请选择文件后缀</option>
		<option value=".asp" <%=IIF(Lcase(Sdcms_filetxt)=".asp","Selected","")%>>.Asp</option>
        <option value=".html" <%=IIF(Lcase(Sdcms_filetxt)=".html","Selected","")%>>.Html</option>
      </select>　<span>如果更改了后缀需要生成全站才会生效</span>      </td>
    </tr>
    <tr class="tdbg">
      <td align="center">截取长度：</td>
      <td><input name="t22" type="text" class="input" value="<%=Sdcms_length%>" size="30">　<span>信息描述自动截取长度，建议：200-500</span></td>
	</tr>
	<tr class="tdbg">
      <td align="center">时区选择：</td>
      <td><select name="t25" id="t25" style="width:400px;">
	    <option selected>请选择服务器所在时区</option>
		<option value="-20"<%=IIF(Sdcms_TimeZone=-20," selected","")%>>(<%=Dateadd("h",-20,Now())%>) 安尼威土克、瓜甲兰</option>
		<option value="-19"<%=IIF(Sdcms_TimeZone=-19," selected","")%>>(<%=Dateadd("h",-19,Now())%>) 中途岛、萨摩亚群岛</option>
		<option value="-18"<%=IIF(Sdcms_TimeZone=-18," selected","")%>>(<%=Dateadd("h",-18,Now())%>) 夏威夷</option>
		<option value="-17"<%=IIF(Sdcms_TimeZone=-17," selected","")%>>(<%=Dateadd("h",-17,Now())%>) 阿拉斯加</option>
		<option value="-16"<%=IIF(Sdcms_TimeZone=-16," selected","")%>>(<%=Dateadd("h",-16,Now())%>) 太平洋时间（美国和加拿大），蒂华纳</option>
		<option value="-15"<%=IIF(Sdcms_TimeZone=-15," selected","")%>>(<%=Dateadd("h",-15,Now())%>) 山区时间(美加)、亚利桑那</option>
		<option value="-14"<%=IIF(Sdcms_TimeZone=-14," selected","")%>>(<%=Dateadd("h",-14,Now())%>) 中部时间（美国和加拿大），特古西加尔巴，萨斯喀彻温省，墨西哥城、塔克西卡帕</option>
		<option value="-13"<%=IIF(Sdcms_TimeZone=-13," selected","")%>>(<%=Dateadd("h",-13,Now())%>) 东部时间（美国和加拿大）、波哥大、利马、基多</option>
		<option value="-12"<%=IIF(Sdcms_TimeZone=-12," selected","")%>>(<%=Dateadd("h",-12,Now())%>) 大西洋时间（加拿大）委内瑞拉、拉巴斯</option>
		<option value="-11.5"<%=IIF(Sdcms_TimeZone=-11.5," selected","")%>>(<%=Dateadd("h",-11.5,Now())%>) 新岛(加拿大东岸) 纽芬兰</option>
		<option value="-11"<%=IIF(Sdcms_TimeZone=-11," selected","")%>>(<%=Dateadd("h",-11,Now())%>) 东南美洲 波西尼亚 布鲁诺斯爱丽斯、乔治城</option>
		<option value="-10"<%=IIF(Sdcms_TimeZone=-10," selected","")%>>(<%=Dateadd("h",-10,Now())%>) 大西洋中部</option>
		<option value="-9"<%=IIF(Sdcms_TimeZone=-9," selected","")%>>(<%=Dateadd("h",-9,Now())%>) 亚速尔群岛，佛得角群岛</option>
		<option value="-8"<%=IIF(Sdcms_TimeZone=-8," selected","")%>>(<%=Dateadd("h",-8,Now())%>) 格林威治标准时间 ：伦敦，都柏林，爱丁堡，里斯本，卡萨布兰卡，蒙罗维亚，英国夏令</option>
		<option value="-7"<%=IIF(Sdcms_TimeZone=-7," selected","")%>>(<%=Dateadd("h",-7,Now())%>) 荷兰，瑞士，塞尔维亚，斯洛伐克，斯洛文尼亚，捷克，丹麦，罗马，法国，萨拉热窝，马其顿，保加利亚，波兰，克罗地亚</option>
		<option value="-6"<%=IIF(Sdcms_TimeZone=-6," selected","")%>>(<%=Dateadd("h",-6,Now())%>) 布加勒斯特，哈拉雷，南非，比勒陀尼亚，埃及，赫尔辛基，里加，塔林，明斯克，以色列</option>
		<option value="-5"<%=IIF(Sdcms_TimeZone=-5," selected","")%>>(<%=Dateadd("h",-5,Now())%>) 沙乌地阿拉伯、俄罗斯 利雅得，莫斯科，圣彼得堡，伏尔加格勒，内罗毕</option>
		<option value="-5.5"<%=IIF(Sdcms_TimeZone=-5.5," selected","")%>>(<%=Dateadd("h",-5.5,Now())%>) 伊朗</option>
		<option value="-4"<%=IIF(Sdcms_TimeZone=-4," selected","")%>>(<%=Dateadd("h",-4,Now())%>) 阿布扎比，马斯喀特，巴库、第比利斯、阿布达比(东阿拉伯)、莫斯凯、塔布理斯(乔治亚共和)、阿拉伯</option>
		<option value="-4.5"<%=IIF(Sdcms_TimeZone=-4.5," selected","")%>>(<%=Dateadd("h",-4.5,Now())%>) 阿富汗</option>
		<option value="-3"<%=IIF(Sdcms_TimeZone=-3," selected","")%>>(<%=Dateadd("h",-3,Now())%>) 西亚 : 叶卡特琳堡、卡拉奇、塔什干、伊斯兰马巴德、克洛奇、伊卡特林堡</option>
		<option value="-3.5"<%=IIF(Sdcms_TimeZone=-3.5," selected","")%>>(<%=Dateadd("h",-3.5,Now())%>) 印度 : 孟买，加尔各答，马德拉斯，新德里</option>
		<option value="-2"<%=IIF(Sdcms_TimeZone=-2," selected","")%>>(<%=Dateadd("h",-2,Now())%>) 中亚 : 阿拉木图、科伦坡、阿马提、达卡</option>
		<option value="-1"<%=IIF(Sdcms_TimeZone=-1," selected","")%>>(<%=Dateadd("h",-1,Now())%>) 曼谷，河内，雅加达</option>
		<option value="0"<%=IIF(Sdcms_TimeZone=0," selected","")%>>(<%=Dateadd("h",0,Now())%>) 中国 : 北京，重庆，广州，上海，香港，台北，新加坡</option>
		<option value="1"<%=IIF(Sdcms_TimeZone=1," selected","")%>>(<%=Dateadd("h",1,Now())%>) 平壤，汉城，东京，大阪，札幌，雅库茨克</option>
		<option value="1.5"<%=IIF(Sdcms_TimeZone=1.5," selected","")%>>(<%=Dateadd("h",1.5,Now())%>) 澳洲中部</option>
		<option value="2"<%=IIF(Sdcms_TimeZone=2," selected","")%>>(<%=Dateadd("h",2,Now())%>) 西太平洋 : 席德尼、塔斯梅尼亚、关岛，莫尔兹比港，霍巴特，堪培拉，悉尼</option>
		<option value="3"<%=IIF(Sdcms_TimeZone=3," selected","")%>>(<%=Dateadd("h",3,Now())%>) 太平洋中部 : 马加丹，所罗门群岛，新喀里多尼亚</option>
		<option value="4"<%=IIF(Sdcms_TimeZone=4," selected","")%>>(<%=Dateadd("h",4,Now())%>) 纽芬兰 : 威灵顿、斐济，堪察加半岛，马绍尔群岛</option>
      </select>　<span>不可以随意调整</span>      </td>
    </tr>
	<tr class="tdbg">
      <td align="center">是否缓存：</td>
      <td><input name="t6" type="radio" value="True" onclick="$('#cookies')[0].style.display='block';$('#cookies_date')[0].style.display='block';" <%=IIF(Sdcms_Cache=True,"Checked","")%> id="t6_0"><label for="t6_0">开启</label> <input name="t6" type="radio"  value="False" onclick="$('#cookies')[0].style.display='none';$('#cookies_date')[0].style.display='none';" <%=IIF(Sdcms_Cache=False,"Checked","")%> id="t6_1"><label for="t6_1">关闭</label></td>
    </tr>
	<tr class="tdbg<%IF Not Sdcms_Cache Then%> dis<%End IF%>" id="cookies">
      <td align="center">缓存前缀：</td>
      <td><input name="t12" type="text" class="input" value="<%=Sdcms_cookies%>"  size="30">　<span>如果有多个站点，请设置不同的值</span></td>
    </tr>
	<tr class="tdbg<%IF Not Sdcms_Cache Then%> dis<%End IF%>" id="cookies_date">
      <td align="center">缓存时间：</td>
      <td><input name="t24" type="text" class="input" value="<%=Sdcms_CacheDate%>" size="30">　<span>单位：秒</span></td>
    </tr>
	<tr class="tdbg">
      <td align="center">管理日志：</td>
      <td><input name="t18" type="radio" value="True" <%=IIF(Sdcms_AdminLog=true,"Checked","")%> id="t18_0"><label for="t18_0">开启</label> <input name="t18" type="radio"  value="False" <%=IIF(Sdcms_AdminLog=false,"Checked","")%> id="t18_1"><label for="t18_1">关闭</label> (<span>关闭则只记录登陆日志</span>)</td>
    </tr>
	<tr class="tdbg">
      <td align="center" width="14%">评论开关：</td>
      <td><input name="t7" type="radio" value="0" <%=IIF(Sdcms_comment_pass=0,"Checked","")%> id="t7_0"><label for="t7_0">关闭</label> <input name="t7" type="radio"  value="1" <%=IIF(Sdcms_comment_pass=1,"Checked","")%> id="t7_1"><label for="t7_1">开启</label></td>
    </tr>
	<tr class="tdbg">
      <td align="center">评论审核：</td>
      <td><input name="t8" type="radio" value="0" <%=IIF(Sdcms_comment_ispass=0,"Checked","")%> id="t8_0"><label for="t8_0">关闭</label> <input name="t8" type="radio"  value="1" <%=IIF(Sdcms_comment_ispass=1,"Checked","")%> id="t8_1"><label for="t8_1">开启</label></td>
    </tr>
	<tr class="tdbg">
      <td align="center">关 键 字：</td>
      <td><textarea name="t4"  rows="3"  class="inputs" id="t4"><%=Content_Encode(Rs(3))%></textarea></td>
    </tr>
	<tr class="tdbg">
      <td align="center">网站描述：</td>
      <td><textarea name="t5"  rows="3"  class="inputs" id="t5"><%=Content_Encode(Rs(4))%></textarea></td>
	</tr>
	</table>

	<table width="98%" border="0" align="center" cellpadding="3" cellspacing="1"  class="dis" id="tagContent1">
	<tr class="tdbg">
      <td width="120" align="center">HTML标签过滤：</td>
      <td><textarea name="t9"  rows="6" class="inputs"><%=Content_Encode(Sdcms_badhtml)%></textarea><span>多个请用“|”分隔</span></td>
	</tr>
	<tr class="tdbg">
      <td align="center">HTML事件过滤：</td>
      <td><textarea name="t10" rows="6" class="inputs"><%=Content_Encode(Sdcms_badEvent)%></textarea><span>多个请用“|”分隔</span></td>
	</tr>
	<tr class="tdbg">
      <td align="center">脏话过滤：</td>
      <td><textarea name="t11" rows="6" class="inputs"><%=Content_Encode(Sdcms_badtext)%></textarea><span>多个请用“|”分隔</span></td>
	</tr>
	</table>
	<table width="98%" border="0" align="center" cellpadding="3" cellspacing="1" class="dis" id="tagContent2">
	<tr class="tdbg">
      <td colspan="2">　 <b>以下为偏好设置，不作为全局参数：</b></td>
    </tr>
	<tr class="tdbg">
      <td width="120" align="center">生成目录：</td>
      <td><input name="t17" type="text" class="input" value="<%=Sdcms_htmdir%>"  size="30">　<span>根目录为空"，也可以指定为某一目录，形式为："sdcms/"</span></td>
    </tr>
	<tr class="tdbg">
      <td align="center">文件名称：</td>
      <td><select name="t16"><option value="{ID}" <%=IIF(Sdcms_filename="{ID}","selected","")%>>自动编号</option><option value="{YYMMDDID}" <%=IIF(Sdcms_filename="{YYMMDDID}","selected","")%>>年+月+日+编号</option><option value="{PinYin}" <%=IIF(Sdcms_filename="{PinYin}","selected","")%>>标题拼音</option></select></td>
    </tr>
	<tr class="tdbg">
      <td align="center">信息管理：</td>
      <td><%all_set="生成首页|生成分类|生成信息":all_set=Split(all_set,"|"):For I=0 To Ubound(all_set)%><input name="t15" type="checkbox" value="<%=I%>" <%=IIF(Instr(", "&Sdcms_Create_Set&", ",", "&I&", ")>0,"Checked","")%> id="<%=I%>"><label for="<%=I%>"><%=all_set(i)%></label>
	  <%next%></td>
    </tr>
	<tr class="tdbg">
      <td colspan="2"><b>Google地图选项：</b></td>
      </tr>
	  <tr>
      <td align="center" class="tdbg">数　　量：</td>
      <td class="tdbg"><input name="t21" type="text" class="input" value="<%=Sdcms_Create_GoogleMap(0)%>" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;" />　<span>为0时显示全部</span></td>
    </tr>
	<tr>
      <td align="center" class="tdbg">频　　率：</td>
      <td class="tdbg"><select name="t21"><option value="always" <%=IIF(Sdcms_Create_GoogleMap(1)="always","Selected","")%>>Always</option><option value="hourly" <%=IIF(Sdcms_Create_GoogleMap(1)="hourly","Selected","")%>>Hourly</option><option value="daily" <%=IIF(Sdcms_Create_GoogleMap(1)="daily","Selected","")%>>Daily</option><option value="weekly"  <%=IIF(Sdcms_Create_GoogleMap(1)="weekly","Selected","")%>>Weekly</option><option value="monthly"  <%=IIF(Sdcms_Create_GoogleMap(1)="monthly","Selected","")%>>Monthly</option><option value="yearly"  <%=IIF(Sdcms_Create_GoogleMap(1)="yearly","Selected","")%>>Yearly</option></select></td>
    </tr>
	<tr>
      <td align="center" class="tdbg">优 先 权：</td>
      <td class="tdbg"><input name="t21" type="text" class="input" value="<%=Sdcms_Create_GoogleMap(2)%>" />　<span>0-1之间的数字</span></td>
    </tr> 
	</table>
	<table width="98%" border="0" align="center" cellpadding="3" cellspacing="1" class="dis" id="tagContent3">
	<tr class="tdbg">
      <td align="center" width="120">上传目录：</td>
      <td><input name="t14" type="text" class="input" value="<%=Sdcms_upfiledir%>"  size="40">　<span>更改默认设置后可能会影响以前的信息</span></td>
    </tr>
	<tr class="tdbg">
      <td align="center">文件类型：</td>
      <td><input name="t19" type="text" class="input" value="<%=Sdcms_upfiletype%>"  size="40">　<span>允许上传的文件类型，多个请用“|”格开</span></td>
    </tr>
	<tr class="tdbg">
      <td align="center">文件限制：</td>
      <td><input name="t20" type="text" class="input" value="<%=Sdcms_upfileMaxSize%>" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;"  size="40">　<span>允许上传的文件最大值，单位：KB</span></td>
    </tr>
	<tr class="tdbg">
      <td align="center">图像组件：</td>
      <td><select name="f0" size="1" id="f0"><option value="false" <%=IIF(Sdcms_Jpeg_t0=False,"Selected","")%>>关闭</option><option value="True" <%=IIF(Sdcms_Jpeg_t0=True,"Selected","")%>>AspJpeg<%=IIF(IsObjInstalled("Persits.Jpeg"),"√","×")%></option></select></td>
    </tr>
	<tr class="tdbg">
      <td align="center">缩 略 图：</td>
      <td>宽度：<input name="f13" type="text" value="<%=Sdcms_Jpeg_t13%>"  onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;" class="input" size="5" /> 高度：<input name="f14" type="text" value="<%=Sdcms_Jpeg_t14%>" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;" class="input" size="5" />　<span>为0时，按比例缩小</span></td>
    </tr>
	<tr class="tdbg">
      <td align="center">算　　法：</td>
      <td><select name="f15" size="1" onchange="<%For i=0 To 2%>$('#sf<%=i%>')[0].style.display='none';<%Next%>$('#sf'+this.value)[0].style.display='inline';"><option value="0" <%=IIF(Sdcms_Jpeg_t15=0,"Selected","")%>>常规法</option><option value="1" <%=IIF(Sdcms_Jpeg_t15=1,"Selected","")%>>裁剪法</option><option value="2" <%=IIF(Sdcms_Jpeg_t15=2,"Selected","")%>>补充法</option></select>　<span id="sf0" <%=IIF(Sdcms_Jpeg_t15<>0,"class=""dis""","")%>>常规法：宽度和高度都大于0时，直接缩小成指定大小，其中一个为0时，按比例缩小</span><span id="sf1" <%=IIF(Sdcms_Jpeg_t15<>1,"class=""dis""","")%>>裁剪法：宽度和高度都大于0时，先按最佳比例缩小再裁剪成指定大小，其中一个为0时，按比例缩小</span><span id="sf2" <%=IIF(Sdcms_Jpeg_t15<>2,"class=""dis""","")%>>补充法：在指定大小的背景图上附加上按最佳比例缩小的图片</span></td>
    </tr>
	<tr class="tdbg">
      <td align="center">水印类型：</td>
      <td><input name="f1" type="radio" value="True" <%=IIF(Sdcms_Jpeg_t1=true,"checked","")%> onclick="<%for i=1 to 5%>$('#jpeg0<%=i%>')[0].style.display='block';<%next%><%For i=6 to 8%>$('#jpeg0<%=i%>')[0].style.display='none';<%next%>" id="f1_0"><label for="f1_0">文字水印</label> <input name="f1" type="radio" value="False"  <%=IIF(Sdcms_Jpeg_t1=false,"checked","")%>  onclick="<%for i=1 to 5%>$('#jpeg0<%=i%>')[0].style.display='none';<%next%><%for i=6 to 8%>$('#jpeg0<%=i%>')[0].style.display='block';<%next%>" id="f1_1"><label for="f1_1">图片水印</label></td>
    </tr>
	<tr class="tdbg">
      <td align="center">水印质量：</td>
      <td><input name="f2" type="text" value="<%=Sdcms_Jpeg_t2%>" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;" class="input" />　<span>0-100 为100时质量最好</span></td>
    </tr>
	<tr class="tdbg <%IF Not Sdcms_Jpeg_t1 Then%>dis<%End IF%>" id="jpeg01">
      <td align="center">水印文字：</td>
      <td><input name="f3" type="text" value="<%=Sdcms_Jpeg_t3%>" class="input" /></td>
    </tr>
	<tr class="tdbg <%IF Not Sdcms_Jpeg_t1 Then%>dis<%End IF%>" id="jpeg02">
      <td align="center">文字字体：</td>
      <td><select name="f4" size="1">
	  <%FontArr=Split("宋体|楷体_GB2312|黑体|隶书|幼圆|Arial|Verdana","|"):For I=0 To Ubound(FontArr)%>
	  <option value="<%=FontArr(I)%>" <%=IIF(Sdcms_Jpeg_t4=FontArr(I),"selected","")%>><%=FontArr(I)%></option>
	  <%Next%>
	  </select></td>
    </tr>
	<tr class="tdbg <%IF Not Sdcms_Jpeg_t1 Then%>dis<%End IF%>" id="jpeg03">
      <td align="center">字体大小：</td>
      <td><input name="f5" type="text" value="<%=Sdcms_Jpeg_t5%>" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;" class="input" />　<span>单位：Px</span></td>
    </tr>
	<tr class="tdbg <%IF Not Sdcms_Jpeg_t1 Then%>dis<%End IF%>" id="jpeg04">
      <td align="center">字体颜色：</td>
      <td><input name="f6" type="text" value="<%=Replace(Sdcms_Jpeg_t6,"&H","#")%>" maxlength="7" class="input" />　<span>如：#000000</span></td>
    </tr>
	<tr class="tdbg <%IF Not Sdcms_Jpeg_t1 Then%>dis<%End IF%>" id="jpeg05">
      <td align="center">是否加粗：</td>
      <td><input name="f7" type="radio" value="1" <%=IIF(Sdcms_Jpeg_t7=1,"checked","")%> id="f7_0"><label for="f7_0">是</label> <input name="f7" type="radio" value="0" <%=IIF(Sdcms_Jpeg_t7=0,"checked","")%> id="f7_1"><label for="f7_1">否</label></td>
    </tr>
	<tr class="tdbg <%IF Sdcms_Jpeg_t1 Then%>dis<%End IF%>" id="jpeg06">
      <td align="center">水印图片：</td>
      <td><input name="f8" id="f8" type="text" value="<%=Sdcms_Jpeg_t8%>" class="input" /><%admin_upfile 1,"100%","20","f8","UpLoadIframe",0,0%></td>
    </tr>
	<tr class="tdbg <%IF Sdcms_Jpeg_t1 Then%>dis<%End IF%>" id="jpeg07">
      <td align="center" >透 明 度：</td>
      <td><input name="f9" type="text" value="<%=Sdcms_Jpeg_t9%>" class="input" />　<span>0-1之间的数字</span></td>
    </tr>
	<tr class="tdbg <%IF Sdcms_Jpeg_t1 Then%>dis<%End IF%>" id="jpeg08">
      <td align="center">图片底色：</td>
      <td><input name="f10" type="text" value="<%=Replace(Sdcms_Jpeg_t10,"&H","#")%>" class="input" />　<span>如：#000000　为空时不去除水印图底色</span></td>
    </tr>
	<tr class="tdbg">
      <td align="center">坐标起点：</td>
      <td><select name="f11" size="1">
	  <option value="0" <%=IIF(Sdcms_Jpeg_t11=0,"selected","")%>>左上</option>
	  <option value="1" <%=IIF(Sdcms_Jpeg_t11=1,"selected","")%>>左下</option>
	  <option value="2" <%=IIF(Sdcms_Jpeg_t11=2,"selected","")%>>居中</option>
	  <option value="3" <%=IIF(Sdcms_Jpeg_t11=3,"selected","")%>>右上</option>
	  <option value="4" <%=IIF(Sdcms_Jpeg_t11=4,"selected","")%>>右下</option>
	  </select></td>
    </tr>
	<tr class="tdbg">
      <td align="center">坐标位置：</td>
      <td>X轴：<input name="f12_0" type="text" class="input" onKeypress="if(event.keyCode<45||event.keyCode>57)event.returnValue=false;" value="<%=Sdcms_Jpeg_t12(0)%>" maxlength="5" />　Y轴：<input name="f12_1" type="text" value="<%=Sdcms_Jpeg_t12(1)%>" class="input" onKeypress="if(event.keyCode<45||event.keyCode>57)event.returnValue=false;" maxlength="5" />　<span>只能是数字</span></td>
    </tr>
	</table>
	<table width="98%" border="0" align="center" cellpadding="3" cellspacing="1">
    <tr class="tdbg">
      <td>　　　　　　　　　　　 <input name="Submit" type="submit" class="bnt" value="保存设置"></td>
    </tr>
	</table>
	</form>
<%
	Rs.Close
	Set Rs=Nothing
End Sub

Sub Save
	Dim t0,t1,t2,t3,t4,t5,t6,t7,t8,t9,t10,t11,t12,t13,t14,t15,t16,t17,t18,t19,t20,t21,t22,t23,t24,t25,t26
	Dim f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12_0,f12_1,f13,f14,f15
	Dim c0,c1,c2,c3,c4,c5,c6,c7
	Dim Old_DataFile,Old_DataName
	t0=FilterText(Trim(Request.Form("t0")),1)
	t1=FilterText(Trim(Request.Form("t1")),0)
	t3=Trim(Request.Form("t3"))'文件后缀
	t4=FilterHtml(Trim(Request.Form("t4")))'关键字
	t5=FilterHtml(Trim(Request.Form("t5")))'描述
	t6=FilterText(Trim(Request.Form("t6")),1)
	t7=FilterText(Trim(Request.Form("t7")),1)
	t8=FilterText(Trim(Request.Form("t8")),1)
	t9=FilterText(Trim(Request.Form("t9")),0)'过滤开始
	t10=FilterText(Trim(Request.Form("t10")),0)
	t11=FilterText(Trim(Request.Form("t11")),0)'过滤结束
	t12=FilterText(Trim(Request.Form("t12")),1)
	t14=FilterText(Trim(Request.Form("t14")),0)'上传目录
	t15=FilterText(Trim(Request.Form("t15")),1)
	t16=FilterText(Trim(Request.Form("t16")),0)
	t17=FilterText(Trim(Request.Form("t17")),0)'生成目录
	t18=FilterText(Trim(Request.Form("t18")),0)
	t19=FilterText(Trim(Request.Form("t19")),0)'文件类型
	t20=IsNum(Trim(Request.Form("t20")),200)
	t21=Replace(Trim(Request.Form("t21"))," ","")
	t22=IsNum(Trim(Request.Form("t22")),200)
	t23=FilterText(Trim(Request.Form("t23")),1)
	t24=IsNum(Trim(Request.Form("t24")),60)
	t25=IsNum(Trim(Request.Form("t25")),0)
	t26=FilterText(Trim(Request.Form("t26")),0)'文件类型
	
	f0=FilterText(Trim(Request.Form("f0")),1)
	f1=FilterText(Trim(Request.Form("f1")),1)
	f2=IsNum(Trim(Request.Form("f2")),100)
	f3=FilterText(Trim(Request.Form("f3")),0)'水印文字
	f4=FilterText(Trim(Request.Form("f4")),1)
	f5=IsNum(Trim(Request.Form("f5")),12)
	f6=FilterText(Trim(Request.Form("f6")),1)
	f7=FilterText(Trim(Request.Form("f7")),1)
	f8=FilterText(Trim(Request.Form("f8")),0)
	f9=FilterText(Trim(Request.Form("f9")),1)
	f10=FilterText(Trim(Request.Form("f10")),1)
	f11=FilterText(Trim(Request.Form("f11")),1)
	f12_0=IsNum(Trim(Request.Form("f12_0")),0)
	f12_1=IsNum(Trim(Request.Form("f12_1")),0)
	f13=IsNum(Trim(Request.Form("f13")),150)
	f14=IsNum(Trim(Request.Form("f14")),113)
	f15=FilterText(Trim(Request.Form("f15")),1)
	f6=Replace(f6,"#","&H")
	IF Len(f10)>1 Then f10=Replace(f10,"#","&H") Else f10=""
	
	If t17<>"" And Right(t17,"1")<>"/" Then t17=t17&"/"
	t17=re(t17,".","")
	Select case Lcase(t3)
		Case ".asp",".htm",".html",".shtml"
		Case Else:t3=".html"
	End Select
	
	Select Case t13
		Case "0","1"
		Case Else:t13=0
	End Select
	
	IF t23=0 Then t3=".asp" Else IF t23=2 And t3=".asp" Then t3=".html"
	if t23=1 then t3=".html"

	t9=check_event(t9,"|",""):t10=check_event(t10,"|",""):t11=check_event(t11,"|",""):t19=check_event(t19,"|",3)
	Dim badfilename,I
	badfilename=Split("asp|aspx|jsp|asa|html|htm|js|vbs|exe|cer|cdx|htw|ida|idq|shtm|shtml|stm|printer|cgi|php|php4|cfm|ashx","|")
	For I=0 To Ubound(badfilename)
		t19=Replace(t19,badfilename(I),"")
	Next
	IF Right(t19,1)="|" Then t19=Left(t19,Len(t19)-1)
	t19=Replace(t19,".","")
	Dim Rs,Sql
	Set Rs=server.CreateObject("Adodb.RecordSet")
	Sql="Select WebName,WebUrl,WebKey,WebDec From "&Sd_Table&" Where Id=1"
	Rs.Open Sql,Conn,1,3
	Rs.Update
		Rs(0)=left(t0,255)
		Rs(1)=left(t1,255)
		Rs(2)=left(t4,255)
		Rs(3)=left(t5,255)
	Rs.Update
	Rs.Close
	Set Rs=Nothing
	'保存网站设置
	
	ReName_Folder "../"&Sdcms_Upfiledir,"../"&t14'重命名附件目录
	Dim Change_Mode
	Change_Mode=False
	IF Sdcms_Mode<2 Then
		IF t23=2 Then
			Change_Mode=True
		End IF
	End IF
	IF Sdcms_Mode=2 Then
		IF t23<2 Then
			Change_Mode=True
		End IF
	End IF
	
	if t23=1 then
		'生成httpd.ini
		dim httpd
		httpd=""
		httpd=httpd&"[ISAPI_Rewrite]"&vbcrlf&vbcrlf

		httpd=httpd&"# 3600 = 1 hour"&vbcrlf
		httpd=httpd&"#CacheClockRate 3600"&vbcrlf&vbcrlf
		
		httpd=httpd&"RepeatLimit 32"&vbcrlf&vbcrlf
		
		httpd=httpd&"#重写单页"&vbcrlf
		httpd=httpd&"RewriteRule "&Sdcms_Root&"Page/(.*)_(\d*)\.html "&Sdcms_Root&"page/\?id=$1&page=$2 [N,I]"&vbcrlf
		httpd=httpd&"RewriteRule "&Sdcms_Root&"Page/(.*)\.html "&Sdcms_Root&"page/\?id=$1 [N,I]"&vbcrlf&vbcrlf
		
		httpd=httpd&"#重写专题"&vbcrlf
		httpd=httpd&"RewriteRule "&Sdcms_Root&"Topic/List_(.*)_(\d*)\.html "&Sdcms_Root&"Topic/\List.asp\?ID=$1&Page=$2 [N,I]"&vbcrlf
		httpd=httpd&"RewriteRule "&Sdcms_Root&"Topic/List_(.*)\.html "&Sdcms_Root&"Topic/\List.asp\?ID=$1 [N,I]"&vbcrlf
		httpd=httpd&"RewriteRule "&Sdcms_Root&"Topic/Index_(.*)\.html "&Sdcms_Root&"Topic/\?page=$1 [N,I]"&vbcrlf
		httpd=httpd&"RewriteRule "&Sdcms_Root&"Topic/Index\.html "&Sdcms_Root&"Topic/\index.asp [N,I]"&vbcrlf&vbcrlf
		
		httpd=httpd&"#重写Tags"&vbcrlf
		httpd=httpd&"RewriteRule "&Sdcms_Root&"tags/List_(.*)\.html "&Sdcms_Root&"tags/\List.asp\?page=$1 [N,I]"&vbcrlf
		httpd=httpd&"RewriteRule "&Sdcms_Root&"tags/List\.html(.*) "&Sdcms_Root&"tags/\list.asp [N,I]"&vbcrlf&vbcrlf
		
		httpd=httpd&"RewriteRule "&Sdcms_Root&"tags/(.*)_(\d*)\.html "&Sdcms_Root&"tags/\?/$1/$2 [N,I]"&vbcrlf
		httpd=httpd&"RewriteRule "&Sdcms_Root&"tags/(.*)\.html "&Sdcms_Root&"tags/\?/$1/ [N,I]"&vbcrlf&vbcrlf
		
		httpd=httpd&"#重写index.asp"&vbcrlf
		httpd=httpd&"RewriteRule "&Sdcms_Root&"index\.html(.*) "&Sdcms_Root&"index.asp [N,I]"&vbcrlf&vbcrlf
		httpd=httpd&"#重写博客"&vbcrlf
		httpd=httpd&"RewriteRule "&Sdcms_Root&"index_(\d*)\.html "&Sdcms_Root&"index.asp\?page=$1 [N,I]"&vbcrlf&vbcrlf
		
		httpd=httpd&"#重写sitemap.asp"&vbcrlf
		httpd=httpd&"RewriteRule "&Sdcms_Root&"sitemap\.html(.*) "&Sdcms_Root&"sitemap.asp [N,I]"&vbcrlf&vbcrlf
		
		httpd=httpd&"#重写内容"&vbcrlf
		httpd=httpd&"RewriteRule "&Sdcms_Root&"html/(.*)/(\d*)_(\d*)\.html "&Sdcms_Root&"Info/\View.asp\?ID=$2&page=$3 [N,I]"&vbcrlf
		httpd=httpd&"RewriteRule "&Sdcms_Root&"html/(.*)/(\d*)\.html "&Sdcms_Root&"Info/\View.asp\?ID=$2 [N,I]"&vbcrlf&vbcrlf
		
		httpd=httpd&"#重写列表"&vbcrlf
		httpd=httpd&"RewriteRule "&Sdcms_Root&"html/(.*)/(\d*) "&Sdcms_Root&"Info/\?cname=$1&page=$2 [N,I]"&vbcrlf
		httpd=httpd&"RewriteRule "&Sdcms_Root&"html/(.*)/ "&Sdcms_Root&"Info/\?cname=$1 [N,I]"&vbcrlf&vbcrlf
		
		httpd=httpd&"#重写内容"&vbcrlf
		httpd=httpd&"RewriteRule "&Sdcms_Root&"date-(.*)_(\d*) "&Sdcms_Root&"date.asp\?c=$1&page=$2 [N,I]"&vbcrlf
		httpd=httpd&"RewriteRule "&Sdcms_Root&"date-(.*) "&Sdcms_Root&"date.asp\?c=$1 [N,I]"
		Savefile "/","httpd.ini",httpd
	else
		'删除httpd.ini和httpd.parse.errors
		Del_File "/httpd.ini"
		Del_File "/httpd.parse.errors"
	end if
	
	Dim Config
	Config=""
	Config=Config&"<"
	Config=Config&"%"& vbcrlf
	Config=Config&"'网站名称"& vbcrlf
	Config=Config&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_WebName:Sdcms_WebName="""&t0&""""&vbcrlf
	Config=Config&"'网站域名"& vbcrlf
	Config=Config&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_WebUrl:Sdcms_WebUrl="""&t1&""""&vbcrlf
	Config=Config&"'系统目录，根目录为：""/"",虚拟目录形式为：""/sdcms/"""& vbcrlf
	Config=Config&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_Root:Sdcms_Root="""&Sdcms_Root&""""&vbcrlf
	Config=Config&"'运行模式,0为动态默认，1为伪静态，2为静态"& vbcrlf
	Config=Config&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_Mode:Sdcms_Mode="&t23&""&vbcrlf
	Config=Config&"'博客模式"& vbcrlf
	Config=Config&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim blogmode:blogmode="&t26&""&vbcrlf
	Config=Config&"'生成目录，根目录为空,也可以指定为某一目录，形式为：""sdcms/"",必须以：""/""结束"& vbcrlf
	Config=Config&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_HtmDir:Sdcms_HtmDir="""&t17&""""&vbcrlf
	Config=Config&"'时区设置,请不要随意更改"& vbcrlf
	Config=Config&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_TimeZone:Sdcms_TimeZone="&t25&vbcrlf
	Config=Config&"'是否开启管理日志"& vbcrlf
	Config=Config&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_AdminLog:Sdcms_AdminLog="&t18&vbcrlf
	Config=Config&"'是否开启缓存"& vbcrlf
	Config=Config&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_Cache:Sdcms_Cache="&t6&vbcrlf
	Config=Config&"'缓存前缀,如果有多个站点，请设置不同的值"& vbcrlf
	Config=Config&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_Cookies:Sdcms_Cookies="""&t12&""""&vbcrlf
	Config=Config&"'缓存时间，单位为秒"& vbcrlf
	Config=Config&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_CacheDate:Sdcms_CacheDate="&t24&""&vbcrlf
	Config=Config&"'系统文件的后缀名，建议不要改动"& vbcrlf
	Config=Config&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_FileTxt:Sdcms_FileTxt="""&t3&""""&vbcrlf
	Config=Config&"'系统模板目录,一般不建议手动更改"& vbcrlf
	Config=Config&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_Skins_Root:Sdcms_Skins_Root="""&Sdcms_Skins_Root&""""&vbcrlf
	Config=Config&"'系统生成文件的默认文件名，建议不要改动"& vbcrlf
	Config=Config&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_FileName:Sdcms_FileName="""&t16&""""&vbcrlf
	Config=Config&"'附件目录"& vbcrlf
	Config=Config&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_UpfileDir:Sdcms_UpfileDir="""&t14&""""&vbcrlf
	Config=Config&"'允许上传文件类型,多个请用|格开"& vbcrlf
	Config=Config&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_UpfileType:Sdcms_UpfileType="""&t19&""""&vbcrlf
	Config=Config&"'允许上传的文件最大值，单位：KB"& vbcrlf
	Config=Config&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_upfileMaxSize:Sdcms_upfileMaxSize="&t20&vbcrlf
	Config=Config&"'生成偏好设置,系统自动生成，请务随意改动"& vbcrlf
	Config=Config&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_Create_Set:Sdcms_Create_Set="""&Re(t15,"&nbsp;"," ")&""""&vbcrlf
	Config=Config&"'生成GOOGLE地图的参数"& vbcrlf
	Config=Config&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_Create_GoogleMap:Sdcms_Create_GoogleMap=Split("""&t21&""","","")"&vbcrlf
	Config=Config&"'评论开关"& vbcrlf
	Config=Config&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_Comment_Pass:Sdcms_Comment_Pass="&t7&vbcrlf
	Config=Config&"'评论审核"& vbcrlf
	Config=Config&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_Comment_IsPass:Sdcms_Comment_IsPass="&t8&vbcrlf
	Config=Config&"'Html标签过滤"& vbcrlf
	Config=Config&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_BadHtml:Sdcms_BadHtml="""&t9&""""&vbcrlf
	Config=Config&"'Html标签事件过滤"& vbcrlf
	Config=Config&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_BadEvent:Sdcms_BadEvent="""&t10&""""&vbcrlf
	Config=Config&"'脏话过滤"& vbcrlf
	Config=Config&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_BadText:Sdcms_BadText="""&t11&""""&vbcrlf
	Config=Config&"'信息描述自动截取字符数,建议为：200-500"& vbcrlf
	Config=Config&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_Length:Sdcms_Length="&t22&vbcrlf
	Config=Config&"'数据库连接类型,True为Access，False为MSSQL"& vbcrlf
	Config=Config&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_DataType:Sdcms_DataType="&Sdcms_DataType&vbcrlf
	Config=Config&"'Access数据库目录"& vbcrlf
	Config=Config&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_DataFile:Sdcms_DataFile="""&Sdcms_DataFile&""""&vbcrlf
	Config=Config&"'Access数据库名称"& vbcrlf
	Config=Config&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_DataName:Sdcms_DataName="""&Sdcms_DataName&""""&vbcrlf
	Config=Config&"'MSSQL数据库IP,本地用 (local) 外地用IP "& vbcrlf
	Config=Config&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_SqlHost:Sdcms_SqlHost="""&Sdcms_SqlHost&""""&vbcrlf
	Config=Config&"'MSSQL数据库名"& vbcrlf
	Config=Config&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_SqlData:Sdcms_SqlData="""&Sdcms_SqlData&""""&vbcrlf
	Config=Config&"'MSSQL数据库帐户"& vbcrlf
	Config=Config&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_SqlUser:Sdcms_SqlUser="""&Sdcms_SqlUser&""""&vbcrlf
	Config=Config&"'MSSQL数据库密码"& vbcrlf
	Config=Config&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_SqlPass:Sdcms_SqlPass="""&Sdcms_SqlPass&""""&vbcrlf
	Config=Config&"'系统安装日期"& vbcrlf
	Config=Config&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_CreateDate:Sdcms_CreateDate="""&Sdcms_CreateDate&""""&vbcrlf
	Config=Config&"%"
	Config=Config&">"&vbcrlf
	Config=Config&"<!--#include file=""../Skins/"&Sdcms_Skins_Root&"/Skins.asp""-->"
	Savefile "../Inc/","Const.asp",Config
	
	'保存水印配置文件
	Dim Jpeg
	Jpeg=""
	Jpeg=Jpeg&"<"
	Jpeg=Jpeg&"%"& vbcrlf
	Jpeg=Jpeg&"'水印开关"& vbcrlf
	Jpeg=Jpeg&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_Jpeg_t0:Sdcms_Jpeg_t0="&f0&vbcrlf
	Jpeg=Jpeg&"'水印类型，文字为真，图片为假"& vbcrlf
	Jpeg=Jpeg&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_Jpeg_t1:Sdcms_Jpeg_t1="&f1&vbcrlf
	Jpeg=Jpeg&"'水印质量"& vbcrlf
	Jpeg=Jpeg&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_Jpeg_t2:Sdcms_Jpeg_t2="""&f2&""""&vbcrlf
	Jpeg=Jpeg&"'水印文字"& vbcrlf
	Jpeg=Jpeg&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_Jpeg_t3:Sdcms_Jpeg_t3="""&f3&""""&vbcrlf
	Jpeg=Jpeg&"'水印文字字体"& vbcrlf
	Jpeg=Jpeg&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_Jpeg_t4:Sdcms_Jpeg_t4="""&f4&""""&vbcrlf
	Jpeg=Jpeg&"'水印文字字体大小"& vbcrlf
	Jpeg=Jpeg&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_Jpeg_t5:Sdcms_Jpeg_t5="""&f5&""""&vbcrlf
	Jpeg=Jpeg&"'水印文字颜色"& vbcrlf
	Jpeg=Jpeg&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_Jpeg_t6:Sdcms_Jpeg_t6="""&f6&""""&vbcrlf
	Jpeg=Jpeg&"'水印文字是否加粗"& vbcrlf
	Jpeg=Jpeg&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_Jpeg_t7:Sdcms_Jpeg_t7="&f7&vbcrlf
	Jpeg=Jpeg&"'水印图片路径"& vbcrlf
	Jpeg=Jpeg&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_Jpeg_t8:Sdcms_Jpeg_t8="""&f8&""""&vbcrlf
	Jpeg=Jpeg&"'水印透明度"& vbcrlf
	Jpeg=Jpeg&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_Jpeg_t9:Sdcms_Jpeg_t9="""&f9&""""&vbcrlf
	Jpeg=Jpeg&"'水印图片底色"& vbcrlf
	Jpeg=Jpeg&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_Jpeg_t10:Sdcms_Jpeg_t10="""&f10&""""&vbcrlf
	Jpeg=Jpeg&"'水印坐标起点位置"& vbcrlf
	Jpeg=Jpeg&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_Jpeg_t11:Sdcms_Jpeg_t11="&f11&vbcrlf
	Jpeg=Jpeg&"'水印坐标位置,X Y轴以|格开"& vbcrlf
	Jpeg=Jpeg&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_Jpeg_t12:Sdcms_Jpeg_t12=Split("""&f12_0&"|"&f12_1&""",""|"")"&vbcrlf
	Jpeg=Jpeg&"'缩略图宽度"& vbcrlf
	Jpeg=Jpeg&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_Jpeg_t13:Sdcms_Jpeg_t13="""&IsNum(f13,0)&""""&vbcrlf
	Jpeg=Jpeg&"'缩略图高度"& vbcrlf
	Jpeg=Jpeg&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_Jpeg_t14:Sdcms_Jpeg_t14="""&IsNum(f14,0)&""""&vbcrlf
	Jpeg=Jpeg&"'缩略图算法"& vbcrlf
	Jpeg=Jpeg&""&CHR(32)&CHR(32)&CHR(32)&CHR(32)&"Dim Sdcms_Jpeg_t15:Sdcms_Jpeg_t15="""&f15&""""&vbcrlf
	Jpeg=Jpeg&"%"
	Jpeg=Jpeg&">"
	Savefile "../Inc/","AspJpeg.asp",Jpeg
	
	AddLog sdcms_adminname,GetIp,"修改系统设置",0
	
	IF Not(t6) Then Application.Contents.RemoveAll()
	
	
	
	IF Change_Mode Then
		IF t23=2 Then
			Alert "系统设置保存成功！\n\n由于模式改变，系统将刷新当前页面。\n\n并且您需要重新生成相关页面才能正常使用前台功能！！！","./"
		Else
			Alert "系统设置保存成功！\n\n由于模式改变，系统将刷新当前页面。","./"
		End IF
	Else
		Alert "系统设置保存成功！","?"
	End IF
End Sub

Function Check_Add
	Check_Add="	<script>"&vbcrlf
	Check_Add=Check_Add&"	function checkadd()"&vbcrlf
	Check_Add=Check_Add&"	{"&vbcrlf
	Check_Add=Check_Add&"	if (document.add.t0.value=='')"&vbcrlf
	Check_Add=Check_Add&"	{"&vbcrlf
	Check_Add=Check_Add&"	alert('网站名称不能为空');"&vbcrlf
	Check_Add=Check_Add&"	document.add.t0.focus;"&vbcrlf
	Check_Add=Check_Add&"	return false"&vbcrlf
	Check_Add=Check_Add&"	}"&vbcrlf
	Check_Add=Check_Add&"	if (document.add.t1.value=='')"&vbcrlf
	Check_Add=Check_Add&"	{"&vbcrlf
	Check_Add=Check_Add&"	alert('网站域名不能为空');"&vbcrlf
	Check_Add=Check_Add&"	document.add.t1.focus;"&vbcrlf
	Check_Add=Check_Add&"	return false"&vbcrlf
	Check_Add=Check_Add&"	}"&vbcrlf
	Check_Add=Check_Add&"	if (document.add.t3.value=='')"&vbcrlf
	Check_Add=Check_Add&"	{"&vbcrlf
	Check_Add=Check_Add&"	alert('请选择文件后缀');"&vbcrlf
	Check_Add=Check_Add&"	document.add.t3.focus;"&vbcrlf
	Check_Add=Check_Add&"	return false"&vbcrlf
	Check_Add=Check_Add&"	}"&vbcrlf
	Check_Add=Check_Add&"	}"&vbcrlf
	Check_Add=Check_Add&"	</script>"&vbcrlf
End Function
%>  
</div>
</body>
</html>