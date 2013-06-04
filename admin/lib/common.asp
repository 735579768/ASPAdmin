<%
'输出所有文章分类
	function getArcCatSel()
		'检查当前是否有默认的id传过来
		dim selid,typeid,sql'定义默认选中的id
			if G("id")<>"" then
			'  set selrs=db.getrecord("kl_article","type_id",array("id:"&G("id")))
			  set selrs=db.query("select cat_id,type_id from kl_archives where id="&G("id"))
			  selid =cstr(selrs("cat_id"))
			end if
			
			if G("cat_id")<>"" then  
				selid =G("cat_id")
				set srs=db.query("select type_id from kl_cats where cat_id="&selid)
				typeid=srs("type_id")
			end if
			
			if typeid<>"" then 
				sql="select cat_id,cat_name from kl_cats where parent_id=0 and type_id="&typeid&" order by sort asc"
			else
				sql="select cat_id,cat_name from kl_cats where parent_id=0 order by sort asc"
			end if
		'输出sel表单
		dim str:str="<select id='cat_id' name='cat_id' style='width:200px;'>"
		set selrs=db.GetRecordBySQL(sql)
		set srs=nothing
		if selrs.recordcount>0 then 
			do while not selrs.eof
				if selid=selrs("cat_id")&"" then
				str=str&"<option value='"&selrs("cat_id")&"' selected>"&selrs("cat_name")&"</option>"				
				else
				str=str&"<option value='"&selrs("cat_id")&"'>"&selrs("cat_name")&"</option>"
				end if
			
				'查询二级分类start
				str=str&catoptions(selrs("cat_id"))
				'set selrss=db.GetRecordBySQL("select cat_id,cat_name from kl_cats where parent_id="&selrs("cat_id")&" order by sort asc")
'				if selrss.recordcount>0 then 
'					do while not selrss.eof
'						
'						if selid=selrss("cat_id")&"" then
'							str=str&"<option value='"&selrss("cat_id")&"' selected><b style='color:#ccc;'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b>"&selrss("cat_name")&"</option>"				
'						else
'							str=str&"<option value='"&selrss("cat_id")&"'><b style='color:#ccc;'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b>"&selrss("cat_name")&"</option>"
'						end if
'					
'					selrss.movenext
'					loop
'					set selrss=nothing
'				end if
				'查询二级分类end
				
			selrs.movenext
			loop
			
		end if
		str=str&"</select>"
		getArcCatSel=str
		set selrs=nothing
		set selrss=nothing
	end function
	
	function ischildcat(catid)
	
		set rstem=db.query("select * from kl_cats where cat_id="&catid)
		if rstem.recordcount>0 then
			ischildcat=true
		else
			ischildcat=false
		end if
	end function
	'定义一个变量输出空格用
	kongge="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
	function catoptions(catid)
	'kongge=kongge&"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
		str=""
		set selrss=db.GetRecordBySQL("select cat_id,cat_name from kl_cats where parent_id="&catid&" order by sort asc")
				if selrss.recordcount>0 then 
					do while not selrss.eof
						'递归输出
						if ischildcat(selrss("cat_id")) then
							str=str&catoptions(selrss("cat_id"))
						end if
						if G("cat_id")=selrss("cat_id")&"" then
							str=str&"<option value='"&selrss("cat_id")&"' selected  >"&kongge&selrss("cat_name")&"</option>"				
						else
							str=str&"<option value='"&selrss("cat_id")&"' >"&kongge&selrss("cat_name")&"</option>"
						end if
					
					selrss.movenext
					loop
					set selrss=nothing
				end if
				catoptions=str
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
		set selrs=nothing
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
					set selrs=nothing
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
					set selrs=nothing
				end if
		str=str&"</select>"
		getQxsel=str
	End Function
'输出单页面下拉菜
	function getsinglesel()
			dim str
			str="<select name=singleid>"
		set selrs=db.GetRecordBySQL("select * from kl_single")
				if selrs.recordcount>0 then 
					do while not selrs.eof
							if G("singleid")=selrs("id")&"" then
							str=str&"<option value='"&selrs("id")&"' selected>"&selrs("pagename")&"</option>"				
							else
							str=str&"<option value='"&selrs("id")&"'>"&selrs("pagename")&"</option>"
							end if
							selrs.movenext
					loop
					set selrs=nothing
				end if
		str=str&"</select>"
		getsinglesel=str	
	end function
	
	'更改父分类
	Function catparentsel(catid)
		'查询它的父分类
		set zrs=db.query("select parent_id from kl_cats where cat_id="&catid)
		prentid=zrs("parent_id")&""
		set zrs=nothing
		restr=""
		fsql="select * from kl_cats where cat_id<>"&catid
		set frs=db.query(fsql)
		if frs.recordcount>0 then
			restr="<select name=parent_id>"
				if parentid=0 then
					restr=restr&"<option value='0' selected>顶级分类</option>"
				end if
			do while not frs.eof
				if prentid=frs("cat_id")&"" then
				restr=restr&"<option value='"&frs("cat_id")&"' selected>"&frs("cat_name")&"</option>"				
				else
				restr=restr&"<option value='"&frs("cat_id")&"'>"&frs("cat_name")&"</option>"
				end if
				frs.movenext
			loop
			restr=restr&"</select>"
		end if
		set frs=nothing
		catparentsel=restr
	end function
%>