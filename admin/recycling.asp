<!--#include file="lib/AdminInIt.asp"-->
<!--#include file="../lib/page.class.asp"-->
<%
'�Ƴ�����վ
	'�����ǵ����Ƴ�
	if G("act")="huanyuan" then
			if G("id")<>"" then 
				id=G("id")
				result=db.UpdateRecord("kl_archives","id="&id,array("recycling:0"))
					if result=0 then
						AlertMsg(CAOZUO_FAIL_STR)
					end if
			end if
		'�����Ƴ�
		if G("batchid")<>"" then
		
			str=G("batchid")
			arr=split(str,",")
			dim result
			for i=0 to ubound(arr)
				result=db.UpdateRecord("kl_archives","id="&arr(i),array("recycling:0"))
			next
				if result=0 then
					AlertMsg(CAOZUO_FAIL_STR)
				end if
		end if
	end if
'����ɾ��
	if G("act")="del" then
			if G("id")<>"" then 
				id=G("id")
				result=db.DeleteRecord("kl_archives","id",id)
					if result=0 then
						AlertMsg(CAOZUO_FAIL_STR)
					end if
			end if
		'����ɾ��
		if G("batchid")<>"" then
			str=G("batchid")
			arr=split(str,",")
			result=""
			for i=0 to ubound(arr)
				result=db.DeleteRecord("kl_archives","id",arr(i))
			next
				if result=0 then
					AlertMsg(CAOZUO_FAIL_STR)
				end if
		end if	
	end if
'tpl.SetTemplatesDir("")
'�����ļ�
'tpl.setVariableFile "TOP_HTML","public/top.html"
'tpl.setVariableFile "FOOTER_HTML","public/footer.html"
'��������
Set mypage=new xdownpage
'�õ����ݿ�����
mypage.getconn=db.idbconn
'sql���
mypage.getsql="SELECT a.id,a.arctitle,a.fbdate,a.arcflag,a.uddate,b.cat_name,c.type_name,a.arccontent,a.arcpic,a.recycling  from (kl_archives as a inner join  kl_cats as b on a.cat_id=b.cat_id) inner join kl_content_types as c on a.type_id=c.type_id  where recycling=1 order by fbdate desc"
'����ÿһҳ�ļ�¼������Ϊ5��
mypage.pagesize=15
'����Recordset
set rs=mypage.getrs()


'��ʾ����
'set rs=db.query("SELECT a.id,a.arctitle,a.fbdate,b.cat_name,c.type_name,a.arccontent,a.arcpic,a.recycling  from (kl_archives as a inner join  kl_cats as b on a.cat_id=b.cat_id) inner join kl_content_types as c on a.type_id=c.type_id")
	tpl.UpdateBlock "arclist"
	
	'��������б�
for i=1 to mypage.pagesize
	if not rs.eof then
	tpl.SetVariable "id",rs("id")&""
	tpl.SetVariable "title",rs("arctitle")&""
	tpl.SetVariable "arctitle",left(rs("arctitle")&"",15)
	tpl.SetVariable "uddate",rs("uddate")&""
	tpl.SetVariable "fbdate",rs("fbdate")&""
	tpl.SetVariable "cat_name",rs("cat_name")&""
	tpl.SetVariable "type_name",rs("type_name")&""
	tpl.SetVariable "arccontent",rs("arccontent")&""
		'�����������
		arcsx=rs("arcflag")&""
		arr=split(arcsx,",")
		flagstr=""
		for j=0 to ubound(arr)
			select case arr(j)
				case "H":
					flagstr=flagstr&"[<span style='color:red;' title='��ҳ�Ƽ�'>��</span>]"
				case "C":
					flagstr=flagstr&"[<span style='color:red;' title='ͷ������'>ͷ</span>]"
			end select
		next
	tpl.SetVariable "flagstr",flagstr
	tpl.ParseBlock "arclist"
	rs.movenext
    else
         exit for
    end if
next
'��ʾ��ҳ��Ϣ������������ԣ���set rs=mypage.getrs()�Ժ�,��������λ�õ��ã����Ե��ö��
tpl.setvariable "pagenav",mypage.getshowpage()
'Generate the page
tpl.Parse
'Destroy our objects
set tpl = nothing
%>