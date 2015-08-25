<!--#include file="Sdcms_check.asp"-->
<!--#include file="../Inc/Upload.asp"-->
<!--#include file="../Inc/AspJpeg.asp"-->
<%
Dim Sdcms,Up_Max,Up_Field,Up_Iframe,Up_Thumb,Up_Jpeg,Action
Set Sdcms=New Sdcms_Admin
Sdcms.Check_admin
Sdcms.Check_lever ""
Set Sdcms=Nothing
Action=Lcase(Trim(Request("Action")))
Up_Max=IsNum(Trim(Request("t0")),1)
Up_Field=Trim(Request("t1"))
Up_Iframe=Trim(Request("t2"))
Up_Thumb=IsNum(Trim(Request("t3")),0)
Up_Jpeg=IsNum(Trim(Request("t4")),0)
IF Up_Max=1 Then Sdcms_upfiletype="Jpeg|Jpg|Gif|Png|Bmp|Swf"
Select Case Action
	Case "add":Save_Upfile
	Case Else:Main
End Select
Sub Save_Upfile
	Dim i,Filename,formPath,Err_Link,File_Type
	Echo "<style type=""text/css""> "
	Echo "*{margin:0;padding:0;font:12px;}"
	Echo "</style>"
	Echo "<script src=""../editor/jquery.js""></script>"
	Echo "<body>"
	Dim sUploadDir:sUploadDir=UploadDir("")
	Create_Folder(Left(sUploadDir,(Len(sUploadDir)-1)))
	Set Sdcms=New UpLoadClass
		'允许上传的文件类型
		Sdcms.FileType=Sdcms_upfiletype
		'文件上传的目录
		Sdcms.SavePath=sUploadDir
		Sdcms.Charset=CharSet
		Sdcms.MaxSize=Sdcms_upfileMaxSize
		Sdcms.AutoSave=0
		Sdcms.Open()
		For I=2 to Ubound(Sdcms.FileItem)
			Filename=Sdcms.SavePath&formPath&Sdcms.Form(Sdcms.FileItem(I))
			Err_Link="<a Href=""?t0="&Up_Max&"&t1="&Up_Field&"&t2="&Up_Iframe&"&t3="&Up_Thumb&"&t4="&Up_Jpeg&""">重新上传</a>"
			Select Case Sdcms.Form(Sdcms.FileItem(I)&"_Err")
				Case -1:Echo"没有文件上传,"&Err_Link:Died
				Case 1: Echo"文件过大，上传失败,"&Err_Link:Died
				Case 2: Echo"不允许被上传的文件,"&Err_Link:Died
				Case 3: Echo"文件过大，且不允许被上传而未被保存,"&Err_Link:Died
				Case 4:	Echo"文件保存失败,"&Err_Link:Died
			End Select
			
			Select Case Lcase(Right(Filename,3))
				Case "jpg","gif","png","peg","bmp":File_Type=0
				Case "swf",".rm","wma","mp3","wmv","mvb","avi":File_Type=1
				Case "flv":File_Type=2
				Case Else:File_Type=3
			End Select
			IF File_Type=0 Then
				IF Up_Thumb=1 Then Jpeg_Thumb(Filename)
				IF Up_Jpeg=1 Then Sdcms_Jpeg(Filename)
			End IF
			IF Up_Max>1 Then
				Echo "<script>parent.editor.appendHTML('"
				Select Case File_Type
				Case 0:Echo "<Img src="""&Filename&""">"
				Case 1:Echo "<Embed src="""&Filename&""" width=""400"" height=""300""></embed>"
				Case 2:Echo "[Flv width=""400"" height=""300""]"&Filename&"[/Flv]"
				Case Else:Echo "附件下载：<a href="""&Filename&""" Target=""_blank"">"&Filename&"</a>"
				End Select
				Echo "')</script>"
			Else
				Echo "<script>$('#"&Up_Field&"',window.parent.document)[0].value='"&filename&"';</script>"
			End IF
			IF File_Type=0 Then
				'Echo "<script>$(""#uploadList"",window.parent.document).append('<option value="""&filename&""">"&filename&"</option>');</script>"
			End IF
		Next
		IF Len(Filename)=0 Then
			Echo "<a Href=""?t0="&Up_Max&"&t1="&Up_Field&"&t2="&Up_Iframe&"&t3="&Up_Thumb&"&t4="&Up_Jpeg&""">请先添加附件</a>"
		Else
			Echo "文件上传成功,<a Href=""?t0="&Up_Max&"&t1="&Up_Field&"&t2="&Up_Iframe&"&t3="&Up_Thumb&"&t4="&Up_Jpeg&""">继续上传</a>"
			IF Up_Max>1 Then Echo "<script>$(""#"&Up_Iframe&""",window.parent.document)[0].style.height='18px';</script>"
		End IF
	Set Sdcms=Nothing
