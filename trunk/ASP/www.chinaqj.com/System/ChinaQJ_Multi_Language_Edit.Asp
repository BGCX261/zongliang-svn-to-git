<!--#include file="../Include/Const.asp" -->
<!--#include file="../Include/ConnSiteData.asp" -->
<!--#include file="CheckAdmin.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%
if Instr(session("AdminPurview"),"|41,")=0 then
  response.write ("<br /><br /><div align=""center""><font style=""color:red; font-size:9pt; "")>您没有管理该模块的权限！</font></div>")
  response.end
end if
%>
<link rel="stylesheet" href="Images/Admin_style.css">
<script language="javascript" src="../Scripts/Admin.js"></script>
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
            colorTable=colorTable+'<td width="11" style="background-color: #000000">'
            if (i==0){
                colorTable=colorTable+'<td width="11" style="background-color: #'+ColorHex[j]+ColorHex[j]+ColorHex[j]+'">'}
            else{
                colorTable=colorTable+'<td width="11" style="background-color: #'+SpColorHex[j]+'">'}
            colorTable=colorTable+'<td width="11" style="background-color: #000000">'
            for (k=0;k<3;k++)
            {
                for (l=0;l<6;l++)
                {
                    colorTable=colorTable+'<td width="11" style="background-color:#'+ColorHex[k+i*3]+ColorHex[l]+ColorHex[j]+'">'
                }
            }
        }
    }
    colorTable='<table width="253" border="0" cellspacing="0" cellpadding="0" style="border: 1px #000000 solid; border-bottom: none; border-collapse: collapse" bordercolor="000000">'
    +'<tr height="30"><td colspan="21" bgcolor="#cccccc">'
    +'<table cellpadding="0" cellspacing="1" border="0" style="border-collapse: collapse">'
    +'<tr><td width="3"><td><input type="text" name="DisColor" size="6" disabled style="border: solid 1px #000000; background-color: #ffff00"></td>'
    +'<td width="3"><td><input type="text" name="HexColor" size="7" style="border: inset 1px; font-family: Arial;" value="#000000">&nbsp;&nbsp;&nbsp;&nbsp;<a href="http://www.ChinaQJ.com" target="_blank">系统选色版</a></td></tr></table></td></table>'
    +'<table border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="000000" onmouseover="doOver()" onmouseout="doOut()" onclick="doclick(\''+dddd+'\',\''+ssss+'\',\''+ffff+'\')" style="cursor:hand;">'
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
<script language="javascript">
<!--
function showUploadDialog(s_Type, s_Link, s_Thumbnail){
    var arr = showModalDialog("eWebEditor/dialog/i_upload.htm?style=coolblue&type="+s_Type+"&link="+s_Link+"&thumbnail="+s_Thumbnail, window, "dialogWidth: 0px; dialogHeight: 0px; help: no; scroll: no; status: no");
}
//-->
</script>
<% 
dim ID,Result,Action,ChinaQJ_Language_Name,ChinaQJ_Language_Ico,ChinaQJ_Language_FrontName,ChinaQJ_Language_File,ChinaQJ_Language_Txt,ChinaQJ_Language_Order,ChinaQJ_Language_State,ChinaQJ_Language_Index
ID=Request("ID")
Action=Request("Action")
Result=Request("Result")
if Action="SaveEdit" then
set rs = server.createobject("adodb.recordset")
    if len(trim(request.Form("ChinaQJ_Language_Name")))<1 then
      response.write ("<script language='javascript'>alert('请填写语言名称！');history.back(-1);</script>")
      response.end
    end if
    if len(trim(request.Form("ChinaQJ_Language_Ico")))<1 then
      response.write ("<script language='javascript'>alert('请填写语言图标！');history.back(-1);</script>")
      response.end
    end if
    if len(trim(request.Form("ChinaQJ_Language_FrontName")))<1 then
      response.write ("<script language='javascript'>alert('请填写语言标识！');history.back(-1);</script>")
      response.end
    end if
    if len(trim(request.Form("ChinaQJ_Language_File")))<1 then
      response.write ("<script language='javascript'>alert('请填写语言目录！');history.back(-1);</script>")
      response.end
    end if
    if len(trim(request.Form("ChinaQJ_Language_Txt")))<1 then
      response.write ("<script language='javascript'>alert('请填写语言字段标识！');history.back(-1);</script>")
      response.end
    end if
