<!--#include file="../Include/Const.asp" -->
<!--#include file="../Include/ConnSiteData.asp" -->
<!--#include file="CheckAdmin.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%
if Instr(session("AdminPurview"),"|2,")=0 then
  response.write ("<br /><br /><div align=""center""><font style=""color:red; font-size:9pt; "")>您没有管理该模块的权限！</font></div>")
  response.end
end If
dim Result
Result=request.QueryString("Result")
dim ID,NavNameCh,NavNameEn,ViewFlagCh,ViewFlagEn,NavUrl,HtmlNavUrl,OutFlag,Remark,TitleColor,IndexViewEn,IndexViewCh,ParentID,sortpath
ID=request.QueryString("ID")
call NavEdit()
%>
<link rel="stylesheet" href="Images/Admin_style.css">
<script language="javascript" src="../Scripts/Admin.js"></script>
<script language="javascript" src="JavaScript/Tab.js"></script>
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
<br />
<table class="tableBorder" width="95%" border="0" align="center" cellpadding="0" cellspacing="1">
<form name="editForm" method="post" action="NavigationEdit.asp?Action=SaveEdit&Result=<%=Result%>&ID=<%=ID%>">
  <tr>
    <th height="22" colspan="2" sytle="line-height:150%">【<%If Result = "Add" then%>添加<%ElseIf Result = "Modify" then%>修改<%End If%>导航】</th>
  </tr>
  <tr><td colspan="2">
<% 
set rs = server.createobject("adodb.recordset")
sql="select * from ChinaQJ_Language order by ChinaQJ_Language_Order"
rs.open sql,conn,1,1
lani=1
while(not rs.eof)
%>
<div id="tcontent<%= lani %>" class="tabcontent">
<table class="tableborderOther" width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr height="35">
    <td width="20%" align="right" class="forumRow"><%=rs("ChinaQJ_Language_Name")%>标题：</td>
    <td width="80%" class="forumRowHighlight"><input name="NavName<%= rs("ChinaQJ_Language_File") %>" type="text" id="NavName<%= rs("ChinaQJ_Language_File") %>" style="width: 200" value="<%=eval("NavName"&rs("ChinaQJ_Language_File"))%>" maxlength="100"> 显示：<input name="ViewFlag<%= rs("ChinaQJ_Language_File") %>" type="checkbox" value="1" <%if eval("ViewFlag"&rs("ChinaQJ_Language_File")) then response.write ("checked")%>> 显示在首页快速导航：<input name="IndexView<%= rs("ChinaQJ_Language_File") %>" type="checkbox" value="1" <%if eval("IndexView"&rs("ChinaQJ_Language_File")) then response.write ("checked")%>><font color="red">*</font></td>
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
    <td align="right" class="forumRow">标题颜色：</td>
    <td class="forumRowHighlight"><input name="TitleColor" id="TitleColor" type="text" value="<%= TitleColor %>" style="background-color:<%= TitleColor %>" size="7">
      <img src="Images/tm.gif"  width="20" height="20"  align="absmiddle" style="background-color:<%= TitleColor %>" onClick="colorcd('editForm','TitleColor','ChinaQJ')" onMouseOver="this.style.cursor='hand'"> <font id="ChinaQJ" color="<%= TitleColor %>">秦江陶瓷</font></td>
  </tr>
  <tr height="35">
    <td align="right" class="forumRow">动态页链接网址：</td>
    <td class="forumRowHighlight"><input name="NavUrl" type="text" id="NavUrl" style="width: 500" value="<%=NavUrl%>"> <font color="red">*</font></td>
  </tr>
  <tr height="35">
    <td align="right" class="forumRow">静态页链接网址：</td>
    <td class="forumRowHighlight"><input name="HtmlNavUrl" type="text" id="HtmlNavUrl" style="width: 500" value="<%=HtmlNavUrl%>"> <font color="red">*</font></td>
  </tr>
  <tr height="35">
    <td width="20%" align="right" class="forumRow">链接状态：</td>
    <td width="80%" class="forumRowHighlight"><input name="OutFlag" type="checkbox" value="1" <%if OutFlag then response.write ("checked")%>>外部链接</td>
  </tr>
  <tr height="28">
    <td align="right" class="forumRow">类别：</td>
    <td class="forumRowHighlight">
    <select name="SortPath" style="width: 180">
    <option value="0┎╂┚0,">主导航栏</option>
