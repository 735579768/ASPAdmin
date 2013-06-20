<!--#include file="lib/AdminInIt.asp"-->
<%
dim cat_id:cat_id=G("cat_id")
if G("act")="updtcat" then
				set uprs=server.createobject("adodb.recordset")
				uprs.open "select * from kl_cats where cat_id="&cat_id,olddb.idbconn,0,2
				uprs("cat_name")=G("cat_name")
				uprs("sort")=G("sort")
				uprs("type_id")=G("type_id")
				uprs("parent_id")=G("parent_id")
				uprs("cat_show")=G("cat_show")
				uprs("cat_pic")=G("cat_pic")
				uprs("cat_seotitle")=G("cat_seotitle")
				uprs("cat_seokeys")=G("cat_seokeys")
				uprs("cat_seodescr")=G("cat_seodescr")
				uprs("cat_single")=G("cat_single")
				uprs("cat_singlecontent")=request("cat_singlecontent")
				uprs("cat_content")=request("cat_content")
				cat_index=G("cat_index")
				cat_list=G("cat_list")
				cat_article=G("cat_article")
				uprs("cat_index")=cat_index
				uprs("cat_list")=cat_list
				uprs("cat_article")=cat_article
	if cat_index="" or cat_list="" or cat_article="" then
		set tplrs=olddb.query("select * from kl_content_types where type_id="&type_id)
		if cat_index="" then uprs("cat_index")=tplrs("tpl_index")&""
		if cat_list="" then uprs("cat_list")=tplrs("tpl_list")&""
		if cat_article="" then uprs("cat_article")=tplrs("tpl_article")&""
		set tplrs=nothing
	end if
	'删除原来的图片
	set temrs=olddb.query("select cat_pic from kl_cats where cat_id="&cat_id)
	tempic=trim(temrs("cat_pic")&"")
	set temrs=nothing
	if cat_pic<>"" and trim(cat_pic)<>tempic then
			DeleteFile tempic
	end if
		uprs.update
		uprs.close
		set uprs=nothing
		AlertMsg(UPDATESUCCESS)
end if
'Generate the page
sql="select a.type_id as typeid ,* from "&suffix&"cats as a inner join kl_content_types as b on a.type_id=b.type_id where a.cat_id="&cat_id
set rs=olddb.query(sql)
cat_index=rs("cat_index")&""
cat_list=rs("cat_list")&""
cat_article=rs("cat_article")&""
cat_content=convertTextarea(rs("cat_content")&"")'转换其中的textarea

if rs("cat_single")="0" then oldtpl.setvariable "sel0","checked='checked'"
if rs("cat_single")="1" then oldtpl.setvariable "sel1","checked='checked'"

if cat_index="" then cat_index=rs("tpl_index")&"" end if
if cat_list="" then cat_list=rs("tpl_list")&"" end if
if cat_article="" then cat_article=rs("tpl_article")&"" end if
setTplVarBySql(sql)
parentidsel=getArcCatSel()
'parentidsel=catparentsel(cat_id)
'======================
'生成cat_id select 的js代码
parentid=rs("parent_id")
jssstr=""

if parentid=0 then
jsstr="<script>$(function(){$('#cat_id').attr('name','parent_id');$('#cat_id').append(""<option value='0'>顶级分类<option>"");$(""#cat_id option[value='0']"").attr('selected','true');});</script>"
else
jsstr="<script>$(function(){$('#cat_id').attr('name','parent_id');$(""#cat_id option[value='"&parentid&"']"").attr('selected','true');});</script>"
end if

'=====================
setVarArr(array("cat_index:"&cat_index,"cat_list:"&cat_list,"cat_article:"&cat_article,"cat_content:"&cat_content,"parentidsel:"&parentidsel,"jsstr:"&jsstr))

oldtpl.Parse
set oldtpl = nothing
%>