if Result="Add" then
sql="select * from ChinaQJ_Language"
rs.open sql,conn,1,3
rs.addnew
else
sql="select * from ChinaQJ_Language where id="&id
rs.open sql,conn,1,3
end if
rs("ChinaQJ_Language_Name")=request("ChinaQJ_Language_Name")
rs("ChinaQJ_Language_Ico")=request("ChinaQJ_Language_Ico")
rs("ChinaQJ_Language_FrontName")=request("ChinaQJ_Language_FrontName")
rs("ChinaQJ_Language_File")=request("ChinaQJ_Language_File")
rs("ChinaQJ_Language_Txt")=request("ChinaQJ_Language_Txt")
rs("ChinaQJ_Language_Order")=request("ChinaQJ_Language_Order")
if request("ChinaQJ_Language_State")=1 then
rs("ChinaQJ_Language_State")=request("ChinaQJ_Language_State")
else
rs("ChinaQJ_Language_State")=0
end if
if request("ChinaQJ_Language_Index")=1 then
rs("ChinaQJ_Language_Index")=request("ChinaQJ_Language_Index")
else
rs("ChinaQJ_Language_Index")=0
end if
rs.update
FolderPath="/"&rs("ChinaQJ_Language_File")
'TempEnd="/Include/Language"&rs("ChinaQJ_Language_File")&".Asp"
Language_File=rs("ChinaQJ_Language_File")
rs.close
set rs=nothing

if Result="Add" then
'新建目录及复制目录文件
FolderName="/Ch"
response.write""&CopyMyFolder(FolderName,FolderPath)&""

'复制语言包文件
'TempSource="/Include/LanguageCh.Asp"
'response.write""&CopyFiles(TempSource,TempEnd)&""

'数据库表新增字段
sql="alter table ChinaQJ_Site add SiteTitle"&Language_File&" VarChar(200), Keywords"&Language_File&" VarChar(255), Descriptions"&Language_File&" VarChar(255), ComName"&Language_File&" VarChar(200), Address"&Language_File&" VarChar(200), SiteIndexNotice"&Language_File&" VarChar(255), Video"&Language_File&" VarChar(250), PageBanner"&Language_File&" VarChar(250), PageBannerType"&Language_File&" int, PageBannerWidth"&Language_File&" VarChar(255), PageBannerHeight"&Language_File&" VarChar(255), SiteDetail"&Language_File&" text"
conn.execute(sql)

sql="alter table ChinaQJ_Navigation add NavName"&Language_File&" VarChar(255), ViewFlag"&Language_File&" bit, IndexView"&Language_File&" bit"
conn.execute(sql)

sql="alter table ChinaQJ_FriendLink add LinkName"&Language_File&" VarChar(255), ViewFlag"&Language_File&" bit, LinkFace"&Language_File&" VarChar(255)"
conn.execute(sql)

sql="alter table ChinaQJ_NetWork add ChinaQJ_Company"&Language_File&" VarChar(255), ChinaQJ_Address"&Language_File&" VarChar(250), ChinaQJ_User"&Language_File&" VarChar(250), ChinaQJ_Demo"&Language_File&" text"
conn.execute(sql)

sql="alter table ChinaQJ_DownSort add SortName"&Language_File&" VarChar(255), ViewFlag"&Language_File&" bit, SeoKeywords"&Language_File&" VarChar(255), SeoDescription"&Language_File&" VarChar(255)"
conn.execute(sql)

sql="alter table ChinaQJ_OthersSort add SortName"&Language_File&" VarChar(255), ViewFlag"&Language_File&" bit, SeoKeywords"&Language_File&" VarChar(255), SeoDescription"&Language_File&" VarChar(255)"
conn.execute(sql)

sql="alter table ChinaQJ_ProductSort add SortName"&Language_File&" VarChar(255), ViewFlag"&Language_File&" bit, SeoKeywords"&Language_File&" VarChar(255), SeoDescription"&Language_File&" VarChar(255)"
conn.execute(sql)

