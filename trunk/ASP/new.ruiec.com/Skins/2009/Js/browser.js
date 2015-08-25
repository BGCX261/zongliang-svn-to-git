var P = function(Name){
	var script = document.getElementsByTagName("script");
	var i = 0;
	while(script[i] != null){var obj = script[i]; i++;}
	var Parameters = obj.src.split("?");
	i = 0;
	while(Parameters[i] != null){i++;}
	if (Name == ""){return Parameters[i-1];}
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

var v = P("");
var f = "/skins/2009/images/ie/";	//http://www.ie6nomore.com/files/theme/ie6nomore-

var div_bs = document.createElement("div");
div_bs.id = "div_bs";
//div_bs.style.borderBottom = " 1px solid #F7941D";
div_bs.style.background = "#FEEFDA";
div_bs.style.textAlign = "center";
div_bs.style.clear = "both";
div_bs.style.width = "100%";
//div_bs.style.height = "75px";
div_bs.style.position = "relative";
//div_bs.style.display = "none";
div_bs.innerHTML = "&nbsp;";

document.write("<style>body{_background-image:about:blank;_background-attachment:fixed;}</style>");
document.write('<div id="div_objs" style="border-top: 1px solid #F7941D;border-bottom: 1px solid #F7941D;background: #FEEFDA;width:100%;height:75px;z-index:9999; display:none;filter:alpha(opacity=70);opacity:0.7;position:fixed;_position:absolute;top:0px;_top:expression(documentElement.scrollTop);">');//documentElement.scrollTop+documentElement.clientHeight-this.offsetHeight
document.write("<div style='position: absolute; right: 3px; top: 3px; font-family: courier new; font-weight: bold;'><a href='#' onclick='javascript:this.parentNode.parentNode.style.display=\"none\";document.getElementById(\"div_bs\").style.display=\"none\";return false;'><img src='"+f+"cornerx.jpg' style='border: none;' alt='Close this notice'/></a></div><div style='width: 760px; margin: 0 auto; text-align: left; padding: 0; overflow: hidden; color: black;'><div style='width: 75px; float: left;'><img src='"+f+"warning.jpg' alt='Warning!'/></div><div style='width: 300px; float: left; font-family: Arial, sans-serif;'><div style='font-size: 14px; font-weight: bold; margin-top: 12px;'>\u60a8\u6b63\u5728\u4f7f\u7528\u5df2\u7ecf\u8fc7\u65f6\u7684 <span style='color:red'>"+v+"</span> \u6d4f\u89c8\u5668\uff01</div><div style='font-size: 12px; margin-top: 6px; line-height: 12px;'>\u7531\u4e8e <span style='color:red'>"+v+"</span> \u7684\u5b89\u5168\u95ee\u9898\u4ee5\u53ca\u5bf9\u4e92\u8054\u7f51\u6807\u51c6\u7684\u652f\u6301\u95ee\u9898\uff0c\u5efa\u8bae\u60a8\u5347\u7ea7\u60a8\u7684\u6d4f\u89c8\u5668\uff0c\u4ee5\u8fbe\u5230\u66f4\u597d\u7684\u6d4f\u89c8\u6548\u679c\uff01</div></div><div style='width: 75px; float: left;'><a href='http://www.google.com/chrome' target='_blank'><img src='"+f+"chrome.jpg' style='border: none;' alt='Get Google Chrome'/></a></div><div style='width: 75px; float: left;'><a href='http://www.browserforthebetter.com/download.html' target='_blank'><img src='"+f+"ie8.jpg' style='border: none;' alt='Get Internet Explorer 8'/></a></div><div style='width: 73px; float: left;'><a href='http://www.firefox.com' target='_blank'><img src='"+f+"firefox.jpg' style='border: none;' alt='Get Firefox'/></a></div><div style='width: 73px; float: left;'><a href='http://www.apple.com/safari/download/' target='_blank'><img src='"+f+"safari.jpg' style='border: none;' alt='Get Safari'/></a></div><div style='width: 73px; float: left;'><a href='http://www.opera.com/download/' target='_blank'><img src='"+f+"opera.jpg' style='border: none;' alt='Get Opera'/></a></div></div></div>");
document.write('</div>');

setTimeout(function(){
	document.body.insertBefore(div_bs, document.body.childNodes.item(0));
	showIE("div_bs",1,75,10);
	},3000);

function showIE(id,height,maxh,tm){
	document.getElementById(id).style.height = height + "px";
	height = height + 1;
	if(height < maxh){setTimeout("showIE('"+id+"',"+height+","+maxh+","+tm+")",tm);}
	else {document.getElementById("div_objs").style.display = "";}
}