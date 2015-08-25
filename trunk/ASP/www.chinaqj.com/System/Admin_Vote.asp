<!--#include file="../Include/Const.asp" -->
<!--#include file="../Include/ConnSiteData.asp" -->
<!--#include file="Admin_htmlconfig.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="Images/Admin_style.css">
<script language="javascript" src="../Scripts/Admin.js"></script>
<script language="javascript" src="../DatePicker/WdatePicker.js"></script>
<%
if Instr(session("AdminPurview"),"|51,")=0 then
  response.write ("<br /><br /><div align=""center""><font style=""color:red; font-size:9pt; "")>您没有管理该模块的权限！</font></div>")
  response.end
end if
%>
<script>
function show(id)
{
    if(document.all(id).style.display=='none')
    {
    document.all(id).style.display='block';
    }
else
    {
    document.all(id).style.display='none';
    }
}
</script>
<br />
<% if Request("id")="" then %>
<script language="javascript">
function setid()
{
str='';
if(!window.form1.votecount.value)
window.form1.votecount.value=1;
for(i=1;i<=window.form1.votecount.value;i++)
str+='<input type="text" name="ChinaQJ_VoteTitle'+i+'" value="选项'+i+'" size="40"> 选项颜色：<select name="ChinaQJ_VoteColor'+i+'"><option style="background-color: red; color: red" value="red" selected>默认</option><option style="background-color: 000000; color: 000000" value="000000">黑色</option><option style="background-color: 0088FF; color: 0088FF" value="0088FF">海蓝</option><option style="background-color: 0000FF; color: 0000FF" value="0000FF">亮蓝</option><option style="background-color: 000088; color: 000088" value="000088">深蓝</option><option style="background-color: 888800; color: 888800" value="888800">黄绿</option><option style="background-color: 008888; color: 008888" value="008888">蓝绿</option><option style="background-color: 008800; color: 008800" value="008800">橄榄</option><option style="background-color: 8888FF; color: 8888FF" value="8888FF">淡紫</option><option style="background-color: AA00CC; color: AA00CC" value="AA00CC">紫色</option><option style="background-color: 8800FF; color: 8800FF" value="8800FF">蓝紫</option><option style="background-color: 888888; color: 888888" value="888888">灰色</option><option style="background-color: CCAA00; color: CCAA00" value="CCAA00">土黄</option><option style="background-color: FF8800; color: FF8800" value="FF8800">金黄</option><option style="background-color: CC3366; color: CC3366" value="CC3366">暗红</option><option style="background-color: FF00FF; color: FF00FF" value="FF00FF">紫红</option><option style="background-color: 3366CC; color: 3366CC" value="3366CC">蓝黑</option></select><br />';
window.upid.innerHTML=str;
}
</script>
<% Else %>
<script language="javascript">
function setid()
 {
 str='';
 if(!window.form1.votecount.value)
 window.form1.votecount.value=1;
 for(i=1;i<=window.form1.votecount.value;i++)
 str+='<input type="text" name="ChinaQJ_VoteTitless'+i+'" value="选项'+i+'" size="40"> 选项颜色：<select name="ChinaQJ_VoteColorss'+i+'"><option style="background-color: red; color: red" value="red" selected>默认</option><option style="background-color: 000000; color: 000000" value="000000">黑色</option><option style="background-color: 0088FF; color: 0088FF" value="0088FF">海蓝</option><option style="background-color: 0000FF; color: 0000FF" value="0000FF">亮蓝</option><option style="background-color: 000088; color: 000088" value="000088">深蓝</option><option style="background-color: 888800; color: 888800" value="888800">黄绿</option><option style="background-color: 008888; color: 008888" value="008888">蓝绿</option><option style="background-color: 008800; color: 008800" value="008800">橄榄</option><option style="background-color: 8888FF; color: 8888FF" value="8888FF">淡紫</option><option style="background-color: AA00CC; color: AA00CC" value="AA00CC">紫色</option><option style="background-color: 8800FF; color: 8800FF" value="8800FF">蓝紫</option><option style="background-color: 888888; color: 888888" value="888888">灰色</option><option style="background-color: CCAA00; color: CCAA00" value="CCAA00">土黄</option><option style="background-color: FF8800; color: FF8800" value="FF8800">金黄</option><option style="background-color: CC3366; color: CC3366" value="CC3366">暗红</option><option style="background-color: FF00FF; color: FF00FF" value="FF00FF">紫红</option><option style="background-color: 3366CC; color: 3366CC" value="3366CC">蓝黑</option></select><br />';
 window.upid.innerHTML=str;
 }
