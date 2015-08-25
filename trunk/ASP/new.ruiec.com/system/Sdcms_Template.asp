<!--#include file="sdcms_check.asp"-->
<%
Dim badfilename,sdcms,Path,title,Paths,Path_s,Temp_file,path_mid,Action
Action=Lcase(Trim(Request.QueryString("Action")))
badfilename=Split(".asp|.aspx|.jsp|.asa|.vbs|.exe|.cer|.cdx|.htw|.ida|.idq|.printer|.cgi|.php|.php4|.cfm|.htr|.phtml|.ashx","|")
Set Sdcms=New Sdcms_Admin
Sdcms.Check_admin
Select Case Action
	Case "add":title="创建文件"
	Case "addfile":title="创建文件夹"
	Case "edit":title="修改文件"
	Case "rename":title="重命名"
	Case "del":title="删除文件"
	Case Else:title="模板管理"
End Select
Path=Trim(Request("path"))
path=Re(path,".","")
IF Len(Path)>0 Then Path_mid="/"
Select Case Path
	Case "":Temp_file="../skins/"
	Case Else:Temp_file="../skins/"&Path&Path_mid
End Select
IF Instr(Path,"/")>0 Then
	Paths=Split(Path,"/")
	Path_s=Paths(Ubound(Paths)-1)
End IF
Sdcms_Head
%>
<div class="sdcms_notice"><span>管理操作：</span><a href="?action=add&Path=<%=Path%>">创建文件</a>　┊　<a href="?action=addfile&Path=<%=Path%>">创建文件夹</a>　┊　<a href="sdcms_skins.asp">模板管理</a></div>
<br>
<ul id="sdcms_sub_title">
	<li class="sub"><%=title%></li>
</ul>
<div id="sdcms_right_b">
<%
Select Case Action
	Case "add":sdcms.Check_lever 28:add
	Case "addfile":sdcms.Check_lever 28:addfile
	Case "edit":sdcms.Check_lever 29:edit
	Case "save":save
	Case "savefiles":savefiles
	Case "rename":sdcms.Check_lever 29:rename
	Case "renamesave":sdcms.Check_lever 29:renamesave
	Case "del":sdcms.Check_lever 30:del
	Case Else:main
