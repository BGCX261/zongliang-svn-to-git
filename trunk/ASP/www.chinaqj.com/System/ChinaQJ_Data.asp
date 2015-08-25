<!--#include file="../Include/Const.asp" -->
<!--#include file="../Include/ConnSiteData.asp" -->
<!--#include file="CheckAdmin.asp"-->
<html >
<head> 
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="Images/Admin_style.css">
</head> 
  
<body> 
<% 
set rs=nothing
set conn=nothing

if Trim(Request.QueryString("Action"))="DataBackup" then
Dim fso,f,f1,fc 
BpAction=request("BpAction") 
'SunlyFName=request("SunlyFName") 
select case BpAction 
case "beifen" 
Set fso = CreateObject("Scripting.FileSystemObject") 
file1=fso.GetParentfoldername(server.MapPath("./"))&"\Database\"&SiteDataAccess 
file2=fso.GetParentfoldername(server.MapPath("./"))&"\Database\"&request.Form("SunlyFName")
fso.copyfile file1,file2 
set fso=nothing 
response.Write("备份成功<br>"&file1&"=>"&file2) 
response.Write("<meta http-equiv='refresh' content='1;URL=ChinaQJ_Data.asp?Action=DataBackup'>") 
case "huanyuan" 
Set fso = CreateObject("Scripting.FileSystemObject") 
file1=fso.GetParentfoldername(server.MapPath("./"))&"\Database\"&SiteDataAccess 
file2=fso.GetParentfoldername(server.MapPath("./"))&"\Database\"&request.Form("SunlyFName") 
fso.copyfile file2,file1 
set fso=nothing 
response.Write("恢复成功<br>"&file1&"=>"&file2) 
response.Write("<meta http-equiv='refresh' content='1;URL=ChinaQJ_Data.asp?Action=DataBackup'>")
case else 
dataform 
end select 
  
function dataform() 
%>
<br>
<table class="tableBorder" width="80%" border="0" align="center" cellpadding="5" cellspacing="1">
    <tr height="25">
		<th colspan="2">备份还原数据库管理</th> 
	</tr> 
	<tr> 
		<td align="center" class="forumRow"><div align="right">备份：</div></td>
		<form name="form1" method="post" Action="ChinaQJ_Data.asp?Action=DataBackup&BpAction=beifen"><td class="forumRow">
			<input name="SunlyFName" type="text" id="SunlyFName" style="width:200px " value="<%= SunlyFName()%>"> 
			<input type="submit" name="Submit" value="开始备份" class="button1" onmouseover=this.className="button2"; onmouseout=this.className="button1";>
		</td></form> 
	</tr>
	<tr>
		<td align="center" class="forumRow"><div align="right">还原：</div></td>
		<form name="form3" method="post" Action="ChinaQJ_Data.asp?Action=DataBackup&BpAction=huanyuan"><td class="forumRow"> 
			<select name="SunlyFName" id="SunlyFName" style="width:200px ">
<% 
Dim fso,f,f1,fc 
Set fso = CreateObject("Scripting.FileSystemObject") 
dbpath=fso.GetParentfoldername(server.MapPath("./"))&"\Database" 
Set f = fso.GetFolder(dbpath) 
Set fc = f.Files 
For Each f1 in fc 
temp=split(f1.name,".") 
fileext=temp(ubound(temp)) 
if fileext="bak" then 
response.Write("<option value='"&f1.name&"'>"&f1.name&"</option>") 
end if 
next 
set fso=nothing 
%> 
	</select> 
			<input type="submit" name="Submit" value="开始恢复" class="button1" onmouseover=this.className="button2"; onmouseout=this.className="button1"; onClick="if(confirm('您真的还原吗？')){return true;}else{return false;}">
		</td></form> 
	</tr> 
</table> 
<% 
end function 
  
