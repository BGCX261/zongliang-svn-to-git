<!--#include file="../Include/Const.asp" -->
<!--#include file="../E-zine/xml/siteContent.asp" -->
<!--#include file="../Include/ConnSiteData.asp" -->
<!--#include file="CheckAdmin.asp"-->
<div id="colorpanel" style="position: absolute; left: 0; top: 0; z-index: 2;"></div>
<script>
var ColorHex=new Array('00','33','66','99','CC','FF')
var SpColorHex=new Array('FF0000','00FF00','0000FF','FFFF00','00FFFF','FF00FF')
var current=null
function intocolor(dddd,ssss,ffff)
{
    var colorTable=''
    for (i=0;i<2;i++)
    {
        for (j=0;j<6;j++)
        {
            colorTable=colorTable+'<tr height="12">'
            colorTable=colorTable+'<td width="11" style="background-color: #000000;">'
            if (i==0){
                colorTable=colorTable+'<td width="11" style="background-color: #'+ColorHex[j]+ColorHex[j]+ColorHex[j]+'">'}
            else{
                colorTable=colorTable+'<td width="11" style="background-color: #'+SpColorHex[j]+'">'}
            colorTable=colorTable+'<td width="11" style="background-color: #000000;">'
            for (k=0;k<3;k++)
            {
                for (l=0;l<6;l++)
                {
                    colorTable=colorTable+'<td width="11" style="background-color: #'+ColorHex[k+i*3]+ColorHex[l]+ColorHex[j]+';">'
                }
            }
        }
    }
    colorTable='<table width="253" border="0" cellspacing="0" cellpadding="0" style="border: 1px #000000 solid; border-bottom: none; border-collapse: collapse;" bordercolor="000000">'
    +'<tr height="30"><td colspan="21" bgcolor="#cccccc">'
    +'<table cellpadding="0" cellspacing="1" border="0" style="border-collapse: collapse;">'
    +'<tr><td width="3"><td><input type="text" name="DisColor" size="6" disabled style="border: solid 1px #000000; background-color: #ffff00;"></td>'
    +'<td width="3"><td><input type="text" name="HexColor" size="7" style="border: inset 1px; font-family: Arial;" value="#000000">&nbsp;&nbsp;&nbsp;&nbsp;<a href="http://www.qianbo.com.cn" target="_blank">系统选色版</a></td></tr></table></td></table>'
    +'<table border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse;" bordercolor="000000" onmouseover="doOver()" onmouseout="doOut()" onclick="doclick(\''+dddd+'\',\''+ssss+'\',\''+ffff+'\')" style="cursor: hand;">'
    +colorTable+'</table>';
    colorpanel.innerHTML=colorTable
}
function doOver() {
    if ((event.srcElement.tagName=="TD") && (current!=event.srcElement)) {
        if (current!=null){
            current.style.backgroundColor = current._background}
        event.srcElement._background = event.srcElement.style.backgroundColor
        DisColor.style.backgroundColor = event.srcElement.style.backgroundColor
        HexColor.value = event.srcElement.style.backgroundColor
        event.srcElement.style.backgroundColor = "white"
        current = event.srcElement
    }
}
function doOut() {
    if (current!=null) current.style.backgroundColor = current._background
}
function doclick(dddd,ssss,ffff){
    if (event.srcElement.tagName=="TD"){
        eval(dddd+"."+ssss).value=event.srcElement._background
        eval(ffff).style.color=event.srcElement._background
        colorxs.style.backgroundColor=event.srcElement._background
        return event.srcElement._background
    }
}
var colorxs
function colorcd(dddd,ssss,ffff){
    colorxs=window.event.srcElement
    var rightedge = document.body.clientWidth-event.clientX;
    var bottomedge = document.body.clientHeight-event.clientY;
    if (rightedge < colorpanel.offsetWidth)
    colorpanel.style.left = document.body.scrollLeft + event.clientX - colorpanel.offsetWidth;
    else
    colorpanel.style.left = document.body.scrollLeft + event.clientX;
    if (bottomedge < colorpanel.offsetHeight)
    colorpanel.style.top = document.body.scrollTop + event.clientY - colorpanel.offsetHeight;
    else
    colorpanel.style.top = document.body.scrollTop + event.clientY;
    colorpanel.style.visibility = "visible";
    window.event.cancelBubble=true
    intocolor(dddd,ssss,ffff)
    return false
}
document.onclick=function(){
    document.getElementById("colorpanel").style.visibility='hidden'
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="Images/Admin_style.css">
<script language="javascript" src="../Scripts/Admin.js"></script>
<script language="javascript">
<!--
function showUploadDialog(s_Type, s_Link, s_Thumbnail){
    var arr = showModalDialog("eWebEditor/dialog/i_upload.htm?style=coolblue&type="+s_Type+"&link="+s_Link+"&thumbnail="+s_Thumbnail, window, "dialogWidth: 0px; dialogHeight: 0px; help: no; scroll: no; status: no");
}
//-->
</script>
<br />
<% 
select case request.QueryString("Action")
  case "Save"
    SaveConstInfo
end select
%>
<body>
<table class="tableBorder" width="95%" border="0" align="center" cellpadding="5" cellspacing="1">
  <form name="editForm" method="post" action="MagazineSetting.asp?Action=Save">
    <tr>
      <th height="28" colspan="2" sytle="line-height: 150%;">【电子杂志参数设置】</th>
    </tr>
    <tr height="28">
      <td width="200" class="forumRow">杂志内容宽度：</td>
      <td class="forumRowHighlight"><input name="PageW" type="text" id="PageW" style="width: 80px;" value="<%= PageW %>"> 像素
        <font color="red">*</font></td>
    </tr>
    <tr height="28">
      <td width="200" class="forumRow">杂志内容高度：</td>
      <td class="forumRowHighlight"><input name="PageH" type="text" id="PageH" style="width: 80px;" value="<%= PageH %>"> 像素
        <font color="red">*</font></td>
    </tr>
    <tr height="28">
      <td width="200" class="forumRow">电子杂志音效开关：</td>
      <td class="forumRowHighlight"><input name="FlipSound" type="checkbox" value="1" <% If FlipSound Then Response.Write("checked")%> ></td>
    </tr>
    <tr height="28">
      <td width="200" class="forumRow">倒序查看杂志内容：</td>
      <td class="forumRowHighlight"><input name="ReverseOrder" type="checkbox" value="1" <% If ReverseOrder Then Response.Write("checked")%> ></td>
    </tr>
    <tr height="28">
      <td width="200" class="forumRow">主体背景色：</td>
      <td class="forumRowHighlight"><input name="BgClr" type="text" id="BgClr" style="width: 80px;" value="<%= BgClr %>">
        <img src="Images/tm.gif"  width="20" height="20"  align="absmiddle" style="background-color: <%= BgClr %>;" onClick="colorcd('editForm','BgClr','BgClrFont')" onMouseOver="this.style.cursor='hand'"> <font id="BgClrFont" color="<%= BgClr %>">文字效果预览</font> <font color="red">* 未开启背景图片时自动启用</font></td>
    </tr>
    <tr height="28">
      <td width="200" class="forumRow">按钮控件主色调：</td>
      <td class="forumRowHighlight"><input name="HStartClr" type="text" id="HStartClr" style="width: 80px;" value="<%= HStartClr %>">
        <img src="Images/tm.gif"  width="20" height="20"  align="absmiddle" style="background-color: <%= HStartClr %>;" onClick="colorcd('editForm','HStartClr','HStartClrFont')" onMouseOver="this.style.cursor='hand'"> <font id="HStartClrFont" color="<%= HStartClr %>">文字效果预览</font> <font color="red">*</font></td>
    </tr>
    <tr height="28">
      <td width="200" class="forumRow">按钮控件主色调透明度：</td>
      <td class="forumRowHighlight"><input name="HStartAlp" type="text" id="HStartAlp" style="width: 80px;" value="<%= HStartAlp %>"> %
        <font color="red">*</font></td>
    </tr>
    <tr height="28">
      <td width="200" class="forumRow">按钮控件次色调：</td>
      <td class="forumRowHighlight"><input name="HEndClr" type="text" id="HEndClr" style="width: 80px;" value="<%= HEndClr %>">
        <img src="Images/tm.gif"  width="20" height="20"  align="absmiddle" style="background-color: <%= HEndClr %>;" onClick="colorcd('editForm','HEndClr','HEndClrFont')" onMouseOver="this.style.cursor='hand'"> <font id="HEndClrFont" color="<%= HEndClr %>">文字效果预览</font> <font color="red">*</font></td>
    </tr>
    <tr height="28">
      <td width="200" class="forumRow">按钮控件次色调透明度：</td>
      <td class="forumRowHighlight"><input name="HEndAlp" type="text" id="HEndAlp" style="width: 80px;" value="<%= HEndAlp %>"> %
        <font color="red">*</font></td>
    </tr>
    <tr height="28">
      <td width="200" class="forumRow">悬浮层背景色：</td>
      <td class="forumRowHighlight"><input name="OverLayClr" type="text" id="OverLayClr" style="width: 80px;" value="<%= OverLayClr %>">
        <img src="Images/tm.gif"  width="20" height="20"  align="absmiddle" style="background-color: <%= OverLayClr %>;" onClick="colorcd('editForm','OverLayClr','OverLayClrFont')" onMouseOver="this.style.cursor='hand'"> <font id="OverLayClrFont" color="<%= OverLayClr %>">文字效果预览</font> <font color="red">*</font></td>
    </tr>
    <tr height="28">
      <td width="200" class="forumRow">悬浮层背景色透明度：</td>
      <td class="forumRowHighlight"><input name="OverLayTrans" type="text" id="OverLayTrans" style="width: 80px;" value="<%= OverLayTrans %>"> %
        <font color="red">*</font></td>
    </tr>
    <tr height="28">
      <td width="200" class="forumRow">背景图片开关：</td>
      <td class="forumRowHighlight"><input name="BgImage" type="checkbox" value="1" <% If BgImage Then Response.Write("checked")%> ></td>
    </tr>
    <tr height="28">
      <td width="200" class="forumRow">背景图片地址：</td>
      <td class="forumRowHighlight"><input name="BgUrl" type="text" id="BgUrl" style="width: 280px;" value="<%= BgUrl %>">
        <input type="button" value="上传图片" onClick="showUploadDialog('image', 'editForm.BgUrl', '')">
        <font color="red">*</font></td>
    </tr>
    <tr height="28">
      <td width="200" class="forumRow">自动播放电子杂志：</td>
      <td class="forumRowHighlight"><input name="AutoPlayer" type="checkbox" value="1" <% If AutoPlayer Then Response.Write("checked")%> /></td>
    </tr>
    <tr height="28">
      <td width="200" class="forumRow">自动播放持续时间：</td>
      <td class="forumRowHighlight"><input name="AutoDur" type="text" id="AutoDur" style="width: 80px;" value="<%= AutoDur %>"> 秒
        <font color="red">*</font></td>
    </tr>
    <tr height="28">
      <td width="200" class="forumRow">Logo图片/动画显示开关：</td>
      <td class="forumRowHighlight"><input name="LogoSetup" type="checkbox" value="1" <% If LogoSetup Then Response.Write("checked")%> /></td>
    </tr>
    <tr height="28">
      <td width="200" class="forumRow">Logo地址：</td>
      <td class="forumRowHighlight"><input name="LogoUrl" type="text" id="LogoUrl" style="width: 280px;" value="<%= LogoUrl %>">
        <input type="button" value="上传图片" onClick="showUploadDialog('image', 'editForm.LogoUrl', '')">
        <br />
        <font color="red">* 支持图片/Flash动画(如设置为图片，请确保为PNG格式，195*100像素。)</font></td>
    </tr>
    <tr height="28">
      <td width="200" class="forumRow">Logo阴影特效：</td>
      <td class="forumRowHighlight"><input name="LogoShade" type="checkbox" value="1" <% If LogoShade Then Response.Write("checked")%> /></td>
    </tr>
    <tr height="28">
      <td width="200" class="forumRow">Logo斜角特效：</td>
      <td class="forumRowHighlight"><input name="LogoBevel" type="checkbox" value="1" <% If LogoBevel Then Response.Write("checked")%> /></td>
    </tr>
    <tr height="28">
      <td width="200" class="forumRow">Logo发光特效：</td>
      <td class="forumRowHighlight"><input name="LogoGlow" type="checkbox" value="1" <% If LogoGlow Then Response.Write("checked")%> /></td>
    </tr>
    <tr height="28">
      <td width="200" class="forumRow">帮助按钮开关：</td>
      <td class="forumRowHighlight"><input name="HelpSetup" type="checkbox" value="1" <% If HelpSetup Then Response.Write("checked")%> /></td>
    </tr>
    <tr height="28">
      <td width="200" class="forumRow">下载按钮开关：</td>
      <td class="forumRowHighlight"><input name="PdfSetup" type="checkbox" value="1" <% If PdfSetup Then Response.Write("checked")%> /></td>
    </tr>
    <tr height="28">
      <td width="200" class="forumRow">放大/缩小按钮开关：</td>
      <td class="forumRowHighlight"><input name="ZoomSetup" type="checkbox" value="1" <% If ZoomSetup Then Response.Write("checked")%> /></td>
    </tr>
    <tr height="28">
      <td width="200" class="forumRow">放大/缩小视图开关：</td>
      <td class="forumRowHighlight"><input name="ExtendedZoom" type="checkbox" value="1" <% If ExtendedZoom Then Response.Write("checked")%> /></td>
    </tr>
    <tr height="28">
      <td width="200" class="forumRow">打印按钮开关：</td>
      <td class="forumRowHighlight"><input name="PrintSetup" type="checkbox" value="1" <% If PrintSetup Then Response.Write("checked")%> /></td>
    </tr>
    <tr height="28">
      <td width="200" class="forumRow">电子杂志列表按钮开关：</td>
      <td class="forumRowHighlight"><input name="ListPages" type="checkbox" value="1" <% If ListPages Then Response.Write("checked")%> /></td>
    </tr>
    <tr height="28">
      <td width="200" class="forumRow">背景音乐开关：</td>
      <td class="forumRowHighlight"><input name="Mp3Setup" type="checkbox" value="1" <% If Mp3Setup Then Response.Write("checked")%> /></td>
    </tr>
    <tr height="28">
      <td width="200" class="forumRow">背景音乐自动播放开关：</td>
      <td class="forumRowHighlight"><input name="AutoStart" type="checkbox" value="1" <% If AutoStart Then Response.Write("checked")%> /></td>
    </tr>
    <tr height="28">
      <td width="200" class="forumRow">背景音乐随机播放开关：</td>
      <td class="forumRowHighlight"><input name="RandomStart" type="checkbox" value="1" <% If RandomStart Then Response.Write("checked")%> /></td>
    </tr>
    <tr height="28">
      <td class="forumRow"></td>
      <td class="forumRowHighlight"><input name="submitSaveEdit" type="submit" id="submitSaveEdit" value="保存设置"></td>
    </tr>
  </form>
</table>
<br />

<%
Function SaveConstInfo()
Set objStream = Server.CreateObject("ADODB.Stream") 
With objStream 
.Open 
.Charset = "utf-8" 
.Position = objStream.Size 
 hf = "<" & "%" & vbcrlf
 hf = hf & "Const pageW= " & chr(34) & trim(request("pageW")) & chr(34) & "" & vbcrlf
 hf = hf & "Const pageH= " & chr(34) & trim(request("pageH")) & chr(34) & "" & vbcrlf
 hf = hf & "Const flipSound= " & trim(request("flipSound")) & "" & vbcrlf
 if request("reverseOrder") then
 hf = hf & "Const reverseOrder= 1" & vbcrlf
 else
 hf = hf & "Const reverseOrder= 0" & vbcrlf
 end if
 hf = hf & "Const bgClr= " & chr(34) & trim(request("bgClr")) & chr(34) & "" & vbcrlf
 hf = hf & "Const hStartClr= " & chr(34) & trim(request("hStartClr")) & chr(34) & "" & vbcrlf
 hf = hf & "Const hStartAlp= " & chr(34) & trim(request("hStartAlp")) & chr(34) & "" & vbcrlf
 hf = hf & "Const hEndClr= " & chr(34) & trim(request("hEndClr")) & chr(34) & "" & vbcrlf
 hf = hf & "Const hEndAlp= " & chr(34) & trim(request("hEndAlp")) & chr(34) & "" & vbcrlf
 hf = hf & "Const overLayClr= " & chr(34) & trim(request("overLayClr")) & chr(34) & "" & vbcrlf
 hf = hf & "Const overLayTrans= " & chr(34) & trim(request("overLayTrans")) & chr(34) & "" & vbcrlf
 if request("bgImage") then
 hf = hf & "Const bgImage= 1" & vbcrlf
 else
 hf = hf & "Const bgImage= 0" & vbcrlf
 end if
 hf = hf & "Const bgUrl= " & chr(34) & trim(request("bgUrl")) & chr(34) & "" & vbcrlf
 if request("autoPlayer") then
 hf = hf & "Const autoPlayer= 1" & vbcrlf
 else
 hf = hf & "Const autoPlayer= 0" & vbcrlf
 end if
 hf = hf & "Const autoDur= " & chr(34) & trim(request("autoDur")) & chr(34) & "" & vbcrlf
 if request("logoSetup") then
 hf = hf & "Const logoSetup= 1" & vbcrlf
 else
 hf = hf & "Const logoSetup= 0" & vbcrlf
 end if
 hf = hf & "Const logoUrl= " & chr(34) & trim(request("logoUrl")) & chr(34) & "" & vbcrlf
 if request("logoShade") then
 hf = hf & "Const logoShade= 1" & vbcrlf
 else
 hf = hf & "Const logoShade= 0" & vbcrlf
 end if
 if request("logoBevel") then
 hf = hf & "Const logoBevel= 1" & vbcrlf
 else
 hf = hf & "Const logoBevel= 0" & vbcrlf
 end if
 if request("logoGlow") then
 hf = hf & "Const logoGlow= 1" & vbcrlf
 else
 hf = hf & "Const logoGlow= 0" & vbcrlf
 end if
 if request("helpSetup") then
 hf = hf & "Const helpSetup= 1" & vbcrlf
 else
 hf = hf & "Const helpSetup= 0" & vbcrlf
 end if
 if request("pdfSetup") then
 hf = hf & "Const pdfSetup= 1" & vbcrlf
 else
 hf = hf & "Const pdfSetup= 0" & vbcrlf
 end if
 if request("zoomSetup") then
 hf = hf & "Const zoomSetup= 1" & vbcrlf
 else
 hf = hf & "Const zoomSetup= 0" & vbcrlf
 end if
 if request("ExtendedZoom") then
 hf = hf & "Const ExtendedZoom= 1" & vbcrlf
 else
 hf = hf & "Const ExtendedZoom= 0" & vbcrlf
 end if
 if request("printSetup") then
 hf = hf & "Const printSetup= 1" & vbcrlf
 else
 hf = hf & "Const printSetup= 0" & vbcrlf
 end if
 if request("ListPages") then
 hf = hf & "Const ListPages= 1" & vbcrlf
 else
 hf = hf & "Const ListPages= 0" & vbcrlf
 end if
 if request("Mp3Setup") then
 hf = hf & "Const Mp3Setup= 1" & vbcrlf
 else
 hf = hf & "Const Mp3Setup= 0" & vbcrlf
 end if
 if request("AutoStart") then
 hf = hf & "Const AutoStart= 1" & vbcrlf
 else
 hf = hf & "Const AutoStart= 0" & vbcrlf
 end if
 if request("RandomStart") then
 hf = hf & "Const RandomStart= 1" & vbcrlf
 else
 hf = hf & "Const RandomStart= 0" & vbcrlf
 end if
 hf = hf & "%" & ">"
.WriteText=hf 
.SaveToFile Server.mappath("../E-zine/xml/siteContent.asp"),2 
.Close 
End With 
Set objStream = Nothing

'生成所有电子杂志XML文件
set rs=server.createobject("adodb.recordset")
sql="select * from ChinaQJ_Magazine"
rs.open sql,conn,1,1
if rs.eof or rs.bof then
Response.Write("")
else
while(not rs.eof)
vDir = ""&SysRootDir&"E-Zine/xml/" '制作SiteMap的目录,相对目录(相对于根目录而言)

set objfso = CreateObject("Scripting.FileSystemObject")
root = Server.MapPath(vDir)

if flipSound then flipSoundXML="true" else flipSoundXML="false" end if
if reverseOrder then reverseOrderXML="true" else reverseOrderXML="false" end if
if bgImage then bgImageXML="true" else bgImageXML="false" end if
if autoPlayer then autoPlayerXML="true" else autoPlayerXML="false" end if
if logoSetup then logoSetupXML="true" else logoSetupXML="false" end if
if logoShade then logoShadeXML="true" else logoShadeXML="false" end if
if logoBevel then logoBevelXML="true" else logoBevelXML="false" end if
if logoGlow then logoGlowXML="true" else logoGlowXML="false" end if
if helpSetup then helpSetupXML="true" else helpSetupXML="false" end if
if pdfSetup then pdfSetupXML="true" else pdfSetupXML="false" end if
if zoomSetup then zoomSetupXML="true" else zoomSetupXML="false" end if
if ExtendedZoom then ExtendedZoomXML="true" else ExtendedZoomXML="false" end if
if printSetup then printSetupXML="true" else printSetupXML="false" end if
if ListPages then ListPagesXML="true" else ListPagesXML="false" end if
if Mp3Setup then Mp3SetupXML="true" else Mp3SetupXML="false" end if
if AutoStart then AutoStartXML="true" else AutoStartXML="false" end if
if RandomStart then RandomStartXML="true" else RandomStartXML="false" end if
hSndClr=hEndClr
hSndAlp=hEndAlp

str = "<?xml version=""1.0"" encoding=""UTF-8""?>" & vbcrlf
str = str & "<flipBook>" & vbcrlf
str = str & "  <siteOptions>" & vbcrlf
str = str & "    <pageSetup pageW="""&pageW&""" pageH="""&pageH&""" hardCover=""false"" pageClr=""eeeeee"" flipSound="""& flipSoundXML &""" reverseOrder="""& reverseOrderXML &""" bgClr="""&bgClr&""" hStartClr="""&hStartClr&""" hStartAlp="""&hStartAlp&""" hEndClr="""&hSndClr&""" hEndAlp="""&hSndAlp&""" overLayClr="""&overLayClr&""" overLayTrans="""&overLayTrans&""" bgImage="""& bgImageXML &""" bgUrl="""&bgUrl&""" bgStyle=""tile"" autoPlayer="""& autoPlayerXML &""" autoDur="""&autoDur&""" preLoadTxt=""数据加载中，请稍候...""></pageSetup>" & vbcrlf
str = str & "    <buttonSetup highlClr=""858c1e"" darkClr=""5B5B13"" rimClr=""ffffff"" iconClr=""ffffff"" buttonPack=""buttonpack02""></buttonSetup>" & vbcrlf
str = str & "    <logoSetup showLogo="""& logoSetupXML &""" logoUrl="""&logoUrl&""" logoShade="""& logoShadeXML &""" logoBevel="""& logoBevelXML &""" logoGlow="""& logoGlowXML &"""></logoSetup>" & vbcrlf
str = str & "    <helpSetup showMe="""& helpSetupXML &""" downPdfBut=""下载电子杂志"" printBut=""打印"" contactBut=""联系我们"" listBut=""电子杂志列表"" zoomBut=""放大/缩小视图"" singleBut=""翻页"" allBut=""跳转"" cornerHint=""单击页角可以向前、向后翻页"" lineClr=""858c1e"" overLayClr=""000000"" overLayTrans=""60""></helpSetup>" & vbcrlf
str = str & "    <pdfSetup showMe="""& pdfSetupXML &""" pdfUrl="""&rs("MagazineDown")&"""></pdfSetup>" & vbcrlf
str = str & "    <zoomSetup showMe="""& zoomSetupXML &""" extendedZoom="""& extendedZoomXML &"""><![CDATA[<dragMessage>您可以单击或拖动页<br /><br />也可以使用鼠标滚轮放大或缩小视图</dragMessage>]]></zoomSetup>" & vbcrlf
str = str & "    <printSetup showMe="""& printSetupXML &""">" & vbcrlf
str = str & "      <printHead><![CDATA[<headPrint>打印选项</headPrint>]]></printHead>" & vbcrlf
str = str & "      <printOne butTxt=""打 印""><![CDATA[<headPrint>打印电子杂志单页</headPrint><br /><contPrint>请输入您要打印的电子杂志单页页码，单击“打印”按钮开始打印。</contPrint>]]></printOne>" & vbcrlf
str = str & "      <printAll butTxt=""打 印""><![CDATA[<headPrint>打印当前电子杂志所有页面</headPrint><br /><contPrint>需要打印所有页面，请直接单击“打印”按钮开始打印。</contPrint>]]></printAll>" & vbcrlf    
str = str & "    </printSetup>" & vbcrlf
str = str & "    <contactSetup showMe=""false"" nameField=""称呼、姓名"" mailField=""电子邮箱"" subjField=""留言、咨询标题"" messageField=""留言、咨询详细内容"" errTxt1=""必填项"" errTxt2=""格式错误"" procTxt=""数据正在提交…"" sucMess=""感谢您的关注，您的留言、咨询内容已提交！"">" & vbcrlf
str = str & "      <contactHead><![CDATA[<headPrint>联系我们</headPrint>]]></contactHead>" & vbcrlf
str = str & "      <contactTxt butTxt=""提 交""><![CDATA[<contPrint>请详细填写您的留言、咨询内容，含 * 为必填项。</contPrint>]]></contactTxt>" & vbcrlf
str = str & "    </contactSetup>" & vbcrlf
str = str & "    <listPages showMe="""& listPagesXML &"""></listPages>" & vbcrlf
str = str & "    <mp3Setup useMp3="""& mp3SetupXML &""" usePhp=""false"" autoStart="""& autoStartXML &""" randomStart="""& randomStartXML &"""></mp3Setup>" & vbcrlf
str = str & "  </siteOptions>" & vbcrlf
str = str & "  <bookPages>" & vbcrlf
OtherPic=rs("OtherPic")
If OtherPic<>"" Then
OtherPic=split(OtherPic,"*")
for htmlshop=0 to ubound(OtherPic)-1
str = str & "    <page src="""&OtherPic(htmlshop)&"""></page>" & vbcrlf
next
end if
str = str & "  </bookPages>" & vbcrlf
str = str & "</flipBook>"& vbcrlf
set fso = nothing

Set objStream = Server.CreateObject("ADODB.Stream")
With objStream
'.Type = adTypeText
'.Mode = adModeReadWrite
.Open
.Charset = "utf-8"
.Position = objStream.Size
.WriteText=str
.SaveToFile server.mappath(""&vDir&"siteContent"&rs("id")&".xml"),2 '生成的XML文件名
.Close
End With
rs.movenext
wend
end if
rs.close
set rs=nothing
'生成结束
 response.Write "<script language=javascript>alert('设置成功！');location.href='MagazineSetting.asp';</script>"
End Function
%>