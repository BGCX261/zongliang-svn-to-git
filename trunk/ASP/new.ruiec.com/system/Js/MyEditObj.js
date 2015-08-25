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

var P = function(Name,def){
	var script = document.getElementsByTagName("script");
	var i = 0;
	while(script[i] != null){var obj = script[i]; i++;}
	var Parameters = obj.src.split("?");
	i = 0;
	while(Parameters[i] != null){i++;}
	if(Name==null) return Parameters[i-1];
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
	return def
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
function RepStr(str,type){
	var myreary = new Array();
	myreary[0] = new Array("<","&lt;");
	myreary[1] = new Array(">","&gt;");
	myreary[2] = new Array("'","&#039;");
	myreary[3] = new Array('"',"&quot;");
	myreary[4] = new Array('&',"&amp;");
	
	/*
	myreary.push(new Array("<","&lt;"));
	myreary.push(new Array(">","&gt;"));
	myreary.push(new Array("'","&#039;"));
	myreary.push(new Array('"',"&quot;"));
	myreary.push(new Array('&',"&amp;"));
	*/
	
	for(var ri = 0; ri < myreary.length; ri++){
		if (type == 0){
			var reg = new RegExp(myreary[ri][0],"g");
			str = str.replace(reg, myreary[ri][1]);
			//str = str.replace(myreary[ri][0], myreary[ri][1]);
		} else {
			var reg = new RegExp(myreary[ri][1],"g");
			str = str.replace(reg, myreary[ri][0]);
			//str = str.replace(myreary[ri][1], myreary[ri][0]);
		}
	}
	return str;
}

var etype = P("type",0);
var this_root = P("root","");
var this_ext = P("ext","asp");
var this_path = document.getElementsByTagName("script")[0].src;//.split("?")[0];
this_path = this_path.substring(0,this_path.lastIndexOf("/")+1);

var head = document.getElementsByTagName('head').item(0);
if (etype==0){
	CreateScript(this_path + "ueditor/editor_config.js");
	CreateScript(this_path + "ueditor/editor_all.js");
	CreateLink(this_path + "ueditor/themes/default/ueditor.css");
} else {
	CreateScript(this_path + "kindeditor/kindeditor.js");
	CreateScript(this_path + "kindeditor/lang/zh_CN.js");
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
	
	document.write("<script language='javascript' charset='utf-8' type='text/javascript' src='"+file+"'></script>");
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

function checkFormOk(obj){
	for(var form = obj.parentNode; form!=document.body; form = form.parentNode){
		if(form.tagName.toUpperCase() == 'FORM'){
			return false;
		}
	}
	return true;
}

//	Start Edit
function Start_MyEdit(id,value,tool,w,h){
	if(value!=""){value=document.getElementById(value).innerHTML;}
	if(etype==0){
		document.write('<script type="text/plain" id="'+id+'">'+RepStr(value,1)+'</script>');

		var editor = new baidu.editor.ui.Editor({
			textarea:id,
			toolbars:tool || [['FullScreen', 'Source', '|', 'Undo', 'Redo', '|','Bold', 'Italic', 'Underline', 'StrikeThrough', '|','BlockQuote', '|', 'PastePlain', '|', 'ForeColor', 'BackColor', 'InsertOrderedList', 'InsertUnorderedList','SelectAll', 'ClearDoc', '|','RowSpacingTop', 'RowSpacingBottom','LineHeight', '|','FontFamily', 'FontSize', '|', 'Indent', '|', 'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyJustify', '|', 'Link', 'Unlink', 'Anchor', '|', 'ImageNone', 'ImageLeft', 'ImageRight', 'ImageCenter', '|', 'InsertImage', 'Emotion', 'InsertVideo', 'Attachment', 'Map', 'GMap', 'InsertFrame', 'PageBreak', 'HighlightCode', '|', 'Horizontal', 'Date', 'Time', 'Spechars','SnapScreen', 'WordImage', '|', 'InsertTable', 'DeleteTable','Preview']],
			wordCount:false,
            elementPathEnabled:false
		});
		editor.render(id);
		if (checkFormOk(document.getElementById(id))) alert("当前Form表单语法错误!可能导致无法正常提交数据.请检查");
	} else {
		document.write('<textarea name="'+id+'" id="'+id+'" style="width:'+(w||'90%')+'; height:'+(h||'350px')+';" >'+value+'</textarea>');
        var editor;
        KindEditor.ready(function(K) {
			editor = K.create('textarea[name="'+id+'"]', {
				cssPath : this_path + 'kindeditor/plugins/code/prettify.css',
				uploadJson : this_path + 'kindeditor/'+this_ext+'/upload_json.'+this_ext,
				fileManagerJson : this_path + 'kindeditor/'+this_ext+'/file_manager_json.'+this_ext,
				allowFileManager : true,
				resizeType:2,
				items:tool || ['source', '|', 'fullscreen', 'undo', 'redo', 'print', 'cut', 'copy', 'paste', 'plainpaste', 'wordpaste', '|', 'justifyleft', 'justifycenter', 'justifyright', 'justifyfull', 'insertorderedlist', 'insertunorderedlist', 'indent', 'outdent', 'subscript', 'superscript', '|', 'selectall', '-', 'title', 'fontname', 'fontsize', '|', 'textcolor', 'bgcolor', 'bold', 'italic', 'underline', 'strikethrough', 'removeformat', '|', 'image', 'flash', 'media', 'advtable', 'hr', 'emoticons', 'link', 'unlink',]
			});
		});
	}
}
