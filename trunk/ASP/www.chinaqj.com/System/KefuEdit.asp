<!--#include file="../Include/Const.asp" -->
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
    +'<td width="3"><td><input type="text" name="HexColor" size="7" style="border: inset 1px; font-family: Arial;" value="#000000">&nbsp;&nbsp;&nbsp;&nbsp;<a href="http://www.chinaqj.com" target="_blank">系统选色版</a></td></tr></table></td></table>'
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
<script language="javascript" src="JavaScript/Tab.js"></script>
<%
dim Result
Result=request.QueryString("Result")
dim ID,KefuNameCh,KefuNameEn,KefuNameJp,ViewFlagCh,ViewFlagEn,ViewFlagJp
dim KefuQQ,KefuMSN,KefuSkype,Sequence,AddTime
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
  <form name="editForm" method="post" action="KefuEdit.Asp?Action=SaveEdit&Result=<%= Result %>&ID=<%= ID %>">
    <tr>
      <th height="28" colspan="2" sytle="line-height: 150%;">【添加在线客服】</th>
    </tr>
    <tr height="28">
      <td colspan="2">
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
              <td width="200" class="forumRowA"><%=rs("ChinaQJ_Language_Name")%>客服名称：</td>
              <td class="forumRowHighlight"><input name="KefuName<%= rs("ChinaQJ_Language_File") %>" type="text" id="KefuName<%= rs("ChinaQJ_Language_File") %>" value="<%=eval("KefuName"&rs("ChinaQJ_Language_File"))%>" size="28" maxlength="100">
              显示：<input name="ViewFlag<%= rs("ChinaQJ_Language_File") %>" type="checkbox" value="1" <%if eval("ViewFlag"&rs("ChinaQJ_Language_File")) then response.write ("checked")%>>
                <font color="red">*</font></td>
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
        <script>showtabcontent("tablist")</script></td>
    </tr>
    <tr height="28">
      <td width="200" class="forumRow">QQ号码：</td>
      <td class="forumRowHighlight"><input name="KefuQQ" id="KefuQQ" type="text" value="<%= KefuQQ %>" size="28"></td>
    </tr>
    <tr height="28">
      <td width="200" class="forumRow">MSN帐号：</td>
      <td class="forumRowHighlight"><input name="KefuMSN" id="KefuMSN" type="text" value="<%= KefuMSN %>" size="28"></td>
    </tr>
    <tr height="28">
      <td width="200" class="forumRow">Skype帐号：</td>
      <td class="forumRowHighlight"><input name="KefuSkype" id="KefuSkype" type="text" value="<%= KefuSkype %>" size="28"></td>
    </tr>
    <tr height="28">
      <td class="forumRow">排序：</td>
      <% if Sequence="" then Sequence=0 %>
      <td class="forumRowHighlight"><input name="Sequence" type="text" id="Sequence" style="width: 50px;" value="<%= Sequence %>" maxlength="10"></td>
    </tr>
    <tr height="28">
      <td class="forumRow">自定义发布时间：</td>
      <% if AddTime="" then AddTime=now() %>
      <td class="forumRowHighlight"><input name="AddTime" type="text" id="AddTime" style="width: 120px;" value="<%= AddTime %>" onFocus="WdatePicker({startDate:'%y-%M-%d  %H:%m:%s',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" readonly>
        <font color="red">默认为当前时间，如需要修改发布时间，请点击文本框选择新时间。留空默认为当前时间。</font></td>
    </tr>
    <tr height="28">
      <td class="forumRow"></td>
      <td class="forumRowHighlight"><input name="submitSaveEdit" type="submit" id="submitSaveEdit" value="保存设置">
        <input type="button" value="返回上一页" onclick="history.back(-1)"></td>
    </tr>
  </form>
