<!--#include file="lib/AdminInIt.asp"-->
<%
'tpl.SetTemplatesDir("")
'包含文件
'tpl.setVariableFile "TOP_HTML","public/top.html"
'tpl.setVariableFile "FOOTER_HTML","public/footer.html"
'Generate the page
'添加文章
	if G("isaddarticle")="true" then
		dim flag,arctitle,type_id,cat_id,arcpic,arccontent,arcauthor,arcsource,arckeys
		arcauthor=G("arcauthor")
		arcsource=G("arcsource")
		arckeys=G("arckeys")
		arctitle=G("arctitle")
		type_id=G("type_id")
		cat_id=G("cat_id")
		arcpic=G("arcpic")
		arccontent=G("arccontent")
		arcflag=G("arcflag")
		arcfbdate=FormatDate(now,2)
		dim result:result=db.AddRecord("kl_articles",array("arctitle:"&arctitle,"arcauthor:"&arcauthor,"arcsource:"&arcsource,"arckeys:"&arckeys,"arcflag:"&arcflag,"type_id:"&type_id,"cat_id:"&cat_id,"arcpic:"&arcpic,"arccontent:"&arccontent,"arcfbdate:"&arcfbdate))
		if result<>0 then
			AlertMsg(ADD_SUCCESS_STR)
		else
			AlertMsg(ADD_FAIL_STR)
		end if
	end if
	
tpl.SetVariable "typeidsel",getContentTypeSel()
tpl.SetVariable "catidsel",getArcCatSel()
tpl.Parse
'Destroy our objects
set tpl = nothing
%>