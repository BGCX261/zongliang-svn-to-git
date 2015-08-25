<!--#include file="Inc/Conn.asp"-->
<%

burl = Request.ServerVariables("HTTP_REFERER")

If InStr(LCase(burl),  LCase(Sdcms_WebUrl))<=0 Then 
	Response.write("<script type='text/javascript'>alert('Error: \u8bf7\u52ff\u975e\u6cd5\u63d0\u4ea4!'); window.location.href='"&Sdcms_WebUrl&"'; </script>")
	Response.end
End If
If Request.Cookies("SUBMISTMSGTIME")<>"" Then 
	Dim ptm,dm
	ptm = DateAdd("n", 1, Request.Cookies("SUBMISTMSGTIME"))
	dm = DateDiff("s",ptm,now())
	If  dm <= 0 Then
		showInfomsg("\u8bf7\u4e0d\u8981\u5728\u4e00\u5206\u949f\u5185\u8fde\u7eed\u63d0\u4ea4\u0021\r\n\u4f60\u4e0a\u6b21\u63d0\u4ea4\u662f\u003a "&(60-(-dm))&" \u79d2\u524d")
	End If
End If

Dim name,comname,phone,content,burl,sql

If Request.Form("username")<>"" Then
	name = Trim(Request.Form("username"))
	If Len(name) > 24 Then showInfomsg("\u60a8\u7684\u59d3\u540d\u771f\u7684\u53eb\u003a "&name&" \u5417?")
Else
	showInfomsg("\u7528\u6237\u540d\u4e0d\u80fd\u4e3a\u7a7a\u54e6")
End If
If Request.Form("tel")<>"" Then
	phone = Trim(Request.Form("tel"))
	If Len(phone) > 21 Then showInfomsg("\u60a8\u7684\u7535\u8bdd\u771f\u7684\u662f\u003a "&phone&" \u5417?")
Else
	showInfomsg("\u60a8\u7684\u7535\u8bdd\u662f\u003f")
End If
If Request.Form("company")<>"" Then
	comname = Trim(Request.Form("company"))
	If Len(comname) > 32 Then showInfomsg("\u60a8\u516c\u53f8\u771f\u7684\u662f\u53eb\u003a "&comname&" \u5417?")
Else
	showInfomsg("\u516c\u53f8\u540d\u4e5f\u4e0d\u80fd\u4e3a\u7a7a\u54e6\u002e")
End If
If Request.Form("content")<>"" Then
	content = Trim(Request.Form("content"))
Else
	showInfomsg("\u60a8\u8981\u8bf4\u7684\u662f\u003f")
End If

Function showInfomsg(msg)
	Response.write("<script type='text/javascript'>alert('"&msg&"'); window.opener = null; window.close();</script>")
	Response.end
End Function

DbOpen

sql = "INSERT INTO sd_msg(username,company,tel,content,addip,addos,addbs,addother) VALUES('"&v(name)&"','"&v(comname)&"','"&v(phone)&"','"&v(content)&"','"&GetUserTrueIP()&"','"&GetUserOSInfo()&"','"&GetUserBrowserInfo()&"','"&Request.ServerVariables("HTTP_USER_AGENT")&"')"

set rs=conn.execute(sql)

Response.write("<script type='text/javascript'>alert('\u63d0\u4ea4\u6210\u529f!\u5ba1\u6838\u901a\u8fc7\u540e\u4f1a\u663e\u793a\u5e76\u8054\u7cfb\u60a8...'); window.location.href='http://www.ruiec.com/';</script>")

Response.Cookies("SUBMISTMSGTIME")=now()
Response.Cookies("SUBMISTMSGTIME").Expires=date+365

Response.end

%>