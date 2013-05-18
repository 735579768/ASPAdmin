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
set rs=db.query("select cat_id,type_id,cat_name,cat_pic,parent_id,sort,cat_show from "&suffix&"cats  where parent_id=0 order by sort asc ")
do while not rs.eof
		'查询二级分类
		set rss=db.query("select cat_id,type_id,cat_pic,cat_name,parent_id,sort,cat_show from "&suffix&"cats  where parent_id="&rs("cat_id")&" order by sort asc ")
		do while not rss.eof
			tpl.SetVariable "cat_id",rss("cat_id")&""
			tpl.SetVariable "cat_name",rss("cat_name")&""
			tpl.SetVariable "sort",rss("sort")&""
			tpl.SetVariable "cat_show",getcatshow(rss("cat_show")&"")
			tpl.setvariable "type_id",rss("type_id")&""
			tpl.setvariable "haveimg",getcatimg(rs("cat_pic")&"")
			tpl.ParseBlock "m2_block"
		rss.movenext
		loop
			tpl.SetVariable "cat_id",rs("cat_id")&""
			tpl.SetVariable "cat_name",rs("cat_name")&""
			tpl.SetVariable "sort",rs("sort")&""
			tpl.SetVariable "cat_show",getcatshow(rs("cat_show")&"")
			tpl.setvariable "type_id",rs("type_id")&""
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
		getcatimg=""
	end if
end function

%>