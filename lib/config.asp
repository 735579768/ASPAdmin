<%
'////////////////////////////////////
'初始化系统的配置参数
'//////////////////////////////////
'on error resume next 
on error goto 0
session("APP")="true"
'字符集设置
Response.Addheader "Content-Type","text/html; charset=gbk" 

'数据库配置
const Sql_Server = "127.0.0.1" '数据库服务器地址 
const Sql_User = "" '数据库登录名 
const Sql_Pass = "" '数据库密码 
const Sql_Data = "/admin/#data/#aspadmindata.mdb" '数据库名
const suffix ="kl_"

'后台文件夹目录
const adminDir="admin"


'登陆id保存 权限操作超级管理员(0)  普通管理员(1)  
dim login_id
login_id=0


'模板配置
dim TPL_PATH
	TPL_PATH="templates/"
	
'在模板最终输出时进行正则替换第一组替换中间用##隔开
redim regarr(2)
regarr(0)="cat\.asp\?cat_id\=(\d+)##cat-$1.html"
regarr(1)="view\.asp\?id\=(\d+)##view-$1.html"
%>