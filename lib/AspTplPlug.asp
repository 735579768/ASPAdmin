<%
'输出文章列表
'功能：输出文章内容列表，可以是图方方式的
'@param num输出的文章条数默认为10
'@param img是否输出图片默认不输出
'@param imgwidth 图片宽度
'@param imgheight 图片高度
function GetArcList(num,img,imgwidth,imgheight)
	if num="" then num=10 end if
	if img="" then img=false end if
	if imgwidth="" then imgwidth=120 end if
	if imgheight="" then imgheight=120 end if
	set fs=Server.CreateObject("Scripting.FileSystemObject")
	set oFile = FS.OpenTextFile(server.mappath(Tpl.p_templates_dir & "plugTpl/Arclist.html"), 1)
	'echo server.mappath(Tpl.p_templates_dir & "plugTpl/Arclist.html")
	temstr = oFile.ReadAll												'保存读到的字符串
	oFile.close
	set oFile=nothing

	
	'正则解析内容
	Set p_regexp = New RegExp   
	p_regexp.IgnoreCase = True
	p_regexp.Global = True
	
	
	'首先判断是否要图片标签
	if img=false then 
	p_regexp.Pattern =  "<img(.*?)/?>" 	
	temstr=p_regexp.replace(temstr,"")
	end if
	
	
	p_regexp.Pattern =  "<loop>([\s\S]*?)</loop>" 
	set matches=p_regexp.Execute(temstr)
'	if matches.count<1 then Arclist=temstr end if
		xh_str=""'循环字符串
		For Each Match in Matches      ' Iterate Matches collection
			xh_str= Match.SubMatches(0) '取出循环内容
		Next
	
	 temstr=replace(temstr,Matches(0),"{{RECONTENT}}")'保存临时变量
	'ziduan_arr=array("id","type_name","cat_name","title","content","pic","fbdate","flag","author","source","clicks","keys")
	set rs=db.GetRecord("kl_archives","*","","arcfbdate desc",num)
	'set rs=db.query("select * from kl_cats order by [sort] asc")
	'去掉loop循环标签
	xh_str=replace(xh_str,"<loop>","")
	xh_str=replace(xh_str,"</loop>","")
'循环内容	
	restr=""
	do while not rs.eof
		a=replace(xh_str,"{{url}}",rs("id")&"")
		a=replace(a,"{{alt}}",rs("arctitle")&"")
		a=replace(a,"{{name}}",left(rs("arctitle")&"",10))
		a=replace(a,"{{picurl}}",rs("arcpic")&"")
		a=replace(a,"{{imgwidth}}",imgwidth)
		a=replace(a,"{{imgheight}}",imgheight)
		restr=restr & a
	rs.movenext
	loop
'循环内容
	set fs=nothing
	GetArcList=replace(temstr,"{{RECONTENT}}",restr)
end function
%>