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
dim ID,NewsNameCh,NewsNameEn,ClassSeo,ViewFlagCh,ViewFlagEn,SortName,SortID,SortPath,TitleColor,ChinaQJPic
dim GroupID,GroupIdName,Exclusive,NoticeFlag,SourceCh,SourceEn,ContentCh,ContentEn,SeoKeywordsCh,SeoKeywordsEn,SeoDescriptionCh,SeoDescriptionEn
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
  <form name="editForm" method="post" action="NewsEdit.asp?Action=SaveEdit&Result=<%=Result%>&ID=<%=ID%>">
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
      <td width="80%" class="forumRowHighlight"><input name="NewsName<%= rs("ChinaQJ_Language_File") %>" type="text" id="NewsName<%= rs("ChinaQJ_Language_File") %>" style="width: 280" value="<%=eval("NewsName"&rs("ChinaQJ_Language_File"))%>" maxlength="100">
        显示：<input name="ViewFlag<%= rs("ChinaQJ_Language_File") %>" type="checkbox" value="1" <%if eval("ViewFlag"&rs("ChinaQJ_Language_File")) then response.write ("checked")%>></td>
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
      <td align="right" class="forumRow" width="200">标题颜色：</td>
      <td class="forumRowHighlight"><input name="TitleColor" id="TitleColor" type="text" value="" style="background-color:<%= TitleColor %>" size="7">
      <img src="Images/tm.gif"  width="20" height="20"  align="absmiddle" style="background-color:<%= TitleColor %>" onClick="colorcd('editForm','TitleColor','ChinaQJ')" onMouseOver="this.style.cursor='hand'"> <font id="ChinaQJ" color="<%= TitleColor %>">秦江陶瓷</font></td>
    </tr>
    <tr height="35">
      <td align="right" class="forumRow">图片：</td>
      <td class="forumRowHighlight"><input name="ChinaQJPic" type="text" id="ChinaQJPic" style="width: 300" value="<%= ChinaQJPic %>" maxlength="100"> <input type="button" value="上传图片" onclick="showUploadDialog('image', 'editForm.ChinaQJPic', '')"></td>
    </tr>
    <tr height="35">
      <td class="forumRow" align="right">静态文件名：</td>
      <td class="forumRowHighlight"><input name="ClassSeo" type="text" id="ClassSeo" style="width: 500" value="<%= ClassSeo %>" maxlength="100"><br /><input name="oAutopinyin" type="checkbox" id="oAutopinyin" value="Yes" <%If ClassSeoISPY = 1 Then%>checked<%end if%>><font color="red">将标题转换为拼音（已填写“静态文件名”则该功能无效）</font></td>
    </tr>
    <tr height="35">
      <td align="right" class="forumRow">新闻类别：</td>
      <td class="forumRowHighlight"><input name="SortID" type="text" id="SortID" style="width: 18; background-color:#fffff0" value="<%=SortID%>" readonly> <input name="SortPath" type="text" id="SortPath" style="width: 70; background-color:#fffff0" value="<%=SortPath%>" readonly> <input name="SortName" type="text" id="SortName" value="<%=SortName%>" style="width: 180; background-color:#fffff0" readonly> <a href="javaScript:OpenScript('SelectSort.asp?Result=News',500,500,'')">选择类别</a> <font color="red">*</font></td>
    </tr>
    <tr height="35">
      <td align="right" class="forumRow">新闻来源：</td>
      <td class="forumRowHighlight"><input name="SourceCh" type="text" style="width: 280;" value="<%=SourceCh%>" maxlength="100"> 中文</td>
    </tr>
    <tr>
      <td align="right" class="forumRow"></td>
      <td class="forumRowHighlight"><input name="SourceEn" type="text" style="width: 280;" value="<%=SourceEn%>" maxlength="100"> 英文</td>
    </tr>
    <tr height="35">
      <td align="right" class="forumRow">是否公告：</td>
      <td class="forumRowHighlight"><input name="NoticeFlag" type="checkbox" value="1" <%if NoticeFlag then%> checked<%end if%>>公告</td>
    </tr>
    <tr height="35">
      <td align="right" class="forumRow">阅读权限：</td>
      <td class="forumRowHighlight"><select name="GroupID">
          <% call SelectGroup() %>
        </select>
        <input name="Exclusive" type="radio" value="&gt;=" <%if Exclusive="" or Exclusive=">=" then response.write ("checked")%>>
        隶属
        <input type="radio" <%if Exclusive="=" then response.write ("checked")%> name="Exclusive" value="=">
        专属（隶属：权限值≥可查看，专属：权限值＝可查看）</td>
    </tr>
    <tr height="35">
      <td align="right" class="forumRow"></td>
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
    if len(trim(request.Form("NewsNameCh")))<3 then
      response.write ("<script language='javascript'>alert('请填写新闻名称！');history.back(-1);</script>")
      response.end
    end if
  if ClassSeoISPY = 1 then
  if request("oAutopinyin")="" and request.Form("ClassSeo")="" then
      response.write ("<script language='javascript'>alert('请填写静态文件名！');history.back(-1);</script>")
      response.end
  end if
  end if
    if Result="Add" then
	  sql="select * from ChinaQJ_News"
      rs.open sql,conn,1,3
      rs.addnew
  '多语言循环保存数据
