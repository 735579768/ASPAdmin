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
	cat_content=G("cat_content")
	'ɾ��ԭ����ͼƬ
	set temrs=db.query("select cat_pic from kl_cats where cat_id="&cat_id)
	tempic=trim(temrs("cat_pic")&"")
	set temrs=nothing
	if cat_pic<>"" and trim(cat_pic)<>tempic then
			DeleteFile(tempic )
	end if
	'echo db.wUpdateRecord("kl_cats","cat_id="&cat_id,array("cat_name:"&cat_name,"type_id:"&type_id,"sort:"&csort,"cat_show:"&cat_show,"cat_pic:"&cat_pic,"cat_seotitle:"&cat_seotitle,"cat_seokeys:"&cat_seokeys,"cat_seodescr:"&cat_seodescr,"cat_content:"&cat_content))
	result=db.UpdateRecord("kl_cats","cat_id="&cat_id,array("cat_name:"&cat_name,"type_id:"&type_id,"sort:"&csort,"cat_show:"&cat_show,"cat_pic:"&cat_pic,"cat_index:"&cat_index,"cat_list:"&cat_list,"cat_article:"&cat_article,"cat_seotitle:"&cat_seotitle,"cat_seokeys:"&cat_seokeys,"cat_seodescr:"&cat_seodescr,"cat_content:"&cat_content))
	'db.query("insert into "&suffix&"cats(parent_id,cat_name,type_id,[sort]) values("&parent_id&",'"&cat_name&"',"&type_id&","&csort&")")
	if result<>0 then
	AlertMsg("������³ɹ�!")
	echo "<script>window.history.go(-1);</script>"
	end if
end if
'Generate the page
set rs=db.query("select * from "&suffix&"cats as a inner join kl_content_types as b on a.type_id=b.type_id where a.cat_id="&cat_id)
cat_index=rs("cat_index")&""
cat_list=rs("cat_list")&""
cat_article=rs("cat_article")&""
if cat_index="" then cat_index=rs("tpl_index")&"" end if
if cat_list="" then cat_list=rs("tpl_list")&"" end if
if cat_article="" then cat_article=rs("tpl_article")&"" end if
setVarArr(array("cat_id:"&cat_id,"cat_name:"&rs("cat_name"),"cat_show:"&rs("cat_show"),"sort:"&rs("sort"),"cat_pic:"&rs("cat_pic"),"cat_index:"&cat_index,"cat_list:"&cat_list,"cat_article:"&cat_article,"cat_seotitle:"&rs("cat_seotitle"),"cat_seokeys:"&rs("cat_seokeys"),"cat_seodescr:"&rs("cat_seodescr"),"cat_content:"&rs("cat_content")))
tpl.setvariable "typeidsel",getContentTypeSel()
tpl.Parse
'Destroy our objects
set tpl = nothing
%>