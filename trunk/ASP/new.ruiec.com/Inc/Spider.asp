<!--#Include File="Conn.asp"-->
<%
Dim Spider,t0,t1,t2,i
'BaiDu
Spider="baiduspider|baiducustomer|baidu-thumbnail|baiduspider-mobile-gate|baidu-transcoder/1.0.6.0|"
'Google
Spider=Spider&"googlebot/2.1|googlebot-image/1.0|feedfetcher-google|mediapartners-google|adsbot-google|googlebot-mobile/2.1|googlefriendconnect/1.0|"
'Yahoo
Spider=Spider&"yahoo! slurp;|yahoo! slurp/3.0|yahoo! slurp china|yahoofeedseeker/2.0|yahoo-blogs|yahoo-mmcrawler|yahoo contentmatch crawler|"
'Msn
Spider=Spider&"msnbot/1.1|msnbot/2.0b|msrabot/2.0/1.0|msnbot-media/1.0|msnbot-products|msnbot-academic|msnbot-newsblogs|"
'SoSo
Spider=Spider&"sosospider|sosoblogspider|sosoimagespider|"
'YoDao
Spider=Spider&"youdaobot/1.0|yodaobot-image/1.0|yodaobot-reader/1.0|"
'SoGou
Spider=Spider&"sogou web robot|sogou web spider/3.0|sogou web spider/4.0|sogou head spider/3.0|sogou-test-spider/4.0|sogou orion spider/4.0|"
'Alexa
Spider=Spider&"ia_archiver|iaarchiver|"
'Cuil
Spider=Spider&"twiceler-0.9|"
'Qihoo
Spider=Spider&"qihoo|"
'ASK.com
Spider=Spider&"ask jeeves/teoma|"
'iask
Spider=Spider&"iaskspider/1.0|iaskspider/2.0"

t0=Split(Spider,"|")
t1=Replace(Request.ServerVariables("http_user_agent"),"+"," ")
IF Len(t1)>0 Then
	For I=0 To Ubound(t0)
		IF Instr(Lcase(t1),Lcase(t0(I)))>0 Then
			t2=t0(I)
		End IF
	Next
End IF

IF Len(t2)>0 Then
	Dim Sql
	Sql="Select title,Lastdate,hits From Sd_Spider Where title='"&t2&"'"
	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Rs.Open Sql,Conn,1,3
	IF Rs.Eof Then
		Rs.Addnew
		Rs(0)=t2
		Rs(1)=Dateadd("h",Sdcms_TimeZone,Now())
		Rs(2)=1
		Rs.Update
		Rs.Close
		Set Rs=Nothing
	Else
		Rs.Update
		Rs(1)=Dateadd("h",Sdcms_TimeZone,Now())
		IF Load_Cookies("Spider")="" Then
		Rs(2)=Rs(2)+1
		End IF
		Add_Cookies "Spider",t2
		Rs.Update
		Rs.Close
		Set Rs=Nothing
	End IF
	Closedb
End IF
%>