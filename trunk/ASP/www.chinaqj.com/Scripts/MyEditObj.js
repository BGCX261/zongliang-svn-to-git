// JavaScript Document
var $i = function(id){if(typeof(id) == "string"){return document.getElementById(id);}else{return id;}};
var isIE = !!window.ActiveXObject;
function checkIsNull(inputid,txtid,txtinfo)
{
	if($i(inputid) == null) return true;
	if($i(inputid).value == "" || $i(inputid).value.replace(/(^\s+)|(\s+$i)/g,"") == ""){
		if($i(txtid) != null) $i(txtid).innerHTML = txtinfo || '该项不能为空!';
		$i(inputid).select();
		$i(inputid).focus();
		return false;
	} else	{
		if($i(txtid) != null) $i(txtid).innerHTML = "";
		return true;
	}
}

function checkIsSame(inputid,inputids,txtid,txtinfo)
{
	if($i(inputid) == null) return true;
	if($i(inputid).value != $i(inputids).value) {
		if($i(txtid) != null) $i(txtid).innerHTML = txtinfo || '输入不一致!';
		$i(inputids).select();
		$i(inputids).focus();
		return false;
	} else	{
		if($i(txtid) != null) $i(txtid).innerHTML = "";
		return true;
	}
}

function checkIsNaN(inputid,txtid,txtinfo)
{
	if($i(inputid) == null) return true;
	var checkreplace = /[0-9]/g;
	if($i(inputid).value.replace(checkreplace,"") != "") {
		if($i(txtid) != null) $i(txtid).innerHTML = txtinfo || '该项只能为数字!';
		$i(inputid).select();
		$i(inputid).focus();
		return false;
	} else {
		if($i(txtid) != null) $i(txtid).innerHTML = "";
		return true;	
	}
}
function checkValLength(inputid,txtid,minlen,maxlen,txtinfo)
{
	if($i(inputid) == null)
		return true;
	if($i(inputid).value.length < minlen || $i(inputid).value.length > maxlen){
		if($i(txtid) != null)
		{
			//var info1 = "长度有误!";
			var info = '长度有误'+minlen+'-'+maxlen;
			$i(txtid).innerHTML = txtinfo;
		}
		$i(inputid).select();
		$i(inputid).focus();
		return false;
	} else	{
		if($i(txtid) != null) $i(txtid).innerHTML = "";
		return true;
	}
}

function checkObject(inputid,txtid,txtinfo,ckreg)
{
	if($i(inputid) == null) return true;
	if($i(inputid).value.replace(ckreg,"") != "") {
		if($i(txtid) != null) $i(txtid).innerHTML = txtinfo || '输入内容格式错误!';
		$i(inputid).select();
		$i(inputid).focus();
		return false;
	} else {
		if($i(txtid) != null) $i(txtid).innerHTML = "";
		return true;	
	}
}

var P = function(Name)
{
	var script = document.getElementsByTagName("script");

	var i = 0;
	while(script[i] != null){var obj = script[i]; i++;}
	
	var Parameters = obj.src.split("?");
	i = 0;
	while(Parameters[i] != null){i++;}
	var str = Parameters[i-1].split("&");
	i = 0;
	while(str[i] != null) {
		var keys = str[i].split("=");
		var j = 0,value = "";
		while(keys[j] != null) {
			if(j != 0) value = value + keys[j];
			j++;
		}
		if(keys[0] == Name) return value;
		i++;
	}
}

// check Img
function checkImage(obj,w,h)
{
	var objCon = document.getElementById(obj);
	var ImgCell = objCon.getElementsByTagName('img');
	for(var i=0; i<ImgCell.length; i++)
	{
		var ImgWidth = ImgCell(i).width;
		var ImgHeight = ImgCell(i).height;
		if(ImgWidth > w)
		{
			var newHeight = w*ImgHeight/ImgWidth;
			if(newHeight <= h)
			{
				ImgCell(i).width = w;
				ImgCell(i).height = newHeight;
			}
			else
			{
				ImgCell(i).height = h;
				ImgCell(i).width = h*ImgWidth/ImgHeight;
			}
		}
		else
		{
			if(ImgHeight > h)
			{
				ImgCell(i).height = h;
				ImgCell(i).width = h*ImgWidth/ImgHeight;
			}
			else
			{
				ImgCell(i).width = ImgWidth;
				ImgCell(i).height = ImgHeight;
			}
		}
	}
}

// 本地IMG
function showImg(inputid,showid,imgstyle)
{
	if(imgstyle == null) imgstyle = "max-width:100px; max-height:100px;";
	var input = document.getElementById(inputid);
	var result = document.getElementById(showid);
	if(typeof FileReader === 'undefined'){
		input.onchange = function(){
			var fPath = getfilePath(input);
			fPath = fPath.replace(/\\/g,'/');
			fPath = fPath.replace(/:/g,'|');
			result.innerHTML = '<img src="file:///'+fPath+'" alt="" style="'+imgstyle+'" />';
			//checkImage(showid,100,100);
		}
	}else{
		input.addEventListener('change',readFile,false);
	}
	function readFile()
	{
		var file = this.files[0];
		if(!/image\/\w+/.test(file.type)){
			alert("请确保文件为图像类型");
			return false;
		}
		var reader = new FileReader();
		reader.readAsDataURL(file);
		reader.onload = function(e){
			result.innerHTML = '<img src="'+this.result+'" alt="" style="'+imgstyle+'" />';
		}
	}
	function getfilePath(obj)
	{
		if(obj)	{
			if (window.navigator.userAgent.indexOf("MSIE") >= 1){
				obj.select();
				return document.selection.createRange().text;
			}else if(window.navigator.userAgent.indexOf("Firefox") >= 1){  
				if(obj.files){
					return obj.files.item[0].getAsDataURL();
				}
				return obj.value;
			}  
			return obj.value;
		}
	}
}

