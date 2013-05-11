<!--#include file="lib/AdminInIt.asp"-->
<!--#include file="../lib/page.class.asp"-->
<%
'tpl.SetTemplatesDir("")
'tpl.setVariableFile "TOP_HTML","public/top.html"
'tpl.setVariableFile "FOOTER_HTML","public/footer.html"

id=G("id")
	if id<>"" then
		result=db.deleteRecord("kl_admin_log","id",id)
	end if


sql="select * from kl_admin_log as  a  inner join kl_admin_qx as b on a.qx_id=b.qx_id order by id desc"
keyvaluarr=array("uname:uname","id:id","qx_name:qx_name","logintime:logintime","loginip:loginip")
listBlockPage "adminlist",sql,keyvaluarr,20
set rs=nothing
'Generate the page
tpl.Parse
'Destroy our objects
set tpl = nothing
%>