</script>
<% End If %>
<%
If Trim(Request.QueryString("Action"))="Modify" Then
sql="select * from ChinaQJ_vote where ChinaQJ_Voteid="&Request("id")
set rs=server.createobject("adodb.recordset")
rs.open sql,conn,1,1
id=Request("id")
ChinaQJ_VoteTitle=rs("ChinaQJ_VoteTitle")
ChinaQJ_VoteStart=rs("ChinaQJ_VoteStart")
ChinaQJ_VoteEnd=rs("ChinaQJ_VoteEnd")
ChinaQJ_VoteStyle=rs("ChinaQJ_VoteStyle")
ChinaQJ_VoteColor=rs("ChinaQJ_VoteColor")
ChinaQJ_Voteing=rs("ChinaQJ_Voteing")
rs.close
set rs=nothing
end if

If Trim(Request.QueryString("Action"))="SaveData" Then

if Request("ChinaQJ_VoteTitle")="" or Request("ChinaQJ_VoteStart")="" or Request("ChinaQJ_VoteEnd")="" then
      response.write ("<script language='javascript'>alert('请完整填写各项信息！');history.back(-1);</script>")
      response.end
end if

set rs=server.createobject("adodb.recordset")
if Request("id")<>"" then
sql="select * from ChinaQJ_vote where ChinaQJ_Voteid="&Request("id")
rs.open sql,conn,1,3
rs("ChinaQJ_VoteTitle")=Request("ChinaQJ_VoteTitle")
rs("ChinaQJ_VoteStart")=Request("ChinaQJ_VoteStart")
rs("ChinaQJ_VoteEnd")=Request("ChinaQJ_VoteEnd")
rs("ChinaQJ_VoteStyle")=Request("ChinaQJ_VoteStyle")
rs("ChinaQJ_Voteing")=Request("ChinaQJ_Voteing")
rs.update
rs.close
if Request("votecountss")<>"" then
for i=1 to Request("votecountss")
ChinaQJ_Voteid=Request("ChinaQJ_Voteid"&i&"")
sql="select * from ChinaQJ_vote where ChinaQJ_Voteid="&ChinaQJ_Voteid
rs.open sql,conn,1,3
rs("ChinaQJ_Voteing")=Request("ChinaQJ_Voteing")
rs("ChinaQJ_VoteTitle")=Request("ChinaQJ_VoteTitle"&i&"")
rs("ChinaQJ_VoteColor")=Request("ChinaQJ_VoteColor"&i&"")
rs.update
rs.close
next
end if
'新增投票选项
if Request("votecount")>0 then
for i=1 to Request("votecount")
sql="select * from ChinaQJ_vote"
rs.open sql,conn,1,3
rs.addnew
rs("ChinaQJ_VoteClass")=Request("id")
rs("ChinaQJ_VoteCount")=0
rs("ChinaQJ_Voteing")=Request("ChinaQJ_Voteing")
rs("ChinaQJ_VoteTitle")=Request("ChinaQJ_VoteTitless"&i&"")
rs("ChinaQJ_VoteColor")=Request("ChinaQJ_VoteColorss"&i&"")
rs.update
rs.close
next
end if
'修改结束
else
sql="select * from ChinaQJ_vote"
rs.open sql,conn,1,3
rs.addnew
rs("ChinaQJ_VoteTitle")=Request("ChinaQJ_VoteTitle")
rs("ChinaQJ_VoteStart")=Request("ChinaQJ_VoteStart")
rs("ChinaQJ_VoteEnd")=Request("ChinaQJ_VoteEnd")
rs("ChinaQJ_VoteStyle")=Request("ChinaQJ_VoteStyle")
rs("ChinaQJ_Voteing")=Request("ChinaQJ_Voteing")
rs("ChinaQJ_VoteClass")=0
rs.update
id=rs("ChinaQJ_Voteid")
'新增投票选项
if Request("votecount")>0 then
for i=1 to Request("votecount")
rs.addnew
rs("ChinaQJ_VoteClass")=id
rs("ChinaQJ_VoteCount")=0
rs("ChinaQJ_Voteing")=Request("ChinaQJ_Voteing")
rs("ChinaQJ_VoteTitle")=Request("ChinaQJ_VoteTitle"&i&"")
rs("ChinaQJ_VoteColor")=Request("ChinaQJ_VoteColor"&i&"")
rs.update
next
end if
end if
end if

