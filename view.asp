<!--#include file="lib/init.asp"-->
<!--#include file="inc/common.asp"-->
<%
id=G("id")
if id="" then reurl("/") end if
'添加点击数量
db.query("update kl_archives set archits=archits+1 where id="&id)
set rs=db.table("kl_archives").where("id="&id).jin("kl_cats on kl_archives.cat_id=kl_cats.cat_id").sel()
rsarr=db.rsToArr(rs)
set arcobj=rsarr(0)
tpl.assign "arcinfo",arcobj

'设定指定的模板
tplfile=getarticleTpl(id)
tpl.display(tplfile)
%>