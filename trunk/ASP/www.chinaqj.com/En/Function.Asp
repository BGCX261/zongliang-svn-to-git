<!--#include file="Language.Asp" -->
<%
function ChinaQJHeadNavigation()
  dim rs,sql
  set rs = server.createobject("adodb.recordset")
  sql="select top 10 * from ChinaQJ_Navigation where "&ViewFlag&" and ParentID=0 order by Sequence asc"
  rs.open sql,conn,1,1
  if rs.bof and rs.eof then
    response.write ChinaQJLanguageTxt7
  else
  Response.Write"<ul>"&VbCrLf
    Do
	if menuname=rs("NavNamech") then
	menuclass="class=hotmenu"
	hotclass="class=blacktext"
	else
	menuclass=""
	hotclass=""
	end if
        If ISHTML = 1 Then
        response.write "<li "&menuclass&"><a href="""&Replace(rs("HtmlNavUrl"),"Lan=","Lan="&Language&"")&""" title="""&rs("NavName"&Language)&"""><span "&hotclass&">"&rs("NavName"&Language)&"</span></a></li>"&VbCrLf
        Else
        response.write "<li "&menuclass&"><a href="""&Replace(rs("NavUrl"),"Lan=","Lan="&Language&"")&""" title="""&rs("NavName"&Language)&"""><span "&hotclass&">"&rs("NavName"&Language)&"</span></a></li>"&VbCrLf
        End If
      rs.movenext
    loop until rs.eof
  Response.Write"</ul>"&VbCrLf
  end if
  rs.close
  set rs=nothing
end Function

function ChinaQJHeadNavigationfoot()
  dim rs,sql
  set rs = server.createobject("adodb.recordset")
  sql="select * from ChinaQJ_Navigation where "&ViewFlag&" and ParentID=0 order by Sequence asc"
  rs.open sql,conn,1,1
  if rs.bof and rs.eof then
    response.write ChinaQJLanguageTxt7
  else
    Response.Write"<ul>"&VbCrLf
	i=1
    Do
	if menuname=rs("NavNamech") then
	menuclass="class=hotmenu"
	hotclass="class=blacktext"
	else
	menuclass=""
	hotclass=""
	end if
        If ISHTML = 1 Then
		if i<>1 then Response.Write "&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;"&VbCrLf
        response.write "<a href="""&Replace(rs("HtmlNavUrl"),"Lan=","Lan="&Language&"")&""" title="""&rs("NavName"&Language)&"""><span "&hotclass&">"&rs("NavName"&Language)&"</span></a>"&VbCrLf
        Else
		if i<>1 then Response.Write "&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;"&VbCrLf
        response.write "<a href="""&Replace(rs("NavUrl"),"Lan=","Lan="&Language&"")&""" title="""&rs("NavName"&Language)&"""><span "&hotclass&">"&rs("NavName"&Language)&"</span></a>"&VbCrLf
        End If
      rs.movenext
	  i=i+1
    loop until rs.eof
  Response.Write"</ul>"&VbCrLf
  end if
  rs.close
  set rs=nothing
end Function

function ChinaQJSink03news(topmun)
  dim rs,sql,NewsName,NewFlag
  set rs = server.createobject("adodb.recordset")
  If IsDatabaseType = 1 Then
    sql="select top "&topmun&" * from ChinaQJ_News where "&ViewFlag&" order by Sequence desc,ID desc"
  Else
    sql="select top "&topmun&" * from ChinaQJ_News where "&ViewFlag&" order by Sequence desc,ID desc"
  End If
  rs.open sql,conn,1,1
  if rs.eof then
    Response.Write ChinaQJLanguageTxt7
  else
    do while not rs.eof
        NewsName=StrLeft(rs("NewsName"&Language),35)
        If ISHTML = 1 Then
            AutoLink = ""&rs("ClassSeo")&""&Separated&""&rs("ID")&"."&HTMLName&""
        Else
            AutoLink = "NewsView.Asp?ID="&rs("id")&""
        End If
		Response.Write "<a href="""&SysRootDir&AutoLink&"""><font color="""&rs("TitleColor")&""">"&NewsName&"</font></a>&nbsp;&nbsp;|&nbsp;&nbsp;"&VbCrLf
      rs.movenext
    loop
  end if
  rs.close
  set rs=nothing
end Function

Function ChinaQJIndexaboutus()
set rs = server.createobject("adodb.recordset")
sql="select top 1 * from ChinaQJ_Site"
rs.open sql,conn,1,1
content=rs("SiteDetail"&Language)
SiteDetailPic=rs("SiteDetailPic")
rs.close
set rs=nothing
Response.Write "<img src="""&SiteDetailPic&""" width=""260"" height=""170"" hspace=""10"" vspace=""10"" align=""left""/>"
Response.Write(content)
end Function

Function ChinaQJIndexaboutuskin05(aboutcount)
set rs = server.createobject("adodb.recordset")
sql="select top 1 * from ChinaQJ_Site"
rs.open sql,conn,1,1
content=rs("SiteDetail"&Language)
SiteDetailPic=rs("SiteDetailPic")
rs.close
set rs=nothing
Response.Write "<table width=""580"" height=""210"" border=""0"" align=""center"" cellpadding=""0"" cellspacing=""0"" class=""c_about"">"&VbCrLf
Response.Write "  <tr>"&VbCrLf
Response.Write "    <td width=""170""  align=""center"" valign=""middle"" class=""c_about_tb"" ><img src="""&SiteDetailPic&""" width=""150"" height=""180"" border=""0"" /></td>"&VbCrLf
Response.Write "    <td align=""left"" valign=""middle"" class=""c_about_tb c_about_lr"">"&left(content,aboutcount)&"...</td>"&VbCrLf
Response.Write "  </tr>"&VbCrLf
Response.Write "</table>"&VbCrLf
end Function

Function ChinaQJIndexNotice()
If IndexNotice = 1 Then
    Response.Write "<div id=""winbg""></div>"&VbCrLf
    Response.Write "<div id=""win"">"&VbCrLf
    Response.Write "  <table width=""546"" border=""0"" cellspacing=""0"" cellpadding=""0"" id=""winbt"">"&VbCrLf
    Response.Write "    <tr>"&VbCrLf
    Response.Write "      <td width=""520"" height=""30"" style=""color: #FFFFFF; font-weight: bold;"">&nbsp;"&SiteTitle&""&ChinaQJLanguageTxt262&"</td>"&VbCrLf
    Response.Write "      <td width=""26"" height=""30""><img src="""&StylePath&"win_close1.gif"" width=""13"" height=""13"" style=""cursor: pointer; position: relative;"" alt="""&ChinaQJLanguageTxt263&""" onclick=""hid=setInterval(proHid,10);"" /></td>"&VbCrLf
    Response.Write "    </tr>"&VbCrLf
    Response.Write "  </table>"&VbCrLf
    Response.Write "  <div id=""wincon"" class=""scroll"" style=""overflow:hidden;"">"&VbCrLf
    Response.Write "    <p><img src="""&SiteIndexNotice&""" width=""522"" height=""283"" border=""0""></p>"&VbCrLf
    Response.Write "  </div>"&VbCrLf
    Response.Write "  <div id=""winclose""><img src="""&StylePath&"win_close2.gif"" border=""0"" style=""margin-top: 5px; cursor: pointer;"" alt="""&ChinaQJLanguageTxt263&""" onclick=""hid=setInterval(proHid,10);"" /></div>"&VbCrLf
    Response.Write "</div>"&VbCrLf
    Response.Write "<script type=""text/javascript"" src=""" & SysRootDir & "Scripts/pop.js""></script>"&VbCrLf
    Response.Write "<script type=""text/javascript"">window.onload=function(){setTimeout(cp,1000);}</script>"&VbCrLf
    Response.Write "<script type=""text/javascript"">setTimeout(function(){hid=setInterval(proHid,10);},10000)</script>"&VbCrLf
End If
End Function

Function ChinaQJJMailDisplay()
    If JMailDisplay = 1 Then
        Response.Write "<script type=""text/javascript"" src=""" & SysRootDir & "scripts/Message.js"" charset=""gb2312""></script>"&VbCrLf
    End If
End Function

Function ChinaQJSlide()
    Response.Write "  <div class=""accord_top"">"&VbCrLf
    Response.Write "    <div id=""feature_wrap"">"&VbCrLf
    Response.Write "      <div id=""featured"">"&VbCrLf
sql="select top 5 * from ChinaQJ_Flash where ShowType='Slide'"
set rs=server.createobject("adodb.recordset")
rs.open sql,conn,1,1
if rs.eof and rs.bof then
Response.Write("")
else
i=1
while(not rs.eof)
    Response.Write "        <div class=""featured featured"&i&"""><a href="""&rs("flashlink")&"""><img src="""&rs("FlashPic")&""" alt="""&rs("flashtext")&""" border=""0""/></a></div>"&VbCrLf
rs.movenext
i=i+1
wend
end if
rs.close
set rs=nothing
    Response.Write "      </div>"&VbCrLf
    Response.Write "    </div>"&VbCrLf
    Response.Write "  </div>"&VbCrLf
End Function

Function ChinaQJSlide2(SWidth,SHeight)
    Response.Write "<object id=""Slide"" data=""../Scripts/Slide.swf?xml=../Scripts/Slide.xml"" type=""application/x-shockwave-flash"" width="""&SWidth&""" height="""&SHeight&""">"&VbCrLf
    Response.Write "    <param name=""movie"" value=""../Scripts/Slide.swf?xml=../Scripts/Slide.xml"" />"&VbCrLf
    Response.Write "    <param name=""wmode"" value=""transparent"" />"&VbCrLf
    Response.Write "</object>"&VbCrLf
End Function

Function ChinaQJimagerotator(SWidth, SHeight)
    Response.Write "<div ID=""FlashColorful"">不支持Flash</div>" & vbCrLf
    Response.Write "<script type=""text/javascript"" src=""" & SysRootDir & "Scripts/imagerotator.js""></script>" & vbCrLf
    Response.Write "<script type=""text/javascript"">" & vbCrLf
    Response.Write "var s1 = new SWFObject(""" & SysRootDir & "Scripts/imagerotator.swf"",""rotator"",""" & SWidth & """,""" & SHeight & """,""7"");" & vbCrLf
    Response.Write "s1.addParam(""wmode"", ""transparent"");" & vbCrLf
    Response.Write "s1.addParam(""quality"", ""high"");" & vbCrLf
    Response.Write "s1.addVariable(""file"",""" & SysRootDir & "Scripts/imagerotator.xml"");" & vbCrLf
    Response.Write "s1.addVariable(""transition"",""random"");" & vbCrLf
    Response.Write "s1.addVariable(""overstretch"",""true"");" & vbCrLf
    Response.Write "s1.addVariable(""shownavigation"",""true"");" & vbCrLf
    Response.Write "s1.addVariable(""shuffle"",""false"");" & vbCrLf
    Response.Write "s1.addVariable(""width"",""" & SWidth & """);" & vbCrLf
    Response.Write "s1.addVariable(""height"",""" & SHeight & """);" & vbCrLf
    Response.Write "s1.write(""FlashColorful"");" & vbCrLf
    Response.Write "</script>" & vbCrLf
End Function

function ChinaQJOthers(SortPath,topmun,trimstr)
  dim rs,sql
  set rs = server.createobject("adodb.recordset")
  If IsDatabaseType = 1 Then
    sql="select top "&topmun&" * from ChinaQJ_Others where "&ViewFlag&" and Charindex('"&SortPath&"',SortPath) > 0 order by id desc"
  Else
    sql="select top "&topmun&" * from ChinaQJ_Others where "&ViewFlag&" and Instr(SortPath,'"&SortPath&"') > 0 order by id desc"
  End If
  rs.open sql,conn,1,1
  if rs.eof then
    Response.Write ""&ChinaQJLanguageTxt7&""&VbCrLf
  else
    do while not rs.eof
        If ISHTML = 1 Then
            AutoLink = ""&rs("ClassSeo")&""&Separated&""&rs("ID")&"."&HTMLName&""
        Else
            AutoLink = "OtherView.Asp?ID="&rs("ID")&""
        End If
        Response.Write "<img src="""&StylePath&"arr5.gif"" align=""absmiddle"" /> <a href="""&AutoLink&""" title="""&rs("OthersName"&Language)&""" target=""_blank""><font color="""&rs("TitleColor")&""">"&StrLeft(rs("OthersName"&Language),trimstr)&"</font></a><br>"&VbCrLf
      rs.movenext
    loop
  end if
  rs.close
  set rs=nothing
end Function

function ChinaQJIndexNewskin02()
  dim rs,sql
  set rs = server.createobject("adodb.recordset")
  If IsDatabaseType = 1 Then
    sql="select top 1 * from ChinaQJ_News where "&ViewFlag&" order by AddTime desc,ID desc"
  Else
    sql="select top 1 * from ChinaQJ_News where "&ViewFlag&" and NoticeFlag order by AddTime desc,ID desc"
  End If
  rs.open sql,conn,1,1
  if rs.eof then
    Response.Write ""&ChinaQJLanguageTxt7&""&VbCrLf
  else
    do while not rs.eof
        If ISHTML = 1 Then
            AutoLink = ""&rs("ClassSeo")&""&Separated&""&rs("ID")&"."&HTMLName&""
        Else
            AutoLink = "NewsView.Asp?ID="&rs("id")&""
        End If
        Response.Write "<a href="""&AutoLink&"""><font color=""#000000"">"&rs("NewsName"&Language)&"</font></a>"&VbCrLf
      rs.movenext
    loop
  end if
  rs.close
  set rs=nothing
end Function

function ChinaQJIndexNews(SortPath,topmun,trimstr)
  dim rs,sql,NewsName,NewFlag
  set rs = server.createobject("adodb.recordset")
  If IsDatabaseType = 1 Then
    sql="select top "&topmun&" * from ChinaQJ_News where "&ViewFlag&" and Charindex('"&SortPath&"',SortPath) > 0 order by Sequence desc,ID desc"
  Else
    sql="select top "&topmun&" * from ChinaQJ_News where "&ViewFlag&" and Instr(SortPath,'"&SortPath&"') > 0 order by NoticeFlag asc,id desc"
  End If
  rs.open sql,conn,1,1
  if rs.eof then
    Response.Write ChinaQJLanguageTxt7
  else
    do while not rs.eof
      if now()-rs("AddTime")<=2 then
        NewsName=StrLeft(rs("NewsName"&Language),trimstr)
        NewFlag=" <img src="""&StylePath&"new.gif"" align=""absmiddle"">"
      else
        NewsName=StrLeft(rs("NewsName"&Language),trimstr)
        NewFlag=""
      end If
        If ISHTML = 1 Then
            AutoLink = ""&SysRootDir&Language&"/"&rs("ClassSeo")&""&Separated&""&rs("ID")&"."&HTMLName&""
        Else
            AutoLink = ""&SysRootDir&Language&"/NewsView.Asp?ID="&rs("id")&""
        End If
		Response.Write "<table width=""100%"" border=""0"" cellspacing=""0"" cellpadding=""0""><tr>"&VbCrLf
        Response.Write "<td style=""background: url("&StylePath&"bg5.gif) repeat-x left bottom;"" height=""25"">"&VbCrLf
		Response.Write "<img src="""&StylePath&"arr2.gif"" align=""absmiddle"" />&nbsp;&nbsp;<a href="""&AutoLink&""" title="""&rs("NewsName"&Language)&""" target=""_blank""><font color="""&rs("TitleColor")&""">"&NewsName&"</font></a></td>"&VbCrLf
		Response.Write "<td style=""font-size: 11px; color: #999999; background: url("&StylePath&"bg5.gif) repeat-x left bottom;"" align=""right""><img src="""&StylePath&"clock.gif"" width=""7"" height=""7"" align=""absmiddle"" />&nbsp;&nbsp;"&FormatDate(rs("Addtime"),13)&"</td>"&VbCrLf
		Response.Write "</tr></table>"&VbCrLf
      rs.movenext
    loop
  end if
  rs.close
  set rs=nothing
end Function

function ChinaQJIndexNewsg(SortPath,topmun,trimstr)
  dim rs,sql,NewsName,NewFlag
  set rs = server.createobject("adodb.recordset")
  If IsDatabaseType = 1 Then
    sql="select top "&topmun&" * from ChinaQJ_News where "&ViewFlag&" and Charindex('"&SortPath&"',SortPath) > 0 order by Sequence desc,ID desc"
  Else
    sql="select top "&topmun&" * from ChinaQJ_News where "&ViewFlag&" and Instr(SortPath,'"&SortPath&"') > 0 order by Sequence desc,ID desc"
  End If
  rs.open sql,conn,1,1
  if rs.eof then
    Response.Write ChinaQJLanguageTxt7
  else
    do while not rs.eof
      if now()-rs("AddTime")<=2 then
        NewsName=StrLeft(rs("NewsName"&Language),trimstr)
        NewFlag=" <img src="""&StylePath&"new.gif"" align=""absmiddle"">"
      else
        NewsName=StrLeft(rs("NewsName"&Language),trimstr)
        NewFlag=""
      end If
        If ISHTML = 1 Then
            AutoLink = ""&rs("ClassSeo")&""&Separated&""&rs("ID")&"."&HTMLName&""
        Else
            AutoLink = "NewsView.Asp?ID="&rs("id")&""
        End If
		Response.Write "<table width=""100%"" border=""0"" cellspacing=""0"" cellpadding=""0""><tr>"&VbCrLf
        Response.Write "<td style=""background: url("&StylePath&"bg5.gif) repeat-x left bottom;"" height=""25"">"&VbCrLf
		Response.Write "<img src="""&StylePath&"arr2.gif"" width=""3"" height=""5"" align=""absmiddle"" />&nbsp;&nbsp;<a href="""&AutoLink&"""><font color="""&rs("TitleColor")&""">"&NewsName&"</font></a></td>"&VbCrLf
		Response.Write "</tr></table>"&VbCrLf
      rs.movenext
    loop
  end if
  rs.close
  set rs=nothing
end Function


Function ChinaQJIndexProducts(SortPath,trs,tds,PicW,PicH,XZ)
  dim rs,sql,tr,td,ProductName,SmallPicPath
  set rs = server.createobject("adodb.recordset")
  If XZ = 1 Then
    sql="select top "&trs*tds&" * from ChinaQJ_Products where "&ViewFlag&" order by UpdateTime desc,Sequence desc,ID desc"
  ElseIf XZ = 2 Then
    sql="select top "&trs*tds&" * from ChinaQJ_Products where "&ViewFlag&" and CommendFlagEn order by UpdateTime desc,Sequence desc,ID desc"
  ElseIf XZ = 3 Then
    sql="select top "&trs*tds&" * from ChinaQJ_Products where "&ViewFlag&" and NewFlagEn order by UpdateTime desc,Sequence desc,ID desc"
  Else
    sql="select top "&trs*tds&" * from ChinaQJ_Products where "&ViewFlag&" order by UpdateTime desc,Sequence desc,ID desc"
  End If
  rs.open sql,conn,1,1
  if rs.eof then
    response.write ChinaQJLanguageTxt7
  else
    Response.Write "<table cellpadding=""2"" cellspacing=""0"" align=""center"" width=""100%"">"&VbCrLf
    for tr=1 to trs
        Response.Write "  <tr>"&VbCrLf
        for td=1 to tds
          if StrLen(rs("ProductName"&Language))<=20 then
            ProductName=rs("ProductName"&Language)
          else
            ProductName=StrLeft(rs("ProductName"&Language),20)
          end If
            If ISHTML = 1 Then
                AutoLink = ""&SysRootDir&Language&"/"&rs("ClassSeo")&""&Separated&""&rs("ID")&"."&HTMLName&""
            Else
                AutoLink = ""&SysRootDir&Language&"/ProductView.Asp?ID="&rs("id")&""
            End If
            SmallPicPath=HtmlSmallPic(rs("GroupID"),rs("SmallPic"),rs("Exclusive"))
            Response.Write "    <td><table cellpadding=""2"" cellspacing=""0"" width=""100%"">"&VbCrLf
            Response.Write "        <tr>"&VbCrLf
			if SysRootDir<>"/" then
            Response.Write "          <td align=""center""><a href="""&AutoLink&""" title="""&rs("ProductName"&Language)&""" target=""_blank""><img src="""&SysRootDir&SmallPicPath&""" alt="""&rs("ProductName"&Language)&""" width="""&PicW&""" height="""&PicH&""" border=""0"" style=""padding: 3px; border: 1px solid #ccc"" /></a></td>"&VbCrLf
			else
            Response.Write "          <td align=""center""><a href="""&AutoLink&""" title="""&rs("ProductName"&Language)&""" target=""_blank""><img src="""&SmallPicPath&""" alt="""&rs("ProductName"&Language)&""" width="""&PicW&""" height="""&PicH&""" border=""0"" style=""padding: 3px; border: 1px solid #ccc"" /></a></td>"&VbCrLf
			end if
            Response.Write "        </tr>"&VbCrLf
            Response.Write "        <tr>"&VbCrLf
            Response.Write "          <td style=""height:30px; text-align:center;""><a href="""&AutoLink&""" title="""&rs("ProductName"&Language)&"""><font color="""&rs("TitleColor")&""">"&ProductName&"</font></a> </td>"&VbCrLf
            Response.Write "        </tr>"&VbCrLf
            Response.Write "      </table></td>"&VbCrLf
          rs.movenext
          if rs.eof then exit for
        next
        Response.Write "  </tr>"&VbCrLf
        if rs.eof then exit for
    next
    Response.Write "</table>"&VbCrLf
  end if
  rs.close
  set rs=nothing
End Function

Function ChinaQJIndexImage(SortPath,trs,tds,PicW,PicH)
  dim rs,sql,tr,td,ProductName,SmallPicPath
  set rs = server.createobject("adodb.recordset")
  sql="select top "&trs*tds&" * from ChinaQJ_Image where "&ViewFlag&" order by Sequence desc,ID desc"
  rs.open sql,conn,1,1
  if rs.eof then
    response.write ChinaQJLanguageTxt7
  else
    Response.Write "<table cellpadding=""0"" cellspacing=""0"" align=""center"" width=""100%"">"&VbCrLf
    for tr=1 to trs
        Response.Write "  <tr>"&VbCrLf
        for td=1 to tds
          if StrLen(rs("ImageName"&Language))<=20 then
            ProductName=rs("ImageName"&Language)
          else
            ProductName=StrLeft(rs("ImageName"&Language),20)
          end If
            If ISHTML = 1 Then
                AutoLink = ""&rs("ClassSeo")&""&Separated&""&rs("ID")&"."&HTMLName&""
            Else
                AutoLink = "ImageView.Asp?ID="&rs("id")&""
            End If
            Response.Write "    <td><table cellpadding=""0"" cellspacing=""0"" width=""100%"">"&VbCrLf
            Response.Write "        <tr>"&VbCrLf
            Response.Write "          <td align=""center""><a href="""&AutoLink&""" title="""&rs("ImageName"&Language)&""" target=""_blank""><img src="""&rs("ChinaQJPic")&""" alt="""&rs("ImageName"&Language)&""" width="""&PicW&""" height="""&PicH&""" border=""0"" style=""padding: 3px; border: 1px solid #ccc"" /></a></td>"&VbCrLf
            Response.Write "        </tr>"&VbCrLf
'            Response.Write "        <tr>"&VbCrLf
'            Response.Write "          <td style=""height:30px; text-align:center;""><a href="""&AutoLink&""" title="""&rs("ImageName"&Language)&"""><font color="""&rs("TitleColor")&""">"&ProductName&"</font></a> </td>"&VbCrLf
'            Response.Write "        </tr>"&VbCrLf
            Response.Write "      </table></td>"&VbCrLf
          rs.movenext
          if rs.eof then exit for
        next
        Response.Write "  </tr>"&VbCrLf
        if rs.eof then exit for
    next
    Response.Write "</table>"&VbCrLf
  end if
  rs.close
  set rs=nothing
End Function

Function ChinaQJIndexFriendLinks(trs,tds)
  dim rs,sql,tr,td,ProductName,SmallPicPath
  set rs = server.createobject("adodb.recordset")
  sql="select top "&trs*tds&" * from ChinaQJ_FriendLink where "&ViewFlag&" order by ID desc"
  rs.open sql,conn,1,1
  if rs.eof then
    Response.write "<center>"&ChinaQJLanguageTxt7&"</center>"
  else
    Response.Write "<table cellpadding=""0"" cellspacing=""0"" width=""100%"">"&VbCrLf
    for tr=1 to trs
        Response.Write "  <tr>"&VbCrLf
        for td=1 to tds
          if StrLen(rs("LinkName"&Language))<=18 then
            LinkFace=rs("LinkName"&Language)
          else
            LinkFace=StrLeft(rs("LinkName"&Language),16)
          end if
            Response.Write "    <td><table cellpadding=""2"" cellspacing=""0"">"&VbCrLf
            Response.Write "        <tr>"&VbCrLf
            Response.Write "          <td align=""center"" height=""18"">"
            If rs("LinkType") = 0 Then
            Response.Write "<a href="""&rs("LinkUrl")&""" title="""&rs("LinkName"&Language)&""">"&LinkFace&"</a>"
            Else
            Response.Write "<a href="""&rs("LinkUrl")&""" target=""_blank""><img src="""&rs("LinkFace"&Language)&""" alt="""&rs("LinkName"&Language)&""" width=""88"" height=""31"" border=""0"" /></a>"
            End If
            Response.Write "</td>"&VbCrLf
            Response.Write "        </tr>"&VbCrLf
            Response.Write "      </table></td>"&VbCrLf
            Response.Write "    <td width=""8""></td>"&VbCrLf
          rs.movenext
          if rs.eof then exit for
        next
        Response.Write "  </tr>"&VbCrLf
        if rs.eof then exit for
    next
    Response.Write "</table>"&VbCrLf
  end if
  rs.close
  set rs=nothing
End Function

Function ChinaQJIndexSelPlay(strUrl,strWidth,StrHeight)
    Dim Exts,isExt
    If strUrl <> "" Then
       isExt = LCase(Mid(strUrl,InStrRev(strUrl, ".")+1))
    Else
       isExt = ""
    End If
    Exts = "mp3,avi,wmv,asf,mov,rm,ra,ram,rmvb,swf,flv"
    If Instr(Exts,isExt) = 0 Then
     Response.write "<center>"&ChinaQJLanguageTxt32&"</center>"
    Else
     Select Case isExt
      Case "mp3","avi","wmv","asf","mov"
        Response.write "<embed id=""MediaPlayer"" src="""&strUrl&""" width="""&strWidth&""" height="""&strHeight&""" loop=""0"" autostart=""false""></embed>"
      Case "mov","rm","ra","ram","rmvb"
        Response.Write "<object classid=""clsid:cfcdaa03-8be4-11cf-b84b-0020afbbccfa"" id=""video1"" width="""&strWidth&""" height="""&strHeight&""" viewastext>"&VbCrLf
        Response.Write "<param name=""_extentx"" value=""5503"">"&VbCrLf
        Response.Write "<param name=""_extenty"" value=""1588"">"&VbCrLf
        Response.Write "<param name=""autostart"" value=""false"">"&VbCrLf
        Response.Write "<param name=""shuffle"" value=""0"">"&VbCrLf
        Response.Write "<param name=""prefetch"" value=""0"">"&VbCrLf
        Response.Write "<param name=""nolabels"" value=""0"">"&VbCrLf
        Response.Write "<param name=""src"" value="""&strUrl&""">"&VbCrLf
        Response.Write "<param name=""controls"" value=""imagewindow,statusbar,controlpanel"">"&VbCrLf
        Response.Write "<param name=""console"" value=""raplayer"">"&VbCrLf
        Response.Write "<param name=""loop"" value=""0"">"&VbCrLf
        Response.Write "<param name=""numloop"" value=""0"">"&VbCrLf
        Response.Write "<param name=""center"" value=""0"">"&VbCrLf
        Response.Write "<param name=""maintainaspect"" value=""0"">"&VbCrLf
        Response.Write "<param name=""backgroundcolor"" value=""#000000"">"&VbCrLf
        Response.Write "</object>"&VbCrLf
      Case "swf"
        Response.Write "<object codeBase=""http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,19,0"" width="""&strWidth&""" height="""&strHeight&""" classid=""clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"">"&VbCrLf
        Response.Write "<param name=""_cx"" value=""19050"">"&VbCrLf
        Response.Write "<param name=""_cy"" value=""3863"">"&VbCrLf
        Response.Write "<param name=""FlashVars"" value="""">"&VbCrLf
        Response.Write "<param name=""Movie"" value="""&strUrl&""">"&VbCrLf
        Response.Write "<param name=""Src"" value="""&strUrl&""">"&VbCrLf
        Response.Write "<param name=""Play"" value=""-1"">"&VbCrLf
        Response.Write "<param name=""Loop"" value=""-1"">"&VbCrLf
        Response.Write "<param name=""Quality"" value=""High"">"&VbCrLf
        Response.Write "<param name=""SAlign"" value="""">"&VbCrLf
        Response.Write "<param name=""Menu"" value=""0"">"&VbCrLf
        Response.Write "<param name=""Base"" value="""">"&VbCrLf
        Response.Write "<param name=""AllowScriptAccess"" value="""">"&VbCrLf
        Response.Write "<param name=""Scale"" value=""ShowAll"">"&VbCrLf
        Response.Write "<param name=""DeviceFont"" value=""0"">"&VbCrLf
        Response.Write "<param name=""EmbedMovie"" value=""0"">"&VbCrLf
        Response.Write "<param name=""BGColor"" value="""">"&VbCrLf
        Response.Write "<param name=""SWRemote"" value="""">"&VbCrLf
        Response.Write "<param name=""MovieData"" value="""">"&VbCrLf
        Response.Write "<param name=""SeamlessTabbing"" value=""1"">"&VbCrLf
        Response.Write "<param name=""Profile"" value=""0"">"&VbCrLf
        Response.Write "<param name=""ProfileAddress"" value="""">"&VbCrLf
        Response.Write "<param name=""ProfilePort"" value=""0"">"&VbCrLf
        Response.Write "<param name=""wmode"" value=""transparent"">"&VbCrLf
        Response.Write "<embed src="""&strUrl&""" width="""&strWidth&""" height="""&strHeight&""" quality=""high"" pluginspage=""http://www.macromedia.com/go/getflashplayer"" type=""application/x-shockwave-flash"" menu=""false""></embed>"&VbCrLf
        Response.Write "</object>"&VbCrLf
      Case "flv"
	  Response.Write "<object type=""application/x-shockwave-flash"" data="""&SysRootDir&"Scripts/ChinaQJFlv.swf"" width="""&strWidth&""" height="""&strHeight&""" id=""ChinaQJFlv"">"&VbCrLf
	  Response.Write "<param name=""movie"" value="""&SysRootDir&"Scripts/ChinaQJFlv.swf""/>"&VbCrLf
	  Response.Write "<param name=""wmode"" value=""transparent"">"&VbCrLf
	  Response.Write "<param name=""allowFullScreen"" value=""true"" />"&VbCrLf
	  Response.Write "<param name=""FlashVars"" value=""xml="&VbCrLf
		Response.Write "			<vcastr>"&VbCrLf
		Response.Write "				<channel>"&VbCrLf
		dim strUrlmore,i
		strUrlmore=split(strUrl,"|")
		If Not(IsNull(strUrlmore)) Then
		for i=0 to ubound(strUrlmore)
		Response.Write "					<item>"&VbCrLf
		Response.Write "						<source>"&trim(strUrlmore(i))&"</source>"&VbCrLf
		Response.Write "						<duration></duration>"&VbCrLf
		Response.Write "						<title></title>"&VbCrLf
		Response.Write "					</item>"&VbCrLf
		next
		else
		Response.Write "					<item>"&VbCrLf
		Response.Write "						<source>"&strUrl&"</source>"&VbCrLf
		Response.Write "						<duration></duration>"&VbCrLf
		Response.Write "						<title></title>"&VbCrLf
		Response.Write "					</item>"&VbCrLf
		end if
		Response.Write "				</channel>"&VbCrLf
		Response.Write "				<config>"&VbCrLf
		Response.Write "				</config>"&VbCrLf
		Response.Write "				<plugIns>"&VbCrLf
		Response.Write "					<logoPlugIn>"&VbCrLf
		Response.Write "						<url>"&SysRootDir&"Scripts/logoPlugIn.swf</url>"&VbCrLf
		Response.Write "						<logoText></logoText>"&VbCrLf
		Response.Write "						<logoTextAlpha>0.8</logoTextAlpha>"&VbCrLf
		Response.Write "						<logoTextFontSize>12</logoTextFontSize>"&VbCrLf
		Response.Write "						<logoTextLink>http://www.chinaqj.com/</logoTextLink>"&VbCrLf
		Response.Write "						<logoTextColor>0xffffff</logoTextColor>"&VbCrLf
		Response.Write "						<textMargin>8 120 auto auto</textMargin>"&VbCrLf
		Response.Write "					</logoPlugIn>"&VbCrLf
		Response.Write "				</plugIns>"&VbCrLf
		Response.Write "			</vcastr>""/>"&VbCrLf
	Response.Write "</object>"
     End Select
    End If
End Function

Function ChinaQJIndexLeftNavigation(topmun)
  Dim rs,sql
  Set rs = server.createobject("adodb.recordset")
  sql="select top "&topmun&" * from ChinaQJ_Navigation where "&ViewFlag&" and "&IndexView&" order by Sequence asc"
  rs.open sql,conn,1,1
  If rs.bof And rs.eof Then
    response.write ChinaQJLanguageTxt7
  Else
    Do
        If ISHTML = 1 Then
        response.write " <a href="""&rs("HtmlNavUrl")&""" title="""&rs("NavName"&Language)&""">"&rs("NavName"&Language)&"</a>"
        Else
        response.write " <a href="""&rs("NavUrl")&""" title="""&rs("NavName"&Language)&""">"&rs("NavName"&Language)&"</a>"
        End If
      rs.movenext
    Loop Until rs.eof
  End If
  rs.close
  Set rs = Nothing
End Function

Function ChinaQJSearchCount(Count,TextCount,TextClass)
    set rs=server.createobject("adodb.recordset")
    sql="Select Top "&Count&" ChinaQJ_SearchName,ChinaQJ_Range From ChinaQJ_Search where searchlanguage='"&Language&"' Order By ChinaQJ_Hits Desc,ID Desc"
    rs.open sql,conn,1,1
    Do While Not rs.eof
    response.write "<a href="""&SysRootDir&Language&"/Search.Asp?Range="&rs("ChinaQJ_Range")&"&Keyword="&rs("ChinaQJ_SearchName")&"""><u>"&Left(rs("ChinaQJ_SearchName"),TextCount)&"</u></a> "
    rs.movenext
    Loop
    rs.close
    Set rs = Nothing
End Function

function ChinaQJTalentWebMenu()
  response.write "<a href=""JobsList.Asp"">"&ChinaQJLanguageTxt65&"</a>"
  response.write "<a href=""MemberTalent.Asp"">"&ChinaQJLanguageTxt84&"</a>"
end function

function TalentWriteWebLocation()
  TalentWriteWebLocation="&nbsp;"&ChinaQJLanguageTxt19&"：<a href=""Index.Asp"" class=""agray"">"&ChinaQJLanguageTxt20&"</a> - "&ChinaQJLanguageTxt218&""&VbCrLf
end Function

sub TalentWriteMemInfo()
  dim rs,sql
  set rs = server.createobject("adodb.recordset")
  sql="select * from ChinaQJ_Members where MemName='"&session("MemName")&"'"
  rs.open sql,conn,1,1
  if rs.bof and rs.eof then
    response.write "<center>"&ChinaQJLanguageTxt7&"</center>"
  else
    mMemID=rs("ID")
    if not rs("RealName")="" then
      mLinkman=rs("RealName")
    else
      mLinkman=rs("MemName")
    end if
    mSex=rs("Sex")
    mAddress=rs("Address")
    mZipCode=rs("ZipCode")
    mTelephone=rs("Telephone")
    mMobile=rs("Mobile")
    mEmail=rs("Email")
  end if
  rs.close
  set rs=nothing
end Sub

Function ChinaQJProductIndexFolder(id)
  Dim rs,sql,i,ChildCount,FolderType,FolderName,onMouseUp,ListType
  Set rs=server.CreateObject("adodb.recordset")
  sql="Select * From ChinaQJ_ProductSort where "&ViewFlag&" And ParentID="&id&" order by Sequence asc,ID desc"
  rs.open sql,conn,1,1
    if id=0 and rs.recordcount=0 then
        response.write "<center>"&ChinaQJLanguageTxt7&"</center>"
        exit function
    end if
  i=1
  while not rs.eof
    ChildCount=conn.execute("select count(*) from ChinaQJ_ProductSort where "&ViewFlag&" And ParentID="&rs("id"))(0)
    FolderName=rs("SortName"&Language)
    datafrom="ChinaQJ_ProductSort"
    If ISHTML = 1 Then
        AutoLink = ""&rs("ClassSeo")&""&Separated&""&rs("ID")&""&Separated&"1."&HTMLName&""
    Else
        AutoLink = "ProductList.Asp?SortID="&rs("ID")&""
    End If
    response.write("<a href="""&AutoLink&""" title="""&rs("SortName"&Language)&""">"&FolderName&"</a>")
    if ChildCount>0 then
%>
<% ChinaQJProductIndexFolder(rs("id")) %>
<%
    end if
    rs.movenext
    i=i+1
    wend
    rs.close
    set rs=nothing
end Function

Function ChinaQJProductFolder(id)
  Dim rs,sql,i,ChildCount,FolderType,FolderName,onMouseUp,ListType
  Set rs=server.CreateObject("adodb.recordset")
  sql="Select * From ChinaQJ_ProductSort where "&ViewFlag&" And ParentID="&id&" order by Sequence desc,ID desc"
  rs.open sql,conn,1,1
    if id=0 and rs.recordcount=0 then
        response.write "<center>"&ChinaQJLanguageTxt7&"</center>"
        exit function
    end if
  i=1
  response.write("<table border=""0"" cellspacing=""1"" cellpadding=""2"">")
  while not rs.eof
    ChildCount=conn.execute("select count(*) from ChinaQJ_ProductSort where "&ViewFlag&" And ParentID="&rs("id"))(0)
    if ChildCount=0 then
      if i=rs.recordcount then
        FolderType="SortFileEnd"
      else
        FolderType="SortFile"
      end if
      FolderName=rs("SortName"&Language)
      onMouseUp=""
    else
      if i=rs.recordcount then
        FolderType="SortEndFolderClose"
        ListType="SortEndListline"
        onMouseUp="EndSortChange('a"&rs("id")&"','b"&rs("id")&"');"
      else
      If SortStart = 0 Then
        FolderType="SortFolderOpen"
      Else
        FolderType="SortFolderClose"
      End If
        ListType="SortListline"
        onMouseUp="SortChange('a"&rs("id")&"','b"&rs("id")&"');"
      end if
      FolderName=rs("SortName"&Language)
    end If
    datafrom="ChinaQJ_ProductSort"
    If ISHTML = 1 Then
        AutoLink = ""&rs("ClassSeo")&""&Separated&""&rs("ID")&""&Separated&"1."&HTMLName&""
    Else
        AutoLink = "ProductList.Asp?SortID="&rs("ID")&""
    End If
    response.write("<tr>")
    response.write("<td nowrap id=""b"&rs("id")&""" onMouseUp="""&onMouseUp&""" class="""&FolderType&"""></td><td nowrap style=""padding-top: 3px""><a href="""&AutoLink&""" class=""SortFile1"">"&FolderName&"</a></td></tr>")
    if ChildCount>0 then
%>
<%If SortStart = 0 Then%>
<tr id="a<%=rs("id")%>" style="display: none">
<%Else%>
<tr id="a<%=rs("id")%>" style="display: yes">
<%End If%>
  <td class="<%=ListType%>" nowrap></td>
  <td><% ChinaQJProductFolder(rs("id")) %></td>
</tr>
<%
    end if
    rs.movenext
    i=i+1
    wend
    response.write("</table>")
    rs.close
    set rs=nothing
end Function

Function ChinaQJMagazineFolder(id)
  Dim rs,sql,i,ChildCount,FolderType,FolderName,onMouseUp,ListType
  Set rs=server.CreateObject("adodb.recordset")
  sql="Select * From ChinaQJ_MagazineSort where "&ViewFlag&" And ParentID="&id&" order by Sequence desc,ID desc"
  rs.open sql,conn,1,1
    if id=0 and rs.recordcount=0 then
        response.write "<center>"&ChinaQJLanguageTxt7&"</center>"
        exit function
    end if
  i=1
  response.write("<table border=""0"" cellspacing=""1"" cellpadding=""2"">")
  while not rs.eof
    ChildCount=conn.execute("select count(*) from ChinaQJ_MagazineSort where "&ViewFlag&" And ParentID="&rs("id"))(0)
    if ChildCount=0 then
      if i=rs.recordcount then
        FolderType="SortFileEnd"
      else
        FolderType="SortFile"
      end if
      FolderName=rs("SortName"&Language)
      onMouseUp=""
    else
      if i=rs.recordcount then
        FolderType="SortEndFolderClose"
        ListType="SortEndListline"
        onMouseUp="EndSortChange('a"&rs("id")&"','b"&rs("id")&"');"
      else
      If SortStart = 0 Then
        FolderType="SortFolderOpen"
      Else
        FolderType="SortFolderClose"
      End If
        ListType="SortListline"
        onMouseUp="SortChange('a"&rs("id")&"','b"&rs("id")&"');"
      end if
      FolderName=rs("SortName"&Language)
    end If
    datafrom="ChinaQJ_MagazineSort"
    If ISHTML = 1 Then
        AutoLink = ""&rs("ClassSeo")&""&Separated&""&rs("ID")&""&Separated&"1."&HTMLName&""
    Else
        AutoLink = "MagazineList.Asp?SortID="&rs("ID")&""
    End If
    response.write("<tr>")
    response.write("<td nowrap id=""b"&rs("id")&""" onMouseUp="""&onMouseUp&""" class="""&FolderType&"""></td><td nowrap style=""padding-top: 3px""><a href="""&AutoLink&""">"&FolderName&"</a></td></tr>")
    if ChildCount>0 then
%>
<%If SortStart = 0 Then%>
<tr id="a<%=rs("id")%>" style="display: none">
<%Else%>
<tr id="a<%=rs("id")%>" style="display: yes">
<%End If%>
  <td class="<%=ListType%>" nowrap></td>
  <td><% ChinaQJMagazineFolder(rs("id")) %></td>
</tr>
<%
    end if
    rs.movenext
    i=i+1
    wend
    response.write("</table>")
    rs.close
    set rs=nothing
end Function

Function ChinaQJVideoFolder(id)
  Dim rs,sql,i,ChildCount,FolderType,FolderName,onMouseUp,ListType
  Set rs=server.CreateObject("adodb.recordset")
  sql="Select * From ChinaQJ_VideoSort where "&ViewFlag&" And ParentID="&id&" order by Sequence desc,ID desc"
  rs.open sql,conn,1,1
    if id=0 and rs.recordcount=0 then
        response.write "<center>"&ChinaQJLanguageTxt7&"</center>"
        exit function
    end if
  i=1
  response.write("<table border=""0"" cellspacing=""1"" cellpadding=""2"">")
  while not rs.eof
    ChildCount=conn.execute("select count(*) from ChinaQJ_VideoSort where "&ViewFlag&" And ParentID="&rs("id"))(0)
    if ChildCount=0 then
      if i=rs.recordcount then
        FolderType="SortFileEnd"
      else
        FolderType="SortFile"
      end if
      FolderName=rs("SortName"&Language)
      onMouseUp=""
    else
      if i=rs.recordcount then
        FolderType="SortEndFolderClose"
        ListType="SortEndListline"
        onMouseUp="EndSortChange('a"&rs("id")&"','b"&rs("id")&"');"
      else
      If SortStart = 0 Then
        FolderType="SortFolderOpen"
      Else
        FolderType="SortFolderClose"
      End If
        ListType="SortListline"
        onMouseUp="SortChange('a"&rs("id")&"','b"&rs("id")&"');"
      end if
      FolderName=rs("SortName"&Language)
    end If
    datafrom="ChinaQJ_VideoSort"
    If ISHTML = 1 Then
        AutoLink = ""&rs("ClassSeo")&""&Separated&""&rs("ID")&""&Separated&"1."&HTMLName&""
    Else
        AutoLink = "VideoList.Asp?SortID="&rs("ID")&""
    End If
    response.write("<tr>")
    response.write("<td nowrap id=""b"&rs("id")&""" onMouseUp="""&onMouseUp&""" class="""&FolderType&"""></td><td nowrap style=""padding-top: 3px""><a href="""&AutoLink&""">"&FolderName&"</a></td></tr>")
    if ChildCount>0 then
%>
<%If SortStart = 0 Then%>
<tr id="a<%=rs("id")%>" style="display: none">
<%Else%>
<tr id="a<%=rs("id")%>" style="display: yes">
<%End If%>
  <td class="<%=ListType%>" nowrap></td>
  <td><% ChinaQJVideoFolder(rs("id")) %></td>
</tr>
<%
    end if
    rs.movenext
    i=i+1
    wend
    response.write("</table>")
    rs.close
    set rs=nothing
end Function

function ChinaQJSearchWebLocation()
  ChinaQJSearchWebLocation="&nbsp;"&ChinaQJLanguageTxt19&"：<a href=""Index.Asp"" class=""agray"">"&ChinaQJLanguageTxt20&"</a> - "&ChinaQJLanguageTxt38&" - "&VbCrLf
  if request("Range")="Void" then
    ChinaQJSearchWebLocation=ChinaQJSearchWebLocation&"<center>"&ChinaQJLanguageTxt37&"</center>"
    exit Function
  elseif trim(request("Keyword")) ="" Then
    ChinaQJSearchWebLocation=ChinaQJSearchWebLocation&"<font color=""red"">"&ChinaQJLanguageTxt39&"</font>"
  elseif request("Range")="Product" Then
    ChinaQJSearchWebLocation=ChinaQJSearchWebLocation&""&ChinaQJLanguageTxt8&" - "&ChinaQJLanguageTxt41&"[<font color=""red"">"&trim(request("Keyword"))&"</font>]"
  elseif request("Range")="News" Then
    ChinaQJSearchWebLocation=ChinaQJSearchWebLocation&""&ChinaQJLanguageTxt9&" - "&ChinaQJLanguageTxt41&"[<font color=""red"">"&trim(request("Keyword"))&"</font>]"
  elseif request("Range")="Down" Then
    ChinaQJSearchWebLocation=ChinaQJSearchWebLocation&""&ChinaQJLanguageTxt10&" - "&ChinaQJLanguageTxt41&"[<font color=""red"">"&trim(request("Keyword"))&"</font>]"
  elseif request("Range")="Others" Then
    ChinaQJSearchWebLocation=ChinaQJSearchWebLocation&""&ChinaQJLanguageTxt40&" - "&ChinaQJLanguageTxt41&"[<font color=""red"">"&trim(request("Keyword"))&"</font>]"
  end if
end Function

function ChinaQJSearchWebContent(Keyword,Range)
  if Range="Void" then
     response.write "<center>"&ChinaQJLanguageTxt37&"</center>"
     exit function
  end if
  dim idCount
  dim pages
      pages=12
  dim pagec
  dim page
      page=clng(request("Page"))
  dim pagenc
      pagenc=5
  dim pagenmax
  dim pagenmin
  dim pageprevious
  dim pagenext
  dim datafrom
  dim datawhere
      select case Range
      case "Product"
        datafrom="ChinaQJ_Products"
        datawhere="where "&ViewFlag&" and ProductName"&Language&" like '%"&KeyWord&"%'"
      case "News"
        datafrom="ChinaQJ_News"
        datawhere="where "&ViewFlag&" and NewsName"&Language&" like '%"&KeyWord&"%'"
      case "Down"
        datafrom="ChinaQJ_Download"
        datawhere="where "&ViewFlag&" and DownName"&Language&" like '%"&KeyWord&"%'"
      case "Others"
        datafrom="ChinaQJ_Others"
        datawhere="where "&ViewFlag&" and OthersName"&Language&" like '%"&KeyWord&"%'"
      end select
  if KeyWord <> "" Then
  set rs=server.createobject("adodb.recordset")
  sql="select * from ChinaQJ_Search where ChinaQJ_SearchName='"&KeyWord&"'"
  rs.open sql,conn,1,3
  If rs.eof Then
  rs.addnew
  rs("ChinaQJ_SearchName") = KeyWord
  rs("ChinaQJ_Range") = Range
  rs("ChinaQJ_Hits") = 1
  'rs("ChinaQJ_SearchLanguage") = Language
  Else
  rs("ChinaQJ_Hits") = rs("ChinaQJ_Hits")+1
  End If
  rs.update
  rs.close
  Set rs = Nothing
  End If
  dim sqlid
  dim Myself,PATH_INFO,QUERY_STRING
      PATH_INFO = request.servervariables("PATH_INFO")
      QUERY_STRING = request.ServerVariables("QUERY_STRING")'
      if QUERY_STRING = "" then
        Myself = PATH_INFO & "?"
      elseif Instr(PATH_INFO & "?" & QUERY_STRING,"Page=")=0 then
        Myself= PATH_INFO & "?" & QUERY_STRING & "&"
      else
        Myself = Left(PATH_INFO & "?" & QUERY_STRING,Instr(PATH_INFO & "?" & QUERY_STRING,"Page=")-1)
      end if
  dim taxis
      taxis="order by id desc "
  dim i
  dim rs,sql
  set rs = server.createobject("adodb.recordset")
  sql="select count(ID) as idCount from ["& datafrom &"]" & datawhere
  set rs=server.createobject("adodb.recordset")
  rs.open sql,conn,0,1
  idCount=rs("idCount")
  if(idcount>0) then
    if(idcount mod pages=0)then
      pagec=int(idcount/pages)
    else
      pagec=int(idcount/pages)+1
    end if
    sql="select id from ["& datafrom &"] " & datawhere & taxis
    set rs=server.createobject("adodb.recordset")
    rs.open sql,conn,1,1
    rs.pagesize = pages
    if page < 1 then page = 1
    if page > pagec then page = pagec
    if pagec > 0 then rs.absolutepage = page
    for i=1 to rs.pagesize
      if rs.eof then exit for
      if(i=1)then
        sqlid=rs("id")
      else
        sqlid=sqlid &","&rs("id")
      end if
      rs.movenext
    next
  end if
  if(idcount>0 and sqlid<>"") Then
    sql="select * from ["& datafrom &"] where id in("& sqlid &") "&taxis
    set rs=server.createobject("adodb.recordset")
    rs.open sql,conn,0,1
    Response.Write "<table width=""100%"" border=""0"" cellspacing=""0"" cellpadding=""0"">"&VbCrLf
	select case Range
	case "News"
    Response.Write "  <tr height=""32"">"&VbCrLf
    Response.Write "    <td width=""550"" style=""color:#FFFFFF; font-weight:bold; background:url("&StylePath&"split.gif) no-repeat right center; background-color:#abacaf"">&nbsp;&nbsp;&nbsp;&nbsp;"&ChinaQJLanguageTxt42&"</td>"&VbCrLf
    Response.Write "    <td align=""center"" bgcolor=""#ABACAF"" style=""color:#FFFFFF; font-weight:bold"">"&ChinaQJLanguageTxt43&"</td>"&VbCrLf
    Response.Write "  </tr>"&VbCrLf
	case "Down"
    Response.Write "  <tr height=""32"">"&VbCrLf
    Response.Write "    <td width=""550"" style=""color:#FFFFFF; font-weight:bold; background:url("&StylePath&"split.gif) no-repeat right center; background-color:#abacaf"">&nbsp;&nbsp;&nbsp;&nbsp;"&ChinaQJLanguageTxt42&"</td>"&VbCrLf
    Response.Write "    <td align=""center"" bgcolor=""#ABACAF"" style=""color:#FFFFFF; font-weight:bold"">"&ChinaQJLanguageTxt43&"</td>"&VbCrLf
    Response.Write "  </tr>"&VbCrLf
	case "Product"
    Response.Write "  <tr>"&VbCrLf
	end select
	dim trs
	trs=1
    while not rs.eof
    If ISHTML = 1 Then
        ProAutoLink = ""&rs("ClassSeo")&""&Separated&""&rs("ID")&"."&HTMLName&""
        NewAutoLink = ""&rs("ClassSeo")&""&Separated&""&rs("ID")&"."&HTMLName&""
        DownAutoLink = ""&rs("ClassSeo")&""&Separated&""&rs("ID")&"."&HTMLName&""
        OtherAutoLink = ""&rs("ClassSeo")&""&Separated&""&rs("ID")&"."&HTMLName&""
    Else
        ProAutoLink = "ProductView.Asp?ID="&rs("ID")&""
        NewAutoLink = "NewsView.Asp?ID="&rs("ID")&""
        DownAutoLink = "DownView.Asp?ID="&rs("ID")&""
        OtherAutoLink = "OtherView.Asp?ID="&rs("ID")&""
    End If
      select case Range
'      case "Product"
'        Response.Write "  <tr height=""28"">"&VbCrLf
'        Response.Write "    <td style=""background:url("&StylePath&"bg2.gif) repeat-x left bottom;"">&nbsp;<img src="""&StylePath&"arr.gif"" width=""11"" height=""14"" align=""absmiddle"" />&nbsp;&nbsp;<a href="""&ProAutoLink&""">"&rs("ProductName"&Language)&"</a></td>"&VbCrLf
'        Response.Write "    <td align=""center"" style=""background:url("&StylePath&"bg2.gif) repeat-x left bottom; color:#999999"">"&FormatDate(rs("UpdateTime"),13)&"</td>"&VbCrLf
'        Response.Write "  </tr>"&VbCrLf
      case "Product"
	  SmallPicPath=HtmlSmallPic(rs("GroupID"),rs("SmallPic"),rs("Exclusive"))
	  dim PicW,PicH
	  PicW=144
	  PicH=106
          if StrLen(rs("ProductName"&Language))<=22 then
            ProductName=rs("ProductName"&Language)
          else
            ProductName=StrLeft(rs("ProductName"&Language),20)
          end If
        Response.Write "  <td width=""25%""><table border=""0"" cellspacing=""0"" cellpadding=""0"" width=""100%"" align=""center""><tr>"&VbCrLf
        Response.Write "    <td align=""center""><a href="""&ProAutoLink&""" title="""&rs("ProductName"&Language)&"""><img src="""&SmallPicPath&""" width="""&PicW&""" height="""&PicH&""" border=""0"" style=""padding: 3px; border: 1px solid #ccc"" alt="""&rs("ProductName"&Language)&""" border=""0"" /></a></td></tr>"&VbCrLf
        Response.Write "    <tr><td align=""center"" style=""color:#999999; height:30px; margin-bottom:10px;""><a href="""&ProAutoLink&""" title="""&rs("ProductName"&Language)&""">"&ProductName&"</a></td>"&VbCrLf
        Response.Write "  </tr></table><td>"&VbCrLf
		if trs mod 4=0 then Response.Write "  </tr><tr>"&VbCrLf
      case "News"
        Response.Write "  <tr height=""28"">"&VbCrLf
        Response.Write "    <td style=""background:url("&StylePath&"bg2.gif) repeat-x left bottom;"">&nbsp;<img src="""&StylePath&"arr.gif"" width=""11"" height=""14"" align=""absmiddle"" />&nbsp;&nbsp;<a href="""&NewAutoLink&""">"&rs("NewsName"&Language)&"</a></td>"&VbCrLf
        Response.Write "    <td align=""center"" style=""background:url("&StylePath&"bg2.gif) repeat-x left bottom; color:#999999"">"&FormatDate(rs("Addtime"),13)&"</td>"&VbCrLf
        Response.Write "  </tr>"&VbCrLf
      case "Down"
        Response.Write "  <tr height=""28"">"&VbCrLf
        Response.Write "    <td style=""background:url("&StylePath&"bg2.gif) repeat-x left bottom;"">&nbsp;<img src="""&StylePath&"arr.gif"" width=""11"" height=""14"" align=""absmiddle"" />&nbsp;&nbsp;<a href="""&DownAutoLink&""">"&rs("DownName"&Language)&"</a>("&rs("FileSize")&")</td>"&VbCrLf
        Response.Write "    <td align=""center"" style=""background:url("&StylePath&"bg2.gif) repeat-x left bottom; color:#999999"">"&FormatDate(rs("Updatetime"),13)&"</td>"&VbCrLf
        Response.Write "  </tr>"&VbCrLf
      case "Others"
        Response.Write "  <tr height=""28"">"&VbCrLf
        Response.Write "    <td style=""background:url("&StylePath&"bg2.gif) repeat-x left bottom;"">&nbsp;<img src="""&StylePath&"arr.gif"" width=""11"" height=""14"" align=""absmiddle"" />&nbsp;&nbsp;<a href="""&OtherAutoLink&""">"&rs("OthersName"&Language)&"</a></td>"&VbCrLf
        Response.Write "    <td align=""center"" style=""background:url("&StylePath&"bg2.gif) repeat-x left bottom; color:#999999"">"&FormatDate(rs("UpdateTime"),13)&"</td>"&VbCrLf
        Response.Write "  </tr>"&VbCrLf
      end select
      rs.movenext
	  trs=trs+1
    wend
	select case Range
	case "Product"
    Response.Write "  </td></tr>"&VbCrLf
	end select
    Response.Write "</table>"&VbCrLf
  else
    response.write "<center>"&ChinaQJLanguageTxt7&"</center>"
    exit function
  end If
  Response.Write "<table width=""98%"" border=""0"" cellspacing=""0"" cellpadding=""0"">"&VbCrLf
  Response.Write "  <tr height=""35"">"&VbCrLf
  Response.Write "    <td align=""center"">"&VbCrLf
  Response.Write ""&ChinaQJLanguageTxt44&"<strong style=""color:red"">"&idcount&"</strong>"&ChinaQJLanguageTxt45&" "&ChinaQJLanguageTxt46&"：<strong style=""color:red"">"&page&"</strong>/"&pagec&" "&ChinaQJLanguageTxt47&"：<strong style=""color:red"">"&pages&"</strong>"&ChinaQJLanguageTxt45&"" & vbCrLf
  pagenmin=page-pagenc
  pagenmax=page+pagenc
  if(pagenmin<1) then pagenmin=1
  if(page>1) then response.write ("<a href="""& myself &"Page=1"" title="""&ChinaQJLanguageTxt48&"""><font color=""#999999"">第一页</font></a> ")
  if page-(pagenc*2+1)<=0 then
    pageprevious=1
  else
    pageprevious=page-(pagenc*2+1)
  end if
  if(pagenmin>1) then response.write ("<a href="""& myself &"Page="& pageprevious &""" title="""&ChinaQJLanguageTxt49&""& pageprevious &""&ChinaQJLanguageTxt50&"""><font face=""webdings"" color=""#000000"">3</font></a> ")
  if(pagenmax>pagec) then pagenmax=pagec
  for i = pagenmin to pagenmax
    if(i=page) then
      response.write ("&nbsp;<strong style=""color:red"">"& i &"</strong>&nbsp;")
    else
      response.write ("[<a href="""& myself &"Page="& i &""">"& i &"</a>]")
    end if
  next
  if page+(pagenc*2+1)>=pagec then
    pagenext=pagec
  else
    pagenext=page+(pagenc*2+1)
  end if
  if(pagenmax<pagec) then response.write (" <a href="""& myself &"Page="& pagenext &""" title="""&ChinaQJLanguageTxt51&""&pagenext&""&ChinaQJLanguageTxt50&"""><font color=""#999999"">最后一页</font></a> ")
  if(page<pagec) then response.write (" <a href="""& myself &"Page="& pagec &""" title="""&ChinaQJLanguageTxt51&""&pagec&""&ChinaQJLanguageTxt50&"""><font color=""#999999"">最后一页</font></a>")
  Response.Write "    </td>"&VbCrLf
  Response.Write "  </tr>"&VbCrLf
  Response.Write "</table>"&VbCrLf
  rs.close
  set rs=nothing
end Function

function ChinaQJProductWebLocation()
  ChinaQJProductWebLocation="&nbsp;"&ChinaQJLanguageTxt19&"：<a href=""Index.Asp"" class=""agray"">"&ChinaQJLanguageTxt20&"</a> - <a href=""ProductList.Asp"" class=""agray"">"&ChinaQJLanguageTxt240&"</a>"&VbCrLf
  if request.QueryString("ID")="" then
    ChinaQJProductWebLocation=ChinaQJProductWebLocation
  elseif not IsNumeric(request.QueryString("ID")) then
    ChinaQJProductWebLocation=ChinaQJProductWebLocation&ChinaQJLanguageTxt16
  elseif conn.execute("select * from ChinaQJ_Products Where "&ViewFlag&" and ID="&request.QueryString("ID")).eof then
    ChinaQJProductWebLocation=ChinaQJProductWebLocation&ChinaQJLanguageTxt16
  else
    dim rs,sql
    set rs = server.createobject("adodb.recordset")
    sql="select * from ChinaQJ_Products where "&ViewFlag&" and ID="&request.QueryString("ID")
    rs.open sql,conn,1,1
    ChinaQJProductWebLocation=ChinaQJProductWebLocation&ChinaQJProductSortPathTXT("ChinaQJ_ProductSort",rs("SortID"))
    rs.close
    set rs=nothing
  end if
end Function

function ChinaQJProductSortPathTXT(DataFrom,ID)
  dim rs,sql
  Set rs=server.CreateObject("adodb.recordset")
  sql="Select * From "&DataFrom&" where "&ViewFlag&" and ID="&ID
  rs.open sql,conn,1,1
  if not rs.eof Then
    If ISHTML = 1 Then
        AutoLink = ""&rs("ClassSeo")&""&Separated&""&rs("ID")&""&Separated&"1."&HTMLName&""
    Else
        AutoLink = "ProductList.Asp?SortID="&rs("ID")&""
    End If
    ChinaQJProductSortPathTXT=ChinaQJProductSortPathTXT(DataFrom,rs("ParentID"))&" - <a href="""&AutoLink&"""><span style=""color:#EC0000"">"&rs("SortName"&Language)&"</span></a>"
  end if
  rs.close
  set rs=nothing
end Function

function ChinaQJProductView()
    Response.Write "<table width=""100%"" border=""0"" cellspacing=""0"" cellpadding=""0"" align=""center"">"&VbCrLf
    Response.Write "    <tr>"&VbCrLf
    Response.Write "        <td>"&VbCrLf
    Response.Write "            <table width=""100%"" border=""0"" cellspacing=""0"" cellpadding=""0"">"&VbCrLf
    Response.Write "              <tr>"&VbCrLf
    Response.Write "                <td width=""30"" height=""36""><img src="""&StylePath&"title_bg1.gif"" width=""30"" height=""36"" /></td>"&VbCrLf
    Response.Write "                <td width=""100%"" align=""center"" background="""&StylePath&"title_bg_center.jpg"" style=""color:#000000; font-size:14px; font-weight:bold"">"&VbCrLf
    ID=request.QueryString("ID")
    if ID="" or not IsNumeric(ID) then
    response.write "<center>"&ChinaQJLanguageTxt7&"</center>"
    elseif conn.execute("select * from ChinaQJ_Products Where "&ViewFlag&" and ID="&ID).eof then
    response.write "<center>"&ChinaQJLanguageTxt7&"</center>"
    else
    dim rs,sql
    set rs = server.createobject("adodb.recordset")
    sql="select * from ChinaQJ_Products where "&ViewFlag&" and ID="&ID
    rs.open sql,conn,1,3
    OtherPic=rs("OtherPic")
    If Not(IsNull(OtherPic)) Then
    OtherPic=split(OtherPic,"*")
    End If
    Response.Write ""&rs("ProductName"&Language)&""&VbCrLf
    End If
    Response.Write "                </td>"&VbCrLf
    Response.Write "                <td width=""30""><img src="""&StylePath&"title_bg2.gif"" width=""30"" height=""36"" /></td>"&VbCrLf
    Response.Write "              </tr>"&VbCrLf
    Response.Write "              <tr>" & vbCrLf
    Response.Write "                <td><img src=""" & StylePath & "title_bg3.gif"" width=""30"" height=""14"" /></td>" & vbCrLf
    Response.Write "                <td background=""" & StylePath & "title_bg_center2.jpg"">&nbsp;</td>" & vbCrLf
    Response.Write "                <td><img src=""" & StylePath & "title_bg4.gif"" width=""30"" height=""14"" /></td>" & vbCrLf
    Response.Write "              </tr>" & vbCrLf
    Response.Write "            </table></td>"&VbCrLf
    Response.Write "        </tr>"&VbCrLf
    if ViewNoRight(rs("GroupID"),rs("Exclusive")) Then
    Response.Write "  <tr>"&VbCrLf
    Response.Write "    <td>"&VbCrLf
    Response.Write "<table width=""100%"" border=""0"" cellspacing=""0"" cellpadding=""0"" align=""center"">"&VbCrLf
    Response.Write "  <tr>"&VbCrLf
    Response.Write "    <td style=""line-height:200%; padding-top:10px;"">"&ChinaQJLanguageTxt55&"："&rs("ProductName"&Language)&"<br />"&VbCrLf
    Response.Write "    "&ChinaQJLanguageTxt56&"："&rs("ProductNo") &"<br />"&VbCrLf
    Response.Write "    "&ChinaQJLanguageTxt59&"："&FormatDate(rs("UpdateTime"),13)&"<br />"&VbCrLf
    attribute1=rs("ProName"&Language)
    attribute1_value=rs("ProInfo"&Language)
    if attribute1 <> "" and attribute1_value <> "" then
    attribute1_1=Split(attribute1,"§§§")
    attribute1_value_1=Split(attribute1_value,"§§§")
    for i=0 to ubound(attribute1_value_1)
    Response.Write "    "&attribute1_1(i)&"："&attribute1_value_1(i)&"<br />"&VbCrLf
    Next
    End If
    Response.Write "    "&ChinaQJLanguageTxt18&"：<script language=""javascript"" src=""HitCount.Asp?id="&rs("ID")&"&LX=ChinaQJ_Products""></script><script language=""javascript"" src=""HitCount.Asp?action=count&LX=ChinaQJ_Products&id="&rs("ID")&"""></script><br />"&VbCrLf
    If Len(rs("OtherPic")) > 0 Then
    Response.Write "    <strong style=""color:red"">"&ChinaQJLanguageTxt63&"：</strong><br />"&VbCrLf
    Dim htmlshop
    for htmlshop = 0 to ubound(OtherPic)-1
    Response.Write "    <a href="""&trim(OtherPic(htmlshop))&""" title="""&rs("ProductName"&Language)&""" rel=""clearbox[gallery=Green,,title="&rs("ProductName"&Language)&",,comment="&rs("ProductName"&Language)&"]"" target=""_blank""><img onMouseOver=""document.rImage.src='"&trim(OtherPic(htmlshop))&"'; pid='"&trim(OtherPic(htmlshop))&"'"" src="""&trim(OtherPic(htmlshop))&""" onload=""javascript:DrawImage(this,110,110);"" style=""border:1px solid #ccc; margin-left:5px; margin-right:5px; margin-top:5px""></a>"&VbCrLf
    next
    End If
    Response.Write "    <br />"&VbCrLf
    Response.Write "    <br /></td>"&VbCrLf
    Response.Write "    <td style=""width:280px; text-align:center; padding-top:10px;""><a href="""&rs("BigPic")&""" rel=""clearbox[gallery=Green,,title="&rs("ProductName"&Language)&",,comment="&rs("ProductName"&Language)&"]"" target=""_blank""><img src="""&HtmlSmallPic(rs("GroupID"),rs("BigPic"),rs("Exclusive"))&""" title="""&rs("ProductName"&Language)&""" style=""padding: 3px; border: 1px solid #ccc"" onload=""javascript:DrawImage(this,280,280);"" name=""rImage"" border=""0""></a><br /><br /><a href=""ProductBuy.Asp?ProductNo="&rs("ProductNo")&""" title="""&ChinaQJLanguageTxt64&"："&rs("ProductName"&Language)&"""><img src="""&StylePath&"buy_"&Language&".gif"" border=""0"" /></a></td>"&VbCrLf
    Response.Write "  </tr>"&VbCrLf
    Response.Write "</table>"&VbCrLf
    Response.Write "    </td>"&VbCrLf
    Response.Write "  </tr>"&VbCrLf
    Response.Write "  <tr>"&VbCrLf
    Response.Write "    <td height=""18"">&nbsp;</td>"&VbCrLf
    Response.Write "  </tr>"&VbCrLf
	
        Response.Write "  <tr>" & vbCrLf
        Response.Write "    <td>" & vbCrLf
        Response.Write "    <a href=""javascript:showCon('1');"" class=""pa"" ID=""m1""><font color=""#ffffff"">" & ChinaQJLanguageTxt239 & "</font></a>" & vbCrLf
		ChinaQJ_Remark = rs("Remark" & Language)
        If InStr(ChinaQJ_Remark, "|||") > 0 Then
            ChinaQJ_RemarkN = Split(ChinaQJ_Remark, "|||")
            For i = 1 To UBound(ChinaQJ_RemarkN) -1
                temp = Split(ChinaQJ_RemarkN(i), "||")
                Response.Write "    <a href=""javascript:showCon('" & i + 1 & "');"" class=""pa"" ID=""m" & i + 1 & """><font color=""#ffffff"">" & temp(0) & "</font></a>" & vbCrLf
            Next
        End If
        Response.Write "    </td>" & vbCrLf
        Response.Write "  </tr>" & vbCrLf
        Response.Write "  <tr>" & vbCrLf
        Response.Write "    <td align=""left"" style=""padding: 12px; background: url(" & StylePath & "bg2.jpg) repeat-x;"">" & vbCrLf
        Response.Write "    <div ID=""con1"" style=""line-height: 24px; display: none;"">" & ProcessSitelink(rs("Content" & Language)) & "</div>" & vbCrLf
        If InStr(ChinaQJ_Remark, "|||") > 0 Then
            ChinaQJ_RemarkD = Split(ChinaQJ_Remark, "|||")
            For i = 1 To UBound(ChinaQJ_RemarkD) -1
                temp = Split(ChinaQJ_RemarkD(i), "||")
                Response.Write "    <div ID=""con" & i + 1 & """ style=""line-height: 24px; display: none;"">" & ProcessSitelink(temp(1)) & "</div>" & vbCrLf
            Next
        End If
        Response.Write "        <table border=""0"" cellpadding=""0"" cellspacing=""0"" ID=""con1"" style=""display: none;"">" & vbCrLf
        Response.Write "        </table>" & vbCrLf
        Response.Write "        <script type=""text/javascript"">showCon('1');</script></td>" & vbCrLf
        Response.Write "  </tr>" & vbCrLf

    Response.Write "  <tr>"&VbCrLf
    Response.Write "    <td height=""15"" style=""background: url("&StylePath&"bg3.gif) repeat-x left center;"">&nbsp;</td>"&VbCrLf
    Response.Write "  </tr>"&VbCrLf
    Response.Write "  <tr>"&VbCrLf
    Response.Write "    <td height=""18"">&nbsp;</td>"&VbCrLf
    Response.Write "  </tr>"&VbCrLf
    Else
    Response.Write "        <tr>"&VbCrLf
    Response.Write "          <td rowspan=""2"" align=""center""><img src="""&StylePath&"NoRight_"&Language&".jpg""></td>"&VbCrLf
    Response.Write "        </tr>"&VbCrLf
    end if
    rs.update
    rs.close
    Set rs = Server.CreateObject("Adodb.Recordset")
    If Request.QueryString("ID") = "" Or Not IsNumeric(Request.QueryString("ID")) Then
        sql = "Select Top 1 TheTags" & Language & " From ChinaQJ_Products Where " & ViewFlag & " Order By Sequence Desc,ID Desc"
    Else
        sql = "Select TheTags" & Language & " From ChinaQJ_Products Where " & ViewFlag & " And ID = " & Request.QueryString("ID")
    End If
    rs.Open sql, conn, 1, 1
    If Not rs.EOF Then
        If rs("TheTags" & Language) <> "" Then
            Response.Write "        <tr>" & vbCrLf
            Response.Write "          <td height=""25"" align=""right"" style=""padding-left: 8px; padding-right: 8px;"">" & vbCrLf
            Response.Write "          <font color=""#005AA0"">Tags：</font>" & vbCrLf
            TheTags = Split(rs("TheTags" & Language), ",")
            For i = 0 To UBound(TheTags)
                Response.Write "<a href=""Search.Asp?Range=Product&Keyword=" & TheTags(i) & """>"
                Response.Write "<font color=""#CC3C3C""><u>"
                Response.Write TheTags(i) & ""
                Response.Write "</u></font>"
                Response.Write "</a> "
            Next
            Response.Write "          </td>" & vbCrLf
            Response.Write "        </tr>" & vbCrLf
        End If
    End If
    rs.Close
    Set rs = Nothing
    Response.Write "        <tr>"&VbCrLf
    Response.Write "          <td height=""25"">"&VbCrLf
    Dim IDmax,IDmin
    IDmax = ID+1
    Set rs = server.createobject("adodb.recordset")
    sql="select * from ChinaQJ_Products where "&ViewFlag&" and ID<"&ID&" order by id desc"
    rs.open sql,conn,1,1
    If Not rs.eof Then
    If ISHTML = 1 Then
    AutoLink = ""&rs("ClassSeo")&""&Separated&""&rs("ID")&"."&HTMLName&""
    Else
    AutoLink = "ProductView.Asp?ID="&rs("ID")&""
    End If
    Response.Write ""&ChinaQJLanguageTxt248&"<a href="""&AutoLink&""" title="""&rs("ProductName"&Language)&"""><font color="""&rs("TitleColor")&""">"&rs("ProductName"&Language)&"</font></a>"
    Else
    Response.Write ""&ChinaQJLanguageTxt248&""&ChinaQJLanguageTxt249&""
    End If
    rs.close
    Response.Write "          </td>"&VbCrLf
    Response.Write "        </tr>"&VbCrLf
    Response.Write "        <tr>"&VbCrLf
    Response.Write "          <td height=""25"">"&VbCrLf
    IDmin = ID-1
    Set rs = server.createobject("adodb.recordset")
    sql="select * from ChinaQJ_Products where "&ViewFlag&" and ID>"&ID&" order by id asc"
    rs.open sql,conn,1,1
    If Not rs.eof Then
    If ISHTML = 1 Then
    AutoLink = ""&rs("ClassSeo")&""&Separated&""&rs("ID")&"."&HTMLName&""
    Else
    AutoLink = "ProductView.Asp?ID="&rs("ID")&""
    End If
    Response.Write ""&ChinaQJLanguageTxt247&"<a href="""&AutoLink&""" title="""&rs("ProductName"&Language)&"""><font color="""&rs("TitleColor")&""">"&rs("ProductName"&Language)&"</font></a>"
    Else
    Response.Write ""&ChinaQJLanguageTxt247&""&ChinaQJLanguageTxt249&""
    End If
    rs.close
    Response.Write "          </td>"&VbCrLf
    Response.Write "        </tr>"&VbCrLf
    set rs=Nothing
    Response.Write "        <tr>"&VbCrLf
    Response.Write "          <td height=""20"">&nbsp;</td>"&VbCrLf
    Response.Write "        </tr>"&VbCrLf
    Response.Write "      </table>"&VbCrLf
end Function

function ChinaQJProductListWebLocation()
  ChinaQJProductListWebLocation="&nbsp;"&ChinaQJLanguageTxt19&"：<a href=""Index.Asp"" class=""agray"">"&ChinaQJLanguageTxt20&"</a> - <a href=""ProductList.Asp"" class=""agray"">"&ChinaQJLanguageTxt226&"</a>"&VbCrLf
  if request.QueryString("SortID")="" then
    ChinaQJProductListWebLocation=ChinaQJProductListWebLocation
  elseif not IsNumeric(request.QueryString("SortID")) then
    ChinaQJProductListWebLocation=ChinaQJProductListWebLocation&ChinaQJLanguageTxt16
  elseif conn.execute("select * from ChinaQJ_ProductSort Where "&ViewFlag&" and ID="&request.QueryString("SortID")).eof then
    ChinaQJProductListWebLocation=ChinaQJProductListWebLocation&ChinaQJLanguageTxt16
  else
    dim rs,sql
    set rs = server.createobject("adodb.recordset")
    sql="select * from ChinaQJ_ProductSort where "&ViewFlag&" and ID="&request.QueryString("SortID")
    rs.open sql,conn,1,1
    ChinaQJProductListWebLocation=ChinaQJProductListWebLocation&ChinaQJProductListSortPathTXT("ChinaQJ_ProductSort",rs("ID"))
    rs.close
    set rs=nothing
  end if
end Function

function ChinaQJProductListSortPathTXT(DataFrom,ID)
  dim rs,sql
  Set rs=server.CreateObject("adodb.recordset")
  sql="Select * From "&DataFrom&" where "&ViewFlag&" and ID="&ID
  rs.open sql,conn,1,1
  if not rs.eof Then
    If ISHTML = 1 Then
        AutoLink = ""&rs("ClassSeo")&""&Separated&""&rs("ID")&""&Separated&"1."&HTMLName&""
    Else
        AutoLink = "ProductList.Asp?SortID="&rs("ID")&""
    End If
    ChinaQJProductListSortPathTXT=ChinaQJProductListSortPathTXT(DataFrom,rs("ParentID"))&" - <a href="""&AutoLink&""">"&rs("SortName"&Language)&"</a>"
  end if
  rs.close
  set rs=nothing
end Function

function ChinaQJProductListWebContent(DataFrom,ID,SortPath,PicW,PicH,trimstr)
  dim rs,sql
  dim HideSort
  set rs = server.createobject("adodb.recordset")
  if ID="" then
    SortPath="0,"
  elseif not IsNumeric(ID) then
    response.write "<center>"&ChinaQJLanguageTxt7&"</center>"
    exit function
  elseif conn.execute("select * from "&DataFrom&" Where "&ViewFlag&" and ID="&ID).eof then
    response.write "<center>"&ChinaQJLanguageTxt7&"</center>"
    exit function
  else
    SortPath=conn.execute("select * from "&DataFrom&" Where "&ViewFlag&" and ID="&ID)("SortPath")
    conn.execute("update "&DataFrom&" set ClickNumber=ClickNumber+1 Where ID="&ID)
  end If
  If IsDatabaseType = 1 Then
    sql="select * from "&DataFrom&" Where not("&ViewFlag&") and Charindex('"&SortPath&"',SortPath) > 0"
  Else
    sql="select * from "&DataFrom&" Where not("&ViewFlag&") and Instr(SortPath,'"&SortPath&"') > 0"
  End If
  rs.open sql,conn,1,1
  while not rs.eof
    HideSort="and not(Instr(SortPath,'"&rs("SortPath")&"')>0) "&HideSort
    rs.movenext
  wend
  rs.close
  dim idCount
  dim pages
      pages=ProInfo
  dim pagec
  dim page
      page=clng(request("Page"))
  dim pagenc
      pagenc=4
  dim pagenmax
  dim pagenmin
  dim pageprevious
  dim pagenext
  datafrom="ChinaQJ_Products"
  dim datawhere
      If IsDatabaseType = 1 Then
        datawhere="where "&ViewFlag&" and Charindex('"&SortPath&"',SortPath) > 0 "&HideSort& " "
      Else
        datawhere="where "&ViewFlag&" and Instr(SortPath,'"&SortPath&"') > 0 "&HideSort& " "
      End If
  dim sqlid
  dim Myself,PATH_INFO,QUERY_STRING
      PATH_INFO = request.servervariables("PATH_INFO")
      QUERY_STRING = request.ServerVariables("QUERY_STRING")'
      if QUERY_STRING = "" then
        Myself = PATH_INFO & "?"
      elseif Instr(PATH_INFO & "?" & QUERY_STRING,"Page=")=0 then
        Myself= PATH_INFO & "?" & QUERY_STRING & "&"
      else
        Myself = Left(PATH_INFO & "?" & QUERY_STRING,Instr(PATH_INFO & "?" & QUERY_STRING,"Page=")-1)
      end if
  dim taxis
      taxis="order by NewFlag"&Language&" asc, UpdateTime desc, id desc"
  dim i
  sql="select count(ID) as idCount from ["& datafrom &"]" & datawhere
  set rs=server.createobject("adodb.recordset")
  rs.open sql,conn,0,1
  idCount=rs("idCount")
  if(idcount>0) then
    if(idcount mod pages=0)then
      pagec=int(idcount/pages)
    else
      pagec=int(idcount/pages)+1
    end if
    sql="select id from ["& datafrom &"] " & datawhere & taxis
    set rs=server.createobject("adodb.recordset")
    rs.open sql,conn,1,1
    rs.pagesize = pages
    if page < 1 then page = 1
    if page > pagec then page = pagec
    if pagec > 0 then rs.absolutepage = page
    for i=1 to rs.pagesize
      if rs.eof then exit for
      if(i=1)then
        sqlid=rs("id")
      else
        sqlid=sqlid &","&rs("id")
      end if
      rs.movenext
    next
  end if
  if(idcount>0 and sqlid<>"") then
    sql="select * from ["& datafrom &"] where id in("& sqlid &") "&taxis
    set rs=server.createobject("adodb.recordset")
    rs.open sql,conn,0,1
    dim tr,td
    dim ProductName,SmallPicPath,Content
    Response.Write "<table border=""0"" cellspacing=""0"" cellpadding=""0"" width=""100%"">"&VbCrLf
    Response.Write "<form action=""ProductBuy.Asp"" method=""Post"" name=""Inquire"" target=""_blank"">"&VbCrLf
    for tr=1 to 3
        Response.Write "  <tr>"&VbCrLf
        for td=1 to 4
          if StrLen(rs("ProductName"&Language))<=22 then
            ProductName=rs("ProductName"&Language)
          else
            ProductName=StrLeft(rs("ProductName"&Language),20)
          end If
            If ISHTML = 1 Then
                AutoLink = ""&SysRootDir&Language&"/"&rs("ClassSeo")&""&Separated&""&rs("ID")&"."&HTMLName&""
            Else
                AutoLink = ""&SysRootDir&Language&"/ProductView.Asp?ID="&rs("ID")&""
            End If
            SmallPicPath=HtmlSmallPic(rs("GroupID"),rs("SmallPic"),rs("Exclusive"))
            Response.Write "    <td align=""center"" valign=""top""><table width=""150"" border=""0"" cellspacing=""0"" cellpadding=""0"" style=""margin-bottom: 22px"">"&VbCrLf
            Response.Write "        <tr>"&VbCrLf
            Response.Write "          <td width=""150"" align=""center""><a href="""&rs("BigPic")&""" title="""&rs("ProductName"&Language)&""" rel=""clearbox[gallery=Green,,title="&rs("ProductName"&Language)&",,comment="&rs("ProductName"&Language)&"]""><img src="""&SmallPicPath&""" width="""&PicW&""" height="""&PicH&""" border=""0"" style=""padding: 3px; border: 1px solid #ccc"" alt="""&rs("ProductName"&Language)&""" border=""0"" /></a></td>"&VbCrLf
            Response.Write "        </tr>"&VbCrLf
            Response.Write "        <tr>"&VbCrLf
            Response.Write "          <td><img src="""&StylePath&"t.gif"" width=""1"" height=""2"" /></td>"&VbCrLf
            Response.Write "        </tr>"&VbCrLf
            Response.Write "        <tr>"&VbCrLf
            Response.Write "          <td bgcolor=""#EFEFEF"" style=""padding:4px 7px 4px 7px;""><table width=""100%"" border=""0"" cellspacing=""0"" cellpadding=""0"">"&VbCrLf
            Response.Write "              <tr>"&VbCrLf
            Response.Write "                <td height=""19"" align=""left""><a href="""&AutoLink&""" title="""&rs("ProductName"&Language)&"""><font color="""&rs("TitleColor")&""">"&left(ProductName,trimstr)&"</font></a></td>"&VbCrLf
            Response.Write "              </tr>"&VbCrLf
            Response.Write "              <tr>"&VbCrLf
            Response.Write "                <td height=""19"" align=""left"">"&ChinaQJLanguageTxt227&"：<span style=""font-size: 11px"">"&FormatDate(rs("UpdateTime"),13)&"</span>&nbsp;&nbsp;<a href="""&AutoLink&""" target=""_blank"" title="""&ChinaQJLanguageTxt228&"""><img src="""&StylePath&"zoom.gif"" border=""0"" align=""absmiddle"" /></a><input name=""ProductNo"" type=""checkbox"" id=""ProductNo"" value="""&trim(rs("ProductNo"))&""" class=""inputnoborder""></td>"&VbCrLf
            Response.Write "              </tr>"&VbCrLf
            Response.Write "            </table></td>"&VbCrLf
            Response.Write "        </tr>"&VbCrLf
            Response.Write "      </table></td>"&VbCrLf
          rs.movenext
          if rs.eof then exit for
        next
        Response.Write "  </tr>"&VbCrLf
        if rs.eof then exit for
      Next
      Response.Write "  <tr>"&VbCrLf
      Response.Write "    <td height=""50"" align=""center"" colspan=""6""><input type=""image"" src="""&StylePath&"buy_"&Language&".gif"" border=""0"" class=""inputnoborder"" /></td>"&VbCrLf
      Response.Write "  </tr>"&VbCrLf
      Response.Write "</form>"&VbCrLf
      Response.Write "</table>"&VbCrLf
  else
    response.write "<center>"&ChinaQJLanguageTxt7&"</center>"
    exit function
  end if
  Response.Write "<div class=""page"">"&VbCrLf
  Response.Write ""&ChinaQJLanguageTxt44&"<strong style=""color:red"">"&idcount&"</strong>"&ChinaQJLanguageTxt45&"&nbsp;&nbsp;&nbsp;" & vbCrLf
  pagenmin=page-pagenc
  pagenmax=page+pagenc
  if(pagenmin<1) then pagenmin=1
%>
    <span id="page">
<%
Sortid=Request("Sortid")
If ISHTML = 1 Then
If Sortid="" then
%>
        <a href="<%= ClassSeo %><%= Separated %>1.<%= HTMLName %>"><%= ChinaQJLanguageTxt313 %></a>
<% If page>1 Then %>
        <a href="<%= ClassSeo %><%= Separated %><%= page-1 %>.<%= HTMLName %>"><%= ChinaQJLanguageTxt314 %></a>
<% Else %>
        <a href="<%= ClassSeo %><%= Separated %>1.<%= HTMLName %>"><%= ChinaQJLanguageTxt313 %></a>
<% End If %>
<%
  if(pagenmax>pagec) then pagenmax=pagec
  for i = pagenmin to pagenmax
    if(i=page) then
%>
        <a href="<%= ClassSeo %><%= Separated %><%= i %>.<%= HTMLName %>" class='page_click' ><%= i %></a>
<% Else %>
        <a href="<%= ClassSeo %><%= Separated %><%= i %>.<%= HTMLName %>" class='' ><%= i %></a>
<%
End If
Next
%>
<% If page<pagenmax Then %>
        <a href="<%= ClassSeo %><%= Separated %><%= page+1 %>.<%= HTMLName %>"><%= ChinaQJLanguageTxt315 %></a>
<% Else %>
        <a href="<%= ClassSeo %><%= Separated %><%= pagenmax %>.<%= HTMLName %>"><%= ChinaQJLanguageTxt315 %></a>
<% End If %>
        <a href="<%= ClassSeo %><%= Separated %><%= pagenmax %>.<%= HTMLName %>"><%= ChinaQJLanguageTxt316 %></a>
<% Else %>
        <a href="<%= ClassSeo %><%= Separated %><%= Sortid %><%= Separated %>1.<%= HTMLName %>"><%= ChinaQJLanguageTxt313 %></a>
<% If page>1 Then %>
        <a href="<%= ClassSeo %><%= Separated %><%= Sortid %><%= Separated %><%= page-1 %>.<%= HTMLName %>"><%= ChinaQJLanguageTxt314 %></a>
<% Else %>
        <a href="<%= ClassSeo %><%= Separated %><%= Sortid %><%= Separated %>1.<%= HTMLName %>"><%= ChinaQJLanguageTxt314 %></a>
<% End If %>
<%
  if(pagenmax>pagec) then pagenmax=pagec
  for i = pagenmin to pagenmax
    if(i=page) then
%>
        <a href="<%= ClassSeo %><%= Separated %><%= Sortid %><%= Separated %><%= i %>.<%= HTMLName %>" class='page_click' ><%= i %></a>
<% Else %>
        <a href="<%= ClassSeo %><%= Separated %><%= Sortid %><%= Separated %><%= i %>.<%= HTMLName %>" class='' ><%= i %></a>
<%
End If
Next
%>
<% If page<pagenmax Then %>
        <a href="<%= ClassSeo %><%= Separated %><%= Sortid %><%= Separated %><%= page+1 %>.<%= HTMLName %>"><%= ChinaQJLanguageTxt315 %></a>
<% Else %>
        <a href="<%= ClassSeo %><%= Separated %><%= Sortid %><%= Separated %><%= pagenmax %>.<%= HTMLName %>"><%= ChinaQJLanguageTxt315 %></a>
<% End If %>
        <a href="<%= ClassSeo %><%= Separated %><%= Sortid %><%= Separated %><%= pagenmax %>.<%= HTMLName %>"><%= ChinaQJLanguageTxt316 %></a>
<% End If %>
<% Else %>
        <a href="<%= myself %>Page=1"><%= ChinaQJLanguageTxt313 %></a>
<% If page>1 Then %>
        <a href="<%= myself %>Page=<%= page-1 %>"><%= ChinaQJLanguageTxt314 %></a>
<% Else %>
        <a href="<%= myself %>Page=1"><%= ChinaQJLanguageTxt314 %></a>
<% End If %>
<%
  if(pagenmax>pagec) then pagenmax=pagec
  for i = pagenmin to pagenmax
    if(i=page) then
%>
        <a href="<%= myself %>Page=<%= i %>" class='page_click' ><%= i %></a>
<% Else %>
        <a href="<%= myself %>Page=<%= i %>" class='' ><%= i %></a>
<%
End If
Next
%>
<% If page<pagenmax Then %>
        <a href="<%= myself %>Page=<%= page+1 %>"><%= ChinaQJLanguageTxt315 %></a>
<% Else %>
        <a href="<%= myself %>Page=<%= pagenmax %>"><%= ChinaQJLanguageTxt315 %></a>
<% End If %>
        <a href="<%= myself %>Page=<%= pagenmax %>"><%= ChinaQJLanguageTxt316 %></a>
<% End If %>
    </span>
<%
  Response.Write "</div>"&VbCrLf
  rs.close
  set rs=nothing
end Function

'新开模产品
function ChinaQJNewProductListWebContent(DataFrom,ID,SortPath,PicW,PicH,trimstr)
  dim rs,sql
  dim HideSort
  set rs = server.createobject("adodb.recordset")
  if ID="" then
    SortPath="0,"
  elseif not IsNumeric(ID) then
    response.write "<center>"&ChinaQJLanguageTxt7&"</center>"
    exit function
  elseif conn.execute("select * from "&DataFrom&" Where "&ViewFlag&" and ID="&ID).eof then
    response.write "<center>"&ChinaQJLanguageTxt7&"</center>"
    exit function
  else
    SortPath=conn.execute("select * from "&DataFrom&" Where "&ViewFlag&" and ID="&ID)("SortPath")
    conn.execute("update "&DataFrom&" set ClickNumber=ClickNumber+1 Where ID="&ID)
  end If
  If IsDatabaseType = 1 Then
    sql="select * from "&DataFrom&" Where not("&ViewFlag&") and Charindex('"&SortPath&"',SortPath) > 0"
  Else
    sql="select * from "&DataFrom&" Where not("&ViewFlag&") and Instr(SortPath,'"&SortPath&"') > 0"
  End If
  rs.open sql,conn,1,1
  while not rs.eof
    HideSort="and not(Instr(SortPath,'"&rs("SortPath")&"')>0) "&HideSort
    rs.movenext
  wend
  rs.close
  dim idCount
  dim pages
      pages=ProInfo
  dim pagec
  dim page
      page=clng(request("Page"))
  dim pagenc
      pagenc=4
  dim pagenmax
  dim pagenmin
  dim pageprevious
  dim pagenext
  datafrom="ChinaQJ_Products"
  dim datawhere
      If IsDatabaseType = 1 Then
        datawhere="where "&ViewFlag&" and NewflagEn and Charindex('"&SortPath&"',SortPath) > 0 "&HideSort& " "
      Else
        datawhere="where "&ViewFlag&" and NewflagEn and Instr(SortPath,'"&SortPath&"') > 0 "&HideSort& " "
      End If
  dim sqlid
  dim Myself,PATH_INFO,QUERY_STRING
      PATH_INFO = request.servervariables("PATH_INFO")
      QUERY_STRING = request.ServerVariables("QUERY_STRING")'
      if QUERY_STRING = "" then
        Myself = PATH_INFO & "?"
      elseif Instr(PATH_INFO & "?" & QUERY_STRING,"Page=")=0 then
        Myself= PATH_INFO & "?" & QUERY_STRING & "&"
      else
        Myself = Left(PATH_INFO & "?" & QUERY_STRING,Instr(PATH_INFO & "?" & QUERY_STRING,"Page=")-1)
      end if
  dim taxis
      taxis="order by NewFlag"&Language&" asc, UpdateTime desc, id desc"
  dim i
  sql="select count(ID) as idCount from ["& datafrom &"]" & datawhere
  set rs=server.createobject("adodb.recordset")
  rs.open sql,conn,0,1
  idCount=rs("idCount")
  if(idcount>0) then
    if(idcount mod pages=0)then
      pagec=int(idcount/pages)
    else
      pagec=int(idcount/pages)+1
    end if
    sql="select id from ["& datafrom &"] " & datawhere & taxis
    set rs=server.createobject("adodb.recordset")
    rs.open sql,conn,1,1
    rs.pagesize = pages
    if page < 1 then page = 1
    if page > pagec then page = pagec
    if pagec > 0 then rs.absolutepage = page
    for i=1 to rs.pagesize
      if rs.eof then exit for
      if(i=1)then
        sqlid=rs("id")
      else
        sqlid=sqlid &","&rs("id")
      end if
      rs.movenext
    next
  end if
  if(idcount>0 and sqlid<>"") then
    sql="select * from ["& datafrom &"] where id in("& sqlid &") "&taxis
    set rs=server.createobject("adodb.recordset")
    rs.open sql,conn,0,1
    dim tr,td
    dim ProductName,SmallPicPath,Content
    Response.Write "<table border=""0"" cellspacing=""0"" cellpadding=""0"" width=""100%"">"&VbCrLf
    Response.Write "<form action=""ProductBuy.Asp"" method=""Post"" name=""Inquire"" target=""_blank"">"&VbCrLf
    for tr=1 to 3
        Response.Write "  <tr>"&VbCrLf
        for td=1 to 4
          if StrLen(rs("ProductName"&Language))<=22 then
            ProductName=rs("ProductName"&Language)
          else
            ProductName=StrLeft(rs("ProductName"&Language),20)
          end If
            If ISHTML = 1 Then
                AutoLink = ""&SysRootDir&Language&"/"&rs("ClassSeo")&""&Separated&""&rs("ID")&"."&HTMLName&""
            Else
                AutoLink = ""&SysRootDir&Language&"/ProductView.Asp?ID="&rs("ID")&""
            End If
            SmallPicPath=HtmlSmallPic(rs("GroupID"),rs("SmallPic"),rs("Exclusive"))
            Response.Write "    <td align=""center"" valign=""top""><table width=""150"" border=""0"" cellspacing=""0"" cellpadding=""0"" style=""margin-bottom: 22px"">"&VbCrLf
            Response.Write "        <tr>"&VbCrLf
            Response.Write "          <td width=""150"" align=""center""><a href="""&rs("BigPic")&""" title="""&rs("ProductName"&Language)&""" rel=""clearbox[gallery=Green,,title="&rs("ProductName"&Language)&",,comment="&rs("ProductName"&Language)&"]""><img src="""&SmallPicPath&""" width="""&PicW&""" height="""&PicH&""" border=""0"" style=""padding: 3px; border: 1px solid #ccc"" alt="""&rs("ProductName"&Language)&""" border=""0"" /></a></td>"&VbCrLf
            Response.Write "        </tr>"&VbCrLf
            Response.Write "        <tr>"&VbCrLf
            Response.Write "          <td><img src="""&StylePath&"t.gif"" width=""1"" height=""2"" /></td>"&VbCrLf
            Response.Write "        </tr>"&VbCrLf
            Response.Write "        <tr>"&VbCrLf
            Response.Write "          <td bgcolor=""#EFEFEF"" style=""padding:4px 7px 4px 7px;""><table width=""100%"" border=""0"" cellspacing=""0"" cellpadding=""0"">"&VbCrLf
            Response.Write "              <tr>"&VbCrLf
            Response.Write "                <td height=""19"" align=""left""><a href="""&AutoLink&""" title="""&rs("ProductName"&Language)&"""><font color="""&rs("TitleColor")&""">"&left(ProductName,trimstr)&"</font></a></td>"&VbCrLf
            Response.Write "              </tr>"&VbCrLf
            Response.Write "              <tr>"&VbCrLf
            Response.Write "                <td height=""19"" align=""left"">"&ChinaQJLanguageTxt227&"：<span style=""font-size: 11px"">"&FormatDate(rs("UpdateTime"),13)&"</span>&nbsp;&nbsp;<a href="""&AutoLink&""" target=""_blank"" title="""&ChinaQJLanguageTxt228&"""><img src="""&StylePath&"zoom.gif"" border=""0"" align=""absmiddle"" /></a><input name=""ProductNo"" type=""checkbox"" id=""ProductNo"" value="""&trim(rs("ProductNo"))&""" class=""inputnoborder""></td>"&VbCrLf
            Response.Write "              </tr>"&VbCrLf
            Response.Write "            </table></td>"&VbCrLf
            Response.Write "        </tr>"&VbCrLf
            Response.Write "      </table></td>"&VbCrLf
          rs.movenext
          if rs.eof then exit for
        next
        Response.Write "  </tr>"&VbCrLf
        if rs.eof then exit for
      Next
      Response.Write "  <tr>"&VbCrLf
      Response.Write "    <td height=""50"" align=""center"" colspan=""6""><input type=""image"" src="""&StylePath&"buy_"&Language&".gif"" border=""0"" class=""inputnoborder"" /></td>"&VbCrLf
      Response.Write "  </tr>"&VbCrLf
      Response.Write "</form>"&VbCrLf
      Response.Write "</table>"&VbCrLf
  else
    response.write "<center>"&ChinaQJLanguageTxt7&"</center>"
    exit function
  end if
  Response.Write "<div class=""page"">"&VbCrLf
  Response.Write ""&ChinaQJLanguageTxt44&"<strong style=""color:red"">"&idcount&"</strong>"&ChinaQJLanguageTxt45&"&nbsp;&nbsp;&nbsp;" & vbCrLf
  pagenmin=page-pagenc
  pagenmax=page+pagenc
  if(pagenmin<1) then pagenmin=1
%>
    <span id="page">
<%
Sortid=Request("Sortid")
If ISHTML = 1 Then
If Sortid="" then
%>
        <a href="<%= ClassSeo %><%= Separated %>1.<%= HTMLName %>"><%= ChinaQJLanguageTxt313 %></a>
<% If page>1 Then %>
        <a href="<%= ClassSeo %><%= Separated %><%= page-1 %>.<%= HTMLName %>"><%= ChinaQJLanguageTxt314 %></a>
<% Else %>
        <a href="<%= ClassSeo %><%= Separated %>1.<%= HTMLName %>"><%= ChinaQJLanguageTxt313 %></a>
<% End If %>
<%
  if(pagenmax>pagec) then pagenmax=pagec
  for i = pagenmin to pagenmax
    if(i=page) then
%>
        <a href="<%= ClassSeo %><%= Separated %><%= i %>.<%= HTMLName %>" class='page_click' ><%= i %></a>
<% Else %>
        <a href="<%= ClassSeo %><%= Separated %><%= i %>.<%= HTMLName %>" class='' ><%= i %></a>
<%
End If
Next
%>
<% If page<pagenmax Then %>
        <a href="<%= ClassSeo %><%= Separated %><%= page+1 %>.<%= HTMLName %>"><%= ChinaQJLanguageTxt315 %></a>
<% Else %>
        <a href="<%= ClassSeo %><%= Separated %><%= pagenmax %>.<%= HTMLName %>"><%= ChinaQJLanguageTxt315 %></a>
<% End If %>
        <a href="<%= ClassSeo %><%= Separated %><%= pagenmax %>.<%= HTMLName %>"><%= ChinaQJLanguageTxt316 %></a>
<% Else %>
        <a href="<%= ClassSeo %><%= Separated %><%= Sortid %><%= Separated %>1.<%= HTMLName %>"><%= ChinaQJLanguageTxt313 %></a>
<% If page>1 Then %>
        <a href="<%= ClassSeo %><%= Separated %><%= Sortid %><%= Separated %><%= page-1 %>.<%= HTMLName %>"><%= ChinaQJLanguageTxt314 %></a>
<% Else %>
        <a href="<%= ClassSeo %><%= Separated %><%= Sortid %><%= Separated %>1.<%= HTMLName %>"><%= ChinaQJLanguageTxt314 %></a>
<% End If %>
<%
  if(pagenmax>pagec) then pagenmax=pagec
  for i = pagenmin to pagenmax
    if(i=page) then
%>
        <a href="<%= ClassSeo %><%= Separated %><%= Sortid %><%= Separated %><%= i %>.<%= HTMLName %>" class='page_click' ><%= i %></a>
<% Else %>
        <a href="<%= ClassSeo %><%= Separated %><%= Sortid %><%= Separated %><%= i %>.<%= HTMLName %>" class='' ><%= i %></a>
<%
End If
Next
%>
<% If page<pagenmax Then %>
        <a href="<%= ClassSeo %><%= Separated %><%= Sortid %><%= Separated %><%= page+1 %>.<%= HTMLName %>"><%= ChinaQJLanguageTxt315 %></a>
<% Else %>
        <a href="<%= ClassSeo %><%= Separated %><%= Sortid %><%= Separated %><%= pagenmax %>.<%= HTMLName %>"><%= ChinaQJLanguageTxt315 %></a>
<% End If %>
        <a href="<%= ClassSeo %><%= Separated %><%= Sortid %><%= Separated %><%= pagenmax %>.<%= HTMLName %>"><%= ChinaQJLanguageTxt316 %></a>
<% End If %>
<% Else %>
        <a href="<%= myself %>Page=1"><%= ChinaQJLanguageTxt313 %></a>
<% If page>1 Then %>
        <a href="<%= myself %>Page=<%= page-1 %>"><%= ChinaQJLanguageTxt314 %></a>
<% Else %>
        <a href="<%= myself %>Page=1"><%= ChinaQJLanguageTxt314 %></a>
<% End If %>
<%
  if(pagenmax>pagec) then pagenmax=pagec
  for i = pagenmin to pagenmax
    if(i=page) then
%>
        <a href="<%= myself %>Page=<%= i %>" class='page_click' ><%= i %></a>
<% Else %>
        <a href="<%= myself %>Page=<%= i %>" class='' ><%= i %></a>
<%
End If
Next
%>
<% If page<pagenmax Then %>
        <a href="<%= myself %>Page=<%= page+1 %>"><%= ChinaQJLanguageTxt315 %></a>
<% Else %>
        <a href="<%= myself %>Page=<%= pagenmax %>"><%= ChinaQJLanguageTxt315 %></a>
<% End If %>
        <a href="<%= myself %>Page=<%= pagenmax %>"><%= ChinaQJLanguageTxt316 %></a>
<% End If %>
    </span>
<%
  Response.Write "</div>"&VbCrLf
  rs.close
  set rs=nothing
end Function

'电子杂志
function ChinaQJMagazineListWebLocation()
  ChinaQJMagazineListWebLocation="&nbsp;"&ChinaQJLanguageTxt19&"：<a href=""Index.Asp"" class=""agray"">"&ChinaQJLanguageTxt20&"</a> - <a href=""MagazineList.Asp"" class=""agray"">"&ChinaQJLanguageTxt302&"</a>"&VbCrLf
  if request.QueryString("SortID")="" then
    ChinaQJMagazineListWebLocation=ChinaQJMagazineListWebLocation
  elseif not IsNumeric(request.QueryString("SortID")) then
    ChinaQJMagazineListWebLocation=ChinaQJMagazineListWebLocation&ChinaQJLanguageTxt16
  elseif conn.execute("select * from ChinaQJ_MagazineSort Where "&ViewFlag&" and ID="&request.QueryString("SortID")).eof then
    ChinaQJMagazineListWebLocation=ChinaQJMagazineListWebLocation&ChinaQJLanguageTxt16
  else
    dim rs,sql
    set rs = server.createobject("adodb.recordset")
    sql="select * from ChinaQJ_MagazineSort where "&ViewFlag&" and ID="&request.QueryString("SortID")
    rs.open sql,conn,1,1
    ChinaQJMagazineListWebLocation=ChinaQJMagazineListWebLocation&ChinaQJMagazineListSortPathTXT("ChinaQJ_MagazineSort",rs("ID"))
    rs.close
    set rs=nothing
  end if
end Function

function ChinaQJMagazineListSortPathTXT(DataFrom,ID)
  dim rs,sql
  Set rs=server.CreateObject("adodb.recordset")
  sql="Select * From "&DataFrom&" where "&ViewFlag&" and ID="&ID
  rs.open sql,conn,1,1
  if not rs.eof Then
  AutoLink = "MagazineList.Asp?SortID="&rs("ID")&""
  ChinaQJMagazineListSortPathTXT=ChinaQJMagazineListSortPathTXT(DataFrom,rs("ParentID"))&" - <a href="""&AutoLink&""">"&rs("SortName"&Language)&"</a>"
  end if
  rs.close
  set rs=nothing
end Function

function ChinaQJMagazineListWebContent(DataFrom,ID,SortPath,PicW,PicH,trimstr)
  dim rs,sql
  dim HideSort
  set rs = server.createobject("adodb.recordset")
  if ID="" then
    SortPath="0,"
  elseif not IsNumeric(ID) then
    response.write "<center>"&ChinaQJLanguageTxt7&"</center>"
    exit function
  elseif conn.execute("select * from "&DataFrom&" Where "&ViewFlag&" and ID="&ID).eof then
    response.write "<center>"&ChinaQJLanguageTxt7&"</center>"
    exit function
  else
    SortPath=conn.execute("select * from "&DataFrom&" Where "&ViewFlag&" and ID="&ID)("SortPath")
    conn.execute("update "&DataFrom&" set ClickNumber=ClickNumber+1 Where ID="&ID)
  end If
  If IsDatabaseType = 1 Then
    sql="select * from "&DataFrom&" Where not("&ViewFlag&") and Charindex('"&SortPath&"',SortPath) > 0"
  Else
    sql="select * from "&DataFrom&" Where not("&ViewFlag&") and Instr(SortPath,'"&SortPath&"') > 0"
  End If
  rs.open sql,conn,1,1
  while not rs.eof
    HideSort="and not(Instr(SortPath,'"&rs("SortPath")&"')>0) "&HideSort
    rs.movenext
  wend
  rs.close
  dim idCount
  dim pages
      pages=ProInfo
  dim pagec
  dim page
      page=clng(request("Page"))
  dim pagenc
      pagenc=4
  dim pagenmax
  dim pagenmin
  dim pageprevious
  dim pagenext
  datafrom="ChinaQJ_Magazine"
  dim datawhere
      If IsDatabaseType = 1 Then
        datawhere="where "&ViewFlag&" and Charindex('"&SortPath&"',SortPath) > 0 "&HideSort& " "
      Else
        datawhere="where "&ViewFlag&" and Instr(SortPath,'"&SortPath&"') > 0 "&HideSort& " "
      End If
  dim sqlid
  dim Myself,PATH_INFO,QUERY_STRING
      PATH_INFO = request.servervariables("PATH_INFO")
      QUERY_STRING = request.ServerVariables("QUERY_STRING")'
      if QUERY_STRING = "" then
        Myself = PATH_INFO & "?"
      elseif Instr(PATH_INFO & "?" & QUERY_STRING,"Page=")=0 then
        Myself= PATH_INFO & "?" & QUERY_STRING & "&"
      else
        Myself = Left(PATH_INFO & "?" & QUERY_STRING,Instr(PATH_INFO & "?" & QUERY_STRING,"Page=")-1)
      end if
  dim taxis
      taxis="order by Sequence desc "
  dim i
  sql="select count(ID) as idCount from ["& datafrom &"]" & datawhere
  set rs=server.createobject("adodb.recordset")
  rs.open sql,conn,0,1
  idCount=rs("idCount")
  if(idcount>0) then
    if(idcount mod pages=0)then
      pagec=int(idcount/pages)
    else
      pagec=int(idcount/pages)+1
    end if
    sql="select id from ["& datafrom &"] " & datawhere & taxis
    set rs=server.createobject("adodb.recordset")
    rs.open sql,conn,1,1
    rs.pagesize = pages
    if page < 1 then page = 1
    if page > pagec then page = pagec
    if pagec > 0 then rs.absolutepage = page
    for i=1 to rs.pagesize
      if rs.eof then exit for
      if(i=1)then
        sqlid=rs("id")
      else
        sqlid=sqlid &","&rs("id")
      end if
      rs.movenext
    next
  end if
  if(idcount>0 and sqlid<>"") then
    sql="select * from ["& datafrom &"] where id in("& sqlid &") "&taxis
    set rs=server.createobject("adodb.recordset")
    rs.open sql,conn,0,1
    dim tr,td
    dim MagazineName,SmallPicPath,Content
    Response.Write "<table border=""0"" cellspacing=""0"" cellpadding=""0"" width=""100%"">"&VbCrLf
    for tr=1 to 3
        Response.Write "  <tr>"&VbCrLf
        for td=1 to 4
          if StrLen(rs("MagazineName"&Language))<=22 then
            MagazineName=rs("MagazineName"&Language)
          else
            MagazineName=StrLeft(rs("MagazineName"&Language),20)
          end If
            AutoLink = ""&SysRootDir&"E-zine/index.Asp?ID="&rs("ID")&""
            Response.Write "    <td width=""180"" align=""center"" valign=""top""><table width=""150"" border=""0"" cellspacing=""0"" cellpadding=""0"" style=""margin-bottom: 22px"">"&VbCrLf
            Response.Write "        <tr>"&VbCrLf
			if SysRootDir<>"/" then
            Response.Write "          <td width=""150"" align=""center""><a href="""&AutoLink&""" title="""&rs("MagazineName"&Language)&""" target=""_blank""><img src="""&SysRootDir&rs("MagazineImage")&""" width="""&PicW&""" height="""&PicH&""" border=""0"" style=""padding: 3px; border: 1px solid #ccc"" alt="""&rs("MagazineName"&Language)&""" border=""0"" /></a></td>"&VbCrLf
			else
            Response.Write "          <td width=""150"" align=""center""><a href="""&AutoLink&""" title="""&rs("MagazineName"&Language)&""" target=""_blank""><img src="""&rs("MagazineImage")&""" width="""&PicW&""" height="""&PicH&""" border=""0"" style=""padding: 3px; border: 1px solid #ccc"" alt="""&rs("MagazineName"&Language)&""" border=""0"" /></a></td>"&VbCrLf
			end if
            Response.Write "        </tr>"&VbCrLf
            Response.Write "        <tr>"&VbCrLf
            Response.Write "          <td><img src="""&StylePath&"t.gif"" width=""1"" height=""2"" /></td>"&VbCrLf
            Response.Write "        </tr>"&VbCrLf
            Response.Write "        <tr>"&VbCrLf
            Response.Write "          <td bgcolor=""#EFEFEF"" style=""padding:4px 7px 4px 7px;""><table width=""100%"" border=""0"" cellspacing=""0"" cellpadding=""0"">"&VbCrLf
            Response.Write "              <tr>"&VbCrLf
            Response.Write "                <td height=""19"" align=""center""><a href="""&AutoLink&""" title="""&rs("MagazineName"&Language)&""" target=""_blank""><font color="""&rs("TitleColor")&""">"&left(MagazineName,trimstr)&"</font></a></td>"&VbCrLf
            Response.Write "              </tr>"&VbCrLf
            Response.Write "            </table></td>"&VbCrLf
            Response.Write "        </tr>"&VbCrLf
            Response.Write "      </table></td>"&VbCrLf
          rs.movenext
          if rs.eof then exit for
        next
        Response.Write "  </tr>"&VbCrLf
        if rs.eof then exit for
      Next
      Response.Write "</table>"&VbCrLf
  else
    response.write "<center>"&ChinaQJLanguageTxt7&"</center>"
    exit function
  end if
  Response.Write "<div class=""page"">"&VbCrLf
  Response.Write ""&ChinaQJLanguageTxt44&"<strong style=""color:red"">"&idcount&"</strong>"&ChinaQJLanguageTxt45&"&nbsp;&nbsp;&nbsp;" & vbCrLf
  pagenmin=page-pagenc
  pagenmax=page+pagenc
  if(pagenmin<1) then pagenmin=1
%>
    <span id="page">
<%
Sortid=Request("Sortid")
If ISHTML = 1 Then
If Sortid="" then
%>
        <a href="<%= ClassSeo %><%= Separated %>1.<%= HTMLName %>"><%= ChinaQJLanguageTxt313 %></a>
<% If page>1 Then %>
        <a href="<%= ClassSeo %><%= Separated %><%= page-1 %>.<%= HTMLName %>"><%= ChinaQJLanguageTxt314 %></a>
<% Else %>
        <a href="<%= ClassSeo %><%= Separated %>1.<%= HTMLName %>"><%= ChinaQJLanguageTxt313 %></a>
<% End If %>
<%
  if(pagenmax>pagec) then pagenmax=pagec
  for i = pagenmin to pagenmax
    if(i=page) then
%>
        <a href="<%= ClassSeo %><%= Separated %><%= i %>.<%= HTMLName %>" class='page_click' ><%= i %></a>
<% Else %>
        <a href="<%= ClassSeo %><%= Separated %><%= i %>.<%= HTMLName %>" class='' ><%= i %></a>
<%
End If
Next
%>
<% If page<pagenmax Then %>
        <a href="<%= ClassSeo %><%= Separated %><%= page+1 %>.<%= HTMLName %>"><%= ChinaQJLanguageTxt315 %></a>
<% Else %>
        <a href="<%= ClassSeo %><%= Separated %><%= pagenmax %>.<%= HTMLName %>"><%= ChinaQJLanguageTxt315 %></a>
<% End If %>
        <a href="<%= ClassSeo %><%= Separated %><%= pagenmax %>.<%= HTMLName %>"><%= ChinaQJLanguageTxt316 %></a>
<% Else %>
        <a href="<%= ClassSeo %><%= Separated %><%= Sortid %><%= Separated %>1.<%= HTMLName %>"><%= ChinaQJLanguageTxt313 %></a>
<% If page>1 Then %>
        <a href="<%= ClassSeo %><%= Separated %><%= Sortid %><%= Separated %><%= page-1 %>.<%= HTMLName %>"><%= ChinaQJLanguageTxt314 %></a>
<% Else %>
        <a href="<%= ClassSeo %><%= Separated %><%= Sortid %><%= Separated %>1.<%= HTMLName %>"><%= ChinaQJLanguageTxt314 %></a>
<% End If %>
<%
  if(pagenmax>pagec) then pagenmax=pagec
  for i = pagenmin to pagenmax
    if(i=page) then
%>
        <a href="<%= ClassSeo %><%= Separated %><%= Sortid %><%= Separated %><%= i %>.<%= HTMLName %>" class='page_click' ><%= i %></a>
<% Else %>
        <a href="<%= ClassSeo %><%= Separated %><%= Sortid %><%= Separated %><%= i %>.<%= HTMLName %>" class='' ><%= i %></a>
<%
End If
Next
%>
<% If page<pagenmax Then %>
        <a href="<%= ClassSeo %><%= Separated %><%= Sortid %><%= Separated %><%= page+1 %>.<%= HTMLName %>"><%= ChinaQJLanguageTxt315 %></a>
<% Else %>
        <a href="<%= ClassSeo %><%= Separated %><%= Sortid %><%= Separated %><%= pagenmax %>.<%= HTMLName %>"><%= ChinaQJLanguageTxt315 %></a>
<% End If %>
        <a href="<%= ClassSeo %><%= Separated %><%= Sortid %><%= Separated %><%= pagenmax %>.<%= HTMLName %>"><%= ChinaQJLanguageTxt316 %></a>
<% End If %>
<% Else %>
        <a href="<%= myself %>Page=1"><%= ChinaQJLanguageTxt313 %></a>
<% If page>1 Then %>
        <a href="<%= myself %>Page=<%= page-1 %>"><%= ChinaQJLanguageTxt314 %></a>
<% Else %>
        <a href="<%= myself %>Page=1"><%= ChinaQJLanguageTxt314 %></a>
<% End If %>
<%
  if(pagenmax>pagec) then pagenmax=pagec
  for i = pagenmin to pagenmax
    if(i=page) then
%>
        <a href="<%= myself %>Page=<%= i %>" class='page_click' ><%= i %></a>
<% Else %>
        <a href="<%= myself %>Page=<%= i %>" class='' ><%= i %></a>
<%
End If
Next
%>
<% If page<pagenmax Then %>
        <a href="<%= myself %>Page=<%= page+1 %>"><%= ChinaQJLanguageTxt315 %></a>
<% Else %>
        <a href="<%= myself %>Page=<%= pagenmax %>"><%= ChinaQJLanguageTxt315 %></a>
<% End If %>
        <a href="<%= myself %>Page=<%= pagenmax %>"><%= ChinaQJLanguageTxt316 %></a>
<% End If %>
    </span>
<%
  Response.Write "</div>"&VbCrLf
  rs.close
  set rs=nothing
end Function

function ChinaQJVideoListWebLocation()
  ChinaQJVideoListWebLocation="&nbsp;"&ChinaQJLanguageTxt19&"：<a href=""Index.Asp"" class=""agray"">"&ChinaQJLanguageTxt20&"</a> - <a href=""VideoList.Asp"" class=""agray"">"&ChinaQJLanguageTxt303&"</a>"&VbCrLf
  if request.QueryString("SortID")="" then
    ChinaQJVideoListWebLocation=ChinaQJVideoListWebLocation
  elseif not IsNumeric(request.QueryString("SortID")) then
    ChinaQJVideoListWebLocation=ChinaQJVideoListWebLocation&ChinaQJLanguageTxt16
  elseif conn.execute("select * from ChinaQJ_VideoSort Where "&ViewFlag&" and ID="&request.QueryString("SortID")).eof then
    ChinaQJVideoListWebLocation=ChinaQJVideoListWebLocation&ChinaQJLanguageTxt16
  else
    dim rs,sql
    set rs = server.createobject("adodb.recordset")
    sql="select * from ChinaQJ_VideoSort where "&ViewFlag&" and ID="&request.QueryString("SortID")
    rs.open sql,conn,1,1
    ChinaQJVideoListWebLocation=ChinaQJVideoListWebLocation&ChinaQJVideoListSortPathTXT("ChinaQJ_VideoSort",rs("ID"))
    rs.close
    set rs=nothing
  end if
end Function

function ChinaQJVideoListSortPathTXT(DataFrom,ID)
  dim rs,sql
  Set rs=server.CreateObject("adodb.recordset")
  sql="Select * From "&DataFrom&" where "&ViewFlag&" and ID="&ID
  rs.open sql,conn,1,1
  if not rs.eof Then
    If ISHTML = 1 Then
        AutoLink = ""&rs("ClassSeo")&""&Separated&""&rs("ID")&""&Separated&"1."&HTMLName&""
    Else
        AutoLink = "VideoList.Asp?SortID="&rs("ID")&""
    End If
    ChinaQJVideoListSortPathTXT=ChinaQJVideoListSortPathTXT(DataFrom,rs("ParentID"))&" - <a href="""&AutoLink&""">"&rs("SortName"&Language)&"</a>"
  end if
  rs.close
  set rs=nothing
end Function

function ChinaQJVideoListWebContent(DataFrom,ID,SortPath,PicW,PicH,trimstr)
  dim rs,sql
  dim HideSort
  set rs = server.createobject("adodb.recordset")
  if ID="" then
    SortPath="0,"
  elseif not IsNumeric(ID) then
    response.write "<center>"&ChinaQJLanguageTxt7&"</center>"
    exit function
  elseif conn.execute("select * from "&DataFrom&" Where "&ViewFlag&" and ID="&ID).eof then
    response.write "<center>"&ChinaQJLanguageTxt7&"</center>"
    exit function
  else
    SortPath=conn.execute("select * from "&DataFrom&" Where "&ViewFlag&" and ID="&ID)("SortPath")
    conn.execute("update "&DataFrom&" set ClickNumber=ClickNumber+1 Where ID="&ID)
  end If
  If IsDatabaseType = 1 Then
    sql="select * from "&DataFrom&" Where not("&ViewFlag&") and Charindex('"&SortPath&"',SortPath) > 0"
  Else
    sql="select * from "&DataFrom&" Where not("&ViewFlag&") and Instr(SortPath,'"&SortPath&"') > 0"
  End If
  rs.open sql,conn,1,1
  while not rs.eof
    HideSort="and not(Instr(SortPath,'"&rs("SortPath")&"')>0) "&HideSort
    rs.movenext
  wend
  rs.close
  dim idCount
  dim pages
      pages=ProInfo
  dim pagec
  dim page
      page=clng(request("Page"))
  dim pagenc
      pagenc=4
  dim pagenmax
  dim pagenmin
  dim pageprevious
  dim pagenext
  datafrom="ChinaQJ_Video"
  dim datawhere
      If IsDatabaseType = 1 Then
        datawhere="where "&ViewFlag&" and Charindex('"&SortPath&"',SortPath) > 0 "&HideSort& " "
      Else
        datawhere="where "&ViewFlag&" and Instr(SortPath,'"&SortPath&"') > 0 "&HideSort& " "
      End If
  dim sqlid
  dim Myself,PATH_INFO,QUERY_STRING
      PATH_INFO = request.servervariables("PATH_INFO")
      QUERY_STRING = request.ServerVariables("QUERY_STRING")'
      if QUERY_STRING = "" then
        Myself = PATH_INFO & "?"
      elseif Instr(PATH_INFO & "?" & QUERY_STRING,"Page=")=0 then
        Myself= PATH_INFO & "?" & QUERY_STRING & "&"
      else
        Myself = Left(PATH_INFO & "?" & QUERY_STRING,Instr(PATH_INFO & "?" & QUERY_STRING,"Page=")-1)
      end if
  dim taxis
      taxis="order by Sequence desc "
  dim i
  sql="select count(ID) as idCount from ["& datafrom &"]" & datawhere
  set rs=server.createobject("adodb.recordset")
  rs.open sql,conn,0,1
  idCount=rs("idCount")
  if(idcount>0) then
    if(idcount mod pages=0)then
      pagec=int(idcount/pages)
    else
      pagec=int(idcount/pages)+1
    end if
    sql="select id from ["& datafrom &"] " & datawhere & taxis
    set rs=server.createobject("adodb.recordset")
    rs.open sql,conn,1,1
    rs.pagesize = pages
    if page < 1 then page = 1
    if page > pagec then page = pagec
    if pagec > 0 then rs.absolutepage = page
    for i=1 to rs.pagesize
      if rs.eof then exit for
      if(i=1)then
        sqlid=rs("id")
      else
        sqlid=sqlid &","&rs("id")
      end if
      rs.movenext
    next
  end if
  if(idcount>0 and sqlid<>"") then
    sql="select * from ["& datafrom &"] where id in("& sqlid &") "&taxis
    set rs=server.createobject("adodb.recordset")
    rs.open sql,conn,0,1
    dim tr,td
    dim VideoName,SmallPicPath,Content
    Response.Write "<table border=""0"" cellspacing=""0"" cellpadding=""0"">"&VbCrLf
    for tr=1 to 3
        Response.Write "  <tr>"&VbCrLf
        for td=1 to 4
          if StrLen(rs("VideoName"&Language))<=22 then
            VideoName=rs("VideoName"&Language)
          else
            VideoName=StrLeft(rs("VideoName"&Language),20)
          end If
		    if left(rs("videourl"),4)="http" then
                AutoLink = rs("videourl")
			else
                AutoLink = rs("videourl")
            End If
            Response.Write "    <td width=""180"" align=""center"" valign=""top""><table width=""150"" border=""0"" cellspacing=""0"" cellpadding=""0"" style=""margin-bottom: 22px"">"&VbCrLf
            Response.Write "        <tr>"&VbCrLf
            Response.Write "          <td width=""150"" align=""center""><a href="""&AutoLink&""" rel=""ChinaQJ[width=700,,height=490,,title="&rs("VideoName"&Language)&"]"" title="""&rs("VideoName"&Language)&"""><img src="""&SysRootDir&rs("VideoImage")&""" width="""&PicW&""" height="""&PicH&""" border=""0"" style=""padding: 3px; border: 1px solid #ccc"" alt="""&rs("VideoName"&Language)&""" border=""0"" /></a></td>"&VbCrLf
            Response.Write "        </tr>"&VbCrLf
            Response.Write "        <tr>"&VbCrLf
            Response.Write "          <td><img src="""&StylePath&"t.gif"" width=""1"" height=""2"" /></td>"&VbCrLf
            Response.Write "        </tr>"&VbCrLf
            Response.Write "        <tr>"&VbCrLf
            Response.Write "          <td bgcolor=""#EFEFEF"" style=""padding:4px 7px 4px 7px;""><table width=""100%"" border=""0"" cellspacing=""0"" cellpadding=""0"">"&VbCrLf
            Response.Write "              <tr>"&VbCrLf
            Response.Write "                <td height=""19"" align=""center""><a href="""&AutoLink&""" title="""&rs("VideoName"&Language)&"""><font color="""&rs("TitleColor")&""">"&left(VideoName,trimstr)&"</font></a></td>"&VbCrLf
            Response.Write "              </tr>"&VbCrLf
            Response.Write "            </table></td>"&VbCrLf
            Response.Write "        </tr>"&VbCrLf
            Response.Write "      </table></td>"&VbCrLf
          rs.movenext
          if rs.eof then exit for
        next
        Response.Write "  </tr>"&VbCrLf
        if rs.eof then exit for
      Next
      Response.Write "</table>"&VbCrLf
  else
    response.write "<center>"&ChinaQJLanguageTxt7&"</center>"
    exit function
  end if
  Response.Write "<div class=""page"">"&VbCrLf
  Response.Write ""&ChinaQJLanguageTxt44&"<strong style=""color:red"">"&idcount&"</strong>"&ChinaQJLanguageTxt45&"&nbsp;&nbsp;&nbsp;" & vbCrLf
  pagenmin=page-pagenc
  pagenmax=page+pagenc
  if(pagenmin<1) then pagenmin=1
%>
    <span id="page">
<%
Sortid=Request("Sortid")
If ISHTML = 1 Then
If Sortid="" then
%>
        <a href="<%= ClassSeo %><%= Separated %>1.<%= HTMLName %>"><%= ChinaQJLanguageTxt313 %></a>
<% If page>1 Then %>
        <a href="<%= ClassSeo %><%= Separated %><%= page-1 %>.<%= HTMLName %>"><%= ChinaQJLanguageTxt314 %></a>
<% Else %>
        <a href="<%= ClassSeo %><%= Separated %>1.<%= HTMLName %>"><%= ChinaQJLanguageTxt313 %></a>
<% End If %>
<%
  if(pagenmax>pagec) then pagenmax=pagec
  for i = pagenmin to pagenmax
    if(i=page) then
%>
        <a href="<%= ClassSeo %><%= Separated %><%= i %>.<%= HTMLName %>" class='page_click' ><%= i %></a>
<% Else %>
        <a href="<%= ClassSeo %><%= Separated %><%= i %>.<%= HTMLName %>" class='' ><%= i %></a>
<%
End If
Next
%>
<% If page<pagenmax Then %>
        <a href="<%= ClassSeo %><%= Separated %><%= page+1 %>.<%= HTMLName %>"><%= ChinaQJLanguageTxt315 %></a>
<% Else %>
        <a href="<%= ClassSeo %><%= Separated %><%= pagenmax %>.<%= HTMLName %>"><%= ChinaQJLanguageTxt315 %></a>
<% End If %>
        <a href="<%= ClassSeo %><%= Separated %><%= pagenmax %>.<%= HTMLName %>"><%= ChinaQJLanguageTxt316 %></a>
<% Else %>
        <a href="<%= ClassSeo %><%= Separated %><%= Sortid %><%= Separated %>1.<%= HTMLName %>"><%= ChinaQJLanguageTxt313 %></a>
<% If page>1 Then %>
        <a href="<%= ClassSeo %><%= Separated %><%= Sortid %><%= Separated %><%= page-1 %>.<%= HTMLName %>"><%= ChinaQJLanguageTxt314 %></a>
<% Else %>
        <a href="<%= ClassSeo %><%= Separated %><%= Sortid %><%= Separated %>1.<%= HTMLName %>"><%= ChinaQJLanguageTxt314 %></a>
<% End If %>
<%
  if(pagenmax>pagec) then pagenmax=pagec
  for i = pagenmin to pagenmax
    if(i=page) then
%>
        <a href="<%= ClassSeo %><%= Separated %><%= Sortid %><%= Separated %><%= i %>.<%= HTMLName %>" class='page_click' ><%= i %></a>
<% Else %>
        <a href="<%= ClassSeo %><%= Separated %><%= Sortid %><%= Separated %><%= i %>.<%= HTMLName %>" class='' ><%= i %></a>
<%
End If
Next
%>
<% If page<pagenmax Then %>
        <a href="<%= ClassSeo %><%= Separated %><%= Sortid %><%= Separated %><%= page+1 %>.<%= HTMLName %>"><%= ChinaQJLanguageTxt315 %></a>
<% Else %>
        <a href="<%= ClassSeo %><%= Separated %><%= Sortid %><%= Separated %><%= pagenmax %>.<%= HTMLName %>"><%= ChinaQJLanguageTxt315 %></a>
<% End If %>
        <a href="<%= ClassSeo %><%= Separated %><%= Sortid %><%= Separated %><%= pagenmax %>.<%= HTMLName %>"><%= ChinaQJLanguageTxt316 %></a>
<% End If %>
<% Else %>
        <a href="<%= myself %>Page=1"><%= ChinaQJLanguageTxt313 %></a>
<% If page>1 Then %>
        <a href="<%= myself %>Page=<%= page-1 %>"><%= ChinaQJLanguageTxt314 %></a>
<% Else %>
        <a href="<%= myself %>Page=1"><%= ChinaQJLanguageTxt314 %></a>
<% End If %>
<%
  if(pagenmax>pagec) then pagenmax=pagec
  for i = pagenmin to pagenmax
    if(i=page) then
%>
        <a href="<%= myself %>Page=<%= i %>" class='page_click' ><%= i %></a>
<% Else %>
        <a href="<%= myself %>Page=<%= i %>" class='' ><%= i %></a>
<%
End If
Next
%>
<% If page<pagenmax Then %>
        <a href="<%= myself %>Page=<%= page+1 %>"><%= ChinaQJLanguageTxt315 %></a>
<% Else %>
        <a href="<%= myself %>Page=<%= pagenmax %>"><%= ChinaQJLanguageTxt315 %></a>
<% End If %>
        <a href="<%= myself %>Page=<%= pagenmax %>"><%= ChinaQJLanguageTxt316 %></a>
<% End If %>
    </span>
<%
  Response.Write "</div>"&VbCrLf
  rs.close
  set rs=nothing
end Function

function ChinaQJProductBuyWebLocation()
  ChinaQJProductBuyWebLocation="&nbsp;"&ChinaQJLanguageTxt19&"：<a href=""Index.Asp"" class=""agray"">"&ChinaQJLanguageTxt20&"</a> - <a href=""ProductList.Asp"" class=""agray"">"&ChinaQJLanguageTxt226&"</a> - "&ChinaQJLanguageTxt265&""&VbCrLf
end Function

function ChinaQJProductBuyNoList()
  if request("UpdateOrder")=ChinaQJLanguageTxt185 then
    Session("ChinaQJProductBuyNoList")=""
  end if
  dim ProductNo,NoArray,i
  if trim(request("ProductNo"))<>"" then ProductNo=trim(request("ProductNo"))&","
  if session("ChinaQJProductBuyNoList")="" and trim(request("ProductNo"))="" then
    ChinaQJProductBuyNoList=""
    exit function
  end if
  if instr(ProductNo,",")>0 then
    NoArray=split(ProductNo, ",")
    for i = 0 to ubound(NoArray)
      if not instr(session("ChinaQJProductBuyNoList"),NoArray(i)&",")>0 then session("ChinaQJProductBuyNoList")=session("ChinaQJProductBuyNoList")&NoArray(i)&","
    next
  end if
  for i = 0 to ubound(split(session("ChinaQJProductBuyNoList"), ","))
    ChinaQJProductBuyNoList=ChinaQJProductBuyNoList&"'"&trim(split(session("ChinaQJProductBuyNoList"),",")(i))&"',"
  next
  ChinaQJProductBuyNoList=left(ChinaQJProductBuyNoList,len(ChinaQJProductBuyNoList)-4)
end Function

function ChinaQJProductBuyProductList()
    Response.Write "<table width=""100%"" border=""0"" cellspacing=""0"" cellpadding=""0"">"&VbCrLf
    Response.Write "  <form action=""ProductBuy.Asp"" method=""POST"" name=""check"">"&VbCrLf
    Response.Write "    <tr>"&VbCrLf
    Response.Write "      <td height=""28"" colspan=""2"" style=""background:url("&StylePath&"bg2.gif) repeat-x left bottom;"">"&ChinaQJLanguageTxt186&"：</td>"&VbCrLf
    Response.Write "    </tr>"&VbCrLf
if ChinaQJProductBuyNoList()="" then
    Response.Write "    <tr>"&VbCrLf
    Response.Write "      <td height=""28"" colspan=""2"" align=""center"">"&ChinaQJLanguageTxt187&"</td>"&VbCrLf
    Response.Write "    </tr>"&VbCrLf
else
    dim rs,sql
    set rs = server.createobject("adodb.recordset")
    sql="select * from ChinaQJ_Products where ProductNo in ("&ChinaQJProductBuyNoList()&") order by id"
    rs.open sql,conn,1,1
    while not rs.eof
    If ISHTML = 1 Then
        AutoLink = ""&rs("ClassSeo")&""&Separated&""&rs("ID")&"."&HTMLName&""
    Else
        AutoLink = "ProductView.Asp?ID="&rs("ID")&""
    End If
    Response.Write "    <tr>"&VbCrLf
    Response.Write "      <td width=""3%"" height=""28"" style=""background:url("&StylePath&"bg2.gif) repeat-x left bottom;""><input type=""CheckBox"" name=""ProductNo"" value="""&rs("ProductNo")&""" class=""inputnoborder"" Checked></td>"&VbCrLf
    Response.Write "      <td width=""97%"" style=""background:url("&StylePath&"bg2.gif) repeat-x left bottom;""><a href="""&AutoLink&""" title="""&rs("ProductName"&Language)&""">"&rs("ProductName"&Language)&" ["&rs("ProductNo")&"]</a></td>"&VbCrLf
    Response.Write "    </tr>"&VbCrLf
    Products=Products&rs("ProductName"&Language)&" "&ChinaQJLanguageTxt56&"："&rs("ProductNo")&"<br>"
    rs.movenext
    wend
    Response.Write "    <tr>"&VbCrLf
    Response.Write "      <td colspan=""2"" height=""35""><input type=""submit"" name=""UpdateOrder"" value="""&ChinaQJLanguageTxt185&"""></td>"&VbCrLf
    Response.Write "    </tr>"&VbCrLf
    rs.close
    set rs=nothing
end if
    Response.Write "  </form>"&VbCrLf
    Response.Write "</table>"&VbCrLf
end function

sub ChinaQJProductBuyMemInfo()
  dim rs,sql
  set rs = server.createobject("adodb.recordset")
  sql="select * from ChinaQJ_Members where MemName='"&session("MemName")&"'"
  rs.open sql,conn,1,1
  if rs.bof and rs.eof then
    response.write "<center>"&ChinaQJLanguageTxt7&"</center>"
  else
    mMemID=rs("ID")
    if not rs("RealName")="" then
      mRealName=rs("RealName")
    else
      mRealName=rs("MemName")
    end if
    mSex=rs("Sex")
    mCompany=rs("Company")
    mAddress=rs("Address")
    mZipCode=rs("ZipCode")
    mTelephone=rs("Telephone")
    mFax=rs("Fax")
    mMobile=rs("Mobile")
    mEmail=rs("Email")
  end if
  rs.close
  set rs=nothing
end Sub

function ChinaQJProductBuyForm()
    Response.Write "            <table width=""100%"" border=""0"" align=""center"" cellpadding=""3"" cellspacing=""5"">"&VbCrLf
    Response.Write "              <form action=""ProductBuySave.Asp?MemberID="&mMemID&""" method=""post"" name=""formBuy"" id=""formBuy"">"&VbCrLf
    Response.Write "                <tr>"&VbCrLf
    Response.Write "                  <td width=""200"" align=""right"">"&ChinaQJLanguageTxt181&"：</td>"&VbCrLf
    Response.Write "                  <td><input name=""OrderName"" type=""text"" id=""OrderName"" value="""&ChinaQJLanguageTxt181&""" size=""40"" maxlength=""100"" />"&VbCrLf
    Response.Write "                    <font color=""red"">*</font></td>"&VbCrLf
    Response.Write "                </tr>"&VbCrLf
    Response.Write "                <tr>"&VbCrLf
    Response.Write "                  <td align=""right"">"&ChinaQJLanguageTxt182&"：</td>"&VbCrLf
    Response.Write "                  <td><input type=""hidden"" name=""Products"" value="""&Products&""" />"&VbCrLf
    Response.Write "                    <textarea name=""Remark"" cols=""80"" rows=""8"" id=""Remark""></textarea></td>"&VbCrLf
    Response.Write "                </tr>"&VbCrLf
    Response.Write "                <tr>"&VbCrLf
    Response.Write "                  <td align=""right"">"&ChinaQJLanguageTxt183&"：</td>"&VbCrLf
    Response.Write "                  <td><input name=""RealName"" type=""text"" id=""RealName"" value="""&mRealName&""" size=""20"" maxlength=""50"" />"&VbCrLf
    Response.Write "                    <font color=""red"">*</font></td>"&VbCrLf
    Response.Write "                </tr>"&VbCrLf
	if Instr(UserCartPurview,"|6,")>0 then
    Response.Write "                <tr>"&VbCrLf
    Response.Write "                  <td align=""right"">"&ChinaQJLanguageTxt90&"：</td>"&VbCrLf
    Response.Write "                  <td><input name=""Sex"" type=""radio"" value="""&ChinaQJLanguageTxt91&""" class=""inputnoborder"" "
    if mSex=ChinaQJLanguageTxt91 Then response.write ("checked")
    response.write " />"&VbCrLf
    Response.Write "                    "&ChinaQJLanguageTxt91&""&VbCrLf
    Response.Write "                    <input type=""radio"" name=""Sex"" value="""&ChinaQJLanguageTxt92&""" class=""inputnoborder"" "
    if mSex=ChinaQJLanguageTxt92 Then response.write ("checked")
    response.write " />"&VbCrLf
    Response.Write "                    "&ChinaQJLanguageTxt92&" "
	if Instr(UserCartPurviewDis,"|6,")>0 then Response.Write "<font color=""red"">*</font>"
	Response.Write "</td>"&VbCrLf
    Response.Write "                </tr>"&VbCrLf
	end if
	if Instr(UserCartPurview,"|7,")>0 then
    Response.Write "                <tr>"&VbCrLf
    Response.Write "                  <td align=""right"">"&ChinaQJLanguageTxt99&"：</td>"&VbCrLf
    Response.Write "                  <td><input name=""Company"" type=""text"" id=""Company"" value="""&mCompany&""" size=""40"" maxlength=""100"" />"&VbCrLf
	if Instr(UserCartPurviewDis,"|7,")>0 then Response.Write "<font color=""red"">*</font>"
	Response.Write "</td>"&VbCrLf
    Response.Write "                </tr>"&VbCrLf
	end if
    Response.Write "                <tr>"&VbCrLf
    Response.Write "                  <td align=""right"">"&ChinaQJLanguageTxt100&"：</td>"&VbCrLf
    Response.Write "                  <td><input name=""Address"" type=""text"" id=""Address"" value="""&mAddress&""" size=""40"" maxlength=""100"" />"&VbCrLf
    Response.Write "                    <font color=""red"">*</font></td>"&VbCrLf
    Response.Write "                </tr>"&VbCrLf
	if Instr(UserCartPurview,"|8,")>0 then
    Response.Write "                <tr>"&VbCrLf
    Response.Write "                  <td align=""right"">"&ChinaQJLanguageTxt34&"：</td>"&VbCrLf
    Response.Write "                  <td><input name=""ZipCode"" type=""text"" id=""ZipCode"" value="""&mZipCode&""" size=""20"" maxlength=""20"" />"&VbCrLf
	if Instr(UserCartPurviewDis,"|8,")>0 then Response.Write "<font color=""red"">*</font>"
	Response.Write "</td>"&VbCrLf
    Response.Write "                </tr>"&VbCrLf
	end if
    Response.Write "                <tr>"&VbCrLf
    Response.Write "                  <td align=""right"">"&ChinaQJLanguageTxt27&"：</td>"&VbCrLf
    Response.Write "                  <td><input name=""Telephone"" type=""text"" id=""Telephone"" value="""&mTelephone&""" size=""20"" maxlength=""50"" />"&VbCrLf
    Response.Write "                    <font color=""red"">*</font></td>"&VbCrLf
    Response.Write "                </tr>"&VbCrLf
	if Instr(UserCartPurview,"|9,")>0 then
    Response.Write "                <tr>"&VbCrLf
    Response.Write "                  <td align=""right"">"&ChinaQJLanguageTxt35&"：</td>"&VbCrLf
    Response.Write "                  <td><input name=""Fax"" type=""text"" id=""Fax"" value="""&mFax&""" size=""20"" maxlength=""50"" /></td>"&VbCrLf
    Response.Write "                </tr>"&VbCrLf
	if Instr(UserCartPurviewDis,"|9,")>0 then Response.Write "<font color=""red"">*</font>"
	Response.Write "</td>"&VbCrLf
    Response.Write "                </tr>"&VbCrLf
	end if
	if Instr(UserCartPurview,"|10,")>0 then
    Response.Write "                <tr>"&VbCrLf
    Response.Write "                  <td align=""right"">"&ChinaQJLanguageTxt26&"：</td>"&VbCrLf
    Response.Write "                  <td><input name=""Mobile"" type=""text"" id=""Mobile"" value="""&mMobile&""" size=""20"" maxlength=""50"" />"&VbCrLf
	if Instr(UserCartPurviewDis,"|10,")>0 then Response.Write "<font color=""red"">*</font>"
	Response.Write "</td>"&VbCrLf
    Response.Write "                </tr>"&VbCrLf
	end if
	if Instr(UserCartPurview,"|11,")>0 then
    Response.Write "                <tr>"&VbCrLf
    Response.Write "                  <td align=""right"">"&ChinaQJLanguageTxt101&"：</td>"&VbCrLf
    Response.Write "                  <td><input name=""Email"" type=""text"" id=""Email"" value="""&mEmail&""" size=""30"" maxlength=""50"" />"&VbCrLf
	if Instr(UserCartPurviewDis,"|11,")>0 then Response.Write "<font color=""red"">*</font>"
	Response.Write "</td>"&VbCrLf
    Response.Write "                </tr>"&VbCrLf
	end if
    Response.Write "                <tr>"&VbCrLf
    Response.Write "                  <td align=""right"">"&ChinaQJLanguageTxt107&"：</td>"&VbCrLf
    Response.Write "                  <td><input name=""CheckCode"" type=""text"" size=""6"" maxlength=""6"" />"&VbCrLf
    Response.Write "                    <a href=""javascript:refreshimg()"" title="""&ChinaQJLanguageTxt108&"""><img src=""../Include/CheckCode/CheckCode.Asp"" name=""checkcode"" align=""absmiddle"" id=""checkcode"" style=""border: 1px solid #ffffff"" /></a> <font color=""red"">*</font></td>"&VbCrLf
    Response.Write "                </tr>"&VbCrLf
    Response.Write "                <tr>"&VbCrLf
    Response.Write "                  <td align=""right"">&nbsp;</td>"&VbCrLf
    Response.Write "                  <td><input name=""Submit"" type=""submit"" value="""&ChinaQJLanguageTxt184&""" /></td>"&VbCrLf
    Response.Write "                </tr>"&VbCrLf
    Response.Write "              </form>"&VbCrLf
    Response.Write "            </table>"&VbCrLf
end Function

Function ChinaQJOtherFolder(id)
  Dim rs,sql,i,ChildCount,FolderType,FolderName,onMouseUp,ListType
  Set rs=server.CreateObject("adodb.recordset")
  sql="Select * From ChinaQJ_OthersSort where "&ViewFlag&" And ParentID="&id&" order by Sequence desc,ID desc"
  rs.open sql,conn,1,1
    if id=0 and rs.recordcount=0 then
        response.write "<center>"&ChinaQJLanguageTxt7&"</center>"
        exit function
    end if
  i=1
  response.write("<table border=""0"" cellspacing=""1"" cellpadding=""2"">")
  while not rs.eof
    ChildCount=conn.execute("select count(*) from ChinaQJ_OthersSort where ParentID="&rs("id"))(0)
    if ChildCount=0 then
      if i=rs.recordcount then
        FolderType="SortFileEnd"
      else
        FolderType="SortFile"
      end if
      FolderName=rs("SortName"&Language)
      onMouseUp=""
    else
      if i=rs.recordcount then
        FolderType="SortEndFolderClose"
        ListType="SortEndListline"
        onMouseUp="EndSortChange('a"&rs("id")&"','b"&rs("id")&"');"
      else
      If SortStart = 0 Then
        FolderType="SortFolderOpen"
      Else
        FolderType="SortFolderClose"
      End If
        ListType="SortListline"
        onMouseUp="SortChange('a"&rs("id")&"','b"&rs("id")&"');"
      end if
      FolderName=rs("SortName"&Language)
    end If
    datafrom="ChinaQJ_OthersSort"
    If ISHTML = 1 Then
        AutoLink = ""&rs("ClassSeo")&""&Separated&""&rs("ID")&""&Separated&"1."&HTMLName&""
    Else
        AutoLink = "OtherList.Asp?SortID="&rs("ID")&""
    End If
    response.write("<tr>")
    response.write("<td nowrap id=""b"&rs("id")&""" onMouseUp="""&onMouseUp&""" class="""&FolderType&"""></td><td nowrap style=""padding-top: 3px""><a href="""&AutoLink&""">"&FolderName&"</a></td></tr>")
    if ChildCount>0 then
%>
<%If SortStart = 0 Then%>
<tr id="a<%=rs("id")%>" style="display: none">
<%Else%>
<tr id="a<%=rs("id")%>" style="display: yes">
<%End If%>
  <td class="<%=ListType%>" nowrap></td>
  <td><% ChinaQJOtherFolder(rs("id")) %></td>
</tr>
<%
    end if
    rs.movenext
    i=i+1
    wend
    response.write("</table>")
    rs.close
    set rs=nothing
end Function

function ChinaQJOtherWebLocation()
  ChinaQJOtherWebLocation="&nbsp;"&ChinaQJLanguageTxt19&"：<a href=""Index.Asp"" class=""agray"">"&ChinaQJLanguageTxt20&"</a> - <a href=""OtherList.Asp"" class=""agray"">"&ChinaQJLanguageTxt144&"</a>"&VbCrLf
  if request.QueryString("ID")="" then
    ChinaQJOtherWebLocation=ChinaQJOtherWebLocation
  elseif not IsNumeric(request.QueryString("ID")) then
    ChinaQJOtherWebLocation=ChinaQJOtherWebLocation&ChinaQJLanguageTxt16
  elseif conn.execute("select * from ChinaQJ_Others Where "&ViewFlag&" and ID="&request.QueryString("ID")).eof then
    ChinaQJOtherWebLocation=ChinaQJOtherWebLocation&ChinaQJLanguageTxt16
  else
    dim rs,sql
    set rs = server.createobject("adodb.recordset")
    sql="select * from ChinaQJ_Others where "&ViewFlag&" and ID="&request.QueryString("ID")
    rs.open sql,conn,1,1
    ChinaQJOtherWebLocation=ChinaQJOtherWebLocation&ChinaQJOtherSortPathTXT("ChinaQJ_OthersSort",rs("SortID"))
    rs.close
    set rs=nothing
  end if
end Function

function ChinaQJOtherSortPathTXT(DataFrom,ID)
  dim rs,sql
  Set rs=server.CreateObject("adodb.recordset")
  sql="Select * From "&DataFrom&" where "&ViewFlag&" and ID="&ID
  rs.open sql,conn,1,1
  if not rs.eof Then
    If ISHTML = 1 Then
        AutoLink = ""&rs("ClassSeo")&""&Separated&""&rs("ID")&""&Separated&"1."&HTMLName&""
    Else
        AutoLink = "OtherList.Asp?SortID="&rs("ID")&""
    End If
    ChinaQJOtherSortPathTXT=ChinaQJOtherSortPathTXT(DataFrom,rs("ParentID"))&" - <a href="""&AutoLink&"""><span style=""color:#EC0000"">"&rs("SortName"&Language)&"</span></a>"
  end if
  rs.close
  set rs=nothing
end Function

function ChinaQJOtherDetail()
    Response.Write "<table width=""100%"" border=""0"" cellspacing=""0"" cellpadding=""0"" align=""center"">"&VbCrLf
    Response.Write "    <tr>"&VbCrLf
    Response.Write "        <td>"&VbCrLf
    Response.Write "      <table width=""100%"" border=""0"" cellspacing=""0"" cellpadding=""0"">"&VbCrLf
    Response.Write "              <tr>"&VbCrLf
    Response.Write "                <td width=""30"" height=""36""><img src="""&StylePath&"title_bg1.gif"" width=""30"" height=""36"" /></td>"&VbCrLf
    Response.Write "                <td width=""100%"" align=""center"" background="""&StylePath&"title_bg_center.jpg"" style=""color:#000000; font-size:14px; font-weight:bold"">"&VbCrLf
      ID=request.QueryString("ID")
      if ID="" or not IsNumeric(ID) then
        response.write "<center>"&ChinaQJLanguageTxt7&"</center>"
      elseif conn.execute("select * from ChinaQJ_Others Where "&ViewFlag&" and ID="&ID).eof then
        response.write "<center>"&ChinaQJLanguageTxt7&"</center>"
      else
        dim rs,sql
        set rs = server.createobject("adodb.recordset")
        sql="select * from ChinaQJ_Others where "&ViewFlag&" and ID="&ID
        rs.open sql,conn,1,3
        Response.Write ""&rs("OthersName"&Language)&""&VbCrLf
      End If
    Response.Write "                </td>"&VbCrLf
    Response.Write "                <td width=""30""><img src="""&StylePath&"title_bg2.gif"" width=""30"" height=""36"" /></td>"&VbCrLf
    Response.Write "              </tr>"&VbCrLf
    Response.Write "              <tr>" & vbCrLf
    Response.Write "                <td><img src=""" & StylePath & "title_bg3.gif"" width=""30"" height=""14"" /></td>" & vbCrLf
    Response.Write "                <td background=""" & StylePath & "title_bg_center2.jpg"">&nbsp;</td>" & vbCrLf
    Response.Write "                <td><img src=""" & StylePath & "title_bg4.gif"" width=""30"" height=""14"" /></td>" & vbCrLf
    Response.Write "              </tr>" & vbCrLf
    Response.Write "            </table></td>"&VbCrLf
    Response.Write "        </tr>"&VbCrLf
    if ViewNoRight(rs("GroupID"),rs("Exclusive")) Then
    Response.Write "        <tr>"&VbCrLf
    Response.Write "          <td align=""center"" style=""color:#999999""><strong>"&ChinaQJLanguageTxt54&"：</strong>"&FormatDate(rs("UpdateTime"),13)&" <strong>"&ChinaQJLanguageTxt18&"：</strong><script language=""javascript"" src=""HitCount.Asp?id="&rs("ID")&"&LX=ChinaQJ_Others""></script><script language=""javascript"" src=""HitCount.Asp?action=count&LX=ChinaQJ_Others&id="&rs("ID")&"""></script></td>"&VbCrLf
    Response.Write "        </tr>"&VbCrLf
    Response.Write "        <tr>"&VbCrLf
    Response.Write "          <td height=""20"">&nbsp;</td>"&VbCrLf
    Response.Write "        </tr>"&VbCrLf
    Response.Write "        <tr>"&VbCrLf
    Response.Write "          <td style=""line-height:25px; font-size:12px; padding-left: 8px; padding-right: 8px"" class=""SiteLink"">"&VbCrLf
    ContentStr=split(rs("Content"&Language),"{＄html_Paging＄}")
    For i=pageNum to pageNum
    Response.Write ""&ProcessSitelink(ContentStr(i)) &""
    Next
    Response.Write "          </td>"&VbCrLf
    Response.Write "        </tr>"&VbCrLf
    Response.Write "        <tr>"&VbCrLf
    Response.Write "          <td height=""20"" align=""right"" style=""padding-right: 18px"">"&VbCrLf
    %>
    <%=ChinaQJLanguageTxt250%><%For p = 0 to ubound(ContentStr)%> <a href="OtherView.Asp?ID=<%=request("ID")%>&page=<%=p%>"><font color="red"><%=p+1%></font></a> <%Next%><%=ChinaQJLanguageTxt50%>
    <%
    Response.Write "          </td>"&VbCrLf
    Response.Write "        </tr>"&VbCrLf
    Else
    Response.Write "        <tr>"&VbCrLf
    Response.Write "          <td align=""center""><img src="""&StylePath&"NoRight_"&Language&".jpg""></td>"&VbCrLf
    Response.Write "        </tr>"&VbCrLf
    end if
    rs.update
    rs.close
    Set rs = Server.CreateObject("Adodb.Recordset")
    If Request.QueryString("ID") = "" Or Not IsNumeric(Request.QueryString("ID")) Then
        sql = "Select Top 1 TheTags" & Language & " From ChinaQJ_Others Where " & ViewFlag & " Order By Sequence Desc,ID Desc"
    Else
        sql = "Select TheTags" & Language & " From ChinaQJ_Others Where " & ViewFlag & " And ID = " & Request.QueryString("ID")
    End If
    rs.Open sql, conn, 1, 1
    If Not rs.EOF Then
        If rs("TheTags" & Language) <> "" Then
            Response.Write "        <tr>" & vbCrLf
            Response.Write "          <td height=""25"" align=""right"" style=""padding-left: 8px; padding-right: 8px;"">" & vbCrLf
            Response.Write "          <font color=""#005AA0"">Tags：</font>" & vbCrLf
            TheTags = Split(rs("TheTags" & Language), ",")
            For i = 0 To UBound(TheTags)
                Response.Write "<a href=""Search.Asp?Range=Other&Keyword=" & TheTags(i) & """>"
                Response.Write "<font color=""#CC3C3C""><u>"
                Response.Write TheTags(i) & ""
                Response.Write "</u></font>"
                Response.Write "</a> "
            Next
            Response.Write "          </td>" & vbCrLf
            Response.Write "        </tr>" & vbCrLf
        End If
    End If
    rs.Close
    Set rs = Nothing
    Response.Write "        <tr>"&VbCrLf
    Response.Write "          <td height=""25"">"&VbCrLf
    Dim IDmax,IDmin
    IDmax = ID+1
    Set rs = server.createobject("adodb.recordset")
    sql="select * from ChinaQJ_Others where "&ViewFlag&" and ID<"&ID&" order by id desc"
    rs.open sql,conn,1,1
    If Not rs.eof Then
    If ISHTML = 1 Then
        AutoLink = ""&rs("ClassSeo")&""&Separated&""&rs("ID")&"."&HTMLName&""
    Else
        AutoLink = "OtherView.Asp?ID="&rs("ID")&""
    End If
    Response.Write ""&ChinaQJLanguageTxt248&"<a href="""&AutoLink&"""><font color="""&rs("TitleColor")&""">"&rs("OthersName"&Language)&"</font></a>"
    Else
    Response.Write ""&ChinaQJLanguageTxt248&""&ChinaQJLanguageTxt249&""
    End If
    rs.close
    Response.Write "          </td>"&VbCrLf
    Response.Write "        </tr>"&VbCrLf
    Response.Write "        <tr>"&VbCrLf
    Response.Write "          <td height=""25"">"&VbCrLf
    IDmin = ID-1
    Set rs = server.createobject("adodb.recordset")
    sql="select * from ChinaQJ_Others where "&ViewFlag&" and ID>"&ID&" order by id asc"
    rs.open sql,conn,1,1
    If Not rs.eof Then
    If ISHTML = 1 Then
        AutoLink = ""&rs("ClassSeo")&""&Separated&""&rs("ID")&"."&HTMLName&""
    Else
        AutoLink = "OtherView.Asp?ID="&rs("ID")&""
    End If
    Response.Write ""&ChinaQJLanguageTxt247&"<a href="""&AutoLink&"""><font color="""&rs("TitleColor")&""">"&rs("OthersName"&Language)&"</font></a>"
    Else
    Response.Write ""&ChinaQJLanguageTxt247&""&ChinaQJLanguageTxt249&""
    End If
    rs.close
    Response.Write "          </td>"&VbCrLf
    Response.Write "        </tr>"&VbCrLf
    set rs=Nothing
    Response.Write "        <tr>"&VbCrLf
    Response.Write "          <td height=""20"">&nbsp;</td>"&VbCrLf
    Response.Write "        </tr>"&VbCrLf
    Response.Write "      </table>"&VbCrLf
end Function

function ChinaQJOtherListWebLocation()
  ChinaQJOtherListWebLocation="&nbsp;"&ChinaQJLanguageTxt19&"：<a href=""Index.Asp"" class=""agray"">"&ChinaQJLanguageTxt20&"</a> - <a href=""OtherList.Asp"" class=""agray"">"&ChinaQJLanguageTxt144&"</a>"&VbCrLf
  if request.QueryString("SortID")="" then
    ChinaQJOtherListWebLocation=ChinaQJOtherListWebLocation
  elseif not IsNumeric(request.QueryString("SortID")) then
    ChinaQJOtherListWebLocation=ChinaQJOtherListWebLocation&ChinaQJLanguageTxt16
  elseif conn.execute("select * from ChinaQJ_OthersSort Where "&ViewFlag&" and ID="&request.QueryString("SortID")).eof then
    ChinaQJOtherListWebLocation=ChinaQJOtherListWebLocation&ChinaQJLanguageTxt16
  else
    dim rs,sql
    set rs = server.createobject("adodb.recordset")
    sql="select * from ChinaQJ_OthersSort where "&ViewFlag&" and ID="&request.QueryString("SortID")
    rs.open sql,conn,1,1
    ChinaQJOtherListWebLocation=ChinaQJOtherListWebLocation&ChinaQJOtherListSortPathTXT("ChinaQJ_OthersSort",rs("ID"))
    rs.close
    set rs=nothing
  end if
end Function

function ChinaQJOtherListSortPathTXT(DataFrom,ID)
  dim rs,sql
  Set rs=server.CreateObject("adodb.recordset")
  sql="Select * From "&DataFrom&" where "&ViewFlag&" and ID="&ID
  rs.open sql,conn,1,1
  if not rs.eof Then
    If ISHTML = 1 Then
        AutoLink = ""&rs("ClassSeo")&""&Separated&""&rs("ID")&""&Separated&"1."&HTMLName&""
    Else
        AutoLink = "OtherList.Asp?SortID="&rs("ID")&""
    End If
    ChinaQJOtherListSortPathTXT=ChinaQJOtherListSortPathTXT(DataFrom,rs("ParentID"))&" - <a href="""&AutoLink&""">"&rs("SortName"&Language)&"</a>"
  end if
  rs.close
  set rs=nothing
end function

function ChinaQJOtherListWebContent(DataFrom,ID,SortPath)
  dim rs,sql
  dim HideSort
  set rs = server.createobject("adodb.recordset")
  if ID="" then
    SortPath="0,"
  elseif not IsNumeric(ID) then
    response.write "<center>"&ChinaQJLanguageTxt7&"</center>"
    exit function
  elseif conn.execute("select * from "&DataFrom&" Where "&ViewFlag&" and ID="&ID).eof then
    response.write "<center>"&ChinaQJLanguageTxt7&"</center>"
    exit function
  else
    SortPath=conn.execute("select * from "&DataFrom&" Where "&ViewFlag&" and ID="&ID)("SortPath")
    conn.execute("update "&DataFrom&" set ClickNumber=ClickNumber+1 Where ID="&ID)
  end If
  If IsDatabaseType = 1 Then
    sql="select * from "&DataFrom&" Where not("&ViewFlag&") and Charindex('"&SortPath&"',SortPath) > 0"
  Else
    sql="select * from "&DataFrom&" Where not("&ViewFlag&") and Instr(SortPath,'"&SortPath&"') > 0"
  End If
  rs.open sql,conn,1,1
  while not rs.eof
    HideSort="and not(Instr(SortPath,'"&rs("SortPath")&"')>0) "&HideSort
    rs.movenext
  wend
  rs.close
  dim idCount
  dim pages
      pages=OtherInfo
  dim pagec
  dim page
      page=clng(request("Page"))
  dim pagenc
      pagenc=5
  dim pagenmax
  dim pagenmin
  dim pageprevious
  dim pagenext
  datafrom="ChinaQJ_Others"
  dim datawhere
      If IsDatabaseType = 1 Then
        datawhere="where "&ViewFlag&" and Charindex('"&SortPath&"',SortPath) > 0 "&HideSort& " "
      Else
        datawhere="where "&ViewFlag&" and Instr(SortPath,'"&SortPath&"') > 0 "&HideSort& " "
      End If
  dim sqlid
  dim Myself,PATH_INFO,QUERY_STRING
      PATH_INFO = request.servervariables("PATH_INFO")
      QUERY_STRING = request.ServerVariables("QUERY_STRING")'
      if QUERY_STRING = "" then
        Myself = PATH_INFO & "?"
      elseif Instr(PATH_INFO & "?" & QUERY_STRING,"Page=")=0 then
        Myself= PATH_INFO & "?" & QUERY_STRING & "&"
      else
        Myself = Left(PATH_INFO & "?" & QUERY_STRING,Instr(PATH_INFO & "?" & QUERY_STRING,"Page=")-1)
      end if
  dim taxis
      taxis="order by Sequence desc,ID desc"
  dim i
  sql="select count(ID) as idCount from ["& datafrom &"]" & datawhere
  set rs=server.createobject("adodb.recordset")
  rs.open sql,conn,0,1
  idCount=rs("idCount")
  if(idcount>0) then
    if(idcount mod pages=0)then
      pagec=int(idcount/pages)
    else
      pagec=int(idcount/pages)+1
    end if
    sql="select id from ["& datafrom &"] " & datawhere & taxis
    set rs=server.createobject("adodb.recordset")
    rs.open sql,conn,1,1
    rs.pagesize = pages
    if page < 1 then page = 1
    if page > pagec then page = pagec
    if pagec > 0 then rs.absolutepage = page
    for i=1 to rs.pagesize
      if rs.eof then exit for
      if(i=1)then
        sqlid=rs("id")
      else
        sqlid=sqlid &","&rs("id")
      end if
      rs.movenext
    next
  end if
  if(idcount>0 and sqlid<>"") then
    sql="select * from ["& datafrom &"] where id in("& sqlid &") "&taxis
    set rs=server.createobject("adodb.recordset")
    rs.open sql,conn,0,1
    Response.Write "<table width=""98%"" border=""0"" cellspacing=""0"" cellpadding=""0"">"&VbCrLf
    Response.Write "  <tr height=""32"">"&VbCrLf
    Response.Write "    <td width=""550"" style=""color:#FFFFFF; font-weight:bold; background:url("&StylePath&"split.gif) no-repeat right center; background-color:#abacaf"">&nbsp;&nbsp;&nbsp;&nbsp;"&ChinaQJLanguageTxt42&"</td>"&VbCrLf
    Response.Write "    <td bgcolor=""#ABACAF"" style=""color:#FFFFFF; font-weight:bold"">&nbsp;&nbsp;"&ChinaQJLanguageTxt54&"</td>"&VbCrLf
    Response.Write "  </tr>"&VbCrLf
    while not rs.eof
    If ISHTML = 1 Then
        AutoLink = ""&rs("ClassSeo")&""&Separated&""&rs("ID")&"."&HTMLName&""
    Else
        AutoLink = "OtherView.Asp?ID="&rs("ID")&""
    End If
    Response.Write "  <tr height=""28"">"&VbCrLf
    Response.Write "    <td style=""background:url("&StylePath&"bg2.gif) repeat-x left bottom;"">&nbsp;<img src="""&StylePath&"arr.gif"" width=""11"" height=""14"" align=""absmiddle"" />&nbsp;&nbsp;<a href="""&AutoLink&"""><font color="""&rs("TitleColor")&""">"&rs("OthersName"&Language)&"</font></a></td>"&VbCrLf
    Response.Write "    <td style=""background:url("&StylePath&"bg2.gif) repeat-x left bottom; color:#999999"">&nbsp;&nbsp;&nbsp;"&FormatDate(rs("Updatetime"),13)&"</td>"&VbCrLf
    Response.Write "  </tr>"&VbCrLf
    rs.movenext
    wend
    Response.Write "</table>"&VbCrLf
  else
    response.write "<center>"&ChinaQJLanguageTxt7&"</center>"
    exit function
  end if
  Response.Write "<div class=""page"">"&VbCrLf
  Response.Write ""&ChinaQJLanguageTxt44&"<strong style=""color:red"">"&idcount&"</strong>"&ChinaQJLanguageTxt45&"&nbsp;&nbsp;&nbsp;" & vbCrLf
  pagenmin=page-pagenc
  pagenmax=page+pagenc
  if(pagenmin<1) then pagenmin=1
%>
    <span id="page">
<%
Sortid=Request("Sortid")
If ISHTML = 1 Then
If Sortid="" then
%>
        <a href="<%= ClassSeo %><%= Separated %>1.<%= HTMLName %>"><%= ChinaQJLanguageTxt313 %></a>
<% If page>1 Then %>
        <a href="<%= ClassSeo %><%= Separated %><%= page-1 %>.<%= HTMLName %>"><%= ChinaQJLanguageTxt314 %></a>
<% Else %>
        <a href="<%= ClassSeo %><%= Separated %>1.<%= HTMLName %>"><%= ChinaQJLanguageTxt313 %></a>
<% End If %>
<%
  if(pagenmax>pagec) then pagenmax=pagec
  for i = pagenmin to pagenmax
    if(i=page) then
%>
        <a href="<%= ClassSeo %><%= Separated %><%= i %>.<%= HTMLName %>" class='page_click' ><%= i %></a>
<% Else %>
        <a href="<%= ClassSeo %><%= Separated %><%= i %>.<%= HTMLName %>" class='' ><%= i %></a>
<%
End If
Next
%>
<% If page<pagenmax Then %>
        <a href="<%= ClassSeo %><%= Separated %><%= page+1 %>.<%= HTMLName %>"><%= ChinaQJLanguageTxt315 %></a>
<% Else %>
        <a href="<%= ClassSeo %><%= Separated %><%= pagenmax %>.<%= HTMLName %>"><%= ChinaQJLanguageTxt315 %></a>
<% End If %>
        <a href="<%= ClassSeo %><%= Separated %><%= pagenmax %>.<%= HTMLName %>"><%= ChinaQJLanguageTxt316 %></a>
<% Else %>
        <a href="<%= ClassSeo %><%= Separated %><%= Sortid %><%= Separated %>1.<%= HTMLName %>"><%= ChinaQJLanguageTxt313 %></a>
<% If page>1 Then %>
        <a href="<%= ClassSeo %><%= Separated %><%= Sortid %><%= Separated %><%= page-1 %>.<%= HTMLName %>"><%= ChinaQJLanguageTxt314 %></a>
<% Else %>
        <a href="<%= ClassSeo %><%= Separated %><%= Sortid %><%= Separated %>1.<%= HTMLName %>"><%= ChinaQJLanguageTxt314 %></a>
<% End If %>
<%
  if(pagenmax>pagec) then pagenmax=pagec
  for i = pagenmin to pagenmax
    if(i=page) then
%>
        <a href="<%= ClassSeo %><%= Separated %><%= Sortid %><%= Separated %><%= i %>.<%= HTMLName %>" class='page_click' ><%= i %></a>
<% Else %>
        <a href="<%= ClassSeo %><%= Separated %><%= Sortid %><%= Separated %><%= i %>.<%= HTMLName %>" class='' ><%= i %></a>
<%
End If
Next
%>
<% If page<pagenmax Then %>
        <a href="<%= ClassSeo %><%= Separated %><%= Sortid %><%= Separated %><%= page+1 %>.<%= HTMLName %>"><%= ChinaQJLanguageTxt315 %></a>
<% Else %>
        <a href="<%= ClassSeo %><%= Separated %><%= Sortid %><%= Separated %><%= pagenmax %>.<%= HTMLName %>"><%= ChinaQJLanguageTxt315 %></a>
<% End If %>
        <a href="<%= ClassSeo %><%= Separated %><%= Sortid %><%= Separated %><%= pagenmax %>.<%= HTMLName %>"><%= ChinaQJLanguageTxt316 %></a>
<% End If %>
<% Else %>
        <a href="<%= myself %>Page=1"><%= ChinaQJLanguageTxt313 %></a>
<% If page>1 Then %>
        <a href="<%= myself %>Page=<%= page-1 %>"><%= ChinaQJLanguageTxt314 %></a>
<% Else %>
        <a href="<%= myself %>Page=1"><%= ChinaQJLanguageTxt314 %></a>
<% End If %>
<%
  if(pagenmax>pagec) then pagenmax=pagec
  for i = pagenmin to pagenmax
    if(i=page) then
%>
        <a href="<%= myself %>Page=<%= i %>" class='page_click' ><%= i %></a>
<% Else %>
        <a href="<%= myself %>Page=<%= i %>" class='' ><%= i %></a>
<%
End If
Next
%>
<% If page<pagenmax Then %>
        <a href="<%= myself %>Page=<%= page+1 %>"><%= ChinaQJLanguageTxt315 %></a>
<% Else %>
        <a href="<%= myself %>Page=<%= pagenmax %>"><%= ChinaQJLanguageTxt315 %></a>
<% End If %>
        <a href="<%= myself %>Page=<%= pagenmax %>"><%= ChinaQJLanguageTxt316 %></a>
<% End If %>
    </span>
<%
  Response.Write "</div>"&VbCrLf
  rs.close
  set rs=nothing
end Function

Function ChinaQJNewsFolder(id)
  Dim rs,sql,i,ChildCount,FolderType,FolderName,onMouseUp,ListType
  Set rs=server.CreateObject("adodb.recordset")
  sql="Select * From ChinaQJ_NewsSort where "&ViewFlag&" And ParentID="&id&" order by Sequence desc,ID desc"
  rs.open sql,conn,1,1
    if id=0 and rs.recordcount=0 then
        response.write "<center>"&ChinaQJLanguageTxt7&"</center>"
        exit function
    end if
  i=1
  response.write("<table border=""0"" cellspacing=""1"" cellpadding=""2"">")
  while not rs.eof
    ChildCount=conn.execute("select count(*) from ChinaQJ_NewsSort where ParentID="&rs("id"))(0)
    if ChildCount=0 then
      if i=rs.recordcount then
        FolderType="SortFileEnd"
      else
        FolderType="SortFile"
      end if
      FolderName=rs("SortName"&Language)
      onMouseUp=""
    else
      if i=rs.recordcount then
        FolderType="SortEndFolderClose"
        ListType="SortEndListline"
        onMouseUp="EndSortChange('a"&rs("id")&"','b"&rs("id")&"');"
      else
      If SortStart = 0 Then
        FolderType="SortFolderOpen"
      Else
        FolderType="SortFolderClose"
      End If
        ListType="SortListline"
        onMouseUp="SortChange('a"&rs("id")&"','b"&rs("id")&"');"
      end if
      FolderName=rs("SortName"&Language)
    end If
    datafrom="ChinaQJ_NewsSort"
    If ISHTML = 1 Then
        AutoLink = ""&rs("ClassSeo")&""&Separated&""&rs("ID")&""&Separated&"1."&HTMLName&""
    Else
        AutoLink = "NewsList.Asp?SortID="&rs("ID")&""
    End If
    response.write("<tr>")
    response.write("<td nowrap id=""b"&rs("id")&""" onMouseUp="""&onMouseUp&""" class="""&FolderType&"""></td><td nowrap style=""padding-top: 3px""><a href="""&AutoLink&""">"&FolderName&"</a></td></tr>")
    if ChildCount>0 then
%>
<%If SortStart = 0 Then%>
<tr id="a<%=rs("id")%>" style="display: none">
<%Else%>
<tr id="a<%=rs("id")%>" style="display: yes">
<%End If%>
  <td class="<%=ListType%>" nowrap></td>
  <td><% ChinaQJNewsFolder(rs("id")) %></td>
</tr>
<%
    end if
    rs.movenext
    i=i+1
    wend
    response.write("</table>")
    rs.close
    set rs=nothing
end Function

Function ChinaQJImageFolder(id)
  Dim rs,sql,i,ChildCount,FolderType,FolderName,onMouseUp,ListType
  Set rs=server.CreateObject("adodb.recordset")
  sql="Select * From ChinaQJ_ImageSort where "&ViewFlag&" And ParentID="&id&" order by Sequence desc,ID desc"
  rs.open sql,conn,1,1
    if id=0 and rs.recordcount=0 then
        response.write "<center>"&ChinaQJLanguageTxt7&"</center>"
        exit function
    end if
  i=1
  response.write("<table border=""0"" cellspacing=""1"" cellpadding=""2"">")
  while not rs.eof
    ChildCount=conn.execute("select count(*) from ChinaQJ_ImageSort where ParentID="&rs("id"))(0)
    if ChildCount=0 then
      if i=rs.recordcount then
        FolderType="SortFileEnd"
      else
        FolderType="SortFile"
      end if
      FolderName=rs("SortName"&Language)
      onMouseUp=""
    else
      if i=rs.recordcount then
        FolderType="SortEndFolderClose"
        ListType="SortEndListline"
        onMouseUp="EndSortChange('a"&rs("id")&"','b"&rs("id")&"');"
      else
      If SortStart = 0 Then
        FolderType="SortFolderOpen"
      Else
        FolderType="SortFolderClose"
      End If
        ListType="SortListline"
        onMouseUp="SortChange('a"&rs("id")&"','b"&rs("id")&"');"
      end if
      FolderName=rs("SortName"&Language)
    end If
    datafrom="ChinaQJ_ImageSort"
    If ISHTML = 1 Then
        AutoLink = ""&rs("ClassSeo")&""&Separated&""&rs("ID")&""&Separated&"1."&HTMLName&""
    Else
        AutoLink = "ImageList.Asp?SortID="&rs("ID")&""
    End If
    response.write("<tr>")
    response.write("<td nowrap id=""b"&rs("id")&""" onMouseUp="""&onMouseUp&""" class="""&FolderType&"""></td><td nowrap style=""padding-top: 3px""><a href="""&AutoLink&""">"&FolderName&"</a></td></tr>")
    if ChildCount>0 then
%>
<%If SortStart = 0 Then%>
<tr id="a<%=rs("id")%>" style="display: none">
<%Else%>
<tr id="a<%=rs("id")%>" style="display: yes">
<%End If%>
  <td class="<%=ListType%>" nowrap></td>
  <td><% ChinaQJImageFolder(rs("id")) %></td>
</tr>
<%
    end if
    rs.movenext
    i=i+1
    wend
    response.write("</table>")
    rs.close
    set rs=nothing
end Function

function ChinaQJNewsWebLocation()
  ChinaQJNewsWebLocation="&nbsp;"&ChinaQJLanguageTxt19&"：<a href=""Index.Asp"" class=""agray"">"&ChinaQJLanguageTxt20&"</a> - <a href=""NewsList.Asp"" class=""agray"">"&ChinaQJLanguageTxt141&"</a>"&VbCrLf
  if request.QueryString("ID")="" then
    ChinaQJNewsWebLocation=ChinaQJNewsWebLocation
  elseif not IsNumeric(request.QueryString("ID")) then
    ChinaQJNewsWebLocation=ChinaQJNewsWebLocation&ChinaQJLanguageTxt16
  elseif conn.execute("select * from ChinaQJ_News Where "&ViewFlag&" and  ID="&request.QueryString("ID")).eof then
    ChinaQJNewsWebLocation=ChinaQJNewsWebLocation&ChinaQJLanguageTxt16
  else
    dim rs,sql
    set rs = server.createobject("adodb.recordset")
    sql="select * from ChinaQJ_News where "&ViewFlag&" and ID="&request.QueryString("ID")
    rs.open sql,conn,1,1
    ChinaQJNewsWebLocation=ChinaQJNewsWebLocation&ChinaQJNewsSortPathTXT("ChinaQJ_NewsSort",rs("SortID"))
    rs.close
    set rs=nothing
  end if
end Function

function ChinaQJImageWebLocation()
  ChinaQJImageWebLocation="&nbsp;"&ChinaQJLanguageTxt19&"：<a href=""Index.Asp"" class=""agray"">"&ChinaQJLanguageTxt20&"</a> - <a href=""ImageList.Asp"" class=""agray"">"&ChinaQJLanguageTxt301&"</a>"&VbCrLf
  if request.QueryString("ID")="" then
    ChinaQJImageWebLocation=ChinaQJImageWebLocation
  elseif not IsNumeric(request.QueryString("ID")) then
    ChinaQJImageWebLocation=ChinaQJImageWebLocation&ChinaQJLanguageTxt16
  elseif conn.execute("select * from ChinaQJ_Image Where "&ViewFlag&" and  ID="&request.QueryString("ID")).eof then
    ChinaQJImageWebLocation=ChinaQJImageWebLocation&ChinaQJLanguageTxt16
  else
    dim rs,sql
    set rs = server.createobject("adodb.recordset")
    sql="select * from ChinaQJ_Image where "&ViewFlag&" and ID="&request.QueryString("ID")
    rs.open sql,conn,1,1
    ChinaQJImageWebLocation=ChinaQJImageWebLocation&ChinaQJImageSortPathTXT("ChinaQJ_ImageSort",rs("SortID"))
    rs.close
    set rs=nothing
  end if
end Function

function ChinaQJImageSortPathTXT(DataFrom,ID)
  dim rs,sql
  Set rs=server.CreateObject("adodb.recordset")
  sql="Select * From "&DataFrom&" where "&ViewFlag&" and ID="&ID
  rs.open sql,conn,1,1
  if not rs.eof Then
    If ISHTML = 1 Then
        AutoLink = ""&rs("ClassSeo")&""&Separated&""&rs("ID")&""&Separated&"1."&HTMLName&""
    Else
        AutoLink = "ImageList.Asp?SortID="&rs("ID")&""
    End If
    ChinaQJImageSortPathTXT=ChinaQJImageSortPathTXT(DataFrom,rs("ParentID"))&" - <a href="""&AutoLink&"""><span style=""color:#EC0000"">"&rs("SortName"&Language)&"</span></a>"
  end if
  rs.close
  set rs=nothing
end Function

function ChinaQJNewsSortPathTXT(DataFrom,ID)
  dim rs,sql
  Set rs=server.CreateObject("adodb.recordset")
  sql="Select * From "&DataFrom&" where "&ViewFlag&" and ID="&ID
  rs.open sql,conn,1,1
  if not rs.eof Then
    If ISHTML = 1 Then
        AutoLink = ""&rs("ClassSeo")&""&Separated&""&rs("ID")&""&Separated&"1."&HTMLName&""
    Else
        AutoLink = "NewsList.Asp?SortID="&rs("ID")&""
    End If
    ChinaQJNewsSortPathTXT=ChinaQJNewsSortPathTXT(DataFrom,rs("ParentID"))&" - <a href="""&AutoLink&"""><span style=""color:#EC0000"">"&rs("SortName"&Language)&"</span></a>"
  end if
  rs.close
  set rs=nothing
end Function

function ChinaQJNewsDetail()
    Response.Write "<table width=""100%"" border=""0"" cellspacing=""0"" cellpadding=""0"" align=""center"">"&VbCrLf
    Response.Write "    <tr>"&VbCrLf
    Response.Write "        <td>"&VbCrLf
    Response.Write "    <table width=""100%"" border=""0"" cellspacing=""0"" cellpadding=""0"">"&VbCrLf
    Response.Write "              <tr>"&VbCrLf
    Response.Write "                <td width=""30"" height=""36""><img src="""&StylePath&"title_bg1.gif"" width=""30"" height=""36"" /></td>"&VbCrLf
    Response.Write "                <td width=""100%"" align=""center"" background="""&StylePath&"title_bg_center.jpg"" style=""color:#000000; font-size:14px; font-weight:bold"">"&VbCrLf
    ID=request.QueryString("ID")
    if ID="" or not IsNumeric(ID) then
    response.write "<center>"&ChinaQJLanguageTxt7&"</center>"
    elseif conn.execute("select * from ChinaQJ_News Where "&ViewFlag&" and  ID="&ID).eof then
    response.write "<center>"&ChinaQJLanguageTxt7&"</center>"
    else
    dim rs,sql
    set rs = server.createobject("adodb.recordset")
    sql="select * from ChinaQJ_News where "&ViewFlag&" and ID="&ID
    rs.open sql,conn,1,3
    Response.Write ""&rs("NewsName"&Language)&""&VbCrLf
    End If
    If Request("page")="" Then
    pageNum=0
    Else
    pageNum=Request("page")
    End if
    Response.Write "                </td>"&VbCrLf
    Response.Write "                <td width=""30""><img src="""&StylePath&"title_bg2.gif"" width=""30"" height=""36"" /></td>"&VbCrLf
    Response.Write "              </tr>"&VbCrLf
    Response.Write "              <tr>" & vbCrLf
    Response.Write "                <td><img src=""" & StylePath & "title_bg3.gif"" width=""30"" height=""14"" /></td>" & vbCrLf
    Response.Write "                <td background=""" & StylePath & "title_bg_center2.jpg"">&nbsp;</td>" & vbCrLf
    Response.Write "                <td><img src=""" & StylePath & "title_bg4.gif"" width=""30"" height=""14"" /></td>" & vbCrLf
    Response.Write "              </tr>" & vbCrLf
    Response.Write "            </table></td>"&VbCrLf
    Response.Write "        </tr>"&VbCrLf
    if ViewNoRight(rs("GroupID"),rs("Exclusive")) Then
    Response.Write "        <tr>"&VbCrLf
    Response.Write "          <td align=""center"" style=""color:#999999""><strong>"&ChinaQJLanguageTxt143&"：</strong>"&FormatDate(rs("Addtime"),13)&" <strong>"&ChinaQJLanguageTxt142&"：</strong>"&rs("Source"&Language)&" <strong>"&ChinaQJLanguageTxt18&"：</strong><script language=""javascript"" src=""HitCount.Asp?id="&rs("ID")&"&LX=ChinaQJ_News""></script><script language=""javascript"" src=""HitCount.Asp?action=count&LX=ChinaQJ_News&id="&rs("ID")&"""></script></td>"&VbCrLf
    Response.Write "        </tr>"&VbCrLf
    Response.Write "        <tr>"&VbCrLf
    Response.Write "          <td height=""20"">&nbsp;</td>"&VbCrLf
    Response.Write "        </tr>"&VbCrLf
    Response.Write "        <tr>"&VbCrLf
    Response.Write "          <td style=""line-height:25px; font-size:12px; padding-left: 8px; padding-right: 8px"" class=""SiteLink"">"&VbCrLf
    ContentStr=split(rs("Content"&Language),"{＄html_Paging＄}")
    For i=pageNum to pageNum
    Response.Write ""&ProcessSitelink(ContentStr(i)) &""
    Next
    Response.Write "          </td>"&VbCrLf
    Response.Write "        </tr>"&VbCrLf
    Response.Write "        <tr>"&VbCrLf
    Response.Write "          <td height=""20"" align=""right"" style=""padding-right: 18px"">"&VbCrLf
    %>
    <%=ChinaQJLanguageTxt250%><%For p = 0 to ubound(ContentStr)%> <a href="NewsView.Asp?ID=<%=request("ID")%>&page=<%=p%>"><font color="red"><%=p+1%></font></a> <%Next%><%=ChinaQJLanguageTxt50%>
    <%
    Response.Write "          </td>"&VbCrLf
    Response.Write "        </tr>"&VbCrLf
    Else
    Response.Write "        <tr>"&VbCrLf
    Response.Write "          <td align=""center""><img src="""&StylePath&"NoRight_"&Language&".jpg""></td>"&VbCrLf
    Response.Write "        </tr>"&VbCrLf
    end if
    rs.update
    rs.close
    Set rs = Server.CreateObject("Adodb.Recordset")
    If Request.QueryString("ID") = "" Or Not IsNumeric(Request.QueryString("ID")) Then
        sql = "Select Top 1 TheTags" & Language & " From ChinaQJ_News Where " & ViewFlag & " Order By Sequence Desc,ID Desc"
    Else
        sql = "Select TheTags" & Language & " From ChinaQJ_News Where " & ViewFlag & " And ID = " & Request.QueryString("ID")
    End If
    rs.Open sql, conn, 1, 1
    If Not rs.EOF Then
        If rs("TheTags" & Language) <> "" Then
            Response.Write "        <tr>" & vbCrLf
            Response.Write "          <td height=""25"" align=""right"" style=""padding-left: 8px; padding-right: 8px;"">" & vbCrLf
            Response.Write "          <font color=""#005AA0"">Tags：</font>" & vbCrLf
            TheTags = Split(rs("TheTags" & Language), ",")
            For i = 0 To UBound(TheTags)
                Response.Write "<a href=""Search.Asp?Range=News&Keyword=" & TheTags(i) & """>"
                Response.Write "<font color=""#CC3C3C""><u>"
                Response.Write TheTags(i) & ""
                Response.Write "</u></font>"
                Response.Write "</a> "
            Next
            Response.Write "          </td>" & vbCrLf
            Response.Write "        </tr>" & vbCrLf
        End If
    End If
    rs.Close
    Set rs = Nothing
    Response.Write "        <tr>"&VbCrLf
    Response.Write "          <td height=""25"">"&VbCrLf
    Dim IDmax,IDmin
    IDmax = ID+1
    Set rs = server.createobject("adodb.recordset")
    sql="select * from ChinaQJ_News where "&ViewFlag&" and ID<"&ID&" order by id desc"
    rs.open sql,conn,1,1
    If Not rs.eof Then
    If ISHTML = 1 Then
        AutoLink = ""&rs("ClassSeo")&""&Separated&""&rs("ID")&"."&HTMLName&""
    Else
        AutoLink = "NewsView.Asp?ID="&rs("ID")&""
    End If
    Response.Write ""&ChinaQJLanguageTxt248&"<a href="""&AutoLink&"""><font color="""&rs("TitleColor")&""">"&rs("NewsName"&Language)&"</font></a>"
    Else
    Response.Write ""&ChinaQJLanguageTxt248&""&ChinaQJLanguageTxt249&""
    End If
    rs.close
    Response.Write "          </td>"&VbCrLf
    Response.Write "        </tr>"&VbCrLf
    Response.Write "        <tr>"&VbCrLf
    Response.Write "          <td height=""25"">"&VbCrLf
    IDmin = ID-1
    Set rs = server.createobject("adodb.recordset")
    sql="select * from ChinaQJ_News where "&ViewFlag&" and ID>"&ID&" order by id asc"
    rs.open sql,conn,1,1
    If Not rs.eof Then
    If ISHTML = 1 Then
        AutoLink = ""&rs("ClassSeo")&""&Separated&""&rs("ID")&"."&HTMLName&""
    Else
        AutoLink = "NewsView.Asp?ID="&rs("ID")&""
    End If
    Response.Write ""&ChinaQJLanguageTxt247&"<a href="""&AutoLink&"""><font color="""&rs("TitleColor")&""">"&rs("NewsName"&Language)&"</font></a>"
    Else
    Response.Write ""&ChinaQJLanguageTxt247&""&ChinaQJLanguageTxt249&""
    End If
    rs.close
    Response.Write "          </td>"&VbCrLf
    Response.Write "        </tr>"&VbCrLf
    set rs=Nothing
    Response.Write "        <tr>"&VbCrLf
    Response.Write "          <td height=""20"">&nbsp;</td>"&VbCrLf
    Response.Write "        </tr>"&VbCrLf
    Response.Write "      </table>"&VbCrLf
end Function

function ChinaQJImageDetail()
    Response.Write "<table width=""100%"" border=""0"" cellspacing=""0"" cellpadding=""0"">"&VbCrLf
    Response.Write "    <tr>"&VbCrLf
    Response.Write "        <td>"&VbCrLf
    Response.Write "    <table width=""100%"" border=""0"" cellspacing=""0"" cellpadding=""0"">"&VbCrLf
    Response.Write "              <tr>"&VbCrLf
    Response.Write "                <td width=""30"" height=""36""><img src="""&StylePath&"title_bg1.gif"" width=""30"" height=""36"" /></td>"&VbCrLf
    Response.Write "                <td width=""100%"" align=""center"" background="""&StylePath&"title_bg_center.jpg"" style=""color:#000000; font-size:14px; font-weight:bold"">"&VbCrLf
    ID=request.QueryString("ID")
    if ID="" or not IsNumeric(ID) then
    response.write "<center>"&ChinaQJLanguageTxt7&"</center>"
    elseif conn.execute("select * from ChinaQJ_Image Where "&ViewFlag&" and  ID="&ID).eof then
    response.write "<center>"&ChinaQJLanguageTxt7&"</center>"
    else
    dim rs,sql
    set rs = server.createobject("adodb.recordset")
    sql="select * from ChinaQJ_Image where "&ViewFlag&" and ID="&ID
    rs.open sql,conn,1,3
    Response.Write ""&rs("ImageName"&Language)&""&VbCrLf
    End If
    If Request("page")="" Then
    pageNum=0
    Else
    pageNum=Request("page")
    End if
    Response.Write "                </td>"&VbCrLf
    Response.Write "                <td width=""30""><img src="""&StylePath&"title_bg2.gif"" width=""30"" height=""36"" /></td>"&VbCrLf
    Response.Write "              </tr>"&VbCrLf
    Response.Write "              <tr>" & vbCrLf
    Response.Write "                <td><img src=""" & StylePath & "title_bg3.gif"" width=""30"" height=""14"" /></td>" & vbCrLf
    Response.Write "                <td background=""" & StylePath & "title_bg_center2.jpg"">&nbsp;</td>" & vbCrLf
    Response.Write "                <td><img src=""" & StylePath & "title_bg4.gif"" width=""30"" height=""14"" /></td>" & vbCrLf
    Response.Write "              </tr>" & vbCrLf
    Response.Write "            </table></td>"&VbCrLf
    Response.Write "        </tr>"&VbCrLf
    if ViewNoRight(rs("GroupID"),rs("Exclusive")) Then
    Response.Write "        <tr>"&VbCrLf
    Response.Write "          <td align=""center"" style=""color:#999999""><strong>"&ChinaQJLanguageTxt143&"：</strong>"&FormatDate(rs("Addtime"),13)&" <strong>"&ChinaQJLanguageTxt142&"：</strong>"&rs("Source"&Language)&" <strong>"&ChinaQJLanguageTxt18&"：</strong><script language=""javascript"" src=""HitCount.Asp?id="&rs("ID")&"&LX=ChinaQJ_Image""></script><script language=""javascript"" src=""HitCount.Asp?action=count&LX=ChinaQJ_Image&id="&rs("ID")&"""></script></td>"&VbCrLf
    Response.Write "        </tr>"&VbCrLf
    Response.Write "        <tr>"&VbCrLf
    Response.Write "          <td height=""20"">&nbsp;</td>"&VbCrLf
    Response.Write "        </tr>"&VbCrLf
    Response.Write "        <tr>"&VbCrLf
    Response.Write "          <td style=""line-height:25px; font-size:12px; padding-left: 8px; padding-right: 8px"" class=""SiteLink"">"&VbCrLf
    ContentStr=split(rs("Content"&Language),"{＄html_Paging＄}")
    For i=pageNum to pageNum
    Response.Write ""&ProcessSitelink(ContentStr(i)) &""
    Next
    Response.Write "          </td>"&VbCrLf
    Response.Write "        </tr>"&VbCrLf
    Response.Write "        <tr>"&VbCrLf
    Response.Write "          <td height=""20"" align=""right"" style=""padding-right: 18px"">"&VbCrLf
    %>
    <%=ChinaQJLanguageTxt250%><%For p = 0 to ubound(ContentStr)%> <a href="ImageView.Asp?ID=<%=request("ID")%>&page=<%=p%>"><font color="red"><%=p+1%></font></a> <%Next%><%=ChinaQJLanguageTxt50%>
    <%
    Response.Write "          </td>"&VbCrLf
    Response.Write "        </tr>"&VbCrLf
    Else
    Response.Write "        <tr>"&VbCrLf
    Response.Write "          <td align=""center""><img src="""&StylePath&"NoRight_"&Language&".jpg""></td>"&VbCrLf
    Response.Write "        </tr>"&VbCrLf
    end if
    rs.update
    rs.close
    Set rs = Server.CreateObject("Adodb.Recordset")
    If Request.QueryString("ID") = "" Or Not IsNumeric(Request.QueryString("ID")) Then
        sql = "Select Top 1 TheTags" & Language & " From ChinaQJ_Image Where " & ViewFlag & " Order By Sequence Desc,ID Desc"
    Else
        sql = "Select TheTags" & Language & " From ChinaQJ_Image Where " & ViewFlag & " And ID = " & Request.QueryString("ID")
    End If
    rs.Open sql, conn, 1, 1
    If Not rs.EOF Then
        If rs("TheTags" & Language) <> "" Then
            Response.Write "        <tr>" & vbCrLf
            Response.Write "          <td height=""25"" align=""right"" style=""padding-left: 8px; padding-right: 8px;"">" & vbCrLf
            Response.Write "          <font color=""#005AA0"">Tags：</font>" & vbCrLf
            TheTags = Split(rs("TheTags" & Language), ",")
            For i = 0 To UBound(TheTags)
                Response.Write "<a href=""Search.Asp?Range=News&Keyword=" & TheTags(i) & """>"
                Response.Write "<font color=""#CC3C3C""><u>"
                Response.Write TheTags(i) & ""
                Response.Write "</u></font>"
                Response.Write "</a> "
            Next
            Response.Write "          </td>" & vbCrLf
            Response.Write "        </tr>" & vbCrLf
        End If
    End If
    rs.Close
    Set rs = Nothing
    Response.Write "        <tr>"&VbCrLf
    Response.Write "          <td height=""25"">"&VbCrLf
    Dim IDmax,IDmin
    IDmax = ID+1
    Set rs = server.createobject("adodb.recordset")
    sql="select * from ChinaQJ_Image where "&ViewFlag&" and ID<"&ID&" order by id desc"
    rs.open sql,conn,1,1
    If Not rs.eof Then
    If ISHTML = 1 Then
        AutoLink = ""&rs("ClassSeo")&""&Separated&""&rs("ID")&"."&HTMLName&""
    Else
        AutoLink = "ImageView.Asp?ID="&rs("ID")&""
    End If
    Response.Write ""&ChinaQJLanguageTxt248&"<a href="""&AutoLink&"""><font color="""&rs("TitleColor")&""">"&rs("ImageName"&Language)&"</font></a>"
    Else
    Response.Write ""&ChinaQJLanguageTxt248&""&ChinaQJLanguageTxt249&""
    End If
    rs.close
    Response.Write "          </td>"&VbCrLf
    Response.Write "        </tr>"&VbCrLf
    Response.Write "        <tr>"&VbCrLf
    Response.Write "          <td height=""25"">"&VbCrLf
    IDmin = ID-1
    Set rs = server.createobject("adodb.recordset")
    sql="select * from ChinaQJ_Image where "&ViewFlag&" and ID>"&ID&" order by id asc"
    rs.open sql,conn,1,1
    If Not rs.eof Then
    If ISHTML = 1 Then
        AutoLink = ""&rs("ClassSeo")&""&Separated&""&rs("ID")&"."&HTMLName&""
    Else
        AutoLink = "ImageView.Asp?ID="&rs("ID")&""
    End If
    Response.Write ""&ChinaQJLanguageTxt247&"<a href="""&AutoLink&"""><font color="""&rs("TitleColor")&""">"&rs("ImageName"&Language)&"</font></a>"
    Else
    Response.Write ""&ChinaQJLanguageTxt247&""&ChinaQJLanguageTxt249&""
    End If
    rs.close
    Response.Write "          </td>"&VbCrLf
    Response.Write "        </tr>"&VbCrLf
    set rs=Nothing
    Response.Write "        <tr>"&VbCrLf
    Response.Write "          <td height=""20"">&nbsp;</td>"&VbCrLf
    Response.Write "        </tr>"&VbCrLf
    Response.Write "      </table>"&VbCrLf
end Function

function ChinaQJNewsListWebLocation()
  ChinaQJNewsListWebLocation="&nbsp;"&ChinaQJLanguageTxt19&"：<a href=""Index.Asp"" class=""agray"">"&ChinaQJLanguageTxt20&"</a> - <a href=""NewsList.Asp"" class=""agray"">"&ChinaQJLanguageTxt141&"</a>"&VbCrLf
  if request.QueryString("SortID")="" then
    ChinaQJNewsListWebLocation=ChinaQJNewsListWebLocation
  elseif not IsNumeric(request.QueryString("SortID")) then
    ChinaQJNewsListWebLocation=ChinaQJNewsListWebLocation&ChinaQJLanguageTxt16
  elseif conn.execute("select * from ChinaQJ_NewsSort Where "&ViewFlag&" and ID="&request.QueryString("SortID")).eof then
    ChinaQJNewsListWebLocation=ChinaQJNewsListWebLocation&ChinaQJLanguageTxt16
  else
    dim rs,sql
    set rs = server.createobject("adodb.recordset")
    sql="select * from ChinaQJ_NewsSort where "&ViewFlag&" and ID="&request.QueryString("SortID")
    rs.open sql,conn,1,1
    ChinaQJNewsListWebLocation=ChinaQJNewsListWebLocation&ChinaQJNewsListSortPathTXT("ChinaQJ_NewsSort",rs("ID"))
    rs.close
    set rs=nothing
  end if
end Function

function ChinaQJImageListWebLocation()
  ChinaQJImageListWebLocation="&nbsp;"&ChinaQJLanguageTxt19&"：<a href=""Index.Asp"" class=""agray"">"&ChinaQJLanguageTxt20&"</a> - <a href=""ImageList.Asp"" class=""agray"">"&ChinaQJLanguageTxt301&"</a>"&VbCrLf
  if request.QueryString("SortID")="" then
    ChinaQJImageListWebLocation=ChinaQJImageListWebLocation
  elseif not IsNumeric(request.QueryString("SortID")) then
    ChinaQJImageListWebLocation=ChinaQJImageListWebLocation&ChinaQJLanguageTxt16
  elseif conn.execute("select * from ChinaQJ_ImageSort Where "&ViewFlag&" and ID="&request.QueryString("SortID")).eof then
    ChinaQJImageListWebLocation=ChinaQJImageListWebLocation&ChinaQJLanguageTxt16
  else
    dim rs,sql
    set rs = server.createobject("adodb.recordset")
    sql="select * from ChinaQJ_ImageSort where "&ViewFlag&" and ID="&request.QueryString("SortID")
    rs.open sql,conn,1,1
    ChinaQJImageListWebLocation=ChinaQJImageListWebLocation&ChinaQJImageListSortPathTXT("ChinaQJ_ImageSort",rs("ID"))
    rs.close
    set rs=nothing
  end if
end Function

function ChinaQJImageListSortPathTXT(DataFrom,ID)
  dim rs,sql
  Set rs=server.CreateObject("adodb.recordset")
  sql="Select * From "&DataFrom&" where "&ViewFlag&" and ID="&ID
  rs.open sql,conn,1,1
  if not rs.eof Then
    If ISHTML = 1 Then
        AutoLink = ""&rs("ClassSeo")&""&Separated&""&rs("ID")&""&Separated&"1."&HTMLName&""
    Else
        AutoLink = "ImageList.Asp?SortID="&rs("ID")&""
    End If
    ChinaQJImageListSortPathTXT=ChinaQJImageListSortPathTXT(DataFrom,rs("ParentID"))&" - <a href="""&AutoLink&""">"&rs("SortName"&Language)&"</a>"
  end if
  rs.close
  set rs=nothing
end function

function ChinaQJNewsListSortPathTXT(DataFrom,ID)
  dim rs,sql
  Set rs=server.CreateObject("adodb.recordset")
  sql="Select * From "&DataFrom&" where "&ViewFlag&" and ID="&ID
  rs.open sql,conn,1,1
  if not rs.eof Then
    If ISHTML = 1 Then
        AutoLink = ""&rs("ClassSeo")&""&Separated&""&rs("ID")&""&Separated&"1."&HTMLName&""
    Else
        AutoLink = "NewsList.Asp?SortID="&rs("ID")&""
    End If
    ChinaQJNewsListSortPathTXT=ChinaQJNewsListSortPathTXT(DataFrom,rs("ParentID"))&" - <a href="""&AutoLink&""">"&rs("SortName"&Language)&"</a>"
  end if
  rs.close
  set rs=nothing
end function

function ChinaQJNewsListWebContent(DataFrom,ID,SortPath)
  dim rs,sql
  dim HideSort
  set rs = server.createobject("adodb.recordset")
  if ID="" then
    SortPath="0,"
  elseif not IsNumeric(ID) then
    response.write "<center>"&ChinaQJLanguageTxt7&"</center>"
    exit function
  elseif conn.execute("select * from "&DataFrom&" Where "&ViewFlag&" and  ID="&ID).eof then
    response.write "<center>"&ChinaQJLanguageTxt7&"</center>"
    exit function
  else
    SortPath=conn.execute("select * from "&DataFrom&" Where "&ViewFlag&" and  ID="&ID)("SortPath")
    conn.execute("update "&DataFrom&" set ClickNumber=ClickNumber+1 Where ID="&ID)
  end If
  If IsDatabaseType = 1 Then
    sql="select * from "&DataFrom&" Where not("&ViewFlag&") and Charindex('"&SortPath&"',SortPath) > 0"
  Else
    sql="select * from "&DataFrom&" Where not("&ViewFlag&") and Instr(SortPath,'"&SortPath&"') > 0"
  End If
  rs.open sql,conn,1,1
  while not rs.eof
    HideSort="and not(Instr(SortPath,'"&rs("SortPath")&"')>0) "&HideSort
    rs.movenext
  wend
  rs.close
  dim idCount
  dim pages
      pages=NewInfo
  dim pagec
  dim page
      page=clng(request("Page"))
  dim pagenc
      pagenc=5
  dim pagenmax
  dim pagenmin
  dim pageprevious
  dim pagenext
  datafrom="ChinaQJ_News"
  dim datawhere
      If IsDatabaseType = 1 Then
        datawhere="where "&ViewFlag&" and Charindex('"&SortPath&"',SortPath) > 0 "&HideSort& " "
      Else
        datawhere="where "&ViewFlag&" and Instr(SortPath,'"&SortPath&"') > 0 "&HideSort& " "
      End If
  dim sqlid
  dim Myself,PATH_INFO,QUERY_STRING
      PATH_INFO = request.servervariables("PATH_INFO")
      QUERY_STRING = request.ServerVariables("QUERY_STRING")'
      if QUERY_STRING = "" then
        Myself = PATH_INFO & "?"
      elseif Instr(PATH_INFO & "?" & QUERY_STRING,"Page=")=0 then
        Myself= PATH_INFO & "?" & QUERY_STRING & "&"
      else
        Myself = Left(PATH_INFO & "?" & QUERY_STRING,Instr(PATH_INFO & "?" & QUERY_STRING,"Page=")-1)
      end if
  dim taxis
      taxis="order by NoticeFlag asc,id desc"
  dim i
  sql="select count(ID) as idCount from ["& datafrom &"]" & datawhere
  set rs=server.createobject("adodb.recordset")
  rs.open sql,conn,0,1
  idCount=rs("idCount")
  if(idcount>0) then
    if(idcount mod pages=0)then
      pagec=int(idcount/pages)
    else
      pagec=int(idcount/pages)+1
    end if
    sql="select id from ["& datafrom &"] " & datawhere & taxis
    set rs=server.createobject("adodb.recordset")
    rs.open sql,conn,1,1
    rs.pagesize = pages
    if page < 1 then page = 1
    if page > pagec then page = pagec
    if pagec > 0 then rs.absolutepage = page
    for i=1 to rs.pagesize
      if rs.eof then exit for
      if(i=1)then
        sqlid=rs("id")
      else
        sqlid=sqlid &","&rs("id")
      end if
      rs.movenext
    next
  end if
  if(idcount>0 and sqlid<>"") then
    sql="select * from ["& datafrom &"] where id in("& sqlid &") "&taxis
    set rs=server.createobject("adodb.recordset")
    rs.open sql,conn,0,1
    Response.Write "<table width=""98%"" border=""0"" cellspacing=""0"" cellpadding=""0"">"&VbCrLf
    Response.Write "  <tr height=""32"">"&VbCrLf
    Response.Write "    <td width=""550"" style=""color:#FFFFFF; font-weight:bold; background:url("&StylePath&"split.gif) no-repeat right center; background-color:#abacaf"">&nbsp;&nbsp;&nbsp;&nbsp;"&ChinaQJLanguageTxt42&"</td>"&VbCrLf
    Response.Write "    <td align=""center"" bgcolor=""#ABACAF"" style=""color:#FFFFFF; font-weight:bold"">"&ChinaQJLanguageTxt43&"</td>"&VbCrLf
    Response.Write "  </tr>"&VbCrLf
    while not rs.eof
    If ISHTML = 1 Then
        AutoLink = ""&rs("ClassSeo")&""&Separated&""&rs("ID")&"."&HTMLName&""
    Else
        AutoLink = "NewsView.Asp?ID="&rs("ID")&""
    End If
    Response.Write "  <tr height=""28"">"&VbCrLf
    Response.Write "    <td style=""background:url("&StylePath&"bg2.gif) repeat-x left bottom;"">&nbsp;<img src="""&StylePath&"arr.gif"" width=""11"" height=""14"" align=""absmiddle"" />&nbsp;&nbsp;<a href="""&AutoLink&"""><font color="""&rs("TitleColor")&""">"&rs("NewsName"&Language)&"</font></a></td>"&VbCrLf
    Response.Write "    <td align=""center"" style=""background:url("&StylePath&"bg2.gif) repeat-x left bottom; color:#999999"">"&FormatDate(rs("Addtime"),13)&"</td>"&VbCrLf
    Response.Write "  </tr>"&VbCrLf
    rs.movenext
    wend
    Response.Write "</table>"&VbCrLf
  else
    response.write "<center>"&ChinaQJLanguageTxt7&"</center>"
    exit function
  end if
  Response.Write "<div class=""page"">"&VbCrLf
  Response.Write ""&ChinaQJLanguageTxt44&"<strong style=""color:red"">"&idcount&"</strong>"&ChinaQJLanguageTxt45&"&nbsp;&nbsp;&nbsp;" & vbCrLf
  pagenmin=page-pagenc
  pagenmax=page+pagenc
  if(pagenmin<1) then pagenmin=1
%>
    <span id="page">
<%
Sortid=Request("Sortid")
If ISHTML = 1 Then
If Sortid="" then
%>
        <a href="<%= ClassSeo %><%= Separated %>1.<%= HTMLName %>"><%= ChinaQJLanguageTxt313 %></a>
<% If page>1 Then %>
        <a href="<%= ClassSeo %><%= Separated %><%= page-1 %>.<%= HTMLName %>"><%= ChinaQJLanguageTxt314 %></a>
<% Else %>
        <a href="<%= ClassSeo %><%= Separated %>1.<%= HTMLName %>"><%= ChinaQJLanguageTxt313 %></a>
<% End If %>
<%
  if(pagenmax>pagec) then pagenmax=pagec
  for i = pagenmin to pagenmax
    if(i=page) then
%>
        <a href="<%= ClassSeo %><%= Separated %><%= i %>.<%= HTMLName %>" class='page_click' ><%= i %></a>
<% Else %>
        <a href="<%= ClassSeo %><%= Separated %><%= i %>.<%= HTMLName %>" class='' ><%= i %></a>
<%
End If
Next
%>
<% If page<pagenmax Then %>
        <a href="<%= ClassSeo %><%= Separated %><%= page+1 %>.<%= HTMLName %>"><%= ChinaQJLanguageTxt315 %></a>
<% Else %>
        <a href="<%= ClassSeo %><%= Separated %><%= pagenmax %>.<%= HTMLName %>"><%= ChinaQJLanguageTxt315 %></a>
<% End If %>
        <a href="<%= ClassSeo %><%= Separated %><%= pagenmax %>.<%= HTMLName %>"><%= ChinaQJLanguageTxt316 %></a>
<% Else %>
        <a href="<%= ClassSeo %><%= Separated %><%= Sortid %><%= Separated %>1.<%= HTMLName %>"><%= ChinaQJLanguageTxt313 %></a>
<% If page>1 Then %>
        <a href="<%= ClassSeo %><%= Separated %><%= Sortid %><%= Separated %><%= page-1 %>.<%= HTMLName %>"><%= ChinaQJLanguageTxt314 %></a>
<% Else %>
        <a href="<%= ClassSeo %><%= Separated %><%= Sortid %><%= Separated %>1.<%= HTMLName %>"><%= ChinaQJLanguageTxt314 %></a>
<% End If %>
<%
  if(pagenmax>pagec) then pagenmax=pagec
  for i = pagenmin to pagenmax
    if(i=page) then
%>
        <a href="<%= ClassSeo %><%= Separated %><%= Sortid %><%= Separated %><%= i %>.<%= HTMLName %>" class='page_click' ><%= i %></a>
<% Else %>
        <a href="<%= ClassSeo %><%= Separated %><%= Sortid %><%= Separated %><%= i %>.<%= HTMLName %>" class='' ><%= i %></a>
<%
End If
Next
%>
<% If page<pagenmax Then %>
        <a href="<%= ClassSeo %><%= Separated %><%= Sortid %><%= Separated %><%= page+1 %>.<%= HTMLName %>"><%= ChinaQJLanguageTxt315 %></a>
<% Else %>
        <a href="<%= ClassSeo %><%= Separated %><%= Sortid %><%= Separated %><%= pagenmax %>.<%= HTMLName %>"><%= ChinaQJLanguageTxt315 %></a>
<% End If %>
        <a href="<%= ClassSeo %><%= Separated %><%= Sortid %><%= Separated %><%= pagenmax %>.<%= HTMLName %>"><%= ChinaQJLanguageTxt316 %></a>
<% End If %>
<% Else %>
        <a href="<%= myself %>Page=1"><%= ChinaQJLanguageTxt313 %></a>
<% If page>1 Then %>
        <a href="<%= myself %>Page=<%= page-1 %>"><%= ChinaQJLanguageTxt314 %></a>
<% Else %>
        <a href="<%= myself %>Page=1"><%= ChinaQJLanguageTxt314 %></a>
<% End If %>
<%
  if(pagenmax>pagec) then pagenmax=pagec
  for i = pagenmin to pagenmax
    if(i=page) then
%>
        <a href="<%= myself %>Page=<%= i %>" class='page_click' ><%= i %></a>
<% Else %>
        <a href="<%= myself %>Page=<%= i %>" class='' ><%= i %></a>
<%
End If
Next
%>
<% If page<pagenmax Then %>
        <a href="<%= myself %>Page=<%= page+1 %>"><%= ChinaQJLanguageTxt315 %></a>
<% Else %>
        <a href="<%= myself %>Page=<%= pagenmax %>"><%= ChinaQJLanguageTxt315 %></a>
<% End If %>
        <a href="<%= myself %>Page=<%= pagenmax %>"><%= ChinaQJLanguageTxt316 %></a>
<% End If %>
    </span>
<%
  Response.Write "</div>"&VbCrLf
  rs.close
  set rs=nothing
end Function

function ChinaQJImageListWebContent(DataFrom,ID,SortPath)
  dim rs,sql
  dim HideSort
  set rs = server.createobject("adodb.recordset")
  if ID="" then
    SortPath="0,"
  elseif not IsNumeric(ID) then
    response.write "<center>"&ChinaQJLanguageTxt7&"</center>"
    exit function
  elseif conn.execute("select * from "&DataFrom&" Where "&ViewFlag&" and  ID="&ID).eof then
    response.write "<center>"&ChinaQJLanguageTxt7&"</center>"
    exit function
  else
    SortPath=conn.execute("select * from "&DataFrom&" Where "&ViewFlag&" and  ID="&ID)("SortPath")
    conn.execute("update "&DataFrom&" set ClickNumber=ClickNumber+1 Where ID="&ID)
  end If
  If IsDatabaseType = 1 Then
    sql="select * from "&DataFrom&" Where not("&ViewFlag&") and Charindex('"&SortPath&"',SortPath) > 0"
  Else
    sql="select * from "&DataFrom&" Where not("&ViewFlag&") and Instr(SortPath,'"&SortPath&"') > 0"
  End If
  rs.open sql,conn,1,1
  while not rs.eof
    HideSort="and not(Instr(SortPath,'"&rs("SortPath")&"')>0) "&HideSort
    rs.movenext
  wend
  rs.close
  dim idCount
  dim pages
      pages=NewInfo
  dim pagec
  dim page
      page=clng(request("Page"))
  dim pagenc
      pagenc=5
  dim pagenmax
  dim pagenmin
  dim pageprevious
  dim pagenext
  datafrom="ChinaQJ_Image"
  dim datawhere
      If IsDatabaseType = 1 Then
        datawhere="where "&ViewFlag&" and Charindex('"&SortPath&"',SortPath) > 0 "&HideSort& " "
      Else
        datawhere="where "&ViewFlag&" and Instr(SortPath,'"&SortPath&"') > 0 "&HideSort& " "
      End If
  dim sqlid
  dim Myself,PATH_INFO,QUERY_STRING
      PATH_INFO = request.servervariables("PATH_INFO")
      QUERY_STRING = request.ServerVariables("QUERY_STRING")'
      if QUERY_STRING = "" then
        Myself = PATH_INFO & "?"
      elseif Instr(PATH_INFO & "?" & QUERY_STRING,"Page=")=0 then
        Myself= PATH_INFO & "?" & QUERY_STRING & "&"
      else
        Myself = Left(PATH_INFO & "?" & QUERY_STRING,Instr(PATH_INFO & "?" & QUERY_STRING,"Page=")-1)
      end if
  dim taxis
      taxis="order by Sequence desc,ID desc"
  dim i
  sql="select count(ID) as idCount from ["& datafrom &"]" & datawhere
  set rs=server.createobject("adodb.recordset")
  rs.open sql,conn,0,1
  idCount=rs("idCount")
  if(idcount>0) then
    if(idcount mod pages=0)then
      pagec=int(idcount/pages)
    else
      pagec=int(idcount/pages)+1
    end if
    sql="select top 8 id from ["& datafrom &"] " & datawhere & taxis
    set rs=server.createobject("adodb.recordset")
    rs.open sql,conn,1,1
    rs.pagesize = pages
    if page < 1 then page = 1
    if page > pagec then page = pagec
    if pagec > 0 then rs.absolutepage = page
    for i=1 to rs.pagesize
      if rs.eof then exit for
      if(i=1)then
        sqlid=rs("id")
      else
        sqlid=sqlid &","&rs("id")
      end if
      rs.movenext
    next
  end if
  if(idcount>0 and sqlid<>"") then
    sql="select * from ["& datafrom &"] where id in("& sqlid &") "&taxis
    set rs=server.createobject("adodb.recordset")
    rs.open sql,conn,0,1
	%>
    <link href="<%= SysRootDir %>Scripts/iFocus.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="<%= SysRootDir %>Scripts/iFocus.js"></script>
    <script type="text/javascript">addLoadEvent(iFocusChange);</script>
    <div ID="ifocus">
  <div ID="ifocus_pic">
    <div ID="ifocus_piclist" style="left: 0; top: 0;">
      <ul>
      <%
	  while not rs.eof
	  If ISHTML = 1 Then
        AutoLink = ""&rs("ClassSeo")&""&Separated&""&rs("ID")&"."&HTMLName&""
	  Else
		  AutoLink = "ImageView.Asp?ID="&rs("ID")&""
	  End If
	  %>
        <li><a href="<%= AutoLink %>"><img src="<%= rs("ImageFile") %>"></a></li>
      <%
	  rs.movenext
      wend
	  rs.movefirst
	  %>
      </ul>
    </div>
    <div ID="ifocus_opdiv"></div>
    <div ID="ifocus_tx">
      <ul>
      <%
	  while not rs.eof
	  If ISHTML = 1 Then
        AutoLink = ""&rs("ClassSeo")&""&Separated&""&rs("ID")&"."&HTMLName&""
	  Else
		  AutoLink = "ImageView.Asp?ID="&rs("ID")&""
	  End If
	  %>
        <li><a href="<%= AutoLink %>"><%= rs("ImageName"&Language) %></a></li>
      <%
	  rs.movenext
      wend
	  rs.movefirst
	  %>
      </ul>
    </div>
  </div>
  <div ID="ifocus_btn">
    <ul>
      <%
	  while not rs.eof
	  If ISHTML = 1 Then
        AutoLink = ""&rs("ClassSeo")&""&Separated&""&rs("ID")&"."&HTMLName&""
	  Else
		  AutoLink = "ImageView.Asp?ID="&rs("ID")&""
	  End If
	  %>
        <li><a href="<%= AutoLink %>"><img src="<%= rs("ChinaQJPic") %>"></a></li>
      <%
	  rs.movenext
      wend
	  %>
    </ul>
  </div>
</div>
<script>classNormal('ifocus_btn','ifocus_tx');classCurrent('ifocus_btn','ifocus_tx',0);</script>
    <%
  else
    response.write "<center>"&ChinaQJLanguageTxt7&"</center>"
    exit function
  end if
  rs.close
  set rs=nothing
end Function

function ChinaQJMessageWebMenu()
  response.write "<a href=""MessageWrite.Asp"">"&ChinaQJLanguageTxt132&"</a>"
  response.write "<a href=""MessageList.Asp"">"&ChinaQJLanguageTxt133&"</a>"
  response.write "<a href=""MemberMessage.Asp"">"&ChinaQJLanguageTxt82&"</a>"
end function

function ChinaQJMessageWriteWebLocation()
  ChinaQJMessageWriteWebLocation="&nbsp;"&ChinaQJLanguageTxt19&"：<a href=""Index.Asp"" class=""agray"">"&ChinaQJLanguageTxt20&"</a> - <a href=""MessageList.Asp"" class=""agray"">"&ChinaQJLanguageTxt134&"</a> - "&ChinaQJLanguageTxt132&""&VbCrLf
end Function

sub ChinaQJMessageWriteMemInfo()
  dim rs,sql
  set rs = server.createobject("adodb.recordset")
  sql="select * from ChinaQJ_Members where MemName='"&session("MemName")&"'"
  rs.open sql,conn,1,1
  if rs.eof then
    response.write "<center>"&ChinaQJLanguageTxt16&"</center>"
  else
    mMemID=rs("ID")
    if not rs("RealName")="" then
      mLinkman=rs("RealName")
    else
      mLinkman=rs("MemName")
    end if
    mSex=rs("Sex")
    mCompany=rs("Company")
    mAddress=rs("Address")
    mZipCode=rs("ZipCode")
    mTelephone=rs("Telephone")
    mFax=rs("Fax")
    mMobile=rs("Mobile")
    mEmail=rs("Email")
    SecretFlag="<input type=""checkbox"" name=""SecretFlag"" value=""1"" class=""inputnoborder"">"
  end if
  rs.close
  set rs=nothing
end Sub

function ChinaQJMessageWriteForm()
    Response.Write "            <table width=""100%"" border=""0"" align=""center"" cellpadding=""3"" cellspacing=""5"">"&VbCrLf
    Response.Write "              <form action=""MessageSave.Asp?MemberID="&mMemID&""" method=""post"" name=""formWrite"" id=""formWrite"">"&VbCrLf
    Response.Write "                <tr>"&VbCrLf
    Response.Write "                  <td width=""200"" align=""right"">"&ChinaQJLanguageTxt136&"：</td>"&VbCrLf
    Response.Write "                  <td><input name=""MesName"" type=""text"" id=""MesName"" size=""40"" maxlength=""100"" />"&VbCrLf
    Response.Write "                    <font color=""red"">*</font></td>"&VbCrLf
    Response.Write "                </tr>"&VbCrLf
    Response.Write "                <tr>"&VbCrLf
    Response.Write "                  <td align=""right"">"&ChinaQJLanguageTxt137&"：</td>"&VbCrLf
    Response.Write "                  <td><textarea name=""Content"" cols=""70"" rows=""8""></textarea>"&VbCrLf
    Response.Write "                    <font color=""red"">*</font></td>"&VbCrLf
    Response.Write "                </tr>"&VbCrLf
	if Instr(MessageFormPurview,"|4,")>0 then
    Response.Write "                <tr>"&VbCrLf
    Response.Write "                  <td align=""right"">"&ChinaQJLanguageTxt138&"：</td>"&VbCrLf
    Response.Write "                  <td><input name=""Linkman"" type=""text"" id=""Linkman"" value="""&mLinkman&""" size=""20"" maxlength=""50"" />"&VbCrLf
	if Instr(MessageFormPurviewDis,"|4,")>0 then Response.Write " <font color=""red"">*</font>"
    Response.Write "                    </td>"&VbCrLf
    Response.Write "                </tr>"&VbCrLf
	end if
	if Instr(MessageFormPurview,"|5,")>0 then
    Response.Write "                <tr>"&VbCrLf
    Response.Write "                  <td align=""right"">"&ChinaQJLanguageTxt90&"：</td>"&VbCrLf
    Response.Write "                  <td><input name=""Sex"" type=""radio"" value="""&ChinaQJLanguageTxt91&""" class=""inputnoborder"" "
    if mSex=ChinaQJLanguageTxt91 then response.write ("checked")
    response.write " />"&VbCrLf
    Response.Write "                    "&ChinaQJLanguageTxt91&""&VbCrLf
    Response.Write "                    <input type=""radio"" name=""Sex"" value="""&ChinaQJLanguageTxt92&""" class=""inputnoborder"" "
    if mSex=ChinaQJLanguageTxt92 then response.write ("checked")
    response.write " />"&VbCrLf
    Response.Write "                    "&ChinaQJLanguageTxt92&""
	if Instr(MessageFormPurviewDis,"|5,")>0 then Response.Write " <font color=""red"">*</font>"
    Response.Write "                    </td>"&VbCrLf
    Response.Write "                </tr>"&VbCrLf
	end if
	if Instr(MessageFormPurview,"|6,")>0 then
    Response.Write "                <tr>"&VbCrLf
    Response.Write "                  <td align=""right"">"&ChinaQJLanguageTxt21&"：</td>"&VbCrLf
    Response.Write "                  <td><input name=""Company"" type=""text"" value="""&mCompany&""" size=""50"" maxlength=""100"" />"
	if Instr(MessageFormPurviewDis,"|6,")>0 then Response.Write " <font color=""red"">*</font>"
    Response.Write "                    </td>"&VbCrLf
    Response.Write "                </tr>"&VbCrLf
	end if
	if Instr(MessageFormPurview,"|7,")>0 then
    Response.Write "                <tr>"&VbCrLf
    Response.Write "                  <td align=""right"">"&ChinaQJLanguageTxt127&"：</td>"&VbCrLf
    Response.Write "                  <td><input name=""Address"" type=""text"" value="""&mAddress&""" size=""50"" maxlength=""100"" />"
	if Instr(MessageFormPurviewDis,"|7,")>0 then Response.Write " <font color=""red"">*</font>"
    Response.Write "                    </td>"&VbCrLf
    Response.Write "                </tr>"&VbCrLf
	end if
	if Instr(MessageFormPurview,"|8,")>0 then
    Response.Write "                <tr>"&VbCrLf
    Response.Write "                  <td align=""right"">"&ChinaQJLanguageTxt34&"：</td>"&VbCrLf
    Response.Write "                  <td><input name=""ZipCode"" type=""text"" value="""&mZipCode&""" size=""20"" maxlength=""20"" />"
	if Instr(MessageFormPurviewDis,"|8,")>0 then Response.Write " <font color=""red"">*</font>"
    Response.Write "                    </td>"&VbCrLf
    Response.Write "                </tr>"&VbCrLf
	end if
	if Instr(MessageFormPurview,"|9,")>0 then
    Response.Write "                <tr>"&VbCrLf
    Response.Write "                  <td align=""right"">"&ChinaQJLanguageTxt27&"：</td>"&VbCrLf
    Response.Write "                  <td><input name=""Telephone"" type=""text"" id=""Telephone"" value="""&mTelephone&""" size=""20"" maxlength=""50"" />"
	if Instr(MessageFormPurviewDis,"|9,")>0 then Response.Write " <font color=""red"">*</font>"
    Response.Write "                    </td>"&VbCrLf
    Response.Write "                </tr>"&VbCrLf
	end if
	if Instr(MessageFormPurview,"|10,")>0 then
    Response.Write "                <tr>"&VbCrLf
    Response.Write "                  <td align=""right"">"&ChinaQJLanguageTxt35&"：</td>"&VbCrLf
    Response.Write "                  <td><input name=""Fax"" type=""text"" id=""Fax"" value="""&mFax&""" size=""20"" maxlength=""50"" />"
	if Instr(MessageFormPurviewDis,"|10,")>0 then Response.Write " <font color=""red"">*</font>"
    Response.Write "                    </td>"&VbCrLf
    Response.Write "                </tr>"&VbCrLf
	end if
	if Instr(MessageFormPurview,"|11,")>0 then
    Response.Write "                <tr>"&VbCrLf
    Response.Write "                  <td align=""right"">"&ChinaQJLanguageTxt26&"：</td>"&VbCrLf
    Response.Write "                  <td><input name=""Mobile"" type=""text"" id=""Mobile"" value="""&mMobile&""" size=""20"" maxlength=""50"" />"
	if Instr(MessageFormPurviewDis,"|11,")>0 then Response.Write " <font color=""red"">*</font>"
    Response.Write "                    </td>"&VbCrLf
    Response.Write "                </tr>"&VbCrLf
	end if
	if Instr(MessageFormPurview,"|12,")>0 then
    Response.Write "                <tr>"&VbCrLf
    Response.Write "                  <td align=""right"">"&ChinaQJLanguageTxt101&"：</td>"&VbCrLf
    Response.Write "                  <td><input name=""Email"" type=""text"" id=""Email"" value="""&mEmail&""" size=""30"" maxlength=""50"" />"
	if Instr(MessageFormPurviewDis,"|12,")>0 then Response.Write " <font color=""red"">*</font>"
    Response.Write "                    </td>"&VbCrLf
    Response.Write "                </tr>"&VbCrLf
	end if
    Response.Write "                <tr>"&VbCrLf
    Response.Write "                  <td align=""right"">"&ChinaQJLanguageTxt139&"：</td>"&VbCrLf
    Response.Write "                  <td>"&SecretFlag&"</td>"&VbCrLf
    Response.Write "                </tr>"&VbCrLf
    Response.Write "                <tr>"&VbCrLf
    Response.Write "                  <td align=""right"">"&ChinaQJLanguageTxt107&"：</td>"&VbCrLf
    Response.Write "                  <td><input name=""CheckCode"" type=""text"" size=""6"" maxlength=""6"" />"&VbCrLf
    Response.Write "                    <a href=""javascript:refreshimg()"" title="""&ChinaQJLanguageTxt108&"""><img src=""../Include/CheckCode/CheckCode.Asp"" name=""checkcode"" align=""absmiddle"" id=""checkcode"" style=""border: 1px solid #ffffff"" /></a> <font color=""red"">*</font></td>"&VbCrLf
    Response.Write "                </tr>"&VbCrLf
    Response.Write "                <tr>"&VbCrLf
    Response.Write "                  <td align=""right"">&nbsp;</td>"&VbCrLf
    Response.Write "                  <td><input name=""Submit"" type=""submit"" value="""&ChinaQJLanguageTxt140&""" /></td>"&VbCrLf
    Response.Write "                </tr>"&VbCrLf
    Response.Write "              </form>"&VbCrLf
    Response.Write "            </table>"&VbCrLf
end Function

function ChinaQJMessageListWebLocation()
  ChinaQJMessageListWebLocation="&nbsp;"&ChinaQJLanguageTxt19&"：<a href=""Index.Asp"" class=""agray"">"&ChinaQJLanguageTxt20&"</a> - <a href=""MessageList.Asp"" class=""agray"">"&ChinaQJLanguageTxt134&"</a> - "&ChinaQJLanguageTxt131&""&VbCrLf
end Function

function ChinaQJMessageListWebContent()
  dim idCount
  dim pages
      pages=MessageInfo
  dim pagec
  dim page
      page=clng(request("Page"))
  dim pagenc
      pagenc=5
  dim pagenmax
  dim pagenmin
  dim pageprevious
  dim pagenext
  dim datafrom
      datafrom="ChinaQJ_Message "
  dim datawhere
      datawhere="where "&ViewFlag&" "
  dim sqlid
  dim Myself,PATH_INFO,QUERY_STRING
      PATH_INFO = request.servervariables("PATH_INFO")
      QUERY_STRING = request.ServerVariables("QUERY_STRING")'
      if QUERY_STRING = "" then
        Myself = PATH_INFO & "?"
      elseif Instr(PATH_INFO & "?" & QUERY_STRING,"Page=")=0 then
        Myself= PATH_INFO & "?" & QUERY_STRING & "&"
      else
        Myself = Left(PATH_INFO & "?" & QUERY_STRING,Instr(PATH_INFO & "?" & QUERY_STRING,"Page=")-1)
      end if
  dim taxis
      taxis="order by id desc "
  dim i
  dim rs,sql
  set rs = server.createobject("adodb.recordset")
  sql="select count(ID) as idCount from ["& datafrom &"]" & datawhere
  set rs=server.createobject("adodb.recordset")
  rs.open sql,conn,0,1
  idCount=rs("idCount")
  if(idcount>0) then
    if(idcount mod pages=0)then
      pagec=int(idcount/pages)
    else
      pagec=int(idcount/pages)+1
    end if
    sql="select id from ["& datafrom &"] " & datawhere & taxis
    set rs=server.createobject("adodb.recordset")
    rs.open sql,conn,1,1
    rs.pagesize = pages
    if page < 1 then page = 1
    if page > pagec then page = pagec
    if pagec > 0 then rs.absolutepage = page
    for i=1 to rs.pagesize
      if rs.eof then exit for
      if(i=1)then
        sqlid=rs("id")
      else
        sqlid=sqlid &","&rs("id")
      end if
      rs.movenext
    next
  end if
  if(idcount>0 and sqlid<>"") then
    sql="select * from ["& datafrom &"] where id in("& sqlid &") "&taxis
    set rs=server.createobject("adodb.recordset")
    rs.open sql,conn,0,1
    while not rs.eof
    Response.Write "<table width=""100%"" border=""0"" cellspacing=""0"" cellpadding=""0"">"&VbCrLf
    Response.Write "  <tr>"&VbCrLf
    Response.Write "    <td width=""5%"" height=""25"" bgcolor=""#820000"" align=""center""><font color=""#FFFFFF""><b>"&rs("ID")&"</b></font></td>"&VbCrLf
    Response.Write "    <td width=""50%"" height=""25"" bgcolor=""#EDEEEF"" align=""left"" style=""padding-left: 8px""><font color=""#333333""><b>"&rs("Company")&"</b></font>("&rs("Linkman")&""&rs("Sex")&")</td>"&VbCrLf
    Response.Write "    <td width=""45%"" height=""25"" bgcolor=""#EDEEEF"" align=""right"" style=""padding-right: 8px""><font color=""#808080"">"&ChinaQJLanguageTxt110&"：</font>"&rs("Addtime")&"</td>"&VbCrLf
    Response.Write "  </tr>"&VbCrLf
    Response.Write "</table>"&VbCrLf
    Response.Write "<table width=""100%"" border=""0"" cellspacing=""0"" cellpadding=""1"">"&VbCrLf
    Response.Write "  <tr align=""left"">"&VbCrLf
    Response.Write "    <td width=""15%"" height=""20"" align=""right"" style=""padding-right: 8px"">"&ChinaQJLanguageTxt111&"：</td>"&VbCrLf
    Response.Write "    <td><b>"&rs("MesName")&"</b></td>"&VbCrLf
    Response.Write "  </tr>"&VbCrLf
    Response.Write "  <tr align=""left"">"&VbCrLf
    Response.Write "    <td height=""20"" align=""right"" style=""padding-right: 8px"">"&ChinaQJLanguageTxt112&"：</td>"&VbCrLf
    Response.Write "    <td style=""padding-right: 5px"">"&ChinaQJMessageListMessageContent(rs("MemID"),rs("SecretFlag"),HtmlStrReplace(rs("Content")))&"</td>"&VbCrLf
    Response.Write "  </tr>"&VbCrLf
    If rs("ReplyContent") <> "" Then
    Response.Write "  <tr>"&VbCrLf
    Response.Write "    <td>&nbsp;</td>"&VbCrLf
    Response.Write "    <td bgcolor=""#F7F7F7"" style=""line-height: 200%""><font color=""#333333""><b>"&ChinaQJLanguageTxt113&"：</b></font><br />"&ChinaQJMessageListMessageReply (rs("MemID"),rs("MesName"),rs("SecretFlag"),rs("ReplyContent"))&"</td>"&VbCrLf
    Response.Write "  </tr>"&VbCrLf
    End If
    Response.Write "  <tr>"&VbCrLf
    Response.Write "    <td colspan=""2"" height=""5""></td>"&VbCrLf
    Response.Write "  </tr>"&VbCrLf
    Response.Write "</table>"&VbCrLf
    rs.movenext
    wend
  else
    response.write "<center>"&ChinaQJLanguageTxt7&"</center>"
    exit function
  end if
  Response.Write "<table width=""98%"" border=""0"" cellspacing=""0"" cellpadding=""0"">"&VbCrLf
  Response.Write "  <tr height=""35"">"&VbCrLf
  Response.Write "    <td align=""center"">"&VbCrLf
  Response.Write ""&ChinaQJLanguageTxt44&"<strong style=""color:red"">"&idcount&"</strong>"&ChinaQJLanguageTxt45&" "&ChinaQJLanguageTxt46&"：<strong style=""color:red"">"&page&"</strong>/"&pagec&" "&ChinaQJLanguageTxt47&"：<strong style=""color:red"">"&pages&"</strong>"&ChinaQJLanguageTxt45&"" & vbCrLf
  pagenmin=page-pagenc
  pagenmax=page+pagenc
  if(pagenmin<1) then pagenmin=1
  if(page>1) then response.write ("<a href="""& myself &"Page=1"" title="""&ChinaQJLanguageTxt48&"""><font face=""webdings"" color=""#000000"">9</font></a> ")
  if page-(pagenc*2+1)<=0 then
    pageprevious=1
  else
    pageprevious=page-(pagenc*2+1)
  end if
  if(pagenmin>1) then response.write ("<a href="""& myself &"Page="& pageprevious &""" title="""&ChinaQJLanguageTxt49&""& pageprevious &""&ChinaQJLanguageTxt50&"""><font face=""webdings"" color=""#000000"">3</font></a> ")
  if(pagenmax>pagec) then pagenmax=pagec
  for i = pagenmin to pagenmax
    if(i=page) then
      response.write ("&nbsp;<strong style=""color:red"">"& i &"</strong>&nbsp;")
    else
      response.write ("[<a href="""& myself &"Page="& i &""">"& i &"</a>]")
    end if
  next
  if page+(pagenc*2+1)>=pagec then
    pagenext=pagec
  else
    pagenext=page+(pagenc*2+1)
  end if
  if(pagenmax<pagec) then response.write (" <a href="""& myself &"Page="& pagenext &""" title="""&ChinaQJLanguageTxt51&""&pagenext&""&ChinaQJLanguageTxt50&"""><font face=""webdings"" color=""#999999"">:</font></a> ")
  if(page<pagec) then response.write (" <a href="""& myself &"Page="& pagec &""" title="""&ChinaQJLanguageTxt51&""&pagec&""&ChinaQJLanguageTxt50&"""><font face=""webdings"" color=""#000000"">:</font></a>")
  Response.Write "    </td>"&VbCrLf
  Response.Write "  </tr>"&VbCrLf
  Response.Write "</table>"&VbCrLf
  rs.close
  set rs=nothing
end function

function ChinaQJMessageListMessageContent(MemID,SecretFlag,Content)
  if SecretFlag then
    dim rs,sql
    set rs = server.createobject("adodb.recordset")
    sql="select * from ChinaQJ_Members where ID="&MemID
    rs.open sql,conn,1,1
    if rs("MemName")=session("MemName") and session("MemLogin")="Succeed" then
      ChinaQJMessageListMessageContent= Content
    else
      ChinaQJMessageListMessageContent=ChinaQJLanguageTxt114
    end if
    rs.close
    set rs=nothing
  else
    ChinaQJMessageListMessageContent=Content
  end if
end function

function ChinaQJMessageListMessageReply(MemID,MesName,SecretFlag,ReplyContent)
  if ReplyContent<>"" then
    if SecretFlag then
      dim rs,sql
      set rs = server.createobject("adodb.recordset")
      sql="select * from ChinaQJ_Members where ID="&MemID
      rs.open sql,conn,1,1
      if rs("MemName")=session("MemName") and session("MemLogin")="Succeed" then
        ChinaQJMessageListMessageReply=ChinaQJMessageListMessageReply&HtmlStrReplace(ReplyContent)
      else
        ChinaQJMessageListMessageReply=ChinaQJMessageListMessageReply&"<font color=""#CC0000"">"&ChinaQJLanguageTxt115&"</font>"
      end if
      rs.close
      set rs=nothing
    else
        ChinaQJMessageListMessageReply=ChinaQJMessageListMessageReply&HtmlStrReplace(ReplyContent)
    end if
  end if
end Function

Function ChinaQJMemberUserWebMenu()
    If session("MemName")="" Or session("GroupID")="" Or session("MemLogin")<>"Succeed" Then
      response.write "<a href=""MemberRegister.Asp"">"&ChinaQJLanguageTxt80&"</a>"
    Else
      response.write "<a href=""MemberInfo.Asp"">"&ChinaQJLanguageTxt81&"</a>"
      response.write "<a href=""MemberMessage.Asp"">"&ChinaQJLanguageTxt82&"</a>"
      response.write "<a href=""MemberOrder.Asp"">"&ChinaQJLanguageTxt83&"</a>"
      response.write "<a href=""MemberTalent.Asp"">"&ChinaQJLanguageTxt84&"</a>"
      response.write "<a href=""MemberLogin.Asp?Action=Out"">"&ChinaQJLanguageTxt85&"</a>"
    End If
End Function

function ChinaQJMemberTalentWebLocation()
  ChinaQJMemberTalentWebLocation="&nbsp;"&ChinaQJLanguageTxt19&"：<a href=""Index.Asp"" class=""agray"">"&ChinaQJLanguageTxt20&"</a> - <a href=""MemberCenter.Asp"" class=""agray"">"&ChinaQJLanguageTxt22&"</a> - "&ChinaQJLanguageTxt66&""&VbCrLf
end Function

function ChinaQJMemberTalentWebContent()
  dim idCount
  dim pages
      pages=2
  dim pagec
  dim page
      page=clng(request("Page"))
  dim pagenc
      pagenc=5
  dim pagenmax
  dim pagenmin
  dim pageprevious
  dim pagenext
  dim datafrom
      datafrom="ChinaQJ_Talents "
  dim datawhere
      datawhere="where MemID="&conn.execute("select * from ChinaQJ_Members where MemName='"&session("MemName")&"'")("ID")&" "
  dim sqlid
  dim Myself,PATH_INFO,QUERY_STRING
      PATH_INFO = request.servervariables("PATH_INFO")
      QUERY_STRING = request.ServerVariables("QUERY_STRING")'
      if QUERY_STRING = "" then
        Myself = PATH_INFO & "?"
      elseif Instr(PATH_INFO & "?" & QUERY_STRING,"Page=")=0 then
        Myself= PATH_INFO & "?" & QUERY_STRING & "&"
      else
        Myself = Left(PATH_INFO & "?" & QUERY_STRING,Instr(PATH_INFO & "?" & QUERY_STRING,"Page=")-1)
      end if
  dim taxis
      taxis="order by id desc "
  dim i
  dim rs,sql
  set rs = server.createobject("adodb.recordset")
  sql="select count(ID) as idCount from ["& datafrom &"]" & datawhere
  set rs=server.createobject("adodb.recordset")
  rs.open sql,conn,0,1
  idCount=rs("idCount")
  if(idcount>0) then
    if(idcount mod pages=0)then
      pagec=int(idcount/pages)
    else
      pagec=int(idcount/pages)+1
    end if
    sql="select id from ["& datafrom &"] " & datawhere & taxis
    set rs=server.createobject("adodb.recordset")
    rs.open sql,conn,1,1
    rs.pagesize = pages
    if page < 1 then page = 1
    if page > pagec then page = pagec
    if pagec > 0 then rs.absolutepage = page
    for i=1 to rs.pagesize
      if rs.eof then exit for
      if(i=1)then
        sqlid=rs("id")
      else
        sqlid=sqlid &","&rs("id")
      end if
      rs.movenext
    next
  end if
  if(idcount>0 and sqlid<>"") then
    sql="select * from ["& datafrom &"] where id in("& sqlid &") "&taxis
    set rs=server.createobject("adodb.recordset")
    rs.open sql,conn,0,1
    while not rs.eof
        Response.Write "<table width=""100%"" border=""0"" align=""center"" cellpadding=""3"" cellspacing=""5"">"&VbCrLf
        Response.Write "  <tr>"&VbCrLf
        Response.Write "    <td style=""background:url("&StylePath&"bg1.gif) repeat-x left bottom"">"&ChinaQJLanguageTxt118&"：<strong style=""color:red"">"&rs("TalentsName")&"</strong> "&ChinaQJLanguageTxt119&"："&FormatDate(rs("Addtime"),13)&""&VbCrLf
        if rs("ReplyTime")<>"" then response.write ""&ChinaQJLanguageTxt120&"："&FormatDate(rs("ReplyTime"),13)&""
        Response.Write "    </td>"&VbCrLf
        Response.Write "  </tr>"&VbCrLf
        Response.Write "  <tr>"&VbCrLf
        Response.Write "    <td style=""line-height:200%"">"&ChinaQJLanguageTxt121&"："&rs("Linkman")&"<br />"&VbCrLf
        Response.Write "      "&ChinaQJLanguageTxt122&"："&rs("Sex")&"<br />"&VbCrLf
        Response.Write "      "&ChinaQJLanguageTxt123&"："&FormatDate(rs("BirthDate"),13)&"<br />"&VbCrLf
        Response.Write "      "&ChinaQJLanguageTxt124&"："&int(rs("Stature"))&"CM<br />"&VbCrLf
        Response.Write "      "&ChinaQJLanguageTxt125&"："&rs("Marriage")&"<br />"&VbCrLf
        Response.Write "      "&ChinaQJLanguageTxt126&"："&rs("RegResidence")&"<br />"&VbCrLf
        Response.Write "      "&ChinaQJLanguageTxt127&"："&rs("Address")&"<br />"&VbCrLf
        Response.Write "      "&ChinaQJLanguageTxt34&"："&rs("ZipCode")&"<br />"&VbCrLf
        Response.Write "      "&ChinaQJLanguageTxt27&"："&rs("Telephone")&"<br />"&VbCrLf
        Response.Write "      "&ChinaQJLanguageTxt26&"："&rs("Mobile")&"<br />"&VbCrLf
        Response.Write "      "&ChinaQJLanguageTxt101&"："&rs("Email")&"<br />"&VbCrLf
        Response.Write "      <strong style=""color:red"">"&ChinaQJLanguageTxt128&"：</strong><br />"&VbCrLf
        Response.Write "      "&HtmlStrReplace(rs("EduResume"))&"<br />"&VbCrLf
        Response.Write "      <strong style=""color:red"">"&ChinaQJLanguageTxt129&"：</strong><br />"&VbCrLf
        Response.Write "      "&HtmlStrReplace(rs("JobResume"))&"<br />"&VbCrLf
        if rs("ReplyContent")<>"" then response.write "<strong style=""color:blue"">"&ChinaQJLanguageTxt130&"：</strong><br />"&HtmlStrReplace(rs("ReplyContent"))
        Response.Write "      </td>"&VbCrLf
        Response.Write "  </tr>"&VbCrLf
        Response.Write "</table>"&VbCrLf
      rs.movenext
    wend
  else
    response.write "<center>"&ChinaQJLanguageTxt7&"</center>"
    exit function
  end if
  Response.Write "<table width=""98%"" border=""0"" cellspacing=""0"" cellpadding=""0"">"&VbCrLf
  Response.Write "  <tr height=""35"">"&VbCrLf
  Response.Write "    <td align=""center"">"&VbCrLf
  Response.Write ""&ChinaQJLanguageTxt44&"<strong style=""color:red"">"&idcount&"</strong>"&ChinaQJLanguageTxt45&" "&ChinaQJLanguageTxt46&"：<strong style=""color:red"">"&page&"</strong>/"&pagec&" "&ChinaQJLanguageTxt47&"：<strong style=""color:red"">"&pages&"</strong>"&ChinaQJLanguageTxt45&"" & vbCrLf
  pagenmin=page-pagenc
  pagenmax=page+pagenc
  if(pagenmin<1) then pagenmin=1
  if(page>1) then response.write ("<a href="""& myself &"Page=1"" title="""&ChinaQJLanguageTxt48&"""><font face=""webdings"" color=""#000000"">9</font></a> ")
  if page-(pagenc*2+1)<=0 then
    pageprevious=1
  else
    pageprevious=page-(pagenc*2+1)
  end if
  if(pagenmin>1) then response.write ("<a href="""& myself &"Page="& pageprevious &""" title="""&ChinaQJLanguageTxt49&""& pageprevious &""&ChinaQJLanguageTxt50&"""><font face=""webdings"" color=""#000000"">3</font></a> ")
  if(pagenmax>pagec) then pagenmax=pagec
  for i = pagenmin to pagenmax
    if(i=page) then
      response.write ("&nbsp;<strong style=""color:red"">"& i &"</strong>&nbsp;")
    else
      response.write ("[<a href="""& myself &"Page="& i &""">"& i &"</a>]")
    end if
  next
  if page+(pagenc*2+1)>=pagec then
    pagenext=pagec
  else
    pagenext=page+(pagenc*2+1)
  end if
  if(pagenmax<pagec) then response.write (" <a href="""& myself &"Page="& pagenext &""" title="""&ChinaQJLanguageTxt51&""&pagenext&""&ChinaQJLanguageTxt50&"""><font face=""webdings"" color=""#999999"">:</font></a> ")
  if(page<pagec) then response.write (" <a href="""& myself &"Page="& pagec &""" title="""&ChinaQJLanguageTxt51&""&pagec&""&ChinaQJLanguageTxt50&"""><font face=""webdings"" color=""#000000"">:</font></a>")
  Response.Write "    </td>"&VbCrLf
  Response.Write "  </tr>"&VbCrLf
  Response.Write "</table>"&VbCrLf
  rs.close
  set rs=nothing
end Function

function ChinaQJMemberRegisterWebLocation()
  ChinaQJMemberRegisterWebLocation="&nbsp;"&ChinaQJLanguageTxt19&"：<a href=""Index.Asp"" class=""agray"">"&ChinaQJLanguageTxt20&"</a> - <a href=""MemberCenter.Asp"" class=""agray"">"&ChinaQJLanguageTxt22&"</a> - "&ChinaQJLanguageTxt80&""&VbCrLf
end Function

function ChinaQJMemberRegisterForm()
    Response.Write "        <table width=""100%"" border=""0"" align=""center"" cellpadding=""3"" cellspacing=""5"">"&VbCrLf
    Response.Write "          <form action=""MemberSaveReg.Asp"" method=""post"" name=""formReg"" id=""formReg"">"&VbCrLf
    Response.Write "              <tr>"&VbCrLf
    Response.Write "                <td width=""200"" align=""right"">"&ChinaQJLanguageTxt87&"：</td>"&VbCrLf
    Response.Write "                <td><input name=""MemName"" type=""text"" id=""MemName"" size=""20"" maxlength=""16"" /> <font color=""red"">*</font>("&ChinaQJLanguageTxt116&")</td>"&VbCrLf
    Response.Write "              </tr>"&VbCrLf
	if Instr(UserRegisterPurview,"|3,")>0 then
    Response.Write "              <tr>"&VbCrLf
    Response.Write "                <td align=""right"">"&ChinaQJLanguageTxt89&"：</td>"&VbCrLf
    Response.Write "                <td><input name=""RealName"" type=""text"" id=""RealName"" size=""20"" maxlength=""50"" />"
	if Instr(UserRegisterPurviewDis,"|3,")>0 then Response.Write " <font color=""red"">*</font>"
	Response.Write "</td>"&VbCrLf
    Response.Write "              </tr>"&VbCrLf
	end if
	if Instr(UserRegisterPurview,"|4,")>0 then
    Response.Write "              <tr>"&VbCrLf
    Response.Write "                <td align=""right"">"&ChinaQJLanguageTxt90&"：</td>"&VbCrLf
    Response.Write "                <td><input name=""Sex"" type=""radio"" value="""&ChinaQJLanguageTxt92&""" checked=""checked"" class=""inputnoborder"" />"&ChinaQJLanguageTxt91&" <input type=""radio"" name=""Sex"" value="""&ChinaQJLanguageTxt92&""" class=""inputnoborder"" />"&ChinaQJLanguageTxt92&" "
	if Instr(UserRegisterPurviewDis,"|4,")>0 then Response.Write " <font color=""red"">*</font>"
	Response.Write "</td>"&VbCrLf
    Response.Write "              </tr>"&VbCrLf
	end if
    Response.Write "              <tr>"&VbCrLf
    Response.Write "                <td align=""right"">"&ChinaQJLanguageTxt93&"：</td>"&VbCrLf
    Response.Write "                <td><input name=""Password"" type=""password"" id=""Password"" size=""20"" maxlength=""16"" /> <font color=""red"">*</font></td>"&VbCrLf
    Response.Write "              </tr>"&VbCrLf
    Response.Write "              <tr>"&VbCrLf
    Response.Write "                <td align=""right"">"&ChinaQJLanguageTxt95&"：</td>"&VbCrLf
    Response.Write "                <td><input name=""vPassword"" type=""password"" id=""vPassword"" size=""20"" maxlength=""16"" /> <font color=""red"">*</font></td>"&VbCrLf
    Response.Write "              </tr>"&VbCrLf
	if Instr(UserRegisterPurview,"|5,")>0 then
    Response.Write "              <tr>"&VbCrLf
    Response.Write "                <td align=""right"">"&ChinaQJLanguageTxt96&"：</td>"&VbCrLf
    Response.Write "                <td><input name=""Question"" type=""text"" id=""Question"" size=""40"" maxlength=""100"" />"
	if Instr(UserRegisterPurviewDis,"|5,")>0 then Response.Write " <font color=""red"">*</font>"
	Response.Write "</td>"&VbCrLf
    Response.Write "              </tr>"&VbCrLf
	end if
	if Instr(UserRegisterPurview,"|6,")>0 then
    Response.Write "              <tr>"&VbCrLf
    Response.Write "                <td align=""right"">"&ChinaQJLanguageTxt97&"：</td>"&VbCrLf
    Response.Write "                <td><input name=""Answer"" type=""text"" id=""Answer"" size=""40"" maxlength=""100"" />"
	if Instr(UserRegisterPurviewDis,"|6,")>0 then Response.Write " <font color=""red"">*</font>"
	Response.Write "</td>"&VbCrLf
    Response.Write "              </tr>"&VbCrLf
	end if
	if Instr(UserRegisterPurview,"|7,")>0 then
    Response.Write "              <tr>"&VbCrLf
    Response.Write "                <td align=""right"">"&ChinaQJLanguageTxt99&"：</td>"&VbCrLf
    Response.Write "                <td><input name=""Company"" type=""text"" id=""Company"" size=""40"" maxlength=""100"" />"
	if Instr(UserRegisterPurviewDis,"|7,")>0 then Response.Write " <font color=""red"">*</font>"
	Response.Write "</td>"&VbCrLf
    Response.Write "              </tr>"&VbCrLf
	end if
	if Instr(UserRegisterPurview,"|8,")>0 then
    Response.Write "              <tr>"&VbCrLf
    Response.Write "                <td align=""right"">"&ChinaQJLanguageTxt100&"：</td>"&VbCrLf
    Response.Write "                <td><input name=""Address"" type=""text"" id=""Address"" size=""40"" maxlength=""100"" />"
	if Instr(UserRegisterPurviewDis,"|8,")>0 then Response.Write " <font color=""red"">*</font>"
	Response.Write "</td>"&VbCrLf
    Response.Write "              </tr>"&VbCrLf
	end if
	if Instr(UserRegisterPurview,"|9,")>0 then
    Response.Write "              <tr>"&VbCrLf
    Response.Write "                <td align=""right"">"&ChinaQJLanguageTxt34&"：</td>"&VbCrLf
    Response.Write "                <td><input name=""ZipCode"" type=""text"" id=""ZipCode"" size=""20"" maxlength=""20"" />"
	if Instr(UserRegisterPurviewDis,"|9,")>0 then Response.Write " <font color=""red"">*</font>"
	Response.Write "</td>"&VbCrLf
    Response.Write "              </tr>"&VbCrLf
	end if
	if Instr(UserRegisterPurview,"|10,")>0 then
    Response.Write "              <tr>"&VbCrLf
    Response.Write "                <td align=""right"">"&ChinaQJLanguageTxt27&"：</td>"&VbCrLf
    Response.Write "                <td><input name=""Telephone"" type=""text"" id=""Telephone"" size=""20"" maxlength=""50"" />"
	if Instr(UserRegisterPurviewDis,"|10,")>0 then Response.Write " <font color=""red"">*</font>"
	Response.Write "</td>"&VbCrLf
    Response.Write "              </tr>"&VbCrLf
	end if
	if Instr(UserRegisterPurview,"|11,")>0 then
    Response.Write "              <tr>"&VbCrLf
    Response.Write "                <td align=""right"">"&ChinaQJLanguageTxt35&"：</td>"&VbCrLf
    Response.Write "                <td><input name=""Fax"" type=""text"" id=""Fax"" size=""20"" maxlength=""50"" />"
	if Instr(UserRegisterPurviewDis,"|11,")>0 then Response.Write " <font color=""red"">*</font>"
	Response.Write "</td>"&VbCrLf
    Response.Write "              </tr>"&VbCrLf
	end if
	if Instr(UserRegisterPurview,"|12,")>0 then
    Response.Write "              <tr>"&VbCrLf
    Response.Write "                <td align=""right"">"&ChinaQJLanguageTxt26&"：</td>"&VbCrLf
    Response.Write "                <td><input name=""Mobile"" type=""text"" id=""Mobile"" size=""20"" maxlength=""50"" />"
	if Instr(UserRegisterPurviewDis,"|12,")>0 then Response.Write " <font color=""red"">*</font>"
	Response.Write "</td>"&VbCrLf
    Response.Write "              </tr>"&VbCrLf
	end if
	if Instr(UserRegisterPurview,"|13,")>0 then
    Response.Write "              <tr>"&VbCrLf
    Response.Write "                <td align=""right"">"&ChinaQJLanguageTxt101&"：</td>"&VbCrLf
    Response.Write "                <td><input name=""Email"" type=""text"" id=""Email"" size=""30"" maxlength=""50"" />"
	if Instr(UserRegisterPurviewDis,"|13,")>0 then Response.Write " <font color=""red"">*</font>"
	Response.Write "</td>"&VbCrLf
    Response.Write "              </tr>"&VbCrLf
	end if
	if Instr(UserRegisterPurview,"|14,")>0 then
    Response.Write "              <tr>"&VbCrLf
    Response.Write "                <td align=""right"">"&ChinaQJLanguageTxt102&"：</td>"&VbCrLf
    Response.Write "                <td><input name=""HomePage"" type=""text"" id=""HomePage"" size=""30"" maxlength=""50"" />"
	if Instr(UserRegisterPurviewDis,"|14,")>0 then Response.Write " <font color=""red"">*</font>"
	Response.Write "</td>"&VbCrLf
    Response.Write "              </tr>"&VbCrLf
	end if
    Response.Write "              <tr>"&VbCrLf
    Response.Write "                <td align=""right"">"&ChinaQJLanguageTxt107&"：</td>"&VbCrLf
    Response.Write "                <td><input name=""CheckCode"" type=""text"" size=""6"" maxlength=""6"" /> <a href=""javascript:refreshimg()"" title="""&ChinaQJLanguageTxt108&"""><img src=""../Include/CheckCode/CheckCode.Asp"" name=""checkcode"" align=""absmiddle"" id=""checkcode"" style=""border: 1px solid #ffffff"" /></a> <font color=""red"">*</font></td>"&VbCrLf
    Response.Write "              </tr>"&VbCrLf
    Response.Write "              <tr>"&VbCrLf
    Response.Write "                <td align=""right"">&nbsp;</td>"&VbCrLf
    Response.Write "                <td><input name=""Submit"" type=""submit"" value="""&ChinaQJLanguageTxt117&""" /></td>"&VbCrLf
    Response.Write "              </tr>"&VbCrLf
    Response.Write "              </form>"&VbCrLf
    Response.Write "            </table>"&VbCrLf
end Function

function ChinaQJMemberOrderWebLocation()
  ChinaQJMemberOrderWebLocation="&nbsp;"&ChinaQJLanguageTxt19&"：<a href=""Index.Asp"" class=""agray"">"&ChinaQJLanguageTxt20&"</a> - <a href=""MemberCenter.Asp"" class=""agray"">"&ChinaQJLanguageTxt22&"</a> - "&ChinaQJLanguageTxt83&""&VbCrLf
end Function

function ChinaQJMemberOrderWebContent()
  dim idCount
  dim pages
      pages=4
  dim pagec
  dim page
      page=clng(request("Page"))
  dim pagenc
      pagenc=5
  dim pagenmax
  dim pagenmin
  dim pageprevious
  dim pagenext
  dim datafrom
      datafrom="ChinaQJ_Order "
  dim datawhere
      datawhere="where MemID="&conn.execute("select * from ChinaQJ_Members where MemName='"&session("MemName")&"'")("ID")&" "
  dim sqlid
  dim Myself,PATH_INFO,QUERY_STRING
      PATH_INFO = request.servervariables("PATH_INFO")
      QUERY_STRING = request.ServerVariables("QUERY_STRING")'
      if QUERY_STRING = "" then
        Myself = PATH_INFO & "?"
      elseif Instr(PATH_INFO & "?" & QUERY_STRING,"Page=")=0 then
        Myself= PATH_INFO & "?" & QUERY_STRING & "&"
      else
        Myself = Left(PATH_INFO & "?" & QUERY_STRING,Instr(PATH_INFO & "?" & QUERY_STRING,"Page=")-1)
      end if
  dim taxis
      taxis="order by id desc "
  dim i
  dim rs,sql
  set rs = server.createobject("adodb.recordset")
  sql="select count(ID) as idCount from ["& datafrom &"]" & datawhere
  set rs=server.createobject("adodb.recordset")
  rs.open sql,conn,0,1
  idCount=rs("idCount")
  if(idcount>0) then
    if(idcount mod pages=0)then
      pagec=int(idcount/pages)
    else
      pagec=int(idcount/pages)+1
    end if
    sql="select id from ["& datafrom &"] " & datawhere & taxis
    set rs=server.createobject("adodb.recordset")
    rs.open sql,conn,1,1
    rs.pagesize = pages
    if page < 1 then page = 1
    if page > pagec then page = pagec
    if pagec > 0 then rs.absolutepage = page
    for i=1 to rs.pagesize
      if rs.eof then exit for
      if(i=1)then
        sqlid=rs("id")
      else
        sqlid=sqlid &","&rs("id")
      end if
      rs.movenext
    next
  end if
  if(idcount>0 and sqlid<>"") then
    sql="select * from ["& datafrom &"] where id in("& sqlid &") "&taxis
    set rs=server.createobject("adodb.recordset")
    rs.open sql,conn,0,1
    while not rs.eof
        Response.Write "<table width=""100%"" border=""0"" align=""center"" cellpadding=""3"" cellspacing=""5"">"&VbCrLf
        Response.Write "  <tr>"&VbCrLf
        Response.Write "    <td style=""background:url("&StylePath&"bg1.gif) repeat-x left bottom""><strong style=""color:red"">"&rs("OrderName")&"</strong> "&ChinaQJLanguageTxt197&"："&FormatDate(rs("Addtime"),13)&""&VbCrLf
        if rs("ReplyTime")<>"" then response.write ""&ChinaQJLanguageTxt120&"："&FormatDate(rs("ReplyTime"),13)&""
        Response.Write "    </td>"&VbCrLf
        Response.Write "  </tr>"&VbCrLf
        Response.Write "  <tr>"&VbCrLf
        Response.Write "    <td style=""line-height:200%"">"&HtmlStrReplace(rs("Remark"))&"<br />"&VbCrLf
        Response.Write "      "&ChinaQJLanguageTxt121&"："&rs("Linkman")&"<br />"&VbCrLf
        Response.Write "      "&ChinaQJLanguageTxt122&"："&rs("Sex")&"<br />"&VbCrLf
        Response.Write "      "&ChinaQJLanguageTxt99&"："&rs("Company")&"<br />"&VbCrLf
        Response.Write "      "&ChinaQJLanguageTxt127&"："&rs("Address")&"<br />"&VbCrLf
        Response.Write "      "&ChinaQJLanguageTxt34&"："&rs("ZipCode")&"<br />"&VbCrLf
        Response.Write "      "&ChinaQJLanguageTxt27&"："&rs("Telephone")&"<br />"&VbCrLf
        Response.Write "      "&ChinaQJLanguageTxt35&"："&rs("Fax")&"<br />"&VbCrLf
        Response.Write "      "&ChinaQJLanguageTxt26&"："&rs("Mobile")&"<br />"&VbCrLf
        Response.Write "      "&ChinaQJLanguageTxt101&"："&rs("Email")&"<br />"&VbCrLf
        if rs("ReplyContent")<>"" then response.write "<strong style=""color:red"">"&ChinaQJLanguageTxt130&"：</strong><br />"&HtmlStrReplace(rs("ReplyContent"))
        Response.Write "      </td>"&VbCrLf
        Response.Write "  </tr>"&VbCrLf
        Response.Write "</table>"&VbCrLf
      rs.movenext
    wend
  else
    response.write "<center>"&ChinaQJLanguageTxt7&"</center>"
    exit function
  end if
  Response.Write "<table width=""98%"" border=""0"" cellspacing=""0"" cellpadding=""0"">"&VbCrLf
  Response.Write "  <tr height=""35"">"&VbCrLf
  Response.Write "    <td align=""center"">"&VbCrLf
  Response.Write ""&ChinaQJLanguageTxt44&"<strong style=""color:red"">"&idcount&"</strong>"&ChinaQJLanguageTxt45&" "&ChinaQJLanguageTxt46&"：<strong style=""color:red"">"&page&"</strong>/"&pagec&" "&ChinaQJLanguageTxt47&"：<strong style=""color:red"">"&pages&"</strong>"&ChinaQJLanguageTxt45&"" & vbCrLf
  pagenmin=page-pagenc
  pagenmax=page+pagenc
  if(pagenmin<1) then pagenmin=1
  if(page>1) then response.write ("<a href="""& myself &"Page=1"" title="""&ChinaQJLanguageTxt48&"""><font face=""webdings"" color=""#000000"">9</font></a> ")
  if page-(pagenc*2+1)<=0 then
    pageprevious=1
  else
    pageprevious=page-(pagenc*2+1)
  end if
  if(pagenmin>1) then response.write ("<a href="""& myself &"Page="& pageprevious &""" title="""&ChinaQJLanguageTxt49&""& pageprevious &""&ChinaQJLanguageTxt50&"""><font face=""webdings"" color=""#000000"">3</font></a> ")
  if(pagenmax>pagec) then pagenmax=pagec
  for i = pagenmin to pagenmax
    if(i=page) then
      response.write ("&nbsp;<strong style=""color:red"">"& i &"</strong>&nbsp;")
    else
      response.write ("[<a href="""& myself &"Page="& i &""">"& i &"</a>]")
    end if
  next
  if page+(pagenc*2+1)>=pagec then
    pagenext=pagec
  else
    pagenext=page+(pagenc*2+1)
  end if
  if(pagenmax<pagec) then response.write (" <a href="""& myself &"Page="& pagenext &""" title="""&ChinaQJLanguageTxt51&""&pagenext&""&ChinaQJLanguageTxt50&"""><font face=""webdings"" color=""#999999"">:</font></a> ")
  if(page<pagec) then response.write (" <a href="""& myself &"Page="& pagec &""" title="""&ChinaQJLanguageTxt51&""&pagec&""&ChinaQJLanguageTxt50&"""><font face=""webdings"" color=""#000000"">:</font></a>")
  Response.Write "    </td>"&VbCrLf
  Response.Write "  </tr>"&VbCrLf
  Response.Write "</table>"&VbCrLf
  rs.close
  set rs=nothing
end Function

function ChinaQJMemberMessageWebLocation()
  ChinaQJMemberMessageWebLocation="&nbsp;"&ChinaQJLanguageTxt19&"：<a href=""Index.Asp"" class=""agray"">"&ChinaQJLanguageTxt20&"</a> - <a href=""MemberCenter.Asp"" class=""agray"">"&ChinaQJLanguageTxt22&"</a> - "&ChinaQJLanguageTxt82&""&VbCrLf
end Function

function ChinaQJMemberMessageWebContent()
  dim idCount
  dim pages
      pages=8
  dim pagec
  dim page
      page=clng(request("Page"))
  dim pagenc
      pagenc=5
  dim pagenmax
  dim pagenmin
  dim pageprevious
  dim pagenext
  dim datafrom
      datafrom="ChinaQJ_Message "
  dim datawhere
      datawhere="where MemID="&conn.execute("select * from ChinaQJ_Members where MemName='"&session("MemName")&"'")("ID")&" "
  dim sqlid
  dim Myself,PATH_INFO,QUERY_STRING
      PATH_INFO = request.servervariables("PATH_INFO")
      QUERY_STRING = request.ServerVariables("QUERY_STRING")'
      if QUERY_STRING = "" then
        Myself = PATH_INFO & "?"
      elseif Instr(PATH_INFO & "?" & QUERY_STRING,"Page=")=0 then
        Myself= PATH_INFO & "?" & QUERY_STRING & "&"
      else
        Myself = Left(PATH_INFO & "?" & QUERY_STRING,Instr(PATH_INFO & "?" & QUERY_STRING,"Page=")-1)
      end if
  dim taxis
      taxis="order by id desc "
  dim i
  dim rs,sql
  set rs = server.createobject("adodb.recordset")
  sql="select count(ID) as idCount from ["& datafrom &"]" & datawhere
  set rs=server.createobject("adodb.recordset")
  rs.open sql,conn,0,1
  idCount=rs("idCount")
  if(idcount>0) then
    if(idcount mod pages=0)then
      pagec=int(idcount/pages)
    else
      pagec=int(idcount/pages)+1
    end if
    sql="select id from ["& datafrom &"] " & datawhere & taxis
    set rs=server.createobject("adodb.recordset")
    rs.open sql,conn,1,1
    rs.pagesize = pages
    if page < 1 then page = 1
    if page > pagec then page = pagec
    if pagec > 0 then rs.absolutepage = page
    for i=1 to rs.pagesize
      if rs.eof then exit for
      if(i=1)then
        sqlid=rs("id")
      else
        sqlid=sqlid &","&rs("id")
      end if
      rs.movenext
    next
  end if
  if(idcount>0 and sqlid<>"") then
    sql="select * from ["& datafrom &"] where id in("& sqlid &") "&taxis
    set rs=server.createobject("adodb.recordset")
    rs.open sql,conn,0,1
    while not rs.eof
    Response.Write "<table width=""100%"" border=""0"" cellspacing=""0"" cellpadding=""0"">"&VbCrLf
    Response.Write "  <tr>"&VbCrLf
    Response.Write "    <td width=""5%"" height=""25"" bgcolor=""#820000"" align=""center""><font color=""#FFFFFF""><b>"&rs("ID")&"</b></font></td>"&VbCrLf
    Response.Write "    <td width=""50%"" height=""25"" bgcolor=""#EDEEEF"" align=""left"" style=""padding-left: 8px""><font color=""#333333""><b>"&rs("Company")&"</b></font>("&rs("Linkman")&""&rs("Sex")&")</td>"&VbCrLf
    Response.Write "    <td width=""45%"" height=""25"" bgcolor=""#EDEEEF"" align=""right"" style=""padding-right: 8px""><font color=""#808080"">"&ChinaQJLanguageTxt110&"：</font>"&rs("Addtime")&"</td>"&VbCrLf
    Response.Write "  </tr>"&VbCrLf
    Response.Write "</table>"&VbCrLf
    Response.Write "<table width=""100%"" border=""0"" cellspacing=""0"" cellpadding=""1"">"&VbCrLf
    Response.Write "  <tr align=""left"">"&VbCrLf
    Response.Write "    <td width=""15%"" height=""20"" align=""right"" style=""padding-right: 8px"">"&ChinaQJLanguageTxt111&"：</td>"&VbCrLf
    Response.Write "    <td><b>"&rs("MesName")&"</b></td>"&VbCrLf
    Response.Write "  </tr>"&VbCrLf
    Response.Write "  <tr align=""left"">"&VbCrLf
    Response.Write "    <td height=""20"" align=""right"" style=""padding-right: 8px"">"&ChinaQJLanguageTxt112&"：</td>"&VbCrLf
    Response.Write "    <td style=""padding-right: 5px"">"&ChinaQJMemberMessageMessageContent(rs("MemID"),rs("SecretFlag"),HtmlStrReplace(rs("Content")))&"</td>"&VbCrLf
    Response.Write "  </tr>"&VbCrLf
    If rs("ReplyContent") <> "" Then
    Response.Write "  <tr>"&VbCrLf
    Response.Write "    <td>&nbsp;</td>"&VbCrLf
    Response.Write "    <td bgcolor=""#F7F7F7"" style=""line-height: 200%""><font color=""#333333""><b>"&ChinaQJLanguageTxt113&"：</b></font><br />"&ChinaQJMemberMessageMessageReply (rs("MemID"),rs("MesName"),rs("SecretFlag"),rs("ReplyContent"))&"</td>"&VbCrLf
    Response.Write "  </tr>"&VbCrLf
    End If
    Response.Write "  <tr>"&VbCrLf
    Response.Write "    <td colspan=""2"" height=""5""></td>"&VbCrLf
    Response.Write "  </tr>"&VbCrLf
    Response.Write "</table>"&VbCrLf
    rs.movenext
    wend
  else
    response.write "<center>"&ChinaQJLanguageTxt7&"</center>"
    exit function
  end if
  Response.Write "<table width=""98%"" border=""0"" cellspacing=""0"" cellpadding=""0"">"&VbCrLf
  Response.Write "  <tr height=""35"">"&VbCrLf
  Response.Write "    <td align=""center"">"&VbCrLf
  Response.Write ""&ChinaQJLanguageTxt44&"<strong style=""color:red"">"&idcount&"</strong>"&ChinaQJLanguageTxt45&" "&ChinaQJLanguageTxt46&"：<strong style=""color:red"">"&page&"</strong>/"&pagec&" "&ChinaQJLanguageTxt47&"：<strong style=""color:red"">"&pages&"</strong>"&ChinaQJLanguageTxt45&"" & vbCrLf
  pagenmin=page-pagenc
  pagenmax=page+pagenc
  if(pagenmin<1) then pagenmin=1
  if(page>1) then response.write ("<a href="""& myself &"Page=1"" title="""&ChinaQJLanguageTxt48&"""><font face=""webdings"" color=""#000000"">9</font></a> ")
  if page-(pagenc*2+1)<=0 then
    pageprevious=1
  else
    pageprevious=page-(pagenc*2+1)
  end if
  if(pagenmin>1) then response.write ("<a href="""& myself &"Page="& pageprevious &""" title="""&ChinaQJLanguageTxt49&""& pageprevious &""&ChinaQJLanguageTxt50&"""><font face=""webdings"" color=""#000000"">3</font></a> ")
  if(pagenmax>pagec) then pagenmax=pagec
  for i = pagenmin to pagenmax
    if(i=page) then
      response.write ("&nbsp;<strong style=""color:red"">"& i &"</strong>&nbsp;")
    else
      response.write ("[<a href="""& myself &"Page="& i &""">"& i &"</a>]")
    end if
  next
  if page+(pagenc*2+1)>=pagec then
    pagenext=pagec
  else
    pagenext=page+(pagenc*2+1)
  end if
  if(pagenmax<pagec) then response.write (" <a href="""& myself &"Page="& pagenext &""" title="""&ChinaQJLanguageTxt51&""&pagenext&""&ChinaQJLanguageTxt50&"""><font face=""webdings"" color=""#999999"">:</font></a> ")
  if(page<pagec) then response.write (" <a href="""& myself &"Page="& pagec &""" title="""&ChinaQJLanguageTxt51&""&pagec&""&ChinaQJLanguageTxt50&"""><font face=""webdings"" color=""#000000"">:</font></a>")
  Response.Write "    </td>"&VbCrLf
  Response.Write "  </tr>"&VbCrLf
  Response.Write "</table>"&VbCrLf
  rs.close
  set rs=nothing
end function

function ChinaQJMemberMessageMessageContent(MemID,SecretFlag,Content)
  if SecretFlag then
    dim rs,sql
    set rs = server.createobject("adodb.recordset")
    sql="select * from ChinaQJ_Members where ID="&MemID
    rs.open sql,conn,1,1
    if rs("MemName")=session("MemName") and session("MemLogin")="Succeed" then
      ChinaQJMemberMessageMessageContent= Content
    else
      ChinaQJMemberMessageMessageContent=ChinaQJLanguageTxt114
    end if
    rs.close
    set rs=nothing
  else
    ChinaQJMemberMessageMessageContent=Content
  end if
end function

function ChinaQJMemberMessageMessageReply(MemID,MesName,SecretFlag,ReplyContent)
  if ReplyContent<>"" then
    if SecretFlag then
      dim rs,sql
      set rs = server.createobject("adodb.recordset")
      sql="select * from ChinaQJ_Members where ID="&MemID
      rs.open sql,conn,1,1
      if rs("MemName")=session("MemName") and session("MemLogin")="Succeed" then
        ChinaQJMemberMessageMessageReply=ChinaQJMemberMessageMessageReply&HtmlStrReplace(ReplyContent)
      else
        ChinaQJMemberMessageMessageReply=ChinaQJMemberMessageMessageReply&"<font color=""#CC0000"">"&ChinaQJLanguageTxt115&"</font>"
      end if
      rs.close
      set rs=nothing
    else
        ChinaQJMemberMessageMessageReply=ChinaQJMemberMessageMessageReply&HtmlStrReplace(ReplyContent)
    end if
  end if
end Function

function ChinaQJMemberInfoWebLocation()
  ChinaQJMemberInfoWebLocation="&nbsp;"&ChinaQJLanguageTxt19&"：<a href=""Index.Asp"" class=""agray"">"&ChinaQJLanguageTxt20&"</a> - <a href=""MemberCenter.Asp"" class=""agray"">"&ChinaQJLanguageTxt22&"</a> - "&ChinaQJLanguageTxt241&""&VbCrLf
end Function

sub ChinaQJMemberInfoMemInfo()
  dim rs,sql
  set rs = server.createobject("adodb.recordset")
  sql="select * from ChinaQJ_Members where MemName='"&session("MemName")&"'"
  rs.open sql,conn,1,1
  if rs.eof then
    response.write "<center>"&ChinaQJLanguageTxt7&"</center>"
  else
    MemID=rs("ID")
    mMemName=rs("MemName")
    mGroupIdName=ChinaQJMemberInfoGroupName(rs("GroupID"))
    mRealName=rs("RealName")
    mSex=rs("Sex")
    If rs("Question") = "" Then
        mQusetion=ChinaQJLanguageTxt248
    Else
        mQusetion=rs("Question")
    End If
    mCompany=rs("Company")
    mAddress=rs("Address")
    mZipCode=rs("ZipCode")
    mTelephone=rs("Telephone")
    mFax=rs("Fax")
    mMobile=rs("Mobile")
    mEmail=rs("Email")
    mHomePage=rs("HomePage")
    mAddTime=rs("AddTime")
    mLoginTimes=rs("LoginTimes")
    mLastLoginTime=rs("LastLoginTime")
    mLastLoginIP=rs("LastLoginIP")
  end if
  rs.close
  set rs=nothing
end sub

function ChinaQJMemberInfoGroupName(GroupID)
  dim rs,sql
  set rs = server.createobject("adodb.recordset")
  sql="select * from ChinaQJ_MemGroup where GroupID='"&GroupID&"'"
  rs.open sql,conn,1,1
  ChinaQJMemberInfoGroupName=rs("GroupName"&Language)
  rs.close
  set rs=nothing
end Function

function ChinaQJMemberInfoForm()
    Response.Write "        <table width=""100%"" border=""0"" align=""center"" cellpadding=""3"" cellspacing=""5"">"&VbCrLf
    Response.Write "          <form action=""MemberSaveInfo.Asp?ID="&MemID&""" method=""post"" name=""formInfo"" id=""formInfo"">"&VbCrLf
    Response.Write "              <tr>"&VbCrLf
    Response.Write "                <td width=""200"" align=""right"">"&ChinaQJLanguageTxt87&"：</td>"&VbCrLf
    Response.Write "                <td>"& mMemName &"</td>"&VbCrLf
    Response.Write "              </tr>"&VbCrLf
    Response.Write "              <tr>"&VbCrLf
    Response.Write "                <td width=""200"" align=""right"">"&ChinaQJLanguageTxt88&"：</td>"&VbCrLf
    Response.Write "                <td>"& mGroupIdName &"</td>"&VbCrLf
    Response.Write "              </tr>"&VbCrLf
    Response.Write "              <tr>"&VbCrLf
    Response.Write "                <td align=""right"">"&ChinaQJLanguageTxt89&"：</td>"&VbCrLf
    Response.Write "                <td><input name=""RealName"" type=""text"" id=""RealName"" size=""20"" maxlength=""50"" value="""&mRealName&""" /> <font color=""red"">*</font></td>"&VbCrLf
    Response.Write "              </tr>"&VbCrLf
    Response.Write "              <tr>"&VbCrLf
    Response.Write "                <td align=""right"">"&ChinaQJLanguageTxt90&"：</td>"&VbCrLf
    Response.Write "                <td><input name=""Sex"" type=""radio"" value="""&ChinaQJLanguageTxt91&""" class=""inputnoborder"" "
    if mSex=ChinaQJLanguageTxt91 then response.write ("checked")
    response.write " />"&ChinaQJLanguageTxt91&" "
    Response.Write "<input type=""radio"" name=""Sex"" value="""&ChinaQJLanguageTxt92&""" class=""inputnoborder"" "
    if mSex=ChinaQJLanguageTxt92 then response.write ("checked")
    response.write " />"&ChinaQJLanguageTxt92&" <font color=""red"">*</font></td>"&VbCrLf
    Response.Write "              </tr>"&VbCrLf
    Response.Write "              <tr>"&VbCrLf
    Response.Write "                <td align=""right"">"&ChinaQJLanguageTxt93&"：</td>"&VbCrLf
    Response.Write "                <td><input name=""Password"" type=""password"" id=""Password"" size=""20"" maxlength=""16"" /> <font color=""red"">"&ChinaQJLanguageTxt94&"</font></td>"&VbCrLf
    Response.Write "              </tr>"&VbCrLf
    Response.Write "              <tr>"&VbCrLf
    Response.Write "                <td align=""right"">"&ChinaQJLanguageTxt95&"：</td>"&VbCrLf
    Response.Write "                <td><input name=""vPassword"" type=""password"" id=""vPassword"" size=""20"" maxlength=""16"" /></td>"&VbCrLf
    Response.Write "              </tr>"&VbCrLf
    Response.Write "              <tr>"&VbCrLf
    Response.Write "                <td align=""right"">"&ChinaQJLanguageTxt96&"：</td>"&VbCrLf
    Response.Write "                <td>"& mQusetion &"</td>"&VbCrLf
    Response.Write "              </tr>"&VbCrLf
    Response.Write "              <tr>"&VbCrLf
    Response.Write "                <td align=""right"">"&ChinaQJLanguageTxt97&"：</td>"&VbCrLf
    Response.Write "                <td>"&ChinaQJLanguageTxt98&"</td>"&VbCrLf
    Response.Write "              </tr>"&VbCrLf
    Response.Write "              <tr>"&VbCrLf
    Response.Write "                <td align=""right"">"&ChinaQJLanguageTxt99&"：</td>"&VbCrLf
    Response.Write "                <td><input name=""Company"" type=""text"" id=""Company"" value="""& mCompany &""" size=""40"" maxlength=""100"" /> <font color=""red"">*</font></td>"&VbCrLf
    Response.Write "              </tr>"&VbCrLf
    Response.Write "              <tr>"&VbCrLf
    Response.Write "                <td align=""right"">"&ChinaQJLanguageTxt100&"：</td>"&VbCrLf
    Response.Write "                <td><input name=""Address"" type=""text"" id=""Address"" value="""& mAddress &""" size=""40"" maxlength=""100"" /></td>"&VbCrLf
    Response.Write "              </tr>"&VbCrLf
    Response.Write "              <tr>"&VbCrLf
    Response.Write "                <td align=""right"">"&ChinaQJLanguageTxt34&"：</td>"&VbCrLf
    Response.Write "                <td><input name=""ZipCode"" type=""text"" id=""ZipCode"" value="""& mZipCode &""" size=""20"" maxlength=""20"" /></td>"&VbCrLf
    Response.Write "              </tr>"&VbCrLf
    Response.Write "              <tr>"&VbCrLf
    Response.Write "                <td align=""right"">"&ChinaQJLanguageTxt27&"：</td>"&VbCrLf
    Response.Write "                <td><input name=""Telephone"" type=""text"" id=""Telephone"" value="""& mTelephone &""" size=""20"" maxlength=""50"" /></td>"&VbCrLf
    Response.Write "              </tr>"&VbCrLf
    Response.Write "              <tr>"&VbCrLf
    Response.Write "                <td align=""right"">"&ChinaQJLanguageTxt35&"：</td>"&VbCrLf
    Response.Write "                <td><input name=""Fax"" type=""text"" id=""Fax"" value="""& mFax &""" size=""20"" maxlength=""50"" /></td>"&VbCrLf
    Response.Write "              </tr>"&VbCrLf
    Response.Write "              <tr>"&VbCrLf
    Response.Write "                <td align=""right"">"&ChinaQJLanguageTxt26&"：</td>"&VbCrLf
    Response.Write "                <td><input name=""Mobile"" type=""text"" id=""Mobile"" value="""& mMobile &""" size=""20"" maxlength=""50"" /></td>"&VbCrLf
    Response.Write "              </tr>"&VbCrLf
    Response.Write "              <tr>"&VbCrLf
    Response.Write "                <td align=""right"">"&ChinaQJLanguageTxt101&"：</td>"&VbCrLf
    Response.Write "                <td><input name=""Email"" type=""text"" id=""Email"" value="""& mEmail &""" size=""30"" maxlength=""50"" /> <font color=""red"">*</font></td>"&VbCrLf
    Response.Write "              </tr>"&VbCrLf
    Response.Write "              <tr>"&VbCrLf
    Response.Write "                <td align=""right"">"&ChinaQJLanguageTxt102&"：</td>"&VbCrLf
    Response.Write "                <td><input name=""HomePage"" type=""text"" id=""HomePage"" value="""& mHomePage &""" size=""30"" maxlength=""50"" /></td>"&VbCrLf
    Response.Write "              </tr>"&VbCrLf
    Response.Write "              <tr>"&VbCrLf
    Response.Write "                <td align=""right"">"&ChinaQJLanguageTxt103&"：</td>"&VbCrLf
    Response.Write "                <td>"& mAddTime &"</td>"&VbCrLf
    Response.Write "              </tr>"&VbCrLf
    Response.Write "              <tr>"&VbCrLf
    Response.Write "                <td align=""right"">"&ChinaQJLanguageTxt104&"：</td>"&VbCrLf
    Response.Write "                <td>"& mLoginTimes &"</td>"&VbCrLf
    Response.Write "              </tr>"&VbCrLf
    Response.Write "              <tr>"&VbCrLf
    Response.Write "                <td align=""right"">"&ChinaQJLanguageTxt105&"：</td>"&VbCrLf
    Response.Write "                <td>"& mLastLoginTime &"</td>"&VbCrLf
    Response.Write "              </tr>"&VbCrLf
    Response.Write "              <tr>"&VbCrLf
    Response.Write "                <td align=""right"">"&ChinaQJLanguageTxt106&"：</td>"&VbCrLf
    Response.Write "                <td>"& mLastLoginIP &"</td>"&VbCrLf
    Response.Write "              </tr>"&VbCrLf
    Response.Write "              <tr>"&VbCrLf
    Response.Write "                <td align=""right"">"&ChinaQJLanguageTxt107&"：</td>"&VbCrLf
    Response.Write "                <td><input name=""CheckCode"" type=""text"" size=""6"" maxlength=""6"" /> <a href=""javascript:refreshimg()"" title="""&ChinaQJLanguageTxt108&"""><img src=""../Include/CheckCode/CheckCode.Asp"" name=""checkcode"" align=""absmiddle"" id=""checkcode"" style=""border: 1px solid #ffffff"" /></a> <font color=""red"">*</font></td>"&VbCrLf
    Response.Write "              </tr>"&VbCrLf
    Response.Write "              <tr>"&VbCrLf
    Response.Write "                <td align=""right"">&nbsp;</td>"&VbCrLf
    Response.Write "                <td><input name=""Submit"" type=""submit"" value="""&ChinaQJLanguageTxt109&""" /></td>"&VbCrLf
    Response.Write "              </tr>"&VbCrLf
    Response.Write "              </form>"&VbCrLf
    Response.Write "            </table>"&VbCrLf
end Function

function ChinaQJMemberGetPassWebLocation()
  ChinaQJMemberGetPassWebLocation="&nbsp;"&ChinaQJLanguageTxt19&"：<a href=""Index.Asp"" class=""agray"">"&ChinaQJLanguageTxt20&"</a> - <a href=""MemberCenter.Asp"" class=""agray"">"&ChinaQJLanguageTxt22&"</a> - "&ChinaQJLanguageTxt229&""&VbCrLf
end Function

function ChinaQJMemberGetPassWebContent()
  dim rs,sql,NewPassword
  if request.QueryString("Step")="" then
    Response.Write "<table width=""100%"" border=""0"" align=""center"" cellpadding=""3"" cellspacing=""5"">"&VbCrLf
    Response.Write "<form action=""MemberGetPass.Asp?Step=EnterNameMail"" method=""post"" name=""form"" id=""form"">"&VbCrLf
    Response.Write "  <tr>"&VbCrLf
    Response.Write "    <td width=""200"" align=""right"">"&ChinaQJLanguageTxt230&"：</td>"&VbCrLf
    Response.Write "    <td><input name=""MemName"" type=""text"" id=""MemName"" size=""30"" maxlength=""16"" /> <font color=""red"">*</font></td>"&VbCrLf
    Response.Write "  </tr>"&VbCrLf
    Response.Write "  <tr>"&VbCrLf
    Response.Write "    <td align=""right"">"&ChinaQJLanguageTxt101&"：</td>"&VbCrLf
    Response.Write "    <td><input name=""Email"" type=""text"" id=""Email"" size=""30"" maxlength=""50"" /> <font color=""red"">*</font></td>"&VbCrLf
    Response.Write "  </tr>"&VbCrLf
    Response.Write "  <tr>"&VbCrLf
    Response.Write "    <td>&nbsp;</td>"&VbCrLf
    Response.Write "    <td><input name=""Next2"" type=""submit"" value="""&ChinaQJLanguageTxt231&""" /></td>"&VbCrLf
    Response.Write "  </tr>"&VbCrLf
    Response.Write "  </form>"&VbCrLf
    Response.Write "</table>"&VbCrLf
  elseif request.QueryString("Step")="EnterNameMail" then
    set rs = server.createobject("adodb.recordset")
    sql="select * from ChinaQJ_Members where MemName='"&request.form("MemName")&"' and Email='"&request.form("Email")&"'"
    rs.open sql,conn,1,1
    if rs.eof then
      WriteMsg ChinaQJLanguageTxt232
      exit function
    end if
    Response.Write "<table width=""100%"" border=""0"" align=""center"" cellpadding=""3"" cellspacing=""5"">"&VbCrLf
    Response.Write "<form action=""MemberGetPass.Asp?Step=EnterAnswer&ID="&rs("ID")&""" method=""post"" name=""form"" id=""form"">"&VbCrLf
    Response.Write "  <tr>"&VbCrLf
    Response.Write "    <td width=""200"" align=""right"">"&ChinaQJLanguageTxt230&"：</td>"&VbCrLf
    Response.Write "    <td>"&rs("MemName")&"</td>"&VbCrLf
    Response.Write "  </tr>"&VbCrLf
    Response.Write "  <tr>"&VbCrLf
    Response.Write "    <td align=""right"">"&ChinaQJLanguageTxt101&"：</td>"&VbCrLf
    Response.Write "    <td>"&rs("Email")&"</td>"&VbCrLf
    Response.Write "  </tr>"&VbCrLf
    Response.Write "  <tr>"&VbCrLf
    Response.Write "    <td align=""right"">"&ChinaQJLanguageTxt96&"：</td>"&VbCrLf
    Response.Write "    <td>"&rs("Question")&"</td>"&VbCrLf
    Response.Write "  </tr>"&VbCrLf
    Response.Write "  <tr>"&VbCrLf
    Response.Write "    <td align=""right"">"&ChinaQJLanguageTxt97&"：</td>"&VbCrLf
    Response.Write "    <td><input name=""Answer"" type=""text"" size=""30"" maxlength=""100"" /></td>"&VbCrLf
    Response.Write "  </tr>"&VbCrLf
    Response.Write "  <tr>"&VbCrLf
    Response.Write "    <td>&nbsp;</td>"&VbCrLf
    Response.Write "    <td><input name=""Next"" type=""submit"" value="""&ChinaQJLanguageTxt231&""" /></td>"&VbCrLf
    Response.Write "  </tr>"&VbCrLf
    Response.Write "  </form>"&VbCrLf
    Response.Write "</table>"&VbCrLf
  elseif request.QueryString("Step")="EnterAnswer" Then
    If trim(request("Answer"))="" Then
    WriteMsg ChinaQJLanguageTxt233
    exit function
    End If
    set rs = server.createobject("adodb.recordset")
    sql="select * from ChinaQJ_Members where ID="&request.QueryString("ID")
    rs.open sql,conn,1,3
    if rs.eof then
      WriteMsg ChinaQJLanguageTxt16
      exit function
    end if
    if rs("Answer")<>MD5(trim(request("Answer"))) then
      WriteMsg ChinaQJLanguageTxt234
      exit function
    end if
    randomize timer
    NewPassword=Int(899999*Rnd() +100000)
    rs("Password")=MD5(NewPassword)
    rs.update
    rs.close
    set rs=nothing
    Response.Write "<script language=javascript>alert('"&ChinaQJLanguageTxt235&""&NewPassword&""&ChinaQJLanguageTxt236&"');window.location.href='Index.Asp';</script>"
    exit function
  end if
end Function

function ChinaQJMemberCenterWebLocation()
  ChinaQJMemberCenterWebLocation="&nbsp;"&ChinaQJLanguageTxt19&"：<a href=""Index.Asp"" class=""agray"">"&ChinaQJLanguageTxt20&"</a> - <a href=""MemberCenter.Asp"" class=""agray"">"&ChinaQJLanguageTxt22&"</a> "&VbCrLf
end function

function ChinaQJMemberCenterMemGroup(GroupID)
  dim rs,sql
  set rs = server.createobject("adodb.recordset")
  sql="select * from ChinaQJ_MemGroup where GroupID='"&GroupID&"'"
  rs.open sql,conn,1,1
  ChinaQJMemberCenterMemGroup=rs("GroupName"&Language)
  rs.close
  set rs=nothing
end Function

function ChinaQJMemberCenterForm()
    Response.Write "      <table width=""100%"" border=""0"" align=""center"" cellpadding=""0"" cellspacing=""0"" style=""margin-top:19px;"">"&VbCrLf
    if session("MemName")="" or session("GroupID")="" or session("MemLogin")<>"Succeed" then
    Response.Write "        <tr>"&VbCrLf
    Response.Write "          <td><table width=""80%"" border=""0"" align=""center"" cellpadding=""0"" cellspacing=""0"">"&VbCrLf
    Response.Write "              <tr style=""line-height:25px; font-size:12px"" align=""center"">"&VbCrLf
    Response.Write "                <td><img src="""&StylePath&"Page_error.jpg"" align=""absmiddle"" /></td>"&VbCrLf
    Response.Write "                <td>"&ChinaQJLanguageTxt74&"：<font color=""red"">"&ChinaQJLanguageTxt75&"</font><br />"&VbCrLf
    Response.Write "                  <a href=""MemberRegister.Asp""><font color=""red"">"&ChinaQJLanguageTxt76&"</font></a>"&ChinaQJLanguageTxt77&"</td>"&VbCrLf
    Response.Write "              </tr>"&VbCrLf
    Response.Write "            </table></td>"&VbCrLf
    Response.Write "        </tr>"&VbCrLf
    else
    Response.Write "        <tr>"&VbCrLf
    Response.Write "          <td><table width=""80%"" border=""0"" align=""center"" cellpadding=""0"" cellspacing=""0"">"&VbCrLf
    Response.Write "              <tr style=""line-height:25px; font-size:12px"" align=""center"">"&VbCrLf
    Response.Write "                <td><img src="""&StylePath&"Page_ok.jpg"" align=""absmiddle"" /></td>"&VbCrLf
    Response.Write "                <td>"&ChinaQJLanguageTxt78&"<font color=""red"">"&ChinaQJMemberCenterMemGroup(session("GroupID"))&"</font><br />"&VbCrLf
    Response.Write "                  "&ChinaQJLanguageTxt79&"</td>"&VbCrLf
    Response.Write "              </tr>"&VbCrLf
    Response.Write "            </table></td>"&VbCrLf
    Response.Write "        </tr>"&VbCrLf
    end if
    Response.Write "        <tr>"&VbCrLf
    Response.Write "          <td height=""20"">&nbsp;</td>"&VbCrLf
    Response.Write "        </tr>"&VbCrLf
    Response.Write "      </table>"&VbCrLf
end Function

function ChinaQJJobsViewWebLocation()
  ChinaQJJobsViewWebLocation="&nbsp;"&ChinaQJLanguageTxt19&"：<a href=""Index.Asp"" class=""agray"">"&ChinaQJLanguageTxt20&"</a> - <a href=""JobsList.Asp"" class=""agray"">"&ChinaQJLanguageTxt65&"</a>"&VbCrLf
end Function

function ChinaQJJobsViewWebContent(DataFrom,ID)
  if ID="" or not IsNumeric(ID) then
    response.write "<div class=""Bodyer_right_page_content"">"&ChinaQJLanguageTxt16&"</div>"
  elseif conn.execute("select * from "&DataFrom&" Where "&ViewFlag&" and ID="&ID).eof then
    response.write "<div class=""Bodyer_right_page_content"">"&ChinaQJLanguageTxt16&"</div>"
  else
    dim rs,sql
    set rs = server.createobject("adodb.recordset")
    sql="select * from "&DataFrom&" where "&ViewFlag&" and ID="&ID
    rs.open sql,conn,1,3
    Response.Write "<table width=""100%"" border=""1"" align=""center"" cellpadding=""7"" cellspacing=""0"" bordercolor=""#D5D3D4"" style=""border-collapse:collapse"">"&VbCrLf
    Response.Write "  <tr>"&VbCrLf
    Response.Write "    <td height=""25"" colspan=""4"" background="""&StylePath&"bg.jpg"" style=""color: #FFFFFF"" style=""padding-left: 8px;""><span style=""font-weight: bold; font-size: 12px"">"&rs("JobName"&Language)&"</span> "&ChinaQJLanguageTxt221&"</td>"&VbCrLf
    Response.Write "  </tr>"&VbCrLf
    Response.Write "  <tr>"&VbCrLf
    Response.Write "    <td width=""15%"" align=""right"">"&ChinaQJLanguageTxt69&"：</td>"&VbCrLf
    Response.Write "    <td width=""35%"" align=""left"">"&rs("JobAddress"&Language)&"</td>"&VbCrLf
    Response.Write "    <td width=""15%"" align=""right"">"&ChinaQJLanguageTxt70&"：</td>"&VbCrLf
    Response.Write "    <td width=""35%"">"&rs("JobNumber")&"</td>"&VbCrLf
    Response.Write "  </tr>"&VbCrLf
    Response.Write "  <tr bgcolor=""#F7F7F7"">"&VbCrLf
    Response.Write "    <td width=""15%"" align=""right"">"&ChinaQJLanguageTxt222&"：</td>"&VbCrLf
    Response.Write "    <td width=""35%"" align=""left"">"&rs("Emolument"&Language)&"</td>"&VbCrLf
    Response.Write "    <td width=""15%"" align=""right"">"&ChinaQJLanguageTxt223&"：</td>"&VbCrLf
    Response.Write "    <td width=""35%"">"&FormatDate(rs("StartDate"),13)&" - "&FormatDate(rs("EndDate"),13)&"</td>"&VbCrLf
    Response.Write "  </tr>"&VbCrLf
    Response.Write "  <tr>"&VbCrLf
    Response.Write "    <td width=""15%"" align=""right"">"&ChinaQJLanguageTxt68&"：</td>"&VbCrLf
    Response.Write "    <td width=""35%"" align=""left"">"&rs("eEmployer"&Language)&"</td>"&VbCrLf
    Response.Write "    <td width=""15%"" align=""right"">"&ChinaQJLanguageTxt183&"：</td>"&VbCrLf
    Response.Write "    <td width=""35%"">"&rs("eContact"&Language)&"</td>"&VbCrLf
    Response.Write "  </tr>"&VbCrLf
    Response.Write "  <tr bgcolor=""#F7F7F7"">"&VbCrLf
    Response.Write "    <td width=""15%"" align=""right"">"&ChinaQJLanguageTxt27&"：</td>"&VbCrLf
    Response.Write "    <td width=""35%"" align=""left"">"&rs("eTel")&"</td>"&VbCrLf
    Response.Write "    <td width=""15%"" align=""right"">"&ChinaQJLanguageTxt100&"：</td>"&VbCrLf
    Response.Write "    <td width=""35%"">"&rs("eAddress"&Language)&"</td>"&VbCrLf
    Response.Write "  </tr>"&VbCrLf
    Response.Write "  <tr>"&VbCrLf
    Response.Write "    <td width=""15%"" align=""right"">"&ChinaQJLanguageTxt34&"：</td>"&VbCrLf
    Response.Write "    <td width=""35%"" align=""left"">"&rs("ePostCode")&"</td>"&VbCrLf
    Response.Write "    <td width=""15%"" align=""right"">"&ChinaQJLanguageTxt101&"：</td>"&VbCrLf
    Response.Write "    <td width=""35%"">"&rs("eEmail")&"</td>"&VbCrLf
    Response.Write "  </tr>"&VbCrLf
    Response.Write "  <tr bgcolor=""#F7F7F7"">"&VbCrLf
    Response.Write "    <td width=""15%"" align=""right"">"&ChinaQJLanguageTxt17&"：</td>"&VbCrLf
    Response.Write "    <td width=""35%"" align=""left"">"&FormatDate(rs("UpdateTime"),13)&"</td>"&VbCrLf
    Response.Write "    <td width=""15%"" align=""right"">"&ChinaQJLanguageTxt18&"：</td>"&VbCrLf
    Response.Write "    <td width=""35%""><script language=""javascript"" src=""HitCount.Asp?id="&rs("ID")&"&LX=ChinaQJ_Jobs""></script><script language=""javascript"" src=""HitCount.Asp?action=count&LX=ChinaQJ_Jobs&id="&rs("ID")&"""></script></td>"&VbCrLf
    Response.Write "  </tr>"&VbCrLf
    Response.Write "  <tr>"&VbCrLf
    Response.Write "    <td align=""right"">"&ChinaQJLanguageTxt224&"：</td>"&VbCrLf
    Response.Write "    <td colspan=""3"" align=""left"">"&HtmlStrReplace(rs("Responsibility"&Language))&"</td>"&VbCrLf
    Response.Write "  </tr>"&VbCrLf
    Response.Write "  <tr bgcolor=""#F7F7F7"">"&VbCrLf
    Response.Write "    <td align=""right"" valign=""top"">"&ChinaQJLanguageTxt225&"：</td>"&VbCrLf
    Response.Write "    <td colspan=""3"" align=""left"">"&HtmlStrReplace(rs("Requirement"&Language))&"</td>"&VbCrLf
    Response.Write "  </tr>"&VbCrLf
    Response.Write "  <tr>"&VbCrLf
    Response.Write "    <td colspan=""4"" align=""center""><a href=""TalentWrite.Asp?JobID="&ID&"&JobName="&server.urlencode(rs("JobName"&Language))&""" title="""&ChinaQJLanguageTxt218&""" ><img src="""&StylePath&"Page_resume_"&Language&".gif"" border=""0"" /></a></td>"&VbCrLf
    Response.Write "  </tr>"&VbCrLf
    Response.Write "</table>"&VbCrLf
    rs.update
    rs.close
    set rs=nothing
  end if
end Function

function ChinaQJJobsListWebContent()
  dim rs,sql
  dim idCount
  dim pages
      pages=JobInfo
  dim pagec
  dim page
      page=clng(request("Page"))
  dim pagenc
      pagenc=5
  dim pagenmax
  dim pagenmin
  dim pageprevious
  dim pagenext
  dim datafrom
  datafrom="ChinaQJ_Jobs"
  dim datawhere
      datawhere="where "&ViewFlag&" "
  dim sqlid
  dim Myself,PATH_INFO,QUERY_STRING
      PATH_INFO = request.servervariables("PATH_INFO")
      QUERY_STRING = request.ServerVariables("QUERY_STRING")'
      if QUERY_STRING = "" then
        Myself = PATH_INFO & "?"
      elseif Instr(PATH_INFO & "?" & QUERY_STRING,"Page=")=0 then
        Myself= PATH_INFO & "?" & QUERY_STRING & "&"
      else
        Myself = Left(PATH_INFO & "?" & QUERY_STRING,Instr(PATH_INFO & "?" & QUERY_STRING,"Page=")-1)
      end if
  dim taxis
      taxis="order by id desc "
  dim i
  sql="select count(ID) as idCount from ["& datafrom &"]" & datawhere
  set rs=server.createobject("adodb.recordset")
  rs.open sql,conn,0,1
  idCount=rs("idCount")
  if(idcount>0) then
    if(idcount mod pages=0)then
      pagec=int(idcount/pages)
    else
      pagec=int(idcount/pages)+1
    end if
    sql="select id from ["& datafrom &"] " & datawhere & taxis
    set rs=server.createobject("adodb.recordset")
    rs.open sql,conn,1,1
    rs.pagesize = pages
    if page < 1 then page = 1
    if page > pagec then page = pagec
    if pagec > 0 then rs.absolutepage = page
    for i=1 to rs.pagesize
      if rs.eof then exit for
      if(i=1)then
        sqlid=rs("id")
      else
        sqlid=sqlid &","&rs("id")
      end if
      rs.movenext
    next
  end if
  if(idcount>0 and sqlid<>"") then
    sql="select * from ["& datafrom &"] where id in("& sqlid &") "&taxis
    set rs=server.createobject("adodb.recordset")
    rs.open sql,conn,0,1
        Response.Write "<table width=""98%"" border=""0"" cellspacing=""0"" cellpadding=""0"">"&VbCrLf
        Response.Write "  <tr height=""32"">"&VbCrLf
        Response.Write "    <td style=""color:#FFFFFF; font-weight:bold; background:url("&StylePath&"split.gif) no-repeat right center; background-color:#abacaf"">&nbsp;&nbsp;&nbsp;&nbsp;"&ChinaQJLanguageTxt67&"</td>"&VbCrLf
        Response.Write "    <td style=""color:#FFFFFF; font-weight:bold; background:url("&StylePath&"split.gif) no-repeat right center; background-color:#abacaf"">&nbsp;&nbsp;"&ChinaQJLanguageTxt68&"</td>"&VbCrLf
        Response.Write "    <td style=""color:#FFFFFF; font-weight:bold; background:url("&StylePath&"split.gif) no-repeat right center; background-color:#abacaf"">&nbsp;&nbsp;"&ChinaQJLanguageTxt69&"</td>"&VbCrLf
        Response.Write "    <td style=""color:#FFFFFF; font-weight:bold; background:url("&StylePath&"split.gif) no-repeat right center; background-color:#abacaf"">&nbsp;&nbsp;"&ChinaQJLanguageTxt70&"</td>"&VbCrLf
        Response.Write "    <td style=""color:#FFFFFF; font-weight:bold; background:url("&StylePath&"split.gif) no-repeat right center; background-color:#abacaf"">&nbsp;&nbsp;"&ChinaQJLanguageTxt71&"</td>"&VbCrLf
        Response.Write "    <td bgcolor=""#ABACAF"" style=""color:#FFFFFF; font-weight:bold"">&nbsp;&nbsp;"&ChinaQJLanguageTxt17&"</td>"&VbCrLf
        Response.Write "  </tr>"&VbCrLf
    while not rs.eof
        If ISHTML = 1 Then
            AutoLink = ""&rs("ClassSeo")&""&Separated&""&rs("ID")&"."&HTMLName&""
        Else
            AutoLink = "JobsView.Asp?ID="&rs("ID")&""
        End If
        Response.Write "  <tr height=""28"">"&VbCrLf
        Response.Write "    <td style=""background:url("&StylePath&"bg2.gif) repeat-x left bottom;"">&nbsp;<img src="""&StylePath&"arr.gif"" width=""11"" height=""14"" align=""absmiddle"" />&nbsp;&nbsp;<a href="""&AutoLink&""">"&rs("JobName"&Language)&"</a></td>"&VbCrLf
        Response.Write "    <td style=""background:url("&StylePath&"bg2.gif) repeat-x left bottom; color:#999999"">&nbsp;&nbsp;&nbsp;"&rs("eEmployer"&Language)&"</td>"&VbCrLf
        Response.Write "    <td style=""background:url("&StylePath&"bg2.gif) repeat-x left bottom; color:#999999"">&nbsp;&nbsp;&nbsp;"&rs("JobAddress"&Language)&"</td>"&VbCrLf
        Response.Write "    <td style=""background:url("&StylePath&"bg2.gif) repeat-x left bottom; color:#999999"">&nbsp;&nbsp;&nbsp;"&rs("JobNumber")&"</td>"&VbCrLf
    If rs("EndDate")>now() Then
        Response.Write "    <td style=""background:url("&StylePath&"bg2.gif) repeat-x left bottom; color:#999999"">&nbsp;&nbsp;&nbsp;"&ChinaQJLanguageTxt72&"</td>"&VbCrLf
    Else
        Response.Write "    <td style=""background:url("&StylePath&"bg2.gif) repeat-x left bottom; color:#999999"">&nbsp;&nbsp;&nbsp;"&ChinaQJLanguageTxt73&"</td>"&VbCrLf
    End If
        Response.Write "    <td style=""background:url("&StylePath&"bg2.gif) repeat-x left bottom; color:#999999"">&nbsp;&nbsp;&nbsp;"&FormatDate(rs("Addtime"),13)&"</td>"&VbCrLf
        Response.Write "  </tr>"&VbCrLf
    rs.movenext
    Wend
        Response.Write "</table>"&VbCrLf
  else
    response.write "<center>"&ChinaQJLanguageTxt7&"</center>"
    exit function
  end if
  Response.Write "<div class=""page"">"&VbCrLf
  Response.Write ""&ChinaQJLanguageTxt44&"<strong style=""color:red"">"&idcount&"</strong>"&ChinaQJLanguageTxt45&"&nbsp;&nbsp;&nbsp;" & vbCrLf
  pagenmin=page-pagenc
  pagenmax=page+pagenc
  if(pagenmin<1) then pagenmin=1
%>
    <span id="page">
<%
Sortid=Request("Sortid")
If ISHTML = 1 Then
If Sortid="" then
%>
        <a href="<%= ClassSeo %><%= Separated %>1.<%= HTMLName %>"><%= ChinaQJLanguageTxt313 %></a>
<% If page>1 Then %>
        <a href="<%= ClassSeo %><%= Separated %><%= page-1 %>.<%= HTMLName %>"><%= ChinaQJLanguageTxt314 %></a>
<% Else %>
        <a href="<%= ClassSeo %><%= Separated %>1.<%= HTMLName %>"><%= ChinaQJLanguageTxt313 %></a>
<% End If %>
<%
  if(pagenmax>pagec) then pagenmax=pagec
  for i = pagenmin to pagenmax
    if(i=page) then
%>
        <a href="<%= ClassSeo %><%= Separated %><%= i %>.<%= HTMLName %>" class='page_click' ><%= i %></a>
<% Else %>
        <a href="<%= ClassSeo %><%= Separated %><%= i %>.<%= HTMLName %>" class='' ><%= i %></a>
<%
End If
Next
%>
<% If page<pagenmax Then %>
        <a href="<%= ClassSeo %><%= Separated %><%= page+1 %>.<%= HTMLName %>"><%= ChinaQJLanguageTxt315 %></a>
<% Else %>
        <a href="<%= ClassSeo %><%= Separated %><%= pagenmax %>.<%= HTMLName %>"><%= ChinaQJLanguageTxt315 %></a>
<% End If %>
        <a href="<%= ClassSeo %><%= Separated %><%= pagenmax %>.<%= HTMLName %>"><%= ChinaQJLanguageTxt316 %></a>
<% Else %>
        <a href="<%= ClassSeo %><%= Separated %><%= Sortid %><%= Separated %>1.<%= HTMLName %>"><%= ChinaQJLanguageTxt313 %></a>
<% If page>1 Then %>
        <a href="<%= ClassSeo %><%= Separated %><%= Sortid %><%= Separated %><%= page-1 %>.<%= HTMLName %>"><%= ChinaQJLanguageTxt314 %></a>
<% Else %>
        <a href="<%= ClassSeo %><%= Separated %><%= Sortid %><%= Separated %>1.<%= HTMLName %>"><%= ChinaQJLanguageTxt314 %></a>
<% End If %>
<%
  if(pagenmax>pagec) then pagenmax=pagec
  for i = pagenmin to pagenmax
    if(i=page) then
%>
        <a href="<%= ClassSeo %><%= Separated %><%= Sortid %><%= Separated %><%= i %>.<%= HTMLName %>" class='page_click' ><%= i %></a>
<% Else %>
        <a href="<%= ClassSeo %><%= Separated %><%= Sortid %><%= Separated %><%= i %>.<%= HTMLName %>" class='' ><%= i %></a>
<%
End If
Next
%>
<% If page<pagenmax Then %>
        <a href="<%= ClassSeo %><%= Separated %><%= Sortid %><%= Separated %><%= page+1 %>.<%= HTMLName %>"><%= ChinaQJLanguageTxt315 %></a>
<% Else %>
        <a href="<%= ClassSeo %><%= Separated %><%= Sortid %><%= Separated %><%= pagenmax %>.<%= HTMLName %>"><%= ChinaQJLanguageTxt315 %></a>
<% End If %>
        <a href="<%= ClassSeo %><%= Separated %><%= Sortid %><%= Separated %><%= pagenmax %>.<%= HTMLName %>"><%= ChinaQJLanguageTxt316 %></a>
<% End If %>
<% Else %>
        <a href="<%= myself %>Page=1"><%= ChinaQJLanguageTxt313 %></a>
<% If page>1 Then %>
        <a href="<%= myself %>Page=<%= page-1 %>"><%= ChinaQJLanguageTxt314 %></a>
<% Else %>
        <a href="<%= myself %>Page=1"><%= ChinaQJLanguageTxt314 %></a>
<% End If %>
<%
  if(pagenmax>pagec) then pagenmax=pagec
  for i = pagenmin to pagenmax
    if(i=page) then
%>
        <a href="<%= myself %>Page=<%= i %>" class='page_click' ><%= i %></a>
<% Else %>
        <a href="<%= myself %>Page=<%= i %>" class='' ><%= i %></a>
<%
End If
Next
%>
<% If page<pagenmax Then %>
        <a href="<%= myself %>Page=<%= page+1 %>"><%= ChinaQJLanguageTxt315 %></a>
<% Else %>
        <a href="<%= myself %>Page=<%= pagenmax %>"><%= ChinaQJLanguageTxt315 %></a>
<% End If %>
        <a href="<%= myself %>Page=<%= pagenmax %>"><%= ChinaQJLanguageTxt316 %></a>
<% End If %>
    </span>
<%
  Response.Write "</div>"&VbCrLf
  rs.close
  set rs=nothing
end Function

Function ChinaQJDownFolder(id)
  Dim rs,sql,i,ChildCount,FolderType,FolderName,onMouseUp,ListType
  Set rs=server.CreateObject("adodb.recordset")
  sql="Select * From ChinaQJ_DownSort where "&ViewFlag&" And ParentID="&id&" order by Sequence desc,ID desc"
  rs.open sql,conn,1,1
    if id=0 and rs.recordcount=0 then
        response.write "<center>"&ChinaQJLanguageTxt7&"</center>"
        exit function
    end if
  i=1
  response.write("<table border=""0"" cellspacing=""1"" cellpadding=""2"">")
  while not rs.eof
    ChildCount=conn.execute("select count(*) from ChinaQJ_DownSort where ParentID="&rs("id"))(0)
    if ChildCount=0 then
      if i=rs.recordcount then
        FolderType="SortFileEnd"
      else
        FolderType="SortFile"
      end if
      FolderName=rs("SortName"&Language)
      onMouseUp=""
    else
      if i=rs.recordcount then
        FolderType="SortEndFolderClose"
        ListType="SortEndListline"
        onMouseUp="EndSortChange('a"&rs("id")&"','b"&rs("id")&"');"
      else
      If SortStart = 0 Then
        FolderType="SortFolderOpen"
      Else
        FolderType="SortFolderClose"
      End If
        ListType="SortListline"
        onMouseUp="SortChange('a"&rs("id")&"','b"&rs("id")&"');"
      end if
      FolderName=rs("SortName"&Language)
    end If
    datafrom="ChinaQJ_DownSort"
    If ISHTML = 1 Then
        AutoLink = ""&rs("ClassSeo")&""&Separated&""&rs("ID")&""&Separated&"1."&HTMLName&""
    Else
        AutoLink = "DownList.Asp?SortID="&rs("ID")&""
    End If
    response.write("<tr>")
    response.write("<td nowrap id=""b"&rs("id")&""" onMouseUp="""&onMouseUp&""" class="""&FolderType&"""></td><td nowrap style=""padding-top: 3px""><a href="""&AutoLink&""">"&FolderName&"</a></td></tr>")
    if ChildCount>0 then
%>
<%If SortStart = 0 Then%>
<tr id="a<%=rs("id")%>" style="display: none">
<%Else%>
<tr id="a<%=rs("id")%>" style="display: yes">
<%End If%>
  <td class="<%=ListType%>" nowrap></td>
  <td><% ChinaQJDownFolder(rs("id")) %></td>
</tr>
<%
    end if
    rs.movenext
    i=i+1
    wend
    response.write("</table>")
    rs.close
    set rs=nothing
end Function

function ChinaQJDownWebLocation()
  ChinaQJDownWebLocation="&nbsp;"&ChinaQJLanguageTxt19&"：<a href=""Index.Asp"" class=""agray"">"&ChinaQJLanguageTxt20&"</a> - <a href=""DownList.Asp"" class=""agray"">"&ChinaQJLanguageTxt52&"</a>"&VbCrLf
  if request.QueryString("ID")="" then
    ChinaQJDownWebLocation=ChinaQJDownWebLocation
  elseif not IsNumeric(request.QueryString("ID")) then
    ChinaQJDownWebLocation=ChinaQJDownWebLocation&ChinaQJLanguageTxt16
  elseif conn.execute("select * from ChinaQJ_Download Where "&ViewFlag&" and ID="&request.QueryString("ID")).eof then
    ChinaQJDownWebLocation=ChinaQJDownWebLocation&ChinaQJLanguageTxt16
  else
    dim rs,sql
    set rs = server.createobject("adodb.recordset")
    sql="select * from ChinaQJ_Download where "&ViewFlag&" and ID="&request.QueryString("ID")
    rs.open sql,conn,1,1
    ChinaQJDownWebLocation=ChinaQJDownWebLocation&ChinaQJDownSortPathTXT("ChinaQJ_DownSort",rs("SortID"))
    rs.close
    set rs=nothing
  end if
end Function

function ChinaQJDownSortPathTXT(DataFrom,ID)
  dim rs,sql
  Set rs=server.CreateObject("adodb.recordset")
  sql="Select * From "&DataFrom&" where "&ViewFlag&" and ID="&ID
  rs.open sql,conn,1,1
  if not rs.eof Then
    If ISHTML = 1 Then
        AutoLink = ""&rs("ClassSeo")&""&Separated&""&rs("ID")&""&Separated&"1."&HTMLName&""
    Else
        AutoLink = "DownList.Asp?SortID="&rs("ID")&""
    End If
    ChinaQJDownSortPathTXT=ChinaQJDownSortPathTXT(DataFrom,rs("ParentID"))&" - <a href="""&AutoLink&"""><span style=""color:#EC0000"">"&rs("SortName"&Language)&"</span></a>"
  end if
  rs.close
  set rs=nothing
end Function

function ChinaQJDownDetail()
    Response.Write "    <table width=""100%"" border=""0"" align=""center"" cellpadding=""0"" cellspacing=""0"" style=""margin-top:19px;"">"&VbCrLf
    Response.Write "        <tr>"&VbCrLf
    Response.Write "          <td><table width=""100%"" border=""0"" cellspacing=""0"" cellpadding=""0"">"&VbCrLf
    Response.Write "              <tr>"&VbCrLf
    Response.Write "                <td width=""30"" height=""36""><img src="""&StylePath&"title_bg1.gif"" width=""30"" height=""36"" /></td>"&VbCrLf
    Response.Write "                <td width=""100%"" align=""center"" background="""&StylePath&"title_bg_center.jpg"" style=""color:#fff; font-size:12px; font-weight:bold"">"&VbCrLf
      ID=request.QueryString("ID")
      if ID="" or not IsNumeric(ID) then
        response.write "<center>"&ChinaQJLanguageTxt7&"</center>"
      elseif conn.execute("select * from ChinaQJ_Download Where "&ViewFlag&" and ID="&ID).eof then
        response.write "<center>"&ChinaQJLanguageTxt7&"</center>"
      else
        dim rs,sql
        set rs = server.createobject("adodb.recordset")
        sql="select * from ChinaQJ_Download where "&ViewFlag&" and ID="&ID
        rs.open sql,conn,1,3
        Response.Write ""&rs("DownName"&Language)&""&VbCrLf
      End If
    Response.Write "                </td>"&VbCrLf
    Response.Write "                <td width=""30""><img src="""&StylePath&"title_bg2.gif"" width=""30"" height=""36"" /></td>"&VbCrLf
    Response.Write "              </tr>"&VbCrLf
    Response.Write "              <tr>" & vbCrLf
    Response.Write "                <td><img src=""" & StylePath & "title_bg3.gif"" width=""30"" height=""14"" /></td>" & vbCrLf
    Response.Write "                <td background=""" & StylePath & "title_bg_center2.jpg"">&nbsp;</td>" & vbCrLf
    Response.Write "                <td><img src=""" & StylePath & "title_bg4.gif"" width=""30"" height=""14"" /></td>" & vbCrLf
    Response.Write "              </tr>" & vbCrLf
    Response.Write "            </table></td>"&VbCrLf
    Response.Write "        </tr>"&VbCrLf
    Response.Write "        <tr>"&VbCrLf
    Response.Write "          <td height=""20"">&nbsp;</td>"&VbCrLf
    Response.Write "        </tr>"&VbCrLf
    if ViewNoRight(rs("GroupID"),rs("Exclusive")) Then
    Response.Write "        <tr>"&VbCrLf
    Response.Write "          <td><table width=""100%"" border=""0"" align=""center"" cellpadding=""1"" cellspacing=""1"" bgcolor=""#E6E6E6"">"&VbCrLf
    Response.Write "              <tr height=""25"" bgcolor=""#FFFFFF"">"&VbCrLf
    Response.Write "                <td width=""80"" align=""right"">"&ChinaQJLanguageTxt219&"：</td>"&VbCrLf
    Response.Write "                <td style=""padding-left: 8px"">"&rs("DownName"&Language)&"</td>"&VbCrLf
    Response.Write "              </tr>"&VbCrLf
    Response.Write "              <tr height=""25"" bgcolor=""#FFFFFF"">"&VbCrLf
    Response.Write "                <td width=""80"" align=""right"">"&ChinaQJLanguageTxt17&"：</td>"&VbCrLf
    Response.Write "                <td style=""padding-left: 8px"">"&FormatDate(rs("UpdateTime"),13)&"</td>"&VbCrLf
    Response.Write "              </tr>"&VbCrLf
    Response.Write "              <tr height=""25"" bgcolor=""#FFFFFF"">"&VbCrLf
    Response.Write "                <td width=""80"" align=""right"">"&ChinaQJLanguageTxt53&"：</td>"&VbCrLf
    Response.Write "                <td style=""padding-left: 8px"">"&rs("FileSize")&"</td>"&VbCrLf
    Response.Write "              </tr>"&VbCrLf
    Response.Write "              <tr height=""25"" bgcolor=""#FFFFFF"">"&VbCrLf
    Response.Write "                <td width=""80"" align=""right"">"&ChinaQJLanguageTxt18&"：</td>"&VbCrLf
    Response.Write "                <td style=""padding-left: 8px""><script language=""javascript"" src=""HitCount.Asp?id="&rs("ID")&"&LX=ChinaQJ_Download""></script>"&VbCrLf
    Response.Write "                  <script language=""javascript"" src=""HitCount.Asp?action=count&LX=ChinaQJ_Download&id="&rs("ID")&"""></script></td>"&VbCrLf
    Response.Write "              </tr>"&VbCrLf
    Response.Write "              <tr height=""25"" bgcolor=""#FFFFFF"">"&VbCrLf
    Response.Write "                <td width=""80"" align=""right"">"&ChinaQJLanguageTxt220&"：</td>"&VbCrLf
    Response.Write "                <td style=""padding-left: 8px""><a href="""&rs("FileUrl")&"""><img src="""&StylePath&"Download_"&Language&".gif"" border=""0"" /></a></td>"&VbCrLf
    Response.Write "              </tr>"&VbCrLf
    Response.Write "              <tr height=""25"" bgcolor=""#FFFFFF"">"&VbCrLf
    Response.Write "                <td width=""80"" align=""right"">"&ChinaQJLanguageTxt182&"：</td>"&VbCrLf
    Response.Write "                <td style=""padding-left: 8px"" class=""SiteLink"">"&ProcessSitelink(rs("Content"&Language))&"</td>"&VbCrLf
    Response.Write "              </tr>"&VbCrLf
    Response.Write "            </table></td>"&VbCrLf
    Response.Write "        </tr>"&VbCrLf
    Else
    Response.Write "        <tr>"&VbCrLf
    Response.Write "          <td align=""center""><img src="""&StylePath&"NoRight_"&Language&".jpg""></td>"&VbCrLf
    Response.Write "        </tr>"&VbCrLf
    End If
    rs.update
    rs.close
    Set rs=Nothing
    Set rs = Server.CreateObject("Adodb.Recordset")
    If Request.QueryString("ID") = "" Or Not IsNumeric(Request.QueryString("ID")) Then
        sql = "Select Top 1 TheTags" & Language & " From ChinaQJ_Download Where " & ViewFlag & " Order By Sequence Desc,ID Desc"
    Else
        sql = "Select TheTags" & Language & " From ChinaQJ_Download Where " & ViewFlag & " And ID = " & Request.QueryString("ID")
    End If
    rs.Open sql, conn, 1, 1
    If Not rs.EOF Then
        If rs("TheTags" & Language) <> "" Then
            Response.Write "        <tr>" & vbCrLf
            Response.Write "          <td height=""25"" align=""right"" style=""padding-left: 8px; padding-right: 8px;"">" & vbCrLf
            Response.Write "          <font color=""#005AA0"">Tags：</font>" & vbCrLf
            TheTags = Split(rs("TheTags" & Language), ",")
            For i = 0 To UBound(TheTags)
                Response.Write "<a href=""Search.Asp?Range=Down&Keyword=" & TheTags(i) & """>"
                Response.Write "<font color=""#CC3C3C""><u>"
                Response.Write TheTags(i) & ""
                Response.Write "</u></font>"
                Response.Write "</a> "
            Next
            Response.Write "          </td>" & vbCrLf
            Response.Write "        </tr>" & vbCrLf
        End If
    End If
    rs.Close
    Set rs = Nothing
    Response.Write "        <tr>"&VbCrLf
    Response.Write "          <td height=""20"">&nbsp;</td>"&VbCrLf
    Response.Write "        </tr>"&VbCrLf
    Response.Write "      </table>"&VbCrLf
end Function

function ChinaQJDownListWebLocation()
  ChinaQJDownListWebLocation="&nbsp;"&ChinaQJLanguageTxt19&"：<a href=""Index.Asp"" class=""agray"">"&ChinaQJLanguageTxt20&"</a> - <a href=""DownList.Asp"" class=""agray"">"&ChinaQJLanguageTxt52&"</a>"&VbCrLf
  if request.QueryString("SortID")="" then
    ChinaQJDownListWebLocation=ChinaQJDownListWebLocation
  elseif not IsNumeric(request.QueryString("SortID")) then
    ChinaQJDownListWebLocation=ChinaQJDownListWebLocation&ChinaQJLanguageTxt16
  elseif conn.execute("select * from ChinaQJ_DownSort Where "&ViewFlag&" and ID="&request.QueryString("SortID")).eof then
    ChinaQJDownListWebLocation=ChinaQJDownListWebLocation&ChinaQJLanguageTxt16
  else
    dim rs,sql
    set rs = server.createobject("adodb.recordset")
    sql="select * from ChinaQJ_DownSort where "&ViewFlag&" and ID="&request.QueryString("SortID")
    rs.open sql,conn,1,1
    ChinaQJDownListWebLocation=ChinaQJDownListWebLocation&ChinaQJDownListSortPathTXT("ChinaQJ_DownSort",rs("ID"))
    rs.close
    set rs=nothing
  end if
end Function

function ChinaQJDownListSortPathTXT(DataFrom,ID)
  dim rs,sql
  Set rs=server.CreateObject("adodb.recordset")
  sql="Select * From "&DataFrom&" where "&ViewFlag&" and ID="&ID
  rs.open sql,conn,1,1
  if not rs.eof Then
    If ISHTML = 1 Then
        AutoLink = ""&rs("ClassSeo")&""&Separated&""&rs("ID")&""&Separated&"1."&HTMLName&""
    Else
        AutoLink = "DownList.Asp?SortID="&rs("ID")&""
    End If
    ChinaQJDownListSortPathTXT=ChinaQJDownListSortPathTXT(DataFrom,rs("ParentID"))&" - <a href="""&AutoLink&""">"&rs("SortName"&Language)&"</a>"
  end if
  rs.close
  set rs=nothing
end function

function ChinaQJDownListWebContent(DataFrom,ID,SortPath)
  dim rs,sql
  dim HideSort
  set rs = server.createobject("adodb.recordset")
  if ID="" then
    SortPath="0,"
  elseif not IsNumeric(ID) then
    response.write "<center>"&ChinaQJLanguageTxt7&"</center>"
    exit function
  elseif conn.execute("select * from "&DataFrom&" Where "&ViewFlag&" and  ID="&ID).eof then
    response.write "<center>"&ChinaQJLanguageTxt7&"</center>"
    exit function
  else
    SortPath=conn.execute("select * from "&DataFrom&" Where "&ViewFlag&" and  ID="&ID)("SortPath")
    conn.execute("update "&DataFrom&" set ClickNumber=ClickNumber+1 Where ID="&ID)
  end If
  If IsDatabaseType = 1 Then
    sql="select * from "&DataFrom&" Where not("&ViewFlag&") and Charindex('"&SortPath&"',SortPath) > 0"
  Else
    sql="select * from "&DataFrom&" Where not("&ViewFlag&") and Instr(SortPath,'"&SortPath&"') > 0"
  End If
  rs.open sql,conn,1,1
  while not rs.eof
    HideSort="and not(Instr(SortPath,'"&rs("SortPath")&"')>0) "&HideSort
    rs.movenext
  wend
  rs.close
  dim idCount
  dim pages
      pages=DownInfo
  dim pagec
  dim page
      page=clng(request("Page"))
  dim pagenc
      pagenc=5
  dim pagenmax
  dim pagenmin
  dim pageprevious
  dim pagenext
  datafrom="ChinaQJ_Download"
  dim datawhere
      If IsDatabaseType = 1 Then
        datawhere="where "&ViewFlag&" and Charindex('"&SortPath&"',SortPath) > 0 "&HideSort& " "
      Else
        datawhere="where "&ViewFlag&" and Instr(SortPath,'"&SortPath&"') > 0 "&HideSort& " "
      End If
  dim sqlid
  dim Myself,PATH_INFO,QUERY_STRING
      PATH_INFO = request.servervariables("PATH_INFO")
      QUERY_STRING = request.ServerVariables("QUERY_STRING")'
      if QUERY_STRING = "" then
        Myself = PATH_INFO & "?"
      elseif Instr(PATH_INFO & "?" & QUERY_STRING,"Page=")=0 then
        Myself= PATH_INFO & "?" & QUERY_STRING & "&"
      else
        Myself = Left(PATH_INFO & "?" & QUERY_STRING,Instr(PATH_INFO & "?" & QUERY_STRING,"Page=")-1)
      end if
  dim taxis
      taxis="order by Sequence desc,ID desc"
  dim i
  sql="select count(ID) as idCount from ["& datafrom &"]" & datawhere
  set rs=server.createobject("adodb.recordset")
  rs.open sql,conn,0,1
  idCount=rs("idCount")
  if(idcount>0) then
    if(idcount mod pages=0)then
      pagec=int(idcount/pages)
    else
      pagec=int(idcount/pages)+1
    end if
    sql="select id from ["& datafrom &"] " & datawhere & taxis
    set rs=server.createobject("adodb.recordset")
    rs.open sql,conn,1,1
    rs.pagesize = pages
    if page < 1 then page = 1
    if page > pagec then page = pagec
    if pagec > 0 then rs.absolutepage = page
    for i=1 to rs.pagesize
      if rs.eof then exit for
      if(i=1)then
        sqlid=rs("id")
      else
        sqlid=sqlid &","&rs("id")
      end if
      rs.movenext
    next
  end if
  if(idcount>0 and sqlid<>"") then
    sql="select * from ["& datafrom &"] where id in("& sqlid &") "&taxis
    set rs=server.createobject("adodb.recordset")
    rs.open sql,conn,0,1
    Response.Write "<table width=""98%"" border=""0"" cellspacing=""0"" cellpadding=""0"">"&VbCrLf
    Response.Write "  <tr height=""32"">"&VbCrLf
    Response.Write "    <td style=""color:#FFFFFF; font-weight:bold; background:url("&StylePath&"split.gif) no-repeat right center; background-color:#abacaf"">&nbsp;&nbsp;&nbsp;&nbsp;"&ChinaQJLanguageTxt42&"</td>"&VbCrLf
    Response.Write "    <td style=""color:#FFFFFF; font-weight:bold; background:url("&StylePath&"split.gif) no-repeat right center; background-color:#abacaf"">&nbsp;&nbsp;"&ChinaQJLanguageTxt53&"</td>"&VbCrLf
    Response.Write "    <td bgcolor=""#abacaf"" style=""color:#FFFFFF; font-weight:bold"">&nbsp;&nbsp;"&ChinaQJLanguageTxt54&"</td>"&VbCrLf
    Response.Write "  </tr>"&VbCrLf
    while not rs.eof
    If ISHTML = 1 Then
        AutoLink = ""&rs("ClassSeo")&""&Separated&""&rs("ID")&"."&HTMLName&""
    Else
        AutoLink = "DownView.Asp?ID="&rs("ID")&""
    End If
    Response.Write "  <tr height=""28"">"&VbCrLf
    Response.Write "    <td style=""background:url("&StylePath&"bg2.gif) repeat-x left bottom;"">&nbsp;<img src="""&StylePath&"arr.gif"" align=""absmiddle"" />&nbsp;&nbsp;<a href="""&AutoLink&"""><font color="""&rs("TitleColor")&""">"&rs("DownName"&Language)&"</font></a></td>"&VbCrLf
    Response.Write "    <td style=""background:url("&StylePath&"bg2.gif) repeat-x left bottom;"">&nbsp;&nbsp;&nbsp;"&rs("FileSize")&"</td>"&VbCrLf
    Response.Write "    <td style=""background:url("&StylePath&"bg2.gif) repeat-x left bottom; color:#999999"">&nbsp;&nbsp;&nbsp;"&FormatDate(rs("Updatetime"),13)&"</td>"&VbCrLf
    Response.Write "  </tr>"&VbCrLf
    rs.movenext
    wend
    Response.Write "</table>"&VbCrLf
  else
    response.write "<center>"&ChinaQJLanguageTxt7&"</center>"
    exit function
  end if
  Response.Write "<div class=""page"">"&VbCrLf
  Response.Write ""&ChinaQJLanguageTxt44&"<strong style=""color:red"">"&idcount&"</strong>"&ChinaQJLanguageTxt45&"&nbsp;&nbsp;&nbsp;" & vbCrLf
  pagenmin=page-pagenc
  pagenmax=page+pagenc
  if(pagenmin<1) then pagenmin=1
%>
    <span id="page">
<%
Sortid=Request("Sortid")
If ISHTML = 1 Then
If Sortid="" then
%>
        <a href="<%= ClassSeo %><%= Separated %>1.<%= HTMLName %>"><%= ChinaQJLanguageTxt313 %></a>
<% If page>1 Then %>
        <a href="<%= ClassSeo %><%= Separated %><%= page-1 %>.<%= HTMLName %>"><%= ChinaQJLanguageTxt314 %></a>
<% Else %>
        <a href="<%= ClassSeo %><%= Separated %>1.<%= HTMLName %>"><%= ChinaQJLanguageTxt313 %></a>
<% End If %>
<%
  if(pagenmax>pagec) then pagenmax=pagec
  for i = pagenmin to pagenmax
    if(i=page) then
%>
        <a href="<%= ClassSeo %><%= Separated %><%= i %>.<%= HTMLName %>" class='page_click' ><%= i %></a>
<% Else %>
        <a href="<%= ClassSeo %><%= Separated %><%= i %>.<%= HTMLName %>" class='' ><%= i %></a>
<%
End If
Next
%>
<% If page<pagenmax Then %>
        <a href="<%= ClassSeo %><%= Separated %><%= page+1 %>.<%= HTMLName %>"><%= ChinaQJLanguageTxt315 %></a>
<% Else %>
        <a href="<%= ClassSeo %><%= Separated %><%= pagenmax %>.<%= HTMLName %>"><%= ChinaQJLanguageTxt315 %></a>
<% End If %>
        <a href="<%= ClassSeo %><%= Separated %><%= pagenmax %>.<%= HTMLName %>"><%= ChinaQJLanguageTxt316 %></a>
<% Else %>
        <a href="<%= ClassSeo %><%= Separated %><%= Sortid %><%= Separated %>1.<%= HTMLName %>"><%= ChinaQJLanguageTxt313 %></a>
<% If page>1 Then %>
        <a href="<%= ClassSeo %><%= Separated %><%= Sortid %><%= Separated %><%= page-1 %>.<%= HTMLName %>"><%= ChinaQJLanguageTxt314 %></a>
<% Else %>
        <a href="<%= ClassSeo %><%= Separated %><%= Sortid %><%= Separated %>1.<%= HTMLName %>"><%= ChinaQJLanguageTxt314 %></a>
<% End If %>
<%
  if(pagenmax>pagec) then pagenmax=pagec
  for i = pagenmin to pagenmax
    if(i=page) then
%>
        <a href="<%= ClassSeo %><%= Separated %><%= Sortid %><%= Separated %><%= i %>.<%= HTMLName %>" class='page_click' ><%= i %></a>
<% Else %>
        <a href="<%= ClassSeo %><%= Separated %><%= Sortid %><%= Separated %><%= i %>.<%= HTMLName %>" class='' ><%= i %></a>
<%
End If
Next
%>
<% If page<pagenmax Then %>
        <a href="<%= ClassSeo %><%= Separated %><%= Sortid %><%= Separated %><%= page+1 %>.<%= HTMLName %>"><%= ChinaQJLanguageTxt315 %></a>
<% Else %>
        <a href="<%= ClassSeo %><%= Separated %><%= Sortid %><%= Separated %><%= pagenmax %>.<%= HTMLName %>"><%= ChinaQJLanguageTxt315 %></a>
<% End If %>
        <a href="<%= ClassSeo %><%= Separated %><%= Sortid %><%= Separated %><%= pagenmax %>.<%= HTMLName %>"><%= ChinaQJLanguageTxt316 %></a>
<% End If %>
<% Else %>
        <a href="<%= myself %>Page=1"><%= ChinaQJLanguageTxt313 %></a>
<% If page>1 Then %>
        <a href="<%= myself %>Page=<%= page-1 %>"><%= ChinaQJLanguageTxt314 %></a>
<% Else %>
        <a href="<%= myself %>Page=1"><%= ChinaQJLanguageTxt314 %></a>
<% End If %>
<%
  if(pagenmax>pagec) then pagenmax=pagec
  for i = pagenmin to pagenmax
    if(i=page) then
%>
        <a href="<%= myself %>Page=<%= i %>" class='page_click' ><%= i %></a>
<% Else %>
        <a href="<%= myself %>Page=<%= i %>" class='' ><%= i %></a>
<%
End If
Next
%>
<% If page<pagenmax Then %>
        <a href="<%= myself %>Page=<%= page+1 %>"><%= ChinaQJLanguageTxt315 %></a>
<% Else %>
        <a href="<%= myself %>Page=<%= pagenmax %>"><%= ChinaQJLanguageTxt315 %></a>
<% End If %>
        <a href="<%= myself %>Page=<%= pagenmax %>"><%= ChinaQJLanguageTxt316 %></a>
<% End If %>
    </span>
<%
  Response.Write "</div>"&VbCrLf
  rs.close
  set rs=nothing
end Function

Function ChinaQJAboutFolderW()
  dim rs,sql
  set rs = server.createobject("adodb.recordset")
  sql="Select * From ChinaQJ_About where "&ViewFlag&" order by Sequence,ID"
  rs.open sql,conn,1,1
  if rs.eof then
    response.write "<center>"&ChinaQJLanguageTxt7&"</center>"
  else
    Do
    If ISHTML = 1 Then
        AutoLink = ""&rs("ClassSeo")&""&Separated&""&rs("ID")&"."&HTMLName&""
    Else
        AutoLink = "About.Asp?ID="&rs("ID")&""
    End If
    FolderName=rs("AboutName"&Language)
        response.write "<a href="""&AutoLink&""">"&FolderName&"</a>"&VbCrLf
        rs.movenext
    loop until rs.eof
  end if
  rs.close
  set rs=nothing
end Function

Function ChinaQJAboutFolder(id)
  Dim rs,sql,i,ChildCount,FolderType,FolderName,onMouseUp,ListType
  Set rs=server.CreateObject("adodb.recordset")
  sql="Select * From ChinaQJ_About where "&ViewFlag&" And ParentID="&id&" order by Sequence,ID"
  rs.open sql,conn,1,1
    if id=0 and rs.recordcount=0 then
        response.write "<center>"&ChinaQJLanguageTxt7&"</center>"
        exit function
    end if
  i=1
  response.write("<table border=""0"" cellspacing=""1"" cellpadding=""2"">")
  while not rs.eof
    ChildCount=conn.execute("select count(*) from ChinaQJ_About where ParentID="&rs("id"))(0)
    if ChildCount=0 then
      if i=rs.recordcount then
        FolderType="SortFileEnd"
      else
        FolderType="SortFile"
      end if
      FolderName=rs("AboutName"&Language)
      onMouseUp=""
    else
      if i=rs.recordcount then
        FolderType="SortEndFolderClose"
        ListType="SortEndListline"
        onMouseUp="EndSortChange('a"&rs("id")&"','b"&rs("id")&"');"
      else
      If SortStart = 0 Then
        FolderType="SortFolderOpen"
      Else
        FolderType="SortFolderClose"
      End If
        ListType="SortListline"
        onMouseUp="SortChange('a"&rs("id")&"','b"&rs("id")&"');"
      end if
      FolderName=rs("AboutName"&Language)
    end If
    If ISHTML = 1 Then
        AutoLink = ""&rs("ClassSeo")&""&Separated&""&rs("ID")&"."&HTMLName&""
    Else
        AutoLink = "About.Asp?ID="&rs("ID")&""
    End If
    response.write("<tr>")
    response.write("<td nowrap id=""b"&rs("id")&""" onMouseUp="""&onMouseUp&""" class="""&FolderType&"""></td><td nowrap style=""padding-top: 3px""><a href="""&AutoLink&""">"&FolderName&"</a></td></tr>")
    if ChildCount>0 then
%>
<%If SortStart = 0 Then%>
<tr id="a<%=rs("id")%>" style="display: none">
<%Else%>
<tr id="a<%=rs("id")%>" style="display: yes">
<%End If%>
  <td class="<%=ListType%>" nowrap></td>
  <td><% ChinaQJAboutFolder(rs("id")) %></td>
</tr>
<%
    end if
    rs.movenext
    i=i+1
    wend
    response.write("</table>")
    rs.close
    set rs=nothing
end Function

function ChinaQJAboutWebLocation()
  ChinaQJAboutWebLocation="&nbsp;"&ChinaQJLanguageTxt19&"：<a href=""Index.Asp"" class=""agray"">"&ChinaQJLanguageTxt20&"</a> - <a href=""Company.Asp"" class=""agray"">"&ChinaQJLanguageTxt36&"</a>"&VbCrLf
end Function

function ChinaQJAboutDetail()
    Response.Write "        <table width=""100%"" border=""0"" cellspacing=""0"" cellpadding=""0"">"&VbCrLf
    Response.Write "              <tr>"&VbCrLf
    Response.Write "                <td width=""201"" valign=""top"" style=""background:url("&StylePath&"bg-line.gif) repeat-y right top;""><img src="""&StylePath&"us.gif"" width=""200"" height=""260"" /></td>"&VbCrLf
    Response.Write "                <td valign=""top""><table width=""100%"" border=""0"" cellspacing=""0"" cellpadding=""0"" style=""margin-left:1px;"">"&VbCrLf
    Response.Write "                    <tr>"&VbCrLf
    Response.Write "                      <td>"&VbCrLf
      dim rs,sql,NewsName,NewFlag
      set rs = server.createobject("adodb.recordset")
      sql="select * from ChinaQJ_Subsidiary where Subsidiary"&Language&"<>"""" order by Sequence,id"
      rs.open sql,conn,1,1
      if rs.eof then
        Response.Write "  <tr>"&VbCrLf
        Response.Write "    <td align=""center"" height=""28"">"&ChinaQJLanguageTxt7&"</td>"&VbCrLf
        Response.Write "  </tr>"&VbCrLf
      Else
      do while not rs.eof
    Response.Write "                        <table width=""100%"" border=""1"" bordercolor=""#EDEDED"" cellspacing=""0"" cellpadding=""8"" style=""border-collapse: collapse"">"&VbCrLf
    Response.Write "                          <tr height=""25"">"&VbCrLf
    Response.Write "                            <td bgcolor=""#EDEDED"" style=""font-weight: bold; color: #EC0000; padding-left: 8px;"" colspan=""2"">"&rs("Subsidiary"&Language)&"</td>"&VbCrLf
    Response.Write "                          </tr>"&VbCrLf
    attribute1=rs("PropertyName"&Language)
    attribute1_value=rs("PropertyValue"&Language)
    if attribute1 <> "" and attribute1_value <> "" then
        attribute1_1=Split(attribute1,"§§§")
        attribute1_value_1=Split(attribute1_value,"§§§")
    for i=0 to ubound(attribute1_value_1)
    Response.Write "                          <tr height=""25"">"&VbCrLf
    Response.Write "                            <td width=""59"" align=""right"" style=""padding-right: 8px;"">"&attribute1_1(i)&"</td>"&VbCrLf
    Response.Write "                            <td style=""padding-left: 8px;"">"&attribute1_value_1(i)&"</td>"&VbCrLf
    Response.Write "                          </tr>"&VbCrLf
    Next
    End If
    Response.Write "                        </table>"&VbCrLf
    Response.Write "                        <br />"&VbCrLf
      rs.movenext
      loop
      end if
      rs.close
      set rs=Nothing
    Response.Write "                        </td>"&VbCrLf
    Response.Write "                    </tr>"&VbCrLf
    Response.Write "                  </table></td>"&VbCrLf
    Response.Write "              </tr>"&VbCrLf
    Response.Write "            </table>"&VbCrLf
end Function

function ChinaQJAboutzWebLocation()
  ChinaQJAboutzWebLocation="&nbsp;"&ChinaQJLanguageTxt19&"：<a href=""Index.Asp"" class=""agray"">"&ChinaQJLanguageTxt20&"</a> - <a href=""About.Asp"" class=""agray"">"&ChinaQJLanguageTxt15&"</a> - "&VbCrLf
  dim rs,sql
  set rs = server.createobject("adodb.recordset")
  if request.QueryString("ID")="" or not IsNumeric(request.QueryString("ID")) then
    sql="select top 1 * from ChinaQJ_About where "&ViewFlag&" order by Sequence desc,ID desc"
  else
    sql="select * from ChinaQJ_About where "&ViewFlag&" and ID="&request.QueryString("ID")
  end if
  rs.open sql,conn,1,1
  if rs.eof then
    ChinaQJAboutzWebLocation=ChinaQJAboutzWebLocation&ChinaQJLanguageTxt16
  else
    ChinaQJAboutzWebLocation=ChinaQJAboutzWebLocation&""&rs("AboutName"&Language)
  end if
  rs.close
  set rs=nothing
end Function

function ChinaQJAboutzDetail()
    Response.Write "    <table width=""100%"" border=""0"" align=""center"" cellpadding=""0"" cellspacing=""0"">"&VbCrLf
      dim rs,sql
      set rs = server.createobject("adodb.recordset")
      if request.QueryString("ID")="" or not IsNumeric(request.QueryString("ID")) then
        sql="select top 1 * from ChinaQJ_About where "&ViewFlag&" order by Sequence asc,ID desc"
      else
        sql="select * from ChinaQJ_About where "&ViewFlag&" and ID="&request.QueryString("ID")
      end if
      rs.open sql,conn,1,3
      if rs.eof Then
    Response.Write "        <tr>"&VbCrLf
    Response.Write "          <td align=""center"">"&ChinaQJLanguageTxt7&"</td>"&VbCrLf
    Response.Write "        </tr>"&VbCrLf
      Else
    If Request("page")="" Then
    pageNum=0
    Else
    pageNum=Request("page")
    End if
        if ViewNoRight(rs("GroupID"),rs("Exclusive")) then
            Response.Write "        <tr>"&VbCrLf
            Response.Write "          <td><table width=""100%"" border=""0"" cellspacing=""0"" cellpadding=""0"">"&VbCrLf
            Response.Write "              <tr>"&VbCrLf
            Response.Write "                <td width=""30"" height=""36""><img src="""&StylePath&"title_bg1.gif"" width=""30"" height=""36"" /></td>"&VbCrLf
            Response.Write "                <td width=""100%"" align=""center"" background="""&StylePath&"title_bg_center.jpg"" style=""color:#fff; font-size:14px; font-weight:bold"">"&rs("AboutName"&Language)&"</td>"&VbCrLf
            Response.Write "                <td width=""30""><img src="""&StylePath&"title_bg2.gif"" width=""30"" height=""36"" /></td>"&VbCrLf
            Response.Write "              </tr>"&VbCrLf
			Response.Write "              <tr>" & vbCrLf
			Response.Write "                <td><img src=""" & StylePath & "title_bg3.gif"" width=""30"" height=""14"" /></td>" & vbCrLf
			Response.Write "                <td background=""" & StylePath & "title_bg_center2.jpg"">&nbsp;</td>" & vbCrLf
			Response.Write "                <td><img src=""" & StylePath & "title_bg4.gif"" width=""30"" height=""14"" /></td>" & vbCrLf
			Response.Write "              </tr>" & vbCrLf
            Response.Write "            </table></td>"&VbCrLf
            Response.Write "        </tr>"&VbCrLf
            Response.Write "        <tr>"&VbCrLf
            Response.Write "          <td align=""center"" class=""subdatext""><strong>"&ChinaQJLanguageTxt17&"：</strong>"&FormatDate(rs("UpdateTime"),13)&" <strong>"&ChinaQJLanguageTxt18&"：</strong><script language=""javascript"" src=""HitCount.Asp?id="&rs("ID")&"&LX=ChinaQJ_About""></script><script language=""javascript"" src=""HitCount.Asp?action=count&LX=ChinaQJ_About&id="&rs("ID")&"""></script></td>"&VbCrLf
            Response.Write "        </tr>"&VbCrLf
            Response.Write "        <tr>"&VbCrLf
            Response.Write "          <td height=""20"">&nbsp;</td>"&VbCrLf
            Response.Write "        </tr>"&VbCrLf
            Response.Write "        <tr>"&VbCrLf
            Response.Write "          <td style=""line-height:25px; font-size:12px; padding-left: 8px; padding-right: 8px"">"&VbCrLf
    if rs("ChinaQJpic")<>"" then Response.Write "<img src='"&rs("ChinaQJpic")&"' width='696' border='0'><br><br>"&VbCrLf
	ContentStr=split(rs("Content"&Language),"{＄html_Paging＄}")
    For i=pageNum to pageNum
    Response.Write ""&ProcessSitelink(ContentStr(i)) &""
    Next
    Response.Write "          </td>"&VbCrLf
            Response.Write "        </tr>"&VbCrLf
    Response.Write "        <tr>"&VbCrLf
    Response.Write "          <td height=""20"" align=""right"" class=""contentpage"">"&VbCrLf
    %>
    <%=ChinaQJLanguageTxt250%><%For p = 0 to ubound(ContentStr)%> <a href="About.Asp?ID=<%=request("ID")%>&page=<%=p%>"><font color="red"><%=p+1%></font></a> <%Next%><%=ChinaQJLanguageTxt50%>
    <%
    Response.Write "          </td>"&VbCrLf
    Response.Write "        </tr>"&VbCrLf
        else
            Response.Write "        <tr>"&VbCrLf
            Response.Write "          <td align=""center""><img src="""&StylePath&"NoRight_"&Language&".jpg""></td>"&VbCrLf
            Response.Write "        </tr>"&VbCrLf
        end if
        rs.update
      end if
      rs.close
      set rs=Nothing
    Set rs = Server.CreateObject("Adodb.Recordset")
    If Request.QueryString("ID") = "" Or Not IsNumeric(Request.QueryString("ID")) Then
        sql = "Select Top 1 TheTags" & Language & " From ChinaQJ_About Where " & ViewFlag & " Order By Sequence Desc,ID Desc"
    Else
        sql = "Select TheTags" & Language & " From ChinaQJ_About Where " & ViewFlag & " And ID = " & Request.QueryString("ID")
    End If
    rs.Open sql, conn, 1, 1
    If Not rs.EOF Then
        If rs("TheTags" & Language) <> "" Then
            Response.Write "        <tr>" & vbCrLf
            Response.Write "          <td height=""25"" align=""right"" style=""padding-left: 8px; padding-right: 8px;"">" & vbCrLf
            Response.Write "          <font color=""#005AA0"">Tags：</font>" & vbCrLf
            TheTags = Split(rs("TheTags" & Language), ",")
            For i = 0 To UBound(TheTags)
                Response.Write "<a href=""Search.Asp?Range=News&Keyword=" & TheTags(i) & """>"
                Response.Write "<font color=""#CC3C3C""><u>"
                Response.Write TheTags(i) & ""
                Response.Write "</u></font>"
                Response.Write "</a> "
            Next
            Response.Write "          </td>" & vbCrLf
            Response.Write "        </tr>" & vbCrLf
        End If
    End If
    rs.Close
    Set rs = Nothing
    Response.Write "        <tr>"&VbCrLf
    Response.Write "          <td height=""20"">&nbsp;</td>"&VbCrLf
    Response.Write "        </tr>"&VbCrLf
    Response.Write "      </table>"&VbCrLf
end Function

function ChinaQJTalentWriteForm()
    Response.Write "            <table width=""100%"" border=""0"" align=""center"" cellpadding=""3"" cellspacing=""5"">"&VbCrLf
    Response.Write "              <form action=""TalentSave.Asp?MemberID="&mMemID&"&JobID="&JobID&""" method=""post"" name=""formWrite"" id=""formWrite"">"&VbCrLf
    Response.Write "                <tr>"&VbCrLf
    Response.Write "                  <td width=""200"" align=""right"">"&ChinaQJLanguageTxt206&"：</td>"&VbCrLf
    Response.Write "                  <td><input name=""TalentsName"" type=""text"" id=""TalentsName"" value="""&TalentsName&""" size=""40"" maxlength=""100"" />"&VbCrLf
    Response.Write "                    <font color=""red"">*</font></td>"&VbCrLf
    Response.Write "                </tr>"&VbCrLf
    Response.Write "                <tr>"&VbCrLf
    Response.Write "                  <td align=""right"">"&ChinaQJLanguageTxt89&"：</td>"&VbCrLf
    Response.Write "                  <td><input name=""Linkman"" type=""text"" value="""&mLinkman&""" size=""20"" maxlength=""50"" />"&VbCrLf
    Response.Write "                    <font color=""red"">*</font></td>"&VbCrLf
    Response.Write "                </tr>"&VbCrLf
    Response.Write "                <tr>"&VbCrLf
    Response.Write "                  <td align=""right"">"&ChinaQJLanguageTxt90&"：</td>"&VbCrLf
    Response.Write "                  <td><input name=""Sex"" type=""radio"" value="""&ChinaQJLanguageTxt91&""" class=""inputnoborder"" "
    if mSex=ChinaQJLanguageTxt91 then response.write ("checked")
    response.write " />"&ChinaQJLanguageTxt91&" "
    Response.Write "                    <input type=""radio"" name=""Sex"" value="""&ChinaQJLanguageTxt92&""" class=""inputnoborder"" "
    if mSex=ChinaQJLanguageTxt92 then response.write ("checked")
    response.write " /> "&ChinaQJLanguageTxt92&" <font color=""red"">*</font></td>"&VbCrLf
    Response.Write "                </tr>"&VbCrLf
    Response.Write "                <tr>"&VbCrLf
    Response.Write "                  <td align=""right"">"&ChinaQJLanguageTxt123&"：</td>"&VbCrLf
    Response.Write "                  <td><input name=""BirthDate"" type=""text"" id=""BirthDate"" size=""20"" maxlength=""10"" />"&VbCrLf
    Response.Write "                    <font color=""red"">*</font>("&ChinaQJLanguageTxt207&"：1988-08-18)</td>"&VbCrLf
    Response.Write "                </tr>"&VbCrLf
	if Instr(RecruitmentPurview,"|9,")>0 then
    Response.Write "                <tr>"&VbCrLf
    Response.Write "                  <td align=""right"">"&ChinaQJLanguageTxt125&"：</td>"&VbCrLf
    Response.Write "                  <td><input name=""Marriage"" type=""radio"" value="""&ChinaQJLanguageTxt208&""" checked=""checked"" class=""inputnoborder"" />"&VbCrLf
    Response.Write "                    "&ChinaQJLanguageTxt208&""&VbCrLf
    Response.Write "                    <input type=""radio"" name=""Marriage"" value="""&ChinaQJLanguageTxt209&""" class=""inputnoborder"" />"&VbCrLf
    Response.Write "                    "&ChinaQJLanguageTxt208&" "
	if Instr(RecruitmentPurviewDis,"|9,")>0 then Response.Write "<font color=""red"">*</font>"
	Response.Write "</td>"&VbCrLf
    Response.Write "                </tr>"&VbCrLf
	end if
	if Instr(RecruitmentPurview,"|10,")>0 then
    Response.Write "                <tr>"&VbCrLf
    Response.Write "                  <td align=""right"">"&ChinaQJLanguageTxt210&"：</td>"&VbCrLf
    Response.Write "                  <td><input name=""Stature"" type=""text"" id=""Stature"" size=""20"" maxlength=""10"" /> CM "
	if Instr(RecruitmentPurviewDis,"|10,")>0 then Response.Write "<font color=""red"">*</font>"
	Response.Write "</td>"&VbCrLf
    Response.Write "                </tr>"&VbCrLf
	end if
    Response.Write "                <tr>"&VbCrLf
    Response.Write "                  <td align=""right"">"&ChinaQJLanguageTxt126&"：</td>"&VbCrLf
    Response.Write "                  <td><input name=""RegResidence"" type=""text"" id=""RegResidence"" size=""50"" maxlength=""100"" />"&VbCrLf
    Response.Write "                    <font color=""red"">*</font></td>"&VbCrLf
    Response.Write "                </tr>"&VbCrLf
    Response.Write "                <tr>"&VbCrLf
    Response.Write "                  <td align=""right"">"&ChinaQJLanguageTxt128&"：</td>"&VbCrLf
    Response.Write "                  <td>"&ChinaQJLanguageTxt211&"&nbsp;&nbsp;&nbsp;&nbsp;"&ChinaQJLanguageTxt212&"&nbsp;&nbsp;&nbsp;&nbsp;"&ChinaQJLanguageTxt213&"&nbsp;&nbsp;&nbsp;&nbsp;"&ChinaQJLanguageTxt214&"&nbsp;&nbsp;&nbsp;&nbsp;"&ChinaQJLanguageTxt215&" <font color=""red"">*</font></td>"&VbCrLf
    Response.Write "                </tr>"&VbCrLf
    Response.Write "                <tr>"&VbCrLf
    Response.Write "                  <td align=""right""></td>"&VbCrLf
    Response.Write "                  <td><textarea name=""EduResume"" rows=""8"" style=""width:500px""></textarea></td>"&VbCrLf
    Response.Write "                </tr>"&VbCrLf
    Response.Write "                <tr>"&VbCrLf
    Response.Write "                  <td align=""right"">"&ChinaQJLanguageTxt129&"：</td>"&VbCrLf
    Response.Write "                  <td>"&ChinaQJLanguageTxt212&"&nbsp;&nbsp;&nbsp;&nbsp;"&ChinaQJLanguageTxt67&"&nbsp;&nbsp;&nbsp;&nbsp;"&ChinaQJLanguageTxt216&"&nbsp;&nbsp;&nbsp;&nbsp;"&ChinaQJLanguageTxt217&" <font color=""red"">*</font></td>"&VbCrLf
    Response.Write "                </tr>"&VbCrLf
    Response.Write "                <tr>"&VbCrLf
    Response.Write "                  <td align=""right""></td>"&VbCrLf
    Response.Write "                  <td><textarea name=""JobResume"" rows=""8"" id=""JobResume"" style=""width:500px""></textarea></td>"&VbCrLf
    Response.Write "                </tr>"&VbCrLf
	if Instr(RecruitmentPurview,"|11,")>0 then
    Response.Write "                <tr>"&VbCrLf
    Response.Write "                  <td align=""right"">"&ChinaQJLanguageTxt127&"：</td>"&VbCrLf
    Response.Write "                  <td><input name=""Address"" type=""text"" value="""&mAddress&""" size=""50"" maxlength=""100"" />"&VbCrLf
	if Instr(RecruitmentPurviewDis,"|11,")>0 then Response.Write "<font color=""red"">*</font>"
	Response.Write "</td>"&VbCrLf
    Response.Write "                </tr>"&VbCrLf
	end if
	if Instr(RecruitmentPurview,"|12,")>0 then
    Response.Write "                <tr>"&VbCrLf
    Response.Write "                  <td align=""right"">"&ChinaQJLanguageTxt34&"：</td>"&VbCrLf
    Response.Write "                  <td><input name=""ZipCode"" type=""text"" id=""ZipCode"" value="""&mZipCode&""" size=""20"" maxlength=""20"" />"&VbCrLf
	if Instr(RecruitmentPurviewDis,"|12,")>0 then Response.Write "<font color=""red"">*</font>"
	Response.Write "</td>"&VbCrLf
    Response.Write "                </tr>"&VbCrLf
	end if
    Response.Write "                <tr>"&VbCrLf
    Response.Write "                  <td align=""right"">"&ChinaQJLanguageTxt27&"：</td>"&VbCrLf
    Response.Write "                  <td><input name=""Telephone"" type=""text"" id=""Telephone"" value="""&mTelephone&""" size=""20"" maxlength=""50"" />"&VbCrLf
    Response.Write "                    <font color=""red"">*</font></td>"&VbCrLf
    Response.Write "                </tr>"&VbCrLf
	if Instr(RecruitmentPurview,"|13,")>0 then
    Response.Write "                <tr>"&VbCrLf
    Response.Write "                  <td align=""right"">"&ChinaQJLanguageTxt26&"：</td>"&VbCrLf
    Response.Write "                  <td><input name=""Mobile"" type=""text"" id=""Mobile"" value="""&mMobile&""" size=""20"" maxlength=""50"" />"&VbCrLf
	if Instr(RecruitmentPurviewDis,"|13,")>0 then Response.Write "<font color=""red"">*</font>"
	Response.Write "</td>"&VbCrLf
    Response.Write "                </tr>"&VbCrLf
	end if
	if Instr(RecruitmentPurview,"|14,")>0 then
    Response.Write "                <tr>"&VbCrLf
    Response.Write "                  <td align=""right"">"&ChinaQJLanguageTxt101&"：</td>"&VbCrLf
    Response.Write "                  <td><input name=""Email"" type=""text"" id=""Email"" value="""&mEmail&""" size=""30"" maxlength=""50"" />"&VbCrLf
	if Instr(RecruitmentPurviewDis,"|14,")>0 then Response.Write "<font color=""red"">*</font>"
	Response.Write "</td>"&VbCrLf
    Response.Write "                </tr>"&VbCrLf
	end if
    Response.Write "                <tr>"&VbCrLf
    Response.Write "                  <td align=""right"">"&ChinaQJLanguageTxt107&"：</td>"&VbCrLf
    Response.Write "                  <td><input name=""CheckCode"" type=""text"" size=""6"" maxlength=""6"" />"&VbCrLf
    Response.Write "                    <a href=""javascript:refreshimg()"" title="""&ChinaQJLanguageTxt108&"""><img src=""../Include/CheckCode/CheckCode.Asp"" name=""checkcode"" align=""absmiddle"" id=""checkcode"" style=""border: 1px solid #ffffff"" /></a> <font color=""red"">*</font></td>"&VbCrLf
    Response.Write "                </tr>"&VbCrLf
    Response.Write "                <tr>"&VbCrLf
    Response.Write "                  <td align=""right"">&nbsp;</td>"&VbCrLf
    Response.Write "                  <td><input name=""Submit"" type=""submit"" value="""&ChinaQJLanguageTxt218&""" /></td>"&VbCrLf
    Response.Write "                </tr>"&VbCrLf
    Response.Write "              </form>"&VbCrLf
    Response.Write "            </table>"&VbCrLf
end Function

function ChinaQJEMailSubscriptions()
    Response.Write "                    <table width=""100%"" border=""0"" cellspacing=""0"" cellpadding=""0"" align=""center"">"&VbCrLf
    Response.Write "                      <form action="""" method=""post"" name=""ChinaQJEmail"">"&VbCrLf
    Response.Write "                        <tr height=""25"">"&VbCrLf
    Response.Write "                          <td><font color=""#CC0000"">"&ChinaQJLanguageTxt251&"</font></td>"&VbCrLf
    Response.Write "                        </tr>"&VbCrLf
    Response.Write "                        <tr height=""25"">"&VbCrLf
    Response.Write "                          <td><input type=""text"" name=""ChinaQJSubscribe"" style=""width: 180px"" /></td>"&VbCrLf
    Response.Write "                        </tr>"&VbCrLf
    Response.Write "                        <tr height=""25"">"&VbCrLf
    Response.Write "                          <td><input type=""submit"" name=""Subscribe"" value="""&ChinaQJLanguageTxt252&""" onclick=""document.ChinaQJEmail.action='"&SysRootDir&Language&"/Subscribe.Asp?Action=Add'"" />"&VbCrLf
    Response.Write "                            <input type=""submit"" name=""Unsubscribe"" value="""&ChinaQJLanguageTxt253&""" onclick=""document.ChinaQJEmail.action='"&SysRootDir&Language&"/Subscribe.Asp?Action=Del'"" /></td>"&VbCrLf
    Response.Write "                        </tr>"&VbCrLf
    Response.Write "                      </form>"&VbCrLf
    Response.Write "                    </table>"&VbCrLf
end Function

function ChinaQJVote()
    id = request("id")
    If IsNumeric(id) = False Then
    response.Write("<script>alert("""&ChinaQJLanguageTxt271&""");window.close();</script>")
    Else
    Set rs = Server.CreateObject("Adodb.Recordset")
    sql = "select * from ChinaQJ_Vote where ChinaQJ_Voteid = "&id
    rs.open sql,conn,1,1
    If Not (rs.bof And rs.eof) Then
    ChinaQJ_Voteid = rs("ChinaQJ_Voteid")
    ChinaQJ_VoteTitle = rs("ChinaQJ_VoteTitle")
    End If
    sql1 = "select * from ChinaQJ_Vote where ChinaQJ_VoteClass = "&ChinaQJ_Voteid&" order by ChinaQJ_Voteid"
    Set rs1 = Conn.execute(sql1)
    If Not(rs1.bof And rs1.eof) Then
    totalcount = 0
    Do While Not rs1.eof
    totalcount = totalcount + rs1("ChinaQJ_VoteCount")
    rs1.movenext
    Loop
    totalren = totalcount
    If totalcount = 0 Then
    totalcount = 1
    End If
    Response.Write "<table width=""85%"" border=""0"" cellspacing=""0"" cellpadding=""0"" align=""center"">"&VbCrLf
    rs1.movefirst
    Do while not rs1.eof
    Response.Write "  <tr>"&VbCrLf
    Response.Write "    <td width=""25%"" align=""left"">"&ChinaQJLanguageTxt272&""&rs1("ChinaQJ_VoteTitle")&"</td>"&VbCrLf
    Dim h
    h = cint((rs1("ChinaQJ_VoteCount")*300)/totalcount)
    Response.Write "    <td width=""55%"" align=""left""><hr width="""&h&""" color="""&rs1("ChinaQJ_VoteColor")&""" style=""height: 8px""></td>"&VbCrLf
    Response.Write "    <td width=""20%"" align=""left"">"&rs1("ChinaQJ_VoteCount")&""&ChinaQJLanguageTxt273&"("&FormatNumber((rs1("ChinaQJ_VoteCount")*100)/totalcount,2)&"%)</td>"&VbCrLf
    Response.Write "  </tr>"&VbCrLf
    rs1.movenext
    Loop
    End If
    Response.Write "  <tr>"&VbCrLf
    Response.Write "    <td colspan=""3"" height=""50"" align=""right"" style=""padding-right: 20px"">"&ChinaQJLanguageTxt274&" <font color=""red"">"&totalren&"</font> "&ChinaQJLanguageTxt275&"</td>"&VbCrLf
    Response.Write "  </tr>"&VbCrLf
    Response.Write "</table>"&VbCrLf
    End If
end Function

function ChinaQJSiteMapCoordinate(MapW,MapH)
    If SiteMapCoordinate = "" Or IsNull(SiteMapCoordinate) Then SiteMapCoordinate = "11433818,3054707"
    Response.Write "<iframe margin=""0"" src=""" & SysRootDir & "Map/index.asp?Language="&Language&""" width=""" & MapW & """ height=""" & MapH & """ scrolling=""no"" frameborder=""0""></iframe>"
end Function

function ChinaQJSiteMapCoordinate2(MapW,MapH)
    If SiteMapCoordinate = "" Or IsNull(SiteMapCoordinate) Then SiteMapCoordinate = "11433818,3054707"
    Response.Write "<iframe margin=""0"" src=""" & StylePath & "ChinaQJmap.html"" width=""" & MapW & """ height=""" & MapH & """ scrolling=""no"" frameborder=""0""></iframe>"
end Function

function ChinaQJNetWebLocation()
  ChinaQJNetWebLocation="&nbsp;"&ChinaQJLanguageTxt19&"：<a href=""Index.Asp"" class=""agray"">"&ChinaQJLanguageTxt20&"</a> - <a href=""NetWork.Asp"" class=""agray"">"&ChinaQJLanguageTxt276&"</a>"&VbCrLf
end Function

function ChinaQJNetDetail()
    If Key = "" Then response.Redirect "NetWork.Asp"
    set rs = server.createobject("adodb.recordset")
    sql="select * from ChinaQJ_NetWork where ChinaQJ_Province = '" & Key& " '"
    rs.open sql,conn,1,1
    If rs.bof And rs.eof Then
    response.write ChinaQJLanguageTxt277
    Else
    do while not rs.eof
    ChinaQJ_Province=rs("ChinaQJ_Province")
    ChinaQJ_Company=rs("ChinaQJ_Company"&Language)
    ChinaQJ_Address=rs("ChinaQJ_Address"&Language)
    ChinaQJ_User=rs("ChinaQJ_User"&Language)
    ChinaQJ_Tel=rs("ChinaQJ_Tel")
    ChinaQJ_Fax=rs("ChinaQJ_Fax")
    ChinaQJ_Url=rs("ChinaQJ_Url")
    ChinaQJ_Zip=rs("ChinaQJ_Zip")
    ChinaQJ_Demo=rs("ChinaQJ_Demo"&Language)
    Response.Write "              <table width=""650"" border=""1"" align=""center"" cellpadding=""6"" cellspacing=""0"" bordercolor=""#e8e8e8"" style=""margin-bottom: 15px;"">"&VbCrLf
    Response.Write "                <tr height=""25"">"&VbCrLf
    Response.Write "                  <td width=""80"" align=""right"" valign=""middle"" bgcolor=""#f7f7f7"" style=""font-family: Tahoma; font-size: 12px; font-weight: bold; color: #b50005;"">"& ChinaQJLanguageTxt278 &"</td>"&VbCrLf
    Response.Write "                  <td width=""272"" align=""left"" valign=""middle"" style=""font-family: Tahoma; font-size: 12px; color: #666666; padding-left: 8px;""><strong>"& ChinaQJ_Company &"</strong></td>"&VbCrLf
    Response.Write "                  <td width=""80"" align=""right"" valign=""middle"" bgcolor=""#f7f7f7"" style=""font-family: Tahoma; font-size: 12px; color: #444444;"">"& ChinaQJLanguageTxt279 &"</td>"&VbCrLf
    Response.Write "                  <td width=""160"" align=""left"" valign=""middle"" style=""font-family: Tahoma; font-size: 12px; color: #666666; padding-left: 8px;"">"& ChinaQJ_User &"</td>"&VbCrLf
    Response.Write "                </tr>"&VbCrLf
    Response.Write "                <tr height=""25"">"&VbCrLf
    Response.Write "                  <td width=""80"" align=""right"" valign=""middle"" bgcolor=""#f7f7f7"" style=""font-family: Tahoma; font-size: 12px;"">"& ChinaQJLanguageTxt280 &"</td>"&VbCrLf
    Response.Write "                  <td width=""272"" align=""left"" valign=""middle"" style=""font-family: Tahoma; font-size: 12px; color: #666666; padding-left: 8px;"">"& ChinaQJ_Address &"</td>"&VbCrLf
    Response.Write "                  <td width=""80"" align=""right"" valign=""middle"" bgcolor=""#f7f7f7"" style=""font-family: Tahoma; font-size: 12px; color: #444444;"">"& ChinaQJLanguageTxt281 &"</td>"&VbCrLf
    Response.Write "                  <td width=""160"" align=""left"" valign=""middle"" style=""font-family: Tahoma; font-size: 12px; color: #666666; padding-left: 8px;"">"& ChinaQJ_Tel &"</td>"&VbCrLf
    Response.Write "                </tr>"&VbCrLf
    Response.Write "                <tr height=""25"">"&VbCrLf
    Response.Write "                  <td width=""80"" align=""right"" valign=""middle"" bgcolor=""#f7f7f7"" style=""font-family: Tahoma; font-size: 12px;"">"& ChinaQJLanguageTxt282 &"</td>"&VbCrLf
    Response.Write "                  <td width=""272"" align=""left"" valign=""middle"" style=""font-family: Tahoma; font-size: 12px; color: #666666; padding-left: 8px;"">"& ChinaQJ_Fax &"</td>"&VbCrLf
    Response.Write "                  <td width=""80"" align=""right"" valign=""middle"" bgcolor=""#f7f7f7"" style=""font-family: Tahoma; font-size: 12px; color: #444444;"">"& ChinaQJLanguageTxt283 &"</td>"&VbCrLf
    Response.Write "                  <td width=""160"" align=""left"" valign=""middle"" style=""font-family: Tahoma; font-size: 12px; color: #666666; padding-left: 8px;""><a href="""& ChinaQJ_Url &""" target=""_blank"">"& ChinaQJ_Url &"</a></td>"&VbCrLf
    Response.Write "                </tr>"&VbCrLf
    Response.Write "                <tr height=""25"">"&VbCrLf
    Response.Write "                  <td width=""80"" align=""right"" valign=""middle"" bgcolor=""#f7f7f7"" style=""font-family: Tahoma; font-size: 12px;"">"& ChinaQJLanguageTxt284 &"</td>"&VbCrLf
    Response.Write "                  <td width=""272"" align=""left"" valign=""middle"" style=""font-family: Tahoma; font-size: 12px; color: #666666; padding-left: 8px;"">"& ChinaQJ_Zip &"</td>"&VbCrLf
    Response.Write "                  <td width=""80"" align=""right"" valign=""middle"" bgcolor=""#f7f7f7"" style=""font-family: Tahoma; font-size: 12px; color: #444444;""></td>"&VbCrLf
    Response.Write "                  <td width=""160"" align=""left"" valign=""middle"" style=""font-family: Tahoma; font-size: 12px; color: #666666; padding-left: 8px;""></td>"&VbCrLf
    Response.Write "                </tr>"&VbCrLf
    Response.Write "                <tr height=""25"">"&VbCrLf
    Response.Write "                  <td width=""80"" align=""right"" valign=""middle"" bgcolor=""#f7f7f7"" style=""font-family: Tahoma; font-size: 12px;"">"& ChinaQJLanguageTxt285 &"</td>"&VbCrLf
    Response.Write "                  <td width=""272"" align=""left"" valign=""middle"" colspan=""3"" style=""font-family: Tahoma; font-size: 12px; color: #666666; line-height: 200%; padding-left: 8px;"">"& ChinaQJ_Demo &"</td>"&VbCrLf
    Response.Write "                </tr>"&VbCrLf
    Response.Write "              </table>"&VbCrLf
    Response.Write "              <br />"&VbCrLf
    rs.movenext
    Loop
    Response.Write "              <center><object classid=""clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"" codebase=""http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,28,0"" width=""400"" height=""320"">"&VbCrLf
    Response.Write "                <param name=""movie"" value=""swf/map.swf"" />"&VbCrLf
    Response.Write "                <param name=""quality"" value=""high"" />"&VbCrLf
    Response.Write "                <param name=""wmode"" value=""opaque"" />"&VbCrLf
    Response.Write "                <embed src=""swf/map.swf"" quality=""high"" wmode=""opaque"" pluginspage=""http://www.adobe.com/shockwave/download/download.cgi?P1_Prod_Version=ShockwaveFlash"" type=""application/x-shockwave-flash"" width=""400"" height=""320""></embed>"&VbCrLf
    Response.Write "              </object></center>"&VbCrLf
    End If
    rs.close
    set rs=Nothing
end Function

function ChinaQJNetWork()
    Response.Write "              <object classid=""clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"" codebase=""http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,28,0"" width=""400"" height=""320"">"&VbCrLf
    Response.Write "                <param name=""movie"" value=""" & StylePath & "map.swf"" />"&VbCrLf
    Response.Write "                <param name=""quality"" value=""high"" />"&VbCrLf
    Response.Write "                <param name=""wmode"" value=""opaque"" />"&VbCrLf
    Response.Write "                <embed src=""" & StylePath & "/map.swf"" quality=""high"" wmode=""opaque"" pluginspage=""http://www.adobe.com/shockwave/download/download.cgi?P1_Prod_Version=ShockwaveFlash"" type=""application/x-shockwave-flash"" width=""400"" height=""320""></embed>"&VbCrLf
    Response.Write "              </object>"&VbCrLf
end Function

Function ChinaQJ_Form()
    sql = "select * from ChinaQJ_Form_Q where ClassID = " & ID & " and ChinaQJ_FormView = 1 order by ChinaQJ_FormSort asc,ID asc"
    Set rs = Server.CreateObject("adodb.recordset")
    rs.Open sql, conn, 1, 1
    If rs.EOF Then Url_Return "暂无相关数据！"
    UForm = 0
    Response.Write "        <table width=""100%"" border=""0"" align=""center"" cellpadding=""3"" cellspacing=""5"">"&vbCrLf
    Response.Write "          <form action=""?action=Save&ID="&ID&""" method=""post"" name=""ChinaQJForm"" ID=""ChinaQJForm"">"&vbCrLf
    Do While Not rs.EOF
        UForm = UForm + 1
        ChinaQJ_FormV = "a_"&rs("ID")
        If rs("ChinaQJ_FormMust") = 1 Then ChinaQJ_FormStars = "<font color=""red"">* 必填</font>" Else ChinaQJ_FormStars = ""
        Response.Write "              <tr>"&vbCrLf
        Response.Write "                <td width=""200"" align=""right"">"&rs("ChinaQJ_FormTitle")&"：</td>"&vbCrLf
        Response.Write "                <td>"
        Select Case CStr(rs("ChinaQJ_FormType"))
            Case 1
                ChinaQJ_FormArr = Split(rs("ChinaQJ_FormContent"), "|")
                For i = LBound(ChinaQJ_FormArr) To UBound(ChinaQJ_FormArr)
                    Response.Write "<input type=""radio"" name="""&ChinaQJ_FormV&""" value="""&ChinaQJ_FormArr(i)&""" class=""ChinaQJInput"" />"&ChinaQJ_FormArr(i)&""
                Next
                Response.Write " "&ChinaQJ_FormStars&"<br />" & vbCrLf
            Case 2
                ChinaQJ_FormArr = Split(rs("ChinaQJ_FormContent"), "|")
                For i = LBound(ChinaQJ_FormArr) To UBound(ChinaQJ_FormArr)
                    Response.Write "<input type=""checkbox"" name="""&ChinaQJ_FormV&""" value="""&ChinaQJ_FormArr(i)&""" class=""ChinaQJInput"" />"&ChinaQJ_FormArr(i)&""
                Next
                Response.Write " "&ChinaQJ_FormStars&"<br />" & vbCrLf
            Case 3
                Response.Write "<select name="""&ChinaQJ_FormV&""" style=""width: 35%;"">" & vbCrLf
                ChinaQJ_FormArr = Split(rs("ChinaQJ_FormContent"), "|")
                For i = LBound(ChinaQJ_FormArr) To UBound(ChinaQJ_FormArr)
                    Response.Write "<option value="""&ChinaQJ_FormArr(i)&""">"&ChinaQJ_FormArr(i)&"</option>"
                Next
                Response.Write "</select>"
                Response.Write " "&ChinaQJ_FormStars&"<br />" & vbCrLf
            Case 4
                Response.Write "<input name="""&ChinaQJ_FormV&""" type=""text"" value="""" class=""ChinaQJText"" />"
                Response.Write " "&ChinaQJ_FormStars&"<br />" & vbCrLf
            Case 5
                Response.Write "<textarea name="""&ChinaQJ_FormV&""" style=""width: 85%; height: 120px;""></textarea>"
                Response.Write " "&ChinaQJ_FormStars&"<br />" & vbCrLf
            Case Else Url_Return "参数错误！"
        End Select
        rs.MoveNext
        Response.Write "                </td>"&vbCrLf
        Response.Write "              </tr>"&vbCrLf
    Loop
    Response.Write "              <tr>"&vbCrLf
    Response.Write "                <td align=""right"">&nbsp;</td>"&vbCrLf
    Response.Write "                <td><input name=""Submit"" type=""submit"" value=""立即提交信息"" /><input name=""ClassID"" type=""hidden"" value="""&ID&""" /></td>"&vbCrLf
    Response.Write "              </tr>"&vbCrLf
    Response.Write "              </form>"&vbCrLf
    Response.Write "            </table>"&vbCrLf
End Function

Function HTMLEncode(fString)
    If Not IsNull(fString) Then
        fString = Replace(fString, ">", "&gt;")
        fString = Replace(fString, "<", "&lt;")
        fString = Replace(fString, Chr(13), "<br />")
        fString = Replace(fString, Chr(10), "&nbsp;")
        HTMLEncode = fString
    End If
End Function

Sub Url_Return(ChinaQJ_String)
    response.Write "<script language=""JavaScript"">alert('" & ChinaQJ_String & "');" & "history.back()" & "</script>"
    Response.End()
End Sub

Sub Url_Go(ChinaQJ_String, ChinaQJ_Url)
    response.Write "<script language=""JavaScript"">alert('" & ChinaQJ_String & "');window.location.href='" & ChinaQJ_Url & "';</script>"
    Response.End()
End Sub

Function GetIP()
    GetIP = Request.ServerVariables("http_x_forwarded_for")
    If GetIP = "" Then GetIP = (Request.ServerVariables("remote_addr"))
End Function

Function ChinaQJKeyListWebLocation()
    ChinaQJKeyListWebLocation = "&nbsp;" & ChinaQJLanguageTxt19 & "：<a href=""" & SysRootDir & LanguageDirectory & """ class=""agray"">" & ChinaQJLanguageTxt20 & "</a> - <a href=""" & SysRootDir & LanguageDirectory & "/KeyList.Asp"" class=""agray"">" & ChinaQJLanguageTxt304 & "</a>" & vbCrLf
End Function

Function ChinaQJKeyListWebContent(DataFrom, ID)
    Dim rs, sql
    Dim IDCount
    Dim pages
    pages = 20
    Dim pagec
    Dim page
    If Request("Page") = "" Then
        page = 1
    Else
        page = CLng(Request("Page"))
    End If
    Dim pagenc
    pagenc = 100
    Dim pagenmax
    Dim pagenmin
    Dim pageprevious
    Dim pagenext
    datafrom = "ChinaQJ_Key"
    ClassSeo = "KeyList"
    Dim sqlid
    Dim Myself, PATH_INFO, QUERY_STRING
    PATH_INFO = Request.ServerVariables("PATH_INFO")
    QUERY_STRING = Request.ServerVariables("QUERY_STRING")'
    If QUERY_STRING = "" Then
        Myself = PATH_INFO & "?"
    ElseIf InStr(PATH_INFO & "?" & QUERY_STRING, "Page=") = 0 Then
        Myself = PATH_INFO & "?" & QUERY_STRING & "&"
    Else
        Myself = Left(PATH_INFO & "?" & QUERY_STRING, InStr(PATH_INFO & "?" & QUERY_STRING, "Page=") -1)
    End If
    Dim i
    sql = "Select Count(ID) As IDCount From [" & datafrom & "]"
    Set rs = Server.CreateObject("Adodb.Recordset")
    rs.Open sql, conn, 0, 1
    IDCount = rs("IDCount")
    If(IDCount > 0) Then
    If(IDCount Mod pages = 0)Then
    pagec = Int(IDCount / pages)
Else
    pagec = Int(IDCount / pages) + 1
End If
sql = "Select ID From [" & datafrom & "] where ViewFlag='"&Language&"'"
Set rs = Server.CreateObject("Adodb.Recordset")
rs.Open sql, conn, 1, 1
rs.pagesize = pages
If page < 1 Then page = 1
If page > pagec Then page = pagec
If pagec > 0 Then rs.absolutepage = page
For i = 1 To rs.pagesize
    If rs.EOF Then Exit For
    If(i = 1)Then
    sqlid = rs("ID")
Else
    sqlid = sqlid & "," & rs("ID")
End If
rs.movenext
Next
End If
If(IDCount > 0 And sqlid <> "") Then
sql = "Select * From [" & datafrom & "] Where ID IN(" & sqlid & ") " & taxis
Set rs = Server.CreateObject("Adodb.Recordset")
rs.Open sql, conn, 1, 1
Response.Write "<table width=""98%"" border=""0"" cellspacing=""0"" cellpadding=""0"">" & vbCrLf
Response.Write "  <tr height=""32"">" & vbCrLf
Response.Write "    <td width=""550"" style=""color:#FFFFFF; font-weight: bold; background: url(" & StylePath & "split.gif) no-repeat right center; background-color: #abacaf;""  align=""left"">&nbsp;&nbsp;&nbsp;&nbsp;" & ChinaQJLanguageTxt42 & "</td>" & vbCrLf
Response.Write "  </tr>" & vbCrLf
While Not rs.EOF
    If ISHTML = 1 Then
        AutoLink = "" & KeysName & Separated & rs("ID") & "." & HTMLName & ""
    Else
        AutoLink = "KeyView.Asp?ID=" & rs("ID") & ""
    End If
    Set rs1 = Server.CreateObject("Adodb.Recordset")
    sql = "Select KeyIdeaName"&Language&" From ChinaQJ_KeyIdea Where ID = " & Cint(rs("KeyName")) & ""
    rs1.Open sql, conn, 1, 1
    If Not rs1.EOF Then
        KeyIdeaName = Replace(rs1(0), "{关键字标签}", rs("Content"))
    End If
    rs1.Close
    Set rs1 = Nothing
    Response.Write "  <tr height=""28"">" & vbCrLf
    Response.Write "    <td style=""background: url(" & StylePath & "bg2.gif) repeat-x left bottom;""  align=""left"">&nbsp;<img src=""" & StylePath & "arr.gif"" width=""11"" height=""14"" align=""absmiddle"" />&nbsp;&nbsp;<a href=""" & AutoLink & """>" & KeyIdeaName & "</a></td>" & vbCrLf
    Response.Write "  </tr>" & vbCrLf
    rs.movenext
Wend
Response.Write "</table>" & vbCrLf
Else
    Response.Write "<center>" & ChinaQJLanguageTxt7 & "</center>"
    Exit Function
End If
  Response.Write "<div class=""page"">"&VbCrLf
  Response.Write ""&ChinaQJLanguageTxt44&"<strong style=""color:red"">"&idcount&"</strong>"&ChinaQJLanguageTxt45&"&nbsp;&nbsp;&nbsp;" & vbCrLf
  pagenmin=page-pagenc
  pagenmax=page+pagenc
  if(pagenmin<1) then pagenmin=1
%>
    <span id="page">
<%
Sortid=Request("Sortid")
If ISHTML = 1 Then
If Sortid="" then
%>
        <a href="<%= ClassSeo %><%= Separated %>1.<%= HTMLName %>"><%= ChinaQJLanguageTxt313 %></a>
<% If page>1 Then %>
        <a href="<%= ClassSeo %><%= Separated %><%= page-1 %>.<%= HTMLName %>"><%= ChinaQJLanguageTxt314 %></a>
<% Else %>
        <a href="<%= ClassSeo %><%= Separated %>1.<%= HTMLName %>"><%= ChinaQJLanguageTxt313 %></a>
<% End If %>
<%
  if(pagenmax>pagec) then pagenmax=pagec
  for i = pagenmin to pagenmax
    if(i=page) then
%>
        <a href="<%= ClassSeo %><%= Separated %><%= i %>.<%= HTMLName %>" class='page_click' ><%= i %></a>
<% Else %>
        <a href="<%= ClassSeo %><%= Separated %><%= i %>.<%= HTMLName %>" class='' ><%= i %></a>
<%
End If
Next
%>
<% If page<pagenmax Then %>
        <a href="<%= ClassSeo %><%= Separated %><%= page+1 %>.<%= HTMLName %>"><%= ChinaQJLanguageTxt315 %></a>
<% Else %>
        <a href="<%= ClassSeo %><%= Separated %><%= pagenmax %>.<%= HTMLName %>"><%= ChinaQJLanguageTxt315 %></a>
<% End If %>
        <a href="<%= ClassSeo %><%= Separated %><%= pagenmax %>.<%= HTMLName %>"><%= ChinaQJLanguageTxt316 %></a>
<% Else %>
        <a href="<%= ClassSeo %><%= Separated %><%= Sortid %><%= Separated %>1.<%= HTMLName %>"><%= ChinaQJLanguageTxt313 %></a>
<% If page>1 Then %>
        <a href="<%= ClassSeo %><%= Separated %><%= Sortid %><%= Separated %><%= page-1 %>.<%= HTMLName %>"><%= ChinaQJLanguageTxt314 %></a>
<% Else %>
        <a href="<%= ClassSeo %><%= Separated %><%= Sortid %><%= Separated %>1.<%= HTMLName %>"><%= ChinaQJLanguageTxt314 %></a>
<% End If %>
<%
  if(pagenmax>pagec) then pagenmax=pagec
  for i = pagenmin to pagenmax
    if(i=page) then
%>
        <a href="<%= ClassSeo %><%= Separated %><%= Sortid %><%= Separated %><%= i %>.<%= HTMLName %>" class='page_click' ><%= i %></a>
<% Else %>
        <a href="<%= ClassSeo %><%= Separated %><%= Sortid %><%= Separated %><%= i %>.<%= HTMLName %>" class='' ><%= i %></a>
<%
End If
Next
%>
<% If page<pagenmax Then %>
        <a href="<%= ClassSeo %><%= Separated %><%= Sortid %><%= Separated %><%= page+1 %>.<%= HTMLName %>"><%= ChinaQJLanguageTxt315 %></a>
<% Else %>
        <a href="<%= ClassSeo %><%= Separated %><%= Sortid %><%= Separated %><%= pagenmax %>.<%= HTMLName %>"><%= ChinaQJLanguageTxt315 %></a>
<% End If %>
        <a href="<%= ClassSeo %><%= Separated %><%= Sortid %><%= Separated %><%= pagenmax %>.<%= HTMLName %>"><%= ChinaQJLanguageTxt316 %></a>
<% End If %>
<% Else %>
        <a href="<%= myself %>Page=1"><%= ChinaQJLanguageTxt313 %></a>
<% If page>1 Then %>
        <a href="<%= myself %>Page=<%= page-1 %>"><%= ChinaQJLanguageTxt314 %></a>
<% Else %>
        <a href="<%= myself %>Page=1"><%= ChinaQJLanguageTxt314 %></a>
<% End If %>
<%
  if(pagenmax>pagec) then pagenmax=pagec
  for i = pagenmin to pagenmax
    if(i=page) then
%>
        <a href="<%= myself %>Page=<%= i %>" class='page_click' ><%= i %></a>
<% Else %>
        <a href="<%= myself %>Page=<%= i %>" class='' ><%= i %></a>
<%
End If
Next
%>
<% If page<pagenmax Then %>
        <a href="<%= myself %>Page=<%= page+1 %>"><%= ChinaQJLanguageTxt315 %></a>
<% Else %>
        <a href="<%= myself %>Page=<%= pagenmax %>"><%= ChinaQJLanguageTxt315 %></a>
<% End If %>
        <a href="<%= myself %>Page=<%= pagenmax %>"><%= ChinaQJLanguageTxt316 %></a>
<% End If %>
    </span>
<%
  Response.Write "</div>"&VbCrLf
rs.Close
Set rs = Nothing
End Function

Function ChinaQJKeyWebLocation()
    ChinaQJKeyWebLocation = "&nbsp;" & ChinaQJLanguageTxt19 & "：<a href=""" & SysRootDir & LanguageDirectory & """ class=""agray"">" & ChinaQJLanguageTxt20 & "</a> - <a href=""KeyList.Asp"" class=""agray"">" & ChinaQJLanguageTxt304 & "</a> - " & KeyIdeaName & "" & vbCrLf
End Function

Function ChinaQJKeyDetail()
    Response.Write "<table width=""100%"" border=""0"" cellspacing=""0"" cellpadding=""0"" align=""center"">" & vbCrLf
    Response.Write "    <tr>" & vbCrLf
    Response.Write "    <td><table width=""100%"" border=""0"" cellspacing=""0"" cellpadding=""0"">" & vbCrLf
    Response.Write "              <tr>" & vbCrLf
    Response.Write "                <td width=""30"" height=""36""><img src=""" & StylePath & "title_bg1.gif"" width=""30"" height=""36"" /></td>" & vbCrLf
    Response.Write "                <td align=""center"" background=""" & StylePath & "title_bg_center.jpg"" style=""color: #000000; font-size: 16px; font-weight: bold;""><h1>" & KeyIdeaName & "</h1></td>" & vbCrLf
    Response.Write "                <td width=""30""><img src=""" & StylePath & "title_bg2.gif"" width=""30"" height=""36"" /></td>" & vbCrLf
    Response.Write "              </tr>" & vbCrLf
    If Request("page") = "" Then
        pageNum = 0
    Else
        pageNum = Request("page")
    End If
    Response.Write "              <tr>" & vbCrLf
    Response.Write "                <td><img src=""" & StylePath & "title_bg3.gif"" width=""30"" height=""14"" /></td>" & vbCrLf
    Response.Write "                <td background=""" & StylePath & "title_bg_center2.jpg"">&nbsp;</td>" & vbCrLf
    Response.Write "                <td><img src=""" & StylePath & "title_bg4.gif"" width=""30"" height=""14"" /></td>" & vbCrLf
    Response.Write "              </tr>" & vbCrLf
    Response.Write "            </table></td>" & vbCrLf
    Response.Write "    </tr>" & vbCrLf
    Response.Write "    <tr>" & vbCrLf
    Response.Write "      <td height=""20"">&nbsp;</td>" & vbCrLf
    Response.Write "    </tr>" & vbCrLf
    Response.Write "    <tr>" & vbCrLf
    Response.Write "      <td align=""left"" style=""line-height: 25px; font-size: 12px; padding-left: 8px; padding-right: 8px;"" class=""SiteLink"">" & vbCrLf
    ContentStr = Split(KeyIdeaContent, "{＄html_Paging＄}")
    For i = pageNum To pageNum
        Response.Write "" & ProcessSitelink(ContentStr(i)) & ""
    Next
    Response.Write "      </td>" & vbCrLf
    Response.Write "    </tr>" & vbCrLf
    Response.Write "    <tr>" & vbCrLf
    Response.Write "      <td height=""20"" align=""right"" style=""padding-right: 18px"">" & vbCrLf
%>
    <%=ChinaQJLanguageTxt250%><%For p = 0 to ubound(ContentStr)%> <a href="KeyView.Asp?ID=<%=Trim(Request("ID"))%>&page=<%=p%>"><font color="red"><%=p+1%></font></a> <%Next%><%=ChinaQJLanguageTxt50%>
    <%
Response.Write "      </td>" & vbCrLf
Response.Write "    </tr>" & vbCrLf
if KeyIdeaTheTags<>"" then
Response.Write "    <tr>" & vbCrLf
Response.Write "      <td height=""25"" align=""right"" style=""padding-left: 8px; padding-right: 8px;"">" & vbCrLf
Response.Write "      <font color=""#005AA0"">Tags：</font>" & vbCrLf
TheTags = Split(KeyIdeaTheTags, ",")
For i = 0 To UBound(TheTags)
    Response.Write "<a href=""Search.Asp?Range=News&Keyword=" & TheTags(i) & """>"
    Response.Write "<font color=""#CC3C3C""><u>"
    Response.Write TheTags(i) & ""
    Response.Write "</u></font>"
    Response.Write "</a> "
Next
Response.Write "      </td>" & vbCrLf
Response.Write "    </tr>" & vbCrLf
end if
Response.Write "</table>" & vbCrLf
End Function
%>