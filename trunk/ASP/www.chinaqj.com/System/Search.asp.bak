<!--#include file="../Include/Const.asp" -->
<!--#include file="../Include/ConnSiteData.asp" -->
<!--#include file="CheckAdmin.asp"-->
<%
dim Result
Result=request.QueryString("Result")
dim Keyword
Keyword=request.form("Keyword")
select case Result
  case "Members"
    response.redirect ("MemList.asp?Result=Search&Keyword="&server.urlencode(Keyword)&"&Page=1")
  case "News"
    response.redirect ("NewsList.asp?Result=Search&Keyword="&server.urlencode(Keyword)&"&Page=1")
  case "UserMessage"
    response.redirect ("UserMessage.asp?Result=Search&Keyword="&server.urlencode(Keyword)&"&Page=1")
  case "Download"
    response.redirect ("DownList.asp?Result=Search&Keyword="&server.urlencode(Keyword)&"&Page=1")
  case "Products"
    response.redirect ("ProductList.asp?Result=Search&Keyword="&server.urlencode(Keyword)&"&Page=1")
  case "Jobs"
    response.redirect ("JobsList.asp?Result=Search&Keyword="&server.urlencode(Keyword)&"&Page=1")
  case "Message"
    response.redirect ("MessageList.asp?Result=Search&Keyword="&server.urlencode(Keyword)&"&Page=1")
  case "Order"
    response.redirect ("OrderList.asp?Result=Search&Keyword="&server.urlencode(Keyword)&"&Page=1")
  case "Talents"
    response.redirect ("TalentsList.asp?Result=Search&Keyword="&server.urlencode(Keyword)&"&Page=1")
  case "Others"
    response.redirect ("OthersList.asp?Result=Search&Keyword="&server.urlencode(Keyword)&"&Page=1")
  case "Image"
    response.redirect ("ImageList.asp?Result=Search&Keyword="&server.urlencode(Keyword)&"&Page=1")
  case "Magazine"
    response.redirect ("MagazineList.asp?Result=Search&Keyword="&server.urlencode(Keyword)&"&Page=1")
  case "Key"
    response.redirect ("KeyList.asp?Result=Search&Keyword="&server.urlencode(Keyword)&"&Page=1")
  case else
end select
%>