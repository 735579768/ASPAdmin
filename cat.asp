<!--#include file="lib/init.asp"-->
<%
catid=G("catid")
if catid="" then reurl("/") end if
'�����ļ�
'Generate the page
'�趨ָ����ģ��
tpl.SetTemplateFile getCatIndexTpl(catid)
tpl.Parse
'Destroy our objects
set tpl = nothing
%>