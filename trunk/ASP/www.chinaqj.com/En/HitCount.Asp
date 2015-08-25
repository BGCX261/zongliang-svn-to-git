<!--#include file="../Include/Const.Asp" -->
<!--#include file="../Include/ConnSiteData.Asp" -->
<!--#include file="function.Asp" -->
<!--#include file="../Include/NoSQL.Asp" -->
<%
dim rs,m_SQL
dim m_ID
m_ID = ReplaceBadChar(Request.QueryString("id"))
m_LX = ReplaceBadChar(Request.QueryString("LX"))
action = ReplaceBadChar(Request.QueryString("action"))
If action = "count" Then
	conn.Execute("update "&m_LX&" set ClickNumber = ClickNumber + 1 where ID=" & m_ID & "")
Else
	m_SQL = "select ClickNumber from "&m_LX&" where ID=" & m_ID
	Set rs = conn.Execute(m_SQL)
	response.write "document.write("&rs(0)&");"
	rs.Close
	set rs=nothing
End If
%>