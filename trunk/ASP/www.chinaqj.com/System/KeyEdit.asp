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
  <form name="editForm" method="post" action="KeyEdit.asp?Action=SaveEdit&Result=<%=Result%>&ID=<%=ID%>">
    <tr>
      <th height="22" colspan="2" sytle="line-height:150%">【批量添加长尾关键字】</th>
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
    <tr height="28">
      <td width="20%" align="right" class="forumRow"><%=rs("ChinaQJ_Language_Name")%>所属创意：</td>
      <td width="80%" class="forumRowHighlight">
      <select name="KeyName<%=rs("ChinaQJ_Language_File")%>">
	  <% 
      set rs1 = server.createobject("adodb.recordset")
      sql1="select * from ChinaQJ_KeyIdea order by id"
      rs1.open sql1,conn,1,1
	  if rs1.bof and rs1.eof then
	  Response.Write"<option value='0'>无创意内容</option>"
	  else
      do
      %>
      <option value='<%= rs1("id") %>'><%= rs1("KeyIdeaName"&rs("ChinaQJ_Language_File")) %></option>
	  <% 
      rs1.movenext
      loop until rs1.eof
	  end if
      rs1.close
      set rs1=nothing
      %>
      </select></td>
    </tr>
    <tr height="28">
      <td align="right" class="forumRowA"><%=rs("ChinaQJ_Language_Name")%>关键字：<br />
      <font color="#cc0000">多个关键字以"回车"换行</font></td>
      <td class="forumRowHighlight"><textarea name="Content<%=rs("ChinaQJ_Language_File")%>" id="Content<%=rs("ChinaQJ_Language_File")%>" style="width: 85%; height: 200px;"></textarea></td>
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
    <tr height="28">
      <td class="forumRow"></td>
      <td class="forumRowHighlight"><font color="#cc0000">注：建议仔细根据企业产品、所需优化的目标关键字、所针对的目标人群精心挑选所需优化关键字，以达到最佳优化效果。也可以联系客服根据行业和产品为您推荐专业关键字供选择使用。</font></td>
    </tr>
  </form>
</table>
<%
sub NewsEdit()
  dim Action,rsRepeat,rs,sql
  Action=request.QueryString("Action")
  if Action="SaveEdit" then
    set rs = server.createobject("adodb.recordset")
    if trim(request.Form("KeyNameCh"))="0" then
      response.write ("<script language='javascript'>alert('请先添加创意关键词！');history.back(-1);</script>")
      response.end
    end if
    if trim(request.Form("ContentCh"))="" then
      response.write ("<script language='javascript'>alert('请填写关键词！');history.back(-1);</script>")
      response.end
    end if

    if Result="Add" then
	'开始多语言循环保存数据
	set rs2 = server.createobject("adodb.recordset")
	sql2="select * from ChinaQJ_Language order by ChinaQJ_Language_Order"
	rs2.open sql2,conn,1,1
	while(not rs2.eof)
	  if trim(Request.Form("Content"&rs2("ChinaQJ_Language_File")))<>"" then
	  Contenti=Replace(trim(Request.Form("Content"&rs2("ChinaQJ_Language_File"))),chr(13),"-|")
	  Contentis=Split(Contenti,"-|")
	  for i=0 to ubound(Contentis)
		set rs = server.createobject("adodb.recordset")
		sql="select * from ChinaQJ_Key"
		rs.open sql,conn,1,3
		rs.addnew
		rs("ViewFlag")=rs2("ChinaQJ_Language_File")
		rs("KeyName")=Trim(Request.Form("KeyName"&rs2("ChinaQJ_Language_File")))
		rs("Content")=Trim(Contentis(i))
		rs.update
		rs.close
		set rs=Nothing
	  next
	  end if
	rs2.movenext
	wend
	rs2.close
	set rs2=nothing
	'结束多语言循环保存数据
	end if
	response.write "<script language='javascript'>alert('设置成功！');location.replace('keyList.asp');</script>"
  end if
end sub
%>