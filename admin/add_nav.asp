<!--#include file="lib/AdminInIt.asp"-->
<%
'tpl.SetTemplatesDir("")
'包含文件
'tpl.setVariableFile "TOP_HTML","public/top.html"
'tpl.setVariableFile "FOOTER_HTML","public/footer.html"

'添加菜单和子菜单
	if G("act")="add" then
		if G("lanmu")<>"" then
			db.query("insert into kl_sysmenus(parent_menu_id,menu_name) values(0,'"&G("lanmu")&"')")
			'echo "insert into "&suffix&"sysmenus(parent_menu_id,menu_name) values(0,'"&G("lanmu")&"')"
			AlertMsg("添加菜单--"&G("lanmu")&"-- 成功！")
		end if 
		if G("childlanmu")<>"" then
			db.query("insert into kl_sysmenus(parent_menu_id,menu_name,menu_link) values("&G("sysmenuid")&",'"&G("childlanmu")&"','"&G("childlanmuurl")&"')")
			AlertMsg("子菜单 --"&G("childlanmu")&"-- 添加成功！")
		end if 
	end if



'更新栏目和子菜单
	if G("act")="update" then
		sqlstr=""
		id=G("id")
		if G("sysmenu_link")<>"" then
			sqlstr="update kl_sysmenus set menu_name='"&G("sysmenu_name")&"',menu_link='"&G("sysmenu_link")&"' where sysmenuid="& id
			db.query(sqlstr)
		else
			sqlstr="update kl_sysmenus set menu_name='"&G("sysmenu_name")&"' where sysmenuid="& id
			db.query(sqlstr)
			
		end if
	end if

'输出栏目和子菜单
	dim str:str=getSysMenusSel()
	tpl.setVariable "sysmenus",str
	tpl.UpdateBlock "m2_block"
	tpl.UpdateBlock "m1_block"
	'查一级菜单
	set rs=db.query("select sysmenuid,menu_name,parent_menu_id,menu_link,sort from " & suffix & "sysmenus  where parent_menu_id=0 order by sort asc ")
	do while not rs.eof
			'查询二级菜单
			set rss=db.query("select sysmenuid,menu_name,menu_link,sort from " & suffix & "sysmenus  where parent_menu_id="&rs("sysmenuid")&" order by sort asc ")
			do while not rss.eof
				tpl.SetVariable "sort2",rss("sort")&""
				tpl.SetVariable "menu2_id",rss("sysmenuid")&""
				tpl.SetVariable "menu2_name",rss("menu_name")&""
				tpl.SetVariable "menu2_link",rss("menu_link")&""
				tpl.ParseBlock "m2_block"
			rss.movenext
			loop
		tpl.SetVariable "sort1",rs("sort")&""
		tpl.SetVariable "menu1_id",rs("sysmenuid")&""
		tpl.SetVariable "menu1_name",rs("menu_name")&""
		tpl.ParseBlock "m1_block"
		rs.movenext
	loop
'Generate the page
tpl.Parse
'Destroy our objects
set tpl = nothing
%>