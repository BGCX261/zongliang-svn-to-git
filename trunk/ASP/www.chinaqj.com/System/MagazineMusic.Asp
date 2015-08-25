<!--#include file="../Include/Const.asp" -->
<!--#include file="../Include/ConnSiteData.asp" -->
<!--#include file="Admin_htmlconfig.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="Images/Admin_style.css">
<script language="javascript" src="../Scripts/Admin.js"></script>
<script language="javascript" src="JavaScript/Tab.js"></script>
<script language="javascript" src="../DatePicker/WdatePicker.js"></script>
<script language="javascript">
<!--
function showUploadDialog(s_Type, s_Link, s_Thumbnail){
    var arr = showModalDialog("eWebEditor/dialog/i_upload.htm?style=coolblue&type="+s_Type+"&link="+s_Link+"&thumbnail="+s_Thumbnail, window, "dialogWidth: 0px; dialogHeight: 0px; help: no; scroll: no; status: no");
}
//-->
</script>
<%
if Instr(session("AdminPurview"),"|16,")=0 then
  response.write ("<br /><br /><div align=""center""><font style=""color:red; font-size:9pt; "")>您没有管理该模块的权限！</font></div>")
  response.end
end if
dim Result
Result="Modify"
dim MagazineMusic
call MagazineEdit()
%>
<br />
<table class="tableBorder" width="95%" border="0" align="center" cellpadding="0" cellspacing="1">
  <form name="editForm" method="post" action="MagazineMusic.asp?Action=SaveEdit&Result=<%=Result%>&ID=<%=ID%>">
    <tr>
      <th height="22" colspan="2" sytle="line-height:150%">【电子杂志背景音乐配置】</th>
    </tr>
    <tr>
      <td width="20%" align="right" class="forumRow">杂志细节：</td>
      <td width="80%" class="forumRowHighlight">
<%
if Result="Modify" then
If Not(IsNull(MagazineMusic)) Then
Dim htmlshop
%>
      <input name="Num_1" type="text" id="Num_1" value="<%= ubound(MagazineMusic) %>" size="5" /> 张
        <input type="button" value="设置" onClick="MagazineMusicSet()" />
        <input type="button" value="增加一张"  onClick="MagazineMusicAdd()" />
        <br />
        <span id="Num_1_str">
<% for htmlshop=0 to ubound(MagazineMusic)-1 %>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td height="28"><input name="Show<%= htmlshop+1 %>_Music" type="text" id="Show<%= htmlshop+1 %>_Music" value="<%= trim(MagazineMusic(htmlshop)) %>" style="width: 300" />
              <input type="button" value="上传背景音乐" onclick="showUploadDialog('media', 'editForm.Show<%= htmlshop+1 %>_Music', '')"></td>
          </tr>
        </table>
<% next %>
        </span>
<%
else
%>
      <input name="Num_1" type="text" id="Num_1" value="0" size="5" /> 张
        <input type="button" value="设置" onClick="MagazineMusicSet()" />
        <input type="button" value="增加一张"  onClick="MagazineMusicAdd()" />
        <br />
        <span id="Num_1_str">
        
        </span>
<%
end if
else
%>
      <input name="Num_1" type="text" id="Num_1" value="0" size="5" /> 张
        <input type="button" value="设置" onClick="MagazineMusicSet()" />
        <input type="button" value="增加一张"  onClick="MagazineMusicAdd()" />
        <br />
        <span id="Num_1_str">
        
        </span>
<%
End If
%>
      </td>
    </tr>
    <tr height="35">
      <td align="right" class="forumRow"></td>
      <td class="forumRowHighlight"><input name="submitSaveEdit" type="submit" id="submitSaveEdit" value="保存"> <input type="button" value="返回上一页" onclick="history.back(-1)"></td>
    </tr>
  </form>
