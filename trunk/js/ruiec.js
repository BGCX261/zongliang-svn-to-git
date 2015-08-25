/*
	My Javascript zongliang
*/
(function(window,undefined){
	
	var document = window.document;
	var navigator = window.navigator;
	var location = window.location;
	var undefined = undefined;
	
	var zl = function(id,dom){return zl.$(id,dom);};

	zl.version = '1.0';
	/*	
		zl.$ get Dom Object	id:name,dom:parentNode Dom.		
	*/
	zl.$ = function(obj,dom){
		try{
			if(typeof obj == 'string'){
				if(obj.charAt(0) == '<' && obj.charAt(obj.length-1) == '>' && obj.length >= 3){
					obj = obj.substr(1, obj.length-2);
					return (dom == undefined) ? document.getElementsByTagName(obj) : zl.$(dom).getElementsByTagName(obj);
				} else if(obj.charAt(0) == '.' && obj.length >= 2){
					obj = obj.substr(1, obj.length-1);
					if(typeof getElementsByClassName != 'undefined'){
						return (dom == undefined) ? document.getElementsByClassName(obj) : zl.$(dom).getElementsByClassName(obj);
					}else{
						var oElm = (dom == undefined) ? document : zl.$(dom);
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
					if(typeof getElementsByName != 'undefined'){
						return (dom == undefined) ? document.getElementsByName(obj) : zl.$(dom).getElementsByName(obj);
					}else{
						var oElm = (dom == undefined) ? document : zl.$(dom);
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
				} else {
					return (dom == undefined) ? document.getElementById(obj) : zl.$(dom).getElementById(obj);
				}
			} else if(typeof obj == 'function'){
				zl.readyCallBacks[zl.readyCallBacks.length] = obj;
				zl.ready();
				//window.onload = function(){zl.ready();}
			} else {
				return obj;	
			}
		}catch(e){
			zl.log('Get $ '+obj+' Error! '+e.message);
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
	zl.r = zl.rand = function(rmin,rmax){return Math.round(rmin||0+(Math.random()*(rmax-rmin)||0));};
	// new error
	zl.e = zl.error = function(msg){throw new Error(msg);};
	// log con:content ,e:error
	zl.log = function(con,e){
		if(window.console && window.console.log){
			if(e != undefined && e.message != undefined){
				console.log(con + '\r\n [Error: ' + e.message + ' ]');
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
		zl.create({cssText:'width:100%;height:24px;background:#ccc;color:red;font-size:14px;',pdom:showEr,content:'\u9519\u8bef\u63d0\u793a<a href="javascript:zl.remove(\'show_Error_Msg\',3);" style="float:right;">关闭</a>'});
		zl.create({cssText:'width:100%;background:#FFF;color:red;font-size:13px;padding:10px;overflow:hidden;display:block;',pdom:showEr,content:'<span>' + msg + '</span>'});
		
		setTimeout(function(){zl._fade(showEr,0,3,function(){zl.remove(this);});},3000);
		
	}
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
				zl.log('Remove Object ' + obj + ' Failure! [Error: Is Null! ]');
			}
		}
	};
	/*	
		Get js parameter	
	*/
	zl.p = zl.parameter = function(name,def){
		try{
			var scripts = zl.$('<script>');
			var js = scripts[scripts.length-1];
			if(name == undefined) return js;
			var qs = js.src.split('?');
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
			return (def == undefined) ? '' : def;
		}catch(e){
			zl.log('Get Parameter Failure! ', e);
			return '';
		}
	};
	/*
		Get All Child Nodes
	*/
	zl.childNodes = function(elem,tag){
		var childs = new Array();
		var nodes = elem.childNodes;
		for(var i = 0; i < nodes.length; i++){
			if(typeof nodes[i].tagName != 'undefined'){
				if(typeof tag != 'string' || nodes[i].tagName.toLowerCase() == tag.toLowerCase()){
					childs[childs.length] = nodes[i];
				}
			}
		}
		return childs;
	}
	/*
		Get Or Set Attrib
	*/
	zl.att = zl.attribute = function(elem,key,val){
		try{
			if(typeof val != 'undefined'){
				if(typeof val == 'function'){
					try{eval('elem.'+key+' = '+val+';');}catch(e){elem.setAttribute(key, val);}
				}else{
					try{elem.setAttribute(key, val);}catch(e){eval('elem.'+key+' = '+val+';');}
				}
			} else {
				return elem.getAttribute(key);
			}
		}catch(e){
			zl.log('Get Or Set Attribute In '+elem+' Failure! ', e);
			return null;
		}
	}
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
		if(obj != undefined){
			zl.readyCallBacks[zl.readyCallBacks.length] = obj;
		}
		zl.loadTime = zl.loadTime + 1;
		if(document.readyState == 'complete' && zl.readyCallBacks != []){
			for(var i = 0,ic = zl.readyCallBacks.length; i < ic; i++ ){
				try{
					if(typeof zl.readyCallBacks[i] == 'string'){
						eval(zl.readyCallBacks[i]);
					}else{
						zl.readyCallBacks[i].call(document);
					}
					//delete zl.readyCallBacks[i];
				}catch(e){
					zl.log('Ready CallBack Failure! ', e);
				}
			}
			zl.readyCallBacks = [];
		}else if(document.readyState != 'complete'){
			setTimeout(function(){zl.ready();},1);
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
			zl.log('Check Default Option Failure! ', e);
			return null;	
		}
	};
	/*
		Get XmlHttp Object Ajax
		return Object or null;
	*/
	zl.getXmlHttpObject = function(){
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
				xmlAjax.onreadystatechange = function(){
					if(xmlAjax.readyState == 4 || xmlAjax.readyState == "complete"){
						try{
							if(opt.success){
								var reData = xmlAjax.responseText;
								if(opt.dataType == 'json'){
									reData = zl.json(reData);
								} else if (opt.dataType == 'xml'){
									reData = zl.xml(reData);
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
				xmlAjax.open(opt.type, opt.url + '?' + opt.query, opt.async);
				xmlAjax.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
				xmlAjax.send(opt.query);
			}catch(e){
				zl.log('Send Ajax Failure! ', e);
				alert(e.message);
			}
		}	
	};
	/*
		open new window run code
		code Code
	*/
	zl.runCode = function(code){
		if(code != ''){
			var newwin = window.open('','','');
			newwin.opener = null;
			newwin.document.write(code);
			newwin.document.close();
			return newwin;
		}
	};
	/*	
		Create Object Dom
		opt option
	*/
	zl.create = function(opt){
		try{
			var df_opt = {'tagName':'div','id':'c_obj','name':'c_obj','css':'','cssText':'','content':'','append':true,'pdom':''};
			opt = zl.cd(df_opt,opt);
			var obj = document.createElement(opt.tagName);
			obj.id = opt.id;
			obj.name = opt.name;
			obj.className = opt.css;
			obj.style.cssText = opt.cssText;
			obj.innerHTML = opt.content;
			for(var i in opt){
				if(i != 'tagName' && i != 'id' && i != 'name' && i != 'css' && i != 'cssText' && i != 'content' && i != 'append' && i != 'pdom'){
					zl.att(obj,i,opt[i]);
					//try{
					//	if(opt[i] != undefined) obj.setAttribute(i, opt[i]);
					//}catch(e){
					//	eval('obj.'+i+' = opt.'+i+';');
					//}
				}
			}
			if(opt.append){
				if(opt.pdom != ''){
					zl.$(opt.pdom).appendChild(obj);
				}else{
					document.body.appendChild(obj);
				}
			}
			return obj;
		}catch(e){
			zl.log('CreateElement Object Failure! ', e);
			alert(e.message);
			return null;
		}
	};
	/*
		ImageErr check images onerror
		img		image object
		url		default image url
	*/
	zl.imageErr = function(obj,url){
		obj = zl.$(obj);
		//img.onerror = function(){img.src = url;}
		var img = new Image();
		img.src = obj.src;
		img.onerror = function(){
			obj.setAttribute('source-src', obj.src);
			obj.src = url;
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
	};
	/*
		Get  Path
		src		path
		return (error)?'':the Path;
	*/
	zl.getPath = function(src){
		try{
			if(src == undefined) src = zl.parameter().src;
			var path = src.substring(0,(src.length - zl.parameter('').length));
			return path.substring(0,path.lastIndexOf('/')+1);
		}catch(e){
			zl.log('Get Path Failure! ', e);
			return '';
		}
	};
	/*
		Get User Browser Info	
		r	retype
		return (r != null)?Browser Version:Object info;
	*/
	zl.browser = function(r){
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
			zl.log('Get Browser Info Failure! ', e);
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
			zl.log('start: '+start+" end: "+transparency);
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
			zl.log('Change object Transparency Failure![ ' + element + '] ', e);
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
			zl.log('Change object Location Failure! [' + element + '] ', e);
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
			zl.log('Change object Size Failure! [' + element + '] ', e);
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
				zl.log('Registration Key '+shortcut_combination+' Failure! ', e);
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
				zl.log('Remove Key '+shortcut_combination+' Failure! ',e);
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
				zl.log('Add Cookie [' + opt.name + ']:[' + opt.value + '] Failure! ', e);
			}
		},
		get : function(ckName){
			try{
				if(document.cookie.length>0){
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
				zl.log('Get Cookie [' + ckName + '] Failure! ', e);
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
				zl.log('Delete Cookie [' + ckName + '] Failure.');
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
				if(zl.$(o) == null) return false;
				return (zl.$(o).value == '' || zl.$(o).value.replace(/(^\s+)|(\s+$i)/g,'') == '');
			}catch(e){
				return false;
			}
		},
		checkIsSame : function(o,r){
			try{
				if(zl.$(o) == null || zl.$(r) == null) return false;
				return (zl.$(o).value == zl.$(r).value);
			}catch(e){
				return false;
			}
		},
		checkValLength : function(o,n,x){
			try{
				if(zl.$(o) == null) return false;
				return (n <= zl.$(o).value.length && zl.$(o).value.length <= x);
			}catch(e){
				return false;	
			}
		},
		checkObject : function(o,r){
			try{
				if(zl.$(o) == null || r == undefined) return false;
				return (zl.$(o).value.replace(new RegExp(r,'g'),'') == '');
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
				if(obj == undefined || obj == null)
					return false;
				if(obj == parent)
					return true;
			}
			return false;
		}catch(e){
			zl.log('Check Object Dom Failure! ', e);
			return false;
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
			zl.log('Show Object Dom Failure! ', e);
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
				if(op[i] != obj && op[i] != other){
					op[i].className = oldclass;
				}else if(op[i] != other){
					op[i].className = newclass;
				}
			}
		}catch(e){
			zl.log('Change Dom Class Failure! ', e);
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
		conver Data JSON
		data	Conetnt
		source	JQuery http://code.jquery.com/jquery-1.7.2.js
	*/
	zl.json = zl.parseJSON = function(data){
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
	};
	/*	
		conver Data XML
		data	Conetnt
		source	JQuery http://code.jquery.com/jquery-1.7.2.js
	*/
	zl.xml = zl.parseXML = function(data){
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
	};
	
	
	zl.ready();
	
	window.zl = window.z = window._zl = window._z = zl;

})(window);


/*

window.onclick = function(e){
	var o = e.srcElement;
	if(o != document.body && o.name != '_cobj'){
		_fade(o,0,3,function(){
			var cssText = "position:absolute;background:#fff;border:1px dashed #ccc;z-index:999;cursor:pointer;text-align:center;";
			cssText += "height:"+(o.offsetHeight-2)+"px;line-height:"+(o.offsetHeight-2)+"px;";
			cssText += "width:"+(o.offsetWidth-2)+"px;height:"+(o.offsetHeight-2)+"px;top:"+o.offsetTop+"px;left:"+o.offsetLeft+"px;";
			createObj({
				'cssText':cssText,
				'title':'点击显示',
				'content':'隐藏内容',
				'onclick':(function(o){return function(e){_fade(o,100,3);remove_obj(this)};})(o),
				'onmouseover':function(){this.style.zIndex = (parseInt(this.style.zIndex)+100);this.style.borderColor = 'red';},
				'onmouseout':function(){this.style.zIndex = (parseInt(this.style.zIndex)-100);this.style.borderColor = '#ccc';}
			});
		});
	}
}

*/
