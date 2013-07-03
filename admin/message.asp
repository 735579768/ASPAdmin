<!--#include file="lib/AdminInIt.asp"-->
<%
msg=G("msg")
uri=G("uri")
newtpl.assign "message",msg
newtpl.assign "uri",uri
newtpl.display("message.html")
%>