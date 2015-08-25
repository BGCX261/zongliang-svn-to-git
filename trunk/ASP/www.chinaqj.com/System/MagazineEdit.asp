<!--#include file="../Include/Const.asp" -->
<!--#include file="../E-zine/xml/siteContent.asp" -->
<!--#include file="../Include/ConnSiteData.asp" -->
<!--#include file="Admin_htmlconfig.asp"-->
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
           +'<td width="3"><td><input type="text" name="HexColor" size="7" style="border: inset 1px; font-family: Arial;" value="#000000">&nbsp;&nbsp;&nbsp;&nbsp;<a href="http://www.ChinaQJ.com" target="_blank">选色板
</a></td></tr></table></td></table>'
           +'<table border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="000000" onmouseover="doOver()" onmouseout="doOut()" onclick="doclick(\''+dddd+'\',\''+ssss+'\',\''+ffff+'\')" style="cursor:hand;">'
           +colorTable+'</table>';
colorpanel.innerHTML=colorTable
}
function doOver() {
      if ((event.srcElement.tagName=="TD") && (current!=event.srcElement)) {
        if (current!=null){current.style.backgroundColor = current._background}
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
<script language="javascript" src="JavaScript/Tab.js"></script>
<script language="javascript" src="../DatePicker/WdatePicker.js"></script>
<script language="javascript">
<!--
function showUploadDialog(s_Type, s_Link, s_Thumbnail){
    var arr = showModalDialog("eWebEditor/dialog/i_upload.htm?style=coolblue&type="+s_Type+"&link="+s_Link+"&thumbnail="+s_Thumbnail, window, "dialogWidth: 0px; dialogHeight: 0px; help: no; scroll: no; status: no");
}
//-->
</script>
<%
if Instr(session("AdminPurview"),"|16,")=0 then
  response.write ("<br /><br /><div align=""center""><font style=""color:red; font-size:9pt; "")>您没有管理该模块的权限！</font></div>")
  response.end
end if
dim Result
Result=request.QueryString("Result")
dim ID,SortName,classseo,SortID,SortPath
dim SeoKeywords,SeoDescription,MagazineImage,MagazineDown,OtherPic
Dim hanzi,j,ChinaQJ,temp,temp1,flag,firstChar
dim Sequence,TitleColor
ID=request.QueryString("ID")
call MagazineEdit()
%>
<br />
<ul id="tablist">
<% 
set rs = server.createobject("adodb.recordset")
sql="select * from ChinaQJ_Language order by ChinaQJ_Language_Order"
rs.open sql,conn,1,1
lani=1
while(not rs.eof)
%>
   <li <% If rs("ChinaQJ_Language_Index") Then Response.Write("class=""selected""")%>><a rel="tcontent<%= lani %>" style="cursor: hand;"><%=rs("ChinaQJ_Language_Name")%></a></li>   
<% 
rs.movenext
lani=lani+1
wend
rs.close
set rs=nothing
%>
</ul>
<table class="tableBorder" width="95%" border="0" align="center" cellpadding="0" cellspacing="1">
  <form name="editForm" method="post" action="MagazineEdit.asp?Action=SaveEdit&Result=<%=Result%>&ID=<%=ID%>">
    <tr>
      <th height="22" colspan="2" sytle="line-height:150%">【<%If Result = "Add" then%>添加<%ElseIf Result = "Modify" then%>修改<%End If%>电子杂志】</th>
    </tr>
  <tr><td class="leftRow" colspan="2">
<% 
set rs = server.createobject("adodb.recordset")
sql="select * from ChinaQJ_Language order by ChinaQJ_Language_Order"
rs.open sql,conn,1,1
lani=1
while(not rs.eof)
%>
<div id="tcontent<%= lani %>" class="tabcontent">
<table class="tableborderOther" width="100%" border="0" align="center" cellpadding="0" cellspacing="1">
    <tr height="35">
      <td width="20%" align="right" class="forumRow"><%=rs("ChinaQJ_Language_Name")%>标题：</td>
      <td width="80%" class="forumRowHighlight"><input name="MagazineName<%= rs("ChinaQJ_Language_File") %>" type="text" id="MagazineName<%= rs("ChinaQJ_Language_File") %>" style="width: 280" value="<%=eval("MagazineName"&rs("ChinaQJ_Language_File"))%>" maxlength="100">
        显示：<input name="ViewFlag<%= rs("ChinaQJ_Language_File") %>" type="checkbox" value="1" <%if eval("ViewFlag"&rs("ChinaQJ_Language_File")) then response.write ("checked")%>>
		推荐：<input name="CommendFlag<%= rs("ChinaQJ_Language_File") %>" type="checkbox" value="1" <%if eval("CommendFlag"&rs("ChinaQJ_Language_File")) then response.write ("checked")%>> <font color="red">*</font></td>
    </tr>
</table>
</div>
<% 
rs.movenext
lani=lani+1
wend
rs.close
set rs=nothing
%>
  <script>showtabcontent("tablist")</script></td></tr>
    <tr height="35">
      <td width="20%" align="right" class="forumRow">MetaKeywords：</td>
      <td width="80%" class="forumRowHighlight"><input name="SeoKeywords" type="text" id="SeoKeywords" style="width: 500" value="<%=SeoKeywords%>" maxlength="250"></td>
    </tr>
    <tr height="35">
      <td width="20%" align="right" class="forumRow">MetaDescription：</td>
      <td width="80%" class="forumRowHighlight"><input name="SeoDescription" type="text" id="SeoDescription" style="width: 500" value="<%=SeoDescription%>" maxlength="250"></td>
    </tr>
    <tr height="35">
    <td align="right" class="forumRow">标题颜色：</td>
    <td class="forumRowHighlight"><input name="TitleColor" id="TitleColor" type="text" value="<%= TitleColor %>" style="background-color:<%= TitleColor %>" size="7">
      <img src="Images/tm.gif"  width="20" height="20"  align="absmiddle" style="background-color:<%= TitleColor %>" onClick="colorcd('editForm','TitleColor','ChinaQJ')" onMouseOver="this.style.cursor='hand'"> <font id="ChinaQJ" color="<%= TitleColor %>">秦江陶瓷</font></td>
  </tr>
    <tr height="35">
      <td align="right" class="forumRow">电子杂志类别：</td>
      <td class="forumRowHighlight"><input name="SortID" type="text" id="SortID" style="width: 18; background-color:#fffff0" value="<%=SortID%>" readonly> <input name="SortPath" type="text" id="SortPath" style="width: 70; background-color:#fffff0" value="<%=SortPath%>" readonly> <input name="SortName" type="text" id="SortName" value="<%=SortName%>" style="width: 180; background-color:#fffff0" readonly> <a href="javaScript:OpenScript('SelectSort.asp?Result=Magazine',500,500,'')">选择类别</a> <font color="red">*</font></td>
    </tr>
    <tr height="35">
      <td width="20%" align="right" class="forumRow">缩略图：</td>
      <td width="80%" class="forumRowHighlight"><input name="MagazineImage" type="text" id="MagazineImage" style="width: 280" value="<%=MagazineImage%>" maxlength="100"> <input type="button" value="上传图片" onclick="showUploadDialog('image', 'editForm.MagazineImage', '')"> <font color="red">*</font></td>
    </tr>
    <tr height="35">
      <td width="20%" align="right" class="forumRow">下载地址：</td>
      <td width="80%" class="forumRowHighlight"><input name="MagazineDown" type="text" id="MagazineDown" style="width: 280" value="<%=MagazineDown%>" maxlength="100"> <input type="button" value="上传文件" onclick="showUploadDialog('file', 'editForm.MagazineDown', '')"> <font color="red">*</font></td>
    </tr>
    <tr height="35">
      <td align="right" class="forumRow">&nbsp;</td>
      <td class="forumRowHighlight"><font color="red">* 请设置好上图片用绝对根目路径，例如“/uploadfile/123.jpg”.</font></td>
    </tr>
    <tr>
      <td align="right" class="forumRow">杂志细节：</td>
      <td class="forumRowHighlight">
<%
if Request("Result")="Modify" then
If Not(IsNull(OtherPic)) Then
Dim htmlshop
%>
      <input name="Num_1" type="text" id="Num_1" value="<%= ubound(OtherPic) %>" size="5" /> 张
        <input type="button" value="设置" onClick="MagazineSet()" />
        <input type="button" value="增加一张"  onClick="MagazineAdd()" />
        <br />
        <span id="Num_1_str">
<% for htmlshop=0 to ubound(OtherPic)-1 %>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td height="28"><input name="Show<%= htmlshop+1 %>_Photos" type="text" id="Show<%= htmlshop+1 %>_Photos" value="<%= trim(OtherPic(htmlshop)) %>" style="width: 300" />
              <input type="button" value="上传图片" onclick="showUploadDialog('image', 'editForm.Show<%= htmlshop+1 %>_Photos', '')"><input type="button" value="上传动画" onclick="showUploadDialog('flash', 'editForm.Show<%= htmlshop+1 %>_Photos', '')"></td>
          </tr>
        </table>
<% next %>
        </span>
<%
else
%>
      <input name="Num_1" type="text" id="Num_1" value="0" size="5" /> 张
        <input type="button" value="设置" onClick="MagazineSet()" />
        <input type="button" value="增加一张"  onClick="MagazineAdd()" />
        <br />
        <span id="Num_1_str">
        
        </span>
<%
end if
else
%>
      <input name="Num_1" type="text" id="Num_1" value="0" size="5" /> 张
        <input type="button" value="设置" onClick="MagazineSet()" />
        <input type="button" value="增加一张"  onClick="MagazineAdd()" />
        <br />
        <span id="Num_1_str">
        
        </span>
<%
End If
%>
      </td>
    </tr>
    <tr height="35">
      <td align="right" class="forumRow">排序：</td>
<% if Sequence="" then Sequence=0 %>
      <td class="forumRowHighlight"><input name="Sequence" type="text" id="Sequence" style="width: 50" value="<%= Sequence %>" maxlength="10"></td>
    </tr>
    <tr height="35">
      <td width="20%" align="right" class="forumRow">自定义发布时间：</td>
      <% if AddTime="" then AddTime=Now() %>
      <td width="80%" class="forumRowHighlight"><input name="AddTime" type="text" id="AddTime" style="width: 120" value="<%=AddTime%>" onFocus="WdatePicker({startDate:'%y-%M-%d  %H:%m:%s',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" readonly> <font color="red">默认为当前时间，如需要修改发布时间，请点击文本框选择新时间。留空默认为当前时间。</font></td>
    </tr>
    <tr height="35">
      <td align="right" class="forumRow"></td>
      <td class="forumRowHighlight"><input name="submitSaveEdit" type="submit" id="submitSaveEdit" value="保存"> <input type="button" value="返回上一页" onclick="history.back(-1)"></td>
    </tr>
  </form>
</table>
<%
sub MagazineEdit()
  dim Action,rsRepeat,rs,sql
  Action=request.QueryString("Action")
  if Action="SaveEdit" then
    set rs = server.createobject("adodb.recordset")
    if len(trim(request.Form("MagazineNameCh")))<3 then
      response.write ("<script language='javascript'>alert('请填写电子杂志标题！');history.back(-1);</script>")
      response.end
    end If
    if Request.Form("SortID")="" and Request.Form("SortPath")="" then
      response.write ("<script language='javascript'>alert('请选择所属分类！');history.back(-1);</script>")
      response.end
    end If
    if Request.Form("MagazineImage")="" then
      response.write ("<script language='javascript'>alert('请填写电子杂志缩略图！');history.back(-1);</script>")
      response.end
    end If
    if Request.Form("MagazineDown")="" then
      response.write ("<script language='javascript'>alert('请填写电子杂志文件下载地址！');history.back(-1);</script>")
      response.end
    end If
    if Result="Add" then
	  sql="select * from ChinaQJ_Magazine"
      rs.open sql,conn,1,3
      rs.addnew
  '多语言循环保存数据
set rsl = server.createobject("adodb.recordset")
sqll="select * from ChinaQJ_Language order by ChinaQJ_Language_Order"
rsl.open sqll,conn,1,1
while(not rsl.eof)
  rs("MagazineName"&rsl("ChinaQJ_Language_File"))=trim(Request.Form("MagazineName"&rsl("ChinaQJ_Language_File")))
  if Request.Form("ViewFlag"&rsl("ChinaQJ_Language_File"))=1 then
	rs("ViewFlag"&rsl("ChinaQJ_Language_File"))=Request.Form("ViewFlag"&rsl("ChinaQJ_Language_File"))
  else
	rs("ViewFlag"&rsl("ChinaQJ_Language_File"))=0
  end if
  if Request.Form("CommendFlag"&rsl("ChinaQJ_Language_File"))=1 then
	rs("CommendFlag"&rsl("ChinaQJ_Language_File"))=Request.Form("CommendFlag"&rsl("ChinaQJ_Language_File"))
  else
	rs("CommendFlag"&rsl("ChinaQJ_Language_File"))=0
  end if
rsl.movenext
wend
rsl.close
set rsl=nothing
	  rs("SeoKeywords")=trim(Request.Form("SeoKeywords"))
	  rs("SeoDescription")=trim(Request.Form("SeoDescription"))
	  rs("SortID")=Request.Form("SortID")
	  rs("SortPath")=Request.Form("SortPath")
	  rs("MagazineImage")=trim(Request.Form("MagazineImage"))
	  rs("MagazineDown")=trim(Request.Form("MagazineDown"))
	  rs("AddTime")=now()
	  rs("Sequence")=trim(Request.Form("Sequence"))
	  rs("TitleColor")=trim(Request.Form("TitleColor"))
	  if PubRndDisplay=1 then
	  rs("ClickNumber")=Rnd_ClickNumber(PubRndNumStart,PubRndNumEnd)
	  else
	  rs("ClickNumber")=0
	  end if
	  Num_1=CheckStr(Request.Form("Num_1"),1)
	  if Num_1="" then Num_1=0
	  if Num_1>0 then
		For i=1 to Num_1
			If CheckStr(Request.Form("Show"&i&"_Photos"),0)<>"" Then
				If OtherPic="" then
					OtherPic=CheckStr(Request.Form("Show"&i&"_Photos"),0)&"*"
				Else
					OtherPic=OtherPic&CheckStr(Request.Form("Show"&i&"_Photos"),0)&"*"
				End if
			End If
		Next
	  end if
	  rs("OtherPic")=OtherPic
	  rs.update
	  rs.MoveLast
	  id=rs("id")
	  rs.close
	  set rs=Nothing
	end if
	if Result="Modify" then
      sql="select * from ChinaQJ_Magazine where ID="&ID
      rs.open sql,conn,1,3
  '多语言循环保存数据
set rsl = server.createobject("adodb.recordset")
sqll="select * from ChinaQJ_Language order by ChinaQJ_Language_Order"
rsl.open sqll,conn,1,1
while(not rsl.eof)
  rs("MagazineName"&rsl("ChinaQJ_Language_File"))=trim(Request.Form("MagazineName"&rsl("ChinaQJ_Language_File")))
  if Request.Form("ViewFlag"&rsl("ChinaQJ_Language_File"))=1 then
	rs("ViewFlag"&rsl("ChinaQJ_Language_File"))=Request.Form("ViewFlag"&rsl("ChinaQJ_Language_File"))
  else
	rs("ViewFlag"&rsl("ChinaQJ_Language_File"))=0
  end if
  if Request.Form("CommendFlag"&rsl("ChinaQJ_Language_File"))=1 then
	rs("CommendFlag"&rsl("ChinaQJ_Language_File"))=Request.Form("CommendFlag"&rsl("ChinaQJ_Language_File"))
  else
	rs("CommendFlag"&rsl("ChinaQJ_Language_File"))=0
  end if
rsl.movenext
wend
rsl.close
set rsl=nothing
	  rs("SeoKeywords")=trim(Request.Form("SeoKeywords"))
	  rs("SeoDescription")=trim(Request.Form("SeoDescription"))
	  rs("SortID")=Request.Form("SortID")
	  rs("SortPath")=Request.Form("SortPath")
	  rs("MagazineImage")=trim(Request.Form("MagazineImage"))
	  rs("MagazineDown")=trim(Request.Form("MagazineDown"))
	  rs("Sequence")=trim(Request.Form("Sequence"))
	  rs("TitleColor")=trim(Request.Form("TitleColor"))
	  if PubRndDisplay=1 then
	  rs("ClickNumber")=Rnd_ClickNumber(PubRndNumStart,PubRndNumEnd)
	  else
	  rs("ClickNumber")=0
	  end if
	  Num_1=CheckStr(Request.Form("Num_1"),1)
	  if Num_1="" then Num_1=0
	  if Num_1>0 then
		For i=1 to Num_1
			If CheckStr(Request.Form("Show"&i&"_Photos"),0)<>"" Then
				If OtherPic="" then
					OtherPic=CheckStr(Request.Form("Show"&i&"_Photos"),0)&"*"
				Else
					OtherPic=OtherPic&CheckStr(Request.Form("Show"&i&"_Photos"),0)&"*"
				End if
			End If
		Next
	  end if
	  rs("OtherPic")=OtherPic
	  rs.update
	  rs.close
	  set rs=Nothing
	  set rs=server.createobject("adodb.recordset")
	end if
	modxmlfile()
	response.write "<script language='javascript'>alert('设置成功！');location.replace('MagazineList.asp');</script>"
  else
	if Result="Modify" then
      set rs = server.createobject("adodb.recordset")
      sql="select * from ChinaQJ_Magazine where ID="& ID
      rs.open sql,conn,1,1
      if rs.bof and rs.eof then
        response.write ("<center>数据库记录读取错误！</center>")
        response.end
      end if
  '多语言循环拾取数据
set rsl = server.createobject("adodb.recordset")
sqll="select * from ChinaQJ_Language order by ChinaQJ_Language_Order"
rsl.open sqll,conn,1,1
while(not rsl.eof)
  Lanl=rsl("ChinaQJ_Language_File")
  MagazineName=rs("MagazineName"&Lanl)
  ViewFlag=rs("ViewFlag"&Lanl)
  CommendFlag=rs("CommendFlag"&Lanl)
  execute("MagazineName"&Lanl&"=MagazineName")
  execute("ViewFlag"&Lanl&"=ViewFlag")
  execute("CommendFlag"&Lanl&"=CommendFlag")
rsl.movenext
wend
rsl.close
set rsl=nothing
      SeoKeywords=rs("SeoKeywords")
      SeoDescription=rs("SeoDescription")
	  SortName=SortText(rs("SortID"))
	  SortID=rs("SortID")
	  SortPath=rs("SortPath")
	  MagazineImage=rs("MagazineImage")
	  MagazineDown=rs("MagazineDown")
	  Sequence=rs("Sequence")
	  TitleColor=rs("TitleColor")
	  OtherPic=rs("OtherPic")
	  If OtherPic<>"" Then
	  OtherPic=split(OtherPic,"*")
	  end if
	  rs.close
      set rs=nothing
    end if
  end if
end sub

Function SortText(ID)
  Dim rs,sql
  Set rs=server.CreateObject("adodb.recordset")
  sql="Select * From ChinaQJ_MagazineSort where ID="&ID
  rs.open sql,conn,1,1
  SortText=rs("SortNameCh")
  rs.close
  set rs=nothing
End Function

Function modxmlfile()
'生成所有电子杂志XML文件
set rs=server.createobject("adodb.recordset")
sql="select * from ChinaQJ_Magazine where id="&id
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
end function
%>