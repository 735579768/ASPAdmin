<!--#include file="../lib/InIt.asp"-->
<%
'	oldtpl.SetTemplateFile "login.html" '设置模板文件
'	oldtpl.SetVariable "adminDir","/"
'	oldtpl.Parse
'	'Destroy our objects
'	set newtpl = nothing
	tpl.assign "adminDir","admin/"
	tpl.p_tpl_dir=TPL_PATH
	tpl.display("login.html")
%>