<!--#include file="lib/AdminInIt.asp"-->
<%
set datars=newdb.table("kl_content_types").where("type_id=1").sel()
json=datars("formjsonstr")
set arr=jsontoobj(json)
for each b in arr.keys
echo b&"=>"&arr(b)&"<br>"
next

if G("act")="addconmodel" then
'取对应数据表中的字段信息
datatable=G("data_table")
set datars=newdb.table(datatable).sel()
Set o = jsObject()
for each  a in datars.fields
o(a.name)="descr|"& cstr(1)
next
formjsonstr=tojson(o)
on error resume next
err.clear
set rs=newdb.table("kl_content_types").sel()'打开一个表的记录集
rs.addnew
rs("type_name")=G("type_name")
rs("type_sxname")=G("type_name")
rs("data_table")=datatable
rs("tpl_addform")=G("tpl_addform")
rs("tpl_editform")=G("tpl_editform")
rs("tpl_index")=G("tpl_index")
rs("tpl_list")=G("tpl_list")
rs("tpl_article")=G("tpl_article")
rs("formjsonstr")=formjsonstr
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