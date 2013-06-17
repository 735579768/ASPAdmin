<!--#include file="lib/init.asp"-->
<!--#include file="lib/page.class.asp"-->
<!--#include file="inc/common.asp"-->
<%
catid=G("catid")
if catid="" then reurl("/") end if
'查询分类信息
set rs=db.where("cat_id="&catid).table("kl_cats").top("1").sel()
cat_single=rs("cat_single")&"" 
cat_content=rs("cat_content")&"" 
'输出分类信息
rsarr=db.rsToArr(rs)
set catobj=rsarr(0)
tpl.assign "catinfo",catobj
'查询分类的子类
set rs=db.where("parent_id="&gettopcat(catid)).table("kl_cats").sel()
rsarr=db.rsToArr(rs)
tpl.assign "childcatlist",rsarr


'输出分类下内容
set rs=db.table("kl_archives").jin("kl_cats on kl_archives.cat_id=kl_cats.cat_id").where("kl_archives.cat_id="&catid&" or kl_cats.parent_id="&catid).order("fbdate desc,id desc").top(12).sel()
goodslist=db.rsToArr(rs)
tpl.assign "goodslist",goodslist




if  cat_single=1 then 
	tpl.show(cat_content)
	die("")
end if
'设定指定的模板
tplfile=getCatTpl(G("catid"))
tpl.display(tplfile)
'判断分类是不是单页面

%>