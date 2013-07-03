<%
'================================
'过滤器函数
'================================
Function FilterFunc(val,funcname,param)
	temvar=val
	Select Case trim(funcname)
				case "left" 
						set fireg=new regExp
						fireg.IgnoreCase = True
						fireg.Global = True
						fireg.pattern="<.*?>|\s*|\r*\n\s*\r*\n"
						val=fireg.replace(val,"")
						set fireg=nothing
						temVar=left(val,Cint(param))
				case "empty" 
						if val="" then
							temvar=param
						else
							temvar=val
						end if
				case "formatdate" 
						valarr=split(val," ")
						datenow=split(valarr(0),param)
						if ubound(datenow)=2 then
							if len(datenow(1))<2 then datenow(1)="0"&datenow(1)
							if len(datenow(2))<2 then datenow(2)="0"&datenow(2)
							newdate=datenow(0)&"/"&datenow(1)&"/"&datenow(2)
							temvar=newdate
						else
							temvar=valarr(0)
						end if
				case else 
						temvar=val
	end select
	if isnull(temvar) then temvar=""
	FilterFunc=temvar
End Function
%>