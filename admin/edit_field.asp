<!--#include file="lib/AdminInIt.asp"-->
<%
typeid=G("type_id")
if G("updformjson")="true" and typeid<>"" then
Set o = jsObject()
for each a in request.Form
num=instr(a,"auto_")
if num<>0 then
fie=replace(a,"auto_","")
o(fie)=G(fie&"1")&"|"&G(fie&"2")
end if
next
formjsonstr= tojson(o)
set rs=newdb.table("kl_content_types").where("type_id="&typeid).sel
rs("formjsonstr")=formjsonstr
rs.update
end if

if typeid<>"" then
	set rs=newdb.table("kl_content_types").where("type_id="&typeid).sel()
	type_name=rs("type_name")
	datatable=rs("data_table")
	set rs=newdb.table(datatable).sel()
	if rs.recordcount>0 then
	redim arr(rs.fields.count-1)
	i=0
	for each a in rs.fields
	arr(i)=a.name
	i=i+1
	next
	newtpl.assign "type_id",typeid
	newtpl.assign "type_name",type_name
	newtpl.assign "arr",arr
	newtpl.display("edit_field.html")
	else
	echo "<script>window.history.go(-1);</sript>"
	end if
else
	echo "<script>window.history.go(-1);</sript>"
end if
%>