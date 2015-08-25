<%
dim AdminAction
AdminAction=request.QueryString("AdminAction")
select case AdminAction
  case "Out"
    call OutLogin()
  case else
    call Login()
end select
sub Login()
  if session("AdminName")="" Or session("UserName")="" Or session("AdminPurview")="" Or session("LoginSystem")<>"Succeed"  Or (EnableSiteManageCode = True And Trim(Request.Cookies("AdminLoginCode")) <> SiteManageCode) then
	 response.redirect "Admin_Login.asp"
     response.end
  end if
end sub
sub OutLogin()
  session.contents.remove "AdminName"
  session.contents.remove "UserName"
  session.contents.remove "AdminPurview"
  session.contents.remove "LoginSystem"
  session.contents.remove "VerifyCode"
  response.redirect "Admin_Login.asp"
end Sub

%>

<%

'==========================================
'	测试函数(判断是否为数字)
'	value	值
'	返回值	是数字返回原数字,否则返回0
'==========================================
Function BetaIsInt(value)
	on error resume next 
	dim str
	dim l,i 
	if isNUll(value) then 
		BetaIsInt=0 
		exit function 
	end if 
	str=cstr(value) 
	if trim(str)="" then 
		BetaIsInt=0 
		exit function 
	end if 
	l=len(str) 
	for i=1 to l 
		if mid(str,i,1)>"9" or mid(str,i,1)<"0" then 
			BetaIsInt=0 
			exit function 
		end if 
	next 
	BetaIsInt=value 
	if err.number<>0 then err.clear 
End Function



%>