<%
'输出所有文章分类
	function getArcCatSel()
		'检查当前是否有默认的id传过来
		dim selid'定义默认选中的id
		if G("id")<>"" then
		'  set selrs=db.getrecord("kl_article","type_id",array("id:"&G("id")))
		  set selrs=db.query("select cat_id from kl_archives where id="&G("id"))
		  selid =cstr(selrs("cat_id"))
		end if
		if G("cat_id")<>"" then  selid =G("cat_id")
		'输出sel表单
		dim str:str="<select id='cat_id' name='cat_id' style='width:200px;'>"
		set selrs=db.GetRecordBySQL("select cat_id,cat_name from kl_cats where parent_id=0 order by sort asc")
		if selrs.recordcount>0 then 
			do while not selrs.eof
				if selid=selrs("cat_id")&"" then
				str=str&"<option value='"&selrs("cat_id")&"' selected>"&selrs("cat_name")&"</option>"				
				else
				str=str&"<option value='"&selrs("cat_id")&"'>"&selrs("cat_name")&"</option>"
				end if
				'查询二级分类start
				set selrss=db.GetRecordBySQL("select cat_id,cat_name from kl_cats where parent_id="&selrs("cat_id")&" order by sort asc")
				if selrss.recordcount>0 then 
					do while not selrss.eof
						if selid=selrss("cat_id")&"" then
							str=str&"<option value='"&selrss("cat_id")&"' selected><b style='color:#ccc;'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b>"&selrss("cat_name")&"</option>"				
						else
							str=str&"<option value='"&selrss("cat_id")&"'><b style='color:#ccc;'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b>"&selrss("cat_name")&"</option>"
						end if
					selrss.movenext
					loop
					set selrss=nothing
				end if
				'查询二级分类end
			selrs.movenext
			loop
		end if
		str=str&"</select>"
		getArcCatSel=str
	end function
'输出内容模型sel
	function getContentTypeSel()
	'检查当前是否有默认的id传过来
		dim selid'定义默认选中的id
		if G("id")<>"" then
		'  set selrs=db.getrecord("kl_article","type_id",array("id:"&G("id")))
		  set selrs=db.query("select type_id from kl_archives where id="&G("id"))
		  selid =cstr(selrs("type_id"))
		end if
		if G("type_id")<>"" then  selid =G("type_id")
		if G("cat_id")<>"" then 
			  set selrs=db.query("select type_id from kl_cats where cat_id="&G("cat_id"))
			  selid =cstr(selrs("type_id"))
		end if
		'输出sel表单
		dim str:str="<select id='cat_id' name='type_id' style='width:200px;'>"
		set selrs=db.GetRecordBySQL("select * from kl_content_types")
		if selrs.recordcount>0 then 
			do while not selrs.eof
				if selid=selrs("type_id")&"" then
				str=str&"<option value='"&selrs("type_id")&"' selected>"&selrs("type_name")&"|内容模型</option>"				
				else
				str=str&"<option value='"&selrs("type_id")&"'>"&selrs("type_name")&"|内容模型</option>"
				end if
				selrs.movenext
			loop
		end if
		str=str&"</select>"
		getContentTypeSel=str
	end function
'输出后台栏目菜单
	function getSysMenusSel()
			dim str
			str="<select name=sysmenuid>"
		set selrs=db.GetRecordBySQL("select * from kl_sysmenus where parent_menu_id=0 order by sort asc")
				if selrs.recordcount>0 then 
					do while not selrs.eof
							if G("sysmenuid")=selrs("sysmenuid")&"" then
							str=str&"<option value='"&selrs("sysmenuid")&"' selected>"&selrs("menu_name")&"</option>"				
							else
							str=str&"<option value='"&selrs("sysmenuid")&"'>"&selrs("menu_name")&"</option>"
							end if
							selrs.movenext
					loop
				end if
		str=str&"</select>"
		getSysMenusSel=str
	end function
'输出角色权限下拉菜单
	Function getQxsel()
			dim str
			str="<select name=qx_id>"
		set selrs=db.GetRecordBySQL("select * from kl_admin_qx")
				if selrs.recordcount>0 then 
					do while not selrs.eof
							if G("qx_id")=selrs("qx_id")&"" then
							str=str&"<option value='"&selrs("qx_id")&"' selected>"&selrs("qx_name")&"</option>"				
							else
							str=str&"<option value='"&selrs("qx_id")&"'>"&selrs("qx_name")&"</option>"
							end if
							selrs.movenext
					loop
				end if
		str=str&"</select>"
		getQxsel=str
	End Function
%>