'删除投票选项
If Trim(Request.QueryString("Action"))="Del" Then
conn.execute "delete from ChinaQJ_vote where ChinaQJ_Voteid="&Request("id")
conn.execute "delete from ChinaQJ_vote where ChinaQJ_VoteClass="&Request("id")
response.redirect "Admin_vote.asp"
end if

If Trim(Request.QueryString("Action"))="VoteDel" Then
conn.execute "delete from ChinaQJ_vote where ChinaQJ_Voteid="&Request("Voteid")
response.redirect "Admin_vote.asp"
end if
%>

<%
if Request("id")="" then
paget="添加新"
else
paget="修改投票"
end if
If Trim(Request.QueryString("Action"))="Add" or Trim(Request.QueryString("Action"))="Modify" Then %>
<table class="tableBorder" width="95%" border="0" align="center" cellpadding="5" cellspacing="1">
  <form name="form1" action="Admin_Vote.Asp?action=SaveData&id=<%=Request("id")%>" method="post">
    <input name="key" type="hidden" value="0">
    <tr>
      <th colspan="2" height="25"><%= paget %>项目</th>
    </tr>
    <tr>
      <td width="200" height="25" align="right" class="forumRow">项目标题：</td>
      <td class="forumRowHighlight"><input name="ChinaQJ_VoteTitle" type="text" size="40" value="<%= ChinaQJ_VoteTitle %>"></td>
    </tr>
<% If ChinaQJ_VoteStyle="" Then ChinaQJ_VoteStyle="radio"%>
    <tr>
      <td height="25" align="right" class="forumRow">投票方式：</td>
      <td class="forumRowHighlight"><input name="ChinaQJ_VoteStyle" type="radio" value="radio" <% If ChinaQJ_VoteStyle="radio" Then %>checked<% End If %>>
        单选
        <input name="ChinaQJ_VoteStyle" type="radio" value="checkbox" <% If ChinaQJ_VoteStyle="checkbox" Then %>checked<% End If %>>
        多选</td>
    </tr>
<% If ChinaQJ_Voteing="" Then ChinaQJ_Voteing=1%>
    <tr>
      <td height="25" align="right" class="forumRow">投票状态：</td>
      <td class="forumRowHighlight"><input name="ChinaQJ_Voteing" type="radio" value="1" <% If ChinaQJ_Voteing=1 Then %>checked<% End If %>>
        开
        <input name="ChinaQJ_Voteing" type="radio" value="0" <% If ChinaQJ_Voteing=0 Then %>checked<% End If %>>
        关</td>
    </tr>
    <tr>
      <td height="25" align="right" class="forumRow">投票时间：</td>
      <td class="forumRowHighlight">开始于
        <input size="10" readonly="" name="ChinaQJ_VoteStart" id="ChinaQJ_VoteStart" value="<%= ChinaQJ_VoteStart %>" onClick="WdatePicker()" />
        结束于
        <input size="10" readonly="" name="ChinaQJ_VoteEnd" id="ChinaQJ_VoteEnd" value="<%= ChinaQJ_VoteEnd %>" onClick="WdatePicker()" /></td>
    </tr>
<%
if Request("id")<>"" then
sqls="select * from ChinaQJ_vote where ChinaQJ_VoteClass="&Request("id")
set rss=server.createobject("adodb.recordset")
rss.open sqls,conn,1,1
votecountss=rss.recordcount
%>
    <tr align="center" valign="middle">
      <td align="right" valign="top" class="forumRow">投票选项：</td>
      <td align="left" id="upids" class="forumRowHighlight"><input type="hidden" name="votecountss" value="<%= votecountss %>">