End Select
Set Sdcms=Nothing
Db_Run
CloseDb
Sub Main
%>
  <table border="0" align="center" cellpadding="3" cellspacing="1" class="table_b">
    <tr>
      <td class="title_bg" width="300">目录/名称</td>
      <td class="title_bg">文件大小</td>
      <td class="title_bg">更新日期</td>
      <td class="title_bg">管理</td>
    </tr>
	<%
	IF Len(path)>0 Then
	%>
	<tr onmouseover=this.bgColor='#EEFEED'; onmouseout=this.bgColor='#ffffff';  bgcolor='#ffffff'>
      <td colspan="4"><img src="images/ext/folder.gif" align="absmiddle" /><a href="Sdcms_Skins.asp">返回模板列表</a>　<%IF Instr(path,"/")>0 Then%><a href="?Path=<%=Path_s%>">上一级目录</a><%End IF%></td>
    </tr>
	<%
	End IF
	Dim Fso,FsoFolder,Fsocontent,Fsocount
	Set Fso=CreateObject("Scripting.Filesystemobject")
	Set FsoFolder=Fso.GetFolder(Server.Mappath(Temp_file))
	Set Fsocontent=FsoFolder.files
	For Each Fsocount In FsoFolder.Subfolders
	%>
    <tr onmouseover=this.bgColor='#EEFEED'; onmouseout=this.bgColor='#ffffff';  bgcolor='#ffffff'>
		<td height="25"><%IF Instr(path_mid,"/")>0 Then%>　　<%End IF%><img src="images/ext/folder.gif" align="absmiddle" /><a href="?Path=<%=path&Path_mid&Fsocount.Name%>"><%=Fsocount.Name%></a></td>
		<td align="center"><%=FormatNumber(Fsocount.Size/1024,2,True,False,True)%> KB</td>
		<td align="center"><%=Fsocount.datelastmodified%></td>
		<td align="center"><a href="?action=rename&t0=<%=Fsocount.Name%>&path=<%=path&Path_mid%>&t1=True">改名</a> <a href="?action=del&t0=<%=path&Path_mid&Fsocount.Name%>&t1=False" onclick='return confirm("真的要删除?不可恢复!");'>删除</a></td>
    </tr>
	<%
	Next
	Dim FsoItem,picsrc,EditType
	For Each FsoItem in Fsocontent
		EditType=False
		Select Case Lcase(Right(FsoItem.Name,3))
			Case "htm","tml":picsrc="html":EditType=True
			Case ".js":picsrc="js":EditType=True
			Case "bmp","jpg","asp","gif","png","swf":picsrc=Right(FsoItem.Name,3)
			Case "css","txt","vbs","xml","xsl":picsrc=Right(FsoItem.Name,3):EditType=True
			Case Else:picsrc="file"
		End Select
	IF Lcase(FsoItem.Name)<>"skins.asp" And Lcase(FsoItem.Name)<>"skin.xml" Then
	%>
    <tr onmouseover=this.bgColor='#EEFEED'; onmouseout=this.bgColor='#ffffff';  bgcolor='#ffffff'>
		<td height="25">　　<img src="images/ext/<%=picsrc%>.gif" align="absmiddle" /><a href="<%If EditType Then%>?action=edit&filename=<%=path&Path_mid&FsoItem.Name%><%Else%>../skins/<%=path&Path_mid&FsoItem.Name%><%End IF%>" <%If not EditType Then%>title="查看详细" target="_blank"<%end if%>><%=FsoItem.Name%></a></td>
		<td align="center"><%=FormatNumber(FsoItem.Size/1024,2,True,False,True)%> KB</td>
		<td align="center"><%=FsoItem.datelastmodified%></td>
		<td align="center"><a href="?action=rename&t0=<%=FsoItem.Name%>&path=<%=path&Path_mid%>&t1=False">改名</a> <a href="?action=del&t0=<%=path&Path_mid&FsoItem.Name%>&t1=True" onclick='return confirm("真的要删除?不可恢复!");'>删除</a></td>
    </tr>
	<%End IF:Next%>
  </table>
<%
Set Fso=Nothing
Set FsoFolder=Nothing
Set Fsocontent=Nothing
End Sub

Sub Add
Echo Check_Add
%>
  <table width="98%" border="0" align="center" cellpadding="3" cellspacing="1">
  <form name="add" id="add" method="post" action="?action=save&t3=True&Path=<%=path%>" onSubmit="return checkadd()">
    <tr>
      <td width="120" align="center" class="tdbg">目　录：      </td>
      <td class="tdbg">../Skins/<%=path&Path_mid%></td>
    </tr>
	<tr>
      <td align="center" class="tdbg">文件名：      </td>
      <td class="tdbg"><input name="t0" type="text" class="input" id="t0" size="40">　<span>格式：sdcms_index.htm</span></td>
    </tr>
	<tr class="tdbg">
      <td align="center">内容：</td>
      <td><textarea id="t1" name="t1" class="inputs" rows="20"></textarea></td>
    </tr>
    <tr class="tdbg">
	  <td>&nbsp;</td>
      <td><input type="submit" class="bnt" value="保存设置"> <input type="button" onClick="history.go(-1)" class="bnt" value="放弃返回"></td>
    </tr>
	</form>
  </table>
<%
End Sub

Sub Edit
Dim t0,i
Echo Check_Add
t0=Trim(Request("filename"))
For I=0 To Ubound(badfilename)
	IF Instr(Lcase(t0),badfilename(i))>0 Then Echo "此类文件不允许被修改":Exit Sub
Next
%>
  <table width="98%" border="0" align="center" cellpadding="3" cellspacing="1">
  <form name="add" method="post" action="?action=save&t3=False&t0=<%=t0%>" onSubmit="return checkadd()">
    <tr>
      <td width="120" align="center" class="tdbg">文件名：      </td>
      <td class="tdbg"><%=t0%></td>
    </tr>
    <tr class="tdbg">
      <td align="center">内　容：      </td>
      <td><textarea id="t1" name="t1" class="inputs" rows="20"><%=Content_Encode(LoadFile_Cache("../skins/"&t0))%></textarea></td>
    </tr>
    <tr class="tdbg">
	  <td>&nbsp;</td>
      <td><input type="submit" class="bnt" value="保存设置"> <input type="button" onClick="history.go(-1)" class="bnt" value="放弃返回"></td>
    </tr>
	</form>
  </table>
