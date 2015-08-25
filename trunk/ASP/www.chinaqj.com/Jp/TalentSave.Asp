<!--#include file="../Include/Const.Asp"-->
<!--#include file="../Include/ConnSiteData.Asp"-->
<!--#include file="Function.Asp" -->
<%
Call FormCheckdata
if DateDiff("s",session("time"),now())<Refresh then
   response.write "<script language='JavaScript'>alert('"&ChinaQJLanguageTxt145&" "&Refresh&" "&ChinaQJLanguageTxt146&"');" & "history.back()" & "</script>"
   response.end
else
   session("time")=now()
end if
dim rs,sql
dim JobID,TalentsName,BirthDate,Stature,Marriage,RegResidence,EduResume,JobResume
dim mMemID,mLinkman,mSex,mAddress,mZipCode,mTelephone,mMobile,mEmail,CheckCode
JobID=request.QueryString("JobID")
TalentsName=trim(request.form("TalentsName"))
BirthDate=trim(request.form("BirthDate"))
Stature=trim(request.form("Stature"))
Marriage=trim(request.form("Marriage"))
RegResidence=trim(request.form("RegResidence"))
EduResume=trim(request.form("EduResume"))
JobResume=trim(request.form("JobResume"))
mMemID=request.QueryString("MemberID")
mLinkman=trim(request.form("Linkman"))
mSex=trim(request.form("Sex"))
mAddress=trim(request.form("Address"))
mZipCode=trim(request.form("ZipCode"))
mTelephone=trim(request.form("Telephone"))
mMobile=trim(request.form("Mobile"))
mEmail=trim(request.form("Email"))
CheckCode = Trim(request.form("CheckCode"))
dim ErrMessage,ErrMsg(15),FindErr(15),i
  ErrMsg(0)=ChinaQJLanguageTxt148
  ErrMsg(1)=ChinaQJLanguageTxt149
  ErrMsg(2)=ChinaQJLanguageTxt150
  ErrMsg(3)=ChinaQJLanguageTxt151
  ErrMsg(4)=ChinaQJLanguageTxt152
  ErrMsg(5)=ChinaQJLanguageTxt153
  ErrMsg(6)=ChinaQJLanguageTxt154
  ErrMsg(7)=ChinaQJLanguageTxt155
  ErrMsg(8)=ChinaQJLanguageTxt156
  ErrMsg(9)=ChinaQJLanguageTxt157
  ErrMsg(10)=ChinaQJLanguageTxt158
  ErrMsg(11)=ChinaQJLanguageTxt159
  ErrMsg(12)=ChinaQJLanguageTxt160
  ErrMsg(13)=ChinaQJLanguageTxt161
  ErrMsg(14)=ChinaQJLanguageTxt162
  ErrMsg(15)=ChinaQJLanguageTxt300
if len(TalentsName)>100 Or len(TalentsName)=0 then
  FindErr(0)=true
end if
if not IsDate(BirthDate) then
  FindErr(1)=true
end if
if Instr(RecruitmentPurviewDis,"|9,")>0 then
If Marriage="" Then FindErr(15)=true
elseif Instr(RecruitmentPurviewDis,"|10,")>0 then
if not IsNumeric(Stature) Or len(Stature)=0 then FindErr(2)=true
elseif Instr(RecruitmentPurviewDis,"|11,")>0 then
if len(mAddress)>100 Or len(mAddress)=0 then FindErr(7)=true
elseif Instr(RecruitmentPurviewDis,"|12,")>0 then
if len(mZipCode)<>6 then FindErr(8)=true
elseif Instr(RecruitmentPurviewDis,"|13,")>0 then
if len(mMobile)>50 Or len(mMobile)<11 Or len(mMobile)=0 then FindErr(10)=true
elseif Instr(RecruitmentPurviewDis,"|14,")>0 then
If mEmail <> "" Then
If Not IsValidEmail(mEmail) Then
  FindErr(11)=True
End If
End If
end if

if len(RegResidence)>100 Or len(RegResidence)=0 then
  FindErr(3)=true
end if
if len(EduResume)=0 then
  FindErr(4)=true
end if
if len(JobResume)=0 then
  FindErr(5)=true
end if
if len(mLinkman)>50 Or len(mLinkman)=0 then
  FindErr(6)=true
end if
if len(mTelephone)>50 Or len(mTelephone)=0 then
  FindErr(9)=true
end if
If CheckCode = "" Then
  FindErr(12)=true
End If
If Trim(Session("CheckCode")) = "" Then
  FindErr(13)=true
End If
If CheckCode <> Session("CheckCode") Then
  FindErr(14)=true
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
sql="select * from ChinaQJ_Talents"
rs.open sql,conn,1,3
rs.addnew
rs("JobID")=JobID
rs("TalentsName")=StrReplace(TalentsName)
rs("BirthDate")=BirthDate
rs("Stature")=Stature
rs("Marriage")=Marriage
rs("RegResidence")=StrReplace(RegResidence)
rs("EduResume")=StrReplace(EduResume)
rs("JobResume")=StrReplace(JobResume)
rs("MemID")=mMemID
rs("Linkman")=StrReplace(mLinkman)
rs("Sex")=mSex
rs("Address")=StrReplace(mAddress)
rs("ZipCode")=StrReplace(mZipCode)
rs("Telephone")=StrReplace(mTelephone)
rs("Mobile")=StrReplace(mMobile)
rs("Email")=mEmail
rs("AddTime")=now()
rs.update
rs.close
set rs=nothing
conn.execute "update ChinaQJ_Jobs set TalentsNumber = TalentsNumber+1 where ID="&JobID
response.write "<script language='javascript'>alert('"&ChinaQJLanguageTxt147&"');location.replace('Index.Asp');</script>"
%>