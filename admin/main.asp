<!--#include file="lib/AdminInIt.asp"-->
<%
'tpl.SetTemplatesDir("")
'�����ļ�
'tpl.setVariableFile "TOP_HTML","public/top.html"
'tpl.setVariableFile "FOOTER_HTML","public/footer.html"

'Generate the page
set rs=db.query("select count(*) as arccount from kl_articles")
tpl.SetVariable "arccount",rs("arccount")&""'��Ч����
set rs=db.query("select count(*) as arcyescount from kl_articles where recycling=0")
tpl.SetVariable "arcyescount",rs("arcyescount")&""'��Ч����
set rs=db.query("select count(*) as arcnocount from kl_articles where recycling=1")
tpl.SetVariable "arcnocount",rs("arcnocount")&""'����վ����
set rs=nothing
tpl.Parse
'Destroy our objects
set tpl = nothing
%>