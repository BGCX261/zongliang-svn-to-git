<!--#include file="../Include/Const.asp" -->
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
           +'<td width="3"><td><input type="text" name="HexColor" size="7" style="border: inset 1px; font-family: Arial;" value="#000000">&nbsp;&nbsp;&nbsp;&nbsp;<a href="http://www.ChinaQJ.com" target="_blank">选色板</a></td></tr></table></td></table>'
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
<script language="javascript" type="text/javascript" src="../DatePicker/WdatePicker.js"></script>
<script language="javascript">
<!--
function showUploadDialog(s_Type, s_Link, s_Thumbnail){
    var arr = showModalDialog("eWebEditor/dialog/i_upload.htm?style=coolblue&type="+s_Type+"&link="+s_Link+"&thumbnail="+s_Thumbnail, window, "dialogWidth: 0px; dialogHeight: 0px; help: no; scroll: no; status: no");
}
//-->
</script>
<%
if Instr(session("AdminPurview"),"|8,")=0 then
  response.write ("<br /><br /><div align=""center""><font style=""color:red; font-size:9pt; "")>您没有管理该模块的权限！</font></div>")
  response.end
end if
dim Result
Result=request.QueryString("Result")
dim ID,SortName,SortID,SortPath,TitleColor,Sequence,VideoImage,VideoUrl
ID=request.QueryString("ID")
Language = "Ch"
call ImageEdit()
call SiteInfo
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
  <form name="editForm" method="post" action="VideoEdit.asp?Action=SaveEdit&Result=<%=Result%>&ID=<%=ID%>">
    <tr>
      <th height="22" colspan="2" sytle="line-height:150%">【<%If Result = "Add" then%>添加<%ElseIf Result = "Modify" then%>修改<%End If%>新闻】</th>
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
      <td width="80%" class="forumRowHighlight"><input name="VideoName<%= rs("ChinaQJ_Language_File") %>" type="text" id="VideoName<%= rs("ChinaQJ_Language_File") %>" style="width: 280" value="<%=eval("VideoName"&rs("ChinaQJ_Language_File"))%>" maxlength="100">
        显示：<input name="ViewFlag<%= rs("ChinaQJ_Language_File") %>" type="checkbox" value="1" <%if eval("ViewFlag"&rs("ChinaQJ_Language_File")) then response.write ("checked")%>></td>
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
      <td align="right" class="forumRow" width="200">标题颜色：</td>
      <td class="forumRowHighlight"><input name="TitleColor" id="TitleColor" type="text" value="" style="background-color:<%= TitleColor %>" size="7">
      <img src="Images/tm.gif"  width="20" height="20"  align="absmiddle" style="background-color:<%= TitleColor %>" onClick="colorcd('editForm','TitleColor','ChinaQJ')" onMouseOver="this.style.cursor='hand'"> <font id="ChinaQJ" color="<%= TitleColor %>">秦江陶瓷</font></td>
    </tr>
    <tr height="35">
      <td align="right" class="forumRow">所属类别：</td>
      <td class="forumRowHighlight"><input name="SortID" type="text" id="SortID" style="width: 18; background-color:#fffff0" value="<%=SortID%>" readonly> <input name="SortPath" type="text" id="SortPath" style="width: 70; background-color:#fffff0" value="<%=SortPath%>" readonly> <input name="SortName" type="text" id="SortName" value="<%=SortName%>" style="width: 180; background-color:#fffff0" readonly> <a href="javaScript:OpenScript('SelectSort.asp?Result=Video',500,500,'')">选择类别</a> <font color="red">*</font></td>
    </tr>
    <tr height="28">
      <td width="200" class="forumRow">缩 略 图：</td>
      <td class="forumRowHighlight"><input name="VideoImage" type="text" id="VideoImage" style="width: 300px;" value="<%= VideoImage %>" maxlength="100">
        <input type="button" value="上传图片" onclick="showUploadDialog('image', 'editForm.VideoImage', '')">
        <font color="red">*</font></td>
    </tr>
    <tr height="28">
      <td class="forumRow">视频地址：</td>
      <td class="forumRowHighlight"><input name="VideoUrl" type="text" style="width: 300px;" value="<%= VideoUrl %>" maxlength="250">
        <input type="button" value="上传视频" onclick="showUploadDialog('media', 'editForm.VideoUrl', '')">
        <font color="red">* 同时支持站外视频地址</font>
        <br />
        支持格式：AVI、MOV、MPG、MPEG、WMV、MP3、WAV、WMA、SWF</td>
    </tr>
    <tr height="28">
      <td class="forumRow" align="right">排序：</td>
      <% If Sequence="" Then Sequence=999 %>
      <td class="forumRowHighlight"><input name="Sequence" type="text" id="Sequence" style="width: 50px;" value="<%= Sequence %>" maxlength="10"></td>
    </tr>
    <tr height="35">
      <td align="right" class="forumRow">自定义发布时间：</td>
      <% if addTime="" then AddTime=Now() %>
      <td class="forumRowHighlight"><input name="AddTime" type="text" id="AddTime" style="width: 120px;" value="<%= AddTime %>" onFocus="WdatePicker({startDate:'%y-%M-%d  %H:%m:%s',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" readonly> <font color="red">默认为当前时间，如需要修改发布时间，请点击文本框选择新时间。留空默认为当前时间。</font></td>
    </tr>
    <tr height="35">
      <td align="right" class="forumRow"></td>
      <td class="forumRowHighlight"><input name="submitSaveEdit" type="submit" id="submitSaveEdit" value="保存"> <input type="button" value="返回上一页" onclick="history.back(-1)"></td>
    </tr>
  </form>
