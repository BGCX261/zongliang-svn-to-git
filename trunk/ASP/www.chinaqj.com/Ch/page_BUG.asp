﻿<table width="980" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
  
  <td valign="top" width="235"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td class="leftnavtop"><%= ChinaQJLanguageTxt240 %></td>
      </tr>
      <tr>
        <td class="leftnavcenter"><div class="SortBg">
            <%ChinaQJProductFolder(0)%>
          </div></td>
      </tr>
      <tr>
        <td class="leftnavbottom1"></td>
      </tr>
      <tr>
        <td><!--#include file="Page_Left.asp" --></td>
      </tr>
    </table></td>
  <td>&nbsp;</td>
  <td valign="top" width="736">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td class="contenttop"></td>
    </tr>
    <tr>
      <td class="contentcenter"><div class="contentnav"><%=ChinaQJBUGWebLocation(GetPrevURL())%></div></td>
    </tr>
    <tr>
      <td class="contentcenter"><div align="center">
<%
	
	SQL_Query("ssss")

	If request.form("title")<>"" Then
		
		'Dim url,browser,os,ip,othercinfo,title,bugs,content,name,sex,phone,email,time,errors

		burl = request.form("url")
		bbrowser = GetUserBrowserInfo()
		bos = GetUserOSInfo()
		bip = GetUserTrueIP()
		bothercinfo = Request.ServerVariables("HTTP_USER_AGENT")
		btitle = request.form("title")
		bbugs = request.form("checkBUG")
		bcontent = request.form("Remark")
		bname = request.form("RealName")
		bsex = request.form("Sex")
		bphone = request.form("Telephone")
		bemail = request.form("Email")
		'btime = now()
		
		If btitle<>"" And bname<>"" Then

			Dim ObjDict
			Set ObjDict = Server.CreateObject("Scripting.Dictionary")
			ObjDict.Add "Url",StrReplace(burl)
			ObjDict.Add "Browser",StrReplace(bbrowser)
			ObjDict.Add "OS",StrReplace(bos)
			ObjDict.Add "IP",StrReplace(bip)
			ObjDict.Add "OtherCInfo",StrReplace(bothercinfo)
			ObjDict.Add "Title",StrReplace(btitle)
			ObjDict.Add "Bugs",StrReplace(bbugs)
			ObjDict.Add "Content",StrReplace(bcontent)
			ObjDict.Add "Name",StrReplace(bname)
			ObjDict.Add "Sex",StrReplace(bsex)
			ObjDict.Add "Phone",StrReplace(bphone)
			ObjDict.Add "Email",StrReplace(bemail)
			'ObjDict.Add "Time",StrReplace(btime)

			'Dim ObjDicts
			'Set ObjDicts = Server.CreateObject("Scripting.Dictionary")
			'ObjDicts.Add "id",10
			'ObjDicts.Add "rad",123
			'ObjDicts.Add "ViewFlagEn","Hello"
			'ObjDicts.Add "ViewFlagJp","Hello"

			'Call SQL_INSERT("beta",ObjDicts)
			
			'Response.end

			Dim bres
				bres = SQL_INSERT("ChinaQJ_Bug",ObjDict)

			'sql="INSERT INTO ChinaQJ_Bug([Url],[Browser],[OS],[IP],[OtherCInfo],[Title],[Bugs],[Content],[Name],[Sex],[Phone],[Email],[Time]) VALUES('"&StrReplace(burl)&"','"&StrReplace(bbrowser)&"','"&StrReplace(bos)&"','"&StrReplace(bip)&"','"&StrReplace(bothercinfo)&"','"&StrReplace(btitle)&"','"&StrReplace(bbugs)&"','"&StrReplace(bcontent)&"','"&StrReplace(bname)&"','"&StrReplace(bsex)&"','"&StrReplace(bphone)&"','"&StrReplace(bemail)&"','"&StrReplace(btime)&"')"
			
			'Response.write(sql)
			'Response.end

			'bres = SQL_Other(sql)

			'Response.write(bres)
			'conn.execute(sql)

			If bres>0 Then
				Response.write("<h1 style='color:#00FF00'>提交成功!谢谢您的反馈!</h1>")
				Response.write("<a href='javascript:;' onclick='window.open(""http://localhost/""); window.opener = null; window.close();'>关闭</a>")
				Response.write("<script>alert('提交成功!谢谢.');")
				Response.End
			Else
				berrors = "提交失败!请重试."
			End If
		Else
			berrors = "请填写完整!"
		End If
	End If

	If berrors<>"" Then
		Response.write("<h3 style='color:red'>"&berrors&"</h3>")
	End If
