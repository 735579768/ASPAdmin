<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
'////////////////////////////////////
'config file
'//////////////////////////////////
''bakon error resume next 
on error goto 0
session("APP")="true"
'运行时间计算
dim end_time,start_time,time_ijob
start_time=timer()
'=======================静态配置======================" 
'database config
const Sql_Server = "127.0.0.1" 'server
const Sql_User = "" 'datauser 
const Sql_Pass = "" 'datapwd
dim site_root:site_root=replace(server.mappath("/")&"/","\","/")
dim Sql_Data:Sql_Data =site_root&"admin/#data/#aspadmindata.mdb" '鏁版嵁搴撳悕
const suffix ="kl_"
const adminDir="admin"
'=======================动态配置======================" 
dim themes:themes="default"'主题目录
dim app_debug:app_debug=true
dim login_id:login_id=0
dim TPL_PATH:TPL_PATH="tpl"
%>