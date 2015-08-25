<!--#include file="../Include/Const.asp" -->
<!--#include file="../Include/ConnSiteData.asp" -->
<!--#include file="Admin_htmlconfig.asp"-->
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
if Instr(session("AdminPurview"),"|10,")=0 then
  response.write ("<br /><br /><div align=""center""><font style=""color:red; font-size:9pt; "")>您没有管理该模块的权限！</font></div>")
  response.end
end if
dim Result
Result=request.QueryString("Result")
dim ID,AboutNameCh,AboutNameEn,ViewFlagCh,ViewFlagEn,ClassSeo,ContentCh,ContentEn,Sequence,Sort,ChinaQJPic,ParentID
dim GroupID,GroupIdName,Exclusive,ChildFlag
Dim hanzi,j,ChinaQJ,temp,temp1,flag,firstChar
ID=request.QueryString("ID")
call AboutEdit()
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
  <form name="editAboutForm" method="post" action="AboutEdit.asp?Action=SaveEdit&Result=<%=Result%>&ID=<%=ID%>">
    <tr>
      <th height="22" colspan="2" sytle="line-height:150%">【<%If Result = "Add" then%>添加<%ElseIf Result = "Modify" then%>修改<%End If%>企业信息】</th>
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
      <td width="80%" class="forumRowHighlight"><input name="AboutName<%= rs("ChinaQJ_Language_File") %>" type="text" id="AboutName<%= rs("ChinaQJ_Language_File") %>" style="width: 280" value="<%=eval("AboutName"&rs("ChinaQJ_Language_File"))%>" maxlength="100">
        显示：<input name="ViewFlag<%= rs("ChinaQJ_Language_File") %>" type="checkbox" value="1" <%if eval("ViewFlag"&rs("ChinaQJ_Language_File")) then response.write ("checked")%>>
         <font color="red">*</font></td>
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
      <td width="20%" align="right" class="forumRow">图片：</td>
      <td width="80%" class="forumRowHighlight"><input name="ChinaQJPic" type="text" id="ChinaQJPic" style="width: 300" value="<%= ChinaQJPic %>" maxlength="100"> <input type="button" value="上传图片" onclick="showUploadDialog('image', 'editAboutForm.ChinaQJPic', '')"></td>
    </tr>
    <tr height="35">
      <td align="right" class="forumRow">类别：</td>
      <td class="forumRowHighlight"><select name="Sort"><option value="0">企业信息</option>
<%
set rs1 = server.createobject("adodb.recordset")
ssql="select * from ChinaQJ_About where ParentID=0"
rs1.open ssql,conn,1,1
if rs1.bof and rs1.eof then
%>
    </select></td>
<%
else
while(not rs1.eof)
if Cint(rs1("ID"))=Cint(Request("id")) then
Response.Write("")
else
%>
      <option value="<%= rs1("id") %>" <% if ParentID=rs1("id") then Response.Write("selected") %>>　<%= rs1("AboutNameCh") %>|<%= rs1("AboutNameEn") %></option>
<%
end if
rs1.movenext
wend
end if
rs1.close
set rs1=nothing
%>
    </select></td></tr>
    <tr height="35">
      <td class="forumRow" align="right" >静态文件名：</td>
      <td class="forumRowHighlight"><input name="ClassSeo" type="text" id="ClassSeo" style="width: 500" value="<%= ClassSeo %>" maxlength="100"><br /><input name="oAutopinyin" type="checkbox" id="oAutopinyin" value="Yes" checked><font color="red">将标题转换为拼音（已填写“静态文件名”则该功能无效）</font></td>
    </tr>
    <tr height="35">
      <td width="20%" align="right" class="forumRow">是否分页：</td>
      <td width="80%" class="forumRowHighlight"><input name="ChildFlag" type="checkbox" value="1" <%if ChildFlag then response.write ("checked")%>> <font color="red">*</font></td>
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
      <td align="right" class="forumRow">排序：</td>
