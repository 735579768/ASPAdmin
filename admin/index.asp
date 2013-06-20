<!--#include file="lib/AdminInIt.asp"-->
<%
oldtpl.setvariable "exit_url","?act=exit"
uname=Request.Cookies("U_name")&""
oldtpl.setvariable "uname",uname
set rs=olddb.query("select top 2 logintime from kl_admin_log where uname='"&uname&"'")
if rs.recordcount=2 then
rs.movenext
oldtpl.setvariable "lastdate",cstr(rs(0))
else
oldtpl.setvariable "lastdate","null"
end if

oldtpl.Parse
set oldtpl = nothing
%>