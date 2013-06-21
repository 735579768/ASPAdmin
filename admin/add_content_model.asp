<!--#include file="lib/AdminInIt.asp"-->
<%
if G("act")="addconmodel" then
on error resume next
err.clear
set rs=newdb.table("kl_content_types").sel()'打开一个表的记录集
rs.addnew
rs("type_name")=G("type_name")
rs("type_sxname")=G("type_name")
rs("data_table")=G("data_table")
rs("tpl_addform")=G("tpl_addform")
rs("tpl_editform")=G("tpl_editform")
rs("tpl_index")=G("tpl_index")
rs("tpl_list")=G("tpl_list")
rs("tpl_article")=G("tpl_article")
rs.update
if err.number<>0 then
	AlertMsg(ADD_FAIL_STR)
else
	AlertMsg(ADD_SUCCESS_STR)
	reurl("contentmodel_list.asp")
end if
end if
newtpl.display("add_content_model.html")
%>