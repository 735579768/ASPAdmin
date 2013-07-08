<!--#include file="../lib/InIt.asp"-->
<%
msg=G("msg")
uri=G("uri")
tpl.p_tpl_dir=TPL_PATH
tpl.assign "message",msg
tpl.assign "uri",uri
tpl.display("message.html")
%>