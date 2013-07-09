<%
'输出首页优化内容
set rs=db.table("kl_meta").where("meta_key='cfg_system'").fild("meta_value").sel()
jsonstr=rs(0)&""
set seoobj=jsontoobj(jsonstr)
tpl.assign "indexseo",seoobj
%>