$(function () {
	$('body').on("click",'.one',function() {
				// $('.kid').hide();
				// $(this).parent().parent().find('.kid').toggle();//
				// $(this)指<a>
				if ($(this).parent().parent().find('.kid').is(":visible")) {
					$('.kid').hide();
					$(this).parent().parent().find('.kid').hide();
				} else {
					$('.kid').hide();
					$(this).parent().parent().find('.kid').show();

					choseterm = $(this);
					setChosetermid();
					//console.log($(this).attr("id"));
					if ($(this).attr("id") != "search" && $(this).attr("id") != "draw") {
						Conframe.window.cleanAllMaker();// 清除所有覆盖物
						Conframe.window.getClientsData(mapTermpagein[$(this)
								.attr("id")]);// 加载对应组的终端maker
					} else if ($(this).attr("id") == "search"){
						Conframe.window.cleanAllMaker();// 清除所有覆盖物
						//Conframe.window.changePreMakerdata(searchdata);
						//console.log(mapTermpage[-1]);
						Conframe.window.getClientsData(mapTermpage[-1]);
						//Conframe.window.addClientMaker(searchdata);	
					}else if ($(this).attr("id") == "draw"){
						Conframe.window.cleanAllMaker();// 清除所有覆盖物
						//console.log(mapTermpage[-2]);
						Conframe.window.getClientsData(mapTermpage[-2]);
						//Conframe.window.changePreMakerdata(drawdata);
						//console.log(drawdata);
						//Conframe.window.addClientMaker(drawdata);
					}
				}
			});
    
  // $('.onekid').live("click",function () {
	$('body').on("click",'.onekid',function () {
        //$('.onekid').removeClass('one-hover');
        //$(this).addClass('one-hover');
        var str=$(this).attr("id");
        if(str!="more"){
        	Conframe.window.changeCenterByid(str);
        }else{
        	$(this).parent().remove();
        	var termid=choseterm.attr("id");
           	//Conframe.window.getClientsData(mapTermpage[termid]);//加载对应组的终端maker/////////////////////////
        	$.ajax({
        		url : "gomap/lefe_cnext",
        		type : "POST",
        		contentType : "application/json; charset=UTF-8",
        		data : JSON.stringify(mapTermpage[termid]),
        		dataType : "json",
        		success : function(data) {
        			if (data.length != 0) {
        				gpsTObbdMore(data,termid,choseterm);
        				mapTermpage[termid].begin= mapTermpage[termid].begin+ mapTermpage[termid].rows;
        				mapTermpagein[termid].rows= mapTermpagein[termid].rows+ mapTermpagein[termid].rows;
        				Conframe.window.cleanAllMaker();//清除所有覆盖物
        				//console.log(mapTermpagein[termid]);
        				Conframe.window.getClientsData(mapTermpagein[termid]);//加载对应组的终端maker
        			} else {
        			}      			
        		},
        		error : function() {
        		}
        	});
        	
        }
    });
    
    //影藏菜单
    var l = $('.left_c');
    var r = $('.right_c');
    var c = $('.Conframe');
    var s = $('.searchdiv');
    $('.nav-tip').click(function () {
        if (l.css('left') == '8px') {
            l.animate({
                left: -300
            }, 500);
            r.animate({
                left: 21
            }, 500);
            c.animate({
                left: 29
            }, 500);
            s.animate({
                left: 29
            }, 500);
            $(this).animate({
                "background-position-x": "-12"
            }, 300);
        } else {
            l.animate({
                left: 8
            }, 500);
            r.animate({
                left: 260
            }, 500);
            c.animate({
                left: 268
            }, 500);
            s.animate({
                left: 268
            }, 500);
            $(this).animate({
                "background-position-x": "0"
            }, 300);
        };
    });
    //横向菜单
    $('.top-menu-nav li').click(function () {
        $('.kidc').hide();
        $(this).find('.kidc').show();
        
    });
    $('.kidc').bind('mouseleave', function () {
        $('.kidc').hide();
    }); 

});
