<!--#include file="lib/AdminInIt.asp"-->
<% if session("APP")<>"true" then reurl("/") end if %>
<%
act=G("act")
on error goto 0
bakmsg=""
if act="bakdata" then
	set fs=server.CreateObject("scripting.FileSystemObject")
	path1=server.MapPath(sql_data)
	curtime=Formatdate(now,0)
	path2=server.MapPath("#data/#bak/"&curtime&".mdb")
	fs.copyFile path1,path2,true
	set fs=nothing
	'set rs=db.GetRecord("kl_admin","*","id="&session("admin_id"),"",0)
	set rs=newdb.query("select * from kl_admin where id="&session("admin_id"))
	adminname=rs("nicheng")
	set rs =newdb.query("select * from kl_databak")
	rs.addnew
	rs("bakname")=curtime&".mdb"
	rs("bakadminname")=adminname
	rs("bakdate")=curtime
	rs("bakdescr")=G("bakdescr")
	rs.update
	set rs=nothing
	bakmsg="备份成功，路径为：<span style='color:'>#data/#bak/"&curtime&".mdb"
end if
if act ="deldb" then 
	set fs=server.CreateObject("scripting.FileSystemObject")
	path2=server.MapPath("#data/#bak/")
	fs.DeleteFile(path2&G(dbname))
	set fs=nothing
	newdb.query("delete from kl_databak  where id="&G("id"))
end if
if act ="hydb" then 
	set fs=server.CreateObject("scripting.FileSystemObject")
	path1=server.MapPath(sql_data)
	path2=server.MapPath("#data/#bak/")
	path2=path2&"\"&G("dbname")
	'echo path2
	fs.copyFile path2,path1,true
	set fs=nothing
	bakmsg="<script>alert(' "&G("dbname")&" 还原成功!')</script>"
end if
newtpl.assign "bakmsg",bakmsg
newtpl.assign "dbpath",Sql_Data
set rs=newdb.table("kl_databak").order("id desc").sel()
rsarr=newdb.rsToArr(rs)
newtpl.assign "baklist",rsarr
newtpl.display("bakdata.html")
%>