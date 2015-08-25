<!--#include file="../Include/Const.asp" -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>自定义函数调用</title>
<link rel="stylesheet" href="Images/Admin_style.css">
</head>
<%
dim GainedName,LabelID
GainedName=Request("GainedName")
LabelID=Trim(Request.QueryString("LabelID"))
%>
<script language="javascript" type="text/javascript">
function AddLabelJS(Name){
    var AddJS="{%="+Name+"(";
    switch(Name){
        case "ChinaQJMenuHeadNavigation":
        AddJS+=document.myform.RowNum.value;
        break;
        case "ChinaQJSlide":
        AddJS+=document.myform.SlideWidth.value;
        AddJS+=","+document.myform.SlideHeight.value;
        break;
        case "ChinaQJRotation":
        AddJS+=document.myform.SlideWidth.value;
        AddJS+=","+document.myform.SlideHeight.value;
        break;
        case "ChinaQJColorful":
        AddJS+=document.myform.SlideWidth.value;
        AddJS+=","+document.myform.SlideHeight.value;
        break;
        case "ChinaQJDownLoad":
        AddJS+='"'+document.myform.DownClass.value+'"';
        AddJS+=","+document.myform.DownCount.value;
        AddJS+=","+document.myform.DownFont.value;
        break;
        case "ChinaQJOthers":
        AddJS+='"'+document.myform.OthersClass.value+'"';
        AddJS+=","+document.myform.OthersCount.value;
        AddJS+=","+document.myform.OthersFont.value;
        break;
        case "ChinaQJIndexNews":
        AddJS+='"'+document.myform.NewsClass.value+'"';
        AddJS+=","+document.myform.NewsCount.value;
        AddJS+=","+document.myform.NewsFont.value;
        break;
        case "ChinaQJNewsNotice":
        AddJS+='"'+document.myform.NewsClass.value+'"';
        AddJS+=","+document.myform.NewsCount.value;
        AddJS+=","+document.myform.NewsFont.value;
        break;
        case "ChinaQJIndexProducts":
        if(document.myform.ProductKind1.checked==true){
            AddJS+="1";
        }
        if(document.myform.ProductKind2.checked==true){
            AddJS+="2";
        }
        if(document.myform.ProductKind3.checked==true){
            AddJS+="3";
        }
        AddJS+=',"'+document.myform.ProductClass.value+'"';
        AddJS+=","+document.myform.ProductRow.value;
        AddJS+=","+document.myform.ProductColumns.value;
        AddJS+=","+document.myform.ProductPicW.value;
        AddJS+=","+document.myform.ProductPicH.value;
        AddJS+=","+document.myform.ProductTitleFont.value;
        break;
        case "ChinaQJIndexFriendLinks":
        AddJS+=document.myform.LineNumber.value;
        AddJS+=","+document.myform.Columns.value;
        break;
        case "ChinaQJIndexSelPlay":
        AddJS+="Video,"+document.myform.PlayWidth.value;
        AddJS+=","+document.myform.PlayHeight.value;
        break;
        case "ChinaQJSiteMapCoordinate":
        AddJS+=document.myform.MapWidth.value;
        AddJS+=","+document.myform.MapHeight.value;
        break;
        case "ChinaQJSearchCount":
        AddJS+=document.myform.SearchCount.value;
        AddJS+=","+document.myform.SearchFont.value+',""';
        break;
        case "ChinaQJProductListWebContent":
        AddJS+='"ChinaQJ_ProductSort",request.QueryString("SortID"),"",'+document.myform.ProductListPicW.value;
        AddJS+=","+document.myform.ProductListPicH.value;
        AddJS+=","+document.myform.ProductListTitleFont.value;
        break;
    }
    AddJS+=")%}";
    
    window.returnValue = AddJS;
	
	dialogArguments.insertHTML<%= LabelID %>(AddJS);
	
    window.close();
}
</script>

<body style="background-color: #d4d0c8;">
<% If GainedName="ChinaQJMenuHeadNavigation" Then %>
<table width="98%" border="0" align="center" cellpadding="5" cellspacing="1">
  <form action="" method="post" name="myform" id="myform">
    <tr>
      <td><fieldset>
          <legend>顶部导航函数标签</legend>
          <table width="100%" border="0" align="center">
            <tr>
              <td width="35%">调用记录数量：</td>
              <td width="65%"><input type="text" name="RowNum" size="10" value="8" /></td>
            </tr>
          </table>
        </fieldset></td>
    </tr>
    <tr align="center">
      <td scope="row"><input type="button" name="Submit" value="确定" onClick="AddLabelJS('ChinaQJMenuHeadNavigation');" />
        <input type="button" value="取消" onClick="window.close();" /></td>
    </tr>
  </form>