<%
j=1
while(not rss.eof)
%>
        <input type="hidden" name="ChinaQJ_Voteid<%= j %>" value="<%= rss("ChinaQJ_Voteid") %>">
        <input type="text" name="ChinaQJ_VoteTitle<%= j %>" value="<%= rss("ChinaQJ_VoteTitle") %>" size="40">
        图形颜色:
        <select name="ChinaQJ_VoteColor<%= j %>">
          <option style="background-color: red; color: red" value="red" <% If rss("ChinaQJ_VoteColor")="red" Then %>selected<% End If %>>默认</option>
          <option style="background-color: 000000; color: 000000" value="000000" <% If rss("ChinaQJ_VoteColor")="000000" Then %>selected<% End If %>>黑色</option>
          <option style="background-color: 0088FF; color: 0088FF" value="0088FF" <% If rss("ChinaQJ_VoteColor")="0088FF" Then %>selected<% End If %>>海蓝</option>
          <option style="background-color: 0000FF; color: 0000FF" value="0000FF" <% If rss("ChinaQJ_VoteColor")="0000FF" Then %>selected<% End If %>>亮蓝</option>
          <option style="background-color: 000088; color: 000088" value="000088" <% If rss("ChinaQJ_VoteColor")="000088" Then %>selected<% End If %>>深蓝</option>
          <option style="background-color: 888800; color: 888800" value="888800" <% If rss("ChinaQJ_VoteColor")="888800" Then %>selected<% End If %>>黄绿</option>
          <option style="background-color: 008888; color: 008888" value="008888" <% If rss("ChinaQJ_VoteColor")="008888" Then %>selected<% End If %>>蓝绿</option>
          <option style="background-color: 008800; color: 008800" value="008800" <% If rss("ChinaQJ_VoteColor")="008800" Then %>selected<% End If %>>橄榄</option>
          <option style="background-color: 8888FF; color: 8888FF" value="8888FF" <% If rss("ChinaQJ_VoteColor")="8888FF" Then %>selected<% End If %>>淡紫</option>
          <option style="background-color: AA00CC; color: AA00CC" value="AA00CC" <% If rss("ChinaQJ_VoteColor")="AA00CC" Then %>selected<% End If %>>紫色</option>
          <option style="background-color: 8800FF; color: 8800FF" value="8800FF" <% If rss("ChinaQJ_VoteColor")="8800FF" Then %>selected<% End If %>>蓝紫</option>
          <option style="background-color: 888888; color: 888888" value="888888" <% If rss("ChinaQJ_VoteColor")="888888" Then %>selected<% End If %>>灰色</option>
          <option style="background-color: CCAA00; color: CCAA00" value="CCAA00" <% If rss("ChinaQJ_VoteColor")="CCAA00" Then %>selected<% End If %>>土黄</option>
          <option style="background-color: FF8800; color: FF8800" value="FF8800" <% If rss("ChinaQJ_VoteColor")="FF8800" Then %>selected<% End If %>>金黄</option>
          <option style="background-color: CC3366; color: CC3366" value="CC3366" <% If rss("ChinaQJ_VoteColor")="CC3366" Then %>selected<% End If %>>暗红</option>
          <option style="background-color: FF00FF; color: FF00FF" value="FF00FF" <% If rss("ChinaQJ_VoteColor")="FF00FF" Then %>selected<% End If %>>紫红</option>
          <option style="background-color: 3366CC; color: 3366CC" value="3366CC" <% If rss("ChinaQJ_VoteColor")="3366CC" Then %>selected<% End If %>>蓝黑</option>
        </select>
        <br />
<%
rss.movenext
j=j+1
wend
rss.close
set rss=nothing
%>
    <tr>
      <td height="25" align="right" class="forumRow">再加几项：</td>
      <td class="forumRowHighlight"><input type="text" name="votecount" size="4" onBlur="setid();" value="0"></td>
    </tr>
    <tr valign="middle">
      <td align="right" class="forumRow">选项名称：</td>
      <td align="left" id="upid" class="forumRowHighlight"></td>
    </tr>
<%
else
%>
    <tr>
      <td height="25" align="right" class="forumRow">选项个数：</td>
      <td class="forumRowHighlight"><input type="text" name="votecount" size="4" onBlur="setid();" value="4"></td>
    </tr>
    
    <tr align="center" valign="middle">
      <td align="right" valign="top" class="forumRow">投票选项：</td>
      <td align="left" id="upid" class="forumRowHighlight"></td>
    </tr>
