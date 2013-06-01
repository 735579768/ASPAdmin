<!--#include file="lib/init.asp"-->
<!--#include file="lib/page.class.asp"-->
<%
catid=G("cat_id")
if catid="" then reurl("/") end if
'判断分类是不是单页面
sql="select cat_single,cat_content from kl_cats where cat_id="&catid
set rs=db.query(sql)
if  cstr(rs("cat_single"))="1" then 
	tpl.show(htmldecode(cstr(rs("cat_content"))))
	die()
end if
'设定指定的模板
tpl.SetTemplateFile getCatIndexTpl(catid)
'设置本分类中的信息
setTplVarBySql("select * from kl_cats where cat_id="&catid)

'输出本分类中的信息列表
sql="select * from kl_archives as a inner join kl_cats as b on a.cat_id=b.cat_id where a.cat_id="&catid&" or b.parent_id="&catid&" order by fbdate desc "
loopBlockpage "list",sql,6

%>