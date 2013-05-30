<!--#include file="lib/AdminInIt.asp"-->
<%
'tpl.SetTemplatesDir("")
'包含文件
'tpl.setVariableFile "TOP_HTML","public/top.html"
'tpl.setVariableFile "FOOTER_HTML","public/footer.html"
'判断要包含的文件是否存在
				temstr=""
				set FSO = createobject("Scripting.FileSystemObject")
				filepath=server.mappath("/"&TPL_PATH&"tpl.ini")
				if FSO.FileExists(filepath) then
					'读取包含的文件并替换标签
					set oFile = FSO.OpenTextFile(filepath, 1)
					temstr = oFile.ReadAll
					oFile.Close
					set oFile = nothing
				end if
	arr=split(temstr,vbCrLf)
	tpl.updateBlock "tpllist"
	for each a in arr
		arr1=split(a,",")
		if ubound(arr1)>0 then
			setVarArr(array("name:"&arr1(0),"descr:"&arr1(1)))
		end if
		tpl.parseBlock "tpllist"
	next
'Generate the page
tpl.Parse
'Destroy our objects
set tpl = nothing
%>