set rsl = server.createobject("adodb.recordset")
sqll="select * from ChinaQJ_Language order by ChinaQJ_Language_Order"
rsl.open sqll,conn,1,1
while(not rsl.eof)
  rs("NewsName"&rsl("ChinaQJ_Language_File"))=trim(Request.Form("NewsName"&rsl("ChinaQJ_Language_File")))
  if Request.Form("ViewFlag"&rsl("ChinaQJ_Language_File"))=1 then
	rs("ViewFlag"&rsl("ChinaQJ_Language_File"))=Request.Form("ViewFlag"&rsl("ChinaQJ_Language_File"))
  else
	rs("ViewFlag"&rsl("ChinaQJ_Language_File"))=0
  end if
  rs("TheTags"&rsl("ChinaQJ_Language_File"))=trim(Request.Form("TheTags"&rsl("ChinaQJ_Language_File")))
  rs("SeoKeywords"&rsl("ChinaQJ_Language_File"))=trim(Request.Form("SeoKeywords"&rsl("ChinaQJ_Language_File")))
  rs("SeoDescription"&rsl("ChinaQJ_Language_File"))=trim(Request.Form("SeoDescription"&rsl("ChinaQJ_Language_File")))
  rs("Content"&rsl("ChinaQJ_Language_File"))=trim(Request.Form("Content"&rsl("ChinaQJ_Language_File")))
rsl.movenext
wend
rsl.close
set rsl=nothing
	  rs("ChinaQJPic")=trim(Request.Form("ChinaQJPic"))
	  rs("TitleColor")=trim(Request.Form("TitleColor"))
	  If Request.Form("oAutopinyin") = "Yes" And Len(trim(Request.form("ClassSeo"))) = 0 Then
		rs("ClassSeo") = Left(Pinyin(trim(request.form("NewsNameCh"))),200)
	  Else
		rs("ClassSeo") = trim(Request.form("ClassSeo"))
	  End If
	  if Request.Form("SortID")="" and Request.Form("SortPath")="" then
        response.write ("<script language='javascript'>alert('请选择所属分类！');history.back(-1);</script>")
        response.end
	  else
	    rs("SortID")=Request.Form("SortID")
		rs("SortPath")=Request.Form("SortPath")
	  end if
	  rs("SourceCh")=trim(Request.Form("SourceCh"))
	  rs("SourceEn")=trim(Request.Form("SourceEn"))
	  if Request.Form("NoticeFlag")=1 then
        rs("NoticeFlag")=Request.Form("NoticeFlag")
	  else
        rs("NoticeFlag")=0
	  end if
      GroupIdName=split(Request.Form("GroupID"),"┎╂┚")
	  rs("GroupID")=GroupIdName(0)
	  rs("Exclusive")=trim(Request.Form("Exclusive"))
	  rs("AddTime")=now()
	  'rs("UpdateTime")=now()<!--注释内容:数据库中没有UpdateTime字段-->
	  if PubRndDisplay=1 then
	  rs("ClickNumber")=Rnd_ClickNumber(PubRndNumStart,PubRndNumEnd)
	  else
	  rs("ClickNumber")=0
	  end if
	  rs.update
	  rs.close
	  set rs=Nothing
	  set rs=server.createobject("adodb.recordset")
	  sql="select top 1 ID,ClassSeo from ChinaQJ_News order by ID desc"
	  rs.open sql,conn,1,1
	  ID=rs("ID")
	  NewNameSeo=rs("ClassSeo")
	  rs.close
	  set rs=Nothing
	  if ISHTML = 1 then
