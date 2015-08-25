<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Google 地图 API</title>
<link rel="stylesheet" href="Images/Admin_style.css">
<script language="javascript" src="../Scripts/Admin.js"></script>
<style type="text/css">
@import url("http://www.google.com/uds/css/gsearch.css");
@import url("http://www.google.com/uds/solutions/localsearch/gmlocalsearch.css");
}
</style>
<%
Longitude=Request("Longitude")
Latitude=Request("Latitude")
Proportion=Request("Proportion")
GoogleMapKey=Request("GoogleMapKey")
%>
<script charset="utf-8" src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=<%=GoogleMapKey%>" type="text/javascript"></script>
<script charset="utf-8" src="http://www.google.com/uds/api?file=uds.js&amp;v=1.0&amp;key=<%=GoogleMapKey%>" type="text/javascript"></script>
<script charset="utf-8" src="http://www.google.com/uds/solutions/localsearch/gmlocalsearch.js" type="text/javascript"></script>
<script type="text/javascript">
function initialize() {
    if (GBrowserIsCompatible()) {
        var map = new GMap2(document.getElementById("ChinaQJ_Map"));
        var customUI = map.getDefaultUI();
        customUI.maptypes.hybrid = false;
        map.setUI(customUI);
        map.setCenter(new GLatLng(<%=Latitude%>, <%=Longitude%>), <%=Proportion%>);
        map.addControl(new GMapTypeControl());
        map.addControl(new google.maps.LocalSearch(), new GControlPosition(G_ANCHOR_BOTTOM_RIGHT, new GSize(10,20)));
        GEvent.addListener(map,"click", function(overlay,latlng) {
            if (!overlay) {
                var myHtml = "<span style='color: red;'>请将您的公司地址经度、纬度、视图比例数值复制到相关接口</span><br />经度位置：<input name='x' type='text' id='x' value='"+ latlng.x.toFixed(6) +"' size='18' /><br />纬度位置：<input name='y' type='text' id='x' value='"+ latlng.y.toFixed(6) +"' size='18' /><br />视图比例：<input name='s' type='text' id='s' value='"+ map.getZoom() +"' size='18' /><br /><input type=\"button\" value=\"确定使用该坐标\" onclick=\"javascript: AddMap(\'"+ latlng.x.toFixed(6) +"\',\'"+ latlng.y.toFixed(6) +"\',\'"+ map.getZoom() +"\')\" \/>";
                map.openInfoWindow(latlng, myHtml);
            }
        }
        );
    }
}
GSearch.setOnLoadCallback(initialize);
</script>
</head>
<body onLoad="initialize()" onUnload="GUnload()">
<div id="ChinaQJ_Map" style="width: 640px; height: 480px;"></div>
</body>
</html>
