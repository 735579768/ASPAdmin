<!--#include file="lib/AdminInIt.asp"-->
<%
on error resume next
if G("upcfg")="true" then 
	Set o = jsObject()
	for each a in request.Form
		o(a)=G(a)
	next
	set rs=newdb.table("kl_meta").where("meta_key='cfg_system'").sel()
	rs("meta_value")=tojson(o)
	rs.update
	'result=olddb.UpdateRecord("kl_meta","meta_key='cfg_system'",array("meta_value:"&tojson(o)))
	if err.number=0 then 
	reurl("config.asp")
	end if
	set rs=nothing
end if



set rs=db.table("kl_meta").where("meta_key='cfg_system'").fild("meta_value").sel()
jsonstr=rs(0)&""
set cfgobj=jsontoobj(jsonstr)
newtpl.assign "cfgobj",cfgobj

set dir=server.CreateObject("Scripting.Dictionary")
dir("0")="关闭"
dir("1")="启用"
newtpl.assign "radioarr",dir
newtpl.assign "yasuoradioarr",dir
newtpl.assign "seled",cfgobj("cfg_weijingtai")
newtpl.assign "yasuoseled",cfgobj("cfg_pageyasuo")
set dir=nothing






'set rs=newdb.table("kl_meta").fild("meta_value").where("meta_key='cfg_system'").sel()
'jsonstr=rs(0)
'set obj=toObject(jsonstr)
'newtpl.assign "cfg_indexname",obj.cfg_indexname
'newtpl.assign "cfg_webname",obj.cfg_webname
'newtpl.assign "cfg_arcdir",obj.cfg_arcdir
'newtpl.assign "cfg_medias_dir",obj.cfg_medias_dir
'newtpl.assign "cfg_df_style",obj.cfg_df_style
'newtpl.assign "cfg_powerby",obj.cfg_powerby
'newtpl.assign "cfg_keywords",obj.cfg_keywords
'newtpl.assign "cfg_description",obj.cfg_description
'newtpl.assign "cfg_beian",obj.cfg_beian
'newtpl.assign "cfg_thirdcode",obj.cfg_thirdcode
newtpl.display("config.html")

'set rs=olddb.getRecord("kl_meta","meta_value","meta_key='cfg_system'","",0)
'jsonstr=rs(0)
'set obj=toObject(jsonstr)
'setVarArr(array("cfg_indexname:"&obj.cfg_indexname,"cfg_webname:"&obj.cfg_webname,"cfg_arcdir:"&obj.cfg_arcdir,"cfg_medias_dir:"&obj.cfg_medias_dir,"cfg_df_style:"&obj.cfg_df_style,"cfg_powerby:"&obj.cfg_powerby,"cfg_keywords:"&obj.cfg_keywords,"cfg_description:"&obj.cfg_description,"cfg_beian:"&obj.cfg_beian,"cfg_thirdcode:"&obj.cfg_thirdcode))
'oldtpl.Parse
'set oldtpl = nothing
%>