sql="alter table ChinaQJ_NewsSort add SortName"&Language_File&" VarChar(255), ViewFlag"&Language_File&" bit, SeoKeywords"&Language_File&" VarChar(255), SeoDescription"&Language_File&" VarChar(255)"
conn.execute(sql)

sql="alter table ChinaQJ_ImageSort add SortName"&Language_File&" VarChar(255), ViewFlag"&Language_File&" bit, SeoKeywords"&Language_File&" VarChar(255), SeoDescription"&Language_File&" VarChar(255)"
conn.execute(sql)

sql="alter table ChinaQJ_VideoSort add SortName"&Language_File&" VarChar(255), ViewFlag"&Language_File&" bit, SeoKeywords"&Language_File&" VarChar(255), SeoDescription"&Language_File&" VarChar(255)"
conn.execute(sql)

sql="alter table ChinaQJ_News add NewsName"&Language_File&" VarChar(255), ViewFlag"&Language_File&" bit, SeoKeywords"&Language_File&" VarChar(255), SeoDescription"&Language_File&" VarChar(255), Source"&Language_File&" VarChar(100), Content"&Language_File&" text, TheTags"&Language_File&" VarChar(255)"
conn.execute(sql)

sql="alter table ChinaQJ_About add AboutName"&Language_File&" VarChar(255), ViewFlag"&Language_File&" bit, SeoKeywords"&Language_File&" VarChar(255), SeoDescription"&Language_File&" VarChar(255), Content"&Language_File&" text, TheTags"&Language_File&" VarChar(255)"
conn.execute(sql)

sql="alter table ChinaQJ_Products add ProductName"&Language_File&" VarChar(255), ViewFlag"&Language_File&" bit, CommendFlag"&Language_File&" bit, NewFlag"&Language_File&" bit, SeoKeywords"&Language_File&" VarChar(255), SeoDescription"&Language_File&" VarChar(255), Content"&Language_File&" text, ProName"&Language_File&" text, ProInfo"&Language_File&" text, TheTags"&Language_File&" VarChar(255), Remark"&Language_File&" text"
conn.execute(sql)

sql="alter table ChinaQJ_Download add DownName"&Language_File&" VarChar(255), ViewFlag"&Language_File&" bit, SeoKeywords"&Language_File&" VarChar(255), SeoDescription"&Language_File&" VarChar(255), Content"&Language_File&" text, TheTags"&Language_File&" VarChar(255)"
conn.execute(sql)

sql="alter table ChinaQJ_Others add OthersName"&Language_File&" VarChar(255), ViewFlag"&Language_File&" bit, SeoKeywords"&Language_File&" VarChar(255), SeoDescription"&Language_File&" VarChar(255), Content"&Language_File&" text, TheTags"&Language_File&" VarChar(255)"
conn.execute(sql)

sql="alter table ChinaQJ_Image add ImageName"&Language_File&" VarChar(255), ViewFlag"&Language_File&" bit, SeoKeywords"&Language_File&" VarChar(255), SeoDescription"&Language_File&" VarChar(255), Content"&Language_File&" text, TheTags"&Language_File&" VarChar(255)"
conn.execute(sql)

sql="alter table ChinaQJ_Video add VideoName"&Language_File&" VarChar(255), ViewFlag"&Language_File&" bit"
conn.execute(sql)

sql="alter table ChinaQJ_KeyIdea add KeyIdeaName"&Language_File&" VarChar(255), Content"&Language_File&" text, SeoKeywords"&Language_File&" VarChar(255), SeoDescription"&Language_File&" VarChar(255), TheTags"&Language_File&" VarChar(255)"
conn.execute(sql)

sql="alter table ChinaQJ_Jobs add JobName"&Language_File&" VarChar(255), ViewFlag"&Language_File&" bit, SeoKeywords"&Language_File&" VarChar(255), SeoDescription"&Language_File&" VarChar(255), JobAddress"&Language_File&" VarChar(255), Emolument"&Language_File&" VarChar(255), Responsibility"&Language_File&" text, Requirement"&Language_File&" text, eEmployer"&Language_File&" VarChar(100), eContact"&Language_File&" VarChar(255), eAddress"&Language_File&" VarChar(100)"
conn.execute(sql)

