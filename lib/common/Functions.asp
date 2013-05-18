<%
'取文章模板
	Function getArticleTpl(arcid)
		set m=db.getRecord("kl_articles","arctpl","id="&arcid,"",0)
		a=m("arctpl")&""
		set m=nothing
		getArticleTpl=a
	End Function
'取分类封面模板
	Function getCatIndexTpl(catid)
		set m=db.getRecord("kl_cats","cat_index","cat_id="&catid,"",0)
		a=m("cat_index")&""
		set m=nothing
		getCatIndexTpl=a
	End Function
'取分类封面模板
	Function getCatListTpl(catid)
		set m=db.getRecord("kl_cats","cat_list","cat_id="&catid,"",0)
		a=m("cat_list")&""
		set m=nothing
		getCatListTpl=a
	End Function
'指设置模板变量
'@param arr 键值数组 
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
'循环块输出
'@param block 要输出的块
'@param sqlstr 查询数据的sql语句
'@param arr 一个键值数组，如"key:valu"  对应的数据格式为 tpl.SetVariable key,rs(valu)&""
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
'循环块输出,后面带分页显示
'@param block 要输出的块
'@param sqlstr 查询数据的sql语句
'@param arr 一个键值数组，如"key:valu"  对应的数据格式为 tpl.SetVariable key,rs(valu)&""
'@param pages页面的大小
	Function listBlockPage(block,sqlstr,arr,pages)
				''创建对象
			Set mypage=new xdownpage
			''得到数据库连接
			mypage.getconn=db.idbconn
			''sql语句
			mypage.getsql=sqlstr
			''设置每一页的记录条数据为5条
			mypage.pagesize=pages
			''返回Recordset
			set rs=mypage.getrs()
			''显示分页信息，这个方法可以，在set rs=mypage.getrs()以后,可在任意位置调用，可以调用多次
			'mypage.showpage()
			'
			''显示数据
			'Response.Write("<br/>")
			on error resume next
				tpl.UpdateBlock block
			for i=1 to mypage.pagesize
			''这里就可以自定义显示方式了
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
'url转向
	Function reurl(url)
		response.Redirect(url)
	End Function 
