﻿<!--#include file="../Include/Const.asp" -->
<!--#include file="../Include/ConnSiteData.asp" -->
<!--#include file="Admin_htmlconfig.asp"-->
<link rel="stylesheet" href="Images/Admin_style.css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%
if Instr(session("AdminPurview"),"|34,")=0 then
  response.write ("<br /><br /><div align=""center""><font style=""color:red; font-size:9pt; "")>您没有管理该模块的权限！</font></div>")
  response.end
end if
if ISHTML = 0 then
  response.Write "<script language='javascript'>alert('请先在【系统参数配置】中将静态HTML设置为开启！');history.go(-1);</script>"
  response.End
end If
%>
<br />
<table class="tableBorder" width="95%" border="0" align="center" cellpadding="5" cellspacing="1">
  <tr>
    <th height="22" colspan="2" sytle="line-height:150%">【按需生成静态页面】</th>
  </tr>
  <tr>
    <td width="25%" align="right" class="forumrow"><a href="Admin_HtmlSort.Asp" target="CreFrame1">生成产品分类页面</a></td>
    <td width="75%" class="forumRowHighlight"><iframe style="width: 100%; height: 28" name="CreFrame1" id="CreFrame1" marginwidth="0" marginheight="20" frameborder="0" noresize scrolling="No"></iframe></td>
  </tr>
  <tr>
    <td align="right" class="forumrow"><a href="Admin_HtmlPro.Asp" target="CreFrame2">生成所有产品详细页面</a></td>
    <td class="forumRowHighlight"><iframe style="width: 100%; height: 28" name="CreFrame2" id="CreFrame2" marginwidth="0" marginheight="0" frameborder="0" noresize scrolling="No"></iframe></td>
  </tr>
  <tr>
    <td align="right" class="forumrow"><a href="Admin_HtmlNewSort.Asp" target="CreFrame3">生成新闻分类页面</a></td>
    <td class="forumRowHighlight"><iframe style="width: 100%; height: 28" name="CreFrame3" id="CreFrame3" marginwidth="0" marginheight="0" frameborder="0" noresize scrolling="No"></iframe></td>
  </tr>
  <tr>
    <td align="right" class="forumrow"><a href="Admin_HtmlNews.Asp" target="CreFrame4">生成新闻详细页面</a></td>
    <td class="forumRowHighlight"><iframe style="width: 100%; height: 28" name="CreFrame4" id="CreFrame4" marginwidth="0" marginheight="0" frameborder="0" noresize scrolling="No"></iframe></td>
  </tr>
  <tr>
    <td align="right" class="forumrow"><a href="Admin_HtmlInfo.Asp" target="CreFrame5">生成企业信息列表</a></td>
    <td class="forumRowHighlight"><iframe style="width: 100%; height: 28" name="CreFrame5" id="CreFrame5" marginwidth="0" marginheight="0" frameborder="0" noresize scrolling="No"></iframe></td>
  </tr>
  <tr>
    <td align="right" class="forumrow"><a href="Admin_HtmlDownSort.Asp" target="CreFrame6">生成下载分类页面</a></td>
    <td class="forumRowHighlight"><iframe style="width: 100%; height: 28" name="CreFrame6" id="CreFrame6" marginwidth="0" marginheight="0" frameborder="0" noresize scrolling="No"></iframe></td>
  </tr>
  <tr>
    <td align="right" class="forumrow"><a href="Admin_HtmlDown.Asp" target="CreFrame7">生成下载详细页面</a></td>
    <td class="forumRowHighlight"><iframe style="width: 100%; height: 28" name="CreFrame7" id="CreFrame7" marginwidth="0" marginheight="0" frameborder="0" noresize scrolling="No"></iframe></td>
  </tr>
  <tr>
    <td align="right" class="forumrow"><a href="Admin_HtmlJobSort.Asp" target="CreFrame8">生成人才招聘列表</a></td>
    <td class="forumRowHighlight"><iframe style="width: 100%; height: 28" name="CreFrame8" id="CreFrame8" marginwidth="0" marginheight="0" frameborder="0" noresize scrolling="No"></iframe></td>
  </tr>
  <tr>
    <td align="right" class="forumrow"><a href="Admin_HtmlJob.Asp" target="CreFrame9">生成人才招聘详细页面</a></td>
    <td class="forumRowHighlight"><iframe style="width: 100%; height: 28" name="CreFrame9" id="CreFrame9" marginwidth="0" marginheight="0" frameborder="0" noresize scrolling="No"></iframe></td>
  </tr>
  <tr>
    <td align="right" class="forumrow"><a href="Admin_HtmlOtherSort.Asp" target="CreFrame10">生成其他信息分类页面</a></td>
    <td class="forumRowHighlight"><iframe style="width: 100%; height: 28" name="CreFrame10" id="CreFrame10" marginwidth="0" marginheight="0" frameborder="0" noresize scrolling="No"></iframe></td>
  </tr>
  <tr>
    <td align="right" class="forumrow"><a href="Admin_HtmlOther.Asp" target="CreFrame11">生成其他信息详细页面</a></td>
    <td class="forumRowHighlight"><iframe style="width: 100%; height: 28" name="CreFrame11" id="CreFrame11" marginwidth="0" marginheight="0" frameborder="0" noresize scrolling="No"></iframe></td>
  </tr>
  <tr>
    <td align="right" class="forumrow"><a href="Admin_HtmlKeySort.Asp" target="CreFrame13">生成服务范围分类页面</a></td>
    <td class="forumRowHighlight"><iframe style="width: 100%; height: 28" name="CreFrame13" id="CreFrame13" marginwidth="0" marginheight="0" frameborder="0" noresize scrolling="No"></iframe></td>
  </tr>
  <tr>
    <td align="right" class="forumrow"><a href="Admin_HtmlKey.Asp" target="CreFrame14">生成服务范围详细页面</a></td>
    <td class="forumRowHighlight"><iframe style="width: 100%; height: 28" name="CreFrame14" id="CreFrame14" marginwidth="0" marginheight="0" frameborder="0" noresize scrolling="No"></iframe></td>
  </tr>
  <tr>
    <td align="right" class="forumrow"><a href="Admin_htmlImagesort.asp" target="CreFrame15">生成图片案例分类页面</a></td>
    <td class="forumRowHighlight"><iframe style="width: 100%; height: 28" name="CreFrame15" id="CreFrame15" marginwidth="0" marginheight="0" frameborder="0" noresize scrolling="No"></iframe></td>
  </tr>
  <tr>
    <td align="right" class="forumrow"><a href="Admin_htmlImage.asp" target="CreFrame16">生成图片案例详细页面</a></td>
    <td class="forumRowHighlight"><iframe style="width: 100%; height: 28" name="CreFrame16" id="CreFrame16" marginwidth="0" marginheight="0" frameborder="0" noresize scrolling="No"></iframe></td>
  </tr>
  <tr>
    <td align="right" class="forumrow"><a href="Admin_htmlVideosort.asp" target="CreFrame17">生成视频分类页面</a></td>
    <td class="forumRowHighlight"><iframe style="width: 100%; height: 28" name="CreFrame17" id="CreFrame17" marginwidth="0" marginheight="0" frameborder="0" noresize scrolling="No"></iframe></td>
  </tr>
  <tr>
    <td align="right" class="forumrow"><a href="Admin_htmlMagazinesort.asp" target="CreFrame18">生成电子杂志分类页面</a></td>
    <td class="forumRowHighlight"><iframe style="width: 100%; height: 28" name="CreFrame18" id="CreFrame18" marginwidth="0" marginheight="0" frameborder="0" noresize scrolling="No"></iframe></td>
  </tr>
  <tr>
    <td align="right" class="forumrow"><a href="Admin_HtmlIndex.Asp" target="CreFrame12">生成首页|报价|其他页面</a></td>
    <td class="forumRowHighlight"><iframe style="width: 100%; height: 28" name="CreFrame12" id="CreFrame12" marginwidth="0" marginheight="0" frameborder="0" noresize scrolling="No"></iframe></td>
  </tr>
</table>
<br />