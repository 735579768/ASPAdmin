<!--#include file="lib/init.asp"-->
<%
id=G("id")
if id="" then reurl("/") end if
'�����ļ�
'Generate the page
'�趨ָ����ģ��
tpl.SetTemplateFile getArticleTpl(id)
tpl.Parse
'Destroy our objects
set tpl = nothing
%>