<!--#include file="../Include/Const.asp" -->
<!--#include file="../Include/ConnSiteData.asp" -->
<!--#include file="Admin_htmlconfig.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="Images/Admin_style.css">
<script language="javascript" src="../Scripts/Admin.js"></script>
<script language="javascript" src="JavaScript/Tab.js"></script>
<%
if Instr(session("AdminPurview"),"|18,")=0 then
  response.write ("<br /><br /><div align=""center""><font style=""color:red; font-size:9pt; "")>您没有管理该模块的权限！</font></div>")
  response.end
end if
dim Result
Result=request.QueryString("Result")
dim ID,JobNameCh,JobNameEn,ViewFlagCh,ViewFlagEn,ClassSeo,JobAddressCh,JobAddressEn,JobNumber,EmolumentCh,EmolumentEn,StartDate,EndDate,ResponsibilityCh,RequirementCh,ResponsibilityEn,RequirementEn
dim eEmployerCh,eContactCh,eEmployerEn,eContactEn,eTel,eAddressCh,eAddressEn,ePostCode,eEmail
Dim hanzi,j,ChinaQJ,temp,temp1,flag,firstChar
ID=request.QueryString("ID")
call JobsEdit()
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
  <form name="editForm" method="post" action="JobsEdit.asp?Action=SaveEdit&Result=<%=Result%>&ID=<%=ID%>">
    <tr height="28">
      <th colspan="2" sytle="line-height:150%">【<%If Result = "Add" then%>添加<%ElseIf Result = "Modify" then%>修改<%End If%>招聘】</th>
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
      <td width="20%" align="right" class="forumRow"><%=rs("ChinaQJ_Language_Name")%>名称：</td>
      <td width="80%" class="forumRowHighlight"><input name="JobName<%= rs("ChinaQJ_Language_File") %>" type="text" id="JobName<%= rs("ChinaQJ_Language_File") %>" style="width: 280" value="<%=eval("JobName"&rs("ChinaQJ_Language_File"))%>" maxlength="280">
        显示：<input name="ViewFlag<%= rs("ChinaQJ_Language_File") %>" type="checkbox" value="1" <%if eval("ViewFlag"&rs("ChinaQJ_Language_File")) then response.write ("checked")%>> <font color="red">*</font></td>
    </tr>
    <tr height="35">
      <td width="20%" align="right" class="forumRow"><%=rs("ChinaQJ_Language_Name")%>MetaKeywords：</td>
      <td width="80%" class="forumRowHighlight"><input name="SeoKeywords<%= rs("ChinaQJ_Language_File") %>" type="text" id="SeoKeywords<%= rs("ChinaQJ_Language_File") %>" style="width: 500" value="<%=eval("SeoKeywords"&rs("ChinaQJ_Language_File"))%>" maxlength="250"></td>
    </tr>
    <tr height="35">
      <td width="20%" align="right" class="forumRow"><%=rs("ChinaQJ_Language_Name")%>MetaDescription：</td>
      <td width="80%" class="forumRowHighlight"><input name="SeoDescription<%= rs("ChinaQJ_Language_File") %>" type="text" id="SeoDescription<%= rs("ChinaQJ_Language_File") %>" style="width: 500" value="<%=eval("SeoDescription"&rs("ChinaQJ_Language_File"))%>" maxlength="250"></td>
    </tr>
    <tr height="35">
      <td align="right" class="forumRow"><%=rs("ChinaQJ_Language_Name")%>工作地点：</td>
      <td class="forumRowHighlight"><input name="JobAddress<%= rs("ChinaQJ_Language_File") %>" type="text" style="width: 180" value="<%=eval("JobAddress"&rs("ChinaQJ_Language_File"))%>" maxlength="180"> <font color="red">*</font></td>
    </tr>
	<tr height="35">
      <td align="right" class="forumRow"><%=rs("ChinaQJ_Language_Name")%>薪水待遇：</td>
      <td class="forumRowHighlight"><input name="Emolument<%= rs("ChinaQJ_Language_File") %>" type="text" style="width: 80" value="<%=eval("Emolument"&rs("ChinaQJ_Language_File"))%>" maxlength="80"> <font color="red">*</font></td>
    </tr>
	<tr height="35">
      <td align="right" class="forumRow"><%=rs("ChinaQJ_Language_Name")%>工作职责：</td>
      <td class="forumRowHighlight"><textarea name="Responsibility<%= rs("ChinaQJ_Language_File") %>" rows="8" id="ResponsibilityCh" style="width: 500"><%=eval("Responsibility"&rs("ChinaQJ_Language_File"))%></textarea> </td>
    </tr>
	<tr height="35">
      <td align="right" class="forumRow"><%=rs("ChinaQJ_Language_Name")%>职位要求：</td>
      <td class="forumRowHighlight"><textarea name="Requirement<%= rs("ChinaQJ_Language_File") %>" rows="8" id="RequirementCh" style="width: 500"><%=eval("Requirement"&rs("ChinaQJ_Language_File"))%></textarea> </td>
    </tr>
	<tr height="35">
      <td align="right" class="forumRow"><%=rs("ChinaQJ_Language_Name")%>用人单位：</td>
      <td class="forumRowHighlight"><input name="eEmployer<%= rs("ChinaQJ_Language_File") %>" type="text" style="width: 280" value="<%=eval("eEmployer"&rs("ChinaQJ_Language_File"))%>" maxlength="280"> </td>
    </tr>
	<tr height="35">
      <td align="right" class="forumRow"><%=rs("ChinaQJ_Language_Name")%>联系人：</td>
      <td class="forumRowHighlight"><input name="eContact<%= rs("ChinaQJ_Language_File") %>" type="text" style="width: 180" value="<%=eval("eContact"&rs("ChinaQJ_Language_File"))%>" maxlength="180"> </td>
    </tr>
	<tr height="35">
      <td align="right" class="forumRow"><%=rs("ChinaQJ_Language_Name")%>联系地址：</td>
      <td class="forumRowHighlight"><input name="eAddress<%= rs("ChinaQJ_Language_File") %>" type="text" style="width: 280" value="<%=eval("eAddress"&rs("ChinaQJ_Language_File"))%>" maxlength="280"> </td>
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
      <td class="forumRow" align="right" width="200">静态文件名：</td>
      <td class="forumRowHighlight"><input name="ClassSeo" type="text" id="ClassSeo" style="width: 500" value="<%= ClassSeo %>" maxlength="100"><br /><input name="oAutopinyin" type="checkbox" id="oAutopinyin" value="Yes" checked><font color="red">将标题转换为拼音（已填写“静态文件名”则该功能无效）</font></td>
    </tr>
	<tr height="35">
      <td align="right" class="forumRow">招聘人数：</td>
      <td class="forumRowHighlight"><input name="JobNumber" type="text" style="width: 80" value="<%=JobNumber%>" maxlength="80"></td>
    </tr>
	<tr height="35">
      <td align="right" class="forumRow">时间：</td>
      <td class="forumRowHighlight"><input name="StartDate" type="text" id="StartDate" style="width: 120" value="<% if StartDate="" then response.write now() else response.write (StartDate) end if%>" maxlength="18"> → <input name="EndDate" type="text" id="EndDate" style="width: 120" value="<% if EndDate="" then response.write (DateAdd("m",3,now())) else response.write (EndDate) end if%>" maxlength="18"> <font color="red">*</font> 默认为当前时间开始，三个月后结束(可手工修改)。</td>
    </tr>
	<tr height="35">
      <td align="right" class="forumRow">联系电话：</td>
      <td class="forumRowHighlight"><input name="eTel" type="text" style="width: 180" value="<%=eTel%>" maxlength="180"></td>
    </tr>
	<tr height="35">
      <td align="right" class="forumRow">邮政编码：</td>
      <td class="forumRowHighlight"><input name="ePostCode" type="text" style="width: 80" value="<%=ePostCode%>" maxlength="80"></td>
    </tr>
	<tr height="35">
      <td align="right" class="forumRow">电子信箱：</td>
      <td class="forumRowHighlight"><input name="eEmail" type="text" style="width: 280" value="<%=eEmail%>" maxlength="280"></td>
    </tr>
    <tr height="35">
      <td align="right" class="forumRow"></td>
      <td class="forumRowHighlight"><input name="submitSaveEdit" type="submit" id="submitSaveEdit" value="保存"> <input type="button" value="返回上一页" onclick="history.back(-1)"></td>
    </tr>
  </form>
