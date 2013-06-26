<!--#include file="lib/AdminInIt.asp"-->
<%
'oldtpl.SetTemplatesDir("")
'包含文件
'Generate the page

		'批量删除
		if G("batchid")<>"" then
			str=G("batchid")
			arr=split(str,",")
			result=""
			for i=0 to ubound(arr)
				result=olddb.DeleteRecord("kl_comments","id",arr(i))
			next
				if result=0 then
					AlertMsg(CAOZUO_FAIL_STR)
				end if
		end if	
		
	if G("act")="del" then
		result=olddb.query("delete from kl_comments where id="&G("id"))
		echo "<script>window.location='comments.asp';</script>"
	end if
	sql="select * from kl_comments order by fbdate desc "

newtpl.assign "sql",sql
newtpl.assign "page",G("page")
newtpl.display("comments.html")
%>