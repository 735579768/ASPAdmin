<!--#include file="lib/init.asp"-->
<%
set rs=server.CreateObject("adodb.recordset")
sql="select * from kl_comments"
rs.open sql,db.kl_conn,1,3
rs.addNew
				for each key in request.Form()
						val=G(key)
						rs(key)=val
				next
					rs("fbdate")=FormatDate(now,2)
					rs("fbip")=getIP()
rs.update
echo "<script>alert('发布成功');window.history.go(-1);</script>"
set rs=nothing
%>