</table>
<%
sub JobsEdit()
  dim Action,rsCheckAdd,rs,sql
  Action=request.QueryString("Action")
  if Action="SaveEdit" then
    set rs = server.createobject("adodb.recordset")
    if len(trim(request.Form("JobNameCh")))<1 then
      response.write ("<script language='javascript'>alert('请填写招聘职位名称！');history.back(-1);</script>")
      response.end
    end if
    if len(trim(request.Form("JobAddressCh")))<1 or len(trim(request.Form("EmolumentCh")))<1 then
      response.write ("<script language='javascript'>alert('请填写工作地点、薪水待遇！');history.back(-1);</script>")
      response.end
    end if
    if not IsNumeric(trim(request.Form("JobNumber"))) then
      response.write ("<script language='javascript'>alert('请正确填写职位数量！');history.back(-1);</script>")
      response.end
    end if
    if not (IsDate(trim(request.Form("StartDate"))) or IsDate(trim(request.Form("EndDate")))) then
      response.write ("<script language='javascript'>alert('请正确填写开始、结束日期！');history.back(-1);</script>")
      response.end
    end if
	if ClassSeoISPY = 1 then
	if request("oAutopinyin")="" and request.Form("ClassSeo")="" then
		response.write ("<script language='javascript'>alert('请填写静态文件名！');history.back(-1);</script>")
		response.end
	end if
	end if
    if Result="Add" then
	  sql="select * from ChinaQJ_Jobs"
      rs.open sql,conn,1,3
      rs.addnew
  '多语言循环保存数据
