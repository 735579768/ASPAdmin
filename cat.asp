<!--#include file="lib/init.asp"-->
<!--#include file="lib/page.class.asp"-->
<%
catid=G("cat_id")
if catid="" then reurl("/") end if
'�趨ָ����ģ��
tpl.SetTemplateFile getCatIndexTpl(catid)

setTplVarBySql("select * from kl_cats where cat_id="&catid)
sql="select * from kl_archives as a inner join kl_cats as b on a.cat_id=b.cat_id where a.cat_id="&catid&" or b.parent_id="&catid&" order by fbdate desc "
loopBlockpage "list",sql,6

tpl.Parse
'Destroy our objects
set tpl = nothing
%>