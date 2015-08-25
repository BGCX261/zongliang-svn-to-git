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
<script language="javascript" src="/Scripts/MyEditObj.js?type=<%=editType%>"></script>
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
dim ID,ContentCh,ContentEn,SeoKeywordsCh,SeoKeywordsEn,SeoDescriptionCh,SeoDescriptionEn
ID=request.QueryString("ID")
Language = "Ch"
call NewsEdit()
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
  <form name="editForm" method="post" action="KeyIdeaEdit.asp?Action=SaveEdit&Result=<%=Result%>&ID=<%=ID%>">
    <tr>
      <th height="22" colspan="2" sytle="line-height:150%">【<%If Result = "Add" then%>添加<%ElseIf Result = "Modify" then%>修改<%End If%>创意内容】</th>
    </tr>
    <tr height="35">
      <td width="20%" align="right" class="forumRow">关键字优化标签：</td>
      <td class="forumRowHighlight">{关键字标签}<br />
      <font color="#cc0000">可在标题、关键字描述、描述文本、详细内页各接口插入该标签，以达到全面的优化页面效果。</font></td>
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
      <td width="80%" class="forumRowHighlight"><input name="KeyIdeaName<%= rs("ChinaQJ_Language_File") %>" type="text" id="KeyIdeaName<%= rs("ChinaQJ_Language_File") %>" style="width: 280" value="<%=eval("KeyIdeaName"&rs("ChinaQJ_Language_File"))%>" maxlength="100">
    </tr>
    <tr height="35">
      <td align="right" class="forumRow">Tags：</td>
      <td class="forumRowHighlight"><input name="TheTags<%= rs("ChinaQJ_Language_File") %>" type="text" id="TheTags<%= rs("ChinaQJ_Language_File") %>" style="width: 500px;" value="<%=eval("TheTags"&rs("ChinaQJ_Language_File"))%>" maxlength="100">
      <br />请用","分隔<br />
      <font color="#CC0000">Tag 标签不仅可以帮助用户很快找到相同主题的文章、产品等，进一步增加用户粘度。<br />
      还可以为您的企业网站带来更佳的优化效果和流量、排名效果。独有海量字库，可以根据您的中文标题<br />
      智能分词，并且您可以对分词效果手工校正、修改，以达到更好的效果。</font></td>
    </tr>
    <tr height="35">
      <td width="20%" align="right" class="forumRow"><%=rs("ChinaQJ_Language_Name")%>MetaKeywords：</td>
      <td width="80%" class="forumRowHighlight"><input name="SeoKeywords<%= rs("ChinaQJ_Language_File") %>" type="text" id="SeoKeywords<%= rs("ChinaQJ_Language_File") %>" style="width: 500" value="<%=eval("SeoKeywords"&rs("ChinaQJ_Language_File"))%>" maxlength="250"></td>
    </tr>
    <tr height="35">
      <td width="20%" align="right" class="forumRow"><%=rs("ChinaQJ_Language_Name")%>MetaDescription：</td>
      <td width="80%" class="forumRowHighlight"><input name="SeoDescription<%= rs("ChinaQJ_Language_File") %>" type="text" id="SeoDescription<%= rs("ChinaQJ_Language_File") %>" style="width: 500" value="<%=eval("SeoDescription"&rs("ChinaQJ_Language_File"))%>" maxlength="250"></td>
    </tr>
    <tr>
      <td align="right" class="forumRow"><%=rs("ChinaQJ_Language_Name")%>内容：</td>
      <td class="forumRowHighlight">
		<div id="div_Con_<%=rs("ChinaQJ_Language_File")%>" style="display:none;"><%= eval("Content" & rs("ChinaQJ_Language_File")) %></div>
		<script>Start_MyEdit("Content<%=rs("ChinaQJ_Language_File")%>","div_Con_<%=rs("ChinaQJ_Language_File")%>");</script>
	  </td>
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
      <td align="right" class="forumRow" width="20%"></td>
      <td class="forumRowHighlight"><input name="submitSaveEdit" type="submit" id="submitSaveEdit" value="保存"> <input type="button" value="返回上一页" onclick="history.back(-1)"></td>
    </tr>
  </form>