sql="alter table ChinaQJ_Message add ViewFlag"&Language_File&" bit"
conn.execute(sql)

sql="alter table ChinaQJ_Subsidiary add Subsidiary"&Language_File&" VarChar(250), PropertyName"&Language_File&" text, PropertyValue"&Language_File&" text"
conn.execute(sql)

sql="alter table ChinaQJ_MemGroup add GroupName"&Language_File&" VarChar(255)"
conn.execute(sql)

sql="alter table ChinaQJ_Properties add ProProperties"&Language_File&" text"
conn.execute(sql)

end if   '复制目录/增加字段结束

response.write "<script language='javascript'>alert('设置成功！');location.replace('ChinaQJ_Multi_Language.Asp');</script>"
end if

if Result="Modify" then
set rs = server.createobject("adodb.recordset")
sql="select * from ChinaQJ_Language where id="&id
rs.open sql,conn,1,1
ChinaQJ_Language_Name=rs("ChinaQJ_Language_Name")
ChinaQJ_Language_Ico=rs("ChinaQJ_Language_Ico")
ChinaQJ_Language_FrontName=rs("ChinaQJ_Language_FrontName")
ChinaQJ_Language_File=rs("ChinaQJ_Language_File")
ChinaQJ_Language_Txt=rs("ChinaQJ_Language_Txt")
ChinaQJ_Language_Order=rs("ChinaQJ_Language_Order")
ChinaQJ_Language_State=rs("ChinaQJ_Language_State")
ChinaQJ_Language_Index=rs("ChinaQJ_Language_Index")
rs.close
set rs=nothing
end if
%>
<br />

<table class="tableBorder" width="95%" border="0" align="center" cellpadding="0" cellspacing="1">
  <form name="editForm" method="post" action="ChinaQJ_Multi_Language_Edit.Asp?Action=SaveEdit&Result=<%= Result %>&ID=<%= ID %>">
    <tr>
      <th height="28" colspan="2" sytle="line-height:150%">【添加语言模块】</th>
    </tr>
    <tr height="28">
      <td width="200" align="right" class="forumRow">语言名称：</td>
      <td class="forumRowHighlight"><input name="ChinaQJ_Language_Name" type="text" id="ChinaQJ_Language_Name" style="width: 120" value="<%= ChinaQJ_Language_Name %>"> <font color="red">*</font></td>
    </tr>
    <tr height="28">
      <td width="200" align="right" class="forumRow">语言图标：</td>
      <td class="forumRowHighlight"><input name="ChinaQJ_Language_Ico" type="text" id="ChinaQJ_Language_Ico" style="width: 250" value="<%= ChinaQJ_Language_Ico %>"> <input type="button" value="上传图片" onclick="showUploadDialog('image', 'editForm.ChinaQJ_Language_Ico', '')"> <font color="red">*</font></td>
    </tr>
    <tr height="28">
      <td width="200" align="right" class="forumRow">语言标识：</td>
      <td class="forumRowHighlight"><input name="ChinaQJ_Language_FrontName" type="text" id="ChinaQJ_Language_FrontName" style="width: 120" value="<%= ChinaQJ_Language_FrontName %>"> <font color="red">* 前台所显示的语言名称</font></td>
    </tr>
    <tr height="28">
      <td width="200" align="right" class="forumRow">语言目录：</td>
      <td class="forumRowHighlight"><input name="ChinaQJ_Language_File" type="text" id="ChinaQJ_Language_File" style="width: 120" value="<%= ChinaQJ_Language_File %>"> <font color="red">*<br />
      前台多国语言模块目录说明：系统首次安装时，会让您自定义设置模块目录。<br />
      如果您的网站已经运行一段时间并被搜索引擎收录、排名良好，建议慎重改变模块目录结构，以免对收录、排名造成影响。<br />
      如果修改目录结构，系统会根据您当前的新设置自动修改目录结构及数据。<br />
      </font></td>
    </tr>
    <tr height="28">
      <td width="200" align="right" class="forumRow">语言字段标识：</td>
      <td class="forumRowHighlight"><input name="ChinaQJ_Language_Txt" type="text" id="ChinaQJ_Language_Txt" style="width: 120" value="<%= ChinaQJ_Language_Txt %>" <% If Result="Modify" Then Response.Write("style=""background-color: lemonchiffon; color: #808080;"" readonly")%>> <font color="red">* 前台所显示的语言名称</font></td>
    </tr>
    <tr height="28">
      <td width="200" align="right" class="forumRow">排序：</td>
