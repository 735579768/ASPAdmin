<!--#include file="lib/init.asp"-->
<%
id=G("id")
if id="" then reurl("/") end if
'�����ļ�
'Generate the page
'�趨ָ����ģ��
tpl.SetTemplateFile getArticleTpl(id)
sql="select * from (kl_archives as a inner join kl_cats as b on a.cat_id=b.cat_id) inner join kl_content_types as c on b.type_id=c.type_id where a.id="&id
setTplVarBySql(sql)
tpl.Parse
'Destroy our objects
set tpl = nothing
%>