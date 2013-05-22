<!--#include file="lib/AdminInIt.asp"-->
<%
'tpl.SetTemplatesDir("")
'°üº¬ÎÄ¼þ
'tpl.setVariableFile "TOP_HTML","public/top.html"
'tpl.setVariableFile "FOOTER_HTML","public/footer.html"
if G("upcfg")="true" then 
	Set o = jsObject()
	o("cfg_indexname")=G("cfg_indexname")
	o("cfg_webname")=G("cfg_webname")
	o("cfg_arcdir")=G("cfg_arcdir")
	o("cfg_medias_dir")=G("cfg_medias_dir")
	o("cfg_df_style")=G("cfg_df_style")
	o("cfg_powerby")=G("cfg_powerby")
	o("cfg_keywords")=G("cfg_keywords")
	o("cfg_description")=G("cfg_description")
	o("cfg_beian")=G("cfg_beian")
	result=db.UpdateRecord("kl_meta","meta_key='cfg_system'",array("meta_value:"&tojson(o)))
	if result<>0 then 
	 AlertMsg(UPDATE_SUCCESS_STR)
	end if
end if


set rs=db.getRecord("kl_meta","meta_value","meta_key='cfg_system'","",0)
jsonstr=rs(0)
set obj=toObject(jsonstr)
setVarArr(array("cfg_indexname:"&obj.cfg_indexname,"cfg_webname:"&obj.cfg_webname,"cfg_arcdir:"&obj.cfg_arcdir,"cfg_medias_dir:"&obj.cfg_medias_dir,"cfg_df_style:"&obj.cfg_df_style,"cfg_powerby:"&obj.cfg_powerby,"cfg_keywords:"&obj.cfg_keywords,"cfg_description:"&obj.cfg_description,"cfg_beian:"&obj.cfg_beian))
'Generate the page
tpl.Parse
'Destroy our objects
set tpl = nothing
%>