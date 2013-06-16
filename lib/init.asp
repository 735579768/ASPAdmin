<!--#INCLUDE FILE="config.asp"-->
<!--#INCLUDE file="lang.asp"-->
<!--#INCLUDE file="common/safe.asp"-->
<!--#INCLUDE FILE="common/Functions.asp"-->
<!--#INCLUDE file="common/md5.asp"-->
<!--#INCLUDE FILE="AspTpl.class.asp"-->
<!--#INCLUDE file="AspTplPlug.class.asp"-->
<!--#INCLUDE file="class/Tpl.class.asp"-->
<!--#INCLUDE file="class/Accessdb.class.asp"-->
<!--#INCLUDE FILE="db.class.asp"-->
<!--#INCLUDE FILE="json.asp"-->
<%
'查询数据测试
'set rs=db.GetRecordBySQL("select * from kj_admin") 
'初始化模板引擎
set tpl=New ASPtpl
'设置模板目录
tpl.p_tpl_dir=TPL_PATH&"/"&themes
'初始化数据库db类
Set db = new Accessdb

'初始化页面标题，关键字，描述
'set rs=db.query("select meta_value from kl_meta where meta_key='cfg_system'")
'set obj=toObject(rs(0)&"")
''arr=toArray(rs(0)&"")
'setVarArr(array("cfg_indexname:"&obj.cfg_indexname,"cfg_webname:"&obj.cfg_webname,"cfg_arcdir:"&obj.cfg_arcdir,"cfg_medias_dir:"&obj.cfg_medias_dir,"cfg_df_style:"&obj.cfg_df_style,"cfg_powerby:"&obj.cfg_powerby,"cfg_keywords:"&obj.cfg_keywords,"cfg_description:"&obj.cfg_description,"cfg_beian:"&obj.cfg_beian))
'set obj=nothing

%>