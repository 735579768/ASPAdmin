<!--#include file="lib/AdminInIt.asp"-->
<%
'tpl.SetTemplatesDir("")
'包含文件
'tpl.setVariableFile "TOP_HTML","public/top.html"
'tpl.setVariableFile "FOOTER_HTML","public/footer.html"
tpl.UpdateBlock "m2_block"
tpl.UpdateBlock "m1_block"
'查一级菜单
set rs=db.query("select sysmenuid,menu_name,parent_menu_id,menu_link,sort from " & suffix & "sysmenus  where parent_menu_id=0 order by sort asc ")
do while not rs.eof
		'查询二级菜单
		set rss=db.query("select sysmenuid,menu_name,menu_link,sort from " & suffix & "sysmenus  where parent_menu_id="&rs("sysmenuid")&" order by sort asc ")
		do while not rss.eof
			tpl.SetVariable "menu2_name",rss("menu_name")&""
			tpl.SetVariable "menu2_link",rss("menu_link")&""
			tpl.ParseBlock "m2_block"
		rss.movenext
		loop
	tpl.SetVariable "menu1_name",rs("menu_name")&""
	tpl.ParseBlock "m1_block"
	rs.movenext
loop
'Generate the page
tpl.Parse
'Destroy our objects
set tpl = nothing
%>