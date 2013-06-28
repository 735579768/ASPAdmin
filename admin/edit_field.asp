<!--#include file="lib/AdminInIt.asp"-->
<%
typeid=G("type_id")
if G("updformjson")="true" and typeid<>"" then
	Set o = jsObject()
	for each a in request.Form
		num=instr(a,"auto_")
		if num<>0 then
		fie=replace(a,"auto_","")
		o(fie)=G(fie&"1")&"|"&G(fie&"2")&"|"&G(fie&"3")
		end if
	next
	formjsonstr= tojson(o)
	set rs=newdb.table("kl_content_types").where("type_id="&typeid).sel
	rs("formjsonstr")=formjsonstr
	rs.update
end if
'输出表中的字段
dim datatable,type_name,formjsonstr,jsonobj
datatable=G("data_table")
if typeid<>"" then
	set rs=newdb.table("kl_content_types").where("type_id="&typeid).sel()
	type_name=rs("type_name")
	datatable=rs("data_table")
	formjsonstr=rs("formjsonstr")
end if
'输出json对象数据
if formjsonstr<>"" then
set jsonobj=jsontoobj(formjsonstr)
end if

if datatable<>"" then
	set rs=newdb.table(datatable).sel()
		listdata=""
		for each a in rs.fields
		dim desc,show,addedit
		
		if isobject(jsonobj) then
			tarr=split(jsonobj(a.name),"|")
			descr=tarr(0)
			show=tarr(1)
			addedit=tarr(2)
		else
			descr=a.name
			show="0"
			addedit=""
		end if
		listdata=listdata&"<tr><td  align='right'><input name='auto_"&a.name&"' type='hidden' />"&a.name&"</td><td align='center' ><input type='text' name='"&a.name&"1' value='"&descr&"' /></td><td align='center' ><input type='text' name='"&a.name&"2' value='"&show&"' /></td><td align='center' ><input type='text' name='"&a.name&"3' value='"&addedit&"' /><a id='"&a.name&"' class='coolbg sel'>类型说明</a></td></tr>"
		next
		newtpl.assign "listdata",listdata
		newtpl.assign "type_id",typeid
		newtpl.assign "type_name",type_name
		newtpl.assign "arr",arr
		newtpl.display("edit_field.html")
else
	echo "<script>window.history.go(-1);</sript>"
end if
%>