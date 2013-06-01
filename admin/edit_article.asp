<!--#include file="lib/AdminInIt.asp"-->
<%
''更新文章
	if G("isupdtarticle")="true" then
		id=G("id")
		cat_id=G("cat_id")
			set uprs=server.createobject("adodb.recordset")
			uprs.open "select * from kl_archives where id="&id,db.idbconn,0,2
			on error resume next
			err.clear
		'delete pic start
		set temrs=db.query("select arcpic from kl_archives where id="&id)
		if not temrs.eof  then
			tempic=trim(temrs("arcpic")&"")
			set temrs=nothing
			if arcpic<>"" and trim(G("arcpic"))<>tempic then
					DeleteFile(tempic )
			end if
		end if
		'delete pic send
				for each key in request.Form()
					 if key<>"id" and key<>"isupdtarticle" then
						val=G(key)
						uprs(key)=val
					 end if
				next
				if(G("arcdescr")="") then uprs("arcdescr")=left(removehtml(G("arccontent")),30)
				uprs.update
				if err.number<>0 then
					AlertMsg(UPDATE_FAIL_STR)
				else
					AlertMsg(UPDATE_SUCCESS_STR)
				end if
	end if
'输出模板默认数据
	id=G("id")
	sqlstr="SELECT a.cat_id as cid,c.type_name as typename,b.type_id as typeid,*  from (kl_archives as a inner join  kl_cats as b on a.cat_id=b.cat_id) inner join kl_content_types as c on b.type_id=c.type_id where a.id="&id&" order by fbdate desc"
	set rs=db.query(sqlstr)
	arctpl=rs("arctpl")&""
	if arctpl="" then arctpl=rs("tpl_article")&"" end if
	tpl.SetVariable "id",rs("id")&""
	
	tpl.SetVariable "arcauthor",rs("arcauthor")&""
	tpl.SetVariable "arctitle",rs("arctitle")&""
	tpl.SetVariable "arcpic",rs("arcpic")&""
	tpl.SetVariable "arctpl",arctpl
	tpl.SetVariable "arcsource",rs("arcsource")&""
	tpl.SetVariable "arckeys",rs("arckeys")&""
	tpl.SetVariable "arcflag",rs("arcflag")&""
	tpl.SetVariable "fbdate",rs("fbdate")&""
	tpl.SetVariable "cat_name",rs("cat_name")&""
	tpl.SetVariable "type_name",rs("typename")&""
	tpl.SetVariable "type_id",rs("typeid")&""
	tpl.SetVariable "arccontent",rs("arccontent")&""
	tpl.SetVariable "arcdescr",rs("arcdescr")&""
	
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