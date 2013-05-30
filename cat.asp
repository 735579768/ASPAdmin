<!--#include file="lib/init.asp"-->
<!--#include file="lib/page.class.asp"-->
<%
catid=G("cat_id")
if catid="" then reurl("/") end if
'设定指定的模板
tpl.SetTemplateFile getCatIndexTpl(catid)
'设置本分类中的信息
setTplVarBySql("select * from kl_cats where cat_id="&catid)

'输出本分类中的信息列表
sql="select * from kl_archives as a inner join kl_cats as b on a.cat_id=b.cat_id where a.cat_id="&catid&" or b.parent_id="&catid&" order by fbdate desc "
loopBlockpage "list",sql,6

tpl.Parse
'Destroy our objects
set tpl = nothing
%>