<%
End If
%>
      </td>
    </tr>
    <tr align="center" valign="middle">
      <td class="forumRow"></td>
      <td align="left" class="forumRowHighlight"><input name="Submit" type="submit" value="<%= paget %>项目"></td>

    </tr>
  </form>
</table>

<% else %>
<table class="tableBorder" width="95%" border="0" align="center" cellpadding="5" cellspacing="1">
  <tr align="center">
    <th width="8%">调用代码</th>
    <th height="25" align="left"><strong>投票主题</strong></th>
    <th width="10%"><strong>投票项管理</strong></th>
    <th width="12%"><strong>开始时间</strong></th>
    <th width="12%"><strong>结束时间</strong></th>
    <th width="10%"><strong>投票方式</strong></th>
    <th width="10%"><strong>投票状态</strong></th>
    <th width="10%"><strong>编辑</strong></th>
  </tr>
<%
sql="select * from ChinaQJ_Vote where ChinaQJ_VoteClass=0"
set rs=server.createobject("adodb.recordset")
rs.open sql,conn,1,1
if rs.eof and rs.bof then
Response.Write("")
else
while(not rs.eof)
%>
  <tr height="25">
    <td onclick='show("daima<%= rs("ChinaQJ_Voteid") %>")' style="cursor: pointer;" class="centerrow">获取代码</td>
    <td class="leftrow"><%= rs("ChinaQJ_VoteTitle") %></td>
    <td onclick='show("<%= rs("ChinaQJ_Voteid") %>")' style="cursor: pointer;" class="centerrow">显示投票项</td>
    <td class="centerrow"><%= rs("ChinaQJ_VoteStart") %> 0:00:00</td>
    <td class="centerrow"><%= rs("ChinaQJ_VoteEnd") %> 0:00:00</td>
    <td class="centerrow">单选投票</td>
    <td class="centerrow">
<% If rs("ChinaQJ_Voteing")=1 Then %>
投票进行中
<% Else %>
投票结束
<% End If %>
</td>
    <td class="centerrow"><a href="Admin_Vote.Asp?action=Modify&id=<%= rs("ChinaQJ_Voteid") %>">修改</a> <a href="Admin_Vote.Asp?action=Del&id=<%= rs("ChinaQJ_Voteid") %>">删除</a></td>
  </tr>
  <tr style="display: none;" id="<%= rs("ChinaQJ_Voteid") %>">
    <td height="25" colspan="8" class="leftrow"><table class="tableBorder" width="50%" border="0" align="center" cellpadding="5" cellspacing="1">
        <tr>
          <th align="left">项目标题</th>
          <th>投票数量</th>
          <th>操作</th>
        </tr>
<%
sqlv="select * from ChinaQJ_Vote where ChinaQJ_VoteClass="&rs("ChinaQJ_Voteid")&""
set rsv=server.createobject("adodb.recordset")
rsv.open sqlv,conn,1,1
if rsv.eof and rsv.bof then
Response.Write("没有投票项目")
else
while(not rsv.eof)
%>
        <tr>
          <td class="leftrow"><%= rsv("ChinaQJ_VoteTitle") %></td>
          <td width="20%" class="centerrow"><%= rsv("ChinaQJ_VoteCount") %></td>
          <td width="25%" class="centerrow"><a href="Admin_Vote.Asp?action=VoteDel&Voteid=<%= rsv("ChinaQJ_Voteid") %>">删除该选项</a></td>
        </tr>
<%
rsv.movenext
wend
end if
rsv.close
set rsv=nothing
%>
      </table></td>
  </tr>
  <tr id="daima<%= rs("ChinaQJ_Voteid") %>" style="display: none">
    <td colspan="8" class="centerrow"><input type="text" value="<script language='javascript' src='ShowVote.Asp?ChinaQJ_Voteid=<%= rs("ChinaQJ_Voteid") %>'></script>" style="width: 60%">
      <br />
      <center><font color="#CC0000">将调用代码插入到前台任意位置，将显示您设置的投票项目。</font></center></td>
  </tr>
<%
rs.movenext
wend
end if
rs.close
set rs=nothing
%>

</table>
<% End If %>
<script language="javascript">setid();</script>