<!--#include file="lib/AdminInIt.asp"-->
<%
if G("act")="del"  then
	db.query("delete from kl_single where id="&G("id"))
end if
sql="select * from kl_single order by id desc "
loopblock "list",sql
%>