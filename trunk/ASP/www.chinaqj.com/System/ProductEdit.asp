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
<script language="javascript" src="/Scripts/ProEdit.js"></script>
<script language="javascript" src="<%=SysRootDir%>Scripts/ChinaQJ.js?dir=<%=SysRootDir%>Scripts/ChinaQJ"></script>
<script language="javascript" src="/Scripts/MyEditObj.js?type=<%=editType%>"></script>
<script language="javascript">
<!--
function showUploadDialog(s_Type, s_Link, s_Thumbnail){
    var arr = showModalDialog("eWebEditor/dialog/i_upload.htm?style=coolblue&type="+s_Type+"&link="+s_Link+"&thumbnail="+s_Thumbnail, window, "dialogWidth: 0px; dialogHeight: 0px; help: no; scroll: no; status: no");
}
var addH=1;function AddHeight(ObjName){if(!document.getElementById(ObjName))return flase;var comment=document.getElementById(ObjName);var nowH=parseInt(comment.style.height);if(nowH<350){nowH+=80;comment.style.height=nowH+"px";addH++;if(addH>80){addH=80;}else{window.setTimeout("AddHeight()","10");}}};function MinHeight(ObjName){if(!document.getElementById(ObjName))return flase;var comment=document.getElementById(ObjName);var nowH=parseInt(comment.style.height);if(nowH>80){nowH-=80;comment.style.height=nowH+"px";addH++;if(addH>80){addH=80;}else{window.setTimeout("MinHeight()","10");}}}
//-->
</script>
<%
if Instr(session("AdminPurview"),"|13,")=0 then
  response.write ("<br /><br /><div align=""center""><font style=""color:red; font-size:9pt; "")>您没有管理该模块的权限！</font></div>")
  response.end
end if
dim Result
Result=request.QueryString("Result")
Language="Ch"
dim ID,ProductNameCh,ProductNameEn,ViewFlagCh,ViewFlagEn,ClassSeo,SortName,SortID,SortPath
dim ProductNo,ProductModel,N_Price,P_Price,Stock,UnitCh,MakerCh,UnitEn,MakerEn,CommendFlag,NewFlag,GroupID,GroupIdName,Exclusive,SeoKeywordsCh,SeoDescriptionCh,SeoKeywordsEn,SeoDescriptionEn
dim Sequence,TitleColor,ProGNCh,ProGNEn,ProXHCh,ProXHEn,ProDHCh,ProDHEn,ProZSCh,ProZSEn
dim SmallPic,BigPic,OtherPic,ContentCh,ContentEn
Dim hanzi,j,ChinaQJ,temp,temp1,flag,firstChar,PropertiesID,rsPropertiesID
ID=request.QueryString("ID")
PropertiesID=request("PropertiesID")
call ProductEdit()
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
  <form name="editForm" method="post" action="ProductEdit.asp?Action=SaveEdit&Result=<%=Result%>&ID=<%=ID%>">
    <tr>
      <th height="22" colspan="2" sytle="line-height:150%">【<%If Result = "Add" then%>添加<%ElseIf Result = "Modify" then%>修改<%End If%>产品】</th>
    </tr>
    <tr height="35">
      <td width="200" class="forumRow" align="right">产品属性模板：</td>
      <td class="forumRowHighlight"><Select name="protext" onChange="var jmpURL=this.options[this.selectedIndex].value ;if(jmpURL!='') {window.location=jmpURL; }else{ this.selectedIndex=0; }"><option value='0'>┌ 请选择产品属性模板</option>
<% 
set rs = server.createobject("adodb.recordset")
sql="select * from ChinaQJ_Properties order by id"
rs.open sql,conn,1,1
lani=1
while(not rs.eof)
if PropertiesID<>"" and rsPropertiesID<>"" then
%>
<option value="productedit.asp?PropertiesID=<%= rs("id") %>&Result=<%= Request("Result") %>&ID=<%= Request("id") %>" <% If rs("id")=Cint(PropertiesID) Then Response.Write("selected")%>>├ <%= rs("Properties_Name") %></option>
<%
elseif PropertiesID<>"" then
%>
<option value="productedit.asp?PropertiesID=<%= rs("id") %>&Result=<%= Request("Result") %>&ID=<%= Request("id") %>" <% If rs("id")=Cint(PropertiesID) Then Response.Write("selected")%>>├ <%= rs("Properties_Name") %></option>
<%
elseif rsPropertiesID<>"" then
%>
<option value="productedit.asp?PropertiesID=<%= rs("id") %>&Result=<%= Request("Result") %>&ID=<%= Request("id") %>" <% If rs("id")=Cint(rsPropertiesID) Then Response.Write("selected")%>>├ <%= rs("Properties_Name") %></option>
<%
else
%>
<option value="productedit.asp?PropertiesID=<%= rs("id") %>&Result=<%= Request("Result") %>&ID=<%= Request("id") %>">├ <%= rs("Properties_Name") %></option><%
end if
rs.movenext
lani=lani+1
wend
rs.close
set rs=nothing
%>
      </select>