set rsl = server.createobject("adodb.recordset")
sqll="select * from ChinaQJ_Language order by ChinaQJ_Language_Order"
rsl.open sqll,conn,1,1
while(not rsl.eof)
  rs("JobName"&rsl("ChinaQJ_Language_File"))=trim(Request.Form("JobName"&rsl("ChinaQJ_Language_File")))
  if Request.Form("ViewFlag"&rsl("ChinaQJ_Language_File"))=1 then
	rs("ViewFlag"&rsl("ChinaQJ_Language_File"))=Request.Form("ViewFlag"&rsl("ChinaQJ_Language_File"))
  else
	rs("ViewFlag"&rsl("ChinaQJ_Language_File"))=0
  end if
  rs("SeoKeywords"&rsl("ChinaQJ_Language_File"))=trim(Request.Form("SeoKeywords"&rsl("ChinaQJ_Language_File")))
  rs("SeoDescription"&rsl("ChinaQJ_Language_File"))=trim(Request.Form("SeoDescription"&rsl("ChinaQJ_Language_File")))
  rs("eContact"&rsl("ChinaQJ_Language_File"))=trim(Request.Form("eContact"&rsl("ChinaQJ_Language_File")))
  rs("JobAddress"&rsl("ChinaQJ_Language_File"))=trim(Request.Form("JobAddress"&rsl("ChinaQJ_Language_File")))
  rs("Emolument"&rsl("ChinaQJ_Language_File"))=trim(Request.Form("Emolument"&rsl("ChinaQJ_Language_File")))
  rs("Responsibility"&rsl("ChinaQJ_Language_File"))=trim(Request.Form("Responsibility"&rsl("ChinaQJ_Language_File")))
  rs("Requirement"&rsl("ChinaQJ_Language_File"))=trim(Request.Form("Requirement"&rsl("ChinaQJ_Language_File")))
  rs("eEmployer"&rsl("ChinaQJ_Language_File"))=trim(Request.Form("eEmployer"&rsl("ChinaQJ_Language_File")))
  rs("eAddress"&rsl("ChinaQJ_Language_File"))=trim(Request.Form("eAddress"&rsl("ChinaQJ_Language_File")))
