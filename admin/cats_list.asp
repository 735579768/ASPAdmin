<!--#include file="lib/AdminInIt.asp"-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script src="js/jquery-1.8.1.min.js" type="text/javascript"></script>
<import file="Js.jquery-1#8#1#min" />
<link href="css/main.css" rel="stylesheet" type="text/css" />
<title>添加信息</title>
</head>
<style>
.biaotou {
	background: url(images/tbg.gif) repeat-x;
	height: 28px;
}
table {
	border-color: #FBFCE2;
}
table td table td, table td table {
	border: none;
	text-align: left;
	line-height: 28px;
	height: 28px;
}
td {
	border-bottom: 1px dotted #BCBCBC;
	height: 28px;
	padding: 2px;
	font-size: 12px;
	font-family: "宋体";
	background-color: #FFF;
}
.catimg{ position:relative; display:inline-block;}
.catimg span{ background:#fff; border:solid 1px #ccc; padding:5px;}
.catimg .catdaimg{ display:none; position:absolute; left:-150px; top:0px; z-index:999;}

.lanmu{ margin:0 auto; }
.lanmu,.lanmu dt,.lanmu dd{display:block;  width:100%; margin:0px; padding:0px;}
.lanmu dt,.lanmu dd{ height:30px; line-height:30px;}
.lanmu dt{ background:url(images/tbg.gif) repeat-x;padding:0px 40px;}
.lanmu dd{padding:0px 90px;border-bottom: 1px dotted #BCBCBC;}
.lanmu dt .left{ width:530px; float:left;}
.lanmu dt .right{ float:left;}

.lanmu dd .left{ width:480px; float:left;}
.lanmu dd .right{ float:left;}
.lanmu dt .jiajian{ display:block; float:left; margin:10px; cursor:pointer;}
</style>
<body>

<dl class="lanmu">
<dt><a href="javascript:zall();" class="coolbg zhankai">全部展开</a>
<a href="javascript:hall();" class="coolbg hebing">全部合并</a></dt>
</dl>

<%
dim menujibie
 menujibie=1
sql="select cat_id from kl_cats where parent_id=0 order by sort asc "
set xhrs=db.query(sql)
if xhrs.recordcount>0 then
	do while not xhrs.eof
		menujibie=1
		call getcatlist(xhrs("cat_id"))
	xhrs.movenext
	loop
end if
%>

<script type="text/javascript">
function zall(){
	$('.jiajian').attr('src','images/jian.gif');
	$('.lanmu dd,.lanmu .senondmenu').show();
	}
function hall(){
	$('.jiajian').attr('src','images/jia.gif');
	$('.lanmu dd,.lanmu .senondmenu').hide();
	}
hall();
$(function(){
		$(".lanmu dd").bind("mouseover",function(){
			$(this).css('background','#FBFCE2');
		});
		$(".lanmu dd").bind("mouseout",function(){
			$(this).css('background','#ffffff');
		});
	$('.lanmu .jiajian').bind('click',function(){
		var a=$(this).attr('src')
		if(a=='images/jia.gif'){
			$(this).attr('src','images/jian.gif');
			}else{
			$(this).attr('src','images/jia.gif');	
				}
		$(this).parent().parent().parent().children('dd,div').toggle();
		});
//ajax删除前台菜单
	$(".delcat").bind("click",function(){
		if(!confirm('确认要删除吗？'))return;
		var obj=$(this);
		var id=obj.prev().val();
		$.get('./',{
			'act':'ajax',
			'action':'delcat',
			'id':id
			},function(data){
					if(data=='1'){
							alert("删除成功！");
							obj.parent().parent().remove();	
						}else{
							alert(data);
							}
				})
		});
		$(".haveimg").bind("mouseover",function(){
			$(this).next().show();
			});
		$(".catdaimg img").bind("mouseover",function(){
			$(this).parent().show();
			});
		$(".catdaimg").bind("mouseout",function(){
			$(this).hide();
			});
	})
</script>
</body>
</html>

<%
'////////////////////////////////////////////////////////本页函数库///////////////////////////////////////////////////////////
''文章列表内容输输出
function getcatshow(str)
	if "1"=str then
		getcatshow=NAVSHOW
	else
		getcatshow="<span style='color:red;'>"&NAVHIDDEN&"</span>"
	end if
end function
'判断分类封面是否有图
function getcatimg(str)
	if str<>"" then
		getcatimg="<div class='catimg'><img class='haveimg' src='images/haveimg.gif' style='cursor:pointer;' width='12' height='12' alt='分类封面有图片显示' title='分类封面有图片显示' /><span class='catdaimg' ><img src='"&str&"' width='150' height='150' /></span></div>"
	else
		getcatimg=NOIMG
	end if
end function
'查询分类文章数量
function getarcnum(catid)
	sql="select count(*) as  a from kl_archives where cat_id="&catid
	set bbbb=db.query(sql)
	getarcnum=bbbb("a")&""
	set bbbb=nothing
end function


'无限分类调用函数
Function getcatlist(catid)
sqlstr="select a.cat_name as catname,a.type_id as typeid,* from kl_cats as a inner join kl_content_types as b on a.type_id=b.type_id   where a.cat_id="&catid&" order by sort asc "
set wraprs=db.query(sqlstr) 
cid1=wraprs("cat_id")&""'分类id
cname1=wraprs("catname")&""'分类name
typeid1=wraprs("typeid")&""'类型id
arcnum1=getarcnum(wraprs("cat_id")&"")
sort1=wraprs("sort")&""
havepic1=getcatimg(wraprs("cat_pic")&"")
navshow1=getcatshow(wraprs("cat_show")&"")



%>
	<dl class='lanmu'>
		<dt>
        	<div class='left'>
                <img class='jiajian' src='images/jian.gif' width='9' height='9' />
                栏目：<u><a title='点击查看此分类下文章' href='article_list.asp?cat_id=<%=cid1%>' target='_self'><%=cname1%></a></u>
                <span class='red'>(ID:<%=cid1%>,文档数:<%=arcnum1%>)</span>(<%=wraprs("type_sxname")%>)
            </div>
            <div class='right'> 
                <a href='add_article.asp?cat_id=<%=cid1%>' title='在此分类下添加信息'  class='coolbg red'>添加信息</a> 
                <a href='edit_cats.asp?cat_id=<%=cid1%>&type_id=<%=typeid1%>' class='coolbg'>更改</a>
                <input type='hidden'  value='<%=cid1%>' />
                <a href='javascript:void(0);' class='coolbg delcat'>删除</a>
                <a href='add_cats.asp?parent_id=<%=cid1%>&type_id=<%=typeid1%>' class='coolbg'>增加子类</a> 
                (排序：<%=sort1%>)(<%=navshow1%>)(<%=havepic1%>)
            </div>
    	</dt>
<%
		sqlstr="select a.cat_id as catid,a.cat_name as catname,a.type_id as typeid,* from kl_cats as a inner join kl_content_types as b on a.type_id=b.type_id   where a.parent_id="&catid&" order by sort asc "
		set neirs=db.query(sqlstr) 
		
		if neirs.recordcount>0 then 
			do while not neirs.eof

		'如果有子菜单就去输出子菜单
		if isparentcat(neirs("catid")) then
				menujibie=menujibie+1 
			echo "<dd class='menujibie"&cstr(menujibie)&"' style='_padding-left:0px;'>"
			 call getcatlist(neirs("catid"))
			echo "</dd>"
		else
			cid2=neirs("catid")&""'分类id
			cname2=neirs("catname")&""'分类name
			arcnum2=getarcnum(neirs("catid")&"")
			typeid2=neirs("typeid")&""'类型id
			sort2=neirs("sort")&""
			havepic2=getcatimg(neirs("cat_pic")&"")
			navshow2=getcatshow(neirs("cat_show")&"")

%>
    <dd>
    	<div class='left'>
    		栏目：<u><a title='点击查看此分类下文章'  href='article_list.asp?cat_id=<%=cid2%>' target='_self'><%=cname2%></a></u><span class='red'>(ID:<%=cid2%>,文档数:<%=arcnum2%>)</span>(<%=neirs("type_sxname")%>)
        </div>
        <div class='right'>
                    <a href='add_article.asp?cat_id=<%=cid2%>' title='在此分类下添加信息'  class='coolbg red'>添加信息</a> 
                <a href='edit_cats.asp?cat_id=<%=cid2%>&type_id=<%=typeid2%>' class='coolbg'>更改</a>
                <input type='hidden'  value='<%=cid2%>' />
                <a href='javascript:void(0);' class='coolbg delcat'>删除</a>
                <a href='add_cats.asp?parent_id=<%=cid2%>&type_id=<%=typeid2%>' class='coolbg'>增加子类</a> 
                (排序：<%=sort2%>)(<%=navshow2%>)(<%=havepic2%>)
        </div>
    </dd>
    <%
			end if
			neirs.movenext
			loop
			set neirs=nothing
	end if
	%>
	</dl>
<%

End function

Function isparentcat(catid)
	sqlstr="select * from kl_cats where  parent_id="&catid&" order by sort asc"
	set krs=db.query(sqlstr)
	if krs.recordcount>0 then
		isparentcat=true
	else
		isparentcat=false
	end if
	set krs=nothing
end function
%>