<%
if PropertiesID<>"" and rsPropertiesID<>"" then
%>
<input name="PropertiesID" type="hidden" value="<%= PropertiesID %>" />
<%
elseif PropertiesID<>"" then
%>
<input name="PropertiesID" type="hidden" value="<%= PropertiesID %>" />
<%
elseif rsPropertiesID<>"" then
%>
<input name="PropertiesID" type="hidden" value="<%= rsPropertiesID %>" />
<%
else
%>
<input name="PropertiesID" type="hidden" value="" />
<%
end if
%>
      </td>
    </tr>
  <tr><td class="leftRow" colspan="2">
<% 
set rs = server.createobject("adodb.recordset")
sql="select * from ChinaQJ_Language order by ChinaQJ_Language_Order"
rs.open sql,conn,1,1
lani=1
while(not rs.eof)
Lan1= rs("ChinaQJ_Language_File")
%>
<div id="tcontent<%= lani %>" class="tabcontent">
<table class="tableborderOther" width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr height="35">
      <td width="200" align="right" class="forumRowOther"><%=rs("ChinaQJ_Language_Name")%>标题：</td>
      <td class="forumRowHighlightOther"><input name="ProductName<%= Lan1 %>" type="text" id="ProductName<%= Lan1 %>" style="width: 280" value="<%=eval("ProductName"&Lan1)%>" maxlength="250">
        <input name="ViewFlag<%= Lan1 %>" type="checkbox" value="1" <%if eval("ViewFlag"&Lan1) then response.write ("checked")%>>显示<font color="red">*</font>&nbsp;&nbsp;&nbsp;<input name="CommendFlag<%= Lan1 %>" type="checkbox" style="height: 13px;width: 13px;" value="1" <%if eval("CommendFlag"&Lan1) then response.write ("checked")%>>推荐&nbsp;&nbsp;&nbsp;<input name="NewFlag<%= Lan1 %>" type="checkbox" value="1" style="height: 13px;width: 13px;" <%if eval("NewFlag"&Lan1) then response.write ("checked")%>>新品
    </td>
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
      <td align="right" class="forumRowOther"><%=rs("ChinaQJ_Language_Name")%>MetaKeywords：</td>
      <td class="forumRowHighlightOther"><input name="SeoKeywords<%= Lan1 %>" type="text" id="SeoKeywords<%= Lan1 %>" style="width: 500" value="<%=eval("SeoKeywords"&Lan1)%>" maxlength="250"></td>
    </tr>
    <tr height="35">
      <td align="right" class="forumRowOther"><%=rs("ChinaQJ_Language_Name")%>MetaDescription：</td>
      <td class="forumRowHighlightOther"><input name="SeoDescription<%= Lan1 %>" type="text" id="SeoDescription<%= Lan1 %>" style="width: 500" value="<%=eval("SeoDescription"&Lan1)%>" maxlength="250"></td>
    </tr>
<%
if PropertiesID<>"" then
set rs6 = server.createobject("adodb.recordset")
sql6="select * from ChinaQJ_Properties where id="&PropertiesID

rs6.open sql6,conn,1,1
  if rs6("ProProperties"&Lan1)<>"" then
  ProProperties=Split(rs6("ProProperties"&Lan1),"§§§")
  Num_1=ubound(ProProperties)+1
  execute("ProName"&Lan1&"=ProProperties")
  execute("Num"&Lan1&"=Num_1")
  else
  execute("Num"&Lan1&"=0")
  end if
