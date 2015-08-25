<!--#include file="../Include/Const.asp" -->
<!--#include file="../Include/ConnSiteData.asp" -->
<!--#include file="Admin_htmlconfig.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="Images/Admin_style.css">
<script language="javascript" src="../Scripts/Admin.js"></script>
<%
if Instr(session("AdminPurview"),"|45,")=0 then
  response.write ("<br /><br /><div align=""center""><font style=""color:red; font-size:9pt; "")>您没有管理该模块的权限！</font></div>")
  response.end
end if
%>
<script language="javascript">
<!--
function showUploadDialog(s_Type, s_Link, s_Thumbnail){
    var arr = showModalDialog("eWebEditor/dialog/i_upload.htm?style=coolblue&type="+s_Type+"&link="+s_Link+"&thumbnail="+s_Thumbnail, window, "dialogWidth: 0px; dialogHeight: 0px; help: no; scroll: no; status: no");
}
//-->
</script>
<br />
<%
ShowType=Request("ShowType")
If Trim(Request.QueryString("Result"))="Modify" Then
sql="select * from ChinaQJ_Flash where id="&Request("id")
set rs=server.createobject("adodb.recordset")
rs.open sql,conn,1,1
id=Request("id")
flashpic=rs("flashpic")
FlashSmallPic=rs("FlashSmallPic")
flashlink=rs("flashlink")
flashtext=rs("flashtext")
rs.close
set rs=nothing
end if

If Trim(Request.QueryString("Action"))="SaveEdit" Then
set rs=server.createobject("adodb.recordset")
if Request("id")<>"" then
sql="select * from ChinaQJ_Flash where id="&Request("id")
rs.open sql,conn,1,3
else
sql="select * from ChinaQJ_Flash"
rs.open sql,conn,1,3
rs.addnew
end if
rs("flashpic")=Request("flashpic")
rs("FlashSmallPic")=Request("FlashSmallPic")
rs("flashlink")=Request("flashlink")
rs("flashtext")=Request("flashtext")
rs("ShowType")=ShowType
rs("AddTime")=now()
rs.update
rs.close
set rs=nothing

if ShowType="Colorful" then
sql="select * from ChinaQJ_Flash where id=22"
set rs=server.createobject("adodb.recordset")
rs.open sql,conn,1,3
rs("displayTime")=Request("displayTime")
rs("slideshowWidth")=Request("slideshowWidth")
rs("slideshowHeight")=Request("slideshowHeight")
rs("bgColor")=Request("bgColor")
rs("loaderColor")=Request("loaderColor")
rs("music")=Request("music")
rs("musicVolume")=Request("musicVolume")
rs.update
rs.close
set rs=nothing

vDir = "../Scripts/" '制作SiteMap的目录,相对目录(相对于根目录而言)

set objfso = CreateObject("Scripting.FileSystemObject")
root = Server.MapPath(vDir)

