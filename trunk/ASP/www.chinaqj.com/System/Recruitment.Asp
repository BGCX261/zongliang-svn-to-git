<!--#include file="../Include/Const.asp" -->
<!--#include file="../Include/ConnSiteData.asp" -->
<!--#include file="../Include/Md5.asp"-->
<!--#include file="CheckAdmin.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="Images/Admin_style.css">
<script language="javascript" src="../Scripts/Admin.js"></script>
<br />
<%
if Instr(session("AdminPurview"),"|60,")=0 then
  response.write ("<br /><br /><div align=""center""><font style=""color:red; font-size:9pt; "")>您没有管理该模块的权限！</font></div>")
  response.end
end if
call FormCheckdata
Action=Trim(Request.QueryString("Action"))
if Action="SaveEdit" then
set rs = server.createobject("adodb.recordset")
sql="select * from ChinaQJ_Formcheck where ID=1"
rs.open sql,conn,1,3
rs("RecruitmentPurview")=Request("Purview9")&Request("Purview10")&Request("Purview11")&Request("Purview12")&Request("Purview13")&Request("Purview14")
rs("RecruitmentPurviewDis")=Request("PurviewDis9")&Request("PurviewDis10")&Request("PurviewDis11")&Request("PurviewDis12")&Request("PurviewDis13")&Request("PurviewDis14")
rs.update
rs.close
set rs=nothing
response.write "<script language='javascript'>alert('设置成功！');location.replace('Recruitment.asp');</script>"
end if
%>
<table class="tableBorder" width="95%" border="0" align="center" cellpadding="5" cellspacing="1">
  <tr>
    <th height="22" colspan="2" sytle="line-height:150%">【人才招聘表单参数】</th>
  </tr>
  <tr>
    <td width="200" class="forumRow">必填项设置：</td>
    <td class="forumRowHighlight"><input name="Purview1" type="checkbox" value="|1," checked disabled>
      申请职位 <font color="red">* 必选</font></td>
  </tr>
  <tr>
    <td class="forumRow"></td>
    <td class="forumRowHighlight"><input name="Purview2" type="checkbox" value="|2," checked disabled>
      真实姓名 <font color="red">* 必选</font></td>
  </tr>
  <tr>
    <td class="forumRow"></td>
    <td class="forumRowHighlight"><input name="Purview3" type="checkbox" value="|3," checked disabled>
      性别 <font color="red">* 必选</font></td>
  </tr>
  <tr>
    <td class="forumRow"></td>
    <td class="forumRowHighlight"><input name="Purview4" type="checkbox" value="|4," checked disabled>
      出生日期 <font color="red">* 必选</font></td>
  </tr>
  <tr>
    <td class="forumRow"></td>
    <td class="forumRowHighlight"><input name="Purview5" type="checkbox" value="|5," checked disabled>
      户口所在地 <font color="red">* 必选</font></td>
  </tr>
  <tr>
    <td class="forumRow"></td>
    <td class="forumRowHighlight"><input name="Purview6" type="checkbox" value="|6," checked disabled>
      教育经历 <font color="red">* 必选</font></td>
  </tr>
  <tr>
    <td class="forumRow"></td>
    <td class="forumRowHighlight"><input name="Purview7" type="checkbox" value="|7," checked disabled>
      工作经历 <font color="red">* 必选</font></td>
  </tr>
  <tr>
    <td class="forumRow"></td>
    <td class="forumRowHighlight"><input name="Purview8" type="checkbox" value="|8," checked disabled>
      联系电话 <font color="red">* 必选</font></td>
  </tr>
  <tr>
    <td class="forumRow"></td>
    <td class="forumRowHighlight"><input name="Purview15" type="checkbox" value="|15," checked disabled>
      验证码 <font color="red">* 必选</font></td>
  </tr>
  <form name="editForm" method="post" action="Recruitment.Asp?Action=SaveEdit">
    <tr>
      <td class="forumRow"><strong style="color: #CC0000;">婚姻状况</strong></td>
      <td class="forumRowHighlight">显示
        <input name="Purview9" type="checkbox" value="|9," <%if Instr(RecruitmentPurview,"|9,")>0 then response.write ("checked")%>
>
        必填
        <input name="PurviewDis9" type="checkbox" value="|9," <%if Instr(RecruitmentPurviewDis,"|9,")>0 then response.write ("checked")%>
></td>
    </tr>
    <tr>
      <td class="forumRow"><strong style="color: #CC0000;">身高</strong></td>
      <td class="forumRowHighlight">显示
        <input name="Purview10" type="checkbox" value="|10," <%if Instr(RecruitmentPurview,"|10,")>0 then response.write ("checked")%>
>
        必填
        <input name="PurviewDis10" type="checkbox" value="|10," <%if Instr(RecruitmentPurviewDis,"|10,")>0 then response.write ("checked")%>
></td>
    </tr>
    <tr>
      <td class="forumRow"><strong style="color: #CC0000;">联系地址</strong></td>
      <td class="forumRowHighlight">显示
        <input name="Purview11" type="checkbox" value="|11," <%if Instr(RecruitmentPurview,"|11,")>0 then response.write ("checked")%>
>
        必填
        <input name="PurviewDis11" type="checkbox" value="|11," <%if Instr(RecruitmentPurviewDis,"|11,")>0 then response.write ("checked")%>
></td>
    </tr>
    <tr>
      <td class="forumRow"><strong style="color: #CC0000;">邮政编码</strong></td>
      <td class="forumRowHighlight">显示
        <input name="Purview12" type="checkbox" value="|12," <%if Instr(RecruitmentPurview,"|12,")>0 then response.write ("checked")%>
>
        必填
        <input name="PurviewDis12" type="checkbox" value="|12," <%if Instr(RecruitmentPurviewDis,"|12,")>0 then response.write ("checked")%>
></td>
    </tr>
    <tr>
      <td class="forumRow"><strong style="color: #CC0000;">手机号码</strong></td>
      <td class="forumRowHighlight">显示
        <input name="Purview13" type="checkbox" value="|13," <%if Instr(RecruitmentPurview,"|13,")>0 then response.write ("checked")%>
>
        必填
        <input name="PurviewDis13" type="checkbox" value="|13," <%if Instr(RecruitmentPurviewDis,"|13,")>0 then response.write ("checked")%>
></td>
    </tr>
    <tr>
      <td class="forumRow"><strong style="color: #CC0000;">电子信箱</strong></td>
      <td class="forumRowHighlight">显示
        <input name="Purview14" type="checkbox" value="|14," <%if Instr(RecruitmentPurview,"|14,")>0 then response.write ("checked")%>
>
        必填
        <input name="PurviewDis14" type="checkbox" value="|14," <%if Instr(RecruitmentPurviewDis,"|14,")>0 then response.write ("checked")%>
></td>
    </tr>
    <tr>
      <td class="forumRow"></td>
      <td class="forumRowHighlight"><input name="submitSaveEdit" type="submit" id="submitSaveEdit" value="保存设置">
        <input type="button" value="返回上一页" onclick="history.back(-1)">
        <input onClick="CheckAll(this.form)" name="buttonAllSelect" type="button" id="submitAllSelect" value="全选">
        <input onClick="CheckOthers(this.form)" name="buttonOtherSelect" type="button" id="submitOtherSelect" value="反选"></td>
    </tr>
  </form>
</table>
<br />
