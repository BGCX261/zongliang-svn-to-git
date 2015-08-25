<!--#include file="../Include/Const.Asp" -->
<!--#include file="../Include/ConnSiteData.Asp" -->
<%
Language=Trim(Request.QueryString("Language"))
Call SiteInfo()
If GoogleMapType = 1 Then
    GoogleMapType = "G_SATELLITE_MAP"
ElseIf GoogleMapType = 2 Then
    GoogleMapType = "G_HYBRID_MAP"
Else
    GoogleMapType = "G_NORMAL_MAP"
End If
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>公司地图</title>
<script charset="utf-8" src="http://maps.google.com/maps?file=api&v=2&key=<%=GoogleMapKey%>" type="text/javascript"></script>
<style type="text/css">
body {
    margin: 0;
    color: #444444;
    font-family: arial, helvetica, sans-serif;
    font-size: 12px;
}
a {
    color: #444444;
    text-decoration: none;
}
a:hover, a:active {
    color: #ec0000;
}
</style>
</head>

<body>
<div id="ChinaQJ_Map" style="width: 690px; height: 480px;"></div>
<script type="text/javascript">
//<![CDATA[
var map = new GMap2(document.getElementById("ChinaQJ_Map"));
var customUI = map.getDefaultUI();
customUI.maptypes.hybrid = false;
map.setUI(customUI);
map.setMapType(<%=GoogleMapType%>);
map.addControl(new GMapTypeControl());
map.setCenter(new GLatLng(<%=Latitude%>, <%=Longitude%>), <%=Proportion%>);
var point = new GPoint(<%=Longitude%>, <%=Latitude%>);
var Marker = new GMarker(point);
var Html = '<%=GoogleMapHtml%>';
GEvent.addListener(Marker, "mouseover", function() {
    Marker.openInfoWindowHtml(Html);
}
);
map.addOverlay(Marker);
//]]>
</script>
</body>
</html>