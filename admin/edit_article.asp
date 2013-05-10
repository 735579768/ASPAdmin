<!--#include file="lib/AdminInIt.asp"-->
<%
'tpl.SetTemplatesDir("")
'包含文件
'tpl.setVariableFile "TOP_HTML","public/top.html"
'tpl.setVariableFile "FOOTER_HTML","public/footer.html"
'Generate the page
'更新文章
	if G("isupdtarticle")="true" then
		dim arctitle,type_id,cat_id,arcpic,arccontent,arcauthor,arcsource,arckeys
		arctitle=G("arctitle")
		type_id=G("type_id")
		cat_id=G("cat_id")
		arcpic=G("arcpic")
		arcauthor=G("arcauthor")
		arcsource=G("arcsource")
		arckeys=G("arckeys")
		
		'删除原来的图片
		set temrs=db.query("select arcpic from kl_articles where id="&G("id"))
		if not temrs.eof  then
			tempic=trim(temrs("arcpic")&"")
			set temrs=nothing
			if arcpic<>"" and trim(arcpic)<>tempic then
					DeleteFile(tempic )
			end if
		end if
		
		arccontent=G("arccontent")
		arcflag=Ucase(G("arcflag"))
		arcupdate=FormatDate(now,1)
		dim result:result=db.UpdateRecord("kl_articles","ID="&G("id"),array("arctitle:"&arctitle,"arcflag:"&arcflag,"type_id:"&type_id,"cat_id:"&cat_id,"arcpic:"&arcpic,"arccontent:"&arccontent,"arcuddate:"&arcupdate,"arcauthor:"&arcauthor,"arcsource:"&arcsource,"arckeys:"&arckeys))
		if result<>0 then
			AlertMsg(UPDATE_SUCCESS_STR)
		else
			AlertMsg(UPDATE_FAIL_STR)
		end if
	end if
'输出模板默认数据
	id=G("id")
	sqlstr="SELECT *  from (kl_articles as a inner join  kl_cats as b on a.cat_id=b.cat_id) inner join kl_content_types as c on a.type_id=c.type_id where a.id="&id&" order by arcfbdate desc"
	set rs=db.query(sqlstr)
	
	tpl.SetVariable "id",rs("id")&""
	tpl.SetVariable "arcauthor",rs("arcauthor")&""
	tpl.SetVariable "arctitle",rs("arctitle")&""
	tpl.SetVariable "arcpic",rs("arcpic")&""
	tpl.SetVariable "arcsource",rs("arcsource")&""
	tpl.SetVariable "arckeys",rs("arckeys")&""
	tpl.SetVariable "arcflag",rs("arcflag")&""
	tpl.SetVariable "arcfbdate",rs("arcfbdate")&""
	tpl.SetVariable "cat_name",rs("cat_name")&""
	tpl.SetVariable "type_name",rs("type_name")&""
	tpl.SetVariable "arccontent",rs("arccontent")&""
	
	tpl.SetVariable "typeidsel",getContentTypeSel()
	tpl.SetVariable "catidsel",getArcCatSel()
tpl.Parse
'Destroy our objects
set tpl = nothing
%>