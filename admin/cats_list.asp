<!--#include file="lib/AdminInIt.asp"-->
<%
'tpl.SetTemplatesDir("")
'�����ļ�
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
'��һ������
set rs=db.query("select cat_id,type_id,cat_name,cat_pic,parent_id,sort,cat_show from "&suffix&"cats  where parent_id=0 order by sort asc ")
do while not rs.eof
		'��ѯ��������
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

'////////////////////////////////////////////////////////��ҳ������///////////////////////////////////////////////////////////
''�����б����������
function getcatshow(str)
	if "1"=str then
		getcatshow="������ʾ��..."
	else
		getcatshow="<span style='color:red;'>����������...</span>"
	end if
end function
'�жϷ�������Ƿ���ͼ
function getcatimg(str)
	if str<>"" then
		getcatimg="<div class='catimg'><img class='haveimg' src='images/haveimg.gif' style='cursor:pointer;' width='12' height='12' alt='���������ͼƬ��ʾ' title='���������ͼƬ��ʾ' /><span class='catdaimg' ><img src='"&str&"' width='150' height='150' /></span></div>"
	else
		getcatimg=""
	end if
end function

%>