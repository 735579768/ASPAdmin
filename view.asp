<!--#include file="lib/init.asp"-->
<!--#include file="inc/common.asp"-->
<%
dim id,typeid,datatable
temid=G("id")
temarr=split(temid,"_")
if ubound(temarr)=1 then
 typeid=temarr(1)
 id=temarr(0)
end if
if ubound(temarr)=0 then id=temarr(0)
if id="" then reurl("/") end if
'查询数据表
if typeid<>"" then
set datars=db.table("kl_content_types").where("type_id="&typeid).sel()
datatable=datars("data_table")&""
set datars=nothing
else
datatable="kl_archives"
end if
'添加点击数量
db.query("update "&datatable&" set archits=archits+1 where id="&id)
set rs=db.table(datatable).fild("kl_cats.cat_id as catid,*").where("id="&id).jin("kl_cats on  "&trim(datatable)&".cat_id=kl_cats.cat_id").sel()
'设置此篇文章信息
if rs.recordcount>0 then 
	rsarr=db.rsToArr(rs)
	set arcobj=rsarr(0)
	tpl.assign "arcinfo",arcobj
else
	reurl("/") 
end if
'设定指定的模板
tplfile=getarticleTpl(id)
tpl.display(tplfile)
%>