%>
		</div>
	  </td>
	</tr>
    <tr>
      <td class="contentcenter"><table width="100%" border="0" align="center" cellpadding="3" cellspacing="5">
        <form action="?" method="post" name="formBuy" id="formBuy">
		  <table>
          <tbody>
            <tr>
              <td width="200" align="right">标题：</td>
              <td>
				<input id="txt_title" name="title" type="text" value="<%=btitle%>" size="40" maxlength="255"><font color="red">*</font><br />
<%
		If GetPrevURL()<>"" Then
%>
				<input type="hidden" id="url" name="url" value="<%=GetPrevURL()%>" />
				<span style="border-color: inherit;">来自:<a href="<%=GetPrevURL()%>" title="您是来自该页面"><%=GetPrevURL()%></a>
<%
		End If
%>
			  </td>
            </tr>
			<tr>
              <td width="200" align="right">BUG：</td>
              <td>
<%
		Dim bugTags
		Set bugTags=SQL_Query("SELECT * FROM ChinaQJ_Bug_Tags")
		If bugTags.Count Then
			For i=0 To (bugTags.Count-1)
%>
				<input id="checkBUG" name="checkBUG" type="checkbox" value="<%=bugTags(""&i&"")("ID")%>" <%If InStr(bbugs,bugTags(""&i&"")("ID"))>0 Then%>checked=""<%End If%> /><%=bugTags(""&i&"")("Title")%><br />
<%
			Next
		End If
%>
			  </td>
            </tr>
            <tr>
              <td align="right">相关说明：</td>
              <td>
                <textarea name="Remark" cols="80" rows="8" id="Remark"><%=bcontent%></textarea></td>
            </tr>
            <tr>
              <td align="right">联系人：</td>
              <td><input name="RealName" type="text" id="RealName" value="<%=bname%>" size="20" maxlength="50">
                <font color="red">*</font></td>
            </tr>
            <tr>
              <td align="right">性别：</td>
              <td><input name="Sex" type="radio" value="先生" class="inputnoborder" checked="">
                先生
                <input type="radio" name="Sex" value="女士" class="inputnoborder" <%If bsex="女士" Then%>checked=""<%End If%>>
                女士 <font color="red">*</font></td>
            </tr>
            <tr>
              <td align="right">联系电话：</td>
              <td><input name="Telephone" type="text" id="Telephone" value="<%=bphone%>" size="20" maxlength="50">
                <font color="red">*</font></td>
            </tr>
            <tr>
              <td align="right">电子邮箱：</td>
              <td><input name="Email" type="text" id="Email" value="<%=bemail%>" size="30" maxlength="50"></td>
            </tr>
<%
		If "a"="b" Then
%>
            <tr>
              <td align="right">验证码：</td>
              <td><input name="CheckCode" type="text" size="6" maxlength="6">
                <a href="javascript:refreshimg()" title="看不清楚，换个图片。"><img src="../Include/CheckCode/CheckCode.Asp" name="checkcode" align="absmiddle" id="checkcode" style="border: 1px solid #ffffff"></a> <font color="red">*</font></td>
            </tr>
<%
		End If
%>
            <tr>
              <td align="right">&nbsp;</td>
              <td><input name="Submit" type="submit" style="cursor:pointer;" value="提交BUG信息" onclick="return onSub();"></td>
            </tr>
          </tbody>
        </table>
		</form>
	  </td>
    </tr>   
    <tr>
      <td class="contentbottom"></td>
    </tr>
  </table>
  </td>
  
  </tr>
  
</table>
