<%
	oldtpl.SetTemplateFile "login.html" '设置模板文件
	oldtpl.SetVariable "adminDir","/"
	oldtpl.Parse
	'Destroy our objects
	set oldtpl = nothing
%>