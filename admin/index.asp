<!--#include file="lib/AdminInIt.asp"-->
<%
'tpl.SetTemplatesDir("")
'tpl.setVariableFile "TOP_HTML","public/top.html"
'tpl.setVariableFile "FOOTER_HTML","public/footer.html"
tpl.setvariable "exit_url","?act=exit"
uname=Request.Cookies("U_name")&""
tpl.setvariable "uname",uname
set rs=db.query("select top 2 logintime from kl_admin_log where uname='"&uname&"'")
if rs.recordcount=2 then
rs.movenext
tpl.setvariable "lastdate",cstr(rs(0))
else
tpl.setvariable "lastdate","null"
end if

'Generate the page
tpl.Parse
'Destroy our objects
set tpl = nothing
%>