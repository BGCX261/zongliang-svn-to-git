<!--#include file="../Include/Const.Asp"-->
<!--#include file="../Include/ConnSiteData.Asp"-->
<!--#include file="../Include/Md5.Asp"-->
<!--#include file="Function.Asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%
call FormCheckdata
if DateDiff("s",session("time"),now())<Refresh then
   response.write "<script language='JavaScript'>alert('"&ChinaQJLanguageTxt145&" "&Refresh&" "&ChinaQJLanguageTxt146&"');" & "history.back()" & "</script>"
   response.end
else
   session("time")=now()
end if
dim mMemName,mRealName,mSex,mPassword,mQuestion,mAnswer,mCompany,mAddress,mZipCode,mTelephone,mFax,mMobile,mEmail,mHomePage
dim vPassword,CheckCode
dim rs,sql
mMemName=trim(request.form("MemName"))
mRealName=trim(request.form("RealName"))
mSex=trim(request.form("Sex"))
mPassword=trim(request.form("Password"))
vPassword=trim(request.form("vPassword"))
mQuestion=trim(request.form("Question"))
mAnswer=trim(request.form("Answer"))
mCompany=trim(request.form("Company"))
mAddress=trim(request.form("Address"))
mZipCode=trim(request.form("ZipCode"))
mTelephone=trim(request.form("Telephone"))
mFax=trim(request.form("Fax"))
mMobile=trim(request.form("Mobile"))
mEmail=trim(request.form("Email"))
mHomePage=trim(request.form("HomePage"))
CheckCode = Trim(request.form("CheckCode"))
dim ErrMessage,ErrMsg(14),FindErr(14),i
  ErrMsg(0)=ChinaQJLanguageTxt173
  ErrMsg(1)=ChinaQJLanguageTxt174
  ErrMsg(2)=ChinaQJLanguageTxt166
  ErrMsg(3)=ChinaQJLanguageTxt167
  ErrMsg(4)=ChinaQJLanguageTxt168
  ErrMsg(5)=ChinaQJLanguageTxt177
  ErrMsg(6)=ChinaQJLanguageTxt170
  ErrMsg(7)=ChinaQJLanguageTxt160
  ErrMsg(8)=ChinaQJLanguageTxt178
  ErrMsg(9)=ChinaQJLanguageTxt162
  ErrMsg(10)=ChinaQJLanguageTxt175
  ErrMsg(11)=ChinaQJLanguageTxt176
  ErrMsg(12)=ChinaQJLanguageTxt200
  ErrMsg(13)=ChinaQJLanguageTxt201
  ErrMsg(14)=ChinaQJLanguageTxt202
if not IsValidMemName(mMemName) then FindErr(0)=true
if not conn.execute("select MemName from ChinaQJ_Members where MemName='" & mMemName & "'").eof then FindErr(1)=true
if not (6<=len(mPassword) and len(mPassword)<=16) then FindErr(2)=true
if mPassword<>vPassword then FindErr(3)=true

If CheckCode = "" Then FindErr(7)=true
If Trim(Session("CheckCode")) = "" Then FindErr(8)=true
If CheckCode <> Session("CheckCode") Then FindErr(9)=true
if Instr(UserRegisterPurviewDis,"|3,")>0 then
if len(mRealName)=0 Or len(mRealName)>50 then FindErr(5)=True
end if
if Instr(UserRegisterPurviewDis,"|4,")>0 then
if len(mSex)=0 then FindErr(12)=True
end if
if Instr(UserRegisterPurviewDis,"|5,")>0 or Instr(UserRegisterPurviewDis,"|6,")>0 then
if len(mQuestion)=0 then FindErr(10)=True
if len(mAnswer)=0 then FindErr(11)=True
end if
if Instr(UserRegisterPurviewDis,"|7,")>0 then
if len(mCompany)=0 Or len(mCompany)>100 then FindErr(4)=true
elseif Instr(UserRegisterPurviewDis,"|8,")>0 then
if len(mAddress)=0 then FindErr(13)=True
elseif Instr(UserRegisterPurviewDis,"|9,")>0 then
if len(mZipCode)=0 then FindErr(13)=True
elseif Instr(UserRegisterPurviewDis,"|10,")>0 then
if len(mTelephone)=0 then FindErr(14)=true
elseif Instr(UserRegisterPurviewDis,"|11,")>0 then
if len(mFax)=0 then FindErr(14)=True
elseif Instr(UserRegisterPurviewDis,"|12,")>0 then
if len(mMobile)=0 then FindErr(14)=True
elseif Instr(UserRegisterPurviewDis,"|13,")>0 then
If mEmail <> "" Then
if not conn.execute("select MemName from ChinaQJ_Members where Email='" & mEmail & "'").eof then FindErr(6)=True
End If
elseif Instr(UserRegisterPurviewDis,"|14,")>0 then
if len(mHomePage)=0 then FindErr(14)=True
end if
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
sql="select * from ChinaQJ_Members"
rs.open sql,conn,1,3
rs.addnew
rs("MemName")=mMemName
rs("RealName")=StrReplace(mRealName)
rs("Sex")=mSex
rs("Password")=Md5(mPassword)
rs("Question")=StrReplace(mQuestion)
rs("Answer")=Md5(mAnswer)
rs("Company")=StrReplace(mCompany)
rs("Address")=StrReplace(mAddress)
rs("ZipCode")=StrReplace(mZipCode)
rs("Telephone")=StrReplace(mTelephone)
rs("Fax")=StrReplace(mFax)
rs("Mobile")=StrReplace(mMobile)
rs("Email")=mEmail
rs("HomePage")=StrReplace(mHomePage)
rs("GroupID")="200709088888888888"
rs("GroupName")=GroupName("200709088888888888")
rs("AddTime")=now()
rs.update
rs.close
Set rs=Nothing
response.write "<script language='javascript'>alert('"&ChinaQJLanguageTxt179&"');location.replace('Index.Asp');</script>"
response.End

function GroupName(GroupID)
  dim rs,sql
  set rs = server.createobject("adodb.recordset")
  sql="select * from ChinaQJ_MemGroup where GroupID='"&GroupID&"'"
  rs.open sql,conn,1,1
  GroupName=rs("GroupName"&Language)
  rs.close
  set rs=nothing
end function
%>