str = "<?xml version='1.0' encoding='UTF-8'?>" & vbcrlf
str = str & "	<slideshow  displayTime="""&Request("displayTime")&"""" & vbcrlf
str = str & "				transitionSpeed="".7""" & vbcrlf
str = str & "				transitionType=""Fade""" & vbcrlf
str = str & "				motionType=""None""" & vbcrlf
str = str & "				motionEasing=""easeInOut""" & vbcrlf
str = str & "				randomize=""false""" & vbcrlf
str = str & "				slideshowWidth="""&Request("slideshowWidth")&"""" & vbcrlf
str = str & "				slideshowHeight="""&Request("slideshowHeight")&"""" & vbcrlf
str = str & "				slideshowX=""center""" & vbcrlf
str = str & "				slideshowY=""0""" & vbcrlf
str = str & "				bgColor="""&Request("bgColor")&"""" & vbcrlf
str = str & "				bgOpacity=""100""" & vbcrlf
str = str & "				useHtml=""true""" & vbcrlf
str = str & "				showHideCaption=""false""" & vbcrlf
str = str & "				captionBg=""000000""" & vbcrlf
str = str & "				captionBgOpacity=""0""" & vbcrlf
str = str & "				captionTextSize=""11""" & vbcrlf
str = str & "				captionTextColor=""FFFFFF""" & vbcrlf
str = str & "				captionBold=""false""" & vbcrlf
str = str & "				captionPadding=""7""" & vbcrlf
str = str & "				showNav=""false""" & vbcrlf
str = str & "				autoHideNav=""false""" & vbcrlf
str = str & "				navHiddenOpacity=""40""" & vbcrlf
str = str & "				navX=""335""" & vbcrlf
str = str & "				navY=""193""" & vbcrlf
str = str & "				btnColor=""FFFFFF""" & vbcrlf
str = str & "				btnHoverColor=""FFCC00""" & vbcrlf
str = str & "				btnShadowOpacity=""85""" & vbcrlf
str = str & "				btnGradientOpacity=""20""" & vbcrlf
str = str & "				btnScale=""120""" & vbcrlf
str = str & "				btnSpace=""7""" & vbcrlf
str = str & "				navBgColor=""333333""" & vbcrlf
str = str & "				navBgAlpha=""0""" & vbcrlf
str = str & "				navCornerRadius=""0""" & vbcrlf
str = str & "				navBorderWidth=""1""" & vbcrlf
str = str & "				navBorderColor=""FFFFFF""" & vbcrlf
str = str & "				navBorderAlpha=""0""" & vbcrlf
str = str & "				navPadding=""8""" & vbcrlf
str = str & "				tooltipSize=""8""" & vbcrlf
str = str & "				tooltipColor=""000000""" & vbcrlf
str = str & "				tooltipBold=""true""" & vbcrlf
str = str & "				tooltipFill=""FFFFFF""" & vbcrlf
str = str & "				tooltipStrokeColor=""000000""" & vbcrlf
str = str & "				tooltipFillAlpha=""80""" & vbcrlf
str = str & "				tooltipStroke=""0""" & vbcrlf
str = str & "				tooltipStrokeAlpha=""0""" & vbcrlf
str = str & "				tooltipCornerRadius=""8""" & vbcrlf
str = str & "				loaderWidth=""200""" & vbcrlf
str = str & "				loaderHeight=""1""" & vbcrlf
str = str & "				loaderColor="""&Request("loaderColor")&"""" & vbcrlf
str = str & "				loaderOpacity=""100"" " & vbcrlf
				
str = str & "				attachCaptionToImage=""true""" & vbcrlf
str = str & "				cropImages=""false""" & vbcrlf
str = str & "				slideshowMargin=""0""" & vbcrlf
str = str & "				showMusicButton=""false""" & vbcrlf
str = str & "				music=""../"&Request("music")&"""" & vbcrlf
str = str & "				musicVolume="""&Request("musicVolume")&"""" & vbcrlf
str = str & "				musicMuted=""false""" & vbcrlf
str = str & "				musicLoop=""true""" & vbcrlf
str = str & "				watermark=""""" & vbcrlf
str = str & "				watermarkX=""625""" & vbcrlf
str = str & "				watermarkY=""30""" & vbcrlf
str = str & "				watermarkOpacity=""100""" & vbcrlf
str = str & "				watermarkLink=""""" & vbcrlf
str = str & "				watermarkLinkTarget=""_blank""" & vbcrlf
str = str & "				captionsY=""bottom""" & vbcrlf
str = str & "				>" & vbcrlf
sql="select * from ChinaQJ_Flash where ShowType='colorful'"
set rs=server.createobject("adodb.recordset")
rs.open sql,conn,1,1
if rs.eof and rs.bof then
Response.Write("")
else
while(not rs.eof)
if SysRootDir<>"/" then
str = str & "		<image img="""&SysRootDir&rs("FlashPic")&""" customtitle="""&rs("flashtext")&""" />" & vbcrlf
else
str = str & "		<image img="""&rs("FlashPic")&""" customtitle="""&rs("flashtext")&""" />" & vbcrlf
end if
rs.movenext
wend
end if
rs.close
set rs=nothing
str = str & "	</slideshow>" & vbcrlf
set fso = nothing

Set objStream = Server.CreateObject("ADODB.Stream")
With objStream
'.Type = adTypeText
'.Mode = adModeReadWrite
.Open
.Charset = "utf-8"
.Position = objStream.Size
.WriteText=str
.SaveToFile server.mappath("/Scripts/slideshow.xml"),2 '生成的XML文件名
.Close
End With
response.write "<script language='javascript'>alert('Colorful-Flash无限图片展示模块发布成功！');location.replace('Admin_SlideEdit.asp?ShowType=Colorful');</script>"
end if

if ShowType="imagerotator" then
vDir = ""&SysRootDir&"Scripts/" '制作SiteMap的目录,相对目录(相对于根目录而言)

set objfso = CreateObject("Scripting.FileSystemObject")
root = Server.MapPath(vDir)

str = "<?xml version=""1.0"" encoding=""utf-8""?>" & vbcrlf
str = str & "<playlist version=""1"" xmlns=""http://www.chinaqj.com"">" & vbcrlf
str = str & "	<trackList>" & vbcrlf
sql="select * from ChinaQJ_Flash where ShowType='imagerotator'"
set rs=server.createobject("adodb.recordset")
rs.open sql,conn,1,1
if rs.eof and rs.bof then
Response.Write("")
else
while(not rs.eof)
str = str & "		<track>" & vbcrlf
str = str & "			<title>"&rs("flashtext")&"</title>" & vbcrlf
str = str & "			<creator>ChinaQJ CMS V5</creator>" & vbcrlf
if SysRootDir<>"/" then
str = str & "			<location>"&SysRootDir&rs("FlashPic")&"</location>" & vbcrlf
else
str = str & "			<location>"&rs("FlashPic")&"</location>" & vbcrlf
end if
str = str & "			<info>"&rs("flashlink")&"</info>" & vbcrlf
str = str & "		</track>" & vbcrlf
rs.movenext
wend
end if
rs.close
set rs=nothing
str = str & "	</trackList>" & vbcrlf
str = str & "</playlist>" & vbcrlf
set fso = nothing

Set objStream = Server.CreateObject("ADODB.Stream")
With objStream
'.Type = adTypeText
'.Mode = adModeReadWrite
.Open
.Charset = "utf-8"
.Position = objStream.Size
.WriteText=str
.SaveToFile server.mappath(""&SysRootDir&"Scripts/imagerotator.xml"),2 '生成的XML文件名
.Close
End With
response.write "<script language='javascript'>alert('ChinaQJ炫丽Flash无限图片展示模块发布成功！');location.replace('Admin_SlideEdit.asp?ShowType=imagerotator');</script>"
end if

end if
%>
<% If Trim(Request.QueryString("Result"))="Add" or Trim(Request.QueryString("Result"))="Modify" Then %>
<table class="tableBorder" width="95%" border="0" align="center" cellpadding="5" cellspacing="1">
  <form name="EditSlide" method="post" action="Admin_SlideEdit.asp?Action=SaveEdit&Result=Add&ShowType=<%= ShowType %>&ID=<%= id %>">
    <tr>
      <th height="22" colspan="2" sytle="line-height:150%">【添加Flash幻灯片】</th>
    </tr>
<%
if ShowType="Colorful" then
sql="select * from ChinaQJ_Flash where id=22"
set rs=server.createobject("adodb.recordset")
rs.open sql,conn,1,1
displayTime=rs("displayTime")
slideshowWidth=rs("slideshowWidth")
slideshowHeight=rs("slideshowHeight")
bgColor=rs("bgColor")
loaderColor=rs("loaderColor")
music=rs("music")
musicVolume=rs("musicVolume")
rs.close
set rs=nothing
%>
    <tr>
      <td class="forumRow">轮换时间（/秒）：</td>
      <td class="forumRowHighlight"><input name="displayTime" type="text" id="displayTime" style="width: 350" value="<%= displayTime %>"> 默认值：5</td>
    </tr>
    <tr>
      <td class="forumRow">FLASH显示宽度：</td>
      <td class="forumRowHighlight"><input name="slideshowWidth" type="text" id="slideshowWidth" style="width: 350" value="<%= slideshowWidth %>"> 默认值：1003</td>
    </tr>
    <tr>
      <td class="forumRow">FLASH显示高度：</td>
      <td class="forumRowHighlight"><input name="slideshowHeight" type="text" id="slideshowHeight" style="width: 350" value="<%= slideshowHeight %>"> 默认值：280</td>
    </tr>
    <tr>
      <td class="forumRow">FLASH背景颜色：</td>
      <td class="forumRowHighlight"><input name="bgColor" type="text" id="bgColor" style="width: 350" value="<%= bgColor %>"> 默认值：FFFFFF</td>
    </tr>
    <tr>
      <td class="forumRow">加载条颜色：</td>
      <td class="forumRowHighlight"><input name="loaderColor" type="text" id="loaderColor" style="width: 350" value="<%= loaderColor %>"> 默认值：FF0000</td>
    </tr>
    <tr>
      <td class="forumRow">MP3音乐地址：</td>
      <td class="forumRowHighlight"><input name="music" type="text" id="music" style="width: 350" value="<%= music %>"><input type="button" value="上传音乐" onclick="showUploadDialog('media', 'EditSlide.music', '')"></td>
    </tr>
    <tr>
      <td class="forumRow">默认背景音乐音量：</td>
      <td class="forumRowHighlight"><input name="musicVolume" type="text" id="musicVolume" style="width: 350" value="<%= musicVolume %>"> 默认值：50</td>
    </tr>
    <% end if %>
    <tr>
      <td width="200" class="forumRow">大图地址：</td>
      <td class="forumRowHighlight"><input name="FlashPic" type="text" id="FlashPic" style="width: 350" value="<%= FlashPic %>">
        <input type="button" value="上传图片" onclick="showUploadDialog('image', 'EditSlide.FlashPic', '')">
        <font color="red">*</font></td>
    </tr>
    <tr>
      <td width="200" class="forumRow">小图地址：</td>
      <td class="forumRowHighlight"><input name="FlashSmallPic" type="text" id="FlashSmallPic" style="width: 350" value="<%= FlashSmallPic %>">
        <input type="button" value="上传图片" onclick="showUploadDialog('image', 'EditSlide.FlashSmallPic', '')">
        <font color="red">*</font></td>
    </tr>
    <tr>
      <td class="forumRow">链接地址：</td>
      <td class="forumRowHighlight"><input name="FlashLink" type="text" id="FlashLink" style="width: 350" value="<%= FlashLink %>">
        <font color="red">*</font></td>
    </tr>
    <tr>
      <td class="forumRow">文字说明：</td>
      <td class="forumRowHighlight"><input name="FlashText" type="text" id="FlashText" style="width: 350" value="<%= FlashText %>">
        <font color="red">*</font></td>
    </tr>
    <tr>
      <td class="forumRow"></td>
      <td class="forumRowHighlight"><input name="submitSaveEdit" type="submit" id="submitSaveEdit" value="保存设置">
        <input type="button" value="返回上一页" onclick="history.back(-1)"></td>
    </tr>
  </form>
</table>
<br />
<% End If %>
<table class="tableBorder" width="95%" border="0" align="center" cellpadding="5" cellspacing="1">
  <form action="DelContent.Asp?Result=Flash" method="post" name="formDel">
    <tr>
      <th width="8">ID</th>
      <th width="200" align="left">大图地址</th>
      <th width="200" align="left">链接地址</th>
      <th align="left">文字说明</th>
      <th width="120" align="left">创建时间</th>
      <th width="60" align="center">操作</th>
      <th width="28">选择</th>
    </tr>
<% flashList() %>
  </form>
</table>
<%
function flashList()
  dim idCount
  dim pages
      pages=20
  dim pagec
  dim page
      page=clng(request("Page"))
  dim pagenc
      pagenc=2
  dim pagenmax
  dim pagenmin
  dim datafrom
      datafrom="ChinaQJ_flash"
  dim sqlid
  dim Myself,PATH_INFO,QUERY_STRING
      PATH_INFO = request.servervariables("PATH_INFO")
	  QUERY_STRING = request.ServerVariables("QUERY_STRING")'
      if QUERY_STRING = "" or Instr(PATH_INFO & "?" & QUERY_STRING,"Page=")=0 then
	    Myself = PATH_INFO & "?"
	  else
	    Myself = Left(PATH_INFO & "?" & QUERY_STRING,Instr(PATH_INFO & "?" & QUERY_STRING,"Page=")-1)
	  end if
  dim taxis
      taxis="order by id desc"
  dim i
  dim rs,sql
  sql="select count(ID) as idCount from ["& datafrom &"] where ShowType='"&ShowType&"'"
  set rs=server.createobject("adodb.recordset")
  rs.open sql,conn,1,1
  idCount=rs("idCount")
  if(idcount>0) then
    if(idcount mod pages=0)then
	  pagec=int(idcount/pages)
   	else
      pagec=int(idcount/pages)+1
    end if
    sql="select id from ["& datafrom &"] where ShowType='"&ShowType&"'"
    set rs=server.createobject("adodb.recordset")
    rs.open sql,conn,1,1
	if not rs.bof or not rs.eof then
    rs.pagesize = pages
    if page < 1 then page = 1
    if page > pagec then page = pagec
    if pagec > 0 then rs.absolutepage = page  
    for i=1 to rs.pagesize
	  if rs.eof then exit for  
	  if(i=1)then
	    sqlid=rs("id")
	  else
	    sqlid=sqlid &","&rs("id")
	  end if
	  rs.movenext
    next
	end if
  end if
  if(idcount>0 and sqlid<>"") then
    sql="select * from ["& datafrom &"] where ShowType='"&ShowType&"'"
    set rs=server.createobject("adodb.recordset")
    rs.open sql,conn,1,1
    while(not rs.eof)
%>
<tr>
<td nowrap class="leftrow"><%= rs("id") %></td>
<td nowrap class="leftrow" onclick="showDetail(0)" style="cursor: hand"><%= rs("flashpic") %></td>
<td nowrap class="leftrow"><%= rs("flashlink") %></td>
<td nowrap class="leftrow"><%= rs("flashtext") %></td>
<td nowrap class="leftrow"><%= rs("addtime") %></td>
<td nowrap class="centerrow"><a href='?Result=Add&ShowType=<%= ShowType %>'>添加</a> <a href='?Result=Modify&ShowType=<%= ShowType %>&ID=<%= rs("id") %>'>修改</a></td>
<td nowrap class="leftrow"><% If rs.recordcount>1 Then %><input name='selectID' type='checkbox' value='<%= rs("id") %>'><% End If %></td>
</tr>
<%
rs.movenext
wend
%>
<tr>
<td colspan='7' nowrap class="forumRow" align="right"><input onClick="CheckAll(this.form)" name="buttonAllSelect" type="button" id="submitAllSearch" value="全选"> <input onClick="CheckOthers(this.form)" name="buttonOtherSelect" type="button" id="submitOtherSelect" value="反选"> <input name='batch' type='submit' value='删除所选' onClick="return test();"></td>
</tr>
<%
  else
    response.write "<tr><td nowrap align='center' colspan='7' class=""forumRow"">暂无产品信息!<a href='?Result=Add&ShowType="& ShowType &"'>点击添加</a></td></tr>"
  end if
  Response.Write "<tr>" & vbCrLf
  Response.Write "<td colspan='7' nowrap class=""forumRow"">" & vbCrLf
  Response.Write "<table width='100%' border='0' align='center' cellpadding='0' cellspacing='0'>" & vbCrLf
  Response.Write "<tr>" & vbCrLf
  Response.Write "<td class=""forumRow"">共计：<font color='red'>"&idcount&"</font>条记录 页次：<font color='red'>"&page&"</font></strong>/"&pagec&" 每页：<font color='red'>"&pages&"</font>条</td>" & vbCrLf
  Response.Write "<td align='right'>" & vbCrLf
  pagenmin=page-pagenc
  pagenmax=page+pagenc
  if(pagenmin<1) then pagenmin=1
  if(page>1) then response.write ("<a href='"& myself &"Page=1'><font style='font-size: 14px; font-family: Webdings'>9</font></a> ")
  if(pagenmin>1) then response.write ("<a href='"& myself &"Page="& page-(pagenc*2+1) &"'><font style='font-size: 14px; font-family: Webdings'>7</font></a> ")
  if(pagenmax>pagec) then pagenmax=pagec
  for i = pagenmin to pagenmax
	if(i=page) then
	  response.write (" <font color='red'>"& i &"</font> ")
	else
	  response.write ("[<a href="& myself &"Page="& i &">"& i &"</a>]")
	end if
  next
  if(pagenmax<pagec) then response.write (" <a href='"& myself &"Page="& page+(pagenc*2+1) &"'><font style='font-size: 14px; font-family: Webdings'>8</font></a> ")
  if(page<pagec) then response.write ("<a href='"& myself &"Page="& pagec &"'><font style='font-size: 14px; font-family: Webdings'>:</font></a> ")
  Response.Write "第<input name='SkipPage' onKeyDown='if(event.keyCode==13)event.returnValue=false' onchange=""if(/\D/.test(this.value)){alert('请输入需要跳转到的页数并且必须为整数！');this.value='"&Page&"';}"" style='width: 28px;' type='text' value='"&Page&"'>页" & vbCrLf
  Response.Write "<input name='submitSkip' type='button' onClick='GoPage("""&Myself&""")' value='转到'>" & vbCrLf
  Response.Write "</td>" & vbCrLf
  Response.Write "</tr>" & vbCrLf
  Response.Write "</table>" & vbCrLf
  rs.close
  set rs=nothing
  Response.Write "</td>" & vbCrLf
  Response.Write "</tr>" & vbCrLf
end Function
%>
<center><font color="#CC0000">* 默认必须保留一条数据</font></center>

<script language="javascript">
<!--
function showDetail(n)
{
    var o = document.getElementById("detail_"+n);
    o.style.display = o.style.display?"":"none";
}
//-->
</script>