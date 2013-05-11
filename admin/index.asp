<!--#include file="lib/AdminInIt.asp"-->
<%
'tpl.SetTemplatesDir("")
'tpl.setVariableFile "TOP_HTML","public/top.html"
'tpl.setVariableFile "FOOTER_HTML","public/footer.html"
tpl.setvariable "exit_url","?act=exit"
'Generate the page
setvararr(array("a:b"))
tpl.Parse
'Destroy our objects
set tpl = nothing
%>