<!--#include file="CheckAdmin.asp" -->
<!--#include file="../Include/Version.asp" -->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="shortcut icon" href="favicon.ico"/>
<title>ChinaQJ <%=Str_Soft_Version%></title>
<LINK href="AdminDefaultTheme/index.css" type="text/css" rel="stylesheet" />
<LINK href="AdminDefaultTheme/MasterPage.css" type="text/css" rel="stylesheet" />
<LINK href="AdminDefaultTheme/Guide.css" type="text/css" rel="stylesheet" />
<SCRIPT language="javascript" src="JavaScript/jquery.js" type="text/javascript"></SCRIPT>
<SCRIPT language="javascript" src="JavaScript/AdminIndex.js" type="text/javascript"></SCRIPT>
<SCRIPT language="javascript" src="JavaScript/FrameTab.js" type="text/javascript"></SCRIPT>
<script language="javascript" src="../Scripts/Admin.js" type="text/javascript"></script>
</head>
<body id="Indexbody" onLoad="Onload();">
<script type="text/JavaScript">
function Show(ID){
    var obj;
    obj=document.getElementById('PopMenu_'+ID);
    obj.style.visibility="visible";
}
function Hide(ID){
    var obj;
    obj=document.getElementById('PopMenu_'+ID);
    obj.style.visibility="hidden";
}
function HideOthers(ID){
    var divs;
    if(document.all)
    {
        divs = document.all.tags('DIV');
    }
    else
    {
        divs = document.getElementsByTagName("DIV");
    }
    for(var i = 0 ;i < divs.length;i++)
    {
        if(divs[i].ID != 'PopMenu_'+ID && divs[i].ID.indexOf('PopMenu_')>=0)
        {
            divs[i].style.visibility="hidden";
        }
    }
}
function Onload() {
    var width = document.body.clientWidth - 207;
    var lHeight = document.body.clientHeight - 78;
    var rHeight = lHeight - (jQuery("#FrameTabs").height() || 0);
    document.getElementById("main_right").style.width = width > 0 ? width : 0;
    document.getElementById("main_right").style.height = rHeight > 0 ? rHeight : 0;
    document.getElementById("left").style.height = lHeight > 0 ? lHeight : 0;
    jQuery("#FrameTabs").width(width);
    if (CheckFramesScroll) {
        CheckFramesScroll();
    }
}
window.onresize = Onload;
function InitSideBarState() {
    var existentSideBarCookie = getCookie("SideBarCookie");
    var SideBarKey = document.getElementById("left").src.substring(document.getElementById("left").src.lastIndexOf('/') + 1, document.getElementById("left").src.lastIndexOf('.'));
    if (existentSideBarCookie.length != 0 && SideBarKey.length != 0 && existentSideBarCookie.indexOf(SideBarKey) != -1) {
        var arrKV = existentSideBarCookie.split("&");
        for (var v in arrKV) {
            if (arrKV[v].indexOf(SideBarKey) != -1) {
                var currentValue = arrKV[v].split("=");
                ChangeSideBarState(currentValue[1]);
            }
        }
    }
    else {
        var obj = document.getElementById("switchPoint");
        obj.alt = "关闭左栏";
        obj.src = "AdminDefaultTheme/Images/butClose.gif";
        document.getElementById("frmTitle").style.display = "block";
        Onload();
    }
}
function ChangeSideBarState(temp) {
    var obj = document.getElementById("switchPoint");
    if (temp == "none") {
        obj.alt = "打开左栏";
        obj.src = "AdminDefaultTheme/Images/butOpen.gif";
        document.getElementById("frmTitle").style.display = "none";
        var width, height;
        width = document.body.clientWidth - 12;
        height = document.body.clientHeight - 70;
        document.getElementById("main_right").style.height = height;
        document.getElementById("main_right").style.width = width;
        document.getElementById("FrameTabs").style.width = width;
        if (CheckFramesScroll) {
            CheckFramesScroll();
        }
    }
    else {
        obj.alt = "关闭左栏";
        obj.src = "AdminDefaultTheme/Images/butClose.gif";
        document.getElementById("frmTitle").style.display = "block";
        Onload();
    }

}
</script>
<table border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td colspan="3"><div id="content">
        <ul id="ChannelMenuItems">
          <li id="MenuMyDeskTop" onClick="ShowHideLayer('ChannelMenu_MenuMyDeskTop')"><a href="javascript:" id="AChannelMenu_MenuMyDeskTop" onClick="ShowMain('Admin_Index_Left.Asp?ID=System','')"><span id="SpanChannelMenu_MenuMyDeskTop">系统参数管理</span></a></li>
          <li id="Primary" onClick="ShowHideLayer('ChannelMenu_Primary')"><a href="javascript:" id="AChannelMenu_Primary"><span id="SpanChannelMenu_Primary">企业主模块管理</span></a></li>
          <li id="Feedback" onClick="ShowHideLayer('ChannelMenu_Feedback')"><a href="javascript:" id="AChannelMenu_Feedback" onClick="ShowMain('Admin_Index_Left.Asp?ID=Feedback','')"><span id="SpanChannelMenu_Feedback">咨询与反馈</span></a></li>
          <li id="User" onClick="ShowHideLayer('ChannelMenu_User')"><a href="javascript:" id="AChannelMenu_User" onClick="ShowMain('Admin_Index_Left.Asp?ID=User','')"><span id="SpanChannelMenu_User">会员管理</span></a></li>
          <li id="Html" onClick="ShowHideLayer('ChannelMenu_Html')"><a href="javascript:" id="AChannelMenu_Html" onClick="ShowMain('Admin_Index_Left.Asp?ID=Html','')"><span id="SpanChannelMenu_Html">静态页面</span></a></li>
          <li id="Count" onClick="ShowHideLayer('ChannelMenu_Count')"><a href="javascript:" id="AChannelMenu_Count" onClick="ShowMain('Admin_Index_Left.Asp?ID=Count','')"><span id="SpanChannelMenu_Count">流量统计</span></a></li>
          <li id="SearchEngine" onClick="ShowHideLayer('ChannelMenu_SearchEngine')"><a href="javascript:" id="AChannelMenu_SearchEngine" onClick="ShowMain('Admin_Index_Left.Asp?ID=SearchEngine','')"><span id="SpanChannelMenu_SearchEngine">网站推广</span></a></li>
        </ul>
        <div id="SubMenu">
          <div id="ChannelMenu_MenuMyDeskTop" style="width: 100%;">
            <ul>
              <li>当前用户：admin(122.226.222.50)</li>
              <li onMouseOver="Show('ShowMenuMyDeskTop');HideOthers('ShowMenuMyDeskTop');" onMouseOut="Hide('ShowMenuMyDeskTop')"><a href="javascript:ShowMain('Admin_Index_Left.Asp?ID=System','SetSite.Asp')">参数设置</a>
                <div id="PopMenu_ShowMenuMyDeskTop" onMouseOver="Show('ShowMenuMyDeskTop')" onMouseOut="Hide('ShowMenuMyDeskTop')" class="SubMenuDiv" onClick="Hide('ShowMenuMyDeskTop')">
                  <dl>
                    <dd><span><a href="javascript:ShowMain('Admin_Index_Left.Asp?ID=System','SetSite.Asp')">网站主参数设置</a></span>
                    <span><a href="javascript:ShowMain('Admin_Index_Left.Asp?ID=System','SetConst.Asp')">系统高级参数设置</a></span>
                    <span><a href="javascript:ShowMain('Admin_Index_Left.Asp?ID=System','NavigationEdit.Asp?Result=Add')">导航栏添加</a></span>
                    <span><a href="javascript:ShowMain('Admin_Index_Left.Asp?ID=System','NavigationList.Asp')">导航栏管理</a></span>
                    <span><a href="javascript:ShowMain('Admin_Index_Left.Asp?ID=System','FriendLinkEdit.Asp?Result=Add')">友情链接添加</a></span>
                    <span><a href="javascript:ShowMain('Admin_Index_Left.Asp?ID=System','FriendLinkList.Asp')">友情链接管理</a></span>
                    <span><a href="javascript:ShowMain('Admin_Index_Left.Asp?ID=System','SetKey.Asp')">站内链接管理</a></span>
                    <span><a href="javascript:ShowMain('Admin_Index_Left.Asp?ID=System','LinkEdit.Asp?Result=Add')">站内链接添加</a></span>
                    <span><a href="javascript:ShowMain('Admin_Index_Left.Asp?ID=System','eWebEditor/Admin/Style.Asp')">在线编辑器管理</a></span>
                    <span><a href="javascript:ShowMain('Admin_Index_Left.Asp?ID=System','eWebEditor/Admin/Upload.Asp')">已上传图片管理</a></span>
                    <span><a href="javascript:ShowMain('Admin_Index_Left.Asp?ID=System','Google.Asp')">生成谷歌SiteMap</a></span>
                    <span><a href="javascript:ShowMain('Admin_Index_Left.Asp?ID=System','Baidu.Asp')">生成百度XML</a></span>
                    <span><a href="javascript:ShowMain('Admin_Index_Left.Asp?ID=System','UserMessage.Asp')">客户即时咨询管理</a></span>
                    <span><a href="javascript:ShowMain('Admin_Index_Left.Asp?ID=System','Admin_Cache.Asp')">清除系统缓存</a></span>
                    
                    <span><a href="javascript:ShowMain('Admin_Index_Left.Asp?ID=System','ChinaQJ_Data.Asp?Action=DataBackup')">备份系统数据库</a></span>
                    <span><a href="javascript:ShowMain('Admin_Index_Left.Asp?ID=System','ChinaQJ_Data.Asp?Action=DataCompact')">压缩、修复系统数据库</a></span>
                    
                    </dd>
                  </dl>
                  <iframe id="Iframe_ShowMenuMyDeskTop" width="100%" frameborder="0" height="400px" style="position: absolute; top: 0px; z-index: -1; border-style: none;"></iframe>
                </div>
              </li>
              <li onMouseOver="Show('ShowMenuMultiLanguage');HideOthers('ShowMenuMultiLanguage');" onMouseOut="Hide('ShowMenuMultiLanguage')"><a href="javascript:ShowMain('Admin_Index_Left.Asp?ID=Multilingual','ChinaQJ_Multi_Language.Asp')">多国语言管理</a>
                <div id="PopMenu_ShowMenuMultiLanguage" onMouseOver="Show('ShowMenuMultiLanguage')" onMouseOut="Hide('ShowMenuMultiLanguage')" class="SubMenuDiv" onClick="Hide('ShowMenuMultiLanguage')">
                  <dl>
                    <dd><span><a href="javascript:ShowMain('Admin_Index_Left.Asp?ID=Multilingual','ChinaQJ_Multi_Language.Asp')">多国语言模块管理</a></span>
                    <span><a href="javascript:ShowMain('Admin_Index_Left.Asp?ID=Multilingual','ChinaQJ_Multi_Language_Edit.Asp?Result=Add')">添加新语言模块</a></span>
                    <span><a href="javascript:ShowMain('Admin_Index_Left.Asp?ID=Multilingual','Language.Asp')">系统语言包管理</a></span></dd>
                  </dl>
                  <iframe id="Iframe_ShowMenuMultiLanguage" width="100%" frameborder="0" height="75px" style="position: absolute; top: 0px; z-index: -1; border-style: none;"></iframe>
                </div>
              </li>
              <li onMouseOver="Show('ShowMenuPlug');HideOthers('ShowMenuPlug');" onMouseOut="Hide('ShowMenuPlug')"><a href="javascript:ShowMain('Admin_Index_Left.Asp?ID=Plug','Admin_Slide.asp')">高级功能设置</a>
                <div id="PopMenu_ShowMenuPlug" onMouseOver="Show('ShowMenuPlug')" onMouseOut="Hide('ShowMenuPlug')" class="SubMenuDiv" onClick="Hide('ShowMenuPlug')">
                  <dl>
                    <dd>
                    <span><a href="javascript:ShowMain('Admin_Index_Left.Asp?ID=Plug','Admin_Slide.asp')">幻灯片参数及发布</a></span>
                    <span><a href="javascript:ShowMain('Admin_Index_Left.Asp?ID=Plug','Admin_SlideEdit.asp?ShowType=Slide')">Flash幻灯片管理</a></span>
                    <span><a href="javascript:ShowMain('Admin_Index_Left.Asp?ID=Plug','Admin_Search.asp')">用户搜索关键词</a></span>
                    <span><a href="javascript:ShowMain('Admin_Index_Left.Asp?ID=Plug','Admin_EMail.asp')">邮件订阅管理</a></span>
                    <span><a href="javascript:ShowMain('Admin_Index_Left.Asp?ID=Plug','Admin_EMailPub.asp')">用户邮件群发</a></span>
                    <span><a href="javascript:ShowMain('Admin_Index_Left.Asp?ID=Plug','Album.Asp')">企业Flash相册</a></span>
                    <span><a href="javascript:ShowMain('Admin_Index_Left.Asp?ID=Plug','Admin_SubSidiaryList.asp')">多子公司管理</a></span>
                    <span><a href="javascript:ShowMain('Admin_Index_Left.Asp?ID=Plug','Admin_SubSidiaryEdit.asp?Result=Add')">添加子公司资料</a></span>
                    <span><a href="javascript:ShowMain('Admin_Index_Left.Asp?ID=Plug','Admin_Vote.asp')">调查投票管理</a></span>
                    <span><a href="javascript:ShowMain('Admin_Index_Left.Asp?ID=Plug','Admin_Vote.asp?Action=Add')">添加调查投票</a></span>
                    <span><a href="javascript:ShowMain('Admin_Index_Left.Asp?ID=Plug','ChinaQJ_NetWorkList.Asp')">营销网络管理</a></span>
                    <span><a href="javascript:ShowMain('Admin_Index_Left.Asp?ID=Plug','ChinaQJ_NetWorkEdit.Asp?Result=Add')">添加网络管理</a></span>
                    <span><a href="javascript:ShowMain('Admin_Index_Left.Asp?ID=Plug','ChinaQJ_Form_Diy.Asp')">自定义表单管理</a></span>
                    <span><a href="javascript:ShowMain('Admin_Index_Left.Asp?ID=Plug','ChinaQJ_Form_Diy.Asp?Action=FormAdd')">添加自定义表单</a></span>
                    <span><a href="javascript:ShowMain('Admin_Index_Left.Asp?ID=Plug','KefuList.Asp')">悬浮在线客服管理</a></span>
                    <span><a href="javascript:ShowMain('Admin_Index_Left.Asp?ID=Plug','KefuEdit.Asp?Result=Add')">添加新客服</a></span></dd>
                  </dl>
                  <iframe id="Iframe_ShowMenuPlug" width="100%" frameborder="0" height="375px" style="position: absolute; top: 0px; z-index: -1; border-style: none;"></iframe>
                </div>
              </li>
              <li onMouseOver="Show('ShowMenuDiyForm');HideOthers('ShowMenuDiyForm');" onMouseOut="Hide('ShowMenuDiyForm')"><a href="javascript:ShowMain('Admin_Index_Left.Asp?ID=DiyForm','UserRegister.Asp')">自定义表单必填项</a>
                <div id="PopMenu_ShowMenuDiyForm" onMouseOver="Show('ShowMenuDiyForm')" onMouseOut="Hide('ShowMenuDiyForm')" class="SubMenuDiv" onClick="Hide('ShowMenuDiyForm')">
                  <dl>
                    <dd><span><a href="javascript:ShowMain('Admin_Index_Left.Asp?ID=DiyForm','UserRegister.Asp')">新用户注册表单参数</a></span>
                    <span><a href="javascript:ShowMain('Admin_Index_Left.Asp?ID=DiyForm','UserCart.Asp')">购物车表单参数</a></span>
                    <span><a href="javascript:ShowMain('Admin_Index_Left.Asp?ID=DiyForm','Recruitment.Asp')">人才招聘参数</a></span>
                    <span><a href="javascript:ShowMain('Admin_Index_Left.Asp?ID=DiyForm','MessageForm.Asp')">用户留言、咨询参数</a></span></dd>
                  </dl>
                  <iframe id="Iframe_ShowMenuDiyForm" width="100%" frameborder="0" height="100px" style="position: absolute; top: 0px; z-index: -1; border-style: none;"></iframe>
                </div>
              </li>
            </ul>
          </div>
          <div id="ChannelMenu_Primary" style="width: 100%; display: none;">
            <ul>
              <li onMouseOver="Show('ShowMenuAbout');HideOthers('ShowMenuAbout');" onMouseOut="Hide('ShowMenuAbout')"><a href="javascript:ShowMain('Admin_Index_Left.Asp?ID=CorporateInformation','AboutList.Asp')">企业信息</a>
                <div id="PopMenu_ShowMenuAbout" onMouseOver="Show('ShowMenuAbout')" onMouseOut="Hide('ShowMenuAbout')" class="SubMenuDiv" onClick="Hide('ShowMenuAbout')">
                  <dl>
                    <dd><span><a href="javascript:ShowMain('Admin_Index_Left.Asp?ID=CorporateInformation','AboutList.Asp')">企业信息列表</a></span>
                    <span><a href="javascript:ShowMain('Admin_Index_Left.Asp?ID=CorporateInformation','AboutEdit.Asp?Result=Add')">添加企业信息</a></span></dd>
                  </dl>
                  <iframe id="Iframe_ShowMenuAbout" width="100%" frameborder="0" height="50px" style="position: absolute; top: 0px; z-index: -1; border-style: none;"></iframe>
                </div>
              </li>
              <li onMouseOver="Show('ShowMenuNews');HideOthers('ShowMenuNews');" onMouseOut="Hide('ShowMenuNews')"><a href="javascript:ShowMain('Admin_Index_Left.Asp?ID=New','NewsList.Asp')">新闻资讯</a>
                <div id="PopMenu_ShowMenuNews" onMouseOver="Show('ShowMenuNews')" onMouseOut="Hide('ShowMenuNews')" class="SubMenuDiv" onClick="Hide('ShowMenuNews')">
                  <dl>
                    <dd><span><a href="javascript:ShowMain('Admin_Index_Left.Asp?ID=New','NewsSort.Asp?Action=Add&ParentID=0')">新闻类别管理</a></span>
                    <span><a href="javascript:ShowMain('Admin_Index_Left.Asp?ID=New','NewsList.Asp')">新闻列表管理</a></span>
                    <span><a href="javascript:ShowMain('Admin_Index_Left.Asp?ID=New','NewsEdit.Asp?Result=Add')">添加新闻</a></span></dd>
                  </dl>
                  <iframe id="Iframe_ShowMenuNews" width="100%" frameborder="0" height="75px" style="position: absolute; top: 0px; z-index: -1; border-style: none;"></iframe>
                </div>
              </li>
              <li onMouseOver="Show('ShowMenuProducts');HideOthers('ShowMenuProducts');" onMouseOut="Hide('ShowMenuProducts')"><a href="javascript:ShowMain('Admin_Index_Left.Asp?ID=Product','ProductList.Asp')">公司产品</a>
                <div id="PopMenu_ShowMenuProducts" onMouseOver="Show('ShowMenuProducts')" onMouseOut="Hide('ShowMenuProducts')" class="SubMenuDiv" onClick="Hide('ShowMenuProducts')">
                  <dl>
                    <dd><span><a href="javascript:ShowMain('Admin_Index_Left.Asp?ID=Product','ProductSort.Asp?Action=Add&ParentID=0')">产品类别管理</a></span>
                    <span><a href="javascript:ShowMain('Admin_Index_Left.Asp?ID=Product','ProductList.Asp')">产品列表管理</a></span>
                    <span><a href="javascript:ShowMain('Admin_Index_Left.Asp?ID=Product','ProductEdit.Asp?Result=Add')">添加产品信息</a></span>
                    <span><a href="javascript:ShowMain('Admin_Index_Left.Asp?ID=Product','PropertiesList.Asp')">产品属性管理</a></span>
                    <span><a href="javascript:ShowMain('Admin_Index_Left.Asp?ID=Product','PropertiesEdit.Asp?Result=Add')">添加产品属性</a></span></dd>
                  </dl>
                  <iframe id="Iframe_ShowMenuProducts" width="100%" frameborder="0" height="125px" style="position: absolute; top: 0px; z-index: -1; border-style: none;"></iframe>
                </div>
              </li>
              <li onMouseOver="Show('ShowMenuDownLoad');HideOthers('ShowMenuDownLoad');" onMouseOut="Hide('ShowMenuDownLoad')"><a href="javascript:ShowMain('Admin_Index_Left.Asp?ID=Download','DownList.Asp')">资料下载</a>
                <div id="PopMenu_ShowMenuDownLoad" onMouseOver="Show('ShowMenuDownLoad')" onMouseOut="Hide('ShowMenuDownLoad')" class="SubMenuDiv" onClick="Hide('ShowMenuDownLoad')">
                  <dl>
                    <dd><span><a href="javascript:ShowMain('Admin_Index_Left.Asp?ID=Download','DownSort.Asp?Action=Add&ParentID=0')">下载类别管理</a></span>
                    <span><a href="javascript:ShowMain('Admin_Index_Left.Asp?ID=Download','DownList.Asp')">下载列表管理</a></span>
                    <span><a href="javascript:ShowMain('Admin_Index_Left.Asp?ID=Download','DownEdit.Asp?Result=Add')">添加下载信息</a></span></dd>
                  </dl>
                  <iframe id="Iframe_ShowMenuDownLoad" width="100%" frameborder="0" height="75px" style="position: absolute; top: 0px; z-index: -1; border-style: none;"></iframe>
                </div>
              </li>
              <li onMouseOver="Show('ShowMenuImageCase');HideOthers('ShowMenuImageCase');" onMouseOut="Hide('ShowMenuImageCase')"><a href="javascript:ShowMain('Admin_Index_Left.Asp?ID=Case','ImageList.Asp')">客户案例</a>
                <div id="PopMenu_ShowMenuImageCase" onMouseOver="Show('ShowMenuImageCase')" onMouseOut="Hide('ShowMenuImageCase')" class="SubMenuDiv" onClick="Hide('ShowMenuImageCase')">
                  <dl>
                    <dd><span><a href="javascript:ShowMain('Admin_Index_Left.Asp?ID=Case','ImageSort.Asp?Action=Add&ParentID=0')">案例类别管理</a></span>
                    <span><a href="javascript:ShowMain('Admin_Index_Left.Asp?ID=Case','ImageList.Asp')">案例列表管理</a></span>
                    <span><a href="javascript:ShowMain('Admin_Index_Left.Asp?ID=Case','ImageEdit.Asp?Result=Add')">添加案例信息</a></span></dd>
                  </dl>
                  <iframe id="Iframe_ShowMenuImageCase" width="100%" frameborder="0" height="75px" style="position: absolute; top: 0px; z-index: -1; border-style: none;"></iframe>
                </div>
              </li>
              <li onMouseOver="Show('ShowMenuOthers');HideOthers('ShowMenuOthers');" onMouseOut="Hide('ShowMenuOthers')"><a href="javascript:ShowMain('Admin_Index_Left.Asp?ID=Other','OthersList.Asp')">其他信息</a>
                <div id="PopMenu_ShowMenuOthers" onMouseOver="Show('ShowMenuOthers')" onMouseOut="Hide('ShowMenuOthers')" class="SubMenuDiv" onClick="Hide('ShowMenuOthers')">
                  <dl>
                    <dd><span><a href="javascript:ShowMain('Admin_Index_Left.Asp?ID=Other','OthersSort.Asp?Action=Add&ParentID=0')">信息类别管理</a></span>
                    <span><a href="javascript:ShowMain('Admin_Index_Left.Asp?ID=Other','OthersList.Asp')">信息列表管理</a></span>
                    <span><a href="javascript:ShowMain('Admin_Index_Left.Asp?ID=Other','OthersEdit.Asp?Result=Add')">添加信息</a></span></dd>
                  </dl>
                  <iframe id="Iframe_ShowMenuOthers" width="100%" frameborder="0" height="75px" style="position: absolute; top: 0px; z-index: -1; border-style: none;"></iframe>
                </div>
              </li>
              <li onMouseOver="Show('ShowMenuMagazine');HideOthers('ShowMenuMagazine');" onMouseOut="Hide('ShowMenuMagazine')"><a href="javascript:ShowMain('Admin_Index_Left.Asp?ID=Magazine','MagazineList.Asp')">电子杂志</a>
                <div id="PopMenu_ShowMenuMagazine" onMouseOver="Show('ShowMenuMagazine')" onMouseOut="Hide('ShowMenuMagazine')" class="SubMenuDiv" onClick="Hide('ShowMenuMagazine')">
                  <dl>
                    <dd><span><a href="javascript:ShowMain('Admin_Index_Left.Asp?ID=Magazine','MagazineSort.Asp?Action=Add&ParentID=0')">电子杂志类别管理</a></span>
                    <span><a href="javascript:ShowMain('Admin_Index_Left.Asp?ID=Magazine','MagazineList.Asp')">电子杂志列表</a></span>
                    <span><a href="javascript:ShowMain('Admin_Index_Left.Asp?ID=Magazine','MagazineEdit.Asp?Result=Add')">添加电子杂志</a></span></dd>
                    <span><a href="javascript:ShowMain('Admin_Index_Left.Asp?ID=Magazine','MagazineMusic.Asp')">电子杂志背景音乐设置</a></span></dd>
                    <span><a href="javascript:ShowMain('Admin_Index_Left.Asp?ID=Magazine','MagazineSetting.Asp')">电子杂志参数设置</a></span></dd>
                  </dl>
                  <iframe id="Iframe_ShowMenuMagazine" width="100%" frameborder="0" height="75px" style="position: absolute; top: 0px; z-index: -1; border-style: none;"></iframe>
                </div>
              </li>
              <li onMouseOver="Show('ShowMenuVideo');HideOthers('ShowMenuVideo');" onMouseOut="Hide('ShowMenuVideo')"><a href="javascript:ShowMain('Admin_Index_Left.Asp?ID=Video','VideoList.Asp')">企业视频</a>
                <div id="PopMenu_ShowMenuVideo" onMouseOver="Show('ShowMenuVideo')" onMouseOut="Hide('ShowMenuVideo')" class="SubMenuDiv" onClick="Hide('ShowMenuVideo')">
                  <dl>
                    <dd><span><a href="javascript:ShowMain('Admin_Index_Left.Asp?ID=Video','VideoSort.Asp?Action=Add&ParentID=0')">视频类别管理</a></span>
                    <span><a href="javascript:ShowMain('Admin_Index_Left.Asp?ID=Video','VideoList.Asp')">视频列表管理</a></span>
                    <span><a href="javascript:ShowMain('Admin_Index_Left.Asp?ID=Video','VideoEdit.Asp?Result=Add')">添加视频信息</a></span></dd>
                  </dl>
                  <iframe id="Iframe_ShowMenuVideo" width="100%" frameborder="0" height="75px" style="position: absolute; top: 0px; z-index: -1; border-style: none;"></iframe>
                </div>
              </li>
              <li onMouseOver="Show('ShowMenuJobs');HideOthers('ShowMenuJobs');" onMouseOut="Hide('ShowMenuJobs')"><a href="javascript:ShowMain('Admin_Index_Left.Asp?ID=Talent','JobsList.Asp')">人才招聘</a>
                <div id="PopMenu_ShowMenuJobs" onMouseOver="Show('ShowMenuJobs')" onMouseOut="Hide('ShowMenuJobs')" class="SubMenuDiv" onClick="Hide('ShowMenuJobs')">
                  <dl>
                    <dd><span><a href="javascript:ShowMain('Admin_Index_Left.Asp?ID=Talent','JobsList.Asp')">招聘列表管理</a></span>
                    <span><a href="javascript:ShowMain('Admin_Index_Left.Asp?ID=Talent','JobsEdit.Asp?Result=Add')">添加招聘信息</a></span></dd>
                  </dl>
                  <iframe id="Iframe_ShowMenuJobs" width="100%" frameborder="0" height="50px" style="position: absolute; top: 0px; z-index: -1; border-style: none;"></iframe>
                </div>
              </li>
            </ul>
          </div>
          <div id="ChannelMenu_Feedback" style="width: 100%; display: none;">
            <ul>
              <li><a href="javascript:ShowMain('','MessageList.Asp')">留言信息管理</a></li>
              <li><a href="javascript:ShowMain('','OrderList.Asp')">订单信息管理</a></li>
              <li><a href="javascript:ShowMain('','TalentsList.Asp')">人才信息管理</a></li>
            </ul>
          </div>
          <div id="ChannelMenu_User" style="width: 100%; display: none;">
            <ul>
              <li><a href="javascript:ShowMain('','AdminList.Asp')">网站管理员管理</a></li>
              <li><a href="javascript:ShowMain('','AdminEdit.Asp?Result=Add')">添加网站管理员</a></li>
              <li><a href="javascript:ShowMain('','MemList.Asp')">前台会员资料</a></li>
              <li><a href="javascript:ShowMain('','MemGroup.Asp')">会员组别管理</a></li>
              <li><a href="javascript:ShowMain('','MemGroup.Asp?Result=Add')">添加会员组别</a></li>
              <li><a href="javascript:ShowMain('','ManageLog.Asp')">后台登录日志</a></li>
            </ul>
          </div>
          <div id="ChannelMenu_Html" style="width: 100%; display: none;">
            <ul>
              <li><a href="javascript:ShowMain('','Admin_Html_Need.Asp')" onClick="return Clearhtml()">按需生成静态页面</a></li>
              <li><a href="javascript:ShowMain('','Admin_Html.Asp')" onClick="return ClearhtmlAll()">生成全站静态页面</a></li>
            </ul>
          </div>
          <div id="ChannelMenu_Count" style="width: 100%; display: none;">
            <ul>
              <li><a href="Admin_Count.Asp" target="main_right">统计概况</a></li>
              <li><a href="Admin_Count.Asp?Action=all" target="main_right">详细统计数据</a></li>
              <li><a href="Admin_Count.Asp?Action=chour" target="main_right">最近24小时统计</a></li>
              <li><a href="Admin_Count.Asp?Action=cday" target="main_right">今日统计数据</a></li>
              <li><a href="Admin_Count.Asp?Action=cweek" target="main_right">周统计数据</a></li>
              <li><a href="Admin_Count.Asp?Action=cmonth" target="main_right">月统计数据</a></li>
              <li><a href="Admin_Count.Asp?Action=ccome" target="main_right">用户来源统计</a></li>
              <li><a href="Admin_Count.Asp?Action=cpage" target="main_right">用户访问页面</a></li>
              <li><a href="Admin_Count.Asp?Action=cip" target="main_right">来自区域统计</a></li>
            </ul>
          </div>
          <div id="ChannelMenu_SearchEngine" style="width: 100%; display: none;">
            <ul>
              <li onMouseOver="Show('ShowMenuDirectoryLogin');HideOthers('ShowMenuDirectoryLogin');" onMouseOut="Hide('ShowMenuDirectoryLogin')"><a href="javascript:ShowMain('Admin_Index_Left.Asp?ID=SearchEngine','SysCome.asp')">搜索引擎登录</a>
                <div id="PopMenu_ShowMenuDirectoryLogin" onMouseOver="Show('ShowMenuDirectoryLogin')" onMouseOut="Hide('ShowMenuDirectoryLogin')" class="SubMenuDiv" onClick="Hide('ShowMenuDirectoryLogin')">
                  <dl>
                    <dd><span><a href="http://www.baidu.com/search/url_submit.html" target="_blank">百度登录入口</a></span>
                    <span><a href="http://www.google.com/intl/zh-CN/add_url.html" target="_blank">Google登录入口</a></span>
                    <span><a href="http://search.help.cn.yahoo.com/h4_4.html" target="_blank">Yahoo登录入口</a></span>
                    <span><a href="http://search.msn.com/docs/submit.Asp" target="_blank">Live登录入口</a></span>
                    <span><a href="http://www.dmoz.org/World/Chinese_Simplified/" target="_blank">Dmoz登录入口</a></span>
                    <span><a href="http://www.alexa.com/site/help/webmasters" target="_blank">Alexa登录入口</a></span>
                    <span><a href="http://ads.zhongsou.com/register/page.jsp" target="_blank">中搜登录入口</a></span>
                    <span><a href="http://iask.com/guest/add_url.php" target="_blank">爱问登录入口</a></span>
                    <span><a href="http://tellbot.youdao.com/report" target="_blank">有道登录入口</a></span>
                    <span><a href="http://cn.bing.com/docs/submit.Asp" target="_blank">必应登录入口</a></span></dd>
                  </dl>
                  <iframe id="Iframe_ShowMenuDirectoryLogin" width="100%" frameborder="0" height="250px" style="position: absolute; top: 0px; z-index: -1; border-style: none;"></iframe>
                </div>
              </li>
              <li onMouseOver="Show('ShowMenuInformationRelease');HideOthers('ShowMenuInformationRelease');" onMouseOut="Hide('ShowMenuInformationRelease')"><a href="javascript:ShowMain('Admin_Index_Left.Asp?ID=SearchEngine2','SysCome.asp')">企业信息发布</a>
                <div id="PopMenu_ShowMenuInformationRelease" onMouseOver="Show('ShowMenuInformationRelease')" onMouseOut="Hide('ShowMenuInformationRelease')" class="SubMenuDiv" onClick="Hide('ShowMenuInformationRelease')">
                  <dl>
                    <dd><span><a href="http://www.alibaba.com" target="_blank">阿里巴巴</a></span>
                    <span><a href="http://www.hc360.com" target="_blank">Google慧聪网</a></span>
                    <span><a href="http://www.yp.net.cn" target="_blank">中国黄页在线</a></span>
                    <span><a href="http://yp.sina.net" target="_blank">新浪企业黄页</a></span>
                    <span><a href="http://www.made-in-china.com" target="_blank">Made-in-China</a></span></dd>
                  </dl>
                  <iframe id="Iframe_ShowMenuInformationRelease" width="100%" frameborder="0" height="125px" style="position: absolute; top: 0px; z-index: -1; border-style: none;"></iframe>
                </div>
              </li>
              <li onMouseOver="Show('ShowMenuClassifieds');HideOthers('ShowMenuClassifieds');" onMouseOut="Hide('ShowMenuClassifieds')"><a href="javascript:ShowMain('Admin_Index_Left.Asp?ID=SearchEngine3','SysCome.asp')">分类信息发布</a>
                <div id="PopMenu_ShowMenuClassifieds" onMouseOver="Show('ShowMenuClassifieds')" onMouseOut="Hide('ShowMenuClassifieds')" class="SubMenuDiv" onClick="Hide('ShowMenuClassifieds')">
                  <dl>
                    <dd><span><a href="http://www.58.com" target="_blank">58同城分类</a></span>
                    <span><a href="http://www.koubei.com" target="_blank">Yahoo口碑</a></span>
                    <span><a href="http://www.ganji.com" target="_blank">赶集网</a></span>
                    <span><a href="http://www.bendibao.com" target="_blank">本地宝</a></span>
                    <span><a href="http://www.baixin.com" target="_blank">百姓网</a></span>
                    <span><a href="http://www.fenlei168.com" target="_blank">中国分类信息网</a></span></dd>
                  </dl>
                  <iframe id="Iframe_ShowMenuClassifieds" width="100%" frameborder="0" height="150px" style="position: absolute; top: 0px; z-index: -1; border-style: none;"></iframe>
                </div>
              </li>
            </ul>
          </div>
        </div>
        <div id="Announce"><a href="../" target="_blank"><img src="AdminDefaultTheme/Images/Home.gif" width="37" height="14" border="0" alt="前台首页" /></a> <a href="http://www.chinaqj.com/" target="_blank"><img src="AdminDefaultTheme/Images/Help.gif" width="37" height="14" border="0" alt="ChinaQJ 企业网站管理系统" /></a> <a href="javascript:AdminOut()"><img src="AdminDefaultTheme/Images/Exit.gif" width="37" height="14" border="0" alt="安全退出" /></a></div>
      </div></td>
  </tr>
  <tr style="vertical-align: top;">
    <td id="frmTitle"><iframe tabid="1" frameborder="0" id="left" name="left" scrolling="auto" src="Admin_Index_Left.Asp" style="width: 195px; height: 800px; visibility: inherit; z-index: 2;"></iframe></td>
    <td onClick="switchSysBar();" class="but"><img id="switchPoint" src="AdminDefaultTheme/images/butClose.gif" alt="关闭左栏" style="border: 0px; width: 12px;" /></td>
    <td><div id="FrameTabs" style="overflow: hidden;"></div>
      <div id="main_right_frame">
        <iframe tabid="1" frameborder="0" id="main_right" name="main_right" scrolling="yes" src="SysCome.Asp" onload="SetTabTitle(this)" style="width: 1280px; height: 800px; visibility: inherit; z-index: 2; overflow-x: hidden;"></iframe>
        <div class="clearbox2" />
      </div></td>
  </tr>
</table>
</body>
</html>
<script type="text/javascript">
<!--
function Clearhtml()
{
    var bln=confirm("注意：添加、修改、删除相关数据时会自动生成、更新、删除所生成的静态文件。\n如果您没有对模板作过修改，不需要批量生成所有商品或新闻详细页面！\n如果您仅对产品、新闻、下载、电子杂志、视频、人才等分类页面作过修改，只需要生成相关分类页面。\n\n请确定是否操作？");
    return bln;
}
function ClearhtmlAll()
{
    var bln=confirm("警告：批量生成全站静态页面将耗费较多系统资源！\n请确定是否操作？");
    return bln;
}
function ClearCount()
{
    var bln=confirm("警告：是否确定清空用户统计数据！\n清空后将不能恢复！");
    return bln;
}
-->
</script>