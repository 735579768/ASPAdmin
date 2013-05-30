<!--#include file="lib/AdminInIt.asp"-->
<!--#include file="../lib/page.class.asp"-->
<%
'tpl.SetTemplatesDir("")
'包含文件
'Generate the page

		'批量删除
		if G("batchid")<>"" then
			str=G("batchid")
			arr=split(str,",")
			result=""
			for i=0 to ubound(arr)
				result=db.DeleteRecord("kl_comments","id",arr(i))
			next
				if result=0 then
					AlertMsg(CAOZUO_FAIL_STR)
				end if
		end if	
		
	if G("act")="del" then
		result=db.query("delete from kl_comments where id="&G("id"))
'			if result=0 then
'				AlertMsg(CAOZUO_FAIL_STR)
'			end if
	end if
	
	sql="select * from kl_comments order by fbdate desc "
	loopBlockpage "commentllist",sql,20

tpl.Parse
'Destroy our objects
set tpl = nothing
%>