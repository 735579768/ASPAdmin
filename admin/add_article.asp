<!--#include file="lib/AdminInIt.asp"-->
<% if session("APP")<>"true" then reurl("/") end if %>
<%
'添加文章
	if G("isaddarticle")="true" then
'		'bakon error resume next
		err.clear
		cat_id=G("cat_id")
		sql="select b.data_table as datatable from kl_cats as a inner join kl_content_types as b on a.type_id=b.type_id where a.cat_id="&cat_id
		set rs=db.query(sql)
		datatable=rs("datatable")
		
				set uprs=server.createobject("adodb.recordset")
				uprs.open "select * from "&datatable,db.idbconn,1,3
				uprs.addNew
				
				for each key in request.Form()
					 if  key<>"isaddarticle" then
						val=G(key)
'						if not isnumeric(val) then
'							val="'"&val&"'"
'						end if
						'echo val&"<br>"
						'echo key&"<br>"
						uprs(key)=val
					 end if
				next
				uprs("fbdate")=FormatDate(now,2)
				uprs("uddate")=FormatDate(now,2)
				if(G("arcdescr")="") then uprs("arcdescr")=left(removehtml(G("arccontent")),30)
				uprs.update
				
				if err.number<>0 then
					echoErr()
					AlertMsg(ADD_FAIL_STR)
					err.clear
				else
					AlertMsg(ADD_SUCCESS_STR)
				end if
	end if
'添加文章时取传递过来的分类
cat_id=G("cat_id")
if cat_id="" then echo "<script>window.history.go(-1);</script>":die("") end if
set rs=db.query("select a.type_id as typeid, * from kl_cats as a inner join kl_content_types as b on a.type_id=b.type_id where a.cat_id="&cat_id)
tpl.setVariable "arctpl",rs("cat_article")&""
tpl.setVariable "cat_name",rs("cat_name")&""
tpl.setVariable "type_name",rs("type_name")&""
tpl.setVariable "type_id",rs("typeid")&""


uname=Request.Cookies("U_name")&""
set nirs=db.query("select top 1 * from kl_admin where username='"&uname&"'")
val=cstr(nirs("nicheng")&"")
if val="" then
	val=uname
end if
set nirs=nothing
tpl.setVariable "author",val
tpl.setVariable "source","http://"&cstr(Request.ServerVariables("SERVER_NAME"))


'tpl.SetVariable "typeidsel",getContentTypeSel()
tpl.SetVariable "catidsel",getArcCatSel()


tpl.SetTemplateFile rs("tpl_addform")&""'getAddform(cat_id)
tpl.Parse
'Destroy our objects
set tpl = nothing
%>