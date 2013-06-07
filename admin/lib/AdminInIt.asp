<!--#INCLUDE FILE="../../lib/init.asp"-->
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

'=======================初始化新模板类和数据库
set newtpl=New ASPtpl
'设置模板目录
'tpl.SetTemplatesDir(TPL_PATH)
'初始化数据库db类
Set newdb = new Accessdb
%>
<!--#INCLUDE FILE="common.asp"-->
<!--#INCLUDE FILE="loginsafe.asp"-->