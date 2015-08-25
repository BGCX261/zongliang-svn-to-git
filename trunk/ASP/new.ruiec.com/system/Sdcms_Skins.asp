<!--#include file="sdcms_check.asp"-->
<%
Dim sdcms,Sd_Table,title,stype,Action
Action=Lcase(Trim(Request.QueryString("Action")))
Set Sdcms=New Sdcms_Admin
Sdcms.Check_admin
title="模板管理"
Sd_Table="sd_skins"
Sdcms_Head
%>

<div class="sdcms_notice"><span>管理操作：</span><a href="?">模板管理</a></div>
<br>
<ul id="sdcms_sub_title">
	<li class="sub"><%=title%></li>
</ul>
<div id="sdcms_right_b">
<%
Select Case Action
	Case "onskins":Sdcms.Check_lever 29:onskins
	Case Else:Main
End Select
Db_Run
CloseDb
Set Sdcms=Nothing
Sub Main
%>
<div>
<%
	Dim Fso,FsoFolder,Fsocontent,Fsocount
	Dim Xml,Title,Versions,Author,Website,Photo
	Set Fso=CreateObject("Scripting.Filesystemobject")
	Set FsoFolder=Fso.GetFolder(Server.Mappath("../skins/"))
	Set Fsocontent=FsoFolder.files
	For Each Fsocount In FsoFolder.Subfolders
	
	IF Check_File("../Skins/"&Fsocount.Name&"/Skin.Xml") Then
		Set Xml=Server.CreateObject("Microsoft.XmlDom")
		Xml.async=False
		Xml.Load(Server.MapPath("../Skins/"&Fsocount.Name&"/Skin.Xml"))
		Title=Xml.documentElement.childNodes(0).text
		Versions=Xml.documentElement.childNodes(1).text
		Author=Xml.documentElement.childNodes(2).text
		Website=Xml.documentElement.childNodes(3).text
		Photo=Xml.documentElement.childNodes(4).text
	Else
		Title="未知"
		Versions="未知"
		Author="Sdcms.Cn"
		Website="Http://www.sdcms.cn"
		Photo="images/nopic.gif"
	End IF
%>
  <div onmouseover=this.className='skinbg_over'; onmouseout=this.className='skinbg'; class="skinbg">
	<table border="0" cellspacing="0" cellpadding="0" align="center" style="margin:8px 10px 0 10px;">
	  <tr>
		<td><table border="0" cellspacing="0" cellpadding="0">
		  <tr>
			<td align="center" valign="top"><a href="sdcms_template.asp?Path=<%=Fsocount.name%>"><img src="<%=Photo%>" width="150" height="120" style="border:1px solid <%=IIF(Sdcms_Skins_Root=Fsocount.name,"#95D870","#e3e3e3")%>;background:#fff;padding:2px;" /></a></td>
		  </tr>
		  <tr>
			<td style="line-height:20px;padding-top:5px;">
			<b>名称</b>：<%=Title%><br />
			<b>版本</b>：<%=Versions%><br />
			<b>作者</b>：<a href="<%=Website%>" target="_blank"><%=Author%></a><br>
			</td>
		  </tr>
		  <tr>
			<td><input name="button" type="button" <%=IIF(Sdcms_Skins_Root=Fsocount.name,"disabled","")%> class="bnt01" onClick="if(confirm('确定要应用该模板么?<%=IIF(Sdcms_Mode=2,"\n\n需要重新生成网站后才能生效！","")%>'))location.href='?action=onskins&Root=<%=Fsocount.name%>';return false;" value="应用" />
			  <input name="button" type="button" class="bnt01" onclick="location.href='sdcms_template.asp?action=edit&filename=<%=Fsocount.name%>/Skin.xml'" value="配置" />
			  <input name="button" type="button" class="bnt01" onclick="location.href='sdcms_template.asp?Path=<%=Fsocount.name%>'" value="模板" />
			  </td>
		  </tr>
		</table></td>
	  </tr>
	</table>
	</div>
<%
Next
Set Xml=Nothing
Set FsoFolder=Nothing
Set Fsocontent=Nothing
%>
<div class="clear"></div>
</div>
<%
End Sub

Sub Onskins
	Dim Skins_Root:Skins_Root=FilterText(Trim(Request.QueryString("Root")),1)
	IF Len(Skins_Root)=0 Then Alert "来源错误","location.href='javascript:history.go(-1)'":Exit Sub
	Dim Skins_Content:Skins_Content=LoadFile_Cache("../Inc/Const.Asp")
	Dim Regs
	Set Regs=New Regexp
		Regs.Ignorecase=True
		Regs.Global=True
		Regs.Pattern="(Sdcms_Skins_Root)\s*=\s*""([^'""\n\r]*)"""
		Skins_Content=Regs.Replace(Skins_Content,"$1="""&Skins_Root&"""")
		Regs.Pattern="<!--#include file=['""]../\Skins/([\s\S]+?)/\Skins.asp['""]-->"
		Skins_Content=Regs.Replace(Skins_Content,"<!--#include file=""../Skins/"&Skins_Root&"/Skins.asp""-->")
	Set Regs=Nothing
	Savefile "../Inc/","Const.asp",Skins_Content
	Go "?"
End Sub
%>  
</div>
</body>
</html>