</table>
<%
sub NewsEdit()
  dim Action,rsRepeat,rs,sql
  Action=request.QueryString("Action")
  if Action="SaveEdit" then
    set rs = server.createobject("adodb.recordset")
    if len(trim(request.Form("KeyIdeaNameCh")))=0 then
      response.write ("<script language='javascript'>alert('请填写新闻名称！');history.back(-1);</script>")
      response.end
    end if
    if Result="Add" then
	  sql="select * from ChinaQJ_KeyIdea"
      rs.open sql,conn,1,3
      rs.addnew
	  '多语言循环保存数据
	  set rsl = server.createobject("adodb.recordset")
	  sqll="select * from ChinaQJ_Language order by ChinaQJ_Language_Order"
	  rsl.open sqll,conn,1,1
	  while(not rsl.eof)
		rs("KeyIdeaName"&rsl("ChinaQJ_Language_File"))=trim(Request.Form("KeyIdeaName"&rsl("ChinaQJ_Language_File")))
		rs("TheTags"&rsl("ChinaQJ_Language_File"))=trim(Request.Form("TheTags"&rsl("ChinaQJ_Language_File")))
		rs("SeoKeywords"&rsl("ChinaQJ_Language_File"))=trim(Request.Form("SeoKeywords"&rsl("ChinaQJ_Language_File")))
		rs("SeoDescription"&rsl("ChinaQJ_Language_File"))=trim(Request.Form("SeoDescription"&rsl("ChinaQJ_Language_File")))
		rs("Content"&rsl("ChinaQJ_Language_File"))=trim(Request.Form("Content"&rsl("ChinaQJ_Language_File")))
	  rsl.movenext
	  wend
	  rsl.close
	  set rsl=nothing
	  rs.update
	  rs.close
	  set rs=Nothing
	end if
	if Result="Modify" then
      sql="select * from ChinaQJ_KeyIdea where ID="&ID
      rs.open sql,conn,1,3
	  '多语言循环保存数据
	  set rsl = server.createobject("adodb.recordset")
	  sqll="select * from ChinaQJ_Language order by ChinaQJ_Language_Order"
	  rsl.open sqll,conn,1,1
	  while(not rsl.eof)
		rs("KeyIdeaName"&rsl("ChinaQJ_Language_File"))=trim(Request.Form("KeyIdeaName"&rsl("ChinaQJ_Language_File")))
		rs("TheTags"&rsl("ChinaQJ_Language_File"))=trim(Request.Form("TheTags"&rsl("ChinaQJ_Language_File")))
		rs("SeoKeywords"&rsl("ChinaQJ_Language_File"))=trim(Request.Form("SeoKeywords"&rsl("ChinaQJ_Language_File")))
		rs("SeoDescription"&rsl("ChinaQJ_Language_File"))=trim(Request.Form("SeoDescription"&rsl("ChinaQJ_Language_File")))
		rs("Content"&rsl("ChinaQJ_Language_File"))=trim(Request.Form("Content"&rsl("ChinaQJ_Language_File")))
	  rsl.movenext
	  wend
	  rsl.close
	  set rsl=nothing
	  rs.update
	  rs.close
	  set rs=Nothing
	end if
	response.write "<script language='javascript'>alert('设置成功！');location.replace('KeyideaList.asp');</script>"
  else
	if Result="Modify" then
      set rs = server.createobject("adodb.recordset")
      sql="select * from ChinaQJ_KeyIdea where ID="& ID
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
		KeyIdeaName=rs("KeyIdeaName"&Lanl)
		TheTags=rs("TheTags"&Lanl)
		SeoKeywords=rs("SeoKeywords"&Lanl)
		SeoDescription=rs("SeoDescription"&Lanl)
		Content=rs("Content"&Lanl)
		if content="" then content=""
		execute("KeyIdeaName"&Lanl&"=KeyIdeaName")
		execute("TheTags"&Lanl&"=TheTags")
		execute("SeoKeywords"&Lanl&"=SeoKeywords")
		execute("SeoDescription"&Lanl&"=SeoDescription")
		execute("Content"&Lanl&"=Content")
	  rsl.movenext
	  wend
	  rsl.close
	  set rsl=nothing
	  rs.close
      set rs=nothing
    end if
  end if
end sub
%>