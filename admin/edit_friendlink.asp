<!--#include file="lib/AdminInIt.asp"-->
<%
'tpl.SetTemplatesDir("")
'°üº¬ÎÄ¼þ
'tpl.setVariableFile "TOP_HTML","public/top.html"
'tpl.setVariableFile "FOOTER_HTML","public/footer.html"

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
	'echo db.wAddRecord("kl_friend_link",array("friend_name:"&friend_name,"sortrank:"&sortrank,"friend_url:"&friend_url,"friend_weizhi:"&friend_weizhi,"friend_email:"&friend_email))
	'echo db.wUpdateRecord("kl_friend_link","friend_id="&friend_id,array("friend_name:"&friend_name,"sortrank:"&sortrank,"friend_url:"&friend_url,"friend_weizhi:"&friend_weizhi,"friend_email:"&friend_email))
	dim result:result=db.UpdateRecord("kl_friend_link","friend_id="&friend_id,array("friend_name:"&friend_name,"sortrank:"&sortrank,"friend_url:"&friend_url,"friend_weizhi:"&friend_weizhi,"friend_email:"&friend_email))
		if result<>0 then
			AlertMsg(UPDATE_SUCCESS_STR)
		else
			AlertMsg(UPDATE_FAIL_STR)
		end if
end if

	friend_id=G("friend_id")
	set rs=db.getRecord("kl_friend_link","*","friend_id="&friend_id,"",0)
	tpl.SetVariable "friend_id",rs("friend_id")&""
	tpl.SetVariable "friend_name",rs("friend_name")&""
	tpl.SetVariable "sortrank",rs("sortrank")&""
	tpl.SetVariable "friend_url",rs("friend_url")&""
	tpl.SetVariable "friend_weizhi",rs("friend_weizhi")&""
	tpl.SetVariable "friend_email",rs("friend_email")&""
	tpl.ParseBlock "friendlinklist"
	
tpl.Parse
'Destroy our objects
set tpl = nothing
%>