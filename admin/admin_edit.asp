<!--#include file="lib/AdminInIt.asp"-->
<%
'tpl.SetTemplatesDir("")
'包含文件
'Generate the page

'输出内容
'echo db.wGetRecord("kl_content_types","type_id,type_name,type_index,type_list,type_article","type_id="&type_id,"type_id desc",0)
'set rs=db.GetRecord("kl_content_types","type_id,type_name,tpl_index,tpl_list,tpl_article","type_id="&type_id,"type_id desc",0)
id=G("id")
	if G("act")="uptadmin" then		
		dim pwd:pwd=G("newpwd")
		'echo db.wUpdateRecord("kl_admin","id="&id,array("password:"&md5(pwd,32)))
		result=db.UpdateRecord("kl_admin","id="&id,array("password:"&md5(pwd,32)))
		if result<>0 then
			AlertMsg(UPDATE_SUCCESS_STR)
		end if
	end if

set rs=db.query("select top 1 * from kl_admin where id="&id)
'初始化数据
setvararr(array("username:"&rs("username"),"nicheng:"&rs("nicheng")))
tpl.setvariable "qx_idsel",getQxsel()
tpl.Parse
'Destroy our objects
set tpl = nothing
%>