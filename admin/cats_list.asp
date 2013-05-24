<!--#include file="lib/AdminInIt.asp"-->
<%
'tpl.SetTemplatesDir("")
'包含文件
'tpl.setVariableFile "TOP_HTML","public/top.html"
dim act:act=G("act")
select case act
	case "" :
		'listanddefault()
	case "list":
		'listanddefault()
end select


tpl.UpdateBlock "m2_block"
tpl.UpdateBlock "m1_block"
'查一级分类
sql1="select a.type_id as typeid,* from kl_cats as a inner join kl_content_types as b on a.type_id=b.type_id   where a.parent_id=0 order by sort asc "
set rs=db.query(sql1)
do while not rs.eof
		'查询二级分类
		sql2="select a.type_id as typeid,* from kl_cats as a inner join kl_content_types as b on a.type_id=b.type_id   where a.parent_id="&rs("cat_id")&"  order by sort asc "
		set rss=db.query(sql2)
		do while not rss.eof
			tpl.SetVariable "arcnum",getarcnum(rs("cat_id")&"")
			tpl.SetVariable "cat_id",rss("cat_id")&""
			tpl.SetVariable "type_sxname",rss("type_sxname")&""
			tpl.SetVariable "cat_name",rss("cat_name")&""
			tpl.SetVariable "sort",rss("sort")&""
			tpl.SetVariable "cat_show",getcatshow(rss("cat_show")&"")
			tpl.setvariable "type_id",rss("typeid")&""
			tpl.setvariable "haveimg",getcatimg(rs("cat_pic")&"")
			tpl.ParseBlock "m2_block"
		rss.movenext
		loop
			tpl.SetVariable "arcnum",getarcnum(rs("cat_id")&"")
			tpl.SetVariable "cat_id",rs("cat_id")&""
			tpl.SetVariable "cat_name",rs("cat_name")&""
			tpl.SetVariable "sort",rs("sort")&""
			tpl.SetVariable "cat_show",getcatshow(rs("cat_show")&"")
			tpl.setvariable "type_id",rs("typeid")&""
			tpl.SetVariable "type_sxname",rs("type_sxname")&""
			tpl.setvariable "haveimg",getcatimg(rs("cat_pic")&"")
			tpl.ParseBlock "m1_block"
		rs.movenext
loop
'Generate the page
tpl.Parse
'Destroy our objects
set tpl = nothing

'////////////////////////////////////////////////////////本页函数库///////////////////////////////////////////////////////////
''文章列表内容输输出
function getcatshow(str)
	if "1"=str then
		getcatshow="导航显示中..."
	else
		getcatshow="<span style='color:red;'>导航隐藏中...</span>"
	end if
end function
'判断分类封面是否有图
function getcatimg(str)
	if str<>"" then
		getcatimg="<div class='catimg'><img class='haveimg' src='images/haveimg.gif' style='cursor:pointer;' width='12' height='12' alt='分类封面有图片显示' title='分类封面有图片显示' /><span class='catdaimg' ><img src='"&str&"' width='150' height='150' /></span></div>"
	else
		getcatimg="无图"
	end if
end function
'查询分类文章数量
function getarcnum(catid)
	sql="select count(*) as  a from kl_archives where cat_id="&catid
	set bbbb=db.query(sql)
	getarcnum=bbbb("a")&""
	set bbbb=nothing
end function
%>