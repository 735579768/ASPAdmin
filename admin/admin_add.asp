<!--#include file="lib/AdminInIt.asp"-->
<%
'tpl.SetTemplatesDir("")
'�����ļ�
'Generate the page

'�������
'echo db.wGetRecord("kl_content_types","type_id,type_name,type_index,type_list,type_article","type_id="&type_id,"type_id desc",0)
'set rs=db.GetRecord("kl_content_types","type_id,type_name,tpl_index,tpl_list,tpl_article","type_id="&type_id,"type_id desc",0)
	if G("act")="addadmin" then
		newpwd=G("newpwd")
		uname=G("uname")
		qx_id=G("qx_id")
		nicheng=G("nicheng")
		'dump(qx_id)
		'echo db.wAddRecord("kl_admin",array("username:"&uname,"qx_id:"&qx_id,"nicheng:"&nicheng,"password:"&md5(newpwd,32)))
		result=db.AddRecord("kl_admin",array("username:"&uname,"qx_id:"&qx_id,"nicheng:"&nicheng,"password:"&md5(newpwd,32)))
		if result<>0 then
			AlertMsg(ADD_SUCCESS_STR)
		end if
	end if


tpl.setvariable "qx_idsel",getQxsel()
tpl.Parse
'Destroy our objects
set tpl = nothing
%>