<!--#include file="lib/AdminInIt.asp"-->
<%
type_id=G("type_id")

if G("act")="delmodel" then 	
newdb.query("delete from kl_content_types where type_id="&type_id)
end if
if G("act")="updmodel" then 	
on error resume next
err.clear
set rs=newdb.table("kl_content_types").where("type_id="&type_id).sel()'打开一个表的记录集
rs("type_name")=G("type_name")
rs("type_sxname")=G("type_sxname")
rs("data_table")=G("data_table")
rs("tpl_addform")=G("tpl_addform")
rs("tpl_editform")=G("tpl_editform")
rs("tpl_index")=G("tpl_index")
rs("tpl_list")=G("tpl_list")
rs("tpl_article")=G("tpl_article")
rs.update
if err.number<>0 then
	AlertMsg(UPDATE_FAIL_STR)
else
	AlertMsg(UPDATE_SUCCESS_STR)
end if

end if
newtpl.display("contentmodel_list.html")
%>