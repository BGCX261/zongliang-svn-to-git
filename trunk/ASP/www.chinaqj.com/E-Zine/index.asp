
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>ChinaQJ e zine</title>
<meta name="keywords" content="E-zine" />
<meta name="description" content="" />
<script type="text/javascript" src="Flash.js"></script>
</head>

<body bgcolor="white" style="margin: 0; padding: 0px;">
<div id="E-zine">不支持Flash</div>
<script type="text/javascript">
var objFlash = new ChinaQJFlash("ChinaQJE-zine.swf?id=<%= Trim(Request.QueryString("id")) %>", "", "100%", "100%", "7", "", false, "high");
objFlash.addParam("wmode", "transparent");
objFlash.addParam("menu", "false");
objFlash.addParam("quality", "best");
objFlash.addParam("bgcolor", "#FFFFFF");
objFlash.addParam("allowScriptAccess", "sameDomain");
objFlash.addParam("allowFullScreen", "true");
objFlash.write("E-zine");
</script>
</body>
</html>
