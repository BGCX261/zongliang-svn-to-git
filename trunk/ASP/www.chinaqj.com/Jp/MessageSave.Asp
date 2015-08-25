<!--#include file="../Include/Const.Asp"-->
<!--#include file="../Include/ConnSiteData.Asp"-->
<!--#include file="Function.Asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="shortcut icon" href="favicon.ico"/>
<%
call FormCheckdata
if DateDiff("s",session("time"),now())<Refresh then
   response.write "<script language='JavaScript'>alert('"&ChinaQJLanguageTxt145&" "&Refresh&" "&ChinaQJLanguageTxt146&"');" & "history.back()" & "</script>"
   response.end
else
   session("time")=now()
end if

dim rs,sql
dim MesName,Content,SecretFlag,mMemID,mLinkman,mSex,mCompany,mAddress,mZipCode,mTelephone,mFax,mMobile,mEmail,CheckCode
MesName=trim(request.form("MesName"))
Content=trim(request.form("Content"))
if trim(request.form("SecretFlag"))="1" then
  SecretFlag=1
else
  SecretFlag=0
end if
mMemID=request.QueryString("MemberID")
mLinkman=trim(request.form("Linkman"))
mSex=trim(request.form("Sex"))
mCompany=trim(request.form("Company"))
mAddress=trim(request.form("Address"))
mZipCode=trim(request.form("ZipCode"))
mTelephone=trim(request.form("Telephone"))
mFax=trim(request.form("Fax"))
mMobile=trim(request.form("Mobile"))
mEmail=trim(request.form("Email"))
CheckCode = Trim(request.form("CheckCode"))
dim ErrMessage,ErrMsg(9),FindErr(9),i
  ErrMsg(0)=ChinaQJLanguageTxt198
  ErrMsg(1)=ChinaQJLanguageTxt199
  ErrMsg(2)=ChinaQJLanguageTxt200
  ErrMsg(3)=ChinaQJLanguageTxt160
  ErrMsg(4)=ChinaQJLanguageTxt203
  ErrMsg(5)=ChinaQJLanguageTxt162
  ErrMsg(6)=ChinaQJLanguageTxt201
  ErrMsg(7)=ChinaQJLanguageTxt202
if len(MesName)>100 Or len(MesName)=0 then
  FindErr(0)=true
end if
if len(Content)<10 then
  FindErr(1)=true
end if
if Instr(MessageFormPurviewDis,"|4,")>0 then
if len(mLinkman)>50 Or len(mLinkman)=0 then FindErr(2)=true
elseif Instr(MessageFormPurviewDis,"|5,")>0 then
if msex="" then FindErr(2)=true
elseif Instr(MessageFormPurviewDis,"|6,")>0 then
if mCompany="" then FindErr(6)=true
elseif Instr(MessageFormPurviewDis,"|7,")>0 then
if mAddress="" then FindErr(6)=true
elseif Instr(MessageFormPurviewDis,"|8,")>0 then
if mZipCode="" then FindErr(6)=true
elseif Instr(MessageFormPurviewDis,"|9,")>0 then
if mTelephone="" then FindErr(7)=true
elseif Instr(MessageFormPurviewDis,"|10,")>0 then
if mFax="" then FindErr(7)=true
elseif Instr(MessageFormPurviewDis,"|11,")>0 then
if mMobile="" then FindErr(7)=true
elseif Instr(MessageFormPurviewDis,"|12,")>0 then
if  mEmail="" then FindErr(7)=true
end if

If CheckCode = "" Then
	FindErr(3)=true
End If
If Trim(Session("CheckCode")) = "" Then
	FindErr(4)=true
End If
If CheckCode <> Session("CheckCode") Then
	FindErr(5)=true
End If
for i = 0 to UBound(FindErr)
  if FindErr(i)=true then
    ErrMessage=ErrMessage+ErrMsg(i)+"\n"
  end if
next
if not (ErrMessage="" Or isnull(ErrMessage)) then
  WriteMsg(ErrMessage)
  response.end
end if
set rs = server.createobject("adodb.recordset")
sql="select * from ChinaQJ_Message"
rs.open sql,conn,1,3
rs.addnew
rs("MesName")=StrReplace(MesName)
rs("Content")=StrReplace(Content)
rs("MemID")=mMemID
rs("Linkman")=StrReplace(mLinkman)
rs("Sex")=mSex
rs("Company")=StrReplace(mCompany)
rs("Address")=StrReplace(mAddress)
rs("ZipCode")=StrReplace(mZipCode)
rs("Telephone")=StrReplace(mTelephone)
rs("Fax")=StrReplace(mFax)
rs("Mobile")=StrReplace(mMobile)
rs("Email")=mEmail
rs("SecretFlag")=SecretFlag
if MesViewFlag then
rs("ViewFlag"&Language)=1
else
rs("ViewFlag"&Language)=0
end if
rs("AddTime")=now()
rs.update
rs.close
set rs=Nothing
Call SiteInfo()
If MesViewFlag = 0 Then
	response.write "<script language='javascript'>alert('"&ChinaQJLanguageTxt204&"');location.replace('MessageList.Asp');</script>"
Else
	response.write "<script language='javascript'>alert('"&ChinaQJLanguageTxt205&"');location.replace('MessageList.Asp');</script>"
End If
%>