End Sub
Sub Main
%>
<html> 
<head> 
<title>SDCMS多文件上传</title> 
<script type="text/javascript"> 
function MultiSelector(list_target, max) 
{ 
this.list_target = list_target; 
this.count = 0; 
this.id = 0; 
var o=parent.document.getElementById("<%=Up_Iframe%>");
if (max){this.max = max;}else{this.max = -1;} 
this.addElement = function(element) 
{ 
if (element.tagName == 'INPUT' && element.type == 'file') 
{ 
element.name = 'file_' + this.id++; 
element.multi_selector = this; 
element.onchange = function() 
{ 
var inputs = document.getElementsByTagName("input"); 
var count = 0; 
var total=inputs.length;
for(var i=0;i <inputs.length;i++) 
{ 
if (inputs[i].type == 'file') 
{ 
if(this.value==inputs[i].value) 
{ 
count++; 
} 
}
}
<%IF Up_Max=1 Then%>
if(total>1) 
{ 
alert("只允许上传一个文件"); 
return false; 
}
<%End IF%>
if(count>1) 
{ 
alert("该文件已存在！"); 
return false; 
} 
if(!this.value.IsPicture()) 
{ 
alert("不允许上传此类文件"); 
return false; 
} 

var new_element=document.createElement('input'); 
new_element.type='file'; 
new_element.size=1; 
new_element.className="addfile"; 
this.parentNode.insertBefore(new_element, this); 
this.multi_selector.addElement(new_element); 
this.multi_selector.addListRow(this); 
this.style.position ='absolute'; 
this.style.left='0px'; 
} 
if (this.max != -1 && this.count >= this.max<%IF Up_Max>1 Then%>-1<%End IF%>) 
{ 
element.disabled = true; 
} 
this.count++; 
this.current_element = element; 
<%IF Up_Max>1 Then%>(o.style||o).height=(parseInt(this.count)*16)+'px';<%End IF%>
} 
else 
{ 
alert('Error: not a file input element'); 
} 
} 
this.addListRow = function(element) 
{ 
var new_row = document.createElement('div'); 
new_row.className="divName"; 
var a = document.createElement("a"); a.title = "删除";a.innerHTML = "删除"; a.href = "javascript:void(0);";
new_row.element = element; 
a.onclick = function() 
{ 
this.parentNode.element.parentNode.removeChild(this.parentNode.element); 
this.parentNode.parentNode.removeChild(this.parentNode); 
this.parentNode.element.multi_selector.count--; 
<%IF Up_Max>1 Then%>(o.style||o).height=(parseInt(this.parentNode.element.multi_selector.count)*16)+'px';<%End IF%>
this.parentNode.element.multi_selector.current_element.disabled = false; 

return false; 
} 
var filename = element.value.substring(element.value.lastIndexOf("\\")+1)+"　"; 
new_row.innerHTML = filename; 
new_row.appendChild(a); 
this.list_target.appendChild(new_row); 
} 
} 
String.prototype.IsPicture = function() 
{ 
<%
Dim jstype,js_type,i
jstype=""
js_type=Split(Sdcms_upfiletype,"|")
For i=0 to ubound(js_type)
jstype=jstype&"."&Lcase(js_type(i))&"|"
Next
%>
var strFilter="<%=jstype%>" ;
if(this.indexOf(".")>-1) 
{ 
	var p = this.lastIndexOf("."); 
	var strPostfix=this.substring(p,this.length) + '|'; 
	strPostfix = strPostfix.toLowerCase(); 
	if(strFilter.indexOf(strPostfix)>-1) 
	{ 
		return true; 
	} 
} 
return false; 
}
</script> 

<style type="text/css"> 
*{margin:0;padding:0;font:12px;}
a.addfile{display:block;float:left;height:20px;margin-top:-1px;position:relative;text-decoration:none;top:0pt;width:80px;cursor:pointer;}
a:hover.addfile{display:block;float:left;height:20px;margin-top:-1px;position:relative;text-decoration:none;top:0pt;width:80px;cursor:pointer;}
input.addfile{cursor:pointer;height:20px;position:absolute;margin:0px 0 0 -75px;width:1px;filter:alpha(opacity=0);opacity:0;}
.bnt{background:#fff;border:0;text-decoration:underline;color:#00f;}
<%IF Up_Max>1 Then%>#files_list div{clear:both;margin-top:2px;}<%Else%>#files_list div{position:absolute;}<%End IF%>
.divName{float:left;padding-left:5px;}
form span{color:#999;}
.input{position:absolute;margin:-4px 0 0 0;}
</style> 
</head> 
<body> 
<form id="form1" method="post" action="?Action=add&t0=<%=Up_Max%>&t1=<%=Up_Field%>&t2=<%=Up_Iframe%>&t3=<%=Up_Thumb%>&t4=<%=Up_Jpeg%>" enctype="multipart/form-data"> 
<a href="javascript:void(0);" title="点击添加附件">添加附件<input id="my_file_element"  class="addfile" size="1" type="file" hideFocus /></a>　<a href="javascript:form1.submit()">上传附件</a>　<%IF Up_Max>1 Then%>(<span><%=Up_Max%>个/次，上传类型：<%=Sdcms_upfiletype%></span>)<%End IF%></span><span id="files_list"></span><script type="text/javascript"> 
var multi_selector = new MultiSelector(document.getElementById('files_list'),<%=Up_Max+1%>); 
multi_selector.addElement(document.getElementById('my_file_element')); 
</script>
</form>
<%End Sub%>
</body> 
</html>