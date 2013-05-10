<!--#INCLUDE FILE="safe.asp"-->
<!--#INCLUDE FILE="config.asp"-->
<!--#INCLUDE FILE="common/Functions.asp"-->
<!--#INCLUDE FILE="md5.asp"-->
<!--#INCLUDE FILE="AspTpl.class.asp"-->
<!--#INCLUDE FILE="AspTplPlug.asp"-->
<!--#INCLUDE FILE="db.class.asp"-->
<%
'初始化模板引擎
set tpl=New ASPTemplate
'设置模板目录
tpl.SetTemplatesDir(TPL_PATH)

set fs=Server.CreateObject("Scripting.FileSystemObject") 
if fs.FileExists(server.MapPath(tpl.p_templates_dir & getRunFileName()&".html")) then
	tpl.SetTemplateFile getRunFileName()&".html" '设置模板文件
end if
set fs=nothing

'初始化数据库db类
Set db = new AspDb 
db.dbConn=Oc(CreatConn("ACCESS",Sql_Data,"","","")) 
'查询数据测试
'set rs=db.GetRecordBySQL("select * from kj_admin") 

%>