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

'初始化模板引擎
set tpl=New ASPtpl
'设置模板目录
tpl.p_tpl_dir=TPL_PATH&"/"&themes
'初始化数据库db类
Set db = new Accessdb

'输出页面优化内容
set rs=db.table("kl_meta").where("meta_key='cfg_system'").fild("meta_value").sel()
jsonstr=rs(0)&""
set seoobj=jsontoobj(jsonstr)
tpl.assign "indexseo",seoobj

'伪静态规则
'在模板最终输出时进行正则替换第一组替换中间用##隔开
dim url_suffex:url_suffex=".html"
redim regarr(4)
regarr(0)="cat\.asp\?catid\=(\d+)\&page\=(\d+)##cat-$1-$2"&url_suffex
regarr(1)="cat\.asp\?catid\=(\d+)##cat-$1"&url_suffex
regarr(2)="view\.asp\?id\=(\d+)##view-$1"&url_suffex
regarr(3)="charset=gb2312##charset=utf-8"
regarr(3)="search\.asp##search"
%>