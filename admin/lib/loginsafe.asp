<%

'�˳���½
if getparam("act")="exit" Then
destroyCookies()
echo "<script>parent.window.location.reload();</script>"
die()
end if


'��½������Ϣ
dim logerrmsg:logerrmsg=""
'��֤��½
dim Uname,Upwd,zhiye,rs,sqlstr
Uname=getparam("loginname")
Upwd=getparam("loginpwd")
numcode=getparam("numcode")


'������û��������봫�����Ļ�������֤
if Uname<>"" and Upwd<>"" and numcode<>"" Then
	'��֤�����
	if numcode<>trim(Session("numcode")) then 
		login("<script>alert('��֤�����');</script>")
	end if
set rs=db.GetRecord(suffix & "admin","*","username='"&Uname&"'","",0)
	if not rs.eof Then
		dim md5pwd:md5pwd=md5(Upwd,32)
		if rs("password")<> md5pwd Then
			login("<script>alert('�������');</script>")
		else
		'echo rs("password")&"--"&md5pwd
			'���µ�½����
			result=db.UpdateRecord("kl_admin","id="&rs("id"),array("logintimes:"&(rs("logintimes")+1)))
			'��¼��½��־
			result=db.AddRecord("kl_admin_log",array("uname:"&rs("username"),"loginip:"&getip(),"qx_id:"&rs("qx_id")))
			Session("admin_id")=rs("id")'�������Ա�����ݱ��е�idֵ
			Session("admin_qx_id")=rs("qx_id")'�������Ա�����ݱ��е�idֵ
			Session.Timeout=30
			Response.Cookies("adminid")=rs("id")
			Response.Cookies("U_name")=Uname
			Response.Cookies("U_pwd")=md5(Upwd,32)
			Response.Cookies("U_name").Expires=now()+1/24
			Response.Cookies("U_pwd").Expires=now()+1/24
		end if
	else
		logerrmsg="�û���������"
		login("<script>alert('�û��������ڣ�');//parent.window.location.reload();</script>")
		
	end if
end if

'���cookies��֤��½״
if not yanzhengCookies() then 
	login("")
end if
act=getparam("act")
if act="ajax" then
%>
<!-- #include file="ajax.asp" -->
<%
end if
'///////////////////////////////////////////////////////////////////////////////////////
	'���cookies��֤��½״̬
	function yanzhengCookies()
			if Request.Cookies("U_pwd")="" or Request.Cookies("U_name")="" then  'ʹ��cookies��֤��½״̬
				destroyCookies()
				yanzhengCookies=false
		else
			'��֤cookies
			set rs=db.GetRecord(suffix & "admin","*","username='"&Request.Cookies("U_name")&"'","",0)
			if not rs.eof Then
				if rs("password") <> Request.Cookies("U_pwd") Then
					destroyCookies()
					yanzhengCookies=false
				else
					Session("admin_id")=rs("id")'�������Ա�����ݱ��е�idֵ
					Session.Timeout=30
					Response.Cookies("adminid")=rs("id")
					Response.Cookies("U_name")=Request.Cookies("U_name")
					Response.Cookies("U_pwd")=Request.Cookies("U_pwd")
					Response.Cookies("U_name").Expires=now()+1/24
					Response.Cookies("U_pwd").Expires=now()+1/24
					yanzhengCookies=true
				end if
			end if
		end if
	end function
	function login(errstr)	
		tpl.SetTemplateFile "login.html" '����ģ���ļ�
		tpl.SetVariable "adminDir","/"&adminDir&"/"
		tpl.setvariable "errstr",errstr
		tpl.Parse
		set tpl = nothing
		die()
	end function
%>
