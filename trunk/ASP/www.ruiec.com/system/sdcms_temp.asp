<!--#include file="sdcms_check.asp"-->
<base target="_self" />
<%
Dim sdcms,title,Path,Paths,Path_s,Path_mid,Temp_file,Action
Action=Lcase(Trim(Request.QueryString("Action")))
Response.Expires = -1
Response.ExpiresAbsolute = Now() - 1
Response.cachecontrol = "no-cache"
Set Sdcms=New Sdcms_Admin
Sdcms.Check_admin
Set Sdcms=Nothing
Select Case Action
	Case Else:title="模板管理"
End Select
Path=Trim(Request("path"))
Path=Re(Path,".","")
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
 
<%
Main
Db_Run
CloseDb
Sub Main
%>
  <table border="0" align="center" cellpadding="3" cellspacing="1" class="table_b">
    <tr>
      <td class="title_bg" width="300">目录/名称</td> 
    </tr>
	<%
	IF Len(path)>0 Then%>
	<tr onmouseover=this.bgColor='#EEFEED'; onmouseout=this.bgColor='#ffffff';  bgcolor='#ffffff'>
      <td colspan="4"><img src="images/ext/folder.gif" align="absmiddle" /><a href="?">返回根目录</a>　<%IF Instr(path,"/")>0 Then%><img src="images/ext/folder.gif" align="absmiddle" /><a href="?Path=<%=Path_s%>"><%=Path_s%></a><%End IF%></td>
    </tr>
	<%
	End IF
	Dim Fso,FsoFolder,Fsocontent,Fsocount
	Set Fso=CreateObject("Scripting.Filesystemobject")
	IF Not Fso.FolderExists(Server.MapPath(Temp_file)) Then
		Alert "目录错误，请检查风格设置","?"
		Echo "<script>javascript:window.close();</script>":Died
	End IF
	Set FsoFolder=Fso.GetFolder(Server.mappath(Temp_file))
	Set Fsocontent=FsoFolder.files
	For Each Fsocount In FsoFolder.Subfolders
	%>
    <tr onmouseover=this.bgColor='#EEFEED'; onmouseout=this.bgColor='#ffffff';  bgcolor='#ffffff'>
		<td height="25"><%IF Instr(path_mid,"/")>0 Then%>　　<%End IF%><img src="images/ext/folder.gif" align="absmiddle" /><a href="?Path=<%=path&Path_mid&Fsocount.Name%>"><%=Fsocount.Name%></a></td>
    </tr>
	<%
	Next
	Dim FsoItem,EditType,picsrc
	For Each FsoItem in Fsocontent
		EditType=False
		Select Case Lcase(Right(FsoItem.Name,3))
			Case "htm","tml":picsrc="html":EditType=True
			Case ".js":picsrc="js"
			Case "bmp","jpg","gif","png","swf","css","txt","asp","vbs","xml","xsl":picsrc=Right(FsoItem.Name,3)
			Case Else:picsrc="file"
		End Select
	IF Lcase(FsoItem.Name)<>"skins.asp" And Lcase(FsoItem.Name)<>"skin.xml" Then
	%>
    <tr onmouseover=this.bgColor='#EEFEED'; onmouseout=this.bgColor='#ffffff';  bgcolor='#ffffff'>
		<td height="25">　　<img src="images/ext/<%=picsrc%>.gif" align="absmiddle" /><a <%if EditType Then%>onclick="outfilename('<%=Re(Temp_file,"../","")&FsoItem.Name%>')" class="hand"<%end if%>><%=FsoItem.Name%></a></td>
    </tr>
	<%End IF:Next%>
  </table>
<%
Set Fso=Nothing
Set FsoFolder=Nothing
Set Fsocontent=Nothing
End Sub
%>  

<script language="javascript" type="text/javascript">  
function outfilename(msgbody)
{
window.returnValue = msgbody;
this.close();
}
</script>
</body>
</html>