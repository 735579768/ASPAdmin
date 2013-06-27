<!--#include file="lib/AdminInIt.asp"-->
<%
typeid=G("type_id")
dim formjsonstr
if  typeid<>"" then
set rs=newdb.table("kl_content_types").where("type_id="&typeid).sel()
formjsonstr=rs("formjsonstr")
datatable=rs("data_table")
set keyobj=jsontoobj(formjsonstr)

dim col'表数量
opt=" <a href='edit_article.asp?id={{id}}&cat_id={{cat_id}}'><img src='images/edit.png' title='编辑属性' alt='编辑属性' onclick=';' style='cursor:pointer' border='0' width='16' height='16'></a>    <a href='/view.asp?id={{id}}' target='_blank'><img src='images/check.gif' title='预览' alt='预览' onclick='' style='cursor:pointer' border='0' width='16' height='16'></a>    <a href='{{recyclingurl}}'><input type='hidden' value='{{id}}' /><img src='images/recycling.gif' title='移到回收站' alt='移到回收站' onclick=';' style='cursor:pointer' border='0' width='30' height='20' class='delarticle'></a>"

redim colarr(20)
titledata="<tr bgcolor='#FBFCE2'>"
for each a in keyobj.keys
 temarr=split(keyobj(a),"|")
	if ubound(temarr)>0 then
	 	if temarr(1)=1 then
			titledata=titledata&"<td>"&temarr(0)&"</td>"			
	  		col=col+1
		end if
	end if
next
titledata=titledata&"<td width='10%'>操作</td></tr>"
newtpl.assign "titledata",titledata


sql="select * from "&datatable&" where 1=1 order by fbdate desc,id desc"
Set mypage=new xdownpage
mypage.getconn=newdb.kl_conn
mypage.getsql=sql
mypage.pagesize=20
set arcrs=mypage.getrs()
pagenav=mypage.getshowpage()
listdata=""
	for i=0 to 19
		if not arcrs.eof then
			listdata=listdata&"<tr>"
			for each a in keyobj.keys
			 temarr=split(keyobj(a),"|")
				if ubound(temarr)>0 then
					if temarr(1)=1 then
						listdata=listdata&"<td>"&left(removehtml(arcrs(a)),10)&"</td>"			
					end if
				end if
			next
			listdata=listdata&"<td>"&opt&"</td></tr>"
		end if

	arcrs.movenext
	next
newtpl.assign "listdata",listdata
newtpl.assign "pagenav",pagenav




'组建数据列

	newtpl.display("list_model.html")
else
	echo "<script>window.history.go(-1);</sript>"
end if
%>