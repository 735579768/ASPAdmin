<!--#include file="lib/AdminInIt.asp"-->
<%
'tpl.SetTemplatesDir("")
'包含文件
'tpl.setVariableFile "TOP_HTML","public/top.html"
'tpl.setVariableFile "FOOTER_HTML","public/footer.html"

'Generate the page
set rs=db.query("select count(*) as arccount from kl_archives")
tpl.SetVariable "arccount",rs("arccount")&""'有效文章
set rs=db.query("select count(*) as arcyescount from kl_archives where recycling=0")
tpl.SetVariable "arcyescount",rs("arcyescount")&""'有效文章
set rs=db.query("select count(*) as arcnocount from kl_archives where recycling=1")
tpl.SetVariable "arcnocount",rs("arcnocount")&""'回收站文章
set rs=nothing


sql="select top 5 * from kl_archives order by uddate desc"
arr=array("arctitle:arctitle","uddate:uddate")
listblock "arclist",sql,arr

sql="select top 5 * from kl_admin_log order by logintime desc"
loopblock "adminlog",sql
tpl.Parse
'Destroy our objects
set tpl = nothing
%>