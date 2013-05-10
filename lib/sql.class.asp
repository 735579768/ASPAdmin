<%
Class SqlAccess
	public rs 
	public con
	Public Property Get conn
		set conn=con
	End Property
	Public Property Let conn(s)
		set con=s
	End Property
'初始化数据库连接
	Private Sub Class_Initialize()
		set con = server.createobject("ADODB.connection") '创建数据库连接对象
		Connstr= "Provider=Microsoft.Jet.Oledb.4.0;Data Source="&Server.MapPath(Sql_Data)
		'Connstr="driver={Microsoft Access Driver (*.mdb)};dbq="&Server.MapPath(Sql_Data)
		con.Open Connstr '用来连接access
	end sub
'执行sql语句
'@param sqlstr 请求的sql语句
'返回值：如果查询有结果则一个记录集,否则返回false
'
	public function query(sqlstr)
		'set rs=createObject("adodb.recordset")
		'rs.open sqlstr,con,1,1
		set rs=conn.execute(sqlstr)
		'如果没有记录返回false
		set query=rs
	end function
End Class
%>