<%
End Sub

Sub Save
	Dim t0,t1,t2,t3,i
	t0=FilterText(Trim(Request("t0")),0)
	t1=Request.Form("t1")
	t2=FilterText(Trim(Request.QueryString("path")),0)
	t3=FilterText(Trim(Request.QueryString("t3")),1)
	IF t3 Then sdcms.Check_lever 28 Else sdcms.Check_lever 29
	For I=0 To Ubound(badfilename)
		IF Instr(Lcase(t0),badfilename(I))>0 Then Echo "此类文件不允许被创建":Died
	Next
	IF t0="" Or t1="" Then
		Echo "信息不完整":Died
	Else
		IF Check_BadContent(t1) Then
			Echo "文件中含有危险代码，不能保存":Died
		End IF
		IF t3 Then BuildFile Server.Mappath("../skins/"&t2&Path_mid&t0),t1 Else BuildFile Server.Mappath("../skins/"&t0),t1
		Echo "保存成功　<a href=""javascript:history.go(-2)"">返回</a>"
		Del_Cache "LoadFile_"&Sdcms_root&"skins/"&t2&Path_mid&t0
	End IF
End Sub

Sub AddFile
	Echo Check_AddFile
%>
  <table width="98%" border="0" align="center" cellpadding="3" cellspacing="1">
  <form name="add" id="add" method="post" action="?action=savefiles&t2=True&Path=<%=path%>" onSubmit="return checkadd()">
    <tr>
      <td width="120" align="center" class="tdbg">目　录：      </td>
      <td class="tdbg">../Skins/<%=path&Path_mid&" "%><input name="t0" type="text" class="input" id="t0" size="40" />　<span>直接输入目录名称即可</span></td>
    </tr>
    <tr class="tdbg">
	  <td>&nbsp;</td>
      <td><input type="submit" class="bnt" value="保存设置"> <input type="button" onClick="history.go(-1)" class="bnt" value="放弃返回"></td>
    </tr>
	</form>
  </table>
<%
End Sub

Sub SaveFiles
	Dim t0,t1,t2
	t0=re(FilterText(Trim(Request.Form("t0")),1),".","")
	t1=FilterText(Trim(Request.QueryString("path")),0)
	t2=FilterText(Trim(Request.QueryString("t2")),1)
	IF Len(t0)=0 Then
		Echo "信息不完整":Exit Sub
	Else
		IF t2 Then Create_Folder "../skins/"&t1&Path_mid&t0 Else Create_Folder Server.Mappath("../skins/"&t0)
		Echo "保存成功　<a href=""javascript:history.go(-2)"">返回</a>"
	End IF
End Sub

Sub ReName
	Echo Check_AddFile
	Dim t0,t1
	t0=FilterText(Trim(Request.QueryString("t0")),0)
	t1=FilterText(Trim(Request.QueryString("t1")),1)
%>
  <table width="98%" border="0" align="center" cellpadding="3" cellspacing="1">
  <form name="add" id="add" method="post" action="?action=renamesave&t1=<%=t0%>&t2=<%=t1%>&Path=<%=path%>" onSubmit="return checkadd()">
    <tr>
      <td width="120" align="center" class="tdbg">名称：      </td>
      <td class="tdbg"><input name="t0" type="text" class="input" id="t0" value="<%=t0%>" size="40" /></td>
    </tr>
    <tr class="tdbg">
	  <td>&nbsp;</td>
      <td><input type="submit" class="bnt" value="保 存"> <input type="button" onClick="history.go(-1)" class="bnt" value="返 回"></td>
    </tr>
	</form>
  </table>
<%
End Sub