<% if Sequence="" then Sequence=0 %>
      <td class="forumRowHighlight"><input name="Sequence" type="text" id="Sequence" style="width: 50" value="<%= Sequence %>" maxlength="10"></td>
    </tr>
    <tr height="35">
      <td align="right" class="forumRow"></td>
      <td class="forumRowHighlight"><input name="submitSaveEdit" type="submit" id="submitSaveEdit" value="保存"> <input type="button" value="返回上一页" onclick="history.back(-1)"></td>
    </tr>
  </form>
</table>
<%
sub AboutEdit()
  dim Action,rsCheckAdd,rs,sql
  Action=request.QueryString("Action")
  if Action="SaveEdit" then
    set rs = server.createobject("adodb.recordset")
    if len(trim(request.Form("AboutNameCh")))<1 then
      response.write ("<script language='javascript'>alert('请填写信息标题！');history.back(-1);</script>")
      response.end
    end If
    if trim(request.Form("ContentCh"))="" then
      response.write ("<script language='javascript'>alert('请填写信息内容！');history.back(-1);</script>")
      response.end
    end if
	if ClassSeoISPY = 1 then
	if request("oAutopinyin")="" and request.Form("ClassSeo")="" then
		response.write ("<script language='javascript'>alert('请填写静态文件名！');history.back(-1);</script>")
		response.end
	end if
	end if
    if Result="Add" then
	  sql="select * from ChinaQJ_About"
      rs.open sql,conn,1,3
      rs.addnew
  '多语言循环保存数据
set rsl = server.createobject("adodb.recordset")
sqll="select * from ChinaQJ_Language order by ChinaQJ_Language_Order"
rsl.open sqll,conn,1,1
while(not rsl.eof)
  rs("AboutName"&rsl("ChinaQJ_Language_File"))=trim(Request.Form("AboutName"&rsl("ChinaQJ_Language_File")))
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
	  rs("Sequence")=Request("Sequence")
	  If Request.Form("oAutopinyin") = "Yes" And Len(trim(Request.form("ClassSeo"))) = 0 Then
		rs("ClassSeo") = Left(Pinyin(trim(request.form("AboutNameCh"))),200)
	  Else
		rs("ClassSeo") = trim(Request.form("ClassSeo"))
	  End If
      GroupIdName=split(Request.Form("GroupID"),"┎╂┚")
	  rs("GroupID")=GroupIdName(0)
	  rs("Exclusive")=trim(Request.Form("Exclusive"))
	  rs("AddTime")=now()
	  rs("UpdateTime")=now()
	  rs.update
	  id=rs("id")
	  if Request.Form("sort")="0" then
	  rs("ParentID")=0
	  rs("SortPath")=""
	  else
	  rs("ParentID")=Request.Form("sort")
	  rs("SortPath")=id & ","
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
	  sql="select top 1 ID,ClassSeo from ChinaQJ_About order by ID desc"
	  rs.open sql,conn,1,1
	  ID=rs("ID")
	  AboutNameDiySeo=rs("ClassSeo")
	  rs.close
	  set rs=Nothing
	  if ISHTML = 1 then
'循环生成名版HTML
set rsh = server.createobject("adodb.recordset")
sqlh="select * from ChinaQJ_Language order by ChinaQJ_Language_Order"
rsh.open sqlh,conn,1,1
while(not rsh.eof)
LanguageFolder=rsh("ChinaQJ_Language_File")&"/"
call htmll("","",""&LanguageFolder&""&AboutNameDiySeo&""&Separated&""&ID&"."&HTMLName&"",""&LanguageFolder&"About.asp","ID=",ID,"","")
rsh.movenext
wend
rsh.close
set rsh=nothing
'循环结束
	  End If
	end if
	if Result="Modify" then
      sql="select * from ChinaQJ_About where ID="&ID
      rs.open sql,conn,1,3
  '多语言循环保存数据
