<!--#include file="lib/AdminInIt.asp"-->
<!--#include file="../lib/page.class.asp"-->
<%
gettablefield("kl_cats")
'�ƶ�����վ
if act="huishousingle" then
		id=G("id")
		result=db.UpdateRecord("kl_archives","id="&id,array("recycling:1"))
		if result=0 then
			AlertMsg("����ʧ��")
		end if
end if
if G("batchid")<>"" then
	str=G("batchid")
	arr=split(str,",")
	dim result
	for i=0 to ubound(arr)
		result=db.UpdateRecord("kl_archives","id="&arr(i),array("recycling:1"))
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
mypage.getsql="SELECT a.id,a.cat_id as catid,a.arctitle,a.fbdate,a.arcflag,a.uddate,b.cat_name,c.type_name,a.arccontent,a.arcpic,a.recycling,a.archits from (kl_archives as a inner join  kl_cats as b on a.cat_id=b.cat_id) inner join kl_content_types as c on a.type_id=c.type_id  where recycling=0  "& guolv &" order by fbdate desc"
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
	tpl.SetVariable "cat_id",rs("catid")&""
	tpl.SetVariable "title",rs("arctitle")&""
	tpl.SetVariable "arctitle",left(rs("arctitle")&"",15)
	tpl.SetVariable "uddate",rs("uddate")&""
	tpl.SetVariable "fbdate",rs("fbdate")&""
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
		getarcimg="<div class='catimg'><img class='haveimg' src='images/haveimg.gif' style='cursor:pointer;' width='12' height='12' alt='���������ͼƬ��ʾ' title='���������ͼƬ��ʾ' /><span class='catdaimg' ><img src='"&str&"' width='150' height='150' /></span></div>"
	
		'getarcimg="[<img src='images/haveimg.gif' style='cursor:pointer; border:none;' width='12' height='12' alt='������ͼƬ��ʾ' title='������ͼƬ��ʾ' />]"
	else
		getarcimg=""
	end if
end function
%>