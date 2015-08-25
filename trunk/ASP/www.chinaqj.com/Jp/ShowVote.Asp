<!--#include file="../Include/Const.Asp" -->
<!--#include file="../Include/NoSQL.Asp" -->
<!--#include file="../Include/ConnSiteData.Asp" -->
<%
If isnull(Request("ChinaQJ_Voteid")) Or Request("ChinaQJ_Voteid") = "" Or IsNumeric(Request("ChinaQJ_Voteid")) = False Then
	Set rs = conn.execute("select top 1 * from ChinaQJ_Vote where ChinaQJ_Voteing = 1 and ChinaQJ_VoteClass = 0 order by ChinaQJ_Voteid desc")
Else
	Set rs = conn.execute("select * from ChinaQJ_Vote where ChinaQJ_Voteid = "&request("ChinaQJ_Voteid")&" and ChinaQJ_Voteing=1")
End If
If rs.eof Then
vote = ChinaQJLanguageTxt7
response.write "document.write ('"&vote&"');"
response.End
End If
ChinaQJ_VoteTitle = rs("ChinaQJ_VoteTitle")
ChinaQJ_VoteStyle = rs("ChinaQJ_VoteStyle")
ChinaQJ_Voteid = rs("ChinaQJ_Voteid")
ChinaQJ_VoteEnd = rs("ChinaQJ_VoteEnd")
Rs.close
If cint(DateDiff("d",Date(),ChinaQJ_VoteEnd))<0 Then
	vote = ChinaQJLanguageTxt266
	response.write "document.write ('"&vote&"');"
	response.End
End If
sql="select * from ChinaQJ_Vote where ChinaQJ_VoteClass = "&ChinaQJ_Voteid
rs.open sql,conn,3,1
html="<table width=""95%"" border=""0"" cellspacing=""0"" cellpadding=""0"">"
html=html&"<form name=""form"" method=""post"" action=""vote.Asp?ChinaQJ_VoteStyle="&ChinaQJ_VoteStyle&""" target=""_blank"">"
html=html&"  <tr>"
html=html&"    <td height=""22""><strong>" & ChinaQJ_VoteTitle & "</strong></td>"
html=html&"  </tr>"
response.write "document.write ('"&html&"');"
htmlss="<input type=""hidden"" name=""Voteid"" value="&ChinaQJ_Voteid&">"
response.write "document.write ('"&htmlss&"');"
Do While Not(rs.eof)
	htmls="  <tr>"
	htmls=htmls&"    <td height=""22"" align=""left""><input type="&ChinaQJ_VoteStyle&" name=""voted"" value="&rs("ChinaQJ_Voteid")&" class=""inputnoborder""> " & rs("ChinaQJ_VoteTitle") & "</td>"
	htmls=htmls&"  </tr>"
response.write "document.write ('"&htmls&"');"
rs.movenext
Loop
html="  <tr>"
html=html&"    <td height=""22""><input type=""Submit"" name=""Submit"" value="""&ChinaQJLanguageTxt267&"""> <input type=""button"" name=""button"" onclick=window.open(""VoteShow.Asp?id=" & ChinaQJ_Voteid & """) value="""&ChinaQJLanguageTxt268&"""></td>"
html=html&"  </tr>"
html=html&"</form>"
html=html&"</table>"
response.write "document.write ('"&html&"');"
%>