<!--#include file="lib/AdminInIt.asp"-->
<%
'tpl.SetTemplatesDir("")
'包含文件
'tpl.setVariableFile "TOP_HTML","public/top.html"
'tpl.setVariableFile "FOOTER_HTML","public/footer.html"
'Generate the page


''更新文章
	if G("isupdtarticle")="true" then
		id=G("id")
		cat_id=G("cat_id")
		sql="select data_table as datatable from kl_cats as a inner join kl_content_types as b on a.type_id=b.type_id where a.cat_id="&cat_id
		set rs=db.query(sql)
		datatable=rs("datatable")
				set uprs=server.createobject("adodb.recordset")
				uprs.open "select * from "&datatable&" where id="&id,db.idbconn,0,2
			on error resume next
			err.clear
				for each key in request.Form()
					 if key<>"id" and key<>"isupdtarticle" then
						val=G(key)
'						if not isnumeric(val) then
'							val="'"&val&"'"
'						end if
						'echo val&"<br>"
						'echo key&"<br>"
						uprs(key)=val
					 end if
				next
				uprs.update
				if err.number<>0 then
					AlertMsg(UPDATE_FAIL_STR)
				else
					AlertMsg(UPDATE_SUCCESS_STR)
				end if
'		dim arctitle,type_id,cat_id,arcpic,arccontent,arcauthor,arcsource,arckeys
'		arctitle=G("arctitle")
'		type_id=G("type_id")
'		cat_id=G("cat_id")
'		arcpic=G("arcpic")
'		arcauthor=G("arcauthor")
'		arcsource=G("arcsource")
'		arckeys=G("arckeys")
'		arctpl=G("arctpl")
'		
'		'删除原来的图片
'		set temrs=db.query("select arcpic from kl_archives where id="&G("id"))
'		if not temrs.eof  then
'			tempic=trim(temrs("arcpic")&"")
'			set temrs=nothing
'			if arcpic<>"" and trim(arcpic)<>tempic then
'					DeleteFile(tempic )
'			end if
'		end if
'		
'		arccontent=G("arccontent")
'		arcflag=Ucase(G("arcflag"))
'		arcupdate=FormatDate(now,1)
'		dim result:result=db.UpdateRecord("kl_archives","ID="&G("id"),array("arctitle:"&arctitle,"arcflag:"&arcflag,"type_id:"&type_id,"cat_id:"&cat_id,"arcpic:"&arcpic,"arccontent:"&arccontent,"uddate:"&arcupdate,"arcauthor:"&arcauthor,"arcsource:"&arcsource,"arckeys:"&arckeys,"arctpl:"&arctpl))
'		if result<>0 then
'			AlertMsg(UPDATE_SUCCESS_STR)
'		else
'			AlertMsg(UPDATE_FAIL_STR)
'		end if
	end if
'输出模板默认数据
	id=G("id")
	sqlstr="SELECT a.cat_id as cid,*  from (kl_archives as a left join  kl_cats as b on a.cat_id=b.cat_id) inner join kl_content_types as c on a.type_id=c.type_id where a.id="&id&" order by fbdate desc"
	set rs=db.query(sqlstr)
	arctpl=rs("arctpl")&""
	if arctpl="" then arctpl=rs("tpl_article")&"" end if
	tpl.SetVariable "id",rs("id")&""
	
	'setVarArr(array("id:"&id,"id:"&id,"id:"&id,"id:"&id,"id:"&id,"id:"&id,"id:"&id,"id:"&id,"id:"&id,))
	tpl.SetVariable "arcauthor",rs("arcauthor")&""
	tpl.SetVariable "arctitle",rs("arctitle")&""
	tpl.SetVariable "arcpic",rs("arcpic")&""
	tpl.SetVariable "arctpl",arctpl
	tpl.SetVariable "arcsource",rs("arcsource")&""
	tpl.SetVariable "arckeys",rs("arckeys")&""
	tpl.SetVariable "arcflag",rs("arcflag")&""
	tpl.SetVariable "fbdate",rs("fbdate")&""
	tpl.SetVariable "cat_name",rs("cat_name")&""
	tpl.SetVariable "type_name",rs("type_name")&""
	tpl.SetVariable "arccontent",rs("arccontent")&""
	
	tpl.SetVariable "typeidsel",getContentTypeSel()
	tpl.SetVariable "catidsel",getArcCatSel()

	tpl.SetTemplateFile rs("tpl_editform")&""'getEditform(rs("cid")&"")
	if err.number <> 0 then 
		echoErr()
	end if
tpl.Parse
'Destroy our objects
set tpl = nothing
%>