</table>
<br />
<%
sub NewsEdit()
  dim Action,rsRepeat,rs,sql
  Action=request.QueryString("Action")
  if Action="SaveEdit" then
    set rs = server.createobject("adodb.recordset")
    if trim(request.Form("KefuNameCh"))="" then
      response.write ("<script language='javascript'>alert('请填写客服名称！');history.back(-1);</script>")
      response.end
    end if
    if trim(request.Form("KefuQQ"))="" then
      response.write ("<script language='javascript'>alert('请填写客服QQ号码！');history.back(-1);</script>")
      response.end
    end if
    if Result="Add" then
	  sql="select * from ChinaQJ_Kefu"
      rs.open sql,conn,1,3
      rs.addnew
  '多语言循环保存数据
set rsl = server.createobject("adodb.recordset")
sqll="select * from ChinaQJ_Language order by ChinaQJ_Language_Order"
rsl.open sqll,conn,1,1
while(not rsl.eof)
  rs("KefuName"&rsl("ChinaQJ_Language_File"))=trim(Request.Form("KefuName"&rsl("ChinaQJ_Language_File")))
  if Request.Form("ViewFlag"&rsl("ChinaQJ_Language_File"))=1 then
	rs("ViewFlag"&rsl("ChinaQJ_Language_File"))=Request.Form("ViewFlag"&rsl("ChinaQJ_Language_File"))
  else
	rs("ViewFlag"&rsl("ChinaQJ_Language_File"))=0
  end if
rsl.movenext
wend
rsl.close
set rsl=nothing
      rs("KefuQQ")=trim(Request.Form("KefuQQ"))
      rs("KefuMSN")=trim(Request.Form("KefuMSN"))
      rs("KefuSkype")=trim(Request.Form("KefuSkype"))
      rs("Sequence")=trim(Request.Form("Sequence"))
      rs("AddTime")=trim(Request.Form("AddTime"))
	  rs.update
	  rs.close
	  set rs=Nothing
	end if
	if Result="Modify" then
      sql="select * from ChinaQJ_Kefu where ID="&ID
      rs.open sql,conn,1,3
  '多语言循环保存数据
set rsl = server.createobject("adodb.recordset")
sqll="select * from ChinaQJ_Language order by ChinaQJ_Language_Order"
rsl.open sqll,conn,1,1
while(not rsl.eof)
  rs("KefuName"&rsl("ChinaQJ_Language_File"))=trim(Request.Form("KefuName"&rsl("ChinaQJ_Language_File")))
  if Request.Form("ViewFlag"&rsl("ChinaQJ_Language_File"))=1 then
	rs("ViewFlag"&rsl("ChinaQJ_Language_File"))=Request.Form("ViewFlag"&rsl("ChinaQJ_Language_File"))
  else
	rs("ViewFlag"&rsl("ChinaQJ_Language_File"))=0
  end if
rsl.movenext
wend
rsl.close
set rsl=nothing
      rs("KefuQQ")=trim(Request.Form("KefuQQ"))
      rs("KefuMSN")=trim(Request.Form("KefuMSN"))
      rs("KefuSkype")=trim(Request.Form("KefuSkype"))
      rs("Sequence")=trim(Request.Form("Sequence"))
      rs("AddTime")=trim(Request.Form("AddTime"))
	  rs.update
	  rs.close
	  set rs=Nothing
	end if
	response.write "<script language='javascript'>alert('设置成功！');location.replace('KefuList.asp');</script>"
  else
	if Result="Modify" then
      set rs = server.createobject("adodb.recordset")
      sql="select * from ChinaQJ_Kefu where ID="& ID
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
  KefuName=rs("KefuName"&Lanl)
  ViewFlag=rs("ViewFlag"&Lanl)
  execute("KefuName"&Lanl&"=KefuName")
  execute("ViewFlag"&Lanl&"=ViewFlag")
rsl.movenext
wend
rsl.close
set rsl=nothing
      KefuQQ=rs("KefuQQ")
      KefuMSN=rs("KefuMSN")
      KefuSkype=rs("KefuSkype")
      Sequence=rs("Sequence")
      AddTime=rs("AddTime")
	  rs.close
      set rs=nothing
    end if
  end if
end sub
%>