<%
'===================================================
'===author 赵克立
'===blog:http://zhaokeli.com/
'===version.v1.0.0
'===asp template class
'===运行模式类似于smarty不过没有smary强大
'===================================================
class QuickTag
		private tplstr
		private tagreg
		private p_var_l
		private p_var_r
		private p_tag_l
		private p_tag_r
		private tplobj
		private sub class_Initialize
			'接收模板类对象
			set tplobj=tpl
			p_var_l = "\{\$"
			p_var_r = "\}"
			p_tag_l = "<\!--\{"
			p_tag_r = "\}-->"
			set tagreg=new Regexp
			tagreg.IgnoreCase = True
			tagreg.Global = True
		end sub
		Private Sub Class_Terminate()
			set tagreg=nothing
		end sub
		'运行本类中的标签解析
		public Function run(str)
			tplstr=str
			arclisttag()
			run=tplstr
		end function
		'=======================================
		'<arclist catid="1,2,3">
		'</arclist>
		'=======================================
		private sub arclisttag()
			tagreg.Pattern=p_tag_l & "arclist\s*?(.*?)\s*?"& p_tag_r  &"([\s\S]*?)"& p_tag_l & "/arclist"& p_tag_r
			Set Matches = tagreg.Execute(tplstr)
			for each m in matches
				catidlist=tplobj.getTagParam(m.submatches(0),"catid")
				parentidlist=tplobj.getTagParam(m.submatches(0),"parentid")
				num=tplobj.getTagParam(m.submatches(0),"num")
				tplsql=tplobj.getTagParam(m.submatches(0),"sql")
				top=""
				if num<>"" then top=" top "&num
				liststr2=""
				runsql=tplsql'如果有sql语句就直接用sql语句
				if runsql="" then 
					if parentidlist<>""  then
						runsql="select "&top&" * from (kl_archives inner join kl_cats on kl_archives.cat_id=kl_cats.cat_id) inner join kl_content_types on kl_cats.type_id=kl_content_types.type_id where kl_cats.parent_id in("&parentidlist&") order by fbdate desc,id desc"
					else
						runsql="select "&top&"  * from (kl_archives inner join kl_cats on kl_archives.cat_id=kl_cats.cat_id) inner join kl_content_types on kl_cats.type_id=kl_content_types.type_id where kl_archives.cat_id in("&catidlist&") order by fbdate desc,id desc"
					end if
				end if
				'echo runsql
				if tplsql<>"" or catidlist<>"" or parentidlist<>"" then	
					set arcrs=db.query(runsql)
						do while not arcrs.eof
							liststr=m.submatches(1)'列表中的字符串
							'arcrs("arctitle")
							'遍历记录集中的字段
							for each fie in arcrs.fields
								'echo fie.name
								'查询列表内容中的对应的字段值
								tagreg.Pattern = p_var_l &fie.name &"(.*?)"& p_var_r
								set mms=tagreg.execute(liststr)
								'遍历查出来的跟字段相似的变量，为啦查询是不是有过滤器
								for each mm in mms
									'判断是不是有过滤器
									c=tplobj.isHaveFilteFunc(mm)
											'echo mm
											if isarray(c) then
											'有过滤器
												liststr=replace(liststr,mm,tplobj.filterVar(cstr(arcrs(c(0))),c(1),c(2)))
											else
											'没有过滤器
												liststr=replace(liststr,mm,cstr(arcrs(fie.name )))
											end if	
								next 
								
							next
						arcrs.movenext
						liststr2=liststr2&liststr
						loop
					set arcrs=nothing
				else
					echo "parentid and sql and catid  is should not null in arclist at that time"
				end if
				tplstr=replace(tplstr,m,liststr2)
			next
		end sub
end class
%>