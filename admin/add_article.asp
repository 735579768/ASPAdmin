<!--#include file="lib/AdminInIt.asp"-->
<%
'tpl.SetTemplatesDir("")
'�����ļ�
'tpl.setVariableFile "TOP_HTML","public/top.html"
'tpl.setVariableFile "FOOTER_HTML","public/footer.html"
'Generate the page


'�������
	if G("isaddarticle")="true" then
	'//////////////////////////////////////////////////////////////////////////////////////////////////////////
			'ȡ���ݴ�ŵ����ݱ��������sql���
		'on error resume next
'		err.clear
'		cat_id=G("cat_id")
'		sql="select b.data_table as datatable from kl_cats as a inner join kl_content_types as b on a.type_id=b.type_id where a.cat_id="&cat_id
'		set rs=db.query(sql)
'		'ȡ�������ڵı�
'		'set rs=db.GetRecord("kl_content_types","data_table","type_id="&type_id,"",0)
'		datatable=rs("datatable")&""
'		'echo datatable
'		fieldarr=getTableField(datatable)
'		strfield=""
'		strvalue=""
'		'��ʼѭ���ֶκ�ֵ
'		for i=0 to ubound(fieldarr)-1
'			temstr=fieldarr(i)
'			'ȡ���ֶκ���������
'			if temstr(0)<>"recycling" and temstr(0)<>"id"  then'�ų�����Ҫ��ӵ��ֶ�
'					val=""
'					'�ж��ֶ������Ƿ������֣����ǵĻ���������
'					if temstr(1)=3 then
'						'������������ֲ���ֵΪ��������Ϊ0
'						if G(temstr(0))="" then
'							 val=0 
'						else
'							 val=G(temstr(0))
'						end if
'						
'					else
'						val="'"&G(temstr(0))&"'"
'					end if
'				'����ֶκ�ֵ�ַ���
'					if strfield="" then
'						strfield="["&temstr(0)&"]"
'						strvalue=val
'					else
'						'��ѯ�ǲ��������ֶ�
'						if instr(temstr(0),"date")<>0 then
'							val="'"&FormatDate(now,2)&"'"
'						end if
'						strvalue=strvalue&","&val
'						strfield=strfield&",["&temstr(0)&"]"
'					end if
'			end if
'		next
'		sql="insert into "&datatable&"("&strfield&") values("&strvalue&")"
'		echo sql
'		result=db.query(sql)
'		if err.number <> 0 then
'			AlertMsg(ADD_FAIL_STR)
'			err.clear
'		else
'			AlertMsg(ADD_SUCCESS_STR)
'		end if
		
		'���ݱ��ύ����
'		on error resume next
		err.clear
		cat_id=G("cat_id")
		sql="select b.data_table as datatable from kl_cats as a inner join kl_content_types as b on a.type_id=b.type_id where a.cat_id="&cat_id
		set rs=db.query(sql)
		datatable=rs("datatable")
				set uprs=server.createobject("adodb.recordset")
				uprs.open "select * from "&datatable,db.idbconn,1,3
				uprs.addNew
				for each key in request.Form()
					 if  key<>"isaddarticle" then
						val=G(key)
'						if not isnumeric(val) then
'							val="'"&val&"'"
'						end if
						'echo val&"<br>"
						'echo key&"<br>"
						uprs(key)=val
					 end if
				next
				uprs("fbdate")=FormatDate(now,2)
				uprs("uddate")=FormatDate(now,2)
				uprs.update
				
				if err.number<>0 then
					echoErr()
					AlertMsg(ADD_FAIL_STR)
					err.clear
				else
					AlertMsg(ADD_SUCCESS_STR)
				end if
'//////////////////////////////////////////////////////////////////////////////////////////////////////////
'		dim flag,arctitle,type_id,cat_id,arcpic,arccontent,arcauthor,arcsource,arckeys
'		arcauthor=G("arcauthor")
'		arcsource=G("arcsource")
'		arckeys=G("arckeys")
'		arctitle=G("arctitle")
'		type_id=G("type_id")
'		cat_id=G("cat_id")
'		arcpic=G("arcpic")
'		arccontent=G("arccontent")
'		arcflag=G("arcflag")
'		fbdate=FormatDate(now,2)
'		dim result:result=db.AddRecord("kl_archives",array("arctitle:"&arctitle,"arcauthor:"&arcauthor,"arcsource:"&arcsource,"arckeys:"&arckeys,"arcflag:"&arcflag,"type_id:"&type_id,"cat_id:"&cat_id,"arcpic:"&arcpic,"arccontent:"&arccontent,"fbdate:"&fbdate))
'		if result<>0 then
'			AlertMsg(ADD_SUCCESS_STR)
'		else
'			AlertMsg(ADD_FAIL_STR)
'		end if
	end if
'�������ʱȡ���ݹ����ķ���
cat_id=G("cat_id")
if cat_id="" then echo "<script>window.history.go(-1);</script>":die() end if
set rs=db.query("select * from kl_cats as a inner join kl_content_types as b on a.type_id=b.type_id where a.cat_id="&cat_id)
tpl.setVariable "arctpl",rs("cat_article")&""
tpl.SetVariable "typeidsel",getContentTypeSel()
tpl.SetVariable "catidsel",getArcCatSel()


tpl.SetTemplateFile rs("tpl_addform")&""'getAddform(cat_id)
tpl.Parse
'Destroy our objects
set tpl = nothing
%>