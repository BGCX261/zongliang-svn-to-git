/*
	My Javascript zongliang
	Update Time 2012-12-31 10:41
*/
(function(window,undefined){
	
	var document = window.document;
	var navigator = window.navigator;
	var location = window.location;
	var undefined = undefined;
	
	var zl = function(id,dom,win){return zl.$(id,dom,win);};

	zl.version = '1.0.0.5';
	/*	
		zl.$ get Dom Object	id:name,dom:parentNode Dom,win:window. 
	*/
	zl.$ = function(obj,dom,win){
		try{
			document = (win == undefined) ? window.document : win.document;
			if(typeof obj == 'string'){
				if(obj == '*'){ 
					return (dom == undefined) ? document.getElementsByTagName('*') : zl.$(dom,undefined,win).getElementsByTagName('*'); 
				}
				var _obj = obj.split(' ');
				if(_obj.length > 1){
					var pdom = zl.$(_obj[0], dom);
					if(pdom != null){
						if(zl.isset(pdom.length)){
							var reary = [];
							for(var i = 0; i < pdom.length; i++){
								var _tmp = zl.$(obj.substr(_obj[0].length+1), pdom[i], win);
								if(_tmp != null){
									if(zl.isset(_tmp.length)){
										for(var _i = 0; _i < _tmp.length; _i++){
											if(_tmp[_i] != null) reary[reary.length] = _tmp[_i];
										}
									}else{
										reary[reary.length] = _tmp;
									}
								}
								//reary[reary.length] = zl.$(obj.substr(_obj[0].length+1), pdom[i], win);
							}
							return (reary.length != 0) ? reary : null;
						}else{
							return zl.$(obj.substr(_obj[0].length+1), pdom, win);
						}
					}else{
						return null;	
					}
				} else if(obj.charAt(0) == '<' && obj.charAt(obj.length-1) == '>' && obj.length >= 3){
					obj = obj.substr(1, obj.length-2);
					return (dom == undefined) ? document.getElementsByTagName(obj) : zl.$(dom,undefined,win).getElementsByTagName(obj);
				} else if(obj.charAt(0) == '.' && obj.length >= 2){
					obj = obj.substr(1, obj.length-1);
					if(zl.isset(document.getElementsByClassName)){
						return (dom == undefined) ? document.getElementsByClassName(obj) : zl.$(dom,undefined,win).getElementsByClassName(obj);
					}else{
						var oElm = (dom == undefined) ? document : zl.$(dom,undefined,win);
						var arrElements = (oElm.all)? oElm.all : oElm.getElementsByTagName('*');
						var arrReturnElements = new Array();
						obj = obj.replace(/\-/g, "\\-");
						var oRegExp = new RegExp('(^|\\s)' + obj + '(\\s|$)');
						var oElement;
						for(var i=0; i < arrElements.length; i++){
							oElement = arrElements[i];
							if(oRegExp.test(oElement.className)){
								arrReturnElements.push(oElement);
							}
						}
						return (arrReturnElements);
					}
				} else if(obj.charAt(0) == '#' && obj.length >= 2){
					obj = obj.substr(1, obj.length-1);
					if(zl.isset(document.getElementsByName)){
						return (dom == undefined) ? document.getElementsByName(obj) : zl.$(dom,undefined,win).getElementsByName(obj);
					}else{
						var oElm = (dom == undefined) ? document : zl.$(dom,undefined,win);
						var arrElements = (oElm.all)? oElm.all : oElm.getElementsByTagName('*');
						var arrReturnElements = new Array();
						var oElement;
						for(var i=0; i < arrElements.length; i++){
							oElement = arrElements[i];
							if(oElement.getAttribute('name') == obj){
								arrReturnElements.push(oElement);
							}
						}
						return (arrReturnElements);
					}
				} else if(obj.charAt(0) == '[' && obj.charAt(obj.length-1) == ']' && obj.length >= 3){
					_tmp = obj.substr(1, obj.length-2);
					var _att = _tmp.split('=');
					if(dom == undefined){
						return zl.$('* '+obj,undefined,win);
					}else{
						return (zl.att(dom,_att[0]) == _att[1]) ? dom : null;
					}
				} else {
					return (dom == undefined) ? document.getElementById(obj) : zl.$(dom,undefined,win).getElementById(obj);
				}
			} else if(typeof obj == 'function'){
				zl.readyCallBacks[zl.readyCallBacks.length] = obj;
				zl.ready();
				//window.onload = function(){zl.ready();}
			} else {
				return obj;	
			}
		}catch(e){
			zl.log('[Function][$] Get $ '+obj+' Error! '+e.message);
			return null;
		}
	};
	/*
		is Internet Explorer
	*/
	zl.isIE = !!window.ActiveXObject;
	// close page
	zl.close = function(){window.opener = null; window.close();};
	// get rand int
	zl.r = zl.rand = function(rmin,rmax){
		if(!zl.isset(rmin))
			rmin = 0;
		if(!zl.isset(rmax))
			rmax = 100;
		return Math.round(rmin+(Math.random()*(rmax-rmin)));
	};
	// new error
	zl.e = zl.error = function(msg){throw new Error(msg);};
	//	Check Obj Is defined
	zl.isset = zl.isdefined = function(obj){ return (typeof obj != 'undefined'); };
	// log con:content ,e:error
	zl.log = function(con,e){
		if(window.console && window.console.log){
			if(e != undefined && e.message != undefined){
				console.log(con + '\r\n\t [Error: ' + e.message + ' ]\r\n');
			} else {
				console.log(con);
			}
		}
	};
	/*
		Show Error Msg
		msg 	Error Content
	*/
	zl.showError = function(msg){
		var showEr = zl.create({id:'show_Error_Msg',cssText:'border: 1px solid #CCC;background: #FFF;width:200px;min-height:50px;z-index:9999; filter:alpha(opacity=70);opacity:0.7;position:fixed;_position:absolute;right:5px;bottom:0px;_bottom:0px;'});
		zl.create({cssText:'width:100%;height:24px;background:#ccc;color:red;font-size:14px;',pdom:showEr,content:'\u9519\u8bef\u63d0\u793a<a href="javascript:zl.remove(\'show_Error_Msg\',3);" style="float:right;">Close</a>'});
		zl.create({cssText:'width:100%;background:#FFF;color:red;font-size:13px;padding:10px;overflow:hidden;display:block;',pdom:showEr,content:'<span>' + msg + '</span>'});
		
		setTimeout(function(){zl._fade(showEr,0,3,function(){zl.remove(this);});},3000);
		
	};
	/*	
		remove object dom	
	*/
	zl.remove = zl.del = function(name,time){
		var obj = zl.$(name);
		if(time){
			zl._fade(obj,0,time,function(){zl.remove(this);});
		} else {
			if(obj != null){
				try{
					obj.parentNode.removeChild(obj);
					zl.log('Remove Object ' + obj + ' Success');
				}catch(e){
					zl.log('Remove Object ' + obj + ' Failure! ', e);
					return e.message;
				}
			}else{
				zl.log('[Function][remove]Remove Object ' + obj + ' Failure! [Error: Is Null! ]');
			}
		}
	};
	/*
		Verify CSS Style Att
		
	*/
	zl.isCss = function(elem,css,val){
		try{
			elem = zl.$(elem);
			if(css in elem.style){
				if(zl.isset(val)){
					elem.style[css] = val;
					return elem.style[css] === val;
				}
				return true;
			}
			return false;
		}catch(e){
			zl.log('[Function][isCss] Get Elem ['+elem+'] CSS ['+css+'] Style Failure! ', e);
			return false;
		}
	};
	/*
		Set Dom CSS Style 
		
	*/
	zl.css = function(elem,css){
		try{
			elem = zl.$(elem);
			if(css.charAt(0) == '.'){
				zl.att(elem, 'class', css.substr(1, css.length-1));	
			}else{
				zl.att(elem, 'style', css);
			}
		}catch(e){
			zl.log('[Function][css] Set Elem ['+elem+'] CSS ['+css+'] Style Failure! ', e);
			return false;
		}
	};
	/*
		Load JavaScript
	*/
	zl.loadjs = zl.loadScript = function(src,charset,callback,kill){
		try{
			var h = zl.$('<head>')[0];
			var ss = zl.$('<script>', h);
			if (ss && ss.length > 0) {
				for(var i = 0; i < ss.length; i ++) {
					if (zl.att(ss[i],'src') == src && !zl.isset(kill)) {
						zl.log('Load JavaScript '+src+' Error.!  JS Already exists');
						zl.run(callback);
						return;
					}
				}
			}
			var js = zl.create({tagName:'script',type:'text/javascript',_src:src,src:src,append:false});
			if(charset){js.charset = charset;}
			if (callback){
				if(zl.isIE){
					js.onreadystatechange = function(){
						if ('complete' == s.readyState || s.readyState == 'loaded'){
							zl.run(callback);
						}
					};
				}else{
					js.onload = function(){
						zl.run(callback);
					};
				}
			}
			zl.insert.child(h,js);
			return js;
		}catch(e){
			zl.log('[Function][loadjs] Load JavaScript '+src+' Failure! ', e);
		}
	};
	/*
		Run Function 
	*/
	zl.run = function(callback){
		try{
			if(typeof callback == 'string'){
				eval(callback);
			}else{
				callback.call(document);
			}
		}catch(e){
			zl.log('[Function][run] Run JavaScript Function '+callback+' Failure! ', e);
		}
	};
	/*	
		Get js parameter	
	*/
	zl.p = zl.parameter = function(name,def,url){
		try{
			if(!zl.isset(url)){
				var scripts = zl.$('<script>');
				var js = scripts[scripts.length-1];
				if(name == undefined) return js;
				url = js.src;
			}
			var qs = url.split('?');
			if (name == null || name == ''){return (qs.length > 1) ? qs[qs.length-1] : ''; }
			var str = qs[qs.length-1].split("&");
			var i = 0;
			while(str[i] != null) {
				var keys = str[i].split("=");
				var j = 0,value = "";
				while(keys[j] != null) {
					if(j != 0) value = value + keys[j];
					j++;
				}
				if(keys[0] == name) return value;
				i++;
			}
			return (!zl.isset(def)) ? '' : def;
		}catch(e){
			zl.log('[Function][p] Get Parameter Failure! ', e);
			return '';
		}
	};
	/*
		Get All Child Nodes
	*/
	zl.childNodes = function(elem,tag){
		try{
			var childs = new Array();
			var nodes = elem.childNodes;
			for(var i = 0; i < nodes.length; i++){
				if(zl.isset(nodes[i].tagName)){
					if(typeof tag != 'string' || nodes[i].tagName.toLowerCase() == tag.toLowerCase()){
						childs[childs.length] = nodes[i];
					}
				}
			}
			return childs;
		}catch(e){
			zl.log('[Function][childNodes] Get Object Dom ' + elem + ' All ChildNodes Tag ' + tag + ' Failure! ', e);
			return zl.$('<' + tab + '>', elem);
		}
	};
	/*
		Get Or Set Attrib
	*/
	zl.att = zl.attribute = function(elem,key,val){
		try{
			if(zl.isset(val)){
				if(typeof val == 'function'){
					try{eval('elem.'+key+' = '+val+';');}catch(e){elem.setAttribute(key, val);}
				}else if(val == null){
					elem.removeAttribute(key);
				}else{
					try{elem.setAttribute(key, val);}catch(e){eval('elem.'+key+' = '+val+';');}
				}
			} else {
				return elem.getAttribute(key);
			}
		}catch(e){
			zl.log('[Function][att] Get Or Set Attribute In '+elem+' Failure! ', e);
			return null;
		}
	};
	/*
		Get Dom Location x,y,h,w
		return obj
	*/
	zl.loc = zl.dom_location = function(elem){
		try{
			if(arguments.length != 1 || elem == null ){
				return null; 
			}
			var offsetTop = elem.offsetTop;
			var offsetLeft = elem.offsetLeft;
			var offsetWidth = elem.offsetWidth;
			var offsetHeight = elem.offsetHeight;
			while( elem = elem.offsetParent){
				if(elem.style.position == 'absolute' || elem.style.position == 'relative' || ( elem.style.overflow != 'visible' && elem.style.overflow != '' )){
					break; 
				}
				offsetTop += elem.offsetTop;
				offsetLeft += elem.offsetLeft; 
			}
			return {top:offsetTop,left:offsetLeft,width:offsetWidth,height:offsetHeight};
		}catch(e){
			zl.log('[Function][loc] Get Location '+elem+' Failure! ', e);
			return null;
		}
	};
	/*
		load dom time
	*/
	zl.loadTime = 0;
	/*
		rand callbacks
	*/
	zl.readyCallBacks = [];
	/*
		ready window.onload ,,,
	*/
	zl.ready = function(obj){
		try{
			if(zl.isset(obj) ){
				zl.readyCallBacks[zl.readyCallBacks.length] = obj;
			}
			zl.loadTime = zl.loadTime + 1;
			if(document.readyState == 'complete' && zl.readyCallBacks != []){
				for(var i = 0,ic = zl.readyCallBacks.length; i < ic; i++ ){
					try{
						zl.run(zl.readyCallBacks[i]);
						/*
						if(typeof zl.readyCallBacks[i] == 'string'){
							eval(zl.readyCallBacks[i]);
						}else{
							zl.readyCallBacks[i].call(document);
						}
						*/
						//delete zl.readyCallBacks[i];
					}catch(e){
						zl.log('[Function][ready] Ready CallBack Failure! ', e);
					}
				}
				zl.readyCallBacks = [];
			}else{
				setTimeout(function(){zl.ready();},1);
			}
		}catch(e){
			zl.log('[Function][ready] Ready Function Failure!',e);
		}
	};
	/*
		Check Default Option
	*/
	zl.cd = zl.checkDefaultOpt = function(def_opt,opt){
		try{
			if(!opt) { 
				opt = def_opt; 
			}else{
				for(var dfo in def_opt){
					if(opt[dfo] == undefined)
						opt[dfo] = def_opt[dfo];
				}
			}
			return opt;
		}catch(e){
			zl.log('[Function][checkDefaultOpt] Check Default Option Failure! ', e);
			return null;	
		}
	};
	/*
		Get XmlHttp Object Ajax
		return Object or null;
	*/
	zl.getXmlHttpObject = function(){
		try{
			var xmlHttp = null;
			try{
				xmlHttp = new XMLHttpRequest();
			}catch(e){
				try{
					xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
				}catch(e){
					xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
				}
			}
			return xmlHttp;
		}catch(e){
			zl.log('[Function][getXmlHttpObject] get XML In Ajax Object Demo Failure!',e); 	
		}
	};
	/*
		My Ajax obj
		opt option
	*/
	zl.ajax = function(opt){
		var df_opt = {type:'post', url:'', query:'', dataType:'', async:true, success:function(o){}};
		opt = zl.cd(df_opt,opt);
		var xmlAjax = zl.getXmlHttpObject();
		if(xmlAjax == null){
			alert('\u60a8\u7684\u6d4f\u89c8\u5668\u53ef\u80fd\u4e0d\u652f\u6301Ajax.\u8bf7\u68c0\u67e5!');
		}else{
			try{
				if(opt.type == 'get') opt.url = opt.url + '?' + opt.query;
				xmlAjax.onreadystatechange = function(){
					if(xmlAjax.readyState == 4 || xmlAjax.readyState == "complete"){
						try{
							if(opt.success){
								var reData = xmlAjax.responseText;
								if(opt.dataType == 'json'){
									try{reData = zl.json(reData);}catch(e){zl.log('Content ReData Type Failure! ', e);}
								} else if (opt.dataType == 'xml'){
									try{reData = zl.xml(reData);}catch(e){zl.log('Content ReData Type Failure! ', e);}
								}
								if(typeof opt.success != 'string'){
									opt.success.call(this,reData);
								}else{
									eval(opt.success + '(reData);');
								}
							}
						}catch(e){
							zl.log('Get Ajax Data Failure! ', e);
							alert(e.message);
						}
					}
				}
				xmlAjax.open(opt.type, opt.url, opt.async);
				xmlAjax.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
				xmlAjax.send(opt.query);
			}catch(e){
				zl.log('[Function][ajax] Send Ajax Failure! ', e);
				alert(e.message);
			}
		}	
	};
	/*
		open new window run code
		code Code
	*/
	zl.runCode = function(code){
		try{
			if(code != ''){
				var newwin = window.open('','','');
				newwin.opener = null;
				newwin.document.write(code);
				newwin.document.close();
				return newwin;
			}
		}catch(e){
			zl.log('[Function][runCode] Run Code Failure!',e);
		}
	};
	/*
		Copy Elem Style
		New Elem In Elem
	*/
	zl.cpem = zl.copyElem = function(elem,opt){
		try{
			elem = zl.$(elem);
			if(elem == null) return null;
			if(typeof opt == 'undefined') opt = {append:false};
			//var cssText = (typeof opt['cssText'] == 'undefined') ? '' : opt['cssText'];
			var cssText = '';
			var locElem = zl.loc(elem);
			cssText = cssText + 'width:' + locElem.width + 'px;';	//elem.offsetWidth
			cssText = cssText + 'height:' + locElem.height + 'px;';	//elem.offsetHeight
			cssText = cssText + 'left:' + locElem.left + 'px;';		//elem.offsetLeft
			cssText = cssText + 'top:' + locElem.top + 'px;';		//elem.offsetTop
			cssText = cssText + 'position:absolute;z-index:99999;';

			opt['cssText'] = (typeof opt['cssText'] == 'undefined') ? cssText : cssText + opt['cssText'];
			
			return zl.create(opt);
		}catch(e){
			zl.log('[Function][copyElem] Copy Element Failure!',e);
			return null;
		}
	};
	/*	
		Create Object Dom
		opt option
	*/
	zl.create = zl.newDom = function(opt){
		try{
			if(typeof opt == 'string'){
				 var obj = document.createElement('div'); 
				 obj.innerHTML = opt;
				 return obj.childNodes;
			}else{
				var df_opt = {tagName:'div',id:'c_obj',name:'c_obj',css:'',cssText:'',content:'',append:true,pdom:'',bdom:'',adom:''};
				opt = zl.cd(df_opt,opt);
				var obj = document.createElement(opt.tagName);
				try{
					obj.id = opt.id;
					obj.name = opt.name;
					obj.className = opt.css;
					obj.style.cssText = opt.cssText;
					try{obj.innerHTML = opt.content;}catch(ex){}
					for(var i in opt){
						if(i != 'tagName' && i != 'id' && i != 'name' && i != 'css' && i != 'cssText' && i != 'content' && i != 'append' && i != 'pdom' && i != 'bdom' && i != 'adom'){
							zl.att(obj,i,opt[i]);
							//try{
							//	if(opt[i] != undefined) obj.setAttribute(i, opt[i]);
							//}catch(e){
							//	eval('obj.'+i+' = opt.'+i+';');
							//}
						}
					}
				}catch(exs){}
				if(opt.append){
					if(opt.pdom != ''){
						zl.insert.child(opt.pdom, obj);
					}else if(opt.bdom != ''){
						zl.insert.before(opt.bdom, obj);
					}else if(opt.adom != ''){
						zl.insert.after(opt.adom, obj);
					}else{
						zl.insert.child(document.body, obj);
					}
				}
				return obj;
			}
		}catch(e){
			zl.log('[Function][create] CreateElement Object Failure! ', e);
			//alert(e.message);
			return null;
		}
	};
	/*
		Insert Dom 
	*/
	zl.insert = {
		before : function(elem,newElem){
			try{
				return zl.$(elem).parentNode.insertBefore(newElem, zl.$(elem));
			}catch(e){
				zl.log('[Function][insert.before] Insert Object Dom '+newElem+' In '+elem+' Before Failure! ', e);
				return false;
			}
		},
		after : function(elem,newElem){
			try{
				if(elem.parentNode.lastChild == elem){
					return elem.parentNode.appendChild(newElem);
				}else{
					return elem.parentNode.insertBefore(newElem,elem.nextSibling);
				}
			}catch(e){
				zl.log('[Function][insert.after] Insert Object Dom '+newElem+' In '+elem+' After Failure! ', e);
				return false;
			}
		},
		child : function(elem,newElem){
			try{
				return zl.$(elem).appendChild(newElem);
			}catch(e){
				zl.log('[Function][insert.child] Insert Object Dom '+newElem+' In '+elem+' Failure! ', e);
				return false;
			}		
		}
	};
	/*
		My Form Option
		Form
	*/
	zl.fm = zl.Form = {
		Init : function(){
			/*	Unfinished...	*/
		}
	};
	/*
		ImageErr check images onerror
		img		image object
		url		default image url
	*/
	zl.imageErr = function(img,url){
		try{
			img = zl.$(img);
			//img.onerror = function(){img.src = url;}
			var _img = new Image();
			_img.src = img.src;
			_img.onerror = function(){
				zl.att(img,'source-src',img.src);
				img.src = url;
			}
			/*
			if(!img.complete){
				var itp = obj.src.substr(-3);
				if(itp == 'jpg' || itp == 'peg' || itp == 'png' || itp == 'gif' || itp == 'bmp'){
					obj.setAttribute('source-src', obj.src);
					obj.src = url;
				}
			}
			*/
		}catch(e){
			zl.log('[Function][imageErr] Load Image Error Failure! ', e);
			return '';
		}
	};
	/*
		Default Image
	*/
	zl.imageDefault = function(url){
		try{
			var _img = new Image();
			_img.src = url;
			_img.onload = function(){
				var imgs = zl.$('<img>');
				for(var i in imgs){
					zl.imageErr(imgs[i],url);
				}	
			}
		}catch(e){
			zl.log('[function][imageDefault] Setting Images Default Url Failure! ', e);
			return '';	
		}
	};
	/*
		Get  Path
		src		path
		return (error)?'':the Path;
	*/
	zl.getPath = function(src){
		try{
			if(!zl.isset(src)) src = zl.parameter().src;
			var path = src.substring(0,(src.length - zl.parameter('').length));
			return path.substring(0,path.lastIndexOf('/')+1);
		}catch(e){
			zl.log('[Function][getPath] Get Path Failure! ', e);
			return '';
		}
	};
	/*
		Get User Browser Info	
		r	retype
		return (r != null)?Browser Version:Object info;
	*/
	zl.bs = zl.browser = function(r){
		try{
			var bsary = new Array();
			bsary[0] = new Array('MSIE ', 'Internet Explorer', 'Microsoft', '');
			bsary[1] = new Array('Chrome\\/', 'Chrome', 'Google', '');
			bsary[2] = new Array('Firefox\\/', 'Firefox', 'Mozilla', '');
			bsary[3] = new Array('Opera\\/', 'Opera', 'Opera Software', 'Version\\/[\\d+.\\d+]+');
			bsary[4] = new Array('Safari\\/', 'Safari', 'Apple', 'Version\\/[\\d+.\\d+]+');
			for(var i = 0; i < bsary.length; i++){
				var ocode = '_reg = /'+bsary[i][0]+'[\\d+.\\d+]+/;';
				ocode = ocode + 'var _bv = _reg.exec(navigator.userAgent);';
				eval(ocode);
				if(_bv){
					if(bsary[i][3] != ''){
						var ocode = '_reg = /'+bsary[i][3]+'/;';
						ocode = ocode + 'var _bv = _reg.exec(navigator.userAgent);';
						eval(ocode);
					}
					_reg = /[\d+.\d+]+/;
					var _v = _reg.exec(_bv)[0];
					var _obj = bsary[i][2]+' '+bsary[i][1]+' '+_v;
					return (r != undefined) ? _obj : {obj:_obj,company:bsary[i][2],name:bsary[i][1],version:_v};
				}
			}
			return 'Unknown';
		}catch(e){
			zl.log('[Function][browser] Get Browser Info Failure! ', e);
			return e.message;
		}
	};
	/*
		Get User System Info	
		r	retype
		return (r != null)?System Version:Object info;
	*/
	zl.os = zl.system = function(r){
		try{
			var osary = new Array();
			osary[0] = new Array('/windows nt 95/', 'Windows 95', 'Microsoft');
			osary[1] = new Array('/windows nt 4.90/', 'Windows ME', 'Microsoft');
			osary[2] = new Array('/windows nt 98/', 'Windows 98', 'Microsoft');
			osary[3] = new Array('/windows nt 5.0/', 'Windows 2000', 'Microsoft');
			osary[4] = new Array('/windows nt 5.1/', 'Windows XP', 'Microsoft');
			osary[5] = new Array('/windows nt 6.0/', 'Windows Vista', 'Microsoft');
			osary[6] = new Array('/windows nt 6.1/', 'Windows 7', 'Microsoft');
			osary[7] = new Array('/windows nt 6.2/', 'Windows 8', 'Microsoft');
			osary[8] = new Array('/windows nt 32/', 'Windows 32', 'Microsoft');
			osary[9] = new Array('/windows nt nt/', 'Windows NT', 'Microsoft');
			osary[10] = new Array('/mac os/', 'Mac OS', 'Apple');
			osary[11] = new Array('/linux/', 'Linux', 'Unknown');
			osary[12] = new Array('/unix/', 'Unix', 'Unknown');
			osary[13] = new Array('/sun os/', 'SunOS', 'SUN');
			osary[14] = new Array('/ibm os/', 'IBM OS/2', 'IBM');
			osary[15] = new Array('/mac pc/', 'Macintosh', 'Unknown');
			osary[16] = new Array('/powerpc/', 'PowerPC', 'Unknown');
			osary[17] = new Array('/aix/', 'AIX', 'Unknown');
			osary[18] = new Array('/hpux/', 'HPUX', 'Unknown');
			osary[19] = new Array('/netbsd/', 'NetBSD', 'Unknown');
			osary[20] = new Array('/bsd/', 'BSD', 'Unknown');
			osary[21] = new Array('/osfl/', 'OSF1', 'Unknown');
			osary[22] = new Array('/irix/', 'IRIX', 'Unknown');
			osary[23] = new Array('/freebsd/', 'FreeBSD', 'Unknown');
			
			for(var i = 0; i < osary.length; i++){
				var ocode = '_reg = '+osary[i][0]+';';
				ocode = ocode + 'var _bv = _reg.exec(navigator.userAgent.toLowerCase());';
				eval(ocode);
				if(_bv){
					var _obj = osary[i][2]+' '+osary[i][1];
					return (r != undefined) ? _obj : {obj:_obj,company:osary[i][2],name:osary[i][1]};
				}
			}
			return 'Unknown';
		}catch(e){
			zl.log('[Function][system] Get System Info Failure! ', e);
			return e.message;
		}
	};
	/*
		Change object Transparency
		element			Object Dom
		Transparency 	Transparency value
		speed			Change Speed
		callback		CallBack
	*/
	zl._fade = zl.fade = zl.transparency = function(element, transparency, speed, callback){
		try{
			element = zl.$(element);
			if(!element.effect){
				element.effect = {};
				element.effect._fade=0;
			}
			clearInterval(element.effect._fade);
			var speed=speed||1;
			var start=(function(elem){
				var alpha;
				if(navigator.userAgent.toLowerCase().indexOf('msie') != -1){
						alpha=elem.currentStyle.filter.indexOf("opacity=") >= 0?(parseFloat( elem.currentStyle.filter.match(/opacity=([^)]*)/)[1] )) + '':
						'100';
				}else{
						alpha=100*elem.ownerDocument.defaultView.getComputedStyle(elem,null)['opacity'];
				}
				return alpha;
			})(element);
			//zl.log('start: '+start+" end: "+transparency);
			element.effect._fade = setInterval(function(){
				start = start < transparency ? Math.min(start + speed, transparency) : Math.max(start - speed, transparency);
				element.style.opacity =  start / 100;
				element.style.filter = 'alpha(opacity=' + start + ')';
				if(Math.round(start) == transparency){
					element.style.opacity =  transparency / 100;
					element.style.filter = 'alpha(opacity=' + transparency + ')';
					clearInterval(element.effect._fade);
					if(callback)callback.call(element);
				}
			}, 20);
		}catch(e){
			zl.log('[Function][_fade] Change object Transparency Failure![ ' + element + '] ', e);
			return e.message;
		}
	};
	/*
		Change object Location
		element			Object Dom
		position		Change Option
		speed			Change Speed
		callback		CallBack
	*/
	zl._move = zl.move = function(element, position, speed, callback){
		try{
			element = zl.$(element);
			if(!element.effect){
				element.effect = {};
				element.effect._move=0;
			}
			clearInterval(element.effect._move);
			var speed=speed||10;
			var start=(function(elem){
				var	posi = {left:elem.offsetLeft, top:elem.offsetTop};
				while(elem = elem.offsetParent){
					posi.left += elem.offsetLeft;
					posi.top += elem.offsetTop;
				};
				return posi;
			})(element);
			element.style.position = 'absolute';
			var	style = element.style;
			var styleArr=[];
			if(typeof(position.left)=='number')styleArr.push('left');
			if(typeof(position.top)=='number')styleArr.push('top');
			element.effect._move = setInterval(function(){
				for(var i=0;i<styleArr.length;i++){
					start[styleArr[i]] += (position[styleArr[i]] - start[styleArr[i]]) * speed/100;
					style[styleArr[i]] = start[styleArr[i]] + 'px';
				}
				for(var i=0;i<styleArr.length;i++){
					if(Math.round(start[styleArr[i]]) == position[styleArr[i]]){
						if(i!=styleArr.length-1)continue;
					}else{
						break;
					}
					for(var i=0;i<styleArr.length;i++)style[styleArr[i]] = position[styleArr[i]] + 'px';
					clearInterval(element.effect._move);
					if(callback)callback.call(element);
				}
			}, 20);
		}catch(e){
			zl.log('[Function][_move] Change object Location Failure! [' + element + '] ', e);
			return e.message;
		}
	};
	/*
		Change object Size
		element			Object Dom
		size			Object New Size Option
		speed			Change Speed
		callback		CallBack
	*/
	zl._reSize = zl.reSize = zl.size = function(element, size, speed, callback){
		try{
			element = zl.$(element);
			if(!element.effect){
				element.effect = {};
				element.effect._resize=0;
			}
			clearInterval(element.effect._resize);
			var speed=speed||10;
			var	start = {width:element.offsetWidth, height:element.offsetHeight};
			var styleArr=[];
			if(!(navigator.userAgent.toLowerCase().indexOf('msie') != -1&&document.compatMode == 'BackCompat')){
				var CStyle=document.defaultView?document.defaultView.getComputedStyle(element,null):element.currentStyle;
				if(typeof(size.width)=='number'){
					styleArr.push('width');
					size.width=size.width-CStyle.paddingLeft.replace(/\D/g,'')-CStyle.paddingRight.replace(/\D/g,'');
				}
				if(typeof(size.height)=='number'){
					styleArr.push('height');
					size.height=size.height-CStyle.paddingTop.replace(/\D/g,'')-CStyle.paddingBottom.replace(/\D/g,'');
				}
			}
			element.style.overflow = 'hidden';
			var	style = element.style;
			element.effect._resize = setInterval(function(){
				for(var i=0;i<styleArr.length;i++){
					start[styleArr[i]] += (size[styleArr[i]] - start[styleArr[i]]) * speed/100;
					style[styleArr[i]] = start[styleArr[i]] + 'px';
				}
				for(var i=0;i<styleArr.length;i++){
					if(Math.round(start[styleArr[i]]) == size[styleArr[i]]){
						if(i!=styleArr.length-1)continue;
					}else{
						break;
					}
					for(var i=0;i<styleArr.length;i++)style[styleArr[i]] = size[styleArr[i]] + 'px';
					clearInterval(element.effect._resize);
					if(callback)callback.call(element);
				}
			}, 20);
		}catch(e){
			zl.log('[Function][_reSize] Change object Size Failure! [' + element + '] ', e);
			return e.message;
		}
	};
	/*
		Hide Elem Dom
		time: hide time
		val: transparency
	*/
	zl.hide = function(elem,time,val){
		try{
			if(!zl.isset(val)) val = 0;
			if(!zl.isset(time)) time = 1;
			zl.fade(elem,val,time);
		}catch(e){
			zl.log('[Function][hide] hide object Elem Failure![ ' + elem + '] ', e);
			return e.message;
		}
	};
	/*
		Show Elem Dom
		time: show time
		val: transparency
	*/
	zl.show = function(elem,time,val){
		try{
			if(!zl.isset(val)) val = 100;
			if(!zl.isset(time)) time = 1;
			zl.fade(elem,val,time);
		}catch(e){
			zl.log('[Function][show] show object Elem Failure![ ' + elem + '] ', e);
			return e.message;
		}
	};
	/*
		Drag Object Dom
	*/
	zl.drag = {
		/*	Unfinished...	*/
	};
	/*
		Dom Keys Reg or Remove
		add Registration Key in Dom . shortcut:Key,callback:Trigger The Key CallBack,opt:Key Option
		remove() Remove Key In Dom. shortcut:key.
		weburl: http://www.openjs.com/scripts/events/keyboard_shortcuts/shortcut.js
	*/
	zl.key = zl._key = zl.shortcuts = {
		all_shortcuts : [],
		add : function(shortcut_combination,callback,opt){
			try{
				var default_options = {'type':'keydown','propagate':false,'disable_in_input':false,'target':document,'keycode':false}
				opt = zl.cd(default_options, opt);
				var ele = zl.$(opt.target);
				var ths = this;
				shortcut_combination = shortcut_combination.toLowerCase();
				var func = function(e){
					e = e || window.event;
					if(opt['disable_in_input']){
						var element;
						if(e.target) element=e.target;
						else if(e.srcElement) element=e.srcElement;
						if(element.nodeType==3) element=element.parentNode;
						if(element.tagName == 'INPUT' || element.tagName == 'TEXTAREA') return;
					}
					if (e.keyCode) code = e.keyCode;
					else if (e.which) code = e.which;
					var character = String.fromCharCode(code).toLowerCase();
					if(code == 188) character=",";
					if(code == 190) character=".";
					var keys = shortcut_combination.split("+");
					var kp = 0;
					var shift_nums = {"`":"~","1":"!","2":"@","3":"#","4":"$","5":"%","6":"^","7":"&","8":"*","9":"(","0":")","-":"_","=":"+",";":":","'":"\"",",":"<",".":">","/":"?","\\":"|"};
					var special_keys = {'esc':27,'escape':27,'tab':9,'space':32,'return':13,'enter':13,'backspace':8,'scrolllock':145,'scroll_lock':145,'scroll':145,'capslock':20,'caps_lock':20,'caps':20,'numlock':144,'num_lock':144,'num':144,'pause':19,'break':19,'insert':45,'home':36,'delete':46,'end':35,'pageup':33,'page_up':33,'pu':33,'pagedown':34,'page_down':34,'pd':34,'left':37,'up':38,'right':39,'down':40,'f1':112,'f2':113,'f3':114,'f4':115,'f5':116,'f6':117,'f7':118,'f8':119,'f9':120,'f10':121,'f11':122,'f12':123};
					var modifiers = { 
						shift: { wanted:false, pressed:false},
						ctrl : { wanted:false, pressed:false},
						alt  : { wanted:false, pressed:false},
						meta : { wanted:false, pressed:false}
					};
					if(e.ctrlKey)	modifiers.ctrl.pressed = true;
					if(e.shiftKey)	modifiers.shift.pressed = true;
					if(e.altKey)	modifiers.alt.pressed = true;
					if(e.metaKey)   modifiers.meta.pressed = true;
					for(var i=0; k=keys[i],i<keys.length; i++){
						if(k == 'ctrl' || k == 'control') {
							kp++;
							modifiers.ctrl.wanted = true;
						} else if(k == 'shift') {
							kp++;
							modifiers.shift.wanted = true;
						} else if(k == 'alt') {
							kp++;
							modifiers.alt.wanted = true;
						} else if(k == 'meta') {
							kp++;
							modifiers.meta.wanted = true;
						} else if(k.length > 1) {
							if(special_keys[k] == code) kp++;
						} else if(opt['keycode']) {
							if(opt['keycode'] == code) kp++;
						} else {
							if(character == k) kp++;
							else {
								if(shift_nums[character] && e.shiftKey) {
									character = shift_nums[character]; 
									if(character == k) kp++;
								}
							}
						}
					}
					if(kp == keys.length && modifiers.ctrl.pressed == modifiers.ctrl.wanted && modifiers.shift.pressed == modifiers.shift.wanted && modifiers.alt.pressed == modifiers.alt.wanted && modifiers.meta.pressed == modifiers.meta.wanted){
						var re = callback(e);
						if((re != undefined && !re) || (re == undefined && !opt['propagate'])){
							e.cancelBubble = true;
							e.returnValue = false;
							if (e.stopPropagation) {
								e.stopPropagation();
								e.preventDefault();
							}
							return false;
						}else{
							e.cancelBubble = false;
							e.returnValue = true;
							return true;	
						}
					}
				}
				this.all_shortcuts[shortcut_combination] = {
					'callback':func, 
					'target':ele, 
					'event': opt['type']
				};
				if(ele.addEventListener) ele.addEventListener(opt['type'], func, false);
				else if(ele.attachEvent) ele.attachEvent('on'+opt['type'], func);
				else ele['on'+opt['type']] = func;
				zl.log('Registration Key '+shortcut_combination+' In '+opt['target']+' on'+opt['type']+' Success!');
			}catch(e){
				zl.log('[Function][key.add] Registration Key '+shortcut_combination+' Failure! ', e);
				return e.message;
			}
		},
		remove : function(shortcut_combination) {
			try{
				shortcut_combination = shortcut_combination.toLowerCase();
				var binding = this.all_shortcuts[shortcut_combination];
				delete(this.all_shortcuts[shortcut_combination])
				if(!binding) return;
				var type = binding['event'];
				var ele = binding['target'];
				var callback = binding['callback'];
				if(ele.detachEvent) ele.detachEvent('on'+type, callback);
				else if(ele.removeEventListener) ele.removeEventListener(type, callback, false);
				else ele['on'+type] = false;
				zl.log('Remove Key '+shortcut_combination+' In '+ele+' on'+type+' Success!');
			}catch(e){
				zl.log('[Function][key.remove] Remove Key '+shortcut_combination+' Failure! ',e);
				return e.message;
			}
		},
		source : 'http://www.openjs.com/scripts/events/keyboard_shortcuts/shortcut.js'
	};
	/*
		Cookie Class
		add	Add New Cookie Afferent NewCookie Option
		get	Get Cookie Value Afferent Cookie Name
		del	Delete Cookie Afferent Cookie Name
	*/
	zl.cookie = zl._cookie = {
		add : function(opt){
			try{
				if(!opt.name || !opt.value){throw new Error("Error: Cookie [name] And [value] Cant Null.");}
				var str = opt.name + "=" + escape(opt.value);
				if(opt.hours){
					var exdate = new Date();
					if(opt.hourstype=='d'){
						exdate.setDate(exdate.getDay()+opt.hours);
					}else if(opt.hourstype=='m'){
						exdate.setDate(exdate.getMinutes()+opt.hours);
					}else{
						exdate.setDate(exdate.getHours()+opt.hours);
					}
					str += ";expires=" + exdate.toGMTString();
				}
				str += (opt.path) ? ";path=" + opt.path : "";
				str += (opt.domain) ? ";domain=" + opt.domain : "";
				str += (opt.secure) ? ";secure=" + opt.secure : "";
				document.cookie = str;
				zl.log('Add Cookie [' + opt.name + ']:[' + opt.value + '] Success.');
			}catch(e){
				zl.log('[Function][cookie.add] Add Cookie [' + opt.name + ']:[' + opt.value + '] Failure! ', e);
			}
		},
		get : function(ckName){
			try{
				if(document.cookie.length>0){
					if(typeof ckName == 'undefined' || ckName == '') return document.cookie.toString();
					var c_start = document.cookie.indexOf(ckName + "=");
					if(c_start != -1){
						c_start = c_start+ckName.length+1;
						var c_end = document.cookie.indexOf(";",c_start)
						if(c_end == -1) c_end = document.cookie.length;
						return unescape(document.cookie.substring(c_start,c_end));
					}
				}
				return null;
			}catch(e){
				zl.log('[Function][cookie.get] Get Cookie [' + ckName + '] Failure! ', e);
				return null;	
			}
		},
		del : function(ckName){
			try{
				var date = new Date();
				date.setTime(date.getTime() - 10000);
				document.cookie = ckName + "=; expires=" + date.toGMTString();
				zl.log('Delete Cookie [' + ckName + '] Success.');
			}catch(e){
				zl.log('[Function][cookie.del] Delete Cookie [' + ckName + '] Failure.');
			}
		}
	};
	/*
		My Check Class
		checkIsNull Check Afferent Object Dom Value Is Null or ''.o:object dom; return (is Null)?true:false;
		checkIsSame Check Afferent Object Dom Value Is Same .o:object dom,r:object dom; return true or false
		checkValLength Check Afferent Object Dom Value Length Is ok.o:object dom,n:min length,x:max length. return true or false
		checkObject Check Afferent Object Dom RegExp Verify.o:object dom,r:RegExp;return true or false;
	*/
	zl.check = zl.myCheck = {
		checkIsNull : function(o){
			try{
				if(zl.$(o) == null){
					if(typeof o == 'string') return (o == '' || o.replace(/(^\s+)|(\s+$i)/g,'') == '');
					else return false;
				}else{
					return (zl.$(o).value == '' || zl.$(o).value.replace(/(^\s+)|(\s+$i)/g,'') == '');
				}
			}catch(e){
				return false;
			}
		},
		checkIsSame : function(o,r){
			try{
				if(zl.$(o) == null || zl.$(r) == null){
					if(typeof o == 'string' && typeof r == 'string') return (o == r);
					else return false;
				}else{
					return (zl.$(o).value == zl.$(r).value);
				}
			}catch(e){
				return false;
			}
		},
		checkIsInt : function(o){
			try{
				if(zl.$(o) == null){
					if(typeof o == 'string' || typeof o == 'number') return !isNaN(o);
					else return false;
				}else{
					return !isNaN(zl.$(o).value);
				}
			}catch(e){
				return false;
			}
		},
		checkValLength : function(o,n,x){
			try{
				if(zl.$(o) == null){
					if(typeof o == 'string') return (n <= o.length && o.length <= x);
					else return false;
				}else{
					return (n <= zl.$(o).value.length && zl.$(o).value.length <= x);
				}
			}catch(e){
				return false;	
			}
		},
		checkObject : function(o,r){
			try{
				if(zl.$(o) == null){
					if(typeof o == 'string' && r != undefined) return (o.replace(new RegExp(r,'g'),'') == '');
					else return false;
				}else{
					return (zl.$(o).value.replace(new RegExp(r,'g'),'') == '');
				}
			}catch(e){
				return false;	
			}
		}
	};
	/*
		Check Object All ChildNodes Images size
		obj		Object
		w		Max Width
		h		Max Height
	*/
	zl.checkImage = function(obj,w,h){
		try{
			var ImgCell = zl.$('<img>', zl.$(obj));
			for(var i=0; i<ImgCell.length; i++){
				var ImgWidth = ImgCell(i).width;
				var ImgHeight = ImgCell(i).height;
				if(ImgWidth > w){
					var newHeight = w*ImgHeight/ImgWidth;
					if(newHeight <= h){
						ImgCell(i).width = w;
						ImgCell(i).height = newHeight;
					}else{
						ImgCell(i).height = h;
						ImgCell(i).width = h*ImgWidth/ImgHeight;
					}
				}else{
					if(ImgHeight > h){
						ImgCell(i).height = h;
						ImgCell(i).width = h*ImgWidth/ImgHeight;
					}else{
						ImgCell(i).width = ImgWidth;
						ImgCell(i).height = ImgHeight;
					}
				}
			}
		}catch(e){
			zl.log('[Function][runCode] Check Images Size Max or Min Failure!',e);	
		}
	};
	/*
		Check Object Html Dom is Pobj childNodes
		obj		Object
		parent	The ParentNode Object
		return (obj is Pobj ChildNodes)?true:false;
	*/
	zl.checkHtml = function(obj,parent){
		try{
			parent = zl.$(parent);
			for(obj = zl.$(obj); obj != document.body; obj = obj.parentNode){
				if(!zl.isset(obj) || obj == null)
					return false;
				if(obj == parent)
					return true;
			}
			return false;
		}catch(e){
			zl.log('[Function][checkHtml] Check Object Dom Failure! ', e);
			return false;
		}
	};
	/*
		Get Object Parent Dom
		elem	object
		parent	parent type
	*/
	zl.getParent = function(elem,parent){
		try{
			elem = zl.$(elem);
			for(; elem != document.body; elem = elem.parentNode){
				if(elem == undefined || elem == null) return null;
				if(elem.tagName.toLowerCase() == parent.toLowerCase()) return elem;
			}
			return null;
		}catch(e){
			zl.log('[Function][getParent] Get Object Parent Dom Failure! ', e);
			return null;
		}
	};
	/*	
		Show Object show or hide
		o 	object
		t	Change Time
		opt	opt obj
		cb	callback
	*/
	zl._stips = zl.flash = function(obj,time,opt,callback){
		try{
			var obj = zl.$(obj);
			opt = zl.cd({i:0,x:100,v:5},opt);
			zl._fade(obj, opt.i, opt.v, function(){
				if(callback) callback.call(obj);
				zl._fade(obj, opt.x, opt.v, function(){
					setTimeout(function(){zl._stips(obj, time, opt, callback); }, time);
				});
			});
		}catch(e){
			zl.log('[Function][flash] Show Object Dom Failure! ', e);
		}
	};
	/*	
		change Class Name
		obj 		object
		newclass	New ClassName
		oldclass	Old ClassName
		other		OtherObject
	*/
	zl.cc = zl.changDomClass = function(obj,newclass,oldclass,other){
		try{
			obj = zl.$(obj);
			var op = zl.childNodes(obj.parentNode,obj.tagName);
			for(var i=0; i<op.length; i++){
				if(op[i] != obj && op[i] != other && typeof oldclass != 'undefined'){
					op[i].className = oldclass;
				}else if(op[i] != other && typeof newclass != 'undefined'){
					op[i].className = newclass;
				}
			}
		}catch(e){
			zl.log('[Function][changeDomClass] Change Dom Class Failure! ', e);
		}
	};
	/*
		Tab	
		Tab Object Show or Hide
	*/
	zl.tab = zl._tab = function(elem,obj,nclass,oclass){
		try{
			zl.changDomClass(elem,nclass,oclass);
			obj = zl.$(obj);
			var op = zl.childNodes(obj.parentNode,obj.TagName);
			for(var i=0,c=op.length; i<c; i++){
				if(op[i].tagName != 'undefined' && op[i].tagName == obj.tagName){
					if(op[i] != obj){
						op[i].style.display = 'none';
					}else{
						op[i].style.display = '';
					}
				}
			}
		}catch(e){
			zl.log('[Function][tag] Tab Object Dom Failure!',e);
		}
	};
	/*	
		conver Html Label
		con		HTMl Conetnt
	*/
	zl.cv = zl.converHtmlLabel = function(con){
		//return document.createElement('div').appendChild(document.createTextNode(con)).parentNode.innerHTML;
		return con.replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;');
	};
	/*
		Native Convert Ascii
	*/
	zl.ascii = zl.nativeConvertAscii = function(str){
		try{
			var nativecode = str.split('');
			var ascii = '';
			for(var i = 0; i < nativecode.length; i++) {
				var code = Number(nativecode[i].charCodeAt(0));
				if (code > 127){
					var charAscii = code.toString(16);
					charAscii = new String('0000').substring(charAscii.length, 4) + charAscii;
					ascii += '\\u' + charAscii;
				} else {
					ascii += nativecode[i];
				}
			}
			return ascii;
		}catch(e){
			zl.log('[Function][ascii] Native Convert Ascii Failure!', e);
			return '';
		}
	};
	/*
		Ascii Convert Natvie
	*/
	zl.natvie = zl.asciiConvertNative = function(str){
		try{
			var asciicode = str.split('\\u');
			var nativeValue = asciicode[0];
			for (var i = 1; i < asciicode.length; i++) {
				var code = asciicode[i];
				nativeValue += String.fromCharCode(parseInt('0x' + code.substring(0, 4)));
				if(code.length > 4) {
					nativeValue += code.substring(4, code.length);
				}
			}
			return nativeValue;
		}catch(e){
			zl.log('[Function][natvie] Ascii Convert Native Failure!', e);
			return '';
		}
	}
	/*	
		conver Data JSON
		data	Conetnt
		source	JQuery http://code.jquery.com/jquery-1.7.2.js
	*/
	zl.json = zl.parseJSON = function(data){
		try{
			if(typeof data !== 'string' || !data){
				return null;
			}
			if(window.JSON && window.JSON.parse){
				return window.JSON.parse(data);
			}
			rvalidchars = /^[\],:{}\s]*$/,
			rvalidescape = /\\(?:["\\\/bfnrt]|u[0-9a-fA-F]{4})/g,
			rvalidtokens = /"[^"\\\n\r]*"|true|false|null|-?\d+(?:\.\d*)?(?:[eE][+\-]?\d+)?/g,
			rvalidbraces = /(?:^|:|,)(?:\s*\[)+/g;
			if(rvalidchars.test(data.replace(rvalidescape,'@').replace(rvalidtokens,']').replace(rvalidbraces,''))){
				return (new Function('return ' + data))();
			}
			zl.log('Invalid JSON Failure!  ' + data );
		}catch(e){
			zl.log('[Function][json] Invalid Json Data Failure!',e);
			return null;
		}
	};
	/*	
		conver Data XML
		data	Conetnt
		source	JQuery http://code.jquery.com/jquery-1.7.2.js
	*/
	zl.xml = zl.parseXML = function(data){
		try{
			if(typeof data !== 'string' || !data){
				return null;
			}
			var xml,tmp;
			try{
				if(window.DOMParser){
					tmp = new DOMParser();
					xml = tmp.parseFromString(data,'text/xml');
				}else{
					xml = new ActiveXObject('Microsoft.XMLDOM');
					xml.async = 'false';
					xml.loadXML(data);
				}
			}catch(e){
				xml = undefined;
			}
			if(!xml || !xml.documentElement || xml.getElementsByTagName('parsererror').length){
				zl.log('Invalid XML Failure:' + data);
			}
			return xml;
		}catch(e){
			zl.log('[Function][tag] Invalid XML Data Failure!',e);
			return null;	
		}
	};
	/*
		MD5
		source: http://pajhome.org.uk/crypt/md5/2.2/md5-min.js
	*/
	zl.md5 = {
		hexcase : 0,
		init : function(s){
			return zl.md5.hex_md5(s);
		},
		hex_md5 : function(a){
			return zl.md5.rstr2hex(zl.md5.rstr_md5(zl.md5.str2rstr_utf8(a)));
		},
		hex_hmac_md5 : function(a,b){
			return zl.md5.rstr2hex(zl.md5.rstr_hmac_md5(zl.md5.str2rstr_utf8(a),zl.md5.str2rstr_utf8(b)));
		},
		md5_vm_test : function(){
			return zl.md5.hex_md5("abc").toLowerCase()=="900150983cd24fb0d6963f7d28e17f72";
		},
		rstr_md5 : function(a){
			return zl.md5.binl2rstr(zl.md5.binl_md5(zl.md5.rstr2binl(a),a.length*8));
		},
		rstr_hmac_md5 : function(c,f){
			var e=zl.md5.rstr2binl(c);
			if(e.length>16){
				e=zl.md5.binl_md5(e,c.length*8)
			}
			var a=Array(16),d=Array(16);
			for(var b=0;b<16;b++){
				a[b]=e[b]^909522486;
				d[b]=e[b]^1549556828
			}
			var g=zl.md5.binl_md5(a.concat(zl.md5.rstr2binl(f)),512+f.length*8);
			return zl.md5.binl2rstr(zl.md5.binl_md5(d.concat(g),512+128));
		},
		rstr2hex : function(c){
			try{
				zl.md5.hexcase
			}
			catch(g){
				zl.md5.hexcase = 0;
			}
			var f=zl.md5.hexcase?"0123456789ABCDEF":"0123456789abcdef";
			var b="";
			var a;
			for(var d=0;d<c.length;d++){
				a=c.charCodeAt(d);
				b+=f.charAt((a>>>4)&15)+f.charAt(a&15)
			}
			return b;
		},
		str2rstr_utf8 : function(c){
			var b="";
			var d=-1;
			var a,e;
			while(++d<c.length){
				a=c.charCodeAt(d);
				e=d+1<c.length?c.charCodeAt(d+1):0;
				if(55296<=a&&a<=56319&&56320<=e&&e<=57343){
					a=65536+((a&1023)<<10)+(e&1023);
					d++
				}
				if(a<=127){
					b+=String.fromCharCode(a)
				}else{
					if(a<=2047){
						b+=String.fromCharCode(192|((a>>>6)&31),128|(a&63))
					}else{
						if(a<=65535){
							b+=String.fromCharCode(224|((a>>>12)&15),128|((a>>>6)&63),128|(a&63))
						}else{
							if(a<=2097151){
								b+=String.fromCharCode(240|((a>>>18)&7),128|((a>>>12)&63),128|((a>>>6)&63),128|(a&63))
							}
						}
					}
				}
			}
			return b
		},
		rstr2binl : function(b){
			var a=Array(b.length>>2);
			for(var c=0;c<a.length;c++){
				a[c]=0
			}
			for(var c=0;c<b.length*8;c+=8){
				a[c>>5]|=(b.charCodeAt(c/8)&255)<<(c%32)
			}
			return a
		},
		binl2rstr : function(b){
			var a="";
			for(var c=0;c<b.length*32;c+=8){
				a+=String.fromCharCode((b[c>>5]>>>(c%32))&255)
			}
			return a
		},
		binl_md5 : function(p,k){
			p[k>>5]|=128<<((k)%32);
			p[(((k+64)>>>9)<<4)+14]=k;
			var o=1732584193;
			var n=-271733879;
			var m=-1732584194;
			var l=271733878;
			for(var g=0;g<p.length;g+=16){
				var j=o;
				var h=n;
				var f=m;
				var e=l;
				o=zl.md5.md5_ff(o,n,m,l,p[g+0],7,-680876936);
				l=zl.md5.md5_ff(l,o,n,m,p[g+1],12,-389564586);
				m=zl.md5.md5_ff(m,l,o,n,p[g+2],17,606105819);
				n=zl.md5.md5_ff(n,m,l,o,p[g+3],22,-1044525330);
				o=zl.md5.md5_ff(o,n,m,l,p[g+4],7,-176418897);
				l=zl.md5.md5_ff(l,o,n,m,p[g+5],12,1200080426);
				m=zl.md5.md5_ff(m,l,o,n,p[g+6],17,-1473231341);
				n=zl.md5.md5_ff(n,m,l,o,p[g+7],22,-45705983);
				o=zl.md5.md5_ff(o,n,m,l,p[g+8],7,1770035416);
				l=zl.md5.md5_ff(l,o,n,m,p[g+9],12,-1958414417);
				m=zl.md5.md5_ff(m,l,o,n,p[g+10],17,-42063);
				n=zl.md5.md5_ff(n,m,l,o,p[g+11],22,-1990404162);
				o=zl.md5.md5_ff(o,n,m,l,p[g+12],7,1804603682);
				l=zl.md5.md5_ff(l,o,n,m,p[g+13],12,-40341101);
				m=zl.md5.md5_ff(m,l,o,n,p[g+14],17,-1502002290);
				n=zl.md5.md5_ff(n,m,l,o,p[g+15],22,1236535329);
				o=zl.md5.md5_gg(o,n,m,l,p[g+1],5,-165796510);
				l=zl.md5.md5_gg(l,o,n,m,p[g+6],9,-1069501632);
				m=zl.md5.md5_gg(m,l,o,n,p[g+11],14,643717713);
				n=zl.md5.md5_gg(n,m,l,o,p[g+0],20,-373897302);
				o=zl.md5.md5_gg(o,n,m,l,p[g+5],5,-701558691);
				l=zl.md5.md5_gg(l,o,n,m,p[g+10],9,38016083);
				m=zl.md5.md5_gg(m,l,o,n,p[g+15],14,-660478335);
				n=zl.md5.md5_gg(n,m,l,o,p[g+4],20,-405537848);
				o=zl.md5.md5_gg(o,n,m,l,p[g+9],5,568446438);
				l=zl.md5.md5_gg(l,o,n,m,p[g+14],9,-1019803690);
				m=zl.md5.md5_gg(m,l,o,n,p[g+3],14,-187363961);
				n=zl.md5.md5_gg(n,m,l,o,p[g+8],20,1163531501);
				o=zl.md5.md5_gg(o,n,m,l,p[g+13],5,-1444681467);
				l=zl.md5.md5_gg(l,o,n,m,p[g+2],9,-51403784);
				m=zl.md5.md5_gg(m,l,o,n,p[g+7],14,1735328473);
				n=zl.md5.md5_gg(n,m,l,o,p[g+12],20,-1926607734);
				o=zl.md5.md5_hh(o,n,m,l,p[g+5],4,-378558);
				l=zl.md5.md5_hh(l,o,n,m,p[g+8],11,-2022574463);
				m=zl.md5.md5_hh(m,l,o,n,p[g+11],16,1839030562);
				n=zl.md5.md5_hh(n,m,l,o,p[g+14],23,-35309556);
				o=zl.md5.md5_hh(o,n,m,l,p[g+1],4,-1530992060);
				l=zl.md5.md5_hh(l,o,n,m,p[g+4],11,1272893353);
				m=zl.md5.md5_hh(m,l,o,n,p[g+7],16,-155497632);
				n=zl.md5.md5_hh(n,m,l,o,p[g+10],23,-1094730640);
				o=zl.md5.md5_hh(o,n,m,l,p[g+13],4,681279174);
				l=zl.md5.md5_hh(l,o,n,m,p[g+0],11,-358537222);
				m=zl.md5.md5_hh(m,l,o,n,p[g+3],16,-722521979);
				n=zl.md5.md5_hh(n,m,l,o,p[g+6],23,76029189);
				o=zl.md5.md5_hh(o,n,m,l,p[g+9],4,-640364487);
				l=zl.md5.md5_hh(l,o,n,m,p[g+12],11,-421815835);
				m=zl.md5.md5_hh(m,l,o,n,p[g+15],16,530742520);
				n=zl.md5.md5_hh(n,m,l,o,p[g+2],23,-995338651);
				o=zl.md5.md5_ii(o,n,m,l,p[g+0],6,-198630844);
				l=zl.md5.md5_ii(l,o,n,m,p[g+7],10,1126891415);
				m=zl.md5.md5_ii(m,l,o,n,p[g+14],15,-1416354905);
				n=zl.md5.md5_ii(n,m,l,o,p[g+5],21,-57434055);
				o=zl.md5.md5_ii(o,n,m,l,p[g+12],6,1700485571);
				l=zl.md5.md5_ii(l,o,n,m,p[g+3],10,-1894986606);
				m=zl.md5.md5_ii(m,l,o,n,p[g+10],15,-1051523);
				n=zl.md5.md5_ii(n,m,l,o,p[g+1],21,-2054922799);
				o=zl.md5.md5_ii(o,n,m,l,p[g+8],6,1873313359);
				l=zl.md5.md5_ii(l,o,n,m,p[g+15],10,-30611744);
				m=zl.md5.md5_ii(m,l,o,n,p[g+6],15,-1560198380);
				n=zl.md5.md5_ii(n,m,l,o,p[g+13],21,1309151649);
				o=zl.md5.md5_ii(o,n,m,l,p[g+4],6,-145523070);
				l=zl.md5.md5_ii(l,o,n,m,p[g+11],10,-1120210379);
				m=zl.md5.md5_ii(m,l,o,n,p[g+2],15,718787259);
				n=zl.md5.md5_ii(n,m,l,o,p[g+9],21,-343485551);
				o=zl.md5.safe_add(o,j);
				n=zl.md5.safe_add(n,h);
				m=zl.md5.safe_add(m,f);
				l=zl.md5.safe_add(l,e)
			}
			return Array(o,n,m,l)
		},
		md5_cmn : function(h,e,d,c,g,f){
			return zl.md5.safe_add(zl.md5.bit_rol(zl.md5.safe_add(zl.md5.safe_add(e,h),zl.md5.safe_add(c,f)),g),d)
		},
		md5_ff : function(g,f,k,j,e,i,h){
			return zl.md5.md5_cmn((f&k)|((~f)&j),g,f,e,i,h)
		},
		md5_gg : function(g,f,k,j,e,i,h){
			return zl.md5.md5_cmn((f&j)|(k&(~j)),g,f,e,i,h)
		},
		md5_hh : function(g,f,k,j,e,i,h){
			return zl.md5.md5_cmn(f^k^j,g,f,e,i,h)
		},
		md5_ii : function(g,f,k,j,e,i,h){
			return zl.md5.md5_cmn(k^(f|(~j)),g,f,e,i,h)
		},
		safe_add : function(a,d){
			var c=(a&65535)+(d&65535);
			var b=(a>>16)+(d>>16)+(c>>16);
			return(b<<16)|(c&65535)
		},
		bit_rol : function(a,b){
			return(a<<b)|(a>>>(32-b))
		},
		source : 'http://pajhome.org.uk/crypt/md5/2.2/md5-min.js'
	};
	/*
		SHA1
		source: http://pajhome.org.uk/crypt/md5/2.2/sha1-min.js
	*/
	zl.sha1 = {
		hexcase : 0,
		b64pad : "",
		init : function(s){
			return zl.sha1.hex_sha1(s);
		},
		hex_sha1 : function(a){
			return zl.sha1.rstr2hex(zl.sha1.rstr_sha1(zl.sha1.str2rstr_utf8(a)))
		},
		hex_hmac_sha1 : function(a,b){
			return zl.sha1.rstr2hex(zl.sha1.rstr_hmac_sha1(zl.sha1.str2rstr_utf8(a),zl.sha1.str2rstr_utf8(b)))
		},
		sha1_vm_test : function(){
			return zl.sha1.hex_sha1("abc").toLowerCase()=="a9993e364706816aba3e25717850c26c9cd0d89d"
		},
		rstr_sha1 : function(a){
			return zl.sha1.binb2rstr(zl.sha1.binb_sha1(zl.sha1.rstr2binb(a),a.length*8))
		},
		rstr_hmac_sha1 : function(c,f){
			var e=zl.sha1.rstr2binb(c);
			if(e.length>16){
				e=zl.sha1.binb_sha1(e,c.length*8)
			}
			var a=Array(16),d=Array(16);
			for(var b=0;b<16;b++){
				a[b]=e[b]^909522486;
				d[b]=e[b]^1549556828
			}
			var g=zl.sha1.binb_sha1(a.concat(zl.sha1.rstr2binb(f)),512+f.length*8);
			return zl.sha1.binb2rstr(zl.sha1.binb_sha1(d.concat(g),512+160))
		},
		rstr2hex : function(c){
			try{
				zl.sha1.hexcase
			}catch(g){
				zl.sha1.hexcase=0
			}
			var f=zl.sha1.hexcase?"0123456789ABCDEF":"0123456789abcdef";
			var b="";
			var a;
			for(var d=0;d<c.length;d++){
				a=c.charCodeAt(d);
				b+=f.charAt((a>>>4)&15)+f.charAt(a&15)
			}
			return b
		},
		str2rstr_utf8 : function(c){
			var b="";
			var d=-1;
			var a,e;
			while(++d<c.length){
				a=c.charCodeAt(d);
				e=d+1<c.length?c.charCodeAt(d+1):0;
				if(55296<=a&&a<=56319&&56320<=e&&e<=57343){
					a=65536+((a&1023)<<10)+(e&1023);
					d++
				}
				if(a<=127){
					b+=String.fromCharCode(a)
				}else{
					if(a<=2047){
						b+=String.fromCharCode(192|((a>>>6)&31),128|(a&63))
					}else{
						if(a<=65535){
							b+=String.fromCharCode(224|((a>>>12)&15),128|((a>>>6)&63),128|(a&63))
						}else{
							if(a<=2097151){
								b+=String.fromCharCode(240|((a>>>18)&7),128|((a>>>12)&63),128|((a>>>6)&63),128|(a&63))
							}
						}
					}
				}
			}
			return b
		},
		rstr2binb : function(b){
			var a=Array(b.length>>2);
			for(var c=0;c<a.length;c++){
				a[c]=0
			}
			for(var c=0;c<b.length*8;c+=8){
				a[c>>5]|=(b.charCodeAt(c/8)&255)<<(24-c%32)
			}
			return a
		},
		binb2rstr : function(b){
			var a="";
			for(var c=0;c<b.length*32;c+=8){
				a+=String.fromCharCode((b[c>>5]>>>(24-c%32))&255)
			}
			return a
		},
		binb_sha1 : function(v,o){
			v[o>>5]|=128<<(24-o%32);
			v[((o+64>>9)<<4)+15]=o;
			var y=Array(80);
			var u=1732584193;
			var s=-271733879;
			var r=-1732584194;
			var q=271733878;
			var p=-1009589776;
			for(var l=0;l<v.length;l+=16){
				var n=u;
				var m=s;
				var k=r;
				var h=q;
				var f=p;
				for(var g=0;g<80;g++){
					if(g<16){
						y[g]=v[l+g]
					}
					else{
						y[g]=zl.sha1.bit_rol(y[g-3]^y[g-8]^y[g-14]^y[g-16],1)
					}
					var z=zl.sha1.safe_add(zl.sha1.safe_add(zl.sha1.bit_rol(u,5),zl.sha1.sha1_ft(g,s,r,q)),zl.sha1.safe_add(zl.sha1.safe_add(p,y[g]),zl.sha1.sha1_kt(g)));
					p=q;
					q=r;
					r=zl.sha1.bit_rol(s,30);
					s=u;
					u=z
				}
				u=zl.sha1.safe_add(u,n);
				s=zl.sha1.safe_add(s,m);
				r=zl.sha1.safe_add(r,k);
				q=zl.sha1.safe_add(q,h);
				p=zl.sha1.safe_add(p,f)
			}
			return Array(u,s,r,q,p)
		},
		sha1_ft : function(e,a,g,f){
			if(e<20){
				return(a&g)|((~a)&f)
			}
			if(e<40){
				return a^g^f
			}
			if(e<60){
				return(a&g)|(a&f)|(g&f)
			}
			return a^g^f
		},
		sha1_kt : function(a){
			return(a<20)?1518500249:(a<40)?1859775393:(a<60)?-1894007588:-899497514
		},
		safe_add : function(a,d){
			var c=(a&65535)+(d&65535);
			var b=(a>>16)+(d>>16)+(c>>16);
			return(b<<16)|(c&65535)
		},
		bit_rol : function(a,b){
			return(a<<b)|(a>>>(32-b))
		},
		source : 'http://pajhome.org.uk/crypt/md5/2.2/sha1-min.js'
	};
	/*
		Search In Ajax Tips In BaiDu
	*/
	zl.search_ajax = {
		/*	input	*/
		search_input : null,
		/*	list	*/
		search_list : null,
		/*	Show Stop Time	*/
		search_showtime : 8000,
		/*	Show Time Func	*/
		search_timeout : null,
		/*	Init	*/
		init : function(elem){
			try{
				elem = zl.$(elem);
				if(elem.tagName.toUpperCase() == "INPUT"){
					zl.att(zl.$(elem),'onkeyup',function(){zl.search_ajax.keySearch(this,event)});
					return 'Success';
				}else{
					elem = zl.$('<input>',elem);
					for(var i in elem){
						if(zl.att(elem[i],'type').toUpperCase() == 'TEXT'){
							zl.att(elem[i],'onkeyup',function(){zl.search_ajax.keySearch(this,event)});
							return 'Success';
						}
					}
					return 'Failure';
				}
			}catch(e){
				return e;
			}
		},
		/*	Key Search	*/
		keySearch : function(elem,e){
			e = e || window.event;
			var keynum = 0;
			if(window.event) keynum = e.keyCode;
			else if(e.which) keynum = e.which;
			if (keynum == 38 || keynum == 40) return;
			alert(keynum);
			zl.remove(elem,3000);
			return;
			elem = zl.$(elem);
			var s_key = '';
			if(elem.tagName.toUpperCase() == "INPUT"){
				s_key = elem.value;
				search_input = elem;
			}else{
				s_key = zl.$('<input>',elem)[0].value;
				search_input = zl.$('<input>',elem)[0];
			}
			if(s_key == ''){
				this.clear_search();
				return;	
			}
			var scripts = zl.$('<script>', zl.$('<head>')[0]);
			for(var ijs in scripts){
				if(zl.att(scripts[ijs],'id') == 'BaiDuJS'){
					zl.remove(scripts[ijs]);
				}
			}
			var src = 'http://suggestion.baidu.com/su?wd='+encodeURIComponent(s_key)+'&p=3&cb=window.bdsug.sug&t='+(new Date()).getTime();
			//zl.create({tagName:'script',id:'BaiDuJS',charset:'utf-8',src:src,pdom:zl.$('<head>')[0]});
			var ajs = zl.loadjs(src,'utf-8',null,true);
			zl.att(ajs,'id','BaiDuJS');
			window.bdsug = {};
			window.bdsug.sug = function(data){zl.search_ajax.search_data(data);};		//load over
			var loc = zl.loc(elem);
			var w = t = l = 0;
			if(loc != null){
				w = loc.width;
				t = loc.top+loc.height+2;
				l = loc.left;
			}else{
				w = obj.offsetWidth;
				t = (obj.offsetTop+obj.offsetHeight+2);
				l = obj.offsetLeft;
			}
			var css = 'position:absolute;background:#fff;width:'+w+'px;top:'+t+'px;left:'+l+'px;border:1px solid #817F82;display:none;z-index:9999;';
			var div_search_list = zl.create({cssText:css/*,pdom:obj.parentNode*/});
			this.clear_search();
			this.search_list = div_search_list;
		},
		/*	Clear Search List	*/
		clear_search : function(){
			if(this.search_list != null){ zl.remove(this.search_list); this.search_list = null;document.body.onclick = null;}	
		},
		/*	List In Click	*/
		search_click : function(elem){
			if(this.search_input != null){
				this.search_input.value = elem.innerText;
			}
			this.clear_search();
		},
		/*	List In onmouseover	*/
		search_mouver : function(elem){
			if (this.search_timeout != null) clearTimeout(this.search_timeout);
			for(var i = 0; i < elem.parentNode.parentNode.getElementsByTagName('tr').length; i++){
				elem.parentNode.parentNode.getElementsByTagName('tr').item(i).className = 'soretr';
			}
			elem.parentNode.className = 'soretrs';
		},
		/*	List In onmouseout	*/
		search_mouout : function(elem){
			if (this.search_timeout != null) clearTimeout(this.search_timeout);
			this.search_timeout = setTimeout(this.clear_search(),this.search_showtime);
			for(var i = 0; i < elem.parentNode.parentNode.getElementsByTagName('tr').length; i++){
				elem.parentNode.parentNode.getElementsByTagName('tr').item(i).className = 'soretr';
			}
		},
		/*	Load Ajax List	*/
		search_data : function(data){
			if(this.search_list != null && data.s != ''){
				var reary = data.s;
				var list_code = '<style>.soretr{cursor: default;}.soretrs{cursor: default;background-color:#EBEBEB;}.soretd{color: black;font: 14px arial;height: 25px;line-height: 25px;padding: 0 8px; text-align: left;}</style>';//.soretr:hover{background-color:#EBEBEB;}
				list_code += '<table id="st_list" cellspacing="0" cellpadding="2" width="100%"><tbody>';
				for (i = 1; i < reary.length; i++) {
					list_code += '<tr class="soretr"><td class="soretd">';
					if(reary[i].toUpperCase().indexOf(data.q.toUpperCase()) != -1)
						list_code += '<span>'+data.q+'</span><b style="color: black;">'+reary[i].slice(data.q.length)+'</b></td></tr>';
					else
						list_code += '<b style="color: black;">'+reary[i]+'</b></td></tr>';
				}
				list_code += '</tbody></table>';
				this.search_list.innerHTML = list_code;
				this.search_list.style.display = 'block';
				document.body.onclick = function(e){
					if(e.srcElement != 	this.search_input){
						this.clear_search();
					}
				}
				/*
				var tds = zl.$('<td>',zl.$('st_list'));
				for(var td in tds){
					zl.att(tds[td],'onclick',this.search_click(this));
					zl.att(tds[td],'onmouseover',this.search_mouver(this));
					zl.att(tds[td],'onmouseout',this.search_mouout(this));
				}
				*/
				/*	
					onclick="soclick(this);" onmouseover="mouver(this);" onmouseout="mouout(this);"
				*/
				if (this.search_timeout != null) clearTimeout(this.search_timeout);
				this.search_timeout = setTimeout(this.clear_search(),this.search_showtime);
				if(this.search_input != null){	
					/*	input  onkeydown	*/
					this.search_input.onkeydown = function(e){
						e = e || window.event;
						var keynum = 0;
						if(window.event) keynum = e.keyCode;
						else if(e.which) keynum = e.which;
						if (keynum == 38){
							if (search_timeout != null) clearTimeout(search_timeout);
							search_timeout = setTimeout(this.clear_search(),this.search_showtime);
							if(this.search_list != null){
								var altr = this.search_list.getElementsByTagName('tr');
								var _i = 0;
								for(var i = 0; i < altr.length; i++){
									if (altr.item(i).className == 'soretrs') _i = i;
									altr.item(i).className = 'soretr';
								}
								if(_i > 0){
									altr.item((_i-1)).className = 'soretrs';
									this.search_input.value = altr.item((_i-1)).innerText;
								}else{
									altr.item((altr.length-1)).className = 'soretrs';
									this.search_input.value = altr.item((altr.length-1)).innerText;
								}
							}
							return false;
						} else if (keynum == 40){
							if (search_timeout != null) clearTimeout(search_timeout);
							search_timeout = setTimeout(this.clear_search(),this.search_showtime);
							if(this.search_list != null){
								var altr = this.search_list.getElementsByTagName('tr');
								var _i = -1;
								for(var i = 0; i < altr.length; i++){
									if (altr.item(i).className == 'soretrs') _i = i;
									altr.item(i).className = 'soretr';
								}
								if(_i+1 >= altr.length){
									altr.item(0).className = 'soretrs';
									this.search_input.value = altr.item(0).innerText;
								}else{
									altr.item((_i+1)).className = 'soretrs';
									this.search_input.value = altr.item((_i+1)).innerText;
								}
							}
							return false;
						}
						return true;
					}
					/*	input onblur	*/
					this.search_input.onblur = function(){
						setTimeout(this.clear_search(),500);
					}
				}
			}
		},
		source : 'BaiDu'
	};
	/*
		Disable Select Content
	*/
	zl.noselect = zl.DisableSelect = function(elem,isdis){
		try{
			elem = zl.$(elem);
			if(typeof elem == 'undefined') elem = document;
			if(typeof isdis == 'undefined') isdis = false;
			elem.onselectstart = function(){return isdis;}	
		}catch(e){
			zl.log('[function][noselect] Failure! ',e);	
		}
	};
	/*
		Disable Menu
	*/
	zl.nomenu = zl.DisableMenu = function(elem,isdis){
		try{
			elem = zl.$(elem);
			if(typeof elem == 'undefined') elem = document;
			if(typeof isdis == 'undefined') isdis = false;
			elem.oncontextmenu = function(){return isdis;}	
		}catch(e){
			zl.log('[function][nomenu] Failure! ',e);	
		}
	};
	/*
		Select Elem Callback
	*/
	zl.selcall = zl.SelectCallback = function(elem,callback){
		try{
			if(typeof elem == 'undefined') elem = document;
			elem = zl.$(elem);
			elem.onmouseup = function(){
				var selDom = window.getSelection().focusNode;
				if(typeof selDom.tagName != 'undefined') selDom = selDom.innerText;
				else selDom = selDom.nodeValue;
				if(selDom.length > 0){
					if(typeof callback == 'undefined'){
						//var selcon = (zl.isIE) ? this.ownerDocument.selection.createRange().text : this.ownerDocument.getSelection();
						//var selcon = (zl.isIE) ? this.ownerDocument.selection.createRange().text : window.getSelection().toString();
						alert(selDom);
					}else{
						zl.run(callback);
					}
				}
			};
		}catch(e){
			zl.log('[function][nomenu] Failure! ',e);	
		}
	};
	
	
	zl.ready();
	
	window.zl = window.z = window._zl = window._z = zl;

})(window);

