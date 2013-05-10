<%
if request("menuid")<>"" then
session("menuid")=request("menuid")
end if
%>
<%
'采用的安全方法是给所有的后台页面编号，然后和所要打开页面编号对比，然后同数据库该用户访问权限对比。
onmenuid=session("menuid")
username=session("username")
flag=session("flag")
id=session("id")

if onmenuid="" then
response.write "1"
response.End()
response.redirect "../index.asp"
response.end
end if

if username="" then
response.write "2"
response.End()
response.redirect "../index.asp"
response.end
end if

if flag="" then
response.write "3"
response.End()
response.redirect "../index.asp"
response.end
end if

if id="" then
response.write "4"
response.End()
response.redirect "../index.asp"
response.end
end if

if int(onmenuid)<>int(menuid) then
response.write "5"
response.End()
response.redirect "../index.asp"
response.end
end if

sql = "select * from menux_my where username='"&session("flag")&"' and menuid="&onmenuid&""
rs.open sql,conn,1,3
  if rs.eof and rs.bof then
response.redirect "../index.asp"
  response.end
  end if
  rs.close
%>






