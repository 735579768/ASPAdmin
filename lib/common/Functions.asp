<%
'ȡ����ģ��
	Function getArticleTpl(arcid)
		set m=db.getRecord("kl_articles","arctpl","id="&arcid,"",0)
		a=m("arctpl")&""
		set m=nothing
		getArticleTpl=a
	End Function
'ȡ�������ģ��
	Function getCatIndexTpl(catid)
		set m=db.getRecord("kl_cats","cat_index","cat_id="&catid,"",0)
		a=m("cat_index")&""
		set m=nothing
		getCatIndexTpl=a
	End Function
'ȡ�������ģ��
	Function getCatListTpl(catid)
		set m=db.getRecord("kl_cats","cat_list","cat_id="&catid,"",0)
		a=m("cat_list")&""
		set m=nothing
		getCatListTpl=a
	End Function
'ָ����ģ�����
'@param arr ��ֵ���� 
	Function setVarArr(arr)
		if isarray(arr) then
		 for i=0 to ubound(arr)
		 key=mid(arr(i),1,(instr(arr(i),":")-1))
		 valu=mid(arr(i),instr(arr(i),":")+1)
		 	tpl.SetVariable key,valu
		 next
		 	setvararr=true
		 else
		 	setvararr=false
		end if
	End Function
'ѭ�������
'@param block Ҫ����Ŀ�
'@param sqlstr ��ѯ���ݵ�sql���
'@param arr һ����ֵ���飬��"key:valu"  ��Ӧ�����ݸ�ʽΪ tpl.SetVariable key,rs(valu)&""
	Function listBlock(block,sqlstr,arr)
	on error resume next
	set rs=db.query(sqlstr)
			tpl.UpdateBlock block
		do while not rs.eof
			if rs.eof and rs.bof then exit do end if
			 for i=0 to ubound(arr)
				 key=mid(arr(i),1,(instr(arr(i),":")-1))
				 valu=mid(arr(i),instr(arr(i),":")+1)
				 tpl.SetVariable key,rs(valu)&""
			 next
			if err.number<>0 then 
				echo  die(Err.Description&":"&valu)
				err.clear
			end if
			tpl.ParseBlock block
			rs.movenext
		loop
	set rs=nothing
	End Function
'////////////////////////////////////////////////////////////////////////////////////////////////////////////
'ѭ�������,�������ҳ��ʾ
'@param block Ҫ����Ŀ�
'@param sqlstr ��ѯ���ݵ�sql���
'@param arr һ����ֵ���飬��"key:valu"  ��Ӧ�����ݸ�ʽΪ tpl.SetVariable key,rs(valu)&""
'@param pagesҳ��Ĵ�С
	Function listBlockPage(block,sqlstr,arr,pages)
				''��������
			Set mypage=new xdownpage
			''�õ����ݿ�����
			mypage.getconn=db.idbconn
			''sql���
			mypage.getsql=sqlstr
			''����ÿһҳ�ļ�¼������Ϊ5��
			mypage.pagesize=pages
			''����Recordset
			set rs=mypage.getrs()
			''��ʾ��ҳ��Ϣ������������ԣ���set rs=mypage.getrs()�Ժ�,��������λ�õ��ã����Ե��ö��
			'mypage.showpage()
			'
			''��ʾ����
			'Response.Write("<br/>")
			on error resume next
				tpl.UpdateBlock block
			for i=1 to mypage.pagesize
			''����Ϳ����Զ�����ʾ��ʽ��
				if not rs.eof then 
			'        response.write rs(0) & "<br/>"
						 for j=0 to ubound(arr)
							 key=mid(arr(j),1,(instr(arr(j),":")-1))
							 valu=mid(arr(j),instr(arr(j),":")+1)
							 tpl.SetVariable key,rs(valu)&""
							if err.number<>0 then 
								echo  die(Err.Description&":"&valu)
								err.clear
							end if
						 next
					tpl.ParseBlock block
					rs.movenext
				else
					 exit for
				end if
			next
			tpl.setvariable "pagenav",mypage.getshowpage()
			set rs=nothing
	End Function
'/////////////////////////////////////////////////////////////////////////////////////////////////////////
'urlת��
	Function reurl(url)
		response.Redirect(url)
	End Function 
'���js��ʾ��ǰ̨
	Function getJsAlert(str)
		getJsAlert="<script>alert("""&str&""");</script>"
	End Function
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
		str1=request(str)
		getparam=replace(str1,":","��")
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
	function filtersql(fString)
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
'���ؿͻ��˵�ip	
	Function getIP() 
		Dim strIPAddr 
		If Request.ServerVariables("HTTP_X_FORWARDED_FOR") = "" OR InStr(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), "unknown") > 0 Then
		strIPAddr = Request.ServerVariables("REMOTE_ADDR") 
		ElseIf InStr(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), ",") > 0 Then 
		strIPAddr = Mid(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), 1, InStr(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), ",")-1) 
		ElseIf InStr(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), ";") > 0 Then 
		strIPAddr = Mid(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), 1, InStr(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), ";")-1) 
		Else 
		strIPAddr = Request.ServerVariables("HTTP_X_FORWARDED_FOR") 
		End If 
		getIP = Trim(Mid(strIPAddr, 1, 30)) 
	End Function
'===============================asp���Ժ���==================================
function dump(a)
debug(a)
end function
function debug(a)
	if IsArray(a)  then
		response.write "=================�������==================<br />"
		for i=lbound(a) to ubound(a)-1
				if IsArray(a(i)) then
				response.write """"&i&"""=><br />"
						for j=lbound(a) to ubound(a)-1
										response.write "&nbsp&nbsp&nbsp&nbsp&nbsp"""&j&"""=><b style='color:red;'>"&a(i)(j)&"</b><br />"
						next
				else
						response.write """"&i&"""=><b style='color:red;'>"&a(i)&"</b><br />"
				end if
		next
		response.write "============================================<br />"
	else
		response.write "=================�������==================<br />"
		response.write "<b style='color:red;'>"&a&"</b><br />"
		response.write "============================================<br />"
		
	end if
end function
'====================================================================================
'���ܣ�ɾ���ļ���ͼƬ��
'������@filestr  �ļ�·����(���������·��)
Function DeleteFile(FileStr)
	   Dim FSO
	   On Error Resume Next
	   Set FSO = CreateObject("Scripting.FileSystemObject")
		If FSO.FileExists(Server.MapPath(FileStr)) Then
			FSO.DeleteFile Server.MapPath(FileStr), True
		Else
		DeleteFile = True
		End If
	   Set FSO = Nothing
	   If Err.Number <> 0 Then
	   Err.Clear:DeleteFile = False
	   Else
	   DeleteFile = True
	   End If
	End Function
%>
<script language="javascript" type="text/javascript" runat="server">function mydecodeurl(s){return decodeURIComponent(s);}</script>