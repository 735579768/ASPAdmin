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
			if isobject(newtpl) then
				set tplobj=newtpl
			else
				set tplobj=tpl
			end if
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
			str=arclisttag(str)
			str=cattag(str)
			str=positiontag(str)
			run=str
		end function
		'=======================================
		'<arclist catid="1,2,3">
		'</arclist>
		'=======================================
		private Function arclisttag(str)
			tagreg.Pattern=p_tag_l & "arclist\s*?(.*?)\s*?"& p_tag_r  &"([\s\S]*?)"& p_tag_l & "/arclist"& p_tag_r
			Set Matches = tagreg.Execute(str)
			for each m in matches
			
				paramstr=m.submatches(0)
				catidlist=tplobj.getTagParam(paramstr,"catid")
				parentidlist=tplobj.getTagParam(paramstr,"parentid")
				num=tplobj.getTagParam(paramstr,"num")
				tplsql=tplobj.getTagParam(paramstr,"sql")
				pgsize=tplobj.getTagParam(paramstr,"pagesize")'分页大小
				pgnav=tplobj.getTagParam(paramstr,"pagenav")'分页导航变量
				hometj=tplobj.getTagParam(paramstr,"hometj")'分页导航变量
				tiaojian=tplobj.getTagParam(paramstr,"where")'分页导航变量
				if hometj<>"" then hometj=" and hometj=1 "
				if tiaojian<>"" then tiaojian=" and "&tiaojian&" "
				top=""
				liststr2=""
				runsql=tplsql'如果有sql语句就直接用sql语句
				if num<>"" then top=" top "&num
				if runsql="" then
					where=" recycling=0 "
					if catidlist<>"" and parentidlist<>"" then
						where=where&" and(kl_archives.cat_id in("&catidlist&") or kl_cats.parent_id in("&parentidlist&"))"&tiaojian 
					else
						if catidlist<>""  then where=where&" and kl_archives.cat_id in("&catidlist&") " &tiaojian 
						if parentidlist<>""  then where=where&" and kl_cats.parent_id in("&parentidlist&") "&tiaojian 
					end if
					runsql="select "&top&" kl_cats.cat_id as catid, * from (kl_archives inner join kl_cats on kl_archives.cat_id=kl_cats.cat_id) inner join kl_content_types on kl_cats.type_id=kl_content_types.type_id where "& where &" "& hometj &" order by fbdate desc,id desc"
				end if
				if tplsql<>"" or catidlist<>"" or parentidlist<>"" then	
					dim arcrs
					if pgnav<>"" then
						if pgsize="" then pgsize=20
								Set mypage=new xdownpage
								mypage.getconn=db.kl_conn
								mypage.getsql=runsql
								mypage.pagesize=cInt(pgsize)
								set arcrs=mypage.getrs()
								pagenav=mypage.getshowpage()
								tplobj.assign pgnav,pagenav&""
					else
						set arcrs=db.query(runsql)
						pgsize=arcrs.recordcount
					end if
						for i=0 to pgsize-1
							if not arcrs.eof then
								liststr=m.submatches(1)'列表中的字符串
								'on error resume next
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
													liststr=replace(liststr,mm,tplobj.filterVar(arcrs(c(0))&"",c(1),c(2)))
												else
												'没有过滤器
													liststr=replace(liststr,mm,arcrs(fie.name )&"")
												end if	
									next 
									
								next
								
							arcrs.movenext
							
							liststr=tplobj.jiexivar(liststr)'在解析短标签前把里面的全局变量解析成数据
							liststr=tplobj.jiexiShortTag(liststr)'处理短标签
							liststr2=liststr2&liststr
							end if
						next
					set arcrs=nothing
				else
					tplobj.echoerr 1, "parentid and sql and catid  is should not null in arclist at that time"
				end if
				str=replace(str,m,liststr2)
			next
			arclisttag=str
		end Function
	'==========================================================================================
	'自定义从数据库查询的标签
	'=========================================================================================
	private function cattag(str)
		str1=""
		Set catreg = New RegExp 
		catreg.IgnoreCase = True
		catreg.Global = True
		catreg.Pattern ="<cat([\s\S]*?)>([\s\S]*?)</cat>"
		set eqm=catreg.execute(str)
		if eqm.count>0 then
			for each m in eqm		
				temparam=tplobj.getTagParam(m.SubMatches(0),"id")
				str1=m.submatches(1)
				set catrs=db.table("kl_cats").top("1").where("cat_id="&temparam).sel()
					for each a in catrs.fields
						catreg.Pattern = p_var_l &a.name &"(.*?)"& p_var_r
						set mms=catreg.execute(str1)
						
						'遍历查出来的跟字段相似的变量，为啦查询是不是有过滤器
									for each mm in mms
										'判断是不是有过滤器
										c=tplobj.isHaveFilteFunc(mm)
												'echo mm
												if isarray(c) then
												'有过滤器
													str1=replace(str1,mm,tplobj.filterVar(cstr(catrs(c(0))),c(1),c(2)))
												else
												'没有过滤器
													str1=replace(str1,mm,cstr(catrs(a.name )))
												end if	
									next 
					next 
				set catrs=nothing
				str=replace(str,m,str1)
			next
		end if
		set catreg=nothing
		cattag=str
	end function
	'==========================================================================================
	'返回当前位置
	'=========================================================================================
	Function positiontag(str)
		str1=""
		Set catreg = New RegExp 
		catreg.IgnoreCase = True
		catreg.Global = True
		catreg.Pattern ="<position([\s\S]*?)/>"
		set eqm=catreg.execute(str)
		if eqm.count>0 then
			for each m in eqm		
				temid=tplobj.getTagParam(m.SubMatches(0),"id")
				temjiange=tplobj.getTagParam(m.SubMatches(0),"jiange")
				str1=getcat(temid,temjiange)
				str=replace(str,m,str1)
			next
		end if
		set catreg=nothing
		positiontag=str	
	end Function
	'==========================================================================================
	'返回当前位置字符串
	'=========================================================================================	
	Function getcat(catid,jiange)
		str=""
		if catid<>"" then
		set catrs=db.table("kl_cats").top("1").where("cat_id="&catid).sel()
		if catrs.recordcount>0 then
		if catrs("parent_id")<>0 then str=str&getcat(catrs("parent_id"),jiange)
		str=str&"<a href='cat.asp?catid="&catrs("cat_id")&"'>"&jiange&catrs("cat_name")&"</a>"
		end if
		end if
		getcat=str
	end Function
end class
%>