<!--#include file="lib/init.asp"-->
<%
id=G("id")
if id="" then reurl("/") end if
'包含文件
'Generate the page
'设定指定的模板
tpl.SetTemplateFile getArticleTpl(id)
tpl.Parse
'Destroy our objects
set tpl = nothing
%>