'循环生成名版HTML
set rsh = server.createobject("adodb.recordset")
sqlh="select * from ChinaQJ_Language order by ChinaQJ_Language_Order"
rsh.open sqlh,conn,1,1
while(not rsh.eof)
LanguageFolder=rsh("ChinaQJ_Language_File")&"/"
call htmll("","",""&LanguageFolder&""&NewNameSeo&""&Separated&""&ID&"."&HTMLName&"",""&LanguageFolder&"NewsView.asp","ID=",ID,"","")
rsh.movenext
wend
rsh.close
set rsh=nothing
'循环结束
	  End If
	end if
	if Result="Modify" then
      sql="select * from ChinaQJ_News where ID="&ID
      rs.open sql,conn,1,3
  '多语言循环保存数据
set rsl = server.createobject("adodb.recordset")
sqll="select * from ChinaQJ_Language order by ChinaQJ_Language_Order"
rsl.open sqll,conn,1,1
while(not rsl.eof)
  rs("NewsName"&rsl("ChinaQJ_Language_File"))=trim(Request.Form("NewsName"&rsl("ChinaQJ_Language_File")))
  if Request.Form("ViewFlag"&rsl("ChinaQJ_Language_File"))=1 then
	rs("ViewFlag"&rsl("ChinaQJ_Language_File"))=Request.Form("ViewFlag"&rsl("ChinaQJ_Language_File"))
  else
	rs("ViewFlag"&rsl("ChinaQJ_Language_File"))=0
  end if
  rs("TheTags"&rsl("ChinaQJ_Language_File"))=trim(Request.Form("TheTags"&rsl("ChinaQJ_Language_File")))
  rs("SeoKeywords"&rsl("ChinaQJ_Language_File"))=trim(Request.Form("SeoKeywords"&rsl("ChinaQJ_Language_File")))
  rs("SeoDescription"&rsl("ChinaQJ_Language_File"))=trim(Request.Form("SeoDescription"&rsl("ChinaQJ_Language_File")))
  rs("Content"&rsl("ChinaQJ_Language_File"))=trim(Request.Form("Content"&rsl("ChinaQJ_Language_File")))
rsl.movenext
wend
rsl.close
set rsl=nothing
	  rs("ChinaQJPic")=trim(Request.Form("ChinaQJPic"))
	  rs("TitleColor")=trim(Request.Form("TitleColor"))
	  If Request.Form("oAutopinyin") = "Yes" And Len(trim(Request.form("ClassSeo"))) = 0 Then
		rs("ClassSeo") = Left(Pinyin(trim(request.form("NewsNameCh"))),200)
	  Else
		rs("ClassSeo") = trim(Request.form("ClassSeo"))
	  End If
	  if Request.Form("SortID")="" and Request.Form("SortPath")="" then
        response.write ("<script language='javascript'>alert('请选择所属分类！');history.back(-1);</script>")
        response.end
	  else
	    rs("SortID")=Request.Form("SortID")
		rs("SortPath")=Request.Form("SortPath")
	  end if
	  rs("SourceCh")=trim(Request.Form("SourceCh"))
	  rs("SourceEn")=trim(Request.Form("SourceEn"))
	  if Request.Form("NoticeFlag")=1 then
        rs("NoticeFlag")=Request.Form("NoticeFlag")
	  else
        rs("NoticeFlag")=0
	  end if
      GroupIdName=split(Request.Form("GroupID"),"┎╂┚")
	  rs("GroupID")=GroupIdName(0)
	  rs("Exclusive")=trim(Request.Form("Exclusive"))
	  'rs("UpdateTime")=now()
	  rs.update
	  rs.close
	  set rs=Nothing
	  set rs=server.createobject("adodb.recordset")
	  sql="select top 1 ID,ClassSeo from ChinaQJ_News where id="&ID
	  rs.open sql,conn,1,1
	  NewNameSeo=rs("ClassSeo")
	  rs.close
	  set rs=Nothing
	  if ISHTML = 1 then
