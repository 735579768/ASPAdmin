<%

'退出登陆
if getparam("act")="exit" Then
destroyCookies()
echo "<script>parent.window.location.reload();</script>"
die()
end if


'登陆错误信息
dim logerrmsg:logerrmsg=""
'验证登陆
dim Uname,Upwd,zhiye,rs,sqlstr
Uname=getparam("loginname")
Upwd=getparam("loginpwd")
numcode=getparam("numcode")


'如果有用户名和密码传过来的话进行验证
if not isempty(Uname) and not isempty(Upwd)  Then
	'验证码检验
	if numcode<>trim(Session("numcode")) then 
	login("<script>alert('验证码错误！');</script>")
	
	end if
set rs=db.GetRecord(suffix & "admin","*","username='"&Uname&"'","",0)
	if not rs.eof Then
		dim md5pwd:md5pwd=md5(Upwd,32)
		if rs("password")<> md5pwd Then
			login("<script>alert('密码错误！');</script>")
		else
		'echo rs("password")&"--"&md5pwd
			Session("admin_id")=rs("id")'保存管理员在数据表中的id值
			Session.Timeout=30
			Response.Cookies("adminid")=rs("id")
			Response.Cookies("U_name")=Uname
			Response.Cookies("U_pwd")=md5(Upwd,32)
			Response.Cookies("U_name").Expires=now()+1/24
			Response.Cookies("U_pwd").Expires=now()+1/24
		end if
	else
		logerrmsg="用户名不存在"
		login("<script>alert('用户名不存在！');//parent.window.location.reload();</script>")
		
	end if
end if

'检查cookies验证登陆状
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
	'检查cookies验证登陆状态
	function yanzhengCookies()
			if Request.Cookies("U_pwd")="" or Request.Cookies("U_name")="" then  '使用cookies验证登陆状态
				destroyCookies()
				yanzhengCookies=false
		else
			'验证cookies
			set rs=db.GetRecord(suffix & "admin","*","username='"&Request.Cookies("U_name")&"'","",0)
			if not rs.eof Then
				if rs("password") <> Request.Cookies("U_pwd") Then
					destroyCookies()
					yanzhengCookies=false
				else
					Session("admin_id")=rs("id")'保存管理员在数据表中的id值
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
		tpl.SetTemplateFile "login.html" '设置模板文件
		tpl.SetVariable "adminDir","/"&adminDir&"/"
		tpl.setvariable "errstr",errstr
		tpl.Parse
		set tpl = nothing
		die()
	end function
%>