rs6.close
set rs6=nothing
end if
%>
    <tr height="35">
      <td class="forumRowOther"><%=rs("ChinaQJ_Language_Name")%>属性：</td>
      <td class="forumRowHighlightOther">
        <%For i=0 to (eval("Num"&Lan1)-1)%>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr height="28">
            <td>属性名：<input name="ProName<%=i+1%><%= Lan1 %>" type="text" id="ProName<%=i+1%><%= Lan1 %>" value="<%=eval("ProName"&Lan1)(i)%>" size="18" style="background-color: lemonchiffon;"/>属性值：<input name="ProInfo<%=i+1%><%= Lan1 %>" type="text" id="ProInfo<%=i+1%><%= Lan1 %>" value="<%if PropertiesID="" then Response.Write(eval("ProInfo"&Lan1)(i)) else Response.Write("请填写"&eval("ProName"&Lan1)(i))&"的值" end if%>" size="50" style="background-color: lemonchiffon;" /></td>
          </tr>
        </table>
        <%Next%>
        <%For i=eval("Num"&Lan1) to 7%>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr height="28">
            <td>属性名：<input name="ProName<%=i+1%><%= Lan1 %>" type="text" id="ProName<%=i+1%><%= Lan1 %>" value="" size="18" style="background-color: lemonchiffon;" />属性值：<input name="ProInfo<%=i+1%><%= Lan1 %>" type="text" id="ProInfo<%=i+1%><%= Lan1 %>" value="" size="50" style="background-color: lemonchiffon;" /></td>
          </tr>
        </table>
        <%Next%>
        <font color="blue">如属性名为空，前台将不会显示。</font><br />
        <font color="#CC0000">系统为您预留了可自定义的扩展属性接口，您可以在添加产品时设置您的产品属性。如：价格、出品公司</font>
      </td>
    </tr>
    <tr height="35">
      <td class="forumRowOther"><%=rs("ChinaQJ_Language_Name")%>自定义产品参数：</td>
      <td class="forumRowHighlightOther">支持Html代码</td>
    </tr>
    <%
	If Result="Modify" Then
	if eval("ReMark"&Lan1)<>"" then
	Remarkf=Split(eval("ReMark"&Lan1),"|||")
	for i=1 to ubound(Remarkf)-1
	Remarks=Split(Remarkf(i),"||")
	%>
    <tr height="35">
      <td class="forumRowOther">参数名称：</td>
      <td class="forumRowHighlightOther"><input name="RemarkN<%= Lan1 %><%= i %>" type="text" style="width: 550px;" value="<%= Remarks(0) %>"></td>
    </tr>
    <tr height="35">
      <td class="forumRowOther">参数内容：</td>
      <td class="forumRowHighlightOther"><textarea name="RemarkD<%= Lan1 %><%= i %>" id="RemarkD<%= Lan1 %><%= i %>" style="width: 550px; height: 80px; background-color: lemonchiffon;"><%= Remarks(1) %></textarea><br />
      <button onClick="javascript: AddHeight('RemarkD<%= Lan1 %><%= i %>')">放大</button>&nbsp;<button onClick="javascript: MinHeight('RemarkD<%= Lan1 %><%= i %>')">缩小</button></td>
    </tr>
    <%
	Next
	End If
	End If
	%>
    <tr height="35">
      <td class="forumRowOther">新建名称：</td>
      <td class="forumRowHighlightOther"><input name="RemarkN<%= Lan1 %>0" type="text" style="width: 550px;" value=""></td>
    </tr>
    <tr height="35">
      <td class="forumRowOther">新建内容：</td>
      <td class="forumRowHighlightOther">
		 <script>Start_MyEdit("RemarkD<%= Lan1 %>0","div_Con_<%=rs("ChinaQJ_Language_File")%>");</script>
		 <br />
		 <font color="blue">说明：本接口用于产品介绍的扩展说明。如除了产品详细介绍外，可以扩展：产品参数、应用案例等多方面。</font><br />
         <a href="../uploadfile/ProductDiy.png" rel="ChinaQJ[title=产品自定义参数示例效果]"><font color="#CC0000"><u>查看示例效果图</u></font></a></td>
    </tr>
    <tr height="35">
      <td class="forumRowOther" align="right"><%=rs("ChinaQJ_Language_Name")%>内容：</td>
      <td align="left" class="forumRowHighlightOther">
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
  <tr>
    <td align="right" class="forumRow">标题颜色：</td>
    <td class="forumRowHighlight"><input name="TitleColor" id="TitleColor" type="text" value="<%= TitleColor %>" style="background-color:<%= TitleColor %>" size="7">
      <img src="Images/tm.gif"  width="20" height="20"  align="absmiddle" style="background-color:<%= TitleColor %>" onClick="colorcd('editForm','TitleColor','ChinaQJ')" onMouseOver="this.style.cursor='hand'"> <font id="ChinaQJ" color="<%= TitleColor %>">秦江陶瓷</font></td>
  </tr>
    <tr>
      <td class="forumRow" align="right">静态文件名：</td>
      <td class="forumRowHighlight"><input name="ClassSeo" type="text" id="ClassSeo" style="width: 500" value="<%= ClassSeo %>" maxlength="100"><br /><input name="oAutopinyin" type="checkbox" id="oAutopinyin" value="Yes" checked><font color="red">将标题转换为拼音（已填写“静态文件名”则该功能无效）</font></td>
    </tr>
    <tr>
      <td align="right" class="forumRow">排序：</td>
