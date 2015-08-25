<!--#include file="../Include/Const.asp" -->
<!--#include file="../Include/ConnSiteData.asp" -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head> 
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"> 
<title>数据库管理</title> 
<link rel="stylesheet" href="Images/Admin_style.css">
<script language="javascript" src="../Scripts/Admin.js"></script>
</head> 
  
<body> 
<% 
Dim fso,f,f1,fc 
action=request("action") 
'SunlyFName=request("SunlyFName") 
select case action 
case "beifen" 
Set fso = CreateObject("Scripting.FileSystemObject") 
file1=fso.GetParentfoldername(server.MapPath("./"))&"\Database\"&SiteDataAccess 
file2=fso.GetParentfoldername(server.MapPath("./"))&"\Database\"&request.Form("SunlyFName") 
fso.copyfile file1,file2 
set fso=nothing 
response.Write("备份成功<br>"&file1&"=>"&file2) 
response.Write("<meta http-equiv='refresh' content='1;URL=ChinaQJ_Data2.asp'>") 
case "huanyuan" 
Set fso = CreateObject("Scripting.FileSystemObject") 
file1=fso.GetParentfoldername(server.MapPath("./"))&"\Database\"&SiteDataAccess 
file2=fso.GetParentfoldername(server.MapPath("./"))&"\Database\"&request.Form("SunlyFName") 
fso.copyfile file2,file1 
set fso=nothing 
response.Write("恢复成功<br>"&file1&"=>"&file2) 
response.Write("<meta http-equiv='refresh' content='1;URL=ChinaQJ_Data2.asp'>") 
case else 
dataform 
end select 
  
function dataform() 
%> 
<table width="100%"   border="0" cellspacing="0" cellpadding="0"> 
	<tr> 
		<td colspan="3"><div align="center">数据库管理</div></td> 
	</tr> 
	<tr> 
		<td width="28%"><div align="right">备份：</div></td> 
		<form name="form1" method="post" action="ChinaQJ_Data2.asp?action=beifen"><td width="56%"> 
			<input name="SunlyFName" type="text" id="SunlyFName" style="width:200px " value="<%= SunlyFName()%>"> 
			<input type="submit" name="Submit" value="开始备份" class="button1" onmouseover=this.className="button2"; onmouseout=this.className="button1";> 
		</td></form> 
		<td width="16%">&nbsp;</td> 
	</tr> 
	<tr> 
		<td><div align="right">还原：</div></td> 
		<form name="form3" method="post" action="ChinaQJ_Data2.asp?action=huanyuan"><td> 
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
			<input type="submit" name="Submit" value="开始恢复" class="button1" onmouseover=this.className="button2"; onmouseout=this.className="button1"; onClick="if(confirm('真的还原么')){return true;}else{return false;}"> 
		</td></form> 
		<td>&nbsp;</td> 
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
%> 
</body> 
</html>