// 替换字符串
function RepStr(str)
{
	str = str.replace("<", "&lt;");
	str = str.replace(">", "&gt;");
	str = str.replace("'", "&#039;");
	str = str.replace('"', "&quot;");

	return str;
	
}

var etype=P("type");
var head = document.getElementsByTagName('head').item(0);
if (etype==0){
	CreateScript("/Scripts/ueditor/editor_config.js");
	CreateScript("/Scripts/ueditor/editor_all.js");
	CreateLink("/Scripts/ueditor/themes/default/ueditor.css");
} else {
	CreateScript("/Scripts/kindeditor/kindeditor.js");
	CreateScript("/Scripts/kindeditor/editor/lang/zh_CN.js");
}

// add script js
function CreateScript(file){
    /*
	var new_element;
    new_element=document.createElement("script");
    new_element.setAttribute("type","text/javascript");
    new_element.setAttribute("src",file);
    void(head.appendChild(new_element));
	*/
	document.write("<script language='javascript' src='"+file+"'></script>");
}
// add style css
function CreateLink(file){
    /*	
	var new_element;
    new_element=document.createElement("link");
    new_element.setAttribute("type","text/css");
    new_element.setAttribute("rel","stylesheet");
    new_element.setAttribute("href",file);
    void(head.appendChild(new_element));
	*/
	document.write("<link rel='stylesheet' type='text/css' href='"+file+"'>");	
}

//	Start Edit
function Start_MyEdit(id,value,tool,w,h){
	if(value!=""){value=document.getElementById(value).innerHTML;}
	if(etype==0){
		document.write('<script type="text/plain" id="'+id+'">'+value+'</script>');
		var editor = new baidu.editor.ui.Editor({
			textarea:id,
			toolbars:tool || [['FullScreen', 'Source', '|', 'Undo', 'Redo', '|','Bold', 'Italic', 'Underline', 'StrikeThrough', '|','BlockQuote', '|', 'PastePlain', '|', 'ForeColor', 'BackColor', 'InsertOrderedList', 'InsertUnorderedList','SelectAll', 'ClearDoc', '|','RowSpacingTop', 'RowSpacingBottom','LineHeight', '|','FontFamily', 'FontSize', '|', 'Indent', '|', 'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyJustify', '|', 'Link', 'Unlink', 'Anchor', '|', 'ImageNone', 'ImageLeft', 'ImageRight', 'ImageCenter', '|', 'InsertImage', 'Emotion', 'InsertVideo', 'Attachment', 'Map', 'GMap', 'InsertFrame', 'PageBreak', 'HighlightCode', '|', 'Horizontal', 'Date', 'Time', 'Spechars','SnapScreen', 'WordImage', '|', 'InsertTable', 'DeleteTable','Preview']],
			wordCount:false,
            elementPathEnabled:false
		});
		editor.render(id);
	} else {
		document.write('<textarea name="'+id+'" id="'+id+'" style="width:'+(w||'550px')+'; height:'+(h||'350px')+';" >'+value+'</textarea>');
        var editor;
        KindEditor.ready(function(K) {
			editor = K.create('textarea[name="'+id+'"]', {
				cssPath : '/Scripts/kindeditor/plugins/code/prettify.css',
				uploadJson : '/Scripts/kindeditor/asp/upload_json.asp',
				fileManagerJson : '/Scripts/kindeditor/asp/file_manager_json.asp',
				allowFileManager : true,
				resizeType:2,
				items:tool || ['source', '|', 'fullscreen', 'undo', 'redo', 'print', 'cut', 'copy', 'paste', 'plainpaste', 'wordpaste', '|', 'justifyleft', 'justifycenter', 'justifyright', 'justifyfull', 'insertorderedlist', 'insertunorderedlist', 'indent', 'outdent', 'subscript', 'superscript', '|', 'selectall', '-', 'title', 'fontname', 'fontsize', '|', 'textcolor', 'bgcolor', 'bold', 'italic', 'underline', 'strikethrough', 'removeformat', '|', 'image', 'flash', 'media', 'advtable', 'hr', 'emoticons', 'link', 'unlink',]
				/*	ctrl+enter=submit
				afterCreate : function() {
					var self = this;
					K.ctrl(document, 13, function() {
						self.sync();
						K('form[name=editForm]')[0].submit();
					});
					K.ctrl(self.edit.doc, 13, function() {
						self.sync();
						K('form[name=editForm]')[0].submit();
					});
				}
				*/
			});
		});
	}
}
