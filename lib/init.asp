<!--#INCLUDE FILE="safe.asp"-->
<!--#INCLUDE FILE="config.asp"-->
<!--#INCLUDE FILE="common/Functions.asp"-->
<!--#INCLUDE FILE="md5.asp"-->
<!--#INCLUDE FILE="AspTpl.class.asp"-->
<!--#INCLUDE FILE="AspTplPlug.asp"-->
<!--#INCLUDE FILE="db.class.asp"-->
<%
'��ʼ��ģ������
set tpl=New ASPTemplate
'����ģ��Ŀ¼
tpl.SetTemplatesDir(TPL_PATH)

set fs=Server.CreateObject("Scripting.FileSystemObject") 
if fs.FileExists(server.MapPath(tpl.p_templates_dir & getRunFileName()&".html")) then
	tpl.SetTemplateFile getRunFileName()&".html" '����ģ���ļ�
end if
set fs=nothing

'��ʼ�����ݿ�db��
Set db = new AspDb 
db.dbConn=Oc(CreatConn("ACCESS",Sql_Data,"","","")) 
'��ѯ���ݲ���
'set rs=db.GetRecordBySQL("select * from kj_admin") 

%>