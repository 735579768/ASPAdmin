<%
'////////////////////////////////////
'��ʼ��ϵͳ�����ò���
'//////////////////////////////////
on error goto 0
'�ַ�������
Response.Addheader "Content-Type","text/html; charset=gbk" 

'���ݿ�����
const Sql_Server = "127.0.0.1" '���ݿ��������ַ 
const Sql_User = "" '���ݿ��¼�� 
const Sql_Pass = "" '���ݿ����� 
const Sql_Data = "/admin/#data/#aspadmindata.mdb" '���ݿ���
const suffix ="kl_"

'��̨�ļ���Ŀ¼
const adminDir="admin"


'��½id���� Ȩ�޲�����������Ա(0)  ��ͨ����Ա(1)  
dim login_id
login_id=0


'ģ������
dim TPL_PATH
	TPL_PATH="templates/"
%>