<!--#include file="lib/AdminInIt.asp"-->
<%
'tpl.SetTemplatesDir("")
'包含文件
'Generate the page

'输出内容
'echo db.wGetRecord("kl_content_types","type_id,type_name,type_index,type_list,type_article","type_id="&type_id,"type_id desc",0)
'set rs=db.GetRecord("kl_content_types","type_id,type_name,tpl_index,tpl_list,tpl_article","type_id="&type_id,"type_id desc",0)
	if G("act")="updateadmin" then
		id=G("id")
		dim pwd:pwd=G("newpwd")
		'echo db.wUpdateRecord("kl_admin","id="&id,array("password:"&md5(pwd,32)))
		result=db.UpdateRecord("kl_admin","id="&id,array("password:"&md5(pwd,32)))
		if result<>0 then
			AlertMsg(UPDATE_SUCCESS_STR)
		end if
	end if


set rs=db.GetRecord("kl_admin","*","id="&session("admin_id"),"",0)
tpl.setvariable "id",cstr(rs("id"))
tpl.setvariable "Uname",cstr(rs("username"))
tpl.setvariable "Upwd",cstr(rs("password"))

tpl.Parse
'Destroy our objects
set tpl = nothing
%>