<!--#include file="lib/init.asp"-->
<%
catid=G("catid")
if catid="" then reurl("/") end if
'包含文件
'Generate the page
'设定指定的模板
tpl.SetTemplateFile getCatIndexTpl(catid)
tpl.Parse
'Destroy our objects
set tpl = nothing
%>