</table>
<% elseIf GainedName="ChinaQJSlide" Then %>
<table width="98%" border="0" align="center" cellpadding="5" cellspacing="1">
  <form action="" method="post" name="myform" id="myform">
    <tr>
      <td><fieldset>
          <legend>幻灯片一函数标签</legend>
          <table width="100%" border="0" align="center">
            <tr>
              <td>幻灯片宽度：
                <input type="text" name="SlideWidth" size="10" value="500" /></td>
              <td>幻灯片高度：
                <input type="text" name="SlideHeight" size="10" value="300" /></td>
            </tr>
          </table>
        </fieldset></td>
    </tr>
    <tr align="center">
      <td scope="row"><input type="button" name="Submit" value="确定" onClick="AddLabelJS('ChinaQJSlide');" />
        <input type="button" value="取消" onClick="window.close();" /></td>
    </tr>
  </form>
</table>
<% elseIf GainedName="ChinaQJRotation" Then %>
<table width="98%" border="0" align="center" cellpadding="5" cellspacing="1">
  <form action="" method="post" name="myform" id="myform">
    <tr>
      <td><fieldset>
          <legend>幻灯片二函数标签</legend>
          <table width="100%" border="0" align="center">
            <tr>
              <td>幻灯片宽度：
                <input type="text" name="SlideWidth" size="10" value="500" /></td>
              <td>幻灯片高度：
                <input type="text" name="SlideHeight" size="10" value="300" /></td>
            </tr>
          </table>
        </fieldset></td>
    </tr>
    <tr align="center">
      <td scope="row"><input type="button" name="Submit" value="确定" onClick="AddLabelJS('ChinaQJRotation');" />
        <input type="button" value="取消" onClick="window.close();" /></td>
    </tr>
  </form>
</table>
<% elseIf GainedName="ChinaQJColorful" Then %>
<table width="98%" border="0" align="center" cellpadding="5" cellspacing="1">
  <form action="" method="post" name="myform" id="myform">
    <tr>
      <td><fieldset>
          <legend>幻灯片三函数标签</legend>
          <table width="100%" border="0" align="center">
            <tr>
              <td>幻灯片宽度：
                <input type="text" name="SlideWidth" size="10" value="500" /></td>
              <td>幻灯片高度：
                <input type="text" name="SlideHeight" size="10" value="300" /></td>
            </tr>
          </table>
        </fieldset></td>
    </tr>
    <tr align="center">
      <td scope="row"><input type="button" name="Submit" value="确定" onClick="AddLabelJS('ChinaQJColorful');" />
        <input type="button" value="取消" onClick="window.close();" /></td>
    </tr>
  </form>
</table>
<% elseIf GainedName="ChinaQJDownLoad" Then %>
<table width="98%" border="0" align="center" cellpadding="5" cellspacing="1">
  <form action="" method="post" name="myform" id="myform">
    <tr>
      <td><fieldset>
          <legend>下载类调用函数标签</legend>
          <table width="100%" border="0" align="center">
            <tr>
              <td>分类ID：
                <input type="text" name="DownClass" size="8" value="0," /></td>
              <td>调用数量：
                <input type="text" name="DownCount" size="8" value="8" /></td>
              <td>标题文字截取：
                <input type="text" name="DownFont" size="8" value="20" /></td>
            </tr>
          </table>
        </fieldset></td>
    </tr>
    <tr align="center">
      <td scope="row"><input type="button" name="Submit" value="确定" onClick="AddLabelJS('ChinaQJDownLoad');" />
        <input type="button" value="取消" onClick="window.close();" /></td>
    </tr>
  </form>
</table>
<% elseIf GainedName="ChinaQJOthers" Then %>
<table width="98%" border="0" align="center" cellpadding="5" cellspacing="1">
  <form action="" method="post" name="myform" id="myform">
    <tr>
      <td><fieldset>
          <legend>其他信息类调用函数标签</legend>
          <table width="100%" border="0" align="center">
            <tr>
              <td>分类ID：
                <input type="text" name="OthersClass" size="8" value="0," /></td>
              <td>调用数量：
                <input type="text" name="OthersCount" size="8" value="8" /></td>
              <td>标题文字截取：
                <input type="text" name="OthersFont" size="8" value="20" /></td>
            </tr>
          </table>
        </fieldset></td>
    </tr>
    <tr align="center">
      <td scope="row"><input type="button" name="Submit" value="确定" onClick="AddLabelJS('ChinaQJOthers');" />
        <input type="button" value="取消" onClick="window.close();" /></td>
    </tr>
  </form>