'输出js提示框到前台
	Function getJsAlert(str)
		getJsAlert="<script>alert("""&str&""");</script>"
	End Function
'弹出js提示框到前台
	function AlertMsg(str)
		echo "<script>alert('"&str&"');</script>"
	end function
'简化取参数操作
	function G(str)
		G=getparam(str)
	end function
'取当前文件名，组合成模板
	function getRunFileName()
		dim str:str=Request.ServerVariables("Script_Name")
		dim a:a=len(str)
		dim lenstr:lenstr=a-InStrRev(str, "/")
		Dim filename:filename =Right(str,lenstr) 'Replace(Request.ServerVariables("Script_Name"),"/","")
		f = mid(filename,1,InStrRev(filename, ".")-1)
		getRunFileName=f
	end function
'判断是不是后台的请求
	function isadmin()
		dim str:str=Request.ServerVariables("Script_Name")
		if instr(str,adminDir)>0 then
			isadmin=true
		else
			isadmin=false		
		end if
	end function
'调试输出信息
	function dump(str)
		response.Write "<pre style='color:red'>"
		response.Write str
		response.Write "</pre>"
	end function
'输出信息
	function echo(str)
		response.Write str
	end function
'退出程序
	function die()
		response.End()
	end function
'取url中的请求参数
	Function getparam(str)
		str1=request(str)
		getparam=replace(str1,":","：")
		'getparam=mydecodeurl(replace(request(str),"$","%"))&"888"
	End Function
'生成编号
	function getbh()
		Randomize
		rndName =Year(Now) & Right("0"& Month(Now),2) & Right("0"& Day(Now),2) & Right("0"& Hour(Now),2) & Right("0"& Minute(Now),2) & Right("0"& Second(Now),2)& Right("00000"& Round(Rnd*89999,0),4)
		rndName =""&rndName
		getbh=rndname
	end function
'功能返回被js编码过的汉字传递请求url参数就可以
	function getParamByJs(str)
		str=request(str)
		getParamByJs=mydecodeurl(replace(str,"$","%"))
	end function
'过滤SQL非法字符并格式化html代码
	function filtersql(fString)
		if isnull(fString) then
		Replace_Text=""
		exit function
		else
		fString=trim(fString)
		fString=replace(fString,">","》")
		fString=replace(fString,"<","《")
		fString=replace(fString,"'","‘")
		fString=replace(fString,";","；")
		fString=replace(fString,"--","—")
		fString=server.htmlencode(fString)
		Replace_Text=fString
		end if	
	end function

Function NoSqlHack(FS_inputStr)
	Dim f_NoSqlHack_AllStr,f_NoSqlHack_Str,f_NoSqlHack_i,Str_InputStr
	Str_InputStr=FS_inputStr
	'目前用最严的过滤方式
	f_NoSqlHack_AllStr="dbcc|alter|drop|* |and|exec|or|insert|select|delete|update|count|master|truncate|declare|char|mid(|chr|set |where|xp_cmdshell"
	f_NoSqlHack_Str = Split(f_NoSqlHack_AllStr,"|")

	For f_NoSqlHack_i=LBound(f_NoSqlHack_Str) To Ubound(f_NoSqlHack_Str)
		If Instr(LCase(Str_InputStr),f_NoSqlHack_Str(f_NoSqlHack_i))<>0 Then
			If f_NoSqlHack_Str(f_NoSqlHack_i)="'" Then f_NoSqlHack_Str(f_NoSqlHack_i)=" \' "
			Response.Write "<html><title>警告</title><body bgcolor=""EEEEEE"" leftmargin=""60"" topmargin=""30""><font style=""font-size:16px;font-weight:bolder;color:blue;""><li>您提交的数据有恶意字符</li></font><font style=""font-size:14px;font-weight:bolder;color:red;""><br><li>您的数据已经被记录!</li><br><li>您的IP："&Request.ServerVariables("Remote_Addr")&"</li><br><li>操作日期："&Now&"</li></font></body></html><!--Powered by Foosun Inc.,AddTime:"&now&"-->"
			Response.End
		End if
	Next
	NoSqlHack = Replace(Replace(Str_InputStr,"'","''"),"%27","''")
End Function

'检测传递的参数是否为数字型
Function Chkrequest(Para)
Chkrequest=False
If Not (IsNull(Para) Or Trim(Para)="" Or Not IsNumeric(Para)) Then
   Chkrequest=True
End If
End Function

'检测传递的参数是否为日期型
Function Chkrequestdate(Para)
Chkrequestdate=False
If Not (IsNull(Para) Or Trim(Para)="" Or Not IsDate(Para)) Then
   Chkrequestdate=True
End If
End Function


'过滤SQL非法字符
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



'该函数作用：按指定参数格式化显示时间。
'numformat=1:将时间转化为yyyy-mm-dd hh:nn格式。
'numformat=2:将时间转化为yyyy-mm-dd格式。
'numformat=3:将时间转化为hh:nn格式。
'numformat=4:将时间转化为yyyy年mm月dd日 hh时nn分格式。
'numformat=5:将时间转化为yyyy年mm月dd日格式。
'numformat=6:将时间转化为hh时nn分格式。
'numformat=7:将时间转化为yyyy年mm月dd日 星期×格式。
'numformat=8:将时间转化为yymmdd格式。
'numformat=9:将时间转化为mmdd格式。
	function Formatdate(shijian,numformat)
		dim ystr,mstr,dstr,hstr,nstr '变量含义分别为年字符串，月字符串，日字符串，时字符串，分字符串
		
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
		formatdate=ystr&"年"&mstr&"月"&dstr&"日 "&hstr&"时"&nstr&"分"
		
		case 5
		formatdate=ystr&"年"&mstr&"月"&dstr&"日" 
		case 6
		formatdate=hstr&"时"&nstr&"分"
		case 7
		formatdate=ystr&"年"&mstr&"月"&dstr&"日 "&WeekdayName(Weekday(shijian))
		case 8
		formatdate=right(ystr,2)&mstr&dstr
		case 9
		formatdate=mstr&"月"&dstr&"日"
		end select
	end function


function bin2str(binstr)                 '将bin2str二进数转化为字符串
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

	function str2bin(str)             '将字符串转化为二进制数
		for i = 1 to len(str)
			str2bin = str2bin & chrb(asc(mid(str, i, 1)))
		next
	end function
'包含文件
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
'销毁cookies
	function destroyCookies()
		session.abandon
		Response.Cookies("adminid").Expires=now-100 
		Response.Cookies("U_name").Expires=now-100 
		Response.Cookies("U_pwd").Expires=now-100 
	end function
'返回客户端的ip	
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
'===============================asp调试函数==================================
function dump(a)
debug(a)
end function
function debug(a)
	if IsArray(a)  then
		response.write "=================调试输出==================<br />"
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
		response.write "=================调试输出==================<br />"
		response.write "<b style='color:red;'>"&a&"</b><br />"
		response.write "============================================<br />"
		
	end if
end function
'====================================================================================
'功能：删除文件（图片）
'参数：@filestr  文件路径，(可以用相对路径)
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