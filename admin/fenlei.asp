<!--#include file="lib/AdminInIt.asp"-->
<%
act=G("act")
cat_id=G("cat_id")
fenlei_parent_id=G("fenlei_parent_id")
newtpl.assign "catsel",getArcCatSel()
'添加新的分类
if act="add" then 
	newdb.table("kl_fenlei").create()
	newdb.add()
end if

if cat_id<>"" or cat_id<>0 then
	set rs=newdb.table("kl_fenlei").where("cat_id="&cat_id&" and fenlei_parent_id=0").sel()
	str=""
	do while not rs.eof
		str=str&"<tr><td>(ID:"&rs("fenlei_id")&")分类名字：<input name='fenlei_name' type='text' value='"&rs("fenlei_name")&"'></td><td><a href='javascript:void(0);' class='coolbg modfenlei'>修改</a>子类名字：<input name='childfenlei_name' type='text' value=''><a href='javascript:void(0);' class='coolbg addchildfenlei' parentid="&rs("fenlei_id")&">添加子类</a></tr>"
		'echo rs("fenlei_name")
		rs.movenext
	loop
	newtpl.assign "sfenlei",str
end if
newtpl.display("fenlei")
%>