</table>
<% elseIf GainedName="ChinaQJIndexNews" Then %>
<table width="98%" border="0" align="center" cellpadding="5" cellspacing="1">
  <form action="" method="post" name="myform" id="myform">
    <tr>
      <td><fieldset>
          <legend>新闻动态类调用函数标签</legend>
          <table width="100%" border="0" align="center">
            <tr>
              <td>分类ID：
                <input type="text" name="NewsClass" size="8" value="0," /></td>
              <td>调用数量：
                <input type="text" name="NewsCount" size="8" value="8" /></td>
              <td>标题文字截取：
                <input type="text" name="NewsFont" size="8" value="20" /></td>
            </tr>
          </table>
        </fieldset></td>
    </tr>
    <tr align="center">
      <td scope="row"><input type="button" name="Submit" value="确定" onClick="AddLabelJS('ChinaQJIndexNews');" />
        <input type="button" value="取消" onClick="window.close();" /></td>
    </tr>
  </form>
</table>
<% elseIf GainedName="ChinaQJNewsNotice" Then %>
<table width="98%" border="0" align="center" cellpadding="5" cellspacing="1">
  <form action="" method="post" name="myform" id="myform">
    <tr>
      <td><fieldset>
          <legend>新闻动态类调用函数标签</legend>
          <table width="100%" border="0" align="center">
            <tr>
              <td>分类ID：
                <input type="text" name="NewsClass" size="8" value="0," /></td>
              <td>调用数量：
                <input type="text" name="NewsCount" size="8" value="8" /></td>
              <td>标题文字截取：
                <input type="text" name="NewsFont" size="8" value="20" /></td>
            </tr>
          </table>
        </fieldset></td>
    </tr>
    <tr align="center">
      <td scope="row"><input type="button" name="Submit" value="确定" onClick="AddLabelJS('ChinaQJNewsNotice');" />
        <input type="button" value="取消" onClick="window.close();" /></td>
    </tr>
  </form>
</table>
<% elseIf GainedName="ChinaQJIndexProducts" Then %>
<table width="98%" border="0" align="center" cellpadding="5" cellspacing="1">
  <form action="" method="post" name="myform" id="myform">
    <tr>
      <td><fieldset>
          <legend>产品类调用函数标签</legend>
          <table width="100%" border="0" align="center">
            <tr>
              <td colspan="4">排序类型：
                <input type="radio" name="ProductKind" id="ProductKind1" value="1" checked />
                按ID
                <input type="radio" name="ProductKind" id="ProductKind2" value="2" />
                新品
                <input type="radio" name="ProductKind" id="ProductKind3" value="3" />
                推荐
                <input type="radio" name="ProductKind" value="4" />
                按点击数</td>
            </tr>
            <tr>
              <td>分类ID：</td>
              <td><input type="text" name="ProductClass" size="8" value="0," /></td>
              <td>行数：</td>
              <td><input type="text" name="ProductRow" size="8" value="2" /></td>
            </tr>
            <tr>
              <td>列数：</td>
              <td><input type="text" name="ProductColumns" size="8" value="4" /></td>
              <td>缩略图宽度：</td>
              <td><input type="text" name="ProductPicW" size="8" value="156" /></td>
            </tr>
            <tr>
              <td>缩略图高度：</td>
              <td><input type="text" name="ProductPicH" size="8" value="100" /></td>
              <td>标题截取：</td>
              <td><input type="text" name="ProductTitleFont" size="8" value="20" /></td>
            </tr>
          </table>
        </fieldset></td>
    </tr>
    <tr align="center">
      <td scope="row"><input type="button" name="Submit" value="确定" onClick="AddLabelJS('ChinaQJIndexProducts');" />
        <input type="button" value="取消" onClick="window.close();" /></td>
    </tr>
  </form>
