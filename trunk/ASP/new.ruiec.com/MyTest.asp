<%
	
	For Each Item in Request.ServerVariables
		Response.Write("<br />" & Item & " => " & Request.ServerVariables(Item))
	Next

	
%>