<% if Sequence="" then Sequence=0 %>
      <td class="forumRowHighlight"><input name="Sequence" type="text" id="Sequence" style="width: 50" value="<%= Sequence %>" maxlength="10"></td>
    </tr>
    <tr>
      <td align="right" class="forumRow">产品类别：</td>
      <td class="forumRowHighlight"><input name="SortID" type="text" id="SortID" style="width: 18; background-color:#fffff0" value="<%=SortID%>" readonly>
        <input name="SortPath" type="text" id="SortPath" style="width: 70; background-color:#fffff0" value="<%=SortPath%>" readonly>
        <input name="SortName" type="text" id="SortName" value="<%=SortName%>" style="width: 180; background-color:#fffff0" readonly>
        <a href="javaScript:OpenScript('SelectSort.asp?Result=Products',500,500,'')">选择所属类别</a> <font color="red">*</font></td>
    </tr>
    <tr>
      <td align="right" class="forumRow">产品编号：</td>
      <td class="forumRowHighlight"><input name="ProductNo" type="text" style="width: 180;" value="<%=ProductNo%>" maxlength="180">
        <font color="red">*</font></td>
    </tr>
    <tr>
      <td align="right" class="forumRow">阅读权限：</td>
      <td class="forumRowHighlight"><select name="GroupID">
          <% call SelectGroup() %>
        </select>
        <input name="Exclusive" type="radio" value="&gt;=" <%if Exclusive="" or Exclusive=">=" then response.write ("checked")%>>
        隶属
        <input type="radio" <%if Exclusive="=" then response.write ("checked")%> name="Exclusive" value="=">
        专属（隶属：权限值≥可查看，专属：权限值＝可查看）</td>
    </tr>
    <tr>
      <td align="right" class="forumRow">产品小图：</td>
      <td class="forumRowHighlight"><input name="SmallPic" type="text" style="width: 280;" value="<%=SmallPic%>" maxlength="250">
        <input type="button" value="上传图片" onclick="showUploadDialog('image', 'editForm.SmallPic', '')">
        <font color="red">*</font></td>
    </tr>
    <tr>
      <td align="right" class="forumRow">产品大图：</td>
      <td class="forumRowHighlight"><input name="BigPic" type="text" style="width: 280;" value="<%=BigPic%>" maxlength="250">
        <input type="button" value="上传图片" onclick="showUploadDialog('image', 'editForm.BigPic', '')">
        <font color="red">*</font></td>
    </tr>
    <tr>
      <td align="right" class="forumRow">更多图片：</td>
      <td class="forumRowHighlight">
<%
if Request("Result")="Modify" then
If Not(IsNull(OtherPic)) Then
Dim htmlshop
%>
      <input name="Num_3" type="text" id="Num_3" value="<%= ubound(OtherPic) %>" size="5" /> 张
        <input type="button" value="设置" onClick="num_3()" />
        <input type="button" value="增加一张"  onClick="num_3_1()" />
        <br />
        <span id="num_3_str">
<% for htmlshop=0 to ubound(OtherPic)-1 %>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td height="28"><input name="more<%= htmlshop+1 %>_pic" type="text" id="more<%= htmlshop+1 %>_pic" value="<%= trim(OtherPic(htmlshop)) %>" style="width: 300" />
              <input type="button" value="上传图片" onclick="showUploadDialog('image', 'editForm.more<%= htmlshop+1 %>_pic', '')"></td>
          </tr>
        </table>
<% next %>
        </span>
<%
else
%>
      <input name="Num_3" type="text" id="Num_3" value="0" size="5" /> 张
        <input type="button" value="设置" onClick="num_3()" />
        <input type="button" value="增加一张"  onClick="num_3_1()" />
        <br />
        <span id="num_3_str">
        
        </span>
<%
end if
else
%>
      <input name="Num_3" type="text" id="Num_3" value="0" size="5" /> 张
        <input type="button" value="设置" onClick="num_3()" />
        <input type="button" value="增加一张"  onClick="num_3_1()" />
        <br />
        <span id="num_3_str">
        
        </span>
