<!--#include file="lib/AdminInIt.asp"-->
<%
'tpl.SetTemplatesDir("")
'tpl.setVariableFile "TOP_HTML","public/top.html"
'tpl.setVariableFile "FOOTER_HTML","public/footer.html"
sql="select * from kl_admin as  a  inner join kl_admin_qx as b on a.qx_id=b.qx_id"
keyvaluarr=array("uname:username","id:id","nicheng:nicheng","qx_name:qx_name","logintimes:logintimes","qx_id:b.qx_id")
listBlock "adminlist",sql,keyvaluarr
set rs=nothing
'Generate the page
tpl.Parse
'Destroy our objects
set tpl = nothing
%>