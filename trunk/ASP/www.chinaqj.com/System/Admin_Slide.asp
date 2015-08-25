<!--#include file="../Include/Const.asp" -->
<!--#include file="../Include/ConnSiteData.asp" -->
<!--#include file="Admin_htmlconfig.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="Images/Admin_style.css">
<%
if Instr(session("AdminPurview"),"|44,")=0 then
  response.write ("<br /><br /><div align=""center""><font style=""color:red; font-size:9pt; "")>您没有管理该模块的权限！</font></div>")
  response.end
end if
%>
<br />
<%  
Set objXML = Server.CreateObject("Msxml2.DOMDocument")
objXML.async = False
loadResult = objXML.load(Server.MapPath("../Scripts/Slide.xml"))

if not loadResult then
 Response.write "装载XML文件错误"
 Response.end
end If  
Set objNodes = objXML.getElementsByTagName("data/config")
%>

<table class="tableBorder" width="95%" border="0" align="center" cellpadding="5" cellspacing="1">
  <form name="editForm" method="post" action="Admin_Slide.asp?Action=SaveEdit">
    <tr>
      <th height="22" colspan="2" sytle="line-height:150%">【Flash幻灯片参数设置】</th>
    </tr>
    <tr>
      <td width="200" class="forumRow">图片圆角弧度：</td>
      <td class="forumRowHighlight"><input name="roundCorner" id="roundCorner" type="text" value="<% = objNodes(0).selectSingleNode("roundCorner").Text %>" style="width: 120px">
        <font color="red">*</font></td>
    </tr>
    <tr>
      <td class="forumRow">图片切换时间/秒：</td>
      <td class="forumRowHighlight"><input name="autoPlayTime" id="autoPlayTime" type="text" value="<% = objNodes(0).selectSingleNode("autoPlayTime").Text %>" style="width: 120px">
        <font color="red">*</font></td>
    </tr>
    <tr>
      <td class="forumRow">图片高质量显示：</td>
      <td class="forumRowHighlight"><select style="width: 120" name="isHeightQuality">
          <option value="true" <% if objNodes(0).selectSingleNode("isHeightQuality").Text="true" then %>selected<%end if%>>是</option>
          <option value="false" <% if objNodes(0).selectSingleNode("isHeightQuality").Text="false" then %>selected<%end if%>>否</option>
        </select>
        <font color="red">*</font></td>
    </tr>
    <tr>
      <td class="forumRow">融合模式：</td>
      <td class="forumRowHighlight"><select style="width: 120" name="blendMode">
          <option value="normal" <% if objNodes(0).selectSingleNode("blendMode").Text="normal" then %>selected<%end if%>>正常</option>
        </select>
        <font color="red">*</font></td>
    </tr>
    <tr>
      <td class="forumRow">图片切换时间/秒：</td>
      <td class="forumRowHighlight"><input name="transDuration" id="transDuration" type="text" value="<% = objNodes(0).selectSingleNode("transDuration").Text %>" style="width: 120px">
        <font color="red">*</font></td>
    </tr>
    <tr>
      <td class="forumRow">连接打开方式：</td>
      <td class="forumRowHighlight"><select style="width: 120" name="windowOpen">
          <option value="_self" <% if objNodes(0).selectSingleNode("windowOpen").Text="_self" then %>selected<%end if%>>本窗口</option>
          <option value="_blank" <% if objNodes(0).selectSingleNode("windowOpen").Text="_blank" then %>selected<%end if%>>新窗口</option>
        </select>
        <font color="red">*</font></td>
    </tr>
    <tr>
      <td class="forumRow">按钮位置：</td>
      <td class="forumRowHighlight"><select style="width: 120" name="btnSetMargin">
          <option value="auto 5 5 auto" <% if objNodes(0).selectSingleNode("btnSetMargin").Text="auto 5 5 auto" then %>selected<%end if%>>默认</option>
          <option value="auto 10 10 auto" <% if objNodes(0).selectSingleNode("btnSetMargin").Text="uto 10 10 auto" then %>selected<%end if%>>右下角对齐</option>
        </select>
        <font color="red">*</font></td>
    </tr>
    <tr>
      <td class="forumRow">按钮距离：</td>
      <td class="forumRowHighlight"><input name="btnDistance" id="btnDistance" type="text" value="<% = objNodes(0).selectSingleNode("btnDistance").Text %>" style="width: 120px">
        <font color="red">*</font></td>
    </tr>
    <tr>
      <td class="forumRow">标题背景颜色：</td>
      <td class="forumRowHighlight"><input name="titleBgColor" id="titleBgColor" type="text" value="<% = objNodes(0).selectSingleNode("titleBgColor").Text %>" style="width: 120px">
        <font color="red">*</font></td>
    </tr>
    <tr>
      <td class="forumRow">标题文字颜色：</td>
      <td class="forumRowHighlight"><input name="titleTextColor" id="titleTextColor" type="text" value="<% = objNodes(0).selectSingleNode("titleTextColor").Text %>" style="width: 120px">
        <font color="red">*</font></td>
    </tr>
    <tr>
      <td class="forumRow">标题背景透明度：</td>
      <td class="forumRowHighlight"><input name="titleBgAlpha" id="titleBgAlpha" type="text" value="<% = objNodes(0).selectSingleNode("titleBgAlpha").Text %>" style="width: 120px">
        <font color="red">*</font></td>
    </tr>
    <tr>
      <td class="forumRow">背景动画时间：</td>
      <td class="forumRowHighlight"><input name="titleMoveDuration" id="titleMoveDuration" type="text" value="<% = objNodes(0).selectSingleNode("titleMoveDuration").Text %>" style="width: 120px">
        <font color="red">*</font></td>
    </tr>
    <tr>
      <td class="forumRow">按钮透明度：</td>
      <td class="forumRowHighlight"><input name="btnAlpha" id="btnAlpha" type="text" value="<% = objNodes(0).selectSingleNode("btnAlpha").Text %>" style="width: 120px">
        <font color="red">*</font></td>
    </tr>
    <tr>
      <td class="forumRow">按钮文字颜色：</td>
      <td class="forumRowHighlight"><input name="btnTextColor" id="btnTextColor" type="text" value="<% = objNodes(0).selectSingleNode("btnTextColor").Text %>" style="width: 120px">
        <font color="red">*</font></td>
    </tr>
    <tr>
      <td class="forumRow">按钮默认颜色：</td>
      <td class="forumRowHighlight"><input name="btnDefaultColor" id="btnDefaultColor" type="text" value="<% = objNodes(0).selectSingleNode("btnDefaultColor").Text %>" style="width: 120px">
        <font color="red">*</font></td>
    </tr>
    <tr>
      <td class="forumRow">按钮激活颜色：</td>
      <td class="forumRowHighlight"><input name="btnHoverColor" id="btnHoverColor" type="text" value="<% = objNodes(0).selectSingleNode("btnHoverColor").Text %>" style="width: 120px">
        <font color="red">*</font></td>
    </tr>
    <tr>
      <td class="forumRow">按钮当前颜色：</td>
      <td class="forumRowHighlight"><input name="btnFocusColor" id="btnFocusColor" type="text" value="<% = objNodes(0).selectSingleNode("btnFocusColor").Text %>" style="width: 120px">
        <font color="red">*</font></td>
    </tr>
    <tr>
      <td class="forumRow">切换图片的方法：</td>
      <td class="forumRowHighlight"><select style="width: 120" name="changImageMode">
          <option value="click" <% if objNodes(0).selectSingleNode("changImageMode").Text="click" then %>selected<%end if%>>点击切换</option>
          <option value="hover" <% if objNodes(0).selectSingleNode("changImageMode").Text="hover" then %>selected<%end if%>>悬停切换</option>
        </select>
        <font color="red">*</font></td>
    </tr>
    <tr>
      <td class="forumRow">是否显示按钮：</td>
      <td class="forumRowHighlight"><select style="width: 120" name="isShowBtn">
          <option value="true" <% if objNodes(0).selectSingleNode("isShowBtn").Text="true" then %>selected<%end if%>>显示</option>
          <option value="false" <% if objNodes(0).selectSingleNode("isShowBtn").Text="false" then %>selected<%end if%>>不显示</option>
        </select>
        <font color="red">*</font></td>
    </tr>
    <tr>
      <td class="forumRow">是否显示标题：</td>
      <td class="forumRowHighlight"><select style="width: 120" name="isShowTitle">
          <option value="true" <% if objNodes(0).selectSingleNode("isShowTitle").Text="true" then %>selected<%end if%>>显示</option>
          <option value="false" <% if objNodes(0).selectSingleNode("isShowTitle").Text="false" then %>selected<%end if%>>不显示</option>
        </select>
        <font color="red">*</font></td>
    </tr>
    <tr>
      <td class="forumRow">图片缩放模式：</td>
      <td class="forumRowHighlight"><select style="width: 180" name="scaleMode">
          <option value="noBorder" <% if objNodes(0).selectSingleNode("scaleMode").Text="noBorder" then %>selected<%end if%>>自动等比例缩放(默认)</option>
          <option value="showAll" <% if objNodes(0).selectSingleNode("scaleMode").Text="showAll" then %>selected<%end if%>>全部显示(多余的裁剪)</option>
          <option value="exactFil" <% if objNodes(0).selectSingleNode("scaleMode").Text="exactFil" then %>selected<%end if%>>缩放到合适尺寸(非等比例)</option>
          <option value="noScale" <% if objNodes(0).selectSingleNode("scaleMode").Text="noScale" then %>selected<%end if%>>无缩放原始尺寸</option>
        </select>
        <font color="red">*</font></td>
    </tr>
    <tr>
      <td class="forumRow">图片缩放特效：</td>
      <td class="forumRowHighlight"><select style="width: 180" name="transform">
          <option value="blur" <% if objNodes(0).selectSingleNode("transform").Text="blur" then %>selected<%end if%>>模糊特效、淡入淡出(默认)</option>
          <option value="alpha" <% if objNodes(0).selectSingleNode("transform").Text="alpha" then %>selected<%end if%>>透明度、淡入淡出</option>
          <option value="left" <% if objNodes(0).selectSingleNode("transform").Text="left" then %>selected<%end if%>>左方图片滚动</option>
          <option value="right" <% if objNodes(0).selectSingleNode("transform").Text="right" then %>selected<%end if%>>右方图片滚动</option>
          <option value="top" <% if objNodes(0).selectSingleNode("transform").Text="top" then %>selected<%end if%>>上方图片滚动</option>
          <option value="bottom" <% if objNodes(0).selectSingleNode("transform").Text="bottom" then %>selected<%end if%>>下方图片滚动</option>
          <option value="breathe" <% if objNodes(0).selectSingleNode("transform").Text="breathe" then %>selected<%end if%>>缩放、淡入淡出</option>
          <option value="breatheBlur" <% if objNodes(0).selectSingleNode("transform").Text="breatheBlur" then %>selected<%end if%>>模糊、缩放、淡入淡出</option>
        </select>
        <font color="red">*</font></td>
    </tr>
    <tr>
      <td class="forumRow">是否显示关于：</td>
      <td class="forumRowHighlight"><select style="width: 120" name="isShowAbout">
          <option value="true" <% if objNodes(0).selectSingleNode("isShowAbout").Text="true" then %>selected<%end if%>>显示</option>
          <option value="false" <% if objNodes(0).selectSingleNode("isShowAbout").Text="false" then %>selected<%end if%>>不显示</option>
        </select>
        <font color="red">* 本参数强制显示</font></td>
    </tr>
    <tr>
      <td class="forumRow">标题文字字体：</td>
      <td class="forumRowHighlight"><input name="titleFont" id="titleFont" type="text" value="<% = objNodes(0).selectSingleNode("titleFont").Text %>" style="width: 120px">
        <font color="red">*</font></td>
    </tr>
    <tr>
      <td class="forumRow"></td>
      <td class="forumRowHighlight"><input name="submitSaveEdit" type="submit" id="submitSaveEdit" value="修改参数并发布XML">
        <input type="button" value="返回上一页" onclick="history.back(-1)"></td>
    </tr>
  </form>