<%
set rs = server.createobject("adodb.recordset")
sql="select * from ChinaQJ_Navigation where ParentID=0 order by Sequence"
rs.open sql,conn,1,1
if rs.bof and rs.eof then
  response.write("")
else
do while not rs.eof
%>
    <option value="<%= rs("ID") %>┎╂┚<%= rs("SortPath") %>" <% If ParentID=rs("ID") Then Response.Write("selected")%>>　<%= rs("NavNameCh") %>&nbsp;|&nbsp;<%= rs("NavNameEn") %></option>
<%
rs.movenext
loop
end if
rs.close
set rs=nothing
%>
    </select>
    </td>
  </tr>
  <tr height="35">
    <td align="right" class="forumRow">备注：</td>
    <td class="forumRowHighlight"><textarea name="Remark" rows="8" id="Remark" style="width: 500"><%=Remark%></textarea></td>
  </tr>
  <tr height="35">
    <td width="20%" align="right" class="forumRow"></td>
    <td width="80%" class="forumRowHighlight"><input name="submitSaveEdit" type="submit" id="submitSaveEdit" value="保存"> <input type="button" value="返回上一页" onclick="history.back(-1)"></td>
  </tr>
  </form>
</table>
<%
sub NavEdit()
  dim Action,rsCheckAdd,rs,sql
  Action=request.QueryString("Action")
  if Action="SaveEdit" then
    set rs = server.createobject("adodb.recordset")
    if len(trim(request.Form("NavNameCh")))<2 then
		response.write ("<script language='javascript'>alert('请填写导航名称并保持至少在一个汉字以上！');history.back(-1);</script>")
		response.end
    end If
    if len(trim(request.Form("NavNameEn")))<2 then
		response.write ("<script language='javascript'>alert('请填写导航名称并保持至少在一个单词以上！');history.back(-1);</script>")
		response.end
    end If
	If trim(Request.Form("NavNameCh")) = ""  Or trim(Request.Form("NavUrl")) = ""  Or trim(Request.Form("HtmlNavUrl")) = "" Then
		response.write ("<script language='javascript'>alert('请填写导航名称和链接网址！');history.back(-1);</script>")
		response.end
	End If
    if Result="Add" Then
	  sql="select * from ChinaQJ_Navigation"
      rs.open sql,conn,1,3
      rs.addnew
	  
  '多语言循环保存数据
set rsl = server.createobject("adodb.recordset")
sqll="select * from ChinaQJ_Language order by ChinaQJ_Language_Order"
rsl.open sqll,conn,1,1
while(not rsl.eof)
  rs("NavName"&rsl("ChinaQJ_Language_File"))=trim(Request.Form("NavName"&rsl("ChinaQJ_Language_File")))
  if Request.Form("IndexView"&rsl("ChinaQJ_Language_File"))=1 then
	rs("IndexView"&rsl("ChinaQJ_Language_File"))=Request.Form("IndexView"&rsl("ChinaQJ_Language_File"))
  else
	rs("IndexView"&rsl("ChinaQJ_Language_File"))=0
  end if
  if Request.Form("ViewFlag"&rsl("ChinaQJ_Language_File"))=1 then
	rs("ViewFlag"&rsl("ChinaQJ_Language_File"))=Request.Form("ViewFlag"&rsl("ChinaQJ_Language_File"))
  else
	rs("ViewFlag"&rsl("ChinaQJ_Language_File"))=0
  end if
