<%
	tpl.SetTemplateFile "login.html" '����ģ���ļ�
	tpl.SetVariable "adminDir","/"
	tpl.Parse
	'Destroy our objects
	set tpl = nothing
%>