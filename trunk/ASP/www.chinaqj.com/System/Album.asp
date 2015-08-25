<!--#include file="../Include/Const.asp" -->
<!--#include file="../Album/Album.asp" -->
<!--#include file="../Include/ConnSiteData.asp" -->
<!--#include file="CheckAdmin.asp"-->

<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="Images/Admin_style.css">
<br />
<%
dim Action
Action=Trim(Request.QueryString("Action"))
%>
<table class="tableBorder" width="95%" border="0" align="center" cellpadding="5" cellspacing="1">
  <form name="editForm" method="post" action="?Action=SaveEdit">
    <tr>
      <th height="22" colspan="2" sytle="line-height: 150%;">【配置、发布企业相册数据】</th>
    </tr>
    <tr>
      <td width="200" class="forumRow">企业相册标题：</td>
      <td class="forumRowHighlight"><input name="SiteTitle" type="text" value="<%= SiteTitleAlbum %>" style="width: 280px;">
        <font color="red">*</font></td>
    </tr>
    <tr>
      <td width="200" class="forumRow">产品缩略图路径：</td>
      <td class="forumRowHighlight"><input name="Thumbnail" type="text" value="<%= Thumbnail %>" style="width: 280px;">
        <font color="red">* 默认，如无特别需要请勿更改。</font></td>
    </tr>
    <tr>
      <td class="forumRow">产品大图路径：</td>
      <td class="forumRowHighlight"><input name="Enlarge" type="text" value="<%= Enlarge %>" style="width: 280px;">
        <font color="red">* 默认，如无特别需要请勿更改。</font></td>
    </tr>
    <tr>
      <td class="forumRow"></td>
      <td class="forumRowHighlight"><input name="submitSaveEdit" type="submit" id="submitSaveEdit" value="配置、发布企业相册数据"></td>
    </tr>
  </form>
</table>
<center><font color="#CC0000">说明：Flash产品相册调用产品模块小图、大图数据；系统自动配置，无须人工干预。</font></center>
<br />
<%
If Action="SaveEdit" Then
Set objStream = Server.CreateObject("ADODB.Stream") 
With objStream 
.Open 
.Charset = "utf-8" 
.Position = objStream.Size 
 hf = "<" & "%" & vbcrlf
 hf = hf & "Const SiteTitleAlbum = " & chr(34) & trim(request("SiteTitle")) & chr(34) & "" & vbcrlf
 hf = hf & "Const Thumbnail = " & chr(34) & trim(request("Thumbnail")) & chr(34) & "" & vbcrlf
 hf = hf & "Const Enlarge = " & chr(34) & trim(request("Enlarge")) & chr(34) & "" & vbcrlf

 hf = hf & "%" & ">"
.WriteText=hf 
.SaveToFile Server.mappath("../Album/Album.asp"),2 
.Close 
End With 
Set objStream = Nothing


vDir = "../Album/" '制作SiteMap的目录,相对目录(相对于根目录而言)

set objfso = CreateObject("Scripting.FileSystemObject")
root = Server.MapPath(vDir)

