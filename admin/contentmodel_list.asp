<!--#include file="lib/AdminInIt.asp"-->
<%
'oldtpl.SetTemplatesDir("")
'包含文件
'oldtpl.setVariableFile "TOP_HTML","public/top.html"
'oldtpl.setVariableFile "FOOTER_HTML","public/footer.html"
dim type_id,type_name,tpl_index,tpl_list,tplarticle
type_id=G("type_id")
if G("act")="updmodel" then 	
	data_table=G("data_table")
	tpl_index=G("tpl_index")
	tpl_list=G("tpl_list")
	tpl_article=G("tpl_article")
	type_name=G("type_name")
	dim result:result=olddb.UpdateRecord("kl_content_types","type_id="& type_id,array("type_name:"&type_name,"data_table:"&data_table,"tpl_index:"&tpl_index,"tpl_list:"&tpl_list,"tpl_article:"&tpl_article))
	'echo olddb.wupdaterecord("kl_content_types","type_id="& type_id,array("type_name:"&type_name,"tpl_index:"&tpl_index,"tpl_list:"&tpl_list,"tpl_article:"&tpl_article))
	if result<>0 then
		AlertMsg(UPDATE_SUCCESS_STR)
	else
		AlertMsg(UPDATE_FAIL_STR)
	end if
end if
'Generate the page

'输出内容
'echo olddb.wGetRecord("kl_content_types","type_id,type_name,type_index,type_list,type_article","type_id="&type_id,"type_id desc",0)
'set rs=olddb.GetRecord("kl_content_types","type_id,type_name,tpl_index,tpl_list,tpl_article","type_id="&type_id,"type_id desc",0)

	sql="select * from kl_content_types "
	arr=array("type_id:type_id","type_name:type_name","data_table:data_table","tpl_index:tpl_index","tpl_list:tpl_list","tpl_article:tpl_article")
	listBlock "contentmodellist",sql,arr
	
oldtpl.Parse
'Destroy our objects
set oldtpl = nothing
%>