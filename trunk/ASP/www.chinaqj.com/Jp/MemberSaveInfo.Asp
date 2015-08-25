<!--#include file="../Include/Const.Asp"-->
<!--#include file="../Include/ConnSiteData.Asp"-->
<!--#include file="../Include/Md5.Asp"-->
<%
dim ID,mRealName,mSex,mPassword,vPassword,mCompany,mAddress,mZipCode,mTelephone,mFax,mMobile,mEmail,mHomePage
dim CheckCode
dim rs,sql
ID=request.QueryString("ID")
mRealName=trim(request.form("RealName"))
mSex=trim(request.form("Sex"))
mPassword=trim(request.form("Password"))
vPassword=trim(request.form("vPassword"))
mCompany=trim(request.form("Company"))
mAddress=trim(request.form("Address"))
mZipCode=trim(request.form("ZipCode"))
mTelephone=trim(request.form("Telephone"))
mFax=trim(request.form("Fax"))
mMobile=trim(request.form("Mobile"))
mEmail=trim(request.form("Email"))
mHomePage=trim(request.form("HomePage"))
CheckCode = Trim(request.form("CheckCode"))
dim ErrMessage,ErrMsg(9),FindErr(9),i
  ErrMsg(0)=ChinaQJLanguageTxt166
  ErrMsg(1)=ChinaQJLanguageTxt167
  ErrMsg(2)=ChinaQJLanguageTxt168
  ErrMsg(3)=ChinaQJLanguageTxt154
  ErrMsg(4)=ChinaQJLanguageTxt170
  ErrMsg(5)=ChinaQJLanguageTxt160
  ErrMsg(6)=ChinaQJLanguageTxt171
  ErrMsg(7)=ChinaQJLanguageTxt162
if len(mPassword)>0 then
   if not (6<=len(mPassword) and len(mPassword)<=16) then FindErr(0)=true
   if mPassword<>vPassword then FindErr(1)=true
end if
if len(mCompany)=0 Or len(mCompany)>100 then FindErr(2)=true
if len(mRealName)=0 Or len(mRealName)>50 then FindErr(3)=True
If mEmail <> "" Then
if not conn.execute("select MemName from ChinaQJ_Members where ID<>"&ID&" and Email='" & mEmail & "'").eof then FindErr(4)=True
End If
If CheckCode = "" Then FindErr(5)=true
If Trim(Session("CheckCode")) = "" Then FindErr(6)=true
If CheckCode <> Session("CheckCode") Then FindErr(7)=true
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
sql="select * from ChinaQJ_Members where ID="&ID
rs.open sql,conn,1,3
rs("RealName")=StrReplace(mRealName)
rs("Sex")=mSex
if len(mPassword)>0 then rs("Password")=Md5(mPassword)
rs("Company")=StrReplace(mCompany)
rs("Address")=StrReplace(mAddress)
rs("ZipCode")=StrReplace(mZipCode)
rs("Telephone")=StrReplace(mTelephone)
rs("Fax")=StrReplace(mFax)
rs("Mobile")=StrReplace(mMobile)
rs("Email")=mEmail
rs("HomePage")=StrReplace(mHomePage)
rs.update
rs.close
set rs=nothing
response.write "<script language='javascript'>alert('"&ChinaQJLanguageTxt172&"');location.replace('MemberInfo.Asp');</script>"
%>