<!--#include file="lib/AdminInIt.asp"-->
<%
dim cat_id:cat_id=G("cat_id")
if G("act")="updtcat" then
	cat_name=G("cat_name")
	csort=G("sort")
	type_id=G("type_id")
	cat_show=G("cat_show")
	cat_pic=G("cat_pic")
	cat_index=G("cat_index")
	cat_list=G("cat_list")
	cat_article=G("cat_article")
	cat_seotitle=G("cat_seotitle")
	cat_seokeys=G("cat_seokeys")
	cat_seodescr=G("cat_seodescr")
	cat_content=filtersql(G("cat_content"))
	
	if cat_index="" or cat_list="" or cat_article="" then
		set tplrs=db.query("select * from kl_content_types where type_id="&type_id)
		if cat_index="" then cat_index=tplrs("tpl_index")&""
		if cat_list="" then cat_list=tplrs("tpl_list")&""
		if cat_article="" then cat_article=tplrs("tpl_article")&""
		set tplrs=nothing
	end if
	'删除原来的图片
	set temrs=db.query("select cat_pic from kl_cats where cat_id="&cat_id)
	tempic=trim(temrs("cat_pic")&"")
	set temrs=nothing
	if cat_pic<>"" and trim(cat_pic)<>tempic then
			DeleteFile tempic
	end if
	
'echo db.wUpdateRecord("kl_cats","cat_id="&cat_id,array("cat_name:"&cat_name,"type_id:"&type_id,"sort:"&csort,"cat_show:"&cat_show,"cat_pic:"&cat_pic,"cat_index:"&cat_index,"cat_list:"&cat_list,"cat_article:"&cat_article,"cat_seotitle:"&cat_seotitle,"cat_seokeys:"&cat_seokeys,"cat_seodescr:"&cat_seodescr,"cat_content:"&cat_content))
	result=db.UpdateRecord("kl_cats","cat_id="&cat_id,array("cat_name:"&cat_name,"type_id:"&type_id,"sort:"&csort,"cat_show:"&cat_show,"cat_pic:"&cat_pic,"cat_index:"&cat_index,"cat_list:"&cat_list,"cat_article:"&cat_article,"cat_seotitle:"&cat_seotitle,"cat_seokeys:"&cat_seokeys,"cat_seodescr:"&cat_seodescr,"cat_content:"&cat_content))

	if result<>0 then
	'AlertMsg("分类更新成功!")
'	reurl("cats_list.asp")
	echo "<script>window.location='cats_list.asp';</script>"
	end if
end if
'Generate the page
sql="select a.type_id as typeid ,* from "&suffix&"cats as a inner join kl_content_types as b on a.type_id=b.type_id where a.cat_id="&cat_id
set rs=db.query(sql)
cat_index=rs("cat_index")&""
cat_list=rs("cat_list")&""
cat_article=rs("cat_article")&""
if cat_index="" then cat_index=rs("tpl_index")&"" end if
if cat_list="" then cat_list=rs("tpl_list")&"" end if
if cat_article="" then cat_article=rs("tpl_article")&"" end if
setVarArr(array("cat_index:"&cat_index,"cat_list:"&cat_list,"cat_article:"&cat_article))


setTplVarBySql(sql)

tpl.Parse
'Destroy our objects
set tpl = nothing
%>