<%
End If
%>
      </td>
    </tr>
    <tr height="35">
      <td align="right" class="forumRow"></td>
      <td class="forumRowHighlight"><input name="submitSaveEdit" type="submit" id="submitSaveEdit" value="保存">
        <input type="button" value="返回上一页" onclick="history.back(-1)"></td>
    </tr>
  </form>
</table>
<%
sub ProductEdit()
  dim Action,rsRepeat,rs,sql
  Action=request.QueryString("Action")
  if Action="SaveEdit" then
    set rs = server.createobject("adodb.recordset")
    if len(trim(request.Form("ProductNameCh")))<1 then
      response.write ("<script language='javascript'>alert('请填写产品名称！');history.back(-1);</script>")
      response.end
    end If
	if Request.Form("SortID")="" and Request.Form("SortPath")="" then
		response.write ("<script language='javascript'>alert('请选择所属分类！');history.back(-1);</script>")
		response.End
	end If
	if ltrim(request.Form("SmallPic")) = "" then
		response.write ("<script language='javascript'>alert('请上传产品小图！');history.back(-1);</script>")
		response.end
	end If
	if ltrim(request.Form("BigPic")) = "" then
		response.write ("<script language='javascript'>alert('请上传产品大图！');history.back(-1);</script>")
		response.end
	end If
	if ltrim(request.Form("ContentCh")) = "" then
		response.write ("<script language='javascript'>alert('请填写产品详细介绍！');history.back(-1);</script>")
		response.end
	end If
	if request("PropertiesID") = "" then
		response.write ("<script language='javascript'>alert('请先选择产品属性！');history.back(-1);</script>")
		response.end
	end If
	if ClassSeoISPY = 1 then
	if request("oAutopinyin")="" and request.Form("ClassSeo")="" then
		response.write ("<script language='javascript'>alert('请填写静态文件名！');history.back(-1);</script>")
		response.end
	end if
	end if
    if Result="Add" Then
	  set rsRepeat = conn.execute("select ProductNo from ChinaQJ_Products where ProductNo='" & trim(Request.Form("ProductNo")) & "'")
	  if not (rsRepeat.bof and rsRepeat.eof) then
		response.write "<script language='javascript'>alert('" & trim(Request.Form("ProductNo")) & "产品编号已存在！');history.back(-1);</script>"
		response.End
	  End If
	  rsRepeat.close
	  set rsRepeat=Nothing
	  sql="select * from ChinaQJ_Products"
      rs.open sql,conn,1,3
      rs.addnew
  '多语言循环保存数据
set rsl = server.createobject("adodb.recordset")
sqll="select * from ChinaQJ_Language order by ChinaQJ_Language_Order"
rsl.open sqll,conn,1,1
while(not rsl.eof)
  Lanl=rsl("ChinaQJ_Language_File")
  rs("ProductName"&rsl("ChinaQJ_Language_File"))=replace(trim(Request.Form("ProductName"&rsl("ChinaQJ_Language_File"))),""&chr(60)&"%","")
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
  if Request.Form("NewFlag"&rsl("ChinaQJ_Language_File"))=1 then
	rs("NewFlag"&rsl("ChinaQJ_Language_File"))=Request.Form("NewFlag"&rsl("ChinaQJ_Language_File"))
  else
	rs("NewFlag"&rsl("ChinaQJ_Language_File"))=0
  end if
  rs("TheTags"&rsl("ChinaQJ_Language_File"))=trim(Request.Form("TheTags"&rsl("ChinaQJ_Language_File")))
  rs("SeoKeywords"&rsl("ChinaQJ_Language_File"))=trim(Request.Form("SeoKeywords"&rsl("ChinaQJ_Language_File")))
  rs("SeoDescription"&rsl("ChinaQJ_Language_File"))=trim(Request.Form("SeoDescription"&rsl("ChinaQJ_Language_File")))
  rs("Content"&rsl("ChinaQJ_Language_File"))=trim(Request.Form("Content"&rsl("ChinaQJ_Language_File")))
  for i=1 to 8
    if Request.Form("ProName"&i&Lanl)<>"" and Request.Form("ProInfo"&i&Lanl)<>"" then
	Num_2=i
	end if
  next
  if Num_2="" then Num_2=0
  if Num_2>0 then
	For i=1 to Num_2
		if Request.Form("ProName"&i&Lanl)<>"" and Request.Form("ProInfo"&i&Lanl)<>"" then
		  if ProName2="" then
		    ProName2=trim(Request.Form("ProName"&i&Lanl))
			ProInfo2=trim(Request.Form("ProInfo"&i&Lanl))
		  else
			ProName2=ProName2&"§§§"&trim(Request.Form("ProName"&i&Lanl))
			ProInfo2=ProInfo2&"§§§"&trim(Request.Form("ProInfo"&i&Lanl))
		  end if
		End If
	Next
  end if
  rs("ProName"&Lanl)=ProName2
  rs("ProInfo"&Lanl)=ProInfo2
  ProName2=""
  ProInfo2=""
  
  Remarksave=""
  for i=0 to 10
  if trim(Request.Form("RemarkN"&Lanl&i))<>"" and Len(trim(Request.Form("RemarkN"&Lanl&i)))>0 then
  Remarksave=Remarksave&"|||"&trim(Request.Form("RemarkN"&Lanl&i))&"||"&trim(Request.Form("RemarkD"&Lanl&i))
  end if
  Next
  Remarksave=Remarksave&"|||"
  rs("Remark"&rsl("ChinaQJ_Language_File"))=Remarksave
  Remarksave=""