'循环生成名版HTML
set rsh = server.createobject("adodb.recordset")
sqlh="select * from ChinaQJ_Language order by ChinaQJ_Language_Order"
rsh.open sqlh,conn,1,1
while(not rsh.eof)
LanguageFolder=rsh("ChinaQJ_Language_File")&"/"
call htmll("","",""&LanguageFolder&""&NewNameSeo&""&Separated&""&ID&"."&HTMLName&"",""&LanguageFolder&"NewsView.asp","ID=",ID,"","")
rsh.movenext
wend
rsh.close
set rsh=nothing
'循环结束
	  End If
	end if
    if ISHTML = 1 then
    response.write "<script language='javascript'>alert('设置成功，相关静态页面已更新！');location.replace('NewsList.asp');</script>"
	Else
	response.write "<script language='javascript'>alert('设置成功！');location.replace('NewsList.asp');</script>"
	End If
  else
	if Result="Modify" then
      set rs = server.createobject("adodb.recordset")
      sql="select * from ChinaQJ_News where ID="& ID
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
  NewsName=rs("NewsName"&Lanl)
  ViewFlag=rs("ViewFlag"&Lanl)
  SeoKeywords=rs("SeoKeywords"&Lanl)
  SeoDescription=rs("SeoDescription"&Lanl)
  Content=rs("Content"&Lanl)
  if content="" then content=""
  TheTags=rs("TheTags"&Lanl)
  execute("TheTags"&Lanl&"=TheTags")
  execute("NewsName"&Lanl&"=NewsName")
  execute("ViewFlag"&Lanl&"=ViewFlag")
  execute("SeoKeywords"&Lanl&"=SeoKeywords")
  execute("SeoDescription"&Lanl&"=SeoDescription")
  execute("Content"&Lanl&"=Content")
rsl.movenext
wend
rsl.close
set rsl=nothing
	  ClassSeo=rs("ClassSeo")
	  SortName=SortText(rs("SortID"))
	  SortID=rs("SortID")
	  SortPath=rs("SortPath")
	  SourceCh=rs("SourceCh")
	  SourceEn=rs("SourceEn")
	  NoticeFlag=rs("NoticeFlag")
	  GroupID=rs("GroupID")
	  Exclusive=rs("Exclusive")
	  ChinaQJPic=rs("ChinaQJPic")
	  TitleColor=rs("TitleColor")
	  rs.close
      set rs=nothing
    end if
  end if
end sub

sub SelectGroup()
  dim rs,sql
  set rs = server.createobject("adodb.recordset")
  sql="select GroupID,GroupNameCh from ChinaQJ_MemGroup"
  rs.open sql,conn,1,1
  if rs.bof and rs.eof then
    response.write("未设组别")
  end if
  while not rs.eof
    response.write("<option value='"&rs("GroupID")&"┎╂┚"&rs("GroupNameCh")&"'")
    if GroupID=rs("GroupID") then response.write ("selected")
    response.write(">"&rs("GroupNameCh")&"</option>")
    rs.movenext
  wend
  rs.close
  set rs=nothing
end sub

Function SortText(ID)
  Dim rs,sql
  Set rs=server.CreateObject("adodb.recordset")
  sql="Select * From ChinaQJ_NewsSort where ID="&ID
  rs.open sql,conn,1,1
  SortText=rs("SortNameCh")
  rs.close
  set rs=nothing
End Function
%>