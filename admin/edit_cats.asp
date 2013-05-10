<!--#include file="lib/AdminInIt.asp"-->
<%
dim cat_id:cat_id=G("cat_id")
if G("act")="updtcat" then
	dim cat_name:cat_name=G("cat_name")
	dim csort:csort=G("sort")
	dim type_id:type_id=G("type_id")
	dim cat_show:cat_show=G("cat_show")
	dim cat_pic:cat_pic=G("cat_pic")
	'删除原来的图片
	set temrs=db.query("select cat_pic from kl_cats where cat_id="&cat_id)
	tempic=trim(temrs("cat_pic")&"")
	set temrs=nothing
	if cat_pic<>"" and trim(cat_pic)<>tempic then
			DeleteFile(tempic )
	end if
	
	result=db.UpdateRecord("kl_cats","cat_id="&cat_id,array("cat_name:"&cat_name,"type_id:"&type_id,"sort:"&csort,"cat_show:"&cat_show,"cat_pic:"&cat_pic))
	'db.query("insert into "&suffix&"cats(parent_id,cat_name,type_id,[sort]) values("&parent_id&",'"&cat_name&"',"&type_id&","&csort&")")
	if result<>0 then
	AlertMsg("分类更新成功!")
	echo "<script>window.location=""cats_list.asp"";</script>"
	end if
end if
'Generate the page
set rs=db.query("select cat_name,sort,cat_show,cat_pic from "&suffix&"cats where cat_id="&cat_id)
tpl.setvariable "cat_id",cat_id
tpl.setvariable "cat_name",rs("cat_name")&""
tpl.setvariable "cat_show",rs("cat_show")&""
tpl.setvariable "sort",rs("sort")&""
tpl.setvariable "cat_pic",rs("cat_pic")&""
tpl.setvariable "typeidsel",getContentTypeSel()
tpl.Parse
'Destroy our objects
set tpl = nothing
%>