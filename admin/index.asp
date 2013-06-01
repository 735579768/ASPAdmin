<!--#include file="lib/AdminInIt.asp"-->
<%
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

tpl.Parse
set tpl = nothing
%>