</table>
<% elseIf GainedName="ChinaQJIndexFriendLinks" Then %>
<table width="98%" border="0" align="center" cellpadding="5" cellspacing="1">
  <form action="" method="post" name="myform" id="myform">
    <tr>
      <td><fieldset>
          <legend>友情链接函数标签</legend>
          <table width="100%" border="0" align="center">
            <tr>
              <td>行数：
                <input type="text" name="LineNumber" size="10" value="2" /></td>
              <td>列数：
                <input type="text" name="Columns" size="10" value="2" /></td>
            </tr>
          </table>
        </fieldset></td>
    </tr>
    <tr align="center">
      <td scope="row"><input type="button" name="Submit" value="确定" onClick="AddLabelJS('ChinaQJIndexFriendLinks');" />
        <input type="button" value="取消" onClick="window.close();" /></td>
    </tr>
  </form>
</table>
<% elseIf GainedName="ChinaQJIndexSelPlay" Then %>
<table width="98%" border="0" align="center" cellpadding="5" cellspacing="1">
  <form action="" method="post" name="myform" id="myform">
    <tr>
      <td><fieldset>
          <legend>视频播放接口函数标签</legend>
          <table width="100%" border="0" align="center">
            <tr>
              <td>视频宽度：
                <input type="text" name="PlayWidth" size="10" value="200" /></td>
              <td>视频高度：
                <input type="text" name="PlayHeight" size="10" value="200" /></td>
            </tr>
          </table>
        </fieldset></td>
    </tr>
    <tr align="center">
      <td scope="row"><input type="button" name="Submit" value="确定" onClick="AddLabelJS('ChinaQJIndexSelPlay');" />
        <input type="button" value="取消" onClick="window.close();" /></td>
    </tr>
  </form>
</table>
<% elseIf GainedName="ChinaQJSiteMapCoordinate" Then %>
<table width="98%" border="0" align="center" cellpadding="5" cellspacing="1">
  <form action="" method="post" name="myform" id="myform">
    <tr>
      <td><fieldset>
          <legend>企业地图函数标签</legend>
          <table width="100%" border="0" align="center">
            <tr>
              <td>地图显示宽度：
                <input type="text" name="MapWidth" size="10" value="350" /></td>
              <td>地图显示高度：
                <input type="text" name="MapHeight" size="10" value="180" /></td>
            </tr>
          </table>
        </fieldset></td>
    </tr>
    <tr align="center">
      <td scope="row"><input type="button" name="Submit" value="确定" onClick="AddLabelJS('ChinaQJSiteMapCoordinate');" />
        <input type="button" value="取消" onClick="window.close();" /></td>
    </tr>
  </form>
</table>
<% elseIf GainedName="ChinaQJSearchCount" Then %>
<table width="98%" border="0" align="center" cellpadding="5" cellspacing="1">
  <form action="" method="post" name="myform" id="myform">
    <tr>
      <td><fieldset>
          <legend>搜索统计函数标签</legend>
          <table width="100%" border="0" align="center">
            <tr>
              <td>总调用数量：
                <input type="text" name="SearchCount" size="10" value="8" /></td>
              <td>文字截取：
                <input type="text" name="SearchFont" size="10" value="10" /></td>
            </tr>
          </table>
        </fieldset></td>
    </tr>
    <tr align="center">
      <td scope="row"><input type="button" name="Submit" value="确定" onClick="AddLabelJS('ChinaQJSearchCount');" />
        <input type="button" value="取消" onClick="window.close();" /></td>
    </tr>
  </form>
</table>
<% elseIf GainedName="ChinaQJProductListWebContent" Then %>
<table width="98%" border="0" align="center" cellpadding="5" cellspacing="1">
  <form action="" method="post" name="myform" id="myform">
    <tr>
      <td><fieldset>
          <legend>产品列表调用函数标签</legend>
          <table width="100%" border="0" align="center">
            <tr>
              <td>缩略图宽度：
                <input type="text" name="ProductListPicW" size="8" value="156" /></td>
              <td>缩略图高度：
                <input type="text" name="ProductListPicH" size="8" value="100" /></td>
              <td>标题文字截取：
                <input type="text" name="ProductListTitleFont" size="8" value="20" /></td>
            </tr>
          </table>
        </fieldset></td>
    </tr>
    <tr align="center">
      <td scope="row"><input type="button" name="Submit" value="确定" onClick="AddLabelJS('ChinaQJProductListWebContent');" />
        <input type="button" value="取消" onClick="window.close();" /></td>
    </tr>
  </form>
</table>
<% End If %>
</body>
</html>