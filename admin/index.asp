<!--#include file="lib/AdminInIt.asp"-->
<%
'tpl.SetTemplatesDir("")
'tpl.setVariableFile "TOP_HTML","public/top.html"
'tpl.setVariableFile "FOOTER_HTML","public/footer.html"
tpl.setvariable "exit_url","?act=exit"
tpl.setvariable "uname",Request.Cookies("U_name")&""
'Generate the page
tpl.Parse
'Destroy our objects
set tpl = nothing
%>