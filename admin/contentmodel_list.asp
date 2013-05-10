<!--#include file="lib/AdminInIt.asp"-->
<%
'tpl.SetTemplatesDir("")
'包含文件
'tpl.setVariableFile "TOP_HTML","public/top.html"
'tpl.setVariableFile "FOOTER_HTML","public/footer.html"
dim type_id,type_name,tpl_index,tpl_list,tplarticle
type_id=G("type_id")
if G("act")="updmodel" then 	
	tpl_index=G("tpl_index")
	tpl_list=G("tpl_list")
	tpl_article=G("tpl_article")
	type_name=G("type_name")
	dim result:result=db.UpdateRecord("kl_content_types","type_id="& type_id,array("type_name:"&type_name,"tpl_index:"&tpl_index,"tpl_list:"&tpl_list,"tpl_article:"&tpl_article))
	'echo db.wupdaterecord("kl_content_types","type_id="& type_id,array("type_name:"&type_name,"tpl_index:"&tpl_index,"tpl_list:"&tpl_list,"tpl_article:"&tpl_article))
	if result<>0 then
		AlertMsg(UPDATE_SUCCESS_STR)
	else
		AlertMsg(UPDATE_FAIL_STR)
	end if
end if
'Generate the page

'输出内容
'echo db.wGetRecord("kl_content_types","type_id,type_name,type_index,type_list,type_article","type_id="&type_id,"type_id desc",0)
'set rs=db.GetRecord("kl_content_types","type_id,type_name,tpl_index,tpl_list,tpl_article","type_id="&type_id,"type_id desc",0)

	set rs=db.query("select * from kl_content_types ")
	tpl.UpdateBlock "contentmodellist"
	do while not rs.eof
		tpl.setvariable "type_id",cstr(rs("type_id"))
		tpl.setvariable "type_name",cstr(rs("type_name"))
		tpl.setvariable "tpl_index",cstr(rs("tpl_index"))
		tpl.setvariable "tpl_list",cstr(rs("tpl_list"))
		tpl.setvariable "tpl_article",cstr(rs("tpl_article"))
		tpl.ParseBlock "contentmodellist"
	rs.movenext
	loop
	
tpl.Parse
'Destroy our objects
set tpl = nothing
%>