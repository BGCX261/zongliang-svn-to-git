<%
'网站名称
    Dim Sdcms_WebName:Sdcms_WebName="行业展会,网络营销,网络公关,品牌策划,整合营销-中瑞传媒"
'网站域名
    Dim Sdcms_WebUrl:Sdcms_WebUrl="http://127.0.0.1"
'系统目录，根目录为："/",虚拟目录形式为："/sdcms/"
    Dim Sdcms_Root:Sdcms_Root="/"
'运行模式,0为动态默认，1为伪静态，2为静态
    Dim Sdcms_Mode:Sdcms_Mode=2
'博客模式
    Dim blogmode:blogmode=false
'生成目录，根目录为空,也可以指定为某一目录，形式为："sdcms/",必须以："/"结束
    Dim Sdcms_HtmDir:Sdcms_HtmDir=""
'时区设置,请不要随意更改
    Dim Sdcms_TimeZone:Sdcms_TimeZone=0
'是否开启管理日志
    Dim Sdcms_AdminLog:Sdcms_AdminLog=True
'是否开启缓存
    Dim Sdcms_Cache:Sdcms_Cache=False
'缓存前缀,如果有多个站点，请设置不同的值
    Dim Sdcms_Cookies:Sdcms_Cookies="7Hh3Qb4Xf1Gl"
'缓存时间，单位为秒
    Dim Sdcms_CacheDate:Sdcms_CacheDate=60
'系统文件的后缀名，建议不要改动
    Dim Sdcms_FileTxt:Sdcms_FileTxt=".html"
'系统模板目录,一般不建议手动更改
    Dim Sdcms_Skins_Root:Sdcms_Skins_Root="2009"
'系统生成文件的默认文件名，建议不要改动
    Dim Sdcms_FileName:Sdcms_FileName="{ID}"
'附件目录
    Dim Sdcms_UpfileDir:Sdcms_UpfileDir="Upfile"
'允许上传文件类型,多个请用|格开
    Dim Sdcms_UpfileType:Sdcms_UpfileType="jpe|gif|jpg|png|bmp|rar|zip|flv|swf"
'允许上传的文件最大值，单位：KB
    Dim Sdcms_upfileMaxSize:Sdcms_upfileMaxSize=200
'生成偏好设置,系统自动生成，请务随意改动
    Dim Sdcms_Create_Set:Sdcms_Create_Set="0, 1, 2"
'生成GOOGLE地图的参数
    Dim Sdcms_Create_GoogleMap:Sdcms_Create_GoogleMap=Split("20,daily,0.8",",")
'评论开关
    Dim Sdcms_Comment_Pass:Sdcms_Comment_Pass=1
'评论审核
    Dim Sdcms_Comment_IsPass:Sdcms_Comment_IsPass=1
'Html标签过滤
    Dim Sdcms_BadHtml:Sdcms_BadHtml="Table|TBODY|TR|TD|Body|Meta|iframe|SCRIPT|form|style|div|object|TEXTAREA"
'Html标签事件过滤
    Dim Sdcms_BadEvent:Sdcms_BadEvent="javascript:|Document.|onerror|onload|onmouseover"
'脏话过滤
    Dim Sdcms_BadText:Sdcms_BadText="操你妈|Fuck|TMD|NND|我操|我日|妈比"
'信息描述自动截取字符数,建议为：200-500
    Dim Sdcms_Length:Sdcms_Length=500
'数据库连接类型,True为Access，False为MSSQL
    Dim Sdcms_DataType:Sdcms_DataType=True
'Access数据库目录
    Dim Sdcms_DataFile:Sdcms_DataFile="Data"
'Access数据库名称
    Dim Sdcms_DataName:Sdcms_DataName="#%@ruie.com_2012@%#.mdb"
'MSSQL数据库IP,本地用 (local) 外地用IP 
    Dim Sdcms_SqlHost:Sdcms_SqlHost="(local)"
'MSSQL数据库名
    Dim Sdcms_SqlData:Sdcms_SqlData="ruiec2012"
'MSSQL数据库帐户
    Dim Sdcms_SqlUser:Sdcms_SqlUser="ruiec2012"
'MSSQL数据库密码
    Dim Sdcms_SqlPass:Sdcms_SqlPass="admin888"
'系统安装日期
    Dim Sdcms_CreateDate:Sdcms_CreateDate="2011-1-14 7:52:45"
%>
<!--#include file="../Skins/2009/Skins.asp"-->