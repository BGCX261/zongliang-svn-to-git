<%

'==================================
'	正则匹配
'	patrn	正则
'	strng	字符串
'	返回匹配到的内容
'==================================
Function RegExpTest(patrn,strng)
	Dim regEx, Matches
	Set regEx = New RegExp
	regEx.Pattern = patrn
	regEx.IgnoreCase = True
	regEx.Global = True
	Set Matches = regEx.Execute(strng)
	RegExpTest=Matches(0)
End Function

'=====================================
'
'	获取上一页URL(转跳至当前页面的前一页URL)
'
'========================================
Function GetPrevURL()
	Dim url
		url=Request.ServerVariables("HTTP_REFERER")
	GetPrevURL=url
End Function

'=======================================
'
'	获取IP(WEB)
'
'=======================================
Function GetUserTrueIP() 
   dim strIPAddr 
   If Request.ServerVariables("HTTP_X_FORWARDED_FOR") = "" OR InStr(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), "unknown") > 0 Then  
      strIPAddr = Request.ServerVariables("REMOTE_ADDR")  
   ElseIf InStr(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), ",") > 0 Then  
      strIPAddr = Mid(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), 1, InStr(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), ",")-1)  
   ElseIf InStr(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), ";") > 0 Then  
      strIPAddr = Mid(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), 1, InStr(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), ";")-1)  
   Else  
      strIPAddr = Request.ServerVariables("HTTP_X_FORWARDED_FOR")  
   End If  
   GetUserTrueIP = Trim(Mid(strIPAddr, 1, 30))  
End Function 

'======================================================
'
'	获取客户端IP地址
'
'======================================================
Function GetIP()
	Dim ip
		ip=Request.ServerVariables("HTTP_X_FORWARDED_FOR")
	If ip="" Then ip=Request.ServerVariables("REMOTE_ADDR") End If
	GetIP=ip
End Function

'===========================================
'
'	获取客户端浏览器版本信息
'
'===========================================
Function GetUserBrowserInfo()
	Dim Agent
		Agent=LCase(Request.ServerVariables("HTTP_USER_AGENT"))
	If InStr(Agent,  "msie")>0 Then
		GetUserBrowserInfo = "Internet Explorer "&RegExpTest("([0-9.0-9]+)",RegExpTest("msie+[\s\/]([0-9.0-9]+)",Agent))
	ElseIf InStr(Agent,  "chrome")>0 Then
		GetUserBrowserInfo = "Chrome "&RegExpTest("([0-9.0-9]+)",RegExpTest("chrome+[\s\/]([0-9.0-9]+)",Agent))
	ElseIf InStr(Agent, "firefox")>0 Then
		GetUserBrowserInfo = "Firefox "&RegExpTest("([0-9.0-9]+)",RegExpTest("firefox+[\s\/]([0-9.0-9]+)",Agent))
	ElseIf InStr(Agent, "opera")>0 Then
		GetUserBrowserInfo = "Opera "&RegExpTest("([0-9.0-9]+)",RegExpTest("opera+[\s\/]([0-9.0-9]+)",Agent))
	ElseIf InStr(Agent, "safari")>0 Then
		GetUserBrowserInfo = "Safari "&RegExpTest("([0-9.0-9]+)",RegExpTest("safari+[\s\/]([0-9.0-9]+)",Agent))
	Else
		GetUserBrowserInfo = "Unknown"
	End If
End Function

'====================================================
'
'	获取操作系统信息
'
'=====================================================
Function GetUserOSInfo() 
	Dim Agent
		Agent=LCase(Request.ServerVariables("HTTP_USER_AGENT"))
	If InStr(Agent, "win")>0 Then
		If InStr(Agent, "95")>0 Then
			GetUserOSInfo = "Windows 95"
		ElseIf InStr(Agent, "4.90")>0 Then
			GetUserOSInfo = "Windows ME"
		ElseIf InStr(Agent, "98")>0 Then
			GetUserOSInfo = "Windows 98"
		ElseIf InStr(Agent, "nt 5.0")>0 Then
			GetUserOSInfo = "Windows 2000"
		ElseIf InStr(Agent, "nt 5.1")>0 Then
			GetUserOSInfo = "Windows XP"
		ElseIf InStr(Agent, "nt 6.0")>0 Then
			GetUserOSInfo = "Windows Vista"
		ElseIf InStr(Agent, "nt 6.1")>0 Then
			GetUserOSInfo = "Windows 7"
		ElseIf InStr(Agent, "32")>0 Then
			GetUserOSInfo = "Windows 32"
		ElseIf InStr(Agent, "nt")>0 Then
			GetUserOSInfo = "Windows NT"
		End If
	ElseIf InStr(Agent, "mac os")>0 Then
		GetUserOSInfo = "Mac OS"
	ElseIf InStr(Agent, "linux")>0 Then
		GetUserOSInfo = "Linux"
	ElseIf InStr(Agent, "unix")>0 Then
		GetUserOSInfo = "Unix"
	ElseIf InStr(Agent, "sun")>0 Then
		GetUserOSInfo = "SunOS"
	ElseIf InStr(Agent, "ibm")>0 Then
		GetUserOSInfo = "IBM OS/2"
	ElseIf InStr(Agent, "mac")>0 Then
		GetUserOSInfo = "Macintosh"
	ElseIf InStr(Agent, "powerpc")>0 Then
		GetUserOSInfo = "PowerPC"
	ElseIf InStr(Agent, "aix")>0 Then
		GetUserOSInfo = "AIX"
	ElseIf InStr(Agent, "hpux")>0 Then
		GetUserOSInfo = "HPUX"
	ElseIf InStr(Agent, "netbsd")>0 Then
		GetUserOSInfo = "NetBSD"
	ElseIf InStr(Agent, "bsd")>0 Then
		GetUserOSInfo = "BSD"
	ElseIf InStr(Agent, "osfl")>0 Then
		GetUserOSInfo = "OSF1"
	ElseIf InStr(Agent, "irix")>0 Then
		GetUserOSInfo = "IRIX"
	ElseIf InStr(Agent, "freebsd")>0 Then
		GetUserOSInfo = "FreeBSD"
	Else
		GetUserOSInfo = "Unknown"
	End If
End Function



%>