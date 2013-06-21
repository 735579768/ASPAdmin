<!--#include file="lib/AdminInIt.asp"-->
<% if session("APP")<>"true" then reurl("/") end if %>
<%
'添加信息
	if G("isaddxx")="true" 
		err.clear
		cat_id=G("cat_id")
		sql="select b.data_table as datatable from kl_cats as a inner join kl_content_types as b on a.type_id=b.type_id where a.cat_id="&cat_id
		set rs=olddb.query(sql)
		datatable=rs("datatable")
		
				set uprs=server.createobject("adodb.recordset")
				uprs.open "select * from "&datatable,olddb.idbconn,1,3
				uprs.addNew
				for each key in request.Form()
					 if  key<>"isaddarticle" then
						val=G(key)
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
%>