rsl.movenext
wend
rsl.close
set rsl=nothing
	  If Request.Form("oAutopinyin") = "Yes" And Len(trim(Request.form("ClassSeo"))) = 0 Then
		rs("ClassSeo") = Left(Pinyin(trim(request.form("ProductNameCh"))),200)
	  Else
		rs("ClassSeo") = trim(Request.form("ClassSeo"))
	  End If
	  rs("SortID")=Request.Form("SortID")
	  rs("SortPath")=Request.Form("SortPath")
	  rs("ProductNo")=trim(Request.Form("ProductNo"))
      GroupIdName=split(Request.Form("GroupID"),"┎╂┚")
	  rs("GroupID")=GroupIdName(0)
	  rs("Exclusive")=trim(Request.Form("Exclusive"))
	  rs("SmallPic")=trim(Request.Form("SmallPic"))
	  rs("BigPic")=trim(Request.Form("BigPic"))
	  Num_3=CheckStr(Request.Form("Num_3"),1)
	  if Num_3="" then Num_3=0
	  if Num_3>0 then
		For i=1 to Num_3
			If CheckStr(Request.Form("more"&i&"_pic"),0)<>"" Then
				If OtherPic="" then
					OtherPic=CheckStr(Request.Form("more"&i&"_pic"),0)&"*"
				Else
					OtherPic=OtherPic&CheckStr(Request.Form("more"&i&"_pic"),0)&"*"
				End if
			End If
		Next
	  end if
	  rs("OtherPic")=OtherPic
	  rs("AddTime")=now()
	  rs("UpdateTime")=now()
	  rs("Sequence")=trim(Request.Form("Sequence"))
	  rs("TitleColor")=trim(Request.Form("TitleColor"))
	  if trim(Request("PropertiesID"))="" then
	  rs("PropertiesID")=0
	  else
	  rs("PropertiesID")=trim(Request("PropertiesID"))
	  end if
	  if PubRndDisplay=1 then
	  rs("ClickNumber")=Rnd_ClickNumber(PubRndNumStart,PubRndNumEnd)
	  else
	  rs("ClickNumber")=0
	  end if
	  rs.update
	  rs.close
	  set rs=Nothing
	  set rs=server.createobject("adodb.recordset")
	  sql="select top 1 ID,ClassSeo from ChinaQJ_Products order by ID desc"
	  rs.open sql,conn,1,1
	  ID=rs("ID")
	  ProNameSeo=rs("ClassSeo")
	  rs.close
	  set rs=Nothing
	  if ISHTML = 1 then
'循环生成名版HTML
set rsh = server.createobject("adodb.recordset")
sqlh="select * from ChinaQJ_Language order by ChinaQJ_Language_Order"
rsh.open sqlh,conn,1,1
while(not rsh.eof)
LanguageFolder=rsh("ChinaQJ_Language_File")&"/"
call htmll("","",""&LanguageFolder&""&ProNameSeo&""&Separated&""&ID&"."&HTMLName&"",""&LanguageFolder&"ProductView.asp","ID=",ID,"","")
rsh.movenext
wend
rsh.close
set rsh=nothing
'循环结束
	  End If
	  End If
	  if Result="Modify" then
      sql="select * from ChinaQJ_Products where ID="&ID
      rs.open sql,conn,1,3
  '多语言循环保存数据
