<!--#include file="../Include/Const.Asp" -->
<!--#include file="../Include/NoSQL.Asp" -->
<!--#include file="../Include/ConnSiteData.Asp" -->
<%
ChinaQJ_Voteid = request("Voteid")
If request("ChinaQJ_VoteStyle") = "radio" Then
	If isnull(request("voted")) Or request("voted") = Empty Then
		Response.Write "<script language=""JavaScript"">alert('"&ChinaQJLanguageTxt269&"');" & "history.back()" & "</script>"
		Response.End
	End If
	conn.execute("Update ChinaQJ_Vote set ChinaQJ_VoteCount = ChinaQJ_VoteCount + 1 where ChinaQJ_Voteid = "&request("voted"))
ElseIf request("ChinaQJ_VoteStyle")="checkbox" Then
	If request("voted").count=0 Then
		Response.Write "<script language=""JavaScript"">alert('"&ChinaQJLanguageTxt269&"');" & "history.back()" & "</script>"
		Response.End
	end if
	For i = 1 To request("voted").count
	conn.execute("Update ChinaQJ_Vote set ChinaQJ_VoteCount = ChinaQJ_VoteCount + 1 where ChinaQJ_Voteid = "&request("voted")(i))
	Next
End If
response.Redirect "VoteShow.Asp?id="&ChinaQJ_Voteid&""
%>