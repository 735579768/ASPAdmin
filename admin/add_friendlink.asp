<!--#include file="lib/AdminInIt.asp"-->
<%
'tpl.SetTemplatesDir("")
'包含文件
'tpl.setVariableFile "TOP_HTML","public/top.html"
'tpl.setVariableFile "FOOTER_HTML","public/footer.html"

'Generate the page
dim friend_id,friend_name,friend_url,sortrank,friend_weizhi,friend_email
	
if G("act")="addfriend" then 
	friend_id=G("friend_id")
	friend_name=G("friend_name")
	friend_url=G("friend_url")
	sortrank=G("sortrank")
	friend_weizhi=G("friend_weizhi")
	friend_email=G("friend_email")
	show=G("show")
	'echo db.wAddRecord("kl_friend_link",array("friend_name:"&friend_name,"sortrank:"&sortrank,"friend_url:"&friend_url,"friend_weizhi:"&friend_weizhi,"friend_email:"&friend_email))
	dim result:result=db.AddRecord("kl_friend_link",array("friend_name:"&friend_name,"sortrank:"&sortrank,"friend_url:"&friend_url,"friend_weizhi:"&friend_weizhi,"friend_email:"&friend_email,"show:"&show))
		if result<>0 then
			AlertMsg(ADD_SUCCESS_STR)
		else
			AlertMsg(ADD_FAIL_STR)
		end if
end if
tpl.Parse
'Destroy our objects
set tpl = nothing
%>