function SunlyFName() 
SunlyFName=year(now) 
if len(month(now))=1 then 
SunlyFName=SunlyFName&"0"&month(now) 
else 
SunlyFName=SunlyFName&month(now) 
end if 
if len(day(now))=1 then 
SunlyFName=SunlyFName&"0"&day(now) 
else 
SunlyFName=SunlyFName&day(now) 
end if 
if len(hour(now))=1 then 
SunlyFName=SunlyFName&"0"&hour(now) 
else 
SunlyFName=SunlyFName&hour(now) 
end if 
if len(minute(now))=1 then 
SunlyFName=SunlyFName&"0"&minute(now) 
else 
SunlyFName=SunlyFName&minute(now) 
end if 
if len(second(now))=1 then 
SunlyFName=SunlyFName&"0"&second(now) 
else 
SunlyFName=SunlyFName&second(now) 
end if 
SunlyFName=SunlyFName&"."&"bak" 
end function 
end if
'压缩数据库
if Trim(Request.QueryString("Action"))="DataCompact" then
const jet_conn_partial = "provider=microsoft.jet.oledb.4.0; data source=" 
dim strdatabase, strfolder, strfilename 

'################################################# 
'edit the following two lines 
'define the full path to where your database is 
Set fso = CreateObject("Scripting.FileSystemObject") 
strfolder = fso.GetParentfoldername(server.MapPath("./"))&"\Database\"
'enter the name of the database 
strdatabase = SiteDataAccess
'stop editing here 
'################################################## 

private sub dbcompact(strdbfilename) 
dim sourceconn 
dim destconn 
dim ojetengine 
dim ofso 

sourceconn = jet_conn_partial & strfolder & strdatabase 
destconn = jet_conn_partial & strfolder & "temp" & strdatabase 

set ofso = server.createobject("scripting.filesystemobject") 
set ojetengine = server.createobject("jro.jetengine") 

with ofso 

if not .fileexists(strfolder & strdatabase) then 
response.write ("not found: " & strfolder & strdatabase) 
stop 
else 
if .fileexists(strfolder & "temp" & strdatabase) then 
response.write ("something went wrong last time " _ 
& "deleting old database... please try again") 
.deletefile (strfolder & "temp" & strdatabase) 
end if 
end if 
end with 

with ojetengine 
.compactdatabase sourceconn, destconn 
end with 

ofso.deletefile strfolder & strdatabase 
ofso.movefile strfolder & "temp" _ 
& strdatabase, strfolder& strdatabase 

set ofso = nothing 
set ojetengine = nothing 
end sub 

private sub dblist() 
dim ofolders 
set ofolders = server.createobject("scripting.filesystemobject") 
response.write ("<select name=""dbfilename"">") 
for each item in ofolders.getfolder(strfolder).files 
if lcase(right(item, 4)) = ".mdb" then
response.write ("<option value=""" & replace(item, strfolder, "") _ 
& """>" & replace(item, strfolder, "") & "</option>") 
end if 
next 
response.write ("</select>") 

set ofolders = nothing 
end sub 
%> 
<% 
'compact database and tell the user the database is optimized 
select case request.form("cmd") 
case "开始压缩" 
dbcompact request.form("dbfilename")
%>
<br />
<table class="tableBorder" width="80%" border="0" align="center" cellpadding="5" cellspacing="1">
  <tr>
  <td align="center" class="forumRow"><% response.write ("数据库 " & request.form("dbfilename") & " 优化完毕。") %></td>
  </tr>
</table>
<%
end select 
%> 
<br />
<table class="tableBorder" width="80%" border="0" align="center" cellpadding="5" cellspacing="1">
  <tr height="25">
    <th colspan="4">压缩和修复数据库</th>
  </tr>
  <tr>
  <td align="center" class="forumRow"><form method="post" action=""> 
<p><%dblist%>  <input type="submit" value="开始压缩" name="cmd"></p> 
</form></td>
  </tr>
</table>
<% End If %>
</body>
</html>