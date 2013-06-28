<!--#include file="lib/AdminInIt.asp"-->
<% if session("APP")<>"true" then reurl("/") end if %>
<%
typeid=G("type_id")
set typers=newdb.table("kl_content_types").where("type_id="&typeid).sel()
formjsonstr=cstr(typers("formjsonstr"))
set jsonobj=jsontoobj(formjsonstr)

listdata=""
if isobject(jsonobj) then
	for each a in jsonobj.keys
	tarr=split(jsonobj(a),"|")
	descr=tarr(0)
	addedit=cstr(tarr(2))
	if addedit<>"" then
'	a="auto_"&a
	select case addedit
		case "1" 'text
			listdata=listdata&"<tr><td>"&descr&":</td><td><input name='"&a&"' type='text' /></td></tr>"
		case "2" 'textarea
			listdata=listdata&"<tr><td>"&descr&":</td><td><textarea name='"&a&"' style='width:500px; height:50px;'></textarea></td></tr>"
		case "3" 'html数据
			listdata=listdata&"<script>var editor;KindEditor.ready(function(K) {editor = K.create('textarea[name="""&a&"""]', {'allowFileManager' : true,'uploadJson': 'editor/asp/upload_json.asp','fileManagerJson': 'editor/asp/file_manager_json.asp','allowFlashUpload':true,'allowFileManager':true,'filterMode':false,'allowPreviewEmoticons':true,'afterBlur':function(){this.sync();}});});</script><tr><td>"&descr&":</td><td><textarea name='"&a&"' style='width:710px;height:400px;visibility:hidden;'></textarea></td></tr>"
		case "4" '上传图片
			listdata=listdata&"<script>var editor;KindEditor.ready(function(K) {K('#image1').click(function() {editor.loadPlugin('image', function() {editor.plugin.imageDialog({imageUrl : K('#url1').val(),clickFn : function(url, title, width, height, border, align) {K('#url1').val(url);editor.hideDialog();}});});});});</script><tr><td>"&descr&":</td><td><input name='"&a&"' type='text' id='url1' value='' style='width:388px' /> <input type='button' id='image1' value='选择图片' /></td></tr>"
		case default
			listdata=listdata&"<tr><td>"&descr&":</td><td><input name='"&a&"' type='text' /></td></tr>"
	end select
	end if
	next
	newtpl.assign "listdata",listdata
end if
'添加信息
	if G("isaddxx")="true"  then
		err.clear
		cat_id=G("cat_id")
		sql="select b.data_table as datatable from kl_cats as a inner join kl_content_types as b on a.type_id=b.type_id where a.cat_id="&cat_id
		set rs=newdb.query(sql)
		datatable=rs("datatable")
		
				set uprs=server.createobject("adodb.recordset")
				uprs.open "select * from "&datatable,olddb.idbconn,1,3
				uprs.addNew
				for each key in request.Form()
					 if  key<>"isaddarticle" then
						val=G(key)
						uprs(key)=val
					 end if
				next
				uprs("fbdate")=FormatDate(now,2)
				uprs("uddate")=FormatDate(now,2)
				if(G("arcdescr")="") then uprs("arcdescr")=left(removehtml(G("arccontent")),30)
				uprs.update
				
				if err.number<>0 then
					echoErr()
					AlertMsg(ADD_FAIL_STR)
					err.clear
				else
					AlertMsg(ADD_SUCCESS_STR)
				end if
	end if
newtpl.display("add_xx.html")
%>