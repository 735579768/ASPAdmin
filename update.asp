<!--#include file="lib/init.asp"-->
<!--#include file="lib/page.class.asp"-->
<!--#include file="inc/common.asp"-->
<%
sql="create table test_table(tet text)"
sql="alter table kl_content_types add formjsonstr text"
sql="alter table kl_content_types drop formjsonstr"
on error resume next
db.kl_conn.execute(sql)
if err.number<>0 then
echo AlertMsg("更新失败:error "&err.description)
else
echo AlertMsg("更新成功")
end if
%>