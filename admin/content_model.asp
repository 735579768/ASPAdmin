<!--#include file="lib/AdminInIt.asp"-->
<%
'oldtpl.SetTemplatesDir("")
'包含文件
'oldtpl.setVariableFile "TOP_HTML","public/top.html"
'oldtpl.setVariableFile "FOOTER_HTML","public/footer.html"
dim type_id,type_name,tpl_index,tpl_list,tplarticle
type_id=G("type_id")
if G("act")="conmodel" then 	
	tpl_index=G("tpl_index")
	tpl_list=G("tpl_list")
	tpl_article=G("tpl_article")
	type_name=G("type_name")
	dim result:result=olddb.UpdateRecord("kl_content_types","type_id="& type_id,array("type_name:"&type_name,"tpl_index:"&tpl_index,"tpl_list:"&tpl_list,"tpl_article:"&tpl_article))
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

set rs=olddb.query("select top 1 * from kl_content_types where type_id="&type_id)
oldtpl.setvariable "type_id",cstr(rs("type_id"))
oldtpl.setvariable "type_name",cstr(rs("type_name"))
oldtpl.setvariable "tpl_index",cstr(rs("tpl_index"))
oldtpl.setvariable "tpl_list",cstr(rs("tpl_list"))
oldtpl.setvariable "tpl_article",cstr(rs("tpl_article"))

oldtpl.Parse
'Destroy our objects
set oldtpl = nothing
%>