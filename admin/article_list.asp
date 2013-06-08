<!--#include file="lib/AdminInIt.asp"-->
<!--#include file="../lib/page.class.asp"-->
<%
act=G("act")
if act="arctj" then
db.query("update kl_archives set hometj=1 where id="&G("id"))
end if
if act="arcnotj" then
db.query("update kl_archives set hometj=0 where id="&G("id"))
end if
'移动回收站
if act="huishousingle" then
		id=G("id")
		result=db.UpdateRecord("kl_archives","id="&id,array("recycling:1"))
		if result=0 then
			AlertMsg("操作失败")
		end if
end if
if G("batchid")<>"" then
	str=G("batchid")
	arr=split(str,",")
	dim result
	for i=0 to ubound(arr)
		result=db.UpdateRecord("kl_archives","id="&arr(i),array("recycling:1"))
	next
		if result=0 then
			AlertMsg(CAOZUO_FAIL_STR)
		end if
end if

'表单过滤分类条件
tpl.setvariable "selcatid",getArcCatSel()
tpl.setvariable "seltypeid",getContentTypeSel()
where=" where recycling=0 "
'搜索类型
if G("type_id")<>"0" and G("type_id")<>""  then
	where=where&" and a.type_id="&G("type_id")&" "	
end if
'搜索分类
if G("cat_id")<>"0" and G("cat_id")<>""  then
	where=where&" and a.cat_id="&G("cat_id")&" "	
end if
'搜索关键字
if G("keywords")<>"" then
	where=where&" and a.arctitle like '%"&G("keywords")&"%' "
	tpl.SetVariable "keywords",G("keywords")
end if
'搜索首页推荐
if G("hometj")<>"" and G("hometj")<>"2" then
	where=where&" and hometj="&G("hometj")&" "
end if


sqlstr="SELECT a.id,a.cat_id as catid,a.arctitle,a.fbdate,a.arcflag,a.uddate,b.cat_name,c.type_name,a.arccontent,a.arcpic,a.recycling,a.archits,* from (kl_archives as a inner join  kl_cats as b on a.cat_id=b.cat_id) inner join kl_content_types as c on b.type_id=c.type_id   "& where &" order by fbdate desc"

'//////////////////////////////////////////////////////////////////////////////////////////
'创建对象
Set mypage=new xdownpage
'得到数据库连接
mypage.getconn=db.idbconn
'sql语句
mypage.getsql=sqlstr
'设置每一页的记录条数据为5条
mypage.pagesize=15
'返回Recordset
set rs=mypage.getrs()


'显示数据
'set rs=db.query("SELECT a.id,a.arctitle,a.fbdate,b.cat_name,c.type_name,a.arccontent,a.arcpic,a.recycling  from (kl_archives as a inner join  kl_cats as b on a.cat_id=b.cat_id) inner join kl_content_types as c on a.type_id=c.type_id")
	tpl.UpdateBlock "arclist"
	
	'输出文章列表
for i=1 to mypage.pagesize
	if not rs.eof then
	tpl.SetVariable "page",G("page")
	tpl.SetVariable "id",rs("id")&""
	tpl.SetVariable "cat_id",rs("catid")&""
	tpl.SetVariable "title",rs("arctitle")&""
	tpl.SetVariable "arctitle",left(rs("arctitle")&"",15)
	tpl.SetVariable "uddate",rs("uddate")&""
	tpl.SetVariable "fbdate",rs("fbdate")&""
	tpl.SetVariable "cat_name",rs("cat_name")&""
	tpl.SetVariable "type_name",rs("type_name")&""
	tpl.SetVariable "arccontent",rs("arccontent")&""
	tpl.SetVariable "archits",rs("archits")&""
	if cstr(rs("hometj"))=0 then
		tpl.SetVariable "tuijian","<a  href='?page="&G("page")&"&act=arctj&id="&rs("id")&"' >未推荐</a>"
	else
		tpl.SetVariable "tuijian","<a style='color:red;' href='?page="&G("page")&"&act=arcnotj&id="&rs("id")&"' >已推荐</a>"
	end if
		'组合文章属性
		arcsx=rs("arcflag")&""
		arr=split(arcsx,",")
		flagstr=""
		for j=0 to ubound(arr)
			select case Ucase(arr(j))
				case "C":
					flagstr=flagstr&"[<span style='color:red;' title='首页推荐'>首</span>]"
				case "H":
					flagstr=flagstr&"[<span style='color:red;' title='头条文章'>头</span>]"
			end select
		next
	tpl.SetVariable "flagstr",flagstr
	
	tpl.SetVariable "haveimg",getarcimg(rs("arcpic")&"")
	tpl.ParseBlock "arclist"
	rs.movenext
    else
         exit for
    end if
next
'显示分页信息，这个方法可以，在set rs=mypage.getrs()以后,可在任意位置调用，可以调用多次
tpl.setvariable "pagenav",mypage.getshowpage()
tpl.Parse
'Destroy our objects
set tpl = nothing


'判断文章是否有图
function getarcimg(str)
	if str<>"" then
		getarcimg="<div class='catimg'><img class='haveimg' src='images/haveimg.gif' style='cursor:pointer;' width='12' height='12' alt='分类封面有图片显示' title='分类封面有图片显示' /><span class='catdaimg' ><img src='"&str&"' width='150' height='150' /></span></div>"
	
		'getarcimg="[<img src='images/haveimg.gif' style='cursor:pointer; border:none;' width='12' height='12' alt='文章有图片显示' title='文章有图片显示' />]"
	else
		getarcimg=""
	end if
end function
%>