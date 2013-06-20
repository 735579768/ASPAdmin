<!--#include file="lib/AdminInIt.asp"-->
<%
''更新文章
	if G("isupdtarticle")="true" then
		id=G("id")
		cat_id=G("cat_id")
			set uprs=server.createobject("adodb.recordset")
			uprs.open "select * from kl_archives where id="&id,olddb.idbconn,0,2
			'bakon error resume next
			err.clear
		'delete pic start
		set temrs=olddb.query("select arcpic from kl_archives where id="&id)
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
				uprs("uddate")=FormatDate(now,2)
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
'	set rs=olddb.query(sqlstr)
'	arctpl=rs("arctpl")&""
'	if arctpl="" then arctpl=rs("tpl_article")&"" end if
'	oldtpl.SetVariable "id",rs("id")&""
'	
'	oldtpl.SetVariable "arcauthor",rs("arcauthor")&""
'	oldtpl.SetVariable "arctitle",rs("arctitle")&""
'	oldtpl.SetVariable "arcpic",rs("arcpic")&""
'	oldtpl.SetVariable "arctpl",arctpl
'	oldtpl.SetVariable "arcsource",rs("arcsource")&""
'	oldtpl.SetVariable "arckeys",rs("arckeys")&""
'	oldtpl.SetVariable "arcflag",rs("arcflag")&""
'	oldtpl.SetVariable "fbdate",rs("fbdate")&""
'	oldtpl.SetVariable "cat_name",rs("cat_name")&""
'	oldtpl.SetVariable "type_name",rs("typename")&""
'	oldtpl.SetVariable "type_id",rs("typeid")&""
'	oldtpl.SetVariable "arccontent",rs("arccontent")&""
'	oldtpl.SetVariable "arcdescr",rs("arcdescr")&""
'	
'	oldtpl.SetVariable "typeidsel",getContentTypeSel()
'	oldtpl.SetVariable "catidsel",getArcCatSel()
'
'	oldtpl.SetTemplateFile rs("tpl_editform")&""'getEditform(rs("cid")&"")
'	if err.number <> 0 then 
'		echoErr()
'	end if
'oldtpl.Parse
'set oldtpl = nothing


set rs=newdb.query(sqlstr)
edittpl=rs("tpl_editform")&""
arr=newdb.rsToArr(rs)
newtpl.assign "arcinfo",arr(0)
newtpl.display(edittpl)
%>