set rsl = server.createobject("adodb.recordset")
sqll="select * from ChinaQJ_Language order by ChinaQJ_Language_Order"
rsl.open sqll,conn,1,1
while(not rsl.eof)
  rs("AboutName"&rsl("ChinaQJ_Language_File"))=trim(Request.Form("AboutName"&rsl("ChinaQJ_Language_File")))
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
	  rs("Sequence")=Request("Sequence")
	  If Request.Form("oAutopinyin") = "Yes" And Len(trim(Request.form("ClassSeo"))) = 0 Then
		rs("ClassSeo") = Left(Pinyin(trim(request.form("AboutNameCh"))),200)
	  Else
		rs("ClassSeo") = trim(Request.form("ClassSeo"))
	  End If
	  GroupIdName=split(Request.Form("GroupID"),"┎╂┚")
	  rs("GroupID")=GroupIdName(0)
	  rs("Exclusive")=trim(Request.Form("Exclusive"))
	  if Request.Form("sort")="0" then
	  rs("ParentID")=0
	  rs("SortPath")=""
	  else
	  rs("ParentID")=Request.Form("sort")
	  rs("SortPath")=Request("id") & ","
	  end if
	  rs("UpdateTime")=now()
	  rs.update
	  rs.close
	  set rs=Nothing
	  set rs=server.createobject("adodb.recordset")
	  sql="select ClassSeo from ChinaQJ_About where id="&ID
	  rs.open sql,conn,1,1
	  AboutNameDiySeo=rs("ClassSeo")
	  rs.close
	  set rs=Nothing
	  if ISHTML = 1 then
'循环生成各版HTML
set rsh = server.createobject("adodb.recordset")
sqlh="select * from ChinaQJ_Language order by ChinaQJ_Language_Order"
rsh.open sqlh,conn,1,1
while(not rsh.eof)
LanguageFolder=rsh("ChinaQJ_Language_File")&"/"
call htmll("","",""&LanguageFolder&""&AboutNameDiySeo&""&Separated&""&ID&"."&HTMLName&"",""&LanguageFolder&"About.asp","ID=",ID,"","")
rsh.movenext
wend
rsh.close
set rsh=nothing
'循环结束
	  End If
	end if
    if ISHTML = 1 then
    response.write "<script language='javascript'>alert('设置成功，相关静态页面已更新！');location.replace('AboutList.asp');</script>"
	Else
	response.write "<script language='javascript'>alert('设置成功！');location.replace('AboutList.asp');</script>"
	End If
  else
	if Result="Modify" then
      set rs = server.createobject("adodb.recordset")
      sql="select * from ChinaQJ_About where ID="& ID
      rs.open sql,conn,1,1
  '多语言循环拾取数据
set rsl = server.createobject("adodb.recordset")
sqll="select * from ChinaQJ_Language order by ChinaQJ_Language_Order"
rsl.open sqll,conn,1,1
while(not rsl.eof)
  Lanl=rsl("ChinaQJ_Language_File")
  AboutName=rs("AboutName"&Lanl)
  TheTags=rs("TheTags"&Lanl)
  ViewFlag=rs("ViewFlag"&Lanl)
  SeoKeywords=rs("SeoKeywords"&Lanl)
  SeoDescription=rs("SeoDescription"&Lanl)
  Content=rs("Content"&Lanl)
  if content="" then content=""
  execute("AboutName"&Lanl&"=AboutName")
  execute("TheTags"&Lanl&"=TheTags")
  execute("ViewFlag"&Lanl&"=ViewFlag")
  execute("SeoKeywords"&Lanl&"=SeoKeywords")
  execute("SeoDescription"&Lanl&"=SeoDescription")
  execute("Content"&Lanl&"=Content")
rsl.movenext
wend
rsl.close
set rsl=nothing
	  ClassSeo=rs("ClassSeo")
	  GroupID=rs("GroupID")
	  Exclusive=rs("Exclusive")
	  Sequence=rs("Sequence")
	  ParentID=rs("ParentID")
	  ChinaQJPic=rs("ChinaQJPic")
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
%>