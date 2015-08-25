<!--#include file="../Include/Const.asp" -->
<!--#include file="../Include/ConnSiteData.asp" -->
<%  '多语言循环保存数据
set rsl = server.createobject("adodb.recordset")
sqll="select * from ChinaQJ_Language order by ChinaQJ_Language_Order"
rsl.open sqll,conn,1,1
while(not rsl.eof)
Language_File=rsl("ChinaQJ_Language_File")

sql="alter table ChinaQJ_Template add CSS"&Language_File&" text, Index"&Language_File&" text, Header"&Language_File&" text, Footer"&Language_File&" text, Left"&Language_File&" text default 备用模板, Right"&Language_File&" text default 备用模板, ProductList"&Language_File&" text, ProductView"&Language_File&" text, ProductBuy"&Language_File&" text, NewsList"&Language_File&" text, NewsView"&Language_File&" text, DownList"&Language_File&" text, DownView"&Language_File&" text, OtherList"&Language_File&" text, OtherView"&Language_File&" text, JobsList"&Language_File&" text, JobsView"&Language_File&" text, TalentWrite"&Language_File&" text, NetWork"&Language_File&" text, Net"&Language_File&" text, MessageList"&Language_File&" text, MessageWrite"&Language_File&" text, MemberCenter"&Language_File&" text, MemberRegister"&Language_File&" text, MemberGetPass"&Language_File&" text, MemberInfo"&Language_File&" text, MemberMessage"&Language_File&" text, MemberOrder"&Language_File&" text, MemberTalent"&Language_File&" text, About"&Language_File&" text, Company"&Language_File&" text, Advisory"&Language_File&" text, Search"&Language_File&" text, VoteShow"&Language_File&" text, Bak1"&Language_File&" text default 备用模板, Bak2"&Language_File&" text default 备用模板, Bak3"&Language_File&" text default 备用模板, Bak4"&Language_File&" text default 备用模板, Bak5"&Language_File&" text default 备用模板, Bak6"&Language_File&" text default 备用模板, Bak7"&Language_File&" text default 备用模板, Bak8"&Language_File&" text default 备用模板, Bak9"&Language_File&" text default 备用模板, Bak10"&Language_File&" text default 备用模板"
conn.execute(sql)

rsl.movenext
wend
rsl.close
set rsl=nothing
Response.Write("操作成功")
%>