<%
'输出首页优化内容
set rs=db.table("kl_meta").where("meta_key='cfg_system'").fild("meta_value").sel()
set obj=toObject(rs(0)&"")
'arr=toArray(rs(0)&"")
a=array("cfg_indexname","cfg_webname","cfg_arcdir","cfg_medias_dir","cfg_df_style","cfg_powerby","cfg_keywords","cfg_description","cfg_beian")
b=array(obj.cfg_indexname,obj.cfg_webname,obj.cfg_arcdir,obj.cfg_medias_dir,obj.cfg_df_style,obj.cfg_powerby,obj.cfg_keywords,obj.cfg_description,obj.cfg_beian)
set seoobj=tpl.getkeyval(a,b)
tpl.assign "indexseo",seoobj


'输出导航
set rs=db.where("cat_show=1").order("sort asc").fild("cat_id,cat_name").table("kl_cats").sel()
navlist=db.rsToArr(rs)
tpl.assign "navlist",navlist

'输出最新产品
set rs=db.table("kl_archives").order("fbdate desc").top(10).sel()
productlist=db.rsToArr(rs)
tpl.assign "productlist",productlist


'输出最新案例
set rs=db.table("kl_archives").where("cat_id=28").order("fbdate desc").top(10).sel()
anlilist=db.rsToArr(rs)
tpl.assign "anlilist",anlilist

'输出产品分类
set rs=db.table("kl_cats").where("parent_id=29").order("sort desc").sel()
catlist=db.rsToArr(rs)
tpl.assign "catlist",catlist
%>