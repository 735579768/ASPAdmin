<%
'���js��ʾ��ǰ̨
function getJsAlert(str)
	getJsAlert="<script>alert("""&str&""");</script>"
end function
'����js��ʾ��ǰ̨
function AlertMsg(str)
	echo "<script>alert('"&str&"');</script>"
end function
'��ȡ��������
	function G(str)
		G=getparam(str)
	end function
'ȡ��ǰ�ļ�������ϳ�ģ��
	function getRunFileName()
		dim str:str=Request.ServerVariables("Script_Name")
		dim a:a=len(str)
		dim lenstr:lenstr=a-InStrRev(str, "/")
		Dim filename:filename =Right(str,lenstr) 'Replace(Request.ServerVariables("Script_Name"),"/","")
		f = mid(filename,1,InStrRev(filename, ".")-1)
		getRunFileName=f
	end function
'�ж��ǲ��Ǻ�̨������
	function isadmin()
		dim str:str=Request.ServerVariables("Script_Name")
		if instr(str,adminDir)>0 then
			isadmin=true
		else
			isadmin=false		
		end if
	end function
'���������Ϣ
	function dump(str)
		response.Write "<pre style='color:red'>"
		response.Write str
		response.Write "</pre>"
	end function
'�����Ϣ
	function echo(str)
		response.Write str
	end function
'�˳�����
	function die()
		response.End()
	end function
'ȡurl�е��������
	Function getparam(str)
		getparam=request(str)
		'getparam=mydecodeurl(replace(request(str),"$","%"))&"888"
	End Function
'���ɱ��
	function getbh()
		Randomize
		rndName =Year(Now) & Right("0"& Month(Now),2) & Right("0"& Day(Now),2) & Right("0"& Hour(Now),2) & Right("0"& Minute(Now),2) & Right("0"& Second(Now),2)& Right("00000"& Round(Rnd*89999,0),4)
		rndName =""&rndName
		getbh=rndname
	end function
'���ܷ��ر�js������ĺ��ִ�������url�����Ϳ���
	function getParamByJs(str)
		str=request(str)
		getParamByJs=mydecodeurl(replace(str,"$","%"))
	end function
'����SQL�Ƿ��ַ�����ʽ��html����
	function Replace_Text(fString)
		if isnull(fString) then
		Replace_Text=""
		exit function
		else
		fString=trim(fString)
		fString=replace(fString,">","��")
		fString=replace(fString,"<","��")
		fString=replace(fString,"'","��")
		fString=replace(fString,";","��")
		fString=replace(fString,"--","��")
		fString=server.htmlencode(fString)
		Replace_Text=fString
		end if	
	end function
'����SQL�Ƿ��ַ�
Function SafeRequest(ParaName,ParaType) 
'--- ������� --- 
'ParaName:��������-�ַ��� 
'ParaType:��������-������(1��ʾ���ϲ��������֣�0��ʾ���ϲ���Ϊ�ַ�)�� 
	Dim ParaValue 
	ParaValue=Request(ParaName) 
	If ParaType=1 then 
		If not isNumeric(ParaValue) then 
			Response.write "����" & ParaName & "����Ϊ�����ͣ�" 
			Response.end 
		End if 
	Else 
		ParaValue=replace(ParaValue,"'","��")
		ParaValue=replace(ParaValue,";","") 
		'ParaValue=replace(ParaValue,";","��") 
	End if 
	SafeRequest=ParaValue 
End function

Function Safeupload(ParaName,ParaType) 
'--- ������� --- 
'ParaName:��������-�ַ��� 
'ParaType:��������-������(1��ʾ���ϲ��������֣�0��ʾ���ϲ���Ϊ�ַ�)�� 
	Dim ParaValue 
	ParaValue=upload.form(ParaName) 
	If ParaType=1 then 
		If not isNumeric(ParaValue) then 
			Response.write "����" & ParaName & "����Ϊ�����ͣ�" 
			Response.end 
		End if 
	Else 
		ParaValue=replace(ParaValue,"'","��")
		ParaValue=replace(ParaValue,";","") 
		'ParaValue=replace(ParaValue,";","��") 
	End if 
	Safeupload=ParaValue 
End function

Function NoSqlHack(FS_inputStr)
	Dim f_NoSqlHack_AllStr,f_NoSqlHack_Str,f_NoSqlHack_i,Str_InputStr
	Str_InputStr=FS_inputStr
	'Ŀǰ�����ϵĹ��˷�ʽ
	f_NoSqlHack_AllStr="dbcc|alter|drop|* |and|exec|or|insert|select|delete|update|count|master|truncate|declare|char|mid(|chr|set |where|xp_cmdshell"
	f_NoSqlHack_Str = Split(f_NoSqlHack_AllStr,"|")

	For f_NoSqlHack_i=LBound(f_NoSqlHack_Str) To Ubound(f_NoSqlHack_Str)
		If Instr(LCase(Str_InputStr),f_NoSqlHack_Str(f_NoSqlHack_i))<>0 Then
			If f_NoSqlHack_Str(f_NoSqlHack_i)="'" Then f_NoSqlHack_Str(f_NoSqlHack_i)=" \' "
			Response.Write "<html><title>����</title><body bgcolor=""EEEEEE"" leftmargin=""60"" topmargin=""30""><font style=""font-size:16px;font-weight:bolder;color:blue;""><li>���ύ�������ж����ַ�</li></font><font style=""font-size:14px;font-weight:bolder;color:red;""><br><li>���������Ѿ�����¼!</li><br><li>����IP��"&Request.ServerVariables("Remote_Addr")&"</li><br><li>�������ڣ�"&Now&"</li></font></body></html><!--Powered by Foosun Inc.,AddTime:"&now&"-->"
			Response.End
		End if
	Next
	NoSqlHack = Replace(Replace(Str_InputStr,"'","''"),"%27","''")
End Function


Function listPages(LinkFile) 
   if not (rs.eof and rs.bof) then
	gopage=currentpage
	totalpage=n
	blockPage=Int((gopage-1)/10)*10+1
'	if instr(linkfile,"?page=")>0 or instr(linkfile,"&page=")>0 then
'	pos=instr(linkfile,"page=")-2
'	linkfile=left(linkfile,pos)
'	end if
	
	If LCase(Request.ServerVariables("HTTPS")) = "off" Then 
    strTemp = "http://" 
    Else 
    strTemp = "https://" 
    End If 
    strTemp = strTemp & CheckStr(Request.ServerVariables("SERVER_NAME")) 
    If Request.ServerVariables("SERVER_PORT") <> 80 Then strTemp = strTemp & ":" & CheckStr(Request.ServerVariables("SERVER_PORT")) 
    strTemp = strTemp & CheckStr(Request.ServerVariables("URL"))
    lenstrTemp=len(strTemp)+1	
	if instr(left(linkfile,lenstrTemp),"?")>0 then 
	
	if blockPage = 1 Then
		Response.Write "<span disabled>����ǰ10ҳ</span>&nbsp;"
	Else
		Response.Write("<span disabled>��</span><a href=" & LinkFile & "&page="&blockPage-10&">��ǰ10ҳ</a>&nbsp;")
	End If
   i=1
   Do Until i > 10 or blockPage > n
    If blockPage=int(gopage) Then
		Response.Write("<font color=#FF0000>[<b>"&blockPage&"</b>]</font>")
	Else
		Response.Write(" <a href=" & LinkFile & "&page="&blockPage&">["&blockPage&"]</a> ")
    End If
    blockPage=blockPage+1
    i = i + 1
    Loop
	if blockPage > totalpage Then
		Response.Write "&nbsp;<span disabled>��10ҳ����"
	Else
		Response.Write("&nbsp;<a href=" & LinkFile & "&page="&blockPage&">��10ҳ��</a><span disabled>��")
	End If 
	response.write" ֱ�ӵ��� "
	response.write"<select onchange=if(this.options[this.selectedIndex].value!=''){location=this.options[this.selectedIndex].value;}>"
    for i=1 to totalpage
    response.write"<option value='" & LinkFile & "&page=" & i & "'"
    if i=gopage then response.write"selected"
    response.write">"&i&"</option>"
    next
    response.write"</select>"
    response.write" ҳ<Br><Br>"
	
	else
	
	if blockPage = 1 Then
		Response.Write "<span disabled>����ǰ10ҳ</span>&nbsp;"
	Else
		Response.Write("<span disabled>��</span><a href=" & LinkFile & "?page="&blockPage-10&">��ǰ10ҳ</a>&nbsp;")
	End If
   i=1
   Do Until i > 10 or blockPage > n
    If blockPage=int(gopage) Then
		Response.Write("<font color=#FF0000>[<b>"&blockPage&"</b>]</font>")
	Else
		Response.Write(" <a href=" & LinkFile & "?page="&blockPage&">["&blockPage&"]</a> ")
    End If
    blockPage=blockPage+1
    i = i + 1
    Loop
	if blockPage > totalpage Then
		Response.Write "&nbsp;<span disabled>��10ҳ����"
	Else
		Response.Write("&nbsp;<a href=" & LinkFile & "?page="&blockPage&">��10ҳ��</a><span disabled>��")
	End If 
	response.write" ֱ�ӵ��� "
	response.write"<select onchange=if(this.options[this.selectedIndex].value!=''){location=this.options[this.selectedIndex].value;}>"
    for i=1 to totalpage
    response.write"<option value='" & LinkFile & "?page=" & i & "'"
    if i=gopage then response.write"selected"
    response.write">"&i&"</option>"
    next
    response.write"</select>"
    response.write" ҳ"
	
	End If
	
	Startinfo=((gopage-1)*msg_per_page)+1
	Endinfo=gopage*msg_per_page
	if Endinfo>totalrec then Endinfo=totalrec
		Response.Write("&nbsp;&nbsp;�� "&totalrec&" ����Ϣ ��ǰ��ʾ�� "&Startinfo&" - "&Endinfo&" �� ÿҳ "&msg_per_page&" ����Ϣ �� "&n&" ҳ")
end if
End Function

'��⴫�ݵĲ����Ƿ�Ϊ������
Function Chkrequest(Para)
Chkrequest=False
If Not (IsNull(Para) Or Trim(Para)="" Or Not IsNumeric(Para)) Then
   Chkrequest=True
End If
End Function

'��⴫�ݵĲ����Ƿ�Ϊ������
Function Chkrequestdate(Para)
Chkrequestdate=False
If Not (IsNull(Para) Or Trim(Para)="" Or Not IsDate(Para)) Then
   Chkrequestdate=True
End If
End Function


'����SQL�Ƿ��ַ�
Function checkStr(Chkstr)
	dim Str:Str=Chkstr
	if isnull(Str) then
		checkStr = ""
		exit Function
	else
		Str=replace(Str,"'","")
		Str=replace(Str,";","")
		Str=replace(Str,"--","")
		checkStr=Str
	end if
End Function



'�ú������ã���ָ��������ʽ����ʾʱ�䡣
'numformat=1:��ʱ��ת��Ϊyyyy-mm-dd hh:nn��ʽ��
'numformat=2:��ʱ��ת��Ϊyyyy-mm-dd��ʽ��
'numformat=3:��ʱ��ת��Ϊhh:nn��ʽ��
'numformat=4:��ʱ��ת��Ϊyyyy��mm��dd�� hhʱnn�ָ�ʽ��
'numformat=5:��ʱ��ת��Ϊyyyy��mm��dd�ո�ʽ��
'numformat=6:��ʱ��ת��Ϊhhʱnn�ָ�ʽ��
'numformat=7:��ʱ��ת��Ϊyyyy��mm��dd�� ���ڡ���ʽ��
'numformat=8:��ʱ��ת��Ϊyymmdd��ʽ��
'numformat=9:��ʱ��ת��Ϊmmdd��ʽ��
	function Formatdate(shijian,numformat)
		dim ystr,mstr,dstr,hstr,nstr '��������ֱ�Ϊ���ַ��������ַ��������ַ�����ʱ�ַ��������ַ���
		
		if isnull(shijian) then
		numformat=0
		else
		ystr=DatePart("yyyy",shijian)
		
		if DatePart("m",shijian)>9 then 
		mstr=DatePart("m",shijian)
		else
		mstr="0"&DatePart("m",shijian) 
		end if
		
		if DatePart("d",shijian)>9 then 
		dstr=DatePart("d",shijian)
		else
		dstr="0"&DatePart("d",shijian) 
		end if
		
		if DatePart("h",shijian)>9 then 
		hstr=DatePart("h",shijian)
		else
		hstr="0"&DatePart("h",shijian) 
		end if
		
		if DatePart("n",shijian)>9 then 
		nstr=DatePart("n",shijian)
		else
		nstr="0"&DatePart("n",shijian) 
		end if
		end if
		
		select case numformat
		case 0
		formatdate=""
		case 1
		formatdate=ystr&"-"&mstr&"-"&dstr&" "&hstr&":"&nstr 
		case 2
		formatdate=ystr&"-"&mstr&"-"&dstr
		
		case 3
		formatdate=hstr&":"&nstr
		case 4
		formatdate=ystr&"��"&mstr&"��"&dstr&"�� "&hstr&"ʱ"&nstr&"��"
		
		case 5
		formatdate=ystr&"��"&mstr&"��"&dstr&"��" 
		case 6
		formatdate=hstr&"ʱ"&nstr&"��"
		case 7
		formatdate=ystr&"��"&mstr&"��"&dstr&"�� "&WeekdayName(Weekday(shijian))
		case 8
		formatdate=right(ystr,2)&mstr&dstr
		case 9
		formatdate=mstr&"��"&dstr&"��"
		end select
	end function


function bin2str(binstr)                 '��bin2str������ת��Ϊ�ַ���
	dim varlen, clow, ccc, skipflag
	skipflag = 0
	ccc = ""
	varlen = lenb(binstr)
	for i = 1 to varlen
		if skipflag = 0 then
			clow = midb(binstr, i, 1)
			if ascb(clow) > 127 then
				ccc = ccc & chr(ascw(midb(binstr, i + 1, 1) & clow))
				skipflag = 1
			else
				ccc = ccc & chr(ascb(clow))
			end if
		else
			skipflag = 0
		end if
	next
	bin2str = ccc
end function

	function str2bin(str)             '���ַ���ת��Ϊ��������
		for i = 1 to len(str)
			str2bin = str2bin & chrb(asc(mid(str, i, 1)))
		next
	end function
'�����ļ�
	Function include(filename)
		Dim re,content,fso,f,aspStart,aspEnd
		set fso=CreateObject("Scripting.FileSystemObject")
		set f=fso.OpenTextFile(server.mappath(filename))
		content=f.ReadAll
		f.close
		set f=nothing
		set fso=nothing
		set re=new RegExp
		re.pattern="^\s*="
		aspEnd=1
		aspStart=inStr(aspEnd,content,"<%")+2
		do while aspStart>aspEnd+1 
		Response.write Mid(content,aspEnd,aspStart-aspEnd-2)
		aspEnd=inStr(aspStart,content,"%\>")+2
		Execute(re.replace(Mid(content,aspStart,aspEnd-aspStart-2),"Response.Write "))
		aspStart=inStr(aspEnd,content,"<%")+2
		loop
		Response.write Mid(content,aspEnd) 
		set re=nothing
	End Function 
'����cookies
	function destroyCookies()
		session.abandon
		Response.Cookies("adminid").Expires=now-100 
		Response.Cookies("U_name").Expires=now-100 
		Response.Cookies("U_pwd").Expires=now-100 
	end function
%>
<script language="javascript" type="text/javascript" runat="server">function mydecodeurl(s){return decodeURIComponent(s);}</script>