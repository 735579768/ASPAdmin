<!--#include file="lib/AdminInIt.asp"-->
<%
'oldtpl.SetTemplatesDir("")
'包含文件
'oldtpl.setVariableFile "TOP_HTML","public/top.html"
'oldtpl.setVariableFile "FOOTER_HTML","public/footer.html"
'创建对象
Set mypage=new xdownpage
'得到数据库连接
mypage.getconn=olddb.idbconn
'sql语句
mypage.getsql="SELECT * from kl_friend_link order by friend_id desc"
'设置每一页的记录条数据为5条
mypage.pagesize=15
'返回Recordset
set rs=mypage.getrs()


'显示数据
'set rs=olddb.query("SELECT a.id,a.arctitle,a.fbdate,b.cat_name,c.type_name,a.arccontent,a.arcpic,a.recycling  from (kl_archives as a inner join  kl_cats as b on a.cat_id=b.cat_id) inner join kl_content_types as c on a.type_id=c.type_id")
	oldtpl.UpdateBlock "friendlinklist"
	
	'输出友情链接列表
for i=1 to mypage.pagesize
	if not rs.eof then
	oldtpl.SetVariable "friend_id",rs("friend_id")&""
	oldtpl.SetVariable "friend_name",rs("friend_name")&""
	oldtpl.SetVariable "friend_url",rs("friend_url")&""
	oldtpl.SetVariable "friend_weizhi",rs("friend_weizhi")&""
	oldtpl.SetVariable "friend_email",rs("friend_email")&""
	oldtpl.ParseBlock "friendlinklist"
	rs.movenext
    else
         exit for
    end if
next
'显示分页信息，这个方法可以，在set rs=mypage.getrs()以后,可在任意位置调用，可以调用多次
oldtpl.setvariable "pagenav",mypage.getshowpage()
oldtpl.Parse
'Destroy our objects
set oldtpl = nothing
%>