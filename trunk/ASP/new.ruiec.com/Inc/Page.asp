<%
Class Sdcms_Page

	Private Get_Conn,Get_PageNum,Get_PageSize,Get_Table,Get_Key,Get_Field,Get_Where,Get_Order,This_Page
	Private Get_PageStart,Get_PageEnd,Rs
	'Private TotalNum
	Dim TotalNum,TotalPageSize
	
	Private Sub Class_Initialize()
		Get_PageSize=20
		Get_PageEnd=""
	End Sub
	
	Private Sub Class_Terminate()
		Closedb
	End Sub
	
	Public Property Let Conn(ByVal t0)
		Set Get_Conn=t0
	End Property
	
	Public Property Let Pagenum(ByVal t0)
		Get_PageNum=t0
	End Property
	
	Public Property Get Pagenum
		PageNum=Get_PageNum
	End Property
	
	Public Property Let PageSize(ByVal t0)
		Get_PageSize=t0
	End Property
	
	Public Property Get PageSize
		PageSize=Get_PageSize
	End Property
	
	Public Property Let Table(ByVal t0)
		Get_Table=t0
	End Property
	
	Public Property Let Key(ByVal t0)
		Get_Key=t0
	End Property
	
	Public Property Let Field(ByVal t0)
		Get_Field=t0
	End Property
	
	Public Property Let Where(ByVal t0)
		Get_Where=t0
	End Property
	
	Public Property Get Where
		IF Len(Get_Where)>0 Then Where="Where "&Get_Where Else Where=Get_Where
	End Property
	
	Public Property Let Order(ByVal t0)
		Get_Order=t0
	End Property
	
	Public Property Get Order
		IF Len(Get_Order)>0 Then Order="Order By "&Get_Order Else Order=Get_Order
	End Property
	
	Public Property Let PageStart(ByVal t0)
		Get_PageStart=t0
	End Property
	
	Public Property Get PageEnd
		PageEnd=Get_PageEnd
	End Property
	
	Public Property Let PageEnd(ByVal t0)
		Get_PageEnd=t0
	End Property
	
	Public Property Get PageStart
		PageStart=Get_PageStart
	End Property
	
	Public Property Get Show
		Dim Sql
		TotalNum=Get_Conn.Execute("Select Count("&Get_Key&") From "&Get_Table&" "&Where&"")(0)'总记录数
		DbQuery=DbQuery+1
		TotalPageSize=Abs(Int(-Abs(TotalNum/PageSize)))
		On Error Resume Next
		Set Rs=Server.CreateObject("Adodb.Recordset")
		Rs.PageSize=PageSize
		This_Page=PageNum
		IF Clng(This_Page)>Clng(TotalPageSize) Then This_Page=Clng(TotalPageSize)
		Sql="Select "&Get_Field&" From "&Get_table&" "&Where&"  "&Order&""
		Rs.Open Sql,Get_Conn,1,1
		Rs.AbsolutePosition=Rs.AbsolutePosition+((Abs(This_Page)-1)*PageSize)
		Set Show=Rs
		DbQuery=DbQuery+1
	End Property
	
	Public Function PageList
		Dim Page_List:Page_List=Empty
		IF TotalNum>0 Then
			IF Pagenum>TotalPageSize Then Pagenum=TotalPageSize
			Dim iBegin,iEnd,iCur,I
			iCur=Pagenum'当前页
			iBegin=iCur
			iEnd=iCur
			IF iCur>TotalPageSize Then iCur=TotalPageSize
			IF iEnd>TotalPageSize Then iEnd=TotalPageSize
			I=6'每次总数量
			Page_List=Page_List&"<div class=""pages"">&nbsp;&nbsp;总数：<font color='red'>"&TotalNum&"</font>"
			Do While True 
				IF iBegin>1 Then 
					iBegin=iBegin-1
					i=i-1  
				End If 
				IF I>1 And iEnd<TotalPageSize Then
					iEnd=iEnd+1
					I=I-1
				End If 
				IF (iBegin<=1 And iEnd>=TotalPageSize) Or I<=1 Then Exit Do     
			Loop
			
			IF Sdcms_Mode=2 Then
				IF iBegin<>1 Then Page_List=Page_List&"<a href="""&Re(PageStart,"_","")&PageEnd&""">1..</a>"
			Else
				IF iBegin<>1 Then Page_List=Page_List&"<a href="""&PageStart&"1"&PageEnd&""">1..</a>"
			End IF
			IF iCur<>1 Then
				IF Sdcms_Mode=2 And iCur-1=1 Then
					Page_List=Page_List&"<a href="""&Replace(PageStart,"_","")&PageEnd&""">上一页</a>"
				Else
					Page_List=Page_List&"<a href="""&PageStart&(iCur-1)&PageEnd&""">上一页</a>"
				End IF
			End IF
			
			For I=iBegin To iEnd
				IF I=iCur Then 
					Page_List=Page_List&"<span class=""selected"">"&I&"</span>"
				Else
					IF Sdcms_Mode=2 And I=1 Then
						Page_List=Page_List&"<a href="""&Replace(PageStart,"_","")&PageEnd&""">"&I&"</a>"
					Else
						Page_List=Page_List&"<a href="""&PageStart&I&PageEnd&""">"&I&"</a>"
					End IF
				End If 
			Next 
			IF iCur<>TotalPageSize Then Page_List=Page_List&"<a href="""&PageStart&(iCur+1)&PageEnd&""">下一页</a>"
			IF iEnd<>TotalPageSize Then	Page_List=Page_List&"<a href="""&PageStart&TotalPageSize&PageEnd&""">.."&TotalPageSize&"</a>"

			Page_List=Page_List&"&nbsp;&nbsp;页次：<font color='red'>"&PageNum&"</font>/"&TotalPageSize&"</div>"
			
		End IF
		PageList=Page_List
	End Function

End Class
%>