</table>
<%
Set objNodes = Nothing  
Set objXML = Nothing  
%>
<br />
<%
if Trim(Request.QueryString("Action"))="SaveEdit" then
vDir = "../Scripts/" '制作SiteMap的目录,相对目录(相对于根目录而言)

set objfso = CreateObject("Scripting.FileSystemObject")
root = Server.MapPath(vDir)

str = "<?xml version='1.0' encoding='UTF-8'?>" & vbcrlf
str = str & "<data>" & vbcrlf
str = str & " <channel>" & vbcrlf
sql="select * from ChinaQJ_Flash where ShowType='Slide'"
set rs=server.createobject("adodb.recordset")
rs.open sql,conn,1,1
if rs.eof and rs.bof then
Response.Write("")
else
while(not rs.eof)
str = str & "     <item>" & vbcrlf
str = str & "         <link>"&rs("flashlink")&"</link>" & vbcrlf
str = str & "         <image>"&rs("flashpic")&"</image>" & vbcrlf
str = str & "         <title>"&rs("flashtext")&"</title>" & vbcrlf
str = str & "     </item>" & vbcrlf
rs.movenext
wend
end if
rs.close
set rs=nothing
str = str & " </channel>" & vbcrlf
str = str & "  <config>" & vbcrlf
str = str & "      <roundCorner>"&Trim(Request.Form("roundCorner"))&"</roundCorner>" & vbcrlf
str = str & "      <autoPlayTime>"&Trim(Request.Form("autoPlayTime"))&"</autoPlayTime>" & vbcrlf
str = str & "      <isHeightQuality>"&Trim(Request.Form("isHeightQuality"))&"</isHeightQuality>" & vbcrlf
str = str & "      <blendMode>"&Trim(Request.Form("blendMode"))&"</blendMode>" & vbcrlf
str = str & "      <transDuration>"&Trim(Request.Form("transDuration"))&"</transDuration>" & vbcrlf
str = str & "      <windowOpen>"&Trim(Request.Form("windowOpen"))&"</windowOpen>" & vbcrlf
str = str & "      <btnSetMargin>"&Trim(Request.Form("btnSetMargin"))&"</btnSetMargin>" & vbcrlf
str = str & "      <btnDistance>"&Trim(Request.Form("btnDistance"))&"</btnDistance>" & vbcrlf
str = str & "      <titleBgColor>"&Trim(Request.Form("titleBgColor"))&"</titleBgColor>" & vbcrlf
str = str & "      <titleTextColor>"&Trim(Request.Form("titleTextColor"))&"</titleTextColor>" & vbcrlf
str = str & "      <titleBgAlpha>"&Trim(Request.Form("titleBgAlpha"))&"</titleBgAlpha>" & vbcrlf
str = str & "      <titleMoveDuration>"&Trim(Request.Form("titleMoveDuration"))&"</titleMoveDuration>" & vbcrlf
str = str & "      <btnAlpha>"&Trim(Request.Form("btnAlpha"))&"</btnAlpha>" & vbcrlf
str = str & "      <btnTextColor>"&Trim(Request.Form("btnTextColor"))&"</btnTextColor>" & vbcrlf
str = str & "      <btnDefaultColor>"&Trim(Request.Form("btnDefaultColor"))&"</btnDefaultColor>" & vbcrlf
str = str & "      <btnHoverColor>"&Trim(Request.Form("btnHoverColor"))&"</btnHoverColor>" & vbcrlf
str = str & "      <btnFocusColor>"&Trim(Request.Form("btnFocusColor"))&"</btnFocusColor>" & vbcrlf
str = str & "      <changImageMode>"&Trim(Request.Form("changImageMode"))&"</changImageMode>" & vbcrlf
str = str & "      <isShowBtn>"&Trim(Request.Form("isShowBtn"))&"</isShowBtn>" & vbcrlf
str = str & "      <isShowTitle>"&Trim(Request.Form("isShowTitle"))&"</isShowTitle>" & vbcrlf
str = str & "      <scaleMode>"&Trim(Request.Form("scaleMode"))&"</scaleMode>" & vbcrlf
str = str & "      <transform>"&Trim(Request.Form("transform"))&"</transform>" & vbcrlf
str = str & "      <isShowAbout>"&Trim(Request.Form("isShowAbout"))&"</isShowAbout>" & vbcrlf
str = str & "      <titleFont>"&Trim(Request.Form("titleFont"))&"</titleFont>" & vbcrlf
str = str & "  </config>" & vbcrlf
str = str & " </data>" & vbcrlf
set fso = nothing

