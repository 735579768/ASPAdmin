<%
'����������·���
	function getArcCatSel()
		'��鵱ǰ�Ƿ���Ĭ�ϵ�id������
		dim selid'����Ĭ��ѡ�е�id
		if G("id")<>"" then
		'  set rs=db.getrecord("kl_article","type_id",array("id:"&G("id")))
		  set rs=db.query("select cat_id from kl_articles where id="&G("id"))
		  selid =cstr(rs("cat_id"))
		end if
		if G("cat_id")<>"" then  selid =G("cat_id")
		'���sel��
		dim str:str="<select id='cat_id' name='cat_id' style='width:200px;'>"
		set rs=db.GetRecordBySQL("select cat_id,cat_name from kl_cats where parent_id=0 order by sort asc")
		if rs.recordcount>0 then 
			do while not rs.eof
				if selid=rs("cat_id")&"" then
				str=str&"<option value='"&rs("cat_id")&"' selected>"&rs("cat_name")&"</option>"				
				else
				str=str&"<option value='"&rs("cat_id")&"'>"&rs("cat_name")&"</option>"
				end if
				'��ѯ��������start
				set rss=db.GetRecordBySQL("select cat_id,cat_name from kl_cats where parent_id="&rs("cat_id")&" order by sort asc")
				if rss.recordcount>0 then 
					do while not rss.eof
						if selid=rss("cat_id")&"" then
							str=str&"<option value='"&rss("cat_id")&"' selected><b style='color:#ccc;'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b>"&rss("cat_name")&"</option>"				
						else
							str=str&"<option value='"&rss("cat_id")&"'><b style='color:#ccc;'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b>"&rss("cat_name")&"</option>"
						end if
					rss.movenext
					loop
					set rss=nothing
				end if
				'��ѯ��������end
			rs.movenext
			loop
		end if
		str=str&"</select>"
		getArcCatSel=str
	end function
'�������ģ��sel
	function getContentTypeSel()
	'��鵱ǰ�Ƿ���Ĭ�ϵ�id������
		dim selid'����Ĭ��ѡ�е�id
		if G("id")<>"" then
		'  set rs=db.getrecord("kl_article","type_id",array("id:"&G("id")))
		  set rs=db.query("select type_id from kl_articles where id="&G("id"))
		  selid =cstr(rs("type_id"))
		end if
		if G("type_id")<>"" then  selid =G("type_id")
		'���sel��
		dim str:str="<select id='cat_id' name='type_id' style='width:200px;'>"
		set rs=db.GetRecordBySQL("select * from kl_content_types")
		if rs.recordcount>0 then 
			do while not rs.eof
				if selid=rs("type_id")&"" then
				str=str&"<option value='"&rs("type_id")&"' selected>"&rs("type_name")&"|����ģ��</option>"				
				else
				str=str&"<option value='"&rs("type_id")&"'>"&rs("type_name")&"|����ģ��</option>"
				end if
				rs.movenext
			loop
		end if
		str=str&"</select>"
		getContentTypeSel=str
	end function
'�����̨��Ŀ�˵�
	function getSysMenusSel()
			dim str
			str="<select name=sysmenuid>"
		set rs=db.GetRecordBySQL("select * from kl_sysmenus where parent_menu_id=0 order by sort asc")
				if rs.recordcount>0 then 
					do while not rs.eof
							if G("sysmenuid")=rs("sysmenuid")&"" then
							str=str&"<option value='"&rs("sysmenuid")&"' selected>"&rs("menu_name")&"</option>"				
							else
							str=str&"<option value='"&rs("sysmenuid")&"'>"&rs("menu_name")&"</option>"
							end if
							rs.movenext
					loop
				end if
		str=str&"</select>"
		getSysMenusSel=str
	end function
'�����ɫȨ�������˵�
	Function getQxsel()
			dim str
			str="<select name=qx_id>"
		set rs=db.GetRecordBySQL("select * from kl_admin_qx")
				if rs.recordcount>0 then 
					do while not rs.eof
							if G("qx_id")=rs("qx_id")&"" then
							str=str&"<option value='"&rs("qx_id")&"' selected>"&rs("qx_name")&"</option>"				
							else
							str=str&"<option value='"&rs("qx_id")&"'>"&rs("qx_name")&"</option>"
							end if
							rs.movenext
					loop
				end if
		str=str&"</select>"
		getQxsel=str
	End Function
%>