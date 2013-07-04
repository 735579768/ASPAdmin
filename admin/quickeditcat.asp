<!--#include file="lib/AdminInIt.asp"-->
<%
'更新数据
act=G("act")
cat_id=G("cat_id")
if act="upd" then
	newdb.table("kl_cats").where("cat_id="&cat_id).create()
	newdb.save()
end if


rsarr=newdb.table("kl_cats").where("cat_id="&cat_id).selarr()
newtpl.assign "catobj",rsarr(0)
newtpl.display("quickeditcat.html")
%>