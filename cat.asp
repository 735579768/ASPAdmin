<!--#include file="lib/init.asp"-->
<!--#include file="lib/page.class.asp"-->
<!--#include file="inc/common.asp"-->
<%
catid=G("catid")
if catid="" then reurl("/") end if

'查询分类信息
set rs=db.where("cat_id="&catid).table("kl_cats").top("1").sel()
cat_single=rs("cat_single")&"" 
'输出分类seo
rsarr=db.rsToArr(rs)
set catobj=rsarr(0)
tpl.assign "catinfo",catobj
'判断分类是不是单页面
if  cat_single=1 then 
	tpl.show(cstr(rs("cat_content")))
	die("")
end if

'输出分类下内容产品
set rs=db.table("kl_archives").where("cat_id="&catid).order("fbdate desc").top(12).sel()
goodslist=db.rsToArr(rs)
tpl.assign "goodslist",goodslist

'设定指定的模板
tplfile=getCatTpl(catid)
tpl.display(tplfile)
'设置本分类中的信息
'setTplVarBySql("select * from kl_cats where cat_id="&catid)
db.where("cat_id="&catid).fild("cat_single,cat_content").table("kl_cats").top("1").sel()
'输出本分类中的信息列表
'sql="select * from kl_archives as a inner join kl_cats as b on a.cat_id=b.cat_id where a.cat_id="&catid&" or b.parent_id="&catid&" order by fbdate desc "
'loopBlockpage "list",sql,6

%>