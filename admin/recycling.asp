<!--#include file="lib/AdminInIt.asp"-->
<!--#include file="../lib/page.class.asp"-->
<%
'移出回收站
	'首先是单个移出
	if G("act")="huanyuan" then
			if G("id")<>"" then 
				id=G("id")
				result=db.UpdateRecord("kl_archives","id="&id,array("recycling:0"))
					if result=0 then
						AlertMsg(CAOZUO_FAIL_STR)
					end if
			end if
		'批量移出
		if G("batchid")<>"" then
		
			str=G("batchid")
			arr=split(str,",")
			dim result
			for i=0 to ubound(arr)
				result=db.UpdateRecord("kl_archives","id="&arr(i),array("recycling:0"))
			next
				if result=0 then
					AlertMsg(CAOZUO_FAIL_STR)
				end if
		end if
	end if
'彻底删除
	if G("act")="del" then
			if G("id")<>"" then 
				id=G("id")
				result=db.DeleteRecord("kl_archives","id",id)
					if result=0 then
						AlertMsg(CAOZUO_FAIL_STR)
					end if
			end if
		'批量删除
		if G("batchid")<>"" then
			str=G("batchid")
			arr=split(str,",")
			result=""
			for i=0 to ubound(arr)
				result=db.DeleteRecord("kl_archives","id",arr(i))
			next
				if result=0 then
					AlertMsg(CAOZUO_FAIL_STR)
				end if
		end if	
	end if
'tpl.SetTemplatesDir("")
'包含文件
'tpl.setVariableFile "TOP_HTML","public/top.html"
'tpl.setVariableFile "FOOTER_HTML","public/footer.html"
'创建对象
Set mypage=new xdownpage
'得到数据库连接
mypage.getconn=db.idbconn
'sql语句
mypage.getsql="SELECT a.id,a.arctitle,a.fbdate,a.arcflag,a.uddate,b.cat_name,c.type_name,a.arccontent,a.arcpic,a.recycling  from (kl_archives as a inner join  kl_cats as b on a.cat_id=b.cat_id) inner join kl_content_types as c on a.type_id=c.type_id  where recycling=1 order by fbdate desc"
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
	tpl.SetVariable "id",rs("id")&""
	tpl.SetVariable "title",rs("arctitle")&""
	tpl.SetVariable "arctitle",left(rs("arctitle")&"",15)
	tpl.SetVariable "uddate",rs("uddate")&""
	tpl.SetVariable "fbdate",rs("fbdate")&""
	tpl.SetVariable "cat_name",rs("cat_name")&""
	tpl.SetVariable "type_name",rs("type_name")&""
	tpl.SetVariable "arccontent",rs("arccontent")&""
		'组合文章属性
		arcsx=rs("arcflag")&""
		arr=split(arcsx,",")
		flagstr=""
		for j=0 to ubound(arr)
			select case arr(j)
				case "H":
					flagstr=flagstr&"[<span style='color:red;' title='首页推荐'>首</span>]"
				case "C":
					flagstr=flagstr&"[<span style='color:red;' title='头条文章'>头</span>]"
			end select
		next
	tpl.SetVariable "flagstr",flagstr
	tpl.ParseBlock "arclist"
	rs.movenext
    else
         exit for
    end if
next
'显示分页信息，这个方法可以，在set rs=mypage.getrs()以后,可在任意位置调用，可以调用多次
tpl.setvariable "pagenav",mypage.getshowpage()
'Generate the page
tpl.Parse
'Destroy our objects
set tpl = nothing
%>