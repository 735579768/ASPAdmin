<!--#include file="lib/AdminInIt.asp"-->
<% if session("APP")<>"true" then reurl("/") end if %>
<%
typeid=G("type_id")
set typers=newdb.table("kl_content_types").where("type_id="&typeid).sel()
fieldtag=typers("fieldtag")&""
'====================
'输出添加表单
Set reg = New RegExp 
reg.IgnoreCase = True
reg.Global = True
reg.Pattern ="<field(.*?)/>"
Set Matches = reg.Execute(fieldtag)
addform=""
For Each Match in Matches 
	nme=getFieldParam(Match,"name")
	title=getFieldParam(Match,"title")
	descr=getFieldParam(Match,"descr")
	datatype=getFieldParam(Match,"datatype")
	addform=addform&gettypeform(nme,"",title,descr,datatype)
next 
newtpl.assign "addform",addform
'输出添加表单
'===============================
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
'=================================本页函数库========
	public Function getFieldParam(str,key)
		Set p_reg = New RegExp 
		str1=""
		p_reg.Pattern ="([\s\S]*?)"&key&"=[\""|\']([\s\S]*?)[\""|\']([\s\S]*?)"	
		set ms=p_reg.Execute(str)
		if ms.count>0 then
		str1=ms(0).SubMatches(1)'取sql语句
		end if
		set ms=nothing
		getFieldParam=str1
	End Function
'==========================================
'返回表单类型
'==========================================
	public Function gettypeform(nme,val,title,descr,datatype)
		select case datatype
			case "text" 'text
				gettypeform="<tr><td>"&title&":</td><td><input name='"&nme&"' type='text' /></td></tr>"
			case "textarea" 'textarea
				gettypeform="<tr><td>"&title&":</td><td><textarea name='"&nme&"' style='width:500px; height:50px;'></textarea>"&descr&"</td></tr>"
			case "html" 'html数据
				gettypeform="<script>var editor;KindEditor.ready(function(K) {editor = K.create('textarea[name="""&nme&"""]', {'allowFileManager' : true,'uploadJson': 'editor/asp/upload_json.asp','fileManagerJson': 'editor/asp/file_manager_json.asp','allowFlashUpload':true,'allowFileManager':true,'filterMode':false,'allowPreviewEmoticons':true,'afterBlur':function(){this.sync();}});});</script><tr><td>"&title&":</td><td><textarea name='"&nme&"' style='width:710px;height:400px;visibility:hidden;'></textarea>"&descr&"</td></tr>"
			case "pic" '上传图片
				gettypeform="<script>var editor;KindEditor.ready(function(K) {K('#image1').click(function() {editor.loadPlugin('image', function() {editor.plugin.imageDialog({imageUrl : K('#url1').val(),clickFn : function(url, title, width, height, border, align) {K('#url1').val(url);editor.hideDialog();}});});});});</script><tr><td>"&title&":</td><td><input name='"&nme&"' type='text' id='url1' value='' style='width:388px' /> <input type='button' id='image1' value='选择图片' />"&descr&"</td></tr>"
			case default
				gettypeform="<tr><td>"&title&":</td><td><input name='"&nme&"' type='text' />"&descr&"</td></tr>"
		end select
	End Function
%>