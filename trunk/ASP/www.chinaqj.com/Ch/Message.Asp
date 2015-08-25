<!--#include file="../Include/Const.Asp"-->
<!--#include file="../Include/ConnSiteData.Asp"-->
<%
BContent = Trim(request("contenthide"))
BPhone = Trim(request("phonehide"))
BAddr = Trim(request("addrhide"))
BEmail = Trim(request("emailhide"))
set rs = server.createobject("adodb.recordset")
sql="select * from ChinaQJ_Biz"
rs.open sql,conn,1,3
rs.addnew
rs("BizContent") = BContent
rs("BizPhone") = BPhone
rs("BizAddr") = BAddr
rs("BizEMail") = BEmail
rs("BizDate") = now()
rs.update
rs.close
set rs = Nothing
If JMailPubDisplay = 1 Then
Call ShopSendEmail(JMailInFrom,JMailTitle&BPhone,BContent&BAddr)
End If
Function ShopSendEmail(strToEmail,strTitle,strSubject)
    On Error Resume Next
    Set jmail = Server.CreateObject("JMail.Message")
    jmail.Charset = "gb2312"
    jmail.ContentType = "text/html"
    jmail.from = JMailOutFrom
    jmail.silent = True
    jmail.Logging = True
    jmail.FromName = JMailName
    jmail.mailserverusername = JMailUser
    jmail.mailserverpassword = JMailPass
    jmail.AddRecipient strToEmail
    jmail.body = strSubject
    jmail.Subject = strTitle
    jmail.Priority = 1
    If Not jmail.Send (JMailSMTP) Then
        response.Write "错误！"
    Else
        response.Write "成功！"
    End If
    Set jmail=Nothing
End Function
%>