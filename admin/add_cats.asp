<!--#include file="lib/AdminInIt.asp"-->
<%
'这个文件用来添加子类和顶级类
'cat如果为0则添加顶级类，不为0则为这个分类的父id
dim parent_id:parent_id=G("parent_id")
if G("act")="add" then
	cat_name=G("cat_name")
	csort=G("sort")
	type_id=G("type_id")
	cat_show=G("cat_show")
	cat_seotitle=G("cat_seotitle")
	cat_seokeys=G("cat_seokeys")
	cat_seodescr=G("cat_seodescr")
	cat_content=G("cat_content")
	cat_index=G("cat_index")
	cat_list=G("cat_list")
	cat_article=G("cat_article")
	dim cat_pic:cat_pic=G("cat_pic")
	'db.query("insert into "&suffix&"cats(parent_id,cat_name,type_id,[sort],cat_show,cat_pic) values("&parent_id&",'"&cat_name&"',"&type_id&","&csort&","&cat_show&","&cat_pic&")")
	arr=array("parent_id:"&parent_id,"cat_name:"&cat_name,"type_id:"&type_id,"sort:"&csort,"cat_show:"&cat_show,"cat_pic:"&cat_pic,"cat_seotitle:"&cat_seotitle,"cat_seokeys:"&cat_seokeys,"cat_seodescr:"&cat_seodescr,"cat_content:"&cat_content,"cat_article:"&cat_article)
	result=db.AddRecord("kl_cats",arr)
	if result<>0 then
		AlertMsg("添加成功!")
		echo "<script>window.history.go(-1);</script>"
	end if
end if
'Generate the page
if parent_id<>0 then
set rs=db.query("select cat_name from "&suffix&"cats where cat_id="&parent_id)
tpl.setvariable "parent_id",parent_id
tpl.setvariable "cat_name",rs("cat_name")&""
else
tpl.setvariable "cat_name","无"
tpl.setvariable "parent_id",parent_id
end if
tpl.setvariable "typeidsel",getContentTypeSel()
'Generate the page
tpl.Parse
'Destroy our objects
set tpl = nothing

'////////////////////////////////////////////////////////本页函数库///////////////////////////////////////////////////////////

%>