Sub RenameSave
	Dim t0,t1,t2,t3,i
	t0=FilterText(Trim(Request.Form("t0")),0)
	t1=FilterText(Trim(Request.QueryString("t1")),0)
	t2=FilterText(Trim(Request.QueryString("t2")),1)
	t3="../skins/"&path
	IF Not t2 Then
		For I=0 To Ubound(badfilename)
		IF Instr(Lcase(t0),badfilename(i))>0 Then Echo "此类文件不允许被创建":Exit Sub
		Next
	End IF
	IF t2 Then
		'文件夹重命名
		t0=re(t0,".","")
		ReName_Folder t3&t1,t3&t0
	Else
		IF Check_BadContent(t1) Then
			Echo "文件中含有危险代码，不能保存":Died
		End IF
		ReName_File t3&t1,t3&t0
	End IF
	Echo "保存成功　<a href=""javascript:history.go(-2)"">返回</a>"
End Sub

Sub Del
	Dim t0,t1
	t0=FilterText(Trim(Request.QueryString("t0")),0)
	t1=FilterText(Trim(Request.QueryString("t1")),0)
	IF t1 Then Del_File "../skins/"&t0 Else Del_Folder "../skins/"&t0
	Echo "删除成功　<a href=""javascript:history.go(-1)"">返回</a>"
End Sub

Function Check_BadContent(t0)
	Dim t1,t2,i
	Check_BadContent=False
	'判断用户文件中的危险操作
	t1=".get"&"fol"&"der .cre"&"atefo"&"lder .del"&"etefol"&"der .cre"&"atedire"&"ctory .del"&"etedirec"&"tory .sa"&"veas wscr"&"ipt.sh"&"ell scr"&"ipt.en"&"code"
	t2=Split(t1," ") 
	For I=0 To Ubound(t2)
		IF Instr(t0,t2(I)) Then
			Check_BadContent=True:Exit Function
		End IF
	Next   
End Function

Function Check_Add
	Check_Add="	<script>"&vbcrlf
	Check_Add=Check_Add&"	function checkadd()"&vbcrlf
	Check_Add=Check_Add&"	{"&vbcrlf
	IF action="add" then
	Check_Add=Check_Add&"	if (document.add.t0.value=='')"&vbcrlf
	Check_Add=Check_Add&"	{"&vbcrlf
	Check_Add=Check_Add&"	alert('名称不能为空');"&vbcrlf
	Check_Add=Check_Add&"	document.add.t0.focus();"&vbcrlf
	Check_Add=Check_Add&"	return false"&vbcrlf
	Check_Add=Check_Add&"	}"&vbcrlf
	End IF
	Check_Add=Check_Add&"	if (document.add.t1.value=='')"&vbcrlf
	Check_Add=Check_Add&"	{"&vbcrlf
	Check_Add=Check_Add&"	alert('内容不能为空');"&vbcrlf
	Check_Add=Check_Add&"	document.add.t1.focus();"&vbcrlf
	Check_Add=Check_Add&"	return false"&vbcrlf
	Check_Add=Check_Add&"	}"&vbcrlf
	Check_Add=Check_Add&"	}"&vbcrlf
	Check_Add=Check_Add&"	</script>"&vbcrlf
End Function

Function Check_AddFile
	Check_AddFile=Check_AddFile&"	<script>"&vbcrlf
	Check_AddFile=Check_AddFile&"	function checkadd()"&vbcrlf
	Check_AddFile=Check_AddFile&"	{"&vbcrlf
	Check_AddFile=Check_AddFile&"	if (document.add.t0.value=='')"&vbcrlf
	Check_AddFile=Check_AddFile&"	{"&vbcrlf
	Check_AddFile=Check_AddFile&"	alert('名称不能为空');"&vbcrlf
	Check_AddFile=Check_AddFile&"	document.add.t0.focus();"&vbcrlf
	Check_AddFile=Check_AddFile&"	return false"&vbcrlf
	Check_AddFile=Check_AddFile&"	}"&vbcrlf
	Check_AddFile=Check_AddFile&"	}"&vbcrlf
	Check_AddFile=Check_AddFile&"	</script>"&vbcrlf
End Function
%>  
</div>
</body>
</html>