rsl.movenext
wend
rsl.close
set rsl=nothing
	  If Request.Form("oAutopinyin") = "Yes" And Len(trim(Request.form("ClassSeo"))) = 0 Then
		rs("ClassSeo") = Left(Pinyin(trim(request.form("JobNameCh"))),200)
	  Else
		rs("ClassSeo") = trim(Request.form("ClassSeo"))
	  End If
	  rs("JobNumber")=trim(Request.Form("JobNumber"))
	  rs("StartDate")=trim(Request.Form("StartDate"))
	  rs("EndDate")=trim(Request.Form("EndDate"))
	  rs("AddTime")=now()
	  rs("UpdateTime")=now()
	  rs("eTel")=trim(Request.Form("eTel"))
	  rs("ePostcode")=trim(Request.Form("ePostcode"))
	  rs("eEmail")=trim(Request.Form("eEmail"))
	  if PubRndDisplay=1 then
	  rs("ClickNumber")=Rnd_ClickNumber(PubRndNumStart,PubRndNumEnd)
	  else
	  rs("ClickNumber")=0
	  end if
	  rs.update
	  rs.close
	  set rs=Nothing
	  set rs=server.createobject("adodb.recordset")
	  sql="select top 1 ID,ClassSeo from ChinaQJ_Jobs order by ID desc"
	  rs.open sql,conn,1,1
	  ID=rs("ID")
	  JobNameDiySeo=rs("ClassSeo")
	  rs.close
	  set rs=Nothing
	  if ISHTML = 1 then
'循环生成各版HTML
set rsh = server.createobject("adodb.recordset")
sqlh="select * from ChinaQJ_Language order by ChinaQJ_Language_Order"
rsh.open sqlh,conn,1,1
while(not rsh.eof)
LanguageFolder=rsh("ChinaQJ_Language_File")&"/"
call htmll("","",""&LanguageFolder&""&JobNameDiySeo&""&Separated&""&ID&"."&HTMLName&"",""&LanguageFolder&"JobsView.asp","ID=",ID,"","")
rsh.movenext
wend
rsh.close
set rsh=nothing
'循环结束
	  End If
	end if
	if Result="Modify" then
      sql="select * from ChinaQJ_Jobs where ID="&ID
      rs.open sql,conn,1,3
  '多语言循环保存数据
set rsl = server.createobject("adodb.recordset")
sqll="select * from ChinaQJ_Language order by ChinaQJ_Language_Order"
rsl.open sqll,conn,1,1
while(not rsl.eof)
  rs("JobName"&rsl("ChinaQJ_Language_File"))=trim(Request.Form("JobName"&rsl("ChinaQJ_Language_File")))
  if Request.Form("ViewFlag"&rsl("ChinaQJ_Language_File"))=1 then
	rs("ViewFlag"&rsl("ChinaQJ_Language_File"))=Request.Form("ViewFlag"&rsl("ChinaQJ_Language_File"))
  else
	rs("ViewFlag"&rsl("ChinaQJ_Language_File"))=0
  end if
  rs("SeoKeywords"&rsl("ChinaQJ_Language_File"))=trim(Request.Form("SeoKeywords"&rsl("ChinaQJ_Language_File")))
  rs("SeoDescription"&rsl("ChinaQJ_Language_File"))=trim(Request.Form("SeoDescription"&rsl("ChinaQJ_Language_File")))
  rs("eContact"&rsl("ChinaQJ_Language_File"))=trim(Request.Form("eContact"&rsl("ChinaQJ_Language_File")))
  rs("JobAddress"&rsl("ChinaQJ_Language_File"))=trim(Request.Form("JobAddress"&rsl("ChinaQJ_Language_File")))
  rs("Emolument"&rsl("ChinaQJ_Language_File"))=trim(Request.Form("Emolument"&rsl("ChinaQJ_Language_File")))
  rs("Responsibility"&rsl("ChinaQJ_Language_File"))=trim(Request.Form("Responsibility"&rsl("ChinaQJ_Language_File")))
  rs("Requirement"&rsl("ChinaQJ_Language_File"))=trim(Request.Form("Requirement"&rsl("ChinaQJ_Language_File")))
  rs("eEmployer"&rsl("ChinaQJ_Language_File"))=trim(Request.Form("eEmployer"&rsl("ChinaQJ_Language_File")))
  rs("eAddress"&rsl("ChinaQJ_Language_File"))=trim(Request.Form("eAddress"&rsl("ChinaQJ_Language_File")))
