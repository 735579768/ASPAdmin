<%
on error resume next
dim ajaxstr
dim id:id=G("id")
'����ɾ����̨�˵�����
	if G("action")="delmenu" then
		'��ѯ����ǲ��Ƕ����˵����ж��ǲ������Ӳ˵�
			set rs=db.query("select * from "& suffix &"sysmenus where parent_menu_id="& id)
		if rs.eof then 
			 db.query("delete * from "& suffix &"sysmenus where sysmenuid="& id) 
			 ajaxstr=1
		else
			 ajaxstr=AJAX_NODELMENU
		end if
	end if
'���º�̨�˵���������
	if G("action")="updtsort" then
		dim menusort:menusort=G("sort")
		db.query("update kl_sysmenus set [sort]='"&menusort&"' where sysmenuid="&id)
		ajaxstr=1
	end if
'ɾ��ǰ̨��Ŀ�˵�
	if G("action")="delcat" then
			'�ж�������������ǲ��������£��еĻ�����ɾ��
			set rs=db.GetRecord("kl_archives","*","cat_id="&id,"",0)
			if not rs.eof then 
				ajaxstr="�����������²���ɾ��!"
				echo ajaxstr
				die("")
			end if
			'��ѯ����ǲ��Ƕ����˵����ж��ǲ������Ӳ˵�,�����Ӳ˵��Ĳ���ɾ��
			set rs=db.query("select * from "& suffix &"cats where parent_id="& id)
			if rs.eof then 
				 db.query("delete * from "& suffix &"cats where cat_id="& id)
				 ajaxstr=1 
			else
				 ajaxstr=AJAX_NODELMENU
			end if
	end if
	
'ɾ����������
	if G("action")="delfriendlink" then
		friend_id=G("friend_id")
		result=db.deleteRecord("kl_friend_link","friend_id",friend_id)
		if result<>0 then
			ajaxstr=1
		end if
	end if
''�����Ƶ�����վ����
'	if G("action")="delarticle" then
'		id=G("id")
'		result=db.UpdateRecord("kl_archives","id="&id,array("recycling:1"))
'		if result<>0 then
'			ajaxstr=1
'		end if
'	end if
echo ajaxstr
die("")
%>