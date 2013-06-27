<!--#include file="lib/AdminInIt.asp"-->
<%
typeid=G("type_id")
set rs=newdb.table("kl_archives").sel()
redim arr(rs.fields.count)
i=0
for each a in rs.fields
arr(i)=a.name
i=i+1
next
newtpl.assign "arr",arr
newtpl.display("edit_field.html")
%>