</table>
<%
sub MagazineEdit()
  dim Action,rsRepeat,rs,sql
  Action=request.QueryString("Action")
  if Action="SaveEdit" then
    set rs = server.createobject("adodb.recordset")
    if Result="Add" then
	  sql="select * from ChinaQJ_MagazineMusic"
      rs.open sql,conn,1,3
      rs.addnew
	  Num_1=CheckStr(Request.Form("Num_1"),1)
	  if Num_1="" then Num_1=0
	  if Num_1>0 then
		For i=1 to Num_1
			If CheckStr(Request.Form("Show"&i&"_Music"),0)<>"" Then
				If MagazineMusic="" then
					MagazineMusic=CheckStr(Request.Form("Show"&i&"_Music"),0)&"*"
				Else
					MagazineMusic=MagazineMusic&CheckStr(Request.Form("Show"&i&"_Music"),0)&"*"
				End if
			End If
		Next
	  end if
	  rs("MagazineMusic")=MagazineMusic
	  rs.update
	  rs.close
	  set rs=Nothing
	  set rs=server.createobject("adodb.recordset")
	end if
	if Result="Modify" then
      sql="select * from ChinaQJ_MagazineMusic"
      rs.open sql,conn,1,3
	  Num_1=CheckStr(Request.Form("Num_1"),1)
	  if Num_1="" then Num_1=0
	  if Num_1>0 then
		For i=1 to Num_1
			If CheckStr(Request.Form("Show"&i&"_Music"),0)<>"" Then
				If MagazineMusic="" then
					MagazineMusic=CheckStr(Request.Form("Show"&i&"_Music"),0)&"*"
				Else
					MagazineMusic=MagazineMusic&CheckStr(Request.Form("Show"&i&"_Music"),0)&"*"
				End if
			End If
		Next
	  end if
	  rs("MagazineMusic")=MagazineMusic
	  rs.update
	  rs.close
	  set rs=Nothing
	  set rs=server.createobject("adodb.recordset")
	end if
	call modxmlfile()
	response.write "<script language='javascript'>alert('设置成功！');location.replace('MagazineMusic.asp');</script>"
  else
	if Result="Modify" then
      set rs = server.createobject("adodb.recordset")
      sql="select * from ChinaQJ_MagazineMusic"
      rs.open sql,conn,1,1
      if rs.bof and rs.eof then
        response.write ("<center>数据库记录读取错误！</center>")
        response.end
      end if
	  MagazineMusic=rs("MagazineMusic")
	  If MagazineMusic<>"" Then
	  MagazineMusic=split(MagazineMusic,"*")
	  end if
	  rs.close
      set rs=nothing
    end if
  end if
end sub

sub modxmlfile()
vDir = ""&SysRootDir&"E-Zine/xml/" '制作SiteMap的目录,相对目录(相对于根目录而言)

set objfso = CreateObject("Scripting.FileSystemObject")
root = Server.MapPath(vDir)

str = "<?xml version=""1.0"" encoding=""UTF-8""?>" & vbcrlf
str = str & "<mp3s>" & vbcrlf
sql="select * from ChinaQJ_MagazineMusic"
set rs=server.createobject("adodb.recordset")
rs.open sql,conn,1,1
if rs.eof and rs.bof then
Response.Write("")
else
MagazineMusic=rs("MagazineMusic")
If MagazineMusic<>"" Then
MagazineMusic=split(MagazineMusic,"*")
for htmlshop=0 to ubound(MagazineMusic)-1
if SysRootDir<>"/" then
str = str & "	<mp3Item mp3Url="""&SysRootDir&MagazineMusic(htmlshop)&"""></mp3Item>" & vbcrlf
else
str = str & "	<mp3Item mp3Url="""&MagazineMusic(htmlshop)&"""></mp3Item>" & vbcrlf
end if
next
end if
end if
rs.close
set rs=nothing
str = str & "</mp3s>" & vbcrlf
set fso = nothing

Set objStream = Server.CreateObject("ADODB.Stream")
With objStream
'.Type = adTypeText
'.Mode = adModeReadWrite
.Open
.Charset = "utf-8"
.Position = objStream.Size
.WriteText=str
.SaveToFile server.mappath(""&vDir&"mp3.xml"),2 '生成的XML文件名
.Close
End With
end sub
%>