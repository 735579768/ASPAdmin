<%
	tpl.SetTemplateFile "login.html" '设置模板文件
	tpl.SetVariable "adminDir","/"
	tpl.Parse
	'Destroy our objects
	set tpl = nothing
%>