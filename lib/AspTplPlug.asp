<%
'��������б�
'���ܣ�������������б�������ͼ����ʽ��
'@param num�������������Ĭ��Ϊ10
'@param img�Ƿ����ͼƬĬ�ϲ����
'@param imgwidth ͼƬ���
'@param imgheight ͼƬ�߶�
function GetArcList(num,img,imgwidth,imgheight)
	if num="" then num=10 end if
	if img="" then img=false end if
	if imgwidth="" then imgwidth=120 end if
	if imgheight="" then imgheight=120 end if
	set fs=Server.CreateObject("Scripting.FileSystemObject")
	set oFile = FS.OpenTextFile(server.mappath(Tpl.p_templates_dir & "plugTpl/Arclist.html"), 1)
	'echo server.mappath(Tpl.p_templates_dir & "plugTpl/Arclist.html")
	temstr = oFile.ReadAll												'����������ַ���
	oFile.close
	set oFile=nothing

	
	'�����������
	Set p_regexp = New RegExp   
	p_regexp.IgnoreCase = True
	p_regexp.Global = True
	
	
	'�����ж��Ƿ�ҪͼƬ��ǩ
	if img=false then 
	p_regexp.Pattern =  "<img(.*?)/?>" 	
	temstr=p_regexp.replace(temstr,"")
	end if
	
	
	p_regexp.Pattern =  "<loop>([\s\S]*?)</loop>" 
	set matches=p_regexp.Execute(temstr)
'	if matches.count<1 then Arclist=temstr end if
		xh_str=""'ѭ���ַ���
		For Each Match in Matches      ' Iterate Matches collection
			xh_str= Match.SubMatches(0) 'ȡ��ѭ������
		Next
	
	 temstr=replace(temstr,Matches(0),"{{RECONTENT}}")'������ʱ����
	'ziduan_arr=array("id","type_name","cat_name","title","content","pic","fbdate","flag","author","source","clicks","keys")
	set rs=db.GetRecord("kl_archives","*","","arcfbdate desc",num)
	'set rs=db.query("select * from kl_cats order by [sort] asc")
	'ȥ��loopѭ����ǩ
	xh_str=replace(xh_str,"<loop>","")
	xh_str=replace(xh_str,"</loop>","")
'ѭ������	
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
'ѭ������
	set fs=nothing
	GetArcList=replace(temstr,"{{RECONTENT}}",restr)
end function
%>