<% If ChinaQJ_Language_Order="" Then ChinaQJ_Language_Order=0 %>
      <td class="forumRowHighlight"><input name="ChinaQJ_Language_Order" type="text" id="ChinaQJ_Language_Order" style="width: 120" value="<%= ChinaQJ_Language_Order %>" onkeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false"> <font color="red">* 只允许填写整数，留空系统则默认为0。</font></td>
    </tr>
<% If ChinaQJ_Language_State="" Then ChinaQJ_Language_State=1 %>
    <tr height="28">
      <td width="200" align="right" class="forumRow">状态：</td>
      <td class="forumRowHighlight"><select style="width: 80px;" name="ChinaQJ_Language_State">
          <option value="0" style="color: red;" <% If ChinaQJ_Language_State=false Then Response.Write("selected")%>>禁用</option>
          <option value="1" <% If ChinaQJ_Language_State Then Response.Write("selected")%>>启用</option>
        </select> <font color="red">*</font></td>
    </tr>
<% If ChinaQJ_Language_Index="" Then ChinaQJ_Language_Index=0 %>
    <tr height="28">
      <td width="200" align="right" class="forumRow">前台首页转向优先：</td>
      <td class="forumRowHighlight"><select style="width: 80px;" name="ChinaQJ_Language_Index">
          <option value="0" <% If ChinaQJ_Language_Index=0 Then Response.Write("selected")%>>默认</option>
          <option value="1" style="color: red;" <% If ChinaQJ_Language_Index Then Response.Write("selected")%>>优先</option>
        </select> <font color="red">* 如果您是多国语言版本，启用后访问首页时将首先转向已设置的语言目录。</font></td>
    </tr>
    <tr height="28">
      <td align="right" class="forumRow"></td>
      <td class="forumRowHighlight"><input name="submitSaveEdit" type="submit" id="submitSaveEdit" value="保存设置" onClick="return CheckLanguage();"> <input type="button" value="返回上一页" onclick="history.back(-1)"></td>
    </tr>
  </form>
</table>
<br />
<% 
Function CopyMyFolder(FolderName,FolderPath) 
sFolder=server.mappath(FolderName) 
oFolder=server.mappath(FolderPath) 
set fso=server.createobject("scripting.filesystemobject") 
if fso.folderexists(server.mappath(FolderName)) Then'检查原文件夹是否存在 
if fso.folderexists(server.mappath(FolderPath)) Then'检查目标文件夹是否存在 
fso.copyfolder sFolder,oFolder 
Else '目标文件夹如果不存在就创建 
CreateNewFolder = Server.Mappath(FolderPath) 
fso.CreateFolder(CreateNewFolder) 
fso.copyfolder sFolder,oFolder 
End if 
'CopyMyFolder="复制文件夹["&server.mappath(FolderName)&"]到["&server.mappath(FolderPath)&"]成功!" 
Else 
'CopyMyFolder="错误,原文件夹["&sFolde&"]不存在!" 
End If 
set fso=nothing 
End Function

Function CopyFiles(TempSource,TempEnd)
TempSource=server.mappath(TempSource) 
TempEnd=server.mappath(TempEnd) 
Dim FSO 
Set FSO = Server.CreateObject("Scripting.FileSystemObject") 
IF FSO.FileExists(TempEnd) then 
   'Response.Write "目标文件 <b>" & TempEnd & "</b> 已存在，请先删除!" 
   Set FSO=Nothing 
   Exit Function 
End IF 
IF FSO.FileExists(TempSource) Then 
Else 
   'Response.Write "要复制的源文件 <b>"&TempSource&"</b> 不存在!" 
   Set FSO=Nothing 
   Exit Function 
End If 
FSO.CopyFile TempSource,TempEnd 
'Response.Write "已经成功复制文件 <b>"&TempSource&"</b> 到 <b>"&TempEnd&"</b>" 
Set FSO = Nothing 
End Function

%> 