<!--#include file="lib/AdminInIt.asp"-->
<!--#include file="../lib/page.class.asp"-->
<%
'tpl.SetTemplatesDir("")
'�����ļ�
'tpl.setVariableFile "TOP_HTML","public/top.html"
'tpl.setVariableFile "FOOTER_HTML","public/footer.html"
'��������
Set mypage=new xdownpage
'�õ����ݿ�����
mypage.getconn=db.idbconn
'sql���
mypage.getsql="SELECT * from kl_friend_link order by friend_id desc"
'����ÿһҳ�ļ�¼������Ϊ5��
mypage.pagesize=15
'����Recordset
set rs=mypage.getrs()


'��ʾ����
'set rs=db.query("SELECT a.id,a.arctitle,a.arcfbdate,b.cat_name,c.type_name,a.arccontent,a.arcpic,a.recycling  from (kl_articles as a inner join  kl_cats as b on a.cat_id=b.cat_id) inner join kl_content_types as c on a.type_id=c.type_id")
	tpl.UpdateBlock "friendlinklist"
	
	'������������б�
for i=1 to mypage.pagesize
	if not rs.eof then
	tpl.SetVariable "friend_id",rs("friend_id")&""
	tpl.SetVariable "friend_name",rs("friend_name")&""
	tpl.SetVariable "friend_url",rs("friend_url")&""
	tpl.SetVariable "friend_weizhi",rs("friend_weizhi")&""
	tpl.SetVariable "friend_email",rs("friend_email")&""
	tpl.ParseBlock "friendlinklist"
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
%>