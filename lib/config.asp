<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
'////////////////////////////////////
'config file
'//////////////////////////////////
''bakon error resume next 
on error goto 0
session("APP")="true"

'Response.Addheader "Content-Type","text/html; charset=utf-8" 
const app_debug=false
'database config
const Sql_Server = "127.0.0.1" 'server
const Sql_User = "" 'datauser 
const Sql_Pass = "" 'datapwd
const Sql_Data = "/admin/#data/#aspadmindata.mdb" '鏁版嵁搴撳悕
const suffix ="kl_"

'admin dir name
const adminDir="admin"
const themes="default"


dim login_id
login_id=0


'tpl dir
dim TPL_PATH
	TPL_PATH="tpl"
	
'在模板最终输出时进行正则替换第一组替换中间用##隔开
redim regarr(4)
regarr(0)="cat\.asp\?catid\=(\d+)\&page\=(\d+)##cat-$1-$2.html"
regarr(1)="cat\.asp\?catid\=(\d+)##cat-$1.html"
regarr(2)="view\.asp\?id\=(\d+)##view-$1.html"
regarr(3)="charset=gb2312##charset=utf-8"
%>