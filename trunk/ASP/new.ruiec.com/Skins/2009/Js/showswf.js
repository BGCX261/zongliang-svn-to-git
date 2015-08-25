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

var path = P("");
	
var flashvars = {};
flashvars.xml = path + "swf/config.xml";
var attributes = {};
attributes.wmode = "transparent";
attributes.id = "slider";
swfobject.embedSWF(path + "swf/cu3er.swf", "objswf", "940", "284", "9", path + "swf/expressInstall.swf", flashvars, attributes);