str = "<?xml version='1.0' encoding='UTF-8'?>" & vbcrlf
str = str & "	<gallery title="""&trim(request("SiteTitle"))&""" thumbDir="""&trim(request("Thumbnail"))&""" imageDir="""&trim(request("Enlarge"))&""" random=""true"">" & vbcrlf

dim IDs,IDsid
sql="select distinct SortID from ChinaQJ_Products where ViewFlagCh"
set rs=server.createobject("adodb.recordset")
rs.open sql,conn,0,1
if rs.eof and rs.bof then
Response.Write("")
else
while(not rs.eof)
IDs= IDs & rs("SortID") & "$$$"
rs.movenext
wend
end if
rs.close
set rs=nothing
IDs=Split(IDs,"$$$")
If Not(IsNull(IDs)) Then
for IDsid=0 to ubound(IDs)-1

sql="select ProductNameCh,SmallPic,BigPic,UpdateTime from ChinaQJ_Products where SortID="&trim(IDs(IDsid))
set rs=server.createobject("adodb.recordset")
rs.open sql,conn,1,1
if rs.eof and rs.bof then
Response.Write("")
else

sql2="select SortNameCh,SortNameEn from ChinaQJ_ProductSort where id="&trim(IDs(IDsid))
set rs2=server.createobject("adodb.recordset")
rs2.open sql2,conn,0,1
SortName=rs2("SortNameCh")
'SortName=rs2("SortNameEn")
rs2.close
set rs2=nothing

str = str & "	  <category name="""&SortName&""">" & vbcrlf
while(not rs.eof)
str = str & "    <image>" & vbcrlf
str = str & "      <date>"&rs("UpdateTime")&"</date>" & vbcrlf
str = str & "      <title>"&left(rs("ProductNameCh"),12)&"</title>" & vbcrlf
str = str & "      <desc>"&rs("ProductNameCh")&"</desc>" & vbcrlf
str = str & "      <thumb>"&replace(rs("SmallPic"),"/uploadfile/","")&"</thumb>" & vbcrlf
str = str & "      <img>"&replace(rs("BigPic"),"/uploadfile/","")&"</img>" & vbcrlf
str = str & "    </image>" & vbcrlf
rs.movenext
wend
str = str & "	  </category>" & vbcrlf
end if
rs.close
set rs=nothing

Next
end if

str = str & "</gallery>" & vbcrlf
set fso = nothing

Set objStream = Server.CreateObject("ADODB.Stream")
With objStream
'.Type = adTypeText
'.Mode = adModeReadWrite
.Open
.Charset = "utf-8"
.Position = objStream.Size
.WriteText=str
.SaveToFile server.mappath(vDir&"AlbumCh.xml"),2 '生成的XML文件名
.Close
End With


set objfso = CreateObject("Scripting.FileSystemObject")
root = Server.MapPath(vDir)

str = "<?xml version='1.0' encoding='UTF-8'?>" & vbcrlf
str = str & "	<gallery title="""&trim(request("SiteTitle"))&""" thumbDir="""&trim(request("Thumbnail"))&""" imageDir="""&trim(request("Enlarge"))&""" random=""true"">" & vbcrlf

dim IDsEn,IDsidEn
sql="select distinct SortID from ChinaQJ_Products where ViewFlagEn"
set rs=server.createobject("adodb.recordset")
rs.open sql,conn,0,1
if rs.eof and rs.bof then
Response.Write("")
else
while(not rs.eof)
IDsEn= IDsEn & rs("SortID") & "$$$"
rs.movenext
wend
end if
rs.close
set rs=nothing
IDsEn=Split(IDsEn,"$$$")
If Not(IsNull(IDsEn)) Then
for IDsidEn=0 to ubound(IDsEn)-1

sql="select ProductNameEn,SmallPic,BigPic,UpdateTime from ChinaQJ_Products where SortID="&trim(IDsEn(IDsidEn))
set rs=server.createobject("adodb.recordset")
rs.open sql,conn,1,1
if rs.eof and rs.bof then
Response.Write("")
else

sql2="select SortNameCh,SortNameEn from ChinaQJ_ProductSort where id="&trim(IDsEn(IDsidEn))
set rs2=server.createobject("adodb.recordset")
rs2.open sql2,conn,0,1
SortName=rs2("SortNameCh")
'SortName=rs2("SortNameEn")
rs2.close
set rs2=nothing

str = str & "	  <category name="""&SortName&""">" & vbcrlf
while(not rs.eof)
str = str & "    <image>" & vbcrlf
str = str & "      <date>"&rs("UpdateTime")&"</date>" & vbcrlf
str = str & "      <title>"&left(rs("ProductNameEn"),20)&"</title>" & vbcrlf
str = str & "      <desc>"&rs("ProductNameEn")&"</desc>" & vbcrlf
str = str & "      <thumb>"&replace(rs("SmallPic"),"/uploadfile/","")&"</thumb>" & vbcrlf
str = str & "      <img>"&replace(rs("BigPic"),"/uploadfile/","")&"</img>" & vbcrlf
str = str & "    </image>" & vbcrlf
rs.movenext
wend
str = str & "	  </category>" & vbcrlf
end if
rs.close
set rs=nothing

Next
end if

str = str & "</gallery>" & vbcrlf
set fso = nothing

Set objStream = Server.CreateObject("ADODB.Stream")
With objStream
'.Type = adTypeText
'.Mode = adModeReadWrite
.Open
.Charset = "utf-8"
.Position = objStream.Size
.WriteText=str
.SaveToFile server.mappath(vDir&"AlbumEn.xml"),2 '生成的XML文件名
.Close
End With

 response.Write "<script language=javascript>alert('企业相册设置成功！');location.href='Album.asp';</script>"
end if
%>
