<!--#include file="lib/AdminInIt.asp"-->
<%
'这个文件用来添加子类和顶级类
'cat如果为0则添加顶级类，不为0则为这个分类的父id
dim parent_id:parent_id=G("parent_id")
if G("act")="add" then
	dim cat_name:cat_name=G("cat_name")
	dim csort:csort=G("sort")
	dim type_id:type_id=G("type_id")
	dim cat_show:cat_show=G("cat_show")
	dim cat_pic:cat_pic=G("cat_pic")
	db.query("insert into "&suffix&"cats(parent_id,cat_name,type_id,[sort],cat_show,cat_pic) values("&parent_id&",'"&cat_name&"',"&type_id&","&csort&","&cat_show&","&cat_pic&")")
	AlertMsg("添加成功!")
	echo "<script>window.location=""cats_list.asp"";</script>"
end if
'Generate the page
if parent_id<>0 then
set rs=db.query("select cat_name from "&suffix&"cats where cat_id="&parent_id)
tpl.setvariable "parent_id",parent_id
tpl.setvariable "cat_name",rs("cat_name")&""
else
tpl.setvariable "cat_name","无"
tpl.setvariable "parent_id",parent_id
end if
tpl.setvariable "typeidsel",getContentTypeSel()
'Generate the page
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