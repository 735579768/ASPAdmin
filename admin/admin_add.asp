<!--#include file="lib/AdminInIt.asp"-->
<%
'oldtpl.SetTemplatesDir("")
'包含文件
'Generate the page

'输出内容
'echo olddb.wGetRecord("kl_content_types","type_id,type_name,type_index,type_list,type_article","type_id="&type_id,"type_id desc",0)
'set rs=olddb.GetRecord("kl_content_types","type_id,type_name,tpl_index,tpl_list,tpl_article","type_id="&type_id,"type_id desc",0)
	if G("act")="addadmin" then
		newpwd=G("newpwd")
		uname=G("uname")
		qx_id=G("qx_id")
		nicheng=G("nicheng")
		'dump(qx_id)
		set yzrs=olddb.query("select * from kl_admin where username='"&uname&"'")
		'echo olddb.wAddRecord("kl_admin",array("username:"&uname,"qx_id:"&qx_id,"nicheng:"&nicheng,"password:"&md5(newpwd,32)))
		if yzrs.recordcount>0 then
			AlertMsg(EXISTADMIN)
		else
			result=olddb.AddRecord("kl_admin",array("username:"&uname,"qx_id:"&qx_id,"nicheng:"&nicheng,"password:"&md5(newpwd,32)))
		end if
		if result<>0 then
			AlertMsg(ADD_SUCCESS_STR)
		end if
	end if


oldtpl.setvariable "qx_idsel",getQxsel()
oldtpl.Parse
'Destroy our objects
set oldtpl = nothing
%>