set rsl = server.createobject("adodb.recordset")
sqll="select * from ChinaQJ_Language order by ChinaQJ_Language_Order"
rsl.open sqll,conn,1,1
while(not rsl.eof)
  Lanl=rsl("ChinaQJ_Language_File")
  rs("ProductName"&rsl("ChinaQJ_Language_File"))=trim(Request.Form("ProductName"&rsl("ChinaQJ_Language_File")))
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
  if Request.Form("NewFlag"&rsl("ChinaQJ_Language_File"))=1 then
	rs("NewFlag"&rsl("ChinaQJ_Language_File"))=Request.Form("NewFlag"&rsl("ChinaQJ_Language_File"))
  else
	rs("NewFlag"&rsl("ChinaQJ_Language_File"))=0
  end if
  rs("TheTags"&rsl("ChinaQJ_Language_File"))=trim(Request.Form("TheTags"&rsl("ChinaQJ_Language_File")))
  rs("SeoKeywords"&rsl("ChinaQJ_Language_File"))=trim(Request.Form("SeoKeywords"&rsl("ChinaQJ_Language_File")))
  rs("SeoDescription"&rsl("ChinaQJ_Language_File"))=trim(Request.Form("SeoDescription"&rsl("ChinaQJ_Language_File")))
  rs("Content"&rsl("ChinaQJ_Language_File"))=trim(Request.Form("Content"&rsl("ChinaQJ_Language_File")))
  for i=1 to 8
    if Request.Form("ProName"&i&Lanl)<>"" and Request.Form("ProInfo"&i&Lanl)<>"" then
	Num_2=i
	end if
  next
  if Num_2="" then Num_2=0
  if Num_2>0 then
	For i=1 to Num_2
		if Request.Form("ProName"&i&Lanl)<>"" and Request.Form("ProInfo"&i&Lanl)<>"" then
		  if ProName2="" then
		    ProName2=trim(Request.Form("ProName"&i&Lanl))
			ProInfo2=trim(Request.Form("ProInfo"&i&Lanl))
		  else
			ProName2=ProName2&"§§§"&trim(Request.Form("ProName"&i&Lanl))
			ProInfo2=ProInfo2&"§§§"&trim(Request.Form("ProInfo"&i&Lanl))
		  end if
		End If
	Next
  end if
  rs("ProName"&Lanl)=ProName2
  rs("ProInfo"&Lanl)=ProInfo2
  ProName2=""
  ProInfo2=""
  
  Remarksave=""
  for i=0 to 10
  if trim(Request.Form("RemarkN"&Lanl&i))<>"" and Len(trim(Request.Form("RemarkN"&Lanl&i)))>0 then
  Remarksave=Remarksave&"|||"&trim(Request.Form("RemarkN"&Lanl&i))&"||"&trim(Request.Form("RemarkD"&Lanl&i))
  end if
  Next
  if Remarksave<>"" Then Remarksave=Remarksave&"|||"
  rs("Remark"&rsl("ChinaQJ_Language_File"))=Remarksave
  Remarksave=""
rsl.movenext
wend
rsl.close
set rsl=nothing
	  If Request.Form("oAutopinyin") = "Yes" And Len(trim(Request.form("ClassSeo"))) = 0 Then
		rs("ClassSeo") = Left(Pinyin(trim(request.form("ProductNameCh"))),200)
	  Else
		rs("ClassSeo") = trim(Request.form("ClassSeo"))
	  End If
	  rs("SortID")=Request.Form("SortID")
	  rs("SortPath")=Request.Form("SortPath")
	  rs("ProductNo")=trim(Request.Form("ProductNo"))
      GroupIdName=split(Request.Form("GroupID"),"┎╂┚")
	  rs("GroupID")=GroupIdName(0)
	  rs("Exclusive")=trim(Request.Form("Exclusive"))
	  rs("SmallPic")=trim(Request.Form("SmallPic"))
	  rs("BigPic")=trim(Request.Form("BigPic"))
	  Num_3=CheckStr(Request.Form("Num_3"),1)
	  if Num_3="" then Num_3=0
	  if Num_3>0 then
		For i=1 to Num_3
			If CheckStr(Request.Form("more"&i&"_pic"),0)<>"" Then
				If OtherPic="" then
					OtherPic=CheckStr(Request.Form("more"&i&"_pic"),0)&"*"
				Else
					OtherPic=OtherPic&CheckStr(Request.Form("more"&i&"_pic"),0)&"*"
				End if
			End If
		Next
	  end if
	  rs("OtherPic")=OtherPic
	  rs("UpdateTime")=now()
	  rs("Sequence")=trim(Request.Form("Sequence"))
	  rs("TitleColor")=trim(Request.Form("TitleColor"))
	  if trim(Request("PropertiesID"))="" then
	  rs("PropertiesID")=0
	  else
	  rs("PropertiesID")=trim(Request("PropertiesID"))
	  end if
	  rs.update
	  rs.close
	  set rs=Nothing
	  set rs=server.createobject("adodb.recordset")
	  sql="select ClassSeo from ChinaQJ_Products where id="&id
	  rs.open sql,conn,1,1
	  ProNameSeo=rs("ClassSeo")
	  rs.close
	  set rs=Nothing
	  if ISHTML = 1 then
