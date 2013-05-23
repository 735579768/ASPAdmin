<%
class AspTplPlug
	private tpl_str'ģ���ַ���
	private	p_regexp'�������
	 Property Let templatestr(str)
		tpl_str=str
	 End Property 
	 Property Get templatestr
		templatestr=tpl_str
	 End Property 

	private sub class_Initialize
		Set p_regexp = New RegExp
	end sub
	
	Function run()
		loopsql()
	End function
'//////////////////////////////////loop code start///////////////////////////////////////////////////
'===============================================================================
'loop����ѭ��
'===============================================================================
	Function loopsql()
		p_regexp.Pattern =  "<\!--\{loop([\s\S]*?)\}-->([\s\S]*?)<\!--\{/loop\}-->" 
		p_regexp.Global = true
		'��ѯģ���е�����loop��
		set matches=p_regexp.Execute(tpl_str)
		if matches.count>0 then 
		redim looparr(Matches.count)
			'ѭ������loop��
			for i=0 to Matches.count-1
			'ȡloop���еĲ���
				temsql=getloopparam(Matches(i),"loop","sql")
				temnum=getloopparam(Matches(i),"loop","num")
				temiterator=getloopparam(Matches(i),"loop","iterator")
				if temnum="" then 
					temnum=0
				else
					temnum=Cint(temnum)
				end if
				'������loop�е�����
				vostr=volist(Matches(i).SubMatches(1),temsql,temnum,temiterator)
				'�����loop���е����ݻ�Ϊָ��������
				tpl_str=replace(tpl_str,Matches(i),vostr)
			next
		end if
'		For Each Match in Matches      ' Iterate Matches collection
'			xh_str= Match.SubMatches(0) 'ȡ��ѭ������
'		Next
		'echo looparr(1)(0)
	End Function	
'===============================================================================
'ȡ��ǩ�еĲ���
'@param str������ǩ���ַ���
'@param tag��ǩ
'@param key�������ڵļ�ֵ
'===============================================================================	
	Function getloopparam(str,tag,key)
		str1=""
		Set reg = New RegExp 
		reg.Global = true
		reg.Pattern =  "<\!--\{"&tag&"([\s\S]*?)"&key&"=\'([\s\S]*?)\'([\s\S]*?)\}-->" 
		set ms=reg.Execute(str)
		if ms.count>0 then
		str1=ms(0).SubMatches(1)'ȡsql���
		end if
		set reg=nothing
		getloopparam=str1
	End Function
'===============================================================================
'ѭ������loop�е����ݲ����ش����������
'===============================================================================	
	Function volist(str,sql,num,iterator)
		str1=""'һ�������մ���ú�ŵı���
		str2=""'ѭ���ֶ��滻ʱ�õ���
		set vors=db.query(sql)
		if num=0 then num=vors.recordcount
		if num>vors.recordcount then num=vors.recordcount
		'ȡ��ѯ���ݼ����ֶ�
		fieldarr=getTableField(sql)
			if vors.recordcount>0 then
			'ѭ����¼��
				for i=0 to num-1
					if vors.eof  then exit for
					str2=str
					'�������
					str2=replace(str2,"{{"&iterator&"}}",i+1)
					'ѭ����¼���е��ֶβ��滻Ϊָ����ֵ
					for j=0 to ubound(fieldarr)-1
						fieldstr=fieldarr(j)(0)
						str2=replace(str2,"{{"&fieldstr&"}}",vors(fieldstr)&"")
					next
					str1=str1+str2
					str2=""
				vors.movenext
				next
			end if
		set vors=nothing
		volist=str1
	End Function	
'//////////////////////////////////loop code end///////////////////////////////////////////////////
end class
%>