<%
'==============================================
'系统参数获取
'取标签内name参数的值
'示例
'nme=tpl.tagparam("name")
'==============================================
'标签功能说明
'
'==============================================

'取参数
nme=tpl.tagparam("name")
'本文件内不能输出内容下面这一句把内容传进去就可以啦
tpl.assign "tagcontent",nme
%>