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
'��ʼ�����ݿ�����
	Private Sub Class_Initialize()
		set con = server.createobject("ADODB.connection") '�������ݿ����Ӷ���
		Connstr= "Provider=Microsoft.Jet.Oledb.4.0;Data Source="&Server.MapPath(Sql_Data)
		'Connstr="driver={Microsoft Access Driver (*.mdb)};dbq="&Server.MapPath(Sql_Data)
		con.Open Connstr '��������access
	end sub
'ִ��sql���
'@param sqlstr �����sql���
'����ֵ�������ѯ�н����һ����¼��,���򷵻�false
'
	public function query(sqlstr)
		'set rs=createObject("adodb.recordset")
		'rs.open sqlstr,con,1,1
		set rs=conn.execute(sqlstr)
		'���û�м�¼����false
		set query=rs
	end function
End Class
%>