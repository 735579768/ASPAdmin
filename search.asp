<!--#include file="lib/init.asp"-->
<!--#include file="lib/page.class.asp"-->
<%
s=G("s")
cat_id=G("cat_id")
'设定指定的模板
sql=""
if cat_id="0" then
sql="select * from kl_archives where type_id=2 and arctitle like '%"&s&"%' order by fbdate desc"
else
sql="select * from kl_archives where cat_id="&cat_id&" and arctitle like '%"&s&"%' order by fbdate desc"
end if
loopBlockpage "list",sql,6

tpl.setVariable "s",s
tpl.Parse
'Destroy our objects
set tpl = nothing
%>