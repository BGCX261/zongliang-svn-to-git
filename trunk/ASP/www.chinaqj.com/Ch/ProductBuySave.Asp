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
dim mOrderName,mRemark
dim mMemID,mRealName,mSex,mCompany,mAddress,mZipCode,mTelephone,mFax,mMobile,mEmail,CheckCode
dim rs,sql
mOrderName=trim(request.form("OrderName"))
mRemark=""&ChinaQJLanguageTxt188&"：<br>"&request.form("Products")&""&ChinaQJLanguageTxt189&"：<br>"&request.form("Remark")
mMemID=request.QueryString("MemberID")
mRealName=trim(request.form("RealName"))
mSex=trim(request.form("Sex"))
mCompany=trim(request.form("Company"))
mAddress=trim(request.form("Address"))
mZipCode=trim(request.form("ZipCode"))
mTelephone=trim(request.form("Telephone"))
mFax=trim(request.form("Fax"))
mMobile=trim(request.form("Mobile"))
mEmail=trim(request.form("Email"))
CheckCode = Trim(request.form("CheckCode"))
dim ErrMessage,ErrMsg(12),FindErr(12),i
  ErrMsg(0)=ChinaQJLanguageTxt190
  ErrMsg(1)=ChinaQJLanguageTxt191
  ErrMsg(2)=ChinaQJLanguageTxt192
  ErrMsg(3)=ChinaQJLanguageTxt156
  ErrMsg(4)=ChinaQJLanguageTxt193
  ErrMsg(5)=ChinaQJLanguageTxt194
  ErrMsg(6)=ChinaQJLanguageTxt159
  ErrMsg(7)=ChinaQJLanguageTxt160
  ErrMsg(8)=ChinaQJLanguageTxt195
  ErrMsg(9)=ChinaQJLanguageTxt162
  ErrMsg(10)=ChinaQJLanguageTxt200
  ErrMsg(11)=ChinaQJLanguageTxt201
  ErrMsg(12)=ChinaQJLanguageTxt202
if len(mOrderName)>100 Or len(mOrderName)=0 then
  FindErr(0)=true
end if
if len(mRealName)>50 Or len(mRealName)=0 then
  FindErr(1)=true
end if
if Instr(UserCartPurviewDis,"|7,")>0 then
if len(mCompany)>100 Or len(Address)>100 Or len(mCompany)=0 then
  FindErr(2)=true
end if
elseif Instr(UserCartPurviewDis,"|8,")>0 then
if len(mZipCode)<>6 then
  FindErr(3)=true
end if
end if
if len(mTelephone)>50 Or len(mTelephone)<11 Or len(mTelephone)=0 then
  FindErr(4)=true
end if
if Instr(UserCartPurviewDis,"|10,")>0 then
if len(mMobile)=0 Or len(mMobile)>50 then
  FindErr(5)=true
end If
elseif Instr(UserCartPurviewDis,"|11,")>0 then
If mEmail <> "" Then
If Not IsValidEmail(mEmail) Then
  FindErr(6)=True
End If
End If
elseif Instr(UserCartPurviewDis,"|9,")>0 then
if len(mfax)=0 then FindErr(12)=true
elseif Instr(UserCartPurviewDis,"|6,")>0 then
if len(mSex)=0 then FindErr(10)=true
end If

If CheckCode = "" Then
  FindErr(7)=true
End If
If Trim(Session("CheckCode")) = "" Then
  FindErr(8)=true
End If
If CheckCode <> Session("CheckCode") Then
  FindErr(9)=true
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
sql="select * from ChinaQJ_Order"
rs.open sql,conn,1,3
rs.addnew
rs("OrderName")=StrReplace(mOrderName)
rs("Remark")=StrReplace(mRemark)
rs("MemID")=mMemID
rs("Linkman")=StrReplace(mRealName)
rs("Sex")=mSex
rs("Company")=StrReplace(mCompany)
rs("Address")=StrReplace(mAddress)
rs("ZipCode")=StrReplace(mZipCode)
rs("Telephone")=StrReplace(mTelephone)
rs("Fax")=StrReplace(mFax)
rs("Mobile")=StrReplace(mMobile)
rs("Email")=mEmail
rs("AddTime")=now()
rs.update
rs.close
set rs=nothing
Session("ChinaQJProductBuyNoList")=""
response.write "<script language='javascript'>alert('"&ChinaQJLanguageTxt196&"');location.replace('Index.Asp');</script>"
%>