Set objStream = Server.CreateObject("ADODB.Stream")
With objStream
'.Type = adTypeText
'.Mode = adModeReadWrite
.Open
.Charset = "utf-8"
.Position = objStream.Size
.WriteText=str
.SaveToFile server.mappath("/Scripts/Slide.xml"),2 '生成的XML文件名
.Close
End With

vDir = "../Scripts/" '制作SiteMap的目录,相对目录(相对于根目录而言)

set objfso = CreateObject("Scripting.FileSystemObject")
root = Server.MapPath(vDir)

str = "<?xml version='1.0' encoding='gb2312'?>" & vbcrlf
str = str & "<imgList>" & vbcrlf
str = str & "  <pic>" & vbcrlf
sql="select * from ChinaQJ_Flash where ShowType='Rotation'"
set rs=server.createobject("adodb.recordset")
rs.open sql,conn,1,1
if rs.eof and rs.bof then
Response.Write("")
else
while(not rs.eof)
str = str & "    <list path="""&rs("FlashPic")&""" smallpath="""&rs("FlashSmallPic")&""" smallinfo="""&rs("FlashText")&""">"&rs("FlashLink")&"</list>" & vbcrlf
rs.movenext
wend
end if
rs.close
set rs=nothing
str = str & "  </pic>" & vbcrlf
str = str & "  <rollTime fade_in=""10"">4</rollTime>" & vbcrlf
str = str & "  <text font=""黑体"" size=""12"" bold=""true"" color=""0xFF0000""></text>" & vbcrlf
str = str & "</imgList>" & vbcrlf
set fso = nothing

Set objStream = Server.CreateObject("ADODB.Stream")
With objStream
'.Type = adTypeText
'.Mode = adModeReadWrite
.Open
.Charset = "utf-8"
.Position = objStream.Size
.WriteText=str
.SaveToFile server.mappath("/Scripts/imgList.xml"),2 '生成的XML文件名
.Close
End With
response.write "<script language='javascript'>alert('Flash无限图片展示模块发布成功！');location.replace('Admin_Slide.asp');</script>"
end if
%>