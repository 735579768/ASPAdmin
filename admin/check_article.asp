<!--#include file="lib/AdminInIt.asp"-->
<%
dim cat_id:cat_id=G("cat_id")
if G("act")="update" then
	dim cat_name:cat_name=G("cat_name")
	dim csort:csort=G("sort")
	dim type_id:type_id=G("type_id")
	db.query("insert into "&suffix&"cats(parent_id,cat_name,type_id,[sort]) values("&parent_id&",'"&cat_name&"',"&type_id&","&csort&")")
	AlertMsg("添加成功!")
end if
'Generate the page
set rs=db.query("select cat_name,sort from "&suffix&"cats where cat_id="&cat_id)
tpl.setvariable "cat_id",cat_id
tpl.setvariable "cat_name",rs("cat_name")&""
tpl.setvariable "sort",rs("sort")&""
tpl.Parse
'Destroy our objects
set tpl = nothing

'////////////////////////////////////////////////////////本页函数库///////////////////////////////////////////////////////////
'文章列表内容输输出
function listanddefault()

	 	tpl.setVariableFile "CATS_CONTENT","cats/cat_list.html"
		set rs=db.query("select a.cat_id,a.cat_name,b.type_name from "&suffix&"cats as a inner join  "&suffix&"content_types as b on a.type_id=b.type_id ")	
	
		if rs.recordcount>0 then
			do while not rs.eof
				tpl.UpdateBlock "a_block"
				tpl.SetVariable "cat_id",rs(0)&""
				tpl.SetVariable "cat_name",rs(1)&""
				tpl.SetVariable "type_name",rs(2)&""
				tpl.ParseBlock "a_block"
			rs.movenext
			loop
		end if
end function
%>