rsl.movenext
wend
rsl.close
set rsl=nothing
	  
      rs("NavUrl")=trim(Request.Form("NavUrl"))
	  rs("HtmlNavUrl")=trim(Request.Form("HtmlNavUrl"))
	  rs("TitleColor")=trim(Request.Form("TitleColor"))
	  if Request.Form("OutFlag")=1 then
        rs("OutFlag")=Request.Form("OutFlag")
	  else
        rs("OutFlag")=0
	  end if
	  rs("Remark")=trim(Request.Form("Remark"))
	  SortPath1=Split(trim(Request.Form("SortPath")),"┎╂┚")
	  rs("ParentID")=SortPath1(0)
	  rs("SortPath")=SortPath1(1) & rs("ID")
	  rs("Sequence")=99
	  rs("AddTime")=now()
	end if
	if Result="Modify" Then
      sql="select * from ChinaQJ_Navigation where ID="&ID
      rs.open sql,conn,1,3
  '多语言循环保存数据
set rsl = server.createobject("adodb.recordset")
sqll="select * from ChinaQJ_Language order by ChinaQJ_Language_Order"
rsl.open sqll,conn,1,1
while(not rsl.eof)
  rs("NavName"&rsl("ChinaQJ_Language_File"))=trim(Request.Form("NavName"&rsl("ChinaQJ_Language_File")))
  if Request.Form("IndexView"&rsl("ChinaQJ_Language_File"))=1 then
	rs("IndexView"&rsl("ChinaQJ_Language_File"))=Request.Form("IndexView"&rsl("ChinaQJ_Language_File"))
  else
	rs("IndexView"&rsl("ChinaQJ_Language_File"))=0
  end if
  if Request.Form("ViewFlag"&rsl("ChinaQJ_Language_File"))=1 then
	rs("ViewFlag"&rsl("ChinaQJ_Language_File"))=Request.Form("ViewFlag"&rsl("ChinaQJ_Language_File"))
  else
	rs("ViewFlag"&rsl("ChinaQJ_Language_File"))=0
  end if
rsl.movenext
wend
rsl.close
set rsl=nothing
      rs("NavUrl")=trim(Request.Form("NavUrl"))
	  rs("HtmlNavUrl")=trim(Request.Form("HtmlNavUrl"))
	  rs("TitleColor")=trim(Request.Form("TitleColor"))
	  if Request.Form("OutFlag")=1 then
        rs("OutFlag")=Request.Form("OutFlag")
	  else
        rs("OutFlag")=0
	  end if
	  rs("Remark")=trim(Request.Form("Remark"))
	  SortPath1=Split(trim(Request.Form("SortPath")),"┎╂┚")
	  rs("ParentID")=SortPath1(0)
	  rs("SortPath")=SortPath1(1) & rs("ID")
	end if
	rs.update
	rs.close
    set rs=nothing
    response.write "<script language='javascript'>alert('设置成功！');location.replace('NavigationList.asp');</script>"
  else
	if Result="Modify" then
      set rs = server.createobject("adodb.recordset")
      sql="select * from ChinaQJ_Navigation where ID="& ID
      rs.open sql,conn,1,1
  '多语言循环拾取数据
set rsl = server.createobject("adodb.recordset")
sqll="select * from ChinaQJ_Language order by ChinaQJ_Language_Order"
rsl.open sqll,conn,1,1
while(not rsl.eof)
  Lanl=rsl("ChinaQJ_Language_File")
  NavName=rs("NavName"&Lanl)
  ViewFlag=rs("ViewFlag"&Lanl)
  IndexView=rs("IndexView"&Lanl)
  execute("NavName"&Lanl&"=NavName")
  execute("ViewFlag"&Lanl&"=ViewFlag")
  execute("IndexView"&Lanl&"=IndexView")
rsl.movenext
wend
rsl.close
set rsl=nothing
	  TitleColor=rs("TitleColor")
      Remark=rs("Remark")
	  OutFlag=rs("OutFlag")
      NavUrl=rs("NavUrl")
	  HtmlNavUrl=rs("HtmlNavUrl")
	  SortPath=rs("SortPath")
	  ParentID=rs("ParentID")
	  rs.close
      set rs=nothing
	end if
  end if
end sub
%>