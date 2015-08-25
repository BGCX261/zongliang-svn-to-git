<!--#include file="../Inc/Conn.asp"-->
<%
'============================================================
'插件名称：广告
'Website：http://www.sdcms.cn
'Author：IT平民
'Date：2008-10-28
'Update:2010-10
'============================================================
Dim ID:ID=IsNum(Request.Querystring("ID"),0)
Get_ad

Function js_b
	js_b="document.write('"
End Function

Function js_o
	js_o="');"
End Function

Sub Get_ad
	IF Sdcms_Cache Then
		IF Check_Cache("Gg"&ID) then
			Create_Cache "Gg"&ID,Get_Show_Ad
		End IF
		Echo Load_Cache("Gg"&ID)
	Else
		Echo Get_Show_Ad
	End IF
End Sub

Function Get_Show_Ad
	Dim Sdcms_Ad,Rs
	DbOpen
	Sdcms_Ad=Empty
	Set Rs=Conn.Execute("Select id,title,url,pic,ispic,ad_w,ad_h,ispass,content From Sd_Ad Where id="&id&" And followid<>0")
	IF Rs.Eof Then
		Sdcms_Ad=Sdcms_Ad&js_b&"没有找到您要的广告信息"&js_o
	Else
		IF Rs(7)=0 Then
			Sdcms_Ad=Sdcms_Ad&js_b&"广告信息未启用"&js_o&"":Died
		End IF
		Select Case Rs(4)
		Case "0"
			Sdcms_Ad=Sdcms_Ad&js_b&"<a href="""&Rs(2)&""" target=""_blank"">"&Rs(1)&"</a>"&js_o
		Case "1"
			Sdcms_Ad=Sdcms_Ad&js_b&"<a href="""&Rs(2)&""" target=""_blank""><img src="""&Rs(3)&""" width="""&Rs(5)&""" height="""&Rs(6)&""" border=""0""></a>"&js_o
		Case "2"
		Sdcms_Ad=Sdcms_Ad&js_b&"<object classid=""clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"" codebase=""http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,19,0"" width="""&Rs(5)&""" height="""&Rs(6)&""">"&js_o&vbLf
	  Sdcms_Ad=Sdcms_Ad&js_b&"<param name=""movie"" value="""&Rs(3)&""" />"&js_o&vbLf
	  Sdcms_Ad=Sdcms_Ad&js_b&"<param name=""quality"" value=""high"" />"&js_o&vbLf
	  Sdcms_Ad=Sdcms_Ad&js_b&"<embed src="""&Rs(3)&""" quality=""high"" pluginspage=""http://www.macromedia.com/go/getflashplayer"" type=""application/x-shockwave-flash"" width="""&Rs(5)&""" height="""&Rs(6)&"""></embed>"&js_o&vbLf
	Sdcms_Ad=Sdcms_Ad&js_b&"</object>"&js_o
		Case "3"
		Sdcms_Ad=Sdcms_Ad&Ad_Re(Rs(8))
		Case Else
		Sdcms_Ad=Sdcms_Ad&js_b&"广告调用错误"&js_o
		End Select
	End IF
	Get_Show_Ad=Sdcms_Ad
	Rs.Close
	Set Rs=Nothing
End Function

Function Ad_Re(t0)
	Dim t1
	IF Len(t0)=0 Then Ad_Re="":Exit Function
	t1=Replace(t0,"""","\""")
	t1=Replace(t1,"/","\/")
	t1=Replace(t1,vbcrlf,""");"&vbcrlf&"document.writeln(""")
	Ad_Re="document.writeln("""&t1&""");"
End Function
%>