<!--#include file="lib/AdminInIt.asp"-->
<%
'oldtpl.SetTemplatesDir("")
'包含文件
'oldtpl.setVariableFile "TOP_HTML","public/top.html"
'oldtpl.setVariableFile "FOOTER_HTML","public/footer.html"

'Generate the page
dim friend_id,friend_name,friend_url,sortrank,friend_weizhi,friend_email
	
if G("act")="updtfriend" then 
	friend_id=G("friend_id")
	friend_name=G("friend_name")
	friend_url=G("friend_url")
	sortrank=G("sortrank")
	if sortrank="" then sortrank =0
	friend_weizhi=G("friend_weizhi")
	friend_email=G("friend_email")
	show=G("show")
	'echo olddb.wAddRecord("kl_friend_link",array("friend_name:"&friend_name,"sortrank:"&sortrank,"friend_url:"&friend_url,"friend_weizhi:"&friend_weizhi,"friend_email:"&friend_email))
	'echo olddb.wUpdateRecord("kl_friend_link","friend_id="&friend_id,array("friend_name:"&friend_name,"sortrank:"&sortrank,"friend_url:"&friend_url,"friend_weizhi:"&friend_weizhi,"friend_email:"&friend_email))
	dim result:result=olddb.UpdateRecord("kl_friend_link","friend_id="&friend_id,array("friend_name:"&friend_name,"sortrank:"&sortrank,"friend_url:"&friend_url,"friend_weizhi:"&friend_weizhi,"friend_email:"&friend_email,"show:"&show))
		if result<>0 then
			AlertMsg(UPDATE_SUCCESS_STR)
		else
			AlertMsg(UPDATE_FAIL_STR)
		end if
end if

	friend_id=G("friend_id")
	set rs=olddb.getRecord("kl_friend_link","*","friend_id="&friend_id,"",0)
	oldtpl.SetVariable "friend_id",rs("friend_id")&""
	oldtpl.SetVariable "friend_name",rs("friend_name")&""
	oldtpl.SetVariable "sortrank",rs("sortrank")&""
	oldtpl.SetVariable "friend_url",rs("friend_url")&""
	oldtpl.SetVariable "friend_weizhi",rs("friend_weizhi")&""
	oldtpl.SetVariable "friend_email",rs("friend_email")&""
	oldtpl.ParseBlock "friendlinklist"
	
oldtpl.Parse
'Destroy our objects
set oldtpl = nothing
%>