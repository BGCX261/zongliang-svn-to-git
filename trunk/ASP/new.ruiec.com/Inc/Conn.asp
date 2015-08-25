<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
<%
Option Explicit
Dim Startime,CharSet,Conn,DbQuery,SqlNowString
DbQuery=0
Startime=Timer()
Session.CodePage=936
CharSet="gb2312"
Response.CharSet=CharSet
Server.ScriptTimeOut=999999
Response.Buffer=True
%>
<!--#include file="Const.asp"-->
<!--#include file="Version.asp"-->
<!--#include file="Md5.asp"-->
<!--#include file="Function.asp"-->
<!--#include file="Templates.asp"-->
<!--#include file="Create.asp"-->
<!--#include file="Page.asp"-->
<!--#include file="PinYin.asp"-->
<%IF Len(Sdcms_CreateDate)=0 Then Go("Install/")%>