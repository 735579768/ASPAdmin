function autowh(){
	this.run=function(options){
					var defaults={
						'autoW':138,//nav显示时候拥有的类
						'autoH':130,//div显示的时候拥有的类
						'sel':'.imgbox img'//tab的切换模式，默认为mouseover
						};
					var opts = $.extend(defaults, options);
					$(opts.sel).each(function(index, element) {
				
				var w=$(this).width();
				var h=$(this).height();
				if(w=750){
					w=750;
					}
					if (w!=0 && h!=0){
						if(w>h){
								if(w>opts.autoW){
									$(this).removeAttr('height');
									$(this).attr('width',opts.autoW)
									var temh=$(this).height();
									if(temh>opts.autoH){
										$(this).removeAttr('width');
										$(this).attr('height',opts.autoH)
										}
										
										
								}else{
									$(this).attr('width',w)
								}
						
						}else{
								if(h>opts.autoH){
									$(this).removeAttr('width');
									$(this).attr('height',opts.autoH)
									var temw=$(this).width();
									if(temw>opts.autoW){
										$(this).removeAttr('height');
										$(this).attr('width',opts.autoW)
										}
										
								}else{
									$(this).attr('height',h);
								}
						}
					}
					});
					
				obj=this;
					setTimeout(function(){
						obj.run({
						'autoW':opts.autoW,//宽
						'autoH':opts.autoH,//高
						'sel':opts.sel//选择器
						});},100); 

			}
	
	}

$(function(){
var a=new autowh()
	a.run({
			'autoW':150,//宽
			'autoH':94,//高
			'sel':'.er_1nr img'//选择器
		})   
	a.run({
		'autoW':140,//宽
		'autoH':94,//高
		'sel':'.fengcnr img'//选择器
	})  
	a.run({
		'autoW':146,//宽
		'autoH':110,//高
		'sel':'.ziznr img'//选择器
	}) 
	

	$('.nonull').bind('focus',function(){
		$(this).css({border:'solid 1px #ccc',color:'#000'});
		$(this).val('')
	//	$(this).prevAll().filter('.yanzheng').remove();
		});
	 
});
function tjcheck(){
	var re=true;
	$('.nonull').each(function(index, element) {
        if($(this).val()==''){
			$(this).val('请输入内容')
			$(this).css({color:'#ccc',border:'solid 1px #f00'});
			//$(this).after("<span class='yanzheng' style='color:red;'>必填项</span>")
			re=false;
			}
    });
	if(re){
		document.form1.submit();
		}
}
/*
<a href="javascript:void(0)" onclick="SetHome(this,window.location)">设为首页</a>
<a href="javascript:void(0)" onclick="shoucang(document.title,window.location)">加入收藏</a>
*/
// 设置为主页
function SetHome(obj,vrl){
        try{
                obj.style.behavior='url(#default#homepage)';obj.setHomePage(vrl);
        }
        catch(e){
                if(window.netscape) {
                        try {
                                netscape.security.PrivilegeManager.enablePrivilege("UniversalXPConnect");
                        }
                        catch (e) {
                                alert("此操作被浏览器拒绝！\n请在浏览器地址栏输入“about:config”并回车\n然后将 [signed.applets.codebase_principal_support]的值设置为'true',双击即可。");
                        }
                        var prefs = Components.classes['@mozilla.org/preferences-service;1'].getService(Components.interfaces.nsIPrefBranch);
                        prefs.setCharPref('browser.startup.homepage',vrl);
                 }else{
                     alert("您的浏览器不支持，请按照下面步骤操作：1.打开浏览器设置。2.点击设置网页。3.输入："+vrl+"点击确定。"); 
                 }              
        }
}

// 加入收藏 兼容360和IE6
function shoucang(sTitle,sURL)
{       
       try
        {
            window.external.addFavorite(sURL, sTitle);
        }
        catch (e)
        {
            try
            {
                window.sidebar.addPanel(sTitle, sURL, "");
            }
            catch (e)
            {
                alert("加入收藏失败，请使用Ctrl+D进行添加");
            }
        }
}