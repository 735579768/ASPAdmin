<!--#include file="lib/AdminInIt.asp"-->
<!--#include file="../lib/page.class.asp"-->
<%
'�ƶ�����վ
if G("batchid")<>"" then
	str=G("batchid")
	arr=split(str,",")
	dim result
	for i=0 to ubound(arr)
		result=db.UpdateRecord("kl_articles","id="&arr(i),array("recycling:1"))
	next
		if result=0 then
			AlertMsg(CAOZUO_FAIL_STR)
		end if
end if

'�����˷�������
tpl.setvariable "selcatid",getArcCatSel()
guolv=""
if G("cat_id")<>"" then
	guolv=" and a.cat_id="&G("cat_id")	
end if

'//////////////////////////////////////////////////////////////////////////////////////////
'��������
Set mypage=new xdownpage
'�õ����ݿ�����
mypage.getconn=db.idbconn
'sql���
mypage.getsql="SELECT a.id,a.arctitle,a.arcfbdate,a.arcflag,a.arcuddate,b.cat_name,c.type_name,a.arccontent,a.arcpic,a.recycling,a.archits from (kl_articles as a inner join  kl_cats as b on a.cat_id=b.cat_id) inner join kl_content_types as c on a.type_id=c.type_id  where recycling=0  "& guolv &" order by arcfbdate desc"
'����ÿһҳ�ļ�¼������Ϊ5��
mypage.pagesize=15
'����Recordset
set rs=mypage.getrs()


'��ʾ����
'set rs=db.query("SELECT a.id,a.arctitle,a.arcfbdate,b.cat_name,c.type_name,a.arccontent,a.arcpic,a.recycling  from (kl_articles as a inner join  kl_cats as b on a.cat_id=b.cat_id) inner join kl_content_types as c on a.type_id=c.type_id")
	tpl.UpdateBlock "arclist"
	
	'��������б�
for i=1 to mypage.pagesize
	if not rs.eof then
	tpl.SetVariable "id",rs("id")&""
	tpl.SetVariable "title",rs("arctitle")&""
	tpl.SetVariable "arctitle",left(rs("arctitle")&"",15)
	tpl.SetVariable "arcuddate",rs("arcuddate")&""
	tpl.SetVariable "arcfbdate",rs("arcfbdate")&""
	tpl.SetVariable "cat_name",rs("cat_name")&""
	tpl.SetVariable "type_name",rs("type_name")&""
	tpl.SetVariable "arccontent",rs("arccontent")&""
	tpl.SetVariable "archits",rs("archits")&""
		'�����������
		arcsx=rs("arcflag")&""
		arr=split(arcsx,",")
		flagstr=""
		for j=0 to ubound(arr)
			select case Ucase(arr(j))
				case "C":
					flagstr=flagstr&"[<span style='color:red;' title='��ҳ�Ƽ�'>��</span>]"
				case "H":
					flagstr=flagstr&"[<span style='color:red;' title='ͷ������'>ͷ</span>]"
			end select
		next
	tpl.SetVariable "flagstr",flagstr
	
	tpl.SetVariable "haveimg",getarcimg(rs("arcpic")&"")
	tpl.ParseBlock "arclist"
	rs.movenext
    else
         exit for
    end if
next
'��ʾ��ҳ��Ϣ������������ԣ���set rs=mypage.getrs()�Ժ�,��������λ�õ��ã����Ե��ö��
tpl.setvariable "pagenav",mypage.getshowpage()
tpl.Parse
'Destroy our objects
set tpl = nothing


'�ж������Ƿ���ͼ
function getarcimg(str)
	if str<>"" then
		getarcimg="[<img src='images/haveimg.gif' style='cursor:pointer; border:none;' width='12' height='12' alt='������ͼƬ��ʾ' title='������ͼƬ��ʾ' />]"
	else
		getarcimg=""
	end if
end function
%>