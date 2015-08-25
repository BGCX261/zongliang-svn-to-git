/*function killErrors(){return true;}
window.onerror=killErrors;*/
var Ajax_msg="获取失败";

function Get_Notice(t0,t1){
	var remoteUrl="http://www.sdcms.cn/plug/sdcms_notice.asp?t0="+t0+"";//远程调用URL
	jQuery.getScript(remoteUrl,function(){
	var boxInfoWrapper=jQuery('#'+t1);
	if (t0==1){boxInfoWrapper.html(getBoxHtml(nicedata));}else{boxInfoWrapper.html(getBoxlink(noticedata.url,noticedata.title))}
	});
}

function getBoxHtml(data)
{
	var t2="<dl>";
	for(var e in data) 
	{ 
		t2+="<dt>"+data[e]+"</dt>";
	}
	t2+="</dl>";
	return t2;
}

function getBoxlink(url,title){
	return '<div><a href="'+url+'" target="_blank">'+title+'</a></div>';
}

var lastCtrl = new Object();
function DoLocation(ctrl)
{
	if(ctrl!=lastCtrl){
		lastCtrl.className="left_link";
	}
	ctrl.className="left_link_over";
	lastCtrl = ctrl;
}

function reinitIframe(t0){
	var iframe=$("#"+t0)[0];
	if(document.all&&window.XMLHttpRequest!=undefined)
	{
		var wWidth=document.documentElement.offsetWidth-240;// >ie6
		}
	else
	{
		var wWidth=document.documentElement.offsetWidth-257;
		}
	try{
		var wHeight=window.document.documentElement.offsetHeight-95;
		var bHeight=iframe.contentWindow.document.body.scrollHeight;
		var dHeight=iframe.contentWindow.document.documentElement.scrollHeight;
		var height=Math.max(bHeight,dHeight);
		iframe.width=wWidth;
		if(height<=wHeight)
		{
			iframe.height=wHeight;
			}
		else
		{
			iframe.height=height;
		}
	}catch (ex){}
}

function selectTag(showContent,selfObj){
	// 操作标签
	var tag = $("#sdcms_sub_title")[0].getElementsByTagName("li");
	var taglength = tag.length;
	for(i=0; i<taglength; i++){
		tag[i].className = "unsub";
	}
	selfObj.parentNode.className = "sub";
	// 操作内容
	for(i=0; j=$("#tagContent"+i)[0]; i++){
		j.style.display = "none";
	}
	$('#'+showContent)[0].style.display = "block";
}

function CheckAll(form)
{
  for (var i=0;i<form.elements.length;i++)
    {
    var e = form.elements[i];
    if (e.Name != "chkAll")
       e.checked = form.chkAll.checked;
    }
}

function checkselect(obj,form){ 
	var bool=(obj.checked)?true:false;
	for(var i=0;i<form.length;i++)
	{ 
		form.all[i].selected=bool;
	} 
}

function CopyUrl(target)
{ 
	target.value=get_c.value; 
	target.select();   
	js=get_c.createTextRange();   
	js.execCommand("Copy"); 
	alert("复制成功!"); 
} 

function Display(ID){
	if ($('#'+ID)[0].style.display == "none"){
		$('#'+ID)[0].style.display="block";
	}else{
	    $('#'+ID)[0].style.display="none";
	}
}

function Open_w(t0,t1,t2,t3,t4)
{
	var t5=showModalDialog(t0,t3,'dialogWidth:'+t1+'pt;dialogHeight:'+t2+'pt;status:no;help:no;;');
	if (t5!=null) t4.value=t5;
}


function insertUpload(msg)
{
	msg=msg[0];
	if(msg.indexOf(".jpg")!=-1||msg.indexOf(".jpeg")!=-1||msg.indexOf(".gif")!=-1||msg.indexOf(".png")!=-1||msg.indexOf(".bmp")!=-1)
	{
	 $("#uploadList").append('<option value="'+msg+'">'+msg+'</option>');
	 }
}