'循环生成名版HTML
set rsh = server.createobject("adodb.recordset")
sqlh="select * from ChinaQJ_Language order by ChinaQJ_Language_Order"
rsh.open sqlh,conn,1,1
while(not rsh.eof)
LanguageFolder=rsh("ChinaQJ_Language_File")&"/"
call htmll("","",""&LanguageFolder&""&ProNameSeo&""&Separated&""&ID&"."&HTMLName&"",""&LanguageFolder&"ProductView.asp","ID=",ID,"","")
rsh.movenext
wend
rsh.close
set rsh=nothing
'循环结束
	  End If
	  End If
	  if ISHTML = 1 then
	  response.write "<script language='javascript'>alert('设置成功，相关静态页面已更新！');location.replace('ProductList.asp');</script>"
	  Else
	  response.write "<script language='javascript'>alert('设置成功！');location.replace('ProductList.asp');</script>"
	  End If
end if
if Result="Modify" then
      set rs = server.createobject("adodb.recordset")
      sql="select * from ChinaQJ_Products where ID="& ID
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
  ProductName=rs("ProductName"&Lanl)
  ViewFlag=rs("ViewFlag"&Lanl)
  CommendFlag=rs("CommendFlag"&Lanl)
  NewFlag=rs("NewFlag"&Lanl)
  SeoKeywords=rs("SeoKeywords"&Lanl)
  SeoDescription=rs("SeoDescription"&Lanl)
  Content=rs("Content"&Lanl)
  if content="" then content=""
  TheTags=rs("TheTags"&Lanl)
  ReMark=rs("ReMark"&Lanl)
  execute("ReMark"&Lanl&"=ReMark")
  execute("TheTags"&Lanl&"=TheTags")
  execute("ProductName"&Lanl&"=ProductName")
  execute("ViewFlag"&Lanl&"=ViewFlag")
  execute("CommendFlag"&Lanl&"=CommendFlag")
  execute("NewFlag"&Lanl&"=NewFlag")
  execute("SeoKeywords"&Lanl&"=SeoKeywords")
  execute("SeoDescription"&Lanl&"=SeoDescription")
  execute("Content"&Lanl&"=Content")
  if rs("ProName"&Lanl)<>"" and rs("ProInfo"&Lanl)<>"" then
  ProName3=Split(rs("ProName"&Lanl),"§§§")
  ProInfo3=Split(rs("ProInfo"&Lanl),"§§§")
  Num_1=ubound(ProName3)+1
  execute("ProName"&Lanl&"=ProName3")
  execute("ProInfo"&Lanl&"=ProInfo3")
  execute("Num"&Lanl&"=Num_1")
  else
  execute("Num"&Lanl&"=0")
  end if
rsl.movenext
wend
rsl.close
set rsl=nothing
	  classseo=rs("ClassSeo")
      SortName=SortText(rs("SortID"))
      SortID=rs("SortID")
      SortPath=rs("SortPath")
      ProductNo=rs("ProductNo")
      GroupID=rs("GroupID")
      Exclusive=rs("Exclusive")
	  SmallPic=rs("SmallPic")
      BigPic=rs("BigPic")
	  OtherPic=rs("OtherPic")
	  If Not(IsNull(OtherPic)) Then
	  OtherPic=split(OtherPic,"*")
	  End If
	  Sequence=rs("Sequence")
	  TitleColor=rs("TitleColor")
	  rsPropertiesID=rs("PropertiesID")
      rs.close
      set rs=nothing
	  else
      randomize timer
      ProductNo=Hour(now)&Minute(now)&Second(now)&"-"&int(900*rnd)+100
      Stock=10000
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
  sql="Select * From ChinaQJ_ProductSort where ID="&ID
  rs.open sql,conn,1,1
  SortText=rs("SortNameCh")
  rs.close
  set rs=nothing
End Function
%>