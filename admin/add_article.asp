<!--#include file="lib/AdminInIt.asp"-->
<%
'tpl.SetTemplatesDir("")
'�����ļ�
'tpl.setVariableFile "TOP_HTML","public/top.html"
'tpl.setVariableFile "FOOTER_HTML","public/footer.html"
'Generate the page
'�������
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
'�������ʱȡ���ݹ����ķ���
cat_id=G("cat_id")
if cat_id="" then echo "<script>window.history.go(-1);</script>":die() end if
set rs=db.query("select * from kl_cats as a inner join kl_content_types as b on a.type_id=b.type_id where a.cat_id="&cat_id)
tpl.setVariable "arctpl",rs("cat_article")&""
tpl.SetVariable "typeidsel",getContentTypeSel()
tpl.SetVariable "catidsel",getArcCatSel()
tpl.Parse
'Destroy our objects
set tpl = nothing
%>