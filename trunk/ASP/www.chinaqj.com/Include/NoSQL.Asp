<%
Dim Fy_Post,Fy_Get,Fy_In,Fy_Inf,Fy_Xh,Fy_db,Fy_dbstr
Fy_In = "'|;|and|exec|insert|select|delete|update|*|%|chr|mid|master|truncate|char|declare"
Fy_Inf = split(Fy_In,"|")
If Request.Form<>"" Then
  For Each Fy_Post In Request.Form
    For Fy_Xh=0 To Ubound(Fy_Inf)
      If Instr(LCase(Request.Form(Fy_Post)),Fy_Inf(Fy_Xh))<>0 Then
        Response.write "<script language='JavaScript'>alert(""I'm sorry, the system detects that the data you submit to contain illegal content!"");" & "history.back()" & "</script>"
        Response.End
      End If
    Next
  Next
End If
If Request.QueryString<>"" Then
  For Each Fy_Get In Request.QueryString
    For Fy_Xh=0 To Ubound(Fy_Inf)
      If Instr(LCase(Request.QueryString(Fy_Get)),Fy_Inf(Fy_Xh))<>0 Then
        Response.write "<script language='JavaScript'>alert(""I'm sorry, the system detects that the data you submit to contain illegal content!"");" & "history.back()" & "</script>"
        Response.End
      End If
    Next
  Next
End If
%>