</table>
<%
sub ImageEdit()
  dim Action,rsRepeat,rs,sql
  Action=request.QueryString("Action")
  if Action="SaveEdit" then
    set rs = server.createobject("adodb.recordset")
    if len(trim(request.Form("VideoNameCh")))<3 then
      response.write ("<script language='javascript'>alert('请填写视频名称！');history.back(-1);</script>")
      response.end
    end if
    if request.Form("VideoImage")="" then
      response.write ("<script language='javascript'>alert('请填写视频缩略图！');history.back(-1);</script>")
      response.end
    end if
    if request.Form("VideoUrl")="" then
      response.write ("<script language='javascript'>alert('请填写视频地址！');history.back(-1);</script>")
      response.end
    end if
    if Result="Add" then
	  sql="select * from ChinaQJ_Video"
      rs.open sql,conn,1,3
      rs.addnew
  '多语言循环保存数据
set rsl = server.createobject("adodb.recordset")
sqll="select * from ChinaQJ_Language order by ChinaQJ_Language_Order"
rsl.open sqll,conn,1,1
while(not rsl.eof)
  rs("VideoName"&rsl("ChinaQJ_Language_File"))=trim(Request.Form("VideoName"&rsl("ChinaQJ_Language_File")))
  if Request.Form("ViewFlag"&rsl("ChinaQJ_Language_File"))=1 then
	rs("ViewFlag"&rsl("ChinaQJ_Language_File"))=Request.Form("ViewFlag"&rsl("ChinaQJ_Language_File"))
  else
	rs("ViewFlag"&rsl("ChinaQJ_Language_File"))=0
  end if
rsl.movenext
wend
rsl.close
set rsl=nothing
	  rs("VideoImage")=trim(Request.Form("VideoImage"))
	  rs("VideoUrl")=trim(Request.Form("VideoUrl"))
	  rs("Sequence")=trim(Request.Form("Sequence"))
	  rs("TitleColor")=trim(Request.Form("TitleColor"))
	  if Request.Form("SortID")="" and Request.Form("SortPath")="" then
        response.write ("<script language='javascript'>alert('请选择所属分类！');history.back(-1);</script>")
        response.end
	  else
	    rs("SortID")=Request.Form("SortID")
		rs("SortPath")=Request.Form("SortPath")
	  end if
	  rs("AddTime")=now()
	  rs("UpdateTime")=now()
	  if PubRndDisplay=1 then
	  rs("ClickNumber")=Rnd_ClickNumber(PubRndNumStart,PubRndNumEnd)
	  else
	  rs("ClickNumber")=0
	  end if
	  rs.update
	  rs.close
	  set rs=Nothing
	end if
	if Result="Modify" then
      sql="select * from ChinaQJ_Video where ID="&ID
      rs.open sql,conn,1,3
  '多语言循环保存数据
set rsl = server.createobject("adodb.recordset")
sqll="select * from ChinaQJ_Language order by ChinaQJ_Language_Order"
rsl.open sqll,conn,1,1
while(not rsl.eof)
  rs("VideoName"&rsl("ChinaQJ_Language_File"))=trim(Request.Form("VideoName"&rsl("ChinaQJ_Language_File")))
  if Request.Form("ViewFlag"&rsl("ChinaQJ_Language_File"))=1 then
	rs("ViewFlag"&rsl("ChinaQJ_Language_File"))=Request.Form("ViewFlag"&rsl("ChinaQJ_Language_File"))
  else
	rs("ViewFlag"&rsl("ChinaQJ_Language_File"))=0
  end if
rsl.movenext
wend
rsl.close
set rsl=nothing
	  rs("VideoImage")=trim(Request.Form("VideoImage"))
	  rs("VideoUrl")=trim(Request.Form("VideoUrl"))
	  rs("Sequence")=trim(Request.Form("Sequence"))
	  rs("TitleColor")=trim(Request.Form("TitleColor"))
	  if Request.Form("SortID")="" and Request.Form("SortPath")="" then
        response.write ("<script language='javascript'>alert('请选择所属分类！');history.back(-1);</script>")
        response.end
	  else
	    rs("SortID")=Request.Form("SortID")
		rs("SortPath")=Request.Form("SortPath")
	  end if
	  rs("UpdateTime")=now()
	  rs.update
	  rs.close
	  set rs=Nothing
	 end if
	  response.write "<script language='javascript'>alert('设置成功！');location.replace('VideoList.asp');</script>"
  else
	if Result="Modify" then
      set rs = server.createobject("adodb.recordset")
      sql="select * from ChinaQJ_Video where ID="& ID
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
  VideoName=rs("VideoName"&Lanl)
  ViewFlag=rs("ViewFlag"&Lanl)
  execute("VideoName"&Lanl&"=VideoName")
  execute("ViewFlag"&Lanl&"=ViewFlag")
rsl.movenext
wend
rsl.close
set rsl=nothing
	  SortName=SortText(rs("SortID"))
	  SortID=rs("SortID")
	  SortPath=rs("SortPath")
	  VideoImage=rs("VideoImage")
	  VideoUrl=rs("VideoUrl")
	  TitleColor=rs("TitleColor")
	  Sequence=rs("Sequence")
	  rs.close
      set rs=nothing
    end if
  end if
end sub

Function SortText(ID)
  Dim rs,sql
  Set rs=server.CreateObject("adodb.recordset")
  sql="Select * From ChinaQJ_VideoSort where ID="&ID
  rs.open sql,conn,1,1
  SortText=rs("SortNameCh")
  rs.close
  set rs=nothing
End Function
%>