rsl.movenext
wend
rsl.close
set rsl=nothing
	  If Request.Form("oAutopinyin") = "Yes" And Len(trim(Request.form("ClassSeo"))) = 0 Then
		rs("ClassSeo") = Left(Pinyin(trim(request.form("JobNameCh"))),200)
	  Else
		rs("ClassSeo") = trim(Request.form("ClassSeo"))
	  End If
	  rs("JobNumber")=trim(Request.Form("JobNumber"))
	  rs("StartDate")=trim(Request.Form("StartDate"))
	  rs("EndDate")=trim(Request.Form("EndDate"))
	  rs("UpdateTime")=now()
	  rs("eTel")=trim(Request.Form("eTel"))
	  rs("ePostcode")=trim(Request.Form("ePostcode"))
	  rs("ePostcode")=trim(Request.Form("ePostcode"))
	  rs("eEmail")=trim(Request.Form("eEmail"))
	  rs.update
	  rs.close
	  set rs=Nothing
	  set rs=server.createobject("adodb.recordset")
	  sql="select ClassSeo from ChinaQJ_Jobs Where id="&id
	  rs.open sql,conn,1,1
	  JobNameDiySeo=rs("ClassSeo")
	  rs.close
	  set rs=Nothing
	  if ISHTML = 1 then
'循环生成各版HTML
set rsh = server.createobject("adodb.recordset")
sqlh="select * from ChinaQJ_Language order by ChinaQJ_Language_Order"
rsh.open sqlh,conn,1,1
while(not rsh.eof)
LanguageFolder=rsh("ChinaQJ_Language_File")&"/"
call htmll("","",""&LanguageFolder&""&JobNameDiySeo&""&Separated&""&ID&"."&HTMLName&"",""&LanguageFolder&"JobsView.asp","ID=",ID,"","")
rsh.movenext
wend
rsh.close
set rsh=nothing
'循环结束
	  End If
	end if
    if ISHTML = 1 then
    response.write "<script language='javascript'>alert('设置成功，相关静态页面已更新！');location.replace('JobsList.asp');</script>"
	Else
	response.write "<script language='javascript'>alert('设置成功！');location.replace('JobsList.asp');</script>"
	End If
  else
	if Result="Modify" then
      set rs = server.createobject("adodb.recordset")
      sql="select * from ChinaQJ_Jobs where ID="& ID
      rs.open sql,conn,1,1
  '多语言循环拾取数据
set rsl = server.createobject("adodb.recordset")
sqll="select * from ChinaQJ_Language order by ChinaQJ_Language_Order"
rsl.open sqll,conn,1,1
while(not rsl.eof)
  Lanl=rsl("ChinaQJ_Language_File")
  JobName=rs("JobName"&Lanl)
  ViewFlag=rs("ViewFlag"&Lanl)
  SeoKeywords=rs("SeoKeywords"&Lanl)
  SeoDescription=rs("SeoDescription"&Lanl)
  eContact=rs("eContact"&Lanl)
  JobAddress=rs("JobAddress"&Lanl)
  Emolument=rs("Emolument"&Lanl)
  Responsibility=rs("Responsibility"&Lanl)
  Requirement=rs("Requirement"&Lanl)
  eEmployer=rs("eEmployer"&Lanl)
  eAddress=rs("eAddress"&Lanl)
  execute("JobName"&Lanl&"=JobName")
  execute("ViewFlag"&Lanl&"=ViewFlag")
  execute("SeoKeywords"&Lanl&"=SeoKeywords")
  execute("SeoDescription"&Lanl&"=SeoDescription")
  execute("eContact"&Lanl&"=eContact")
  execute("JobAddress"&Lanl&"=JobAddress")
  execute("Emolument"&Lanl&"=Emolument")
  execute("Responsibility"&Lanl&"=Responsibility")
  execute("Requirement"&Lanl&"=Requirement")
  execute("eEmployer"&Lanl&"=eEmployer")
  execute("eAddress"&Lanl&"=eAddress")
rsl.movenext
wend
rsl.close
set rsl=nothing
	  ClassSeo=rs("ClassSeo")
	  JobNumber=rs("JobNumber")
	  StartDate=rs("StartDate")
	  EndDate=rs("EndDate")
	  eTel=rs("eTel")
	  ePostcode=rs("ePostcode")
	  eEmail=rs("eEmail")
	  rs.close
      set rs=nothing
	end if
  end if
end sub
%>