<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">
<!-- 下拉框 -->
<link rel="stylesheet" href="static/ace/css/chosen.css" />
<link href="static/ace/css/style.css" type="text/css" rel="stylesheet" />
<link href="static/ace/css/stylediv.css" type="text/css" rel="stylesheet"/>
<link href="static/ace/css/tag.css" type="text/css" rel="stylesheet"/>
<!-- jsp文件头和头部 -->
<%@ include file="../system/index/top.jsp"%>
<%@ include file="../international.jsp"%>
<!-- 日期框 -->
<link rel="stylesheet" href="static/ace/css/datepicker.css" />
<style type="text/css">
*{margin:0;padding:0;list-style-type:none;}
a,img{border:0;}
em{font-style:normal;}
body{font:12px/180% Arial, Helvetica, sans-serif;}
a,a:visited{color:#5e5e5e;text-decoration:none;}
a:hover{color:#3366cc!important;text-decoration:none;}
.clear{display:block;overflow:hidden;clear:both;height:0;line-height:0;font-size:0;}
.clearfix:after{content:".";display:block;height:0;clear:both;visibility:hidden;}
.clearfix{display:inline-table;}/* Hides from IE-mac \*/
*html .clearfix{height:1%;}
.clearfix{display:block;}/* End hide from IE-mac */
*+html .clearfix{min-height:1%;}
 .demo{width:1000px;margin:0px auto;position:absolute;padding:100px} 
/* Form input */
.Form li{font-size:21px;font-weight:300}
.Form label{display:inline-block;line-height:1.4em;font-size:18px}
.FancyForm li,.FancyForm li .input{position:relative}
.FancyForm label{
	position:absolute;z-index:2;top:7px;left:10px;display:block;color:#BCBCBC;cursor:text;
	
	-moz-user-select:none;
	-webkit-user-select:none;
	
	-moz-transition:all .16s ease-in-out;
	-webkit-transition:all .16s ease-in-out;
}
.FancyForm .fff{
	position:absolute;z-index:1;top:0;right:0;left:3px;bottom:0;background-color:#fff;
	
	border-radius:8px;
	-moz-border-radius:8px;
	-webkit-border-radius:8px;
}
.FancyForm .val label{left:-9999px;opacity:0!important;filter:alpha(opacity="0")!important;}
/* Button base */
.Button{
	position:relative;
	display:inline-block;
	padding:.45em .825em .45em;
	text-align:center;
	line-height:1em; 
	border:1px solid transparent;
	cursor:pointer; 
	font-size:20px;
	width:100px;
	height:100px;
	border-radius:.3em; 
	-moz-border-radius:.3em; 
	-webkit-border-radius:.3em; 
	
	-moz-transition-property:color, -moz-box-shadow, text-shadow; 
	-moz-transition-duration:.05s; 
	-moz-transition-timing-function:ease-in-out; 
	-webkit-transition-property:color, -webkit-box-shadow, text-shadow; 
	-webkit-transition-duration:.05s; 
	-webkit-transition-timing-function:ease-in-out; 
	
	box-shadow:0 1px rgba(255,255,255,0.8), inset 0 1px rgba(255,255,255,0.35); 
	-moz-box-shadow:0 1px rgba(255,255,255,0.8), inset 0 1px rgba(255,255,255,0.35); 
	-webkit-box-shadow:0 1px rgba(255,255,255,0.8), inset 0 1px rgba(255,255,255,0.35);
}

.Button:hover {text-decoration:none;}
.Button strong {position:relative; z-index:2;}

.Button{
	display:block;border:1px solid;opacity:1;
	
	border-radius:.3em;
	-moz-border-radius:.3em;
	-webkit-border-radius:.3em;
	
	box-shadow:inset 0 1px rgba(255,255,255,0.35);
	-moz-box-shadow:inset 0 1px rgba(255,255,255,0.35);
	-webkit-box-shadow:inset 0 1px rgba(255,255,255,0.35);
	
	-moz-transition-property:opacity;
	-moz-transition-duration:0.5s;
	-moz-transition-timing-function:ease-in-out;
	-webkit-transition-property:opacity;
	-webkit-transition-duration:0.5s;
	-webkit-transition-timing-function:ease-in-out;
}

.Button:hover span{
	-moz-transition-property:opacity;
	-moz-transition-duration:0.05s;
	-moz-transition-timing-function:linear;
	-webkit-transition-property:opacity;
	-webkit-transition-duration:0.05s;
	-webkit-transition-timing-function:linear;
}
.Button:active span{
	-moz-transition:none;
	-webkit-transition:none;
}

/* Red Button */
.RedButton{color:#fcf9f9; text-shadow:0 -1px rgba(34,25,25,0.5);}
.RedButton:hover {color:#fff; text-shadow:0 -1px rgba(34,25,25,0.3);}
.RedButton:active {color:#f2f0f0; text-shadow:0 -1px rgba(34,25,25,0.6);}

.RedButton{
	border-color:#015E91;
	background-color:#3693D5;
	background:-moz-linear-gradient(center top , #54B1EB, #47A0E0 50%, #419FE1 50%, #3683D5);
	background:-o-linear-gradient(top left, #54B1EB, #47A0E0 50%, #419FE1 50%, #3683D5);
	background:-webkit-gradient(linear, 0% 0%, 0% 100%, from(#54B1EB), to(#47A0E0), color-stop(.5,#419FE1),color-stop(.5,#3683D5));
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#54B1EB', endColorstr='#3683D5');
}

.RedButton:hover{
	border-color:#0366AD;
	background-color:#3EA1D6;
	background:-moz-linear-gradient(center top, #5EB4EA, #61A1EE 50%, #59A5EB 50%, #3691E6);
	background:-o-linear-gradient(top left, #5EB4EA, #61A1EE 50%, #59A5EB 50%, #3691E6);
	background:-webkit-gradient(linear, 0% 0%, 0% 100%, from(#5EB4EA), to(#61A1EE), color-stop(.5,#59A5EB),color-stop(.5,#3691E6));
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#5EB4EA', endColorstr='#3691E6');
}

.RedButton:active{
	border-color:#013B6A;
	background-color:#3089C8;
	background:-moz-linear-gradient(center top, #4B9CDD, #4189D5 50%, #3D8BD3 50%, #3093C8);
	background:-o-linear-gradient(top left, #4B9CDD, #4189D5 50%, #3D8BD3 50%, #3093C8);
	background:-webkit-gradient(linear, 0% 0%, 0% 100%, from(#4B9CDD), to(#4189D5), color-stop(.5,#3D8BD3),color-stop(.5,#3093C8));
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#4B9CDD', endColorstr='#3093C8');
}

.RedButton.Button18:hover{
	box-shadow:0 1px rgba(255, 255, 255, 0.8), 0 1px rgba(255, 255, 255, 0.35) inset, 0 0 10px rgba(82, 162, 235, 0.25);
	-moz-box-shadow:0 1px rgba(255, 255, 255, 0.8), 0 1px rgba(255, 255, 255, 0.35) inset, 0 0 10px rgba(82, 162, 235, 0.25);
	-webkit-box-shadow:0 1px rgba(255, 255, 255, 0.8), 0 1px rgba(255, 255, 255, 0.35) inset, 0 0 10px rgba(82, 162, 235, 0.25);
}
.RedButton.Button18:active{
	box-shadow:0 1px 2px rgba(34, 25, 25, 0.25) inset, 0 0 3px rgba(82, 202, 235, 0.35);
	-moz-box-shadow:0 1px 2px rgba(34, 25, 25, 0.25) inset, 0 0 3px rgba(82, 202, 235, 0.35);
	-webkit-box-shadow:0 1px 2px rgba(34, 25, 25, 0.25) inset, 0 0 3px rgba(82, 202, 235, 0.35);	
}
/* tag */
.default-tag a,.default-tag a span,.plus-tag a,.plus-tag a em,.plus-tag-add a{background-color: #66CCFF;height:100px;line-height:100px;text-align: center;font-size: 20px;margin:0 10px 0px 0;border-radius: 10px;}
.tagbtn a{color:#333333;display:block;float:left;overflow:hidden;margin:0 10px 10px 0;padding:0 10px 0 8px;white-space:nowrap;}
/* default-tag */
.default-tag{padding:16px 0 0 0;}
.default-tag a{background-position:100% 0;}
.default-tag a:hover{background-position:100% -22px;}
.default-tag a span{padding:0 0 0 11px;background-position:0 -60px;}
.default-tag a:hover span{background-position:0 -98px;}
.default-tag a.selected{opacity:0.6;filter:alpha(opacity=60);}
.default-tag a.selected:hover{background-position:100% 0;cursor:default;}
.default-tag a.selected:hover span{background-position:0 -60px;}
/* plus-tag */
.plus-tag{padding:0 0 10px 0;}
.plus-tag a{background-position:100% -22px;}
.plus-tag a em{display:block;float:left;margin:5px 0 0 0px;width:0px;height:13px;overflow:hidden;background-position:-165px -100px;cursor:pointer;}
.plus-tag a:hover em{background-position:-168px -64px;}
/* plus-tag-add */
.plus-tag-add li{height:56px;position:relative;}
.plus-tag-add li .label{position:absolute;left:-110px;top:7px;display:block;}
.plus-tag-add button{float:left;}
.plus-tag-add a{float:left;margin:12px 0 0 20px;display:inline;font-size:18px;background-position:-289px -59px;padding:0 0 0 16px;}
.plus-tag-add a.plus{background-position:-289px -96px;}

</style>
</head>
<body class="no-skin">

	<!-- /section:basics/navbar.layout -->
	<div class="main-container" id="main-container">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">
				<div class="page-content">
						<div class="demo">
							<div class="plus-tag tagbtn clearfix" id="myTags" style="float: left;">
							<c:forEach items="${menuList}" var="menu">
									<a class="deleteLink" value="${menu.MENU_ID }" title="<c:if test="${sessionScope.session_language=='en_US' }">${menu.MENU_NAME_EN }</c:if><c:if test="${sessionScope.session_language=='zh_CN' }">${menu.MENU_NAME }</c:if>"
									onclick="openTargetPage('${menu.MENU_ID }','<c:if test="${sessionScope.session_language=='en_US' }">${menu.MENU_NAME_EN }</c:if><c:if test="${sessionScope.session_language=='zh_CN' }">${menu.MENU_NAME }</c:if>','${menu.MENU_URL }')">
									<span><c:if test="${sessionScope.session_language=='en_US' }">${menu.MENU_NAME_EN }</c:if><c:if test="${sessionScope.session_language=='zh_CN' }">${menu.MENU_NAME }</c:if></span><em></em></a>
								</c:forEach>
							</div>
						
							<div class="plus-tag-add" style="float: left;">
									<ul class="Form FancyForm" style="margin-left:10px">
										<li>
											<button id = "ele2" type="button" class="Button RedButton Button18" style="font-size:22px;">+</button>
											<div id="blk2" class="blk" style="display:none;">
									            <div class="head"><div class="head-right"></div></div>
									            <div class="main">
									                <span style="font-size:20px;font-style: normal; ">可选统计项目</span>
									                <a href="javascript:void(0)" id="close2" class="closeBtn">关闭</a>
									                	<div id="mycard-plus">
															<div class="default-tag tagbtn">
																<div class="clearfix">
																<c:forEach items="${menuCardList}" var="menuCard">
																		<a value = "${menuCard.MENU_ID },${menuCard.MENU_URL }" title="<c:if test="${sessionScope.session_language=='en_US' }">${menuCard.MENU_NAME_EN }</c:if><c:if test="${sessionScope.session_language=='zh_CN' }">${menuCard.MENU_NAME }</c:if>" href="javascript:void(0);"><span>
																			<c:if test="${sessionScope.session_language=='en_US' }">
																					${menuCard.MENU_NAME_EN }
																			</c:if>
																			<c:if test="${sessionScope.session_language=='zh_CN' }">
																				${menuCard.MENU_NAME }
																			</c:if></span><em></em></a>
																	</c:forEach>
																</div>
															</div>
														</div>
									            </div>
									            <div class="foot"><div class="foot-right"></div></div>
									        </div>
										</li>
									</ul>
							</div><!--plus-tag-add end-->
						</div>
					<!-- /.col -->
				<!-- /.row -->
			</div>
			<!-- /.page-content -->
		</div>
	</div>
	<!-- /.main-content -->

	<!-- 返回顶部 -->
	<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
		<i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
	</a>

	</div>
	<!-- /.main-container -->
	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../system/index/foot.jsp"%>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<!-- 删除时确认窗口 -->
	<script src="static/ace/js/bootbox.js"></script>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
	<script type="text/javascript" src="static/js/popup_layer.js"></script>
	<script type="text/javascript" src="static/js/tag.js"></script>
	<script type="text/javascript" src="static/js/jquery.contextmenu.r2.js"></script>
	<script type="text/javascript">
		//检索
		function openTargetPage(a,b,c){
			top.mainFrame.tabAddHandler(a,b,c); 
		}
		</script>
	<script type="text/javascript">
	$(document).ready(function(){
		$('.deleteLink').contextMenu('myMenu1',{
			bindings:{
				'delete': function(t){
					var menuId;
					var title = $('span', t).text();
					var a=$(".plus-tag");
					$("a",a).each(function(){
						var d=$(this);
						if(d.attr("title")==title){
							menuId = d.attr("value");
							d.remove();
							return false
						}
					});
					var b=[];
					$("a",a).each(function(){
						b.push($(this).attr("title"))
					});
					if(b.length){
						$('#myTags').show();
					}else{
						$('#myTags').hide();
					}
					$('.default-tag a').removeClass('selected');
					$.each(b, function(index,title){
						$('.default-tag a').each(function(){
							var $this = $(this);
							if($this.attr('title') == title){
								$this.addClass('selected');
								return false;
							}
						})
					});
					$.ajax({
							type: "POST",
							url: '<%=basePath%>lampstatictis/delSubMenu.do',
					    	data: {MENU_ID:menuId},
							dataType:'json',
							cache: false,
							success: function(data){
								 $.each(data.list, function(i, list){
										nextPage('${page.currentPage}');
								 });
							}
						});
				}
			}
		});
	//示例2，弹出层位置可偏移
	new PopupLayer({
		trigger:"#ele2",
		popupBlk:"#blk2",
		closeBtn:"#close2",
		offsets:{
			x:$("#blk2").offset().left,
			y:$("#blk2").offset().top
		}
	});
	
});
</script>

<script type="text/javascript">
var searchAjax=function(){};
var G_tocard_maxTips=30;

$(function(){(
	function(){
		var a=$(".plus-tag");
		$("a em",a).live("click",function(){
			var c=$(this).parents("a"),b=c.attr("title"),d=c.attr("value");
			delTips(b,d)
		});
		
		hasTips=function(b){
			var d=$("a",a),c=false;
			d.each(function(){
				if($(this).attr("title")==b){
					c=true;
					return false
				}
			});
			return c
		};

		isMaxTips=function(){
			return	
			$("a",a).length>=G_tocard_maxTips
		};

		setTips=function(c,d){
			if(hasTips(c)){
				return false
			}if(isMaxTips()){
				alert("最多添加"+G_tocard_maxTips+"个标签！");
				return false
			}
			var key = d.split(',');
			var menuId = key[0];
			var menuUrl = key[1];
			a.append($("<a class=deleteLink title="+c+' value='+menuId+'" onclick=openTargetPage(\''+menuId+'\',\''+c+'\',\''+menuUrl+'\')><span>'+c+'</span><div class=delete></div><em></em></a>'));
			searchAjax(c,d,true);
			rightClick();
			$.ajax({
				type: "POST",
				url: '<%=basePath%>lampstatictis/saveSubMenu.do',
		    	data: {MENU_ID:menuId},
				dataType:'json',
				cache: false,
				success: function(data){
					 $.each(data.list, function(i, list){
							nextPage('${page.currentPage}');
					 });
				}
			});
			return true
		};

		delTips=function(b,c){
			if(!hasTips(b)){
				return false
			}
			$("a",a).each(function(){
				var d=$(this);
				if(d.attr("title")==b){
					d.remove();
					return false
				}
			});
			searchAjax(b,c,false);
			return true
		};

		getTips=function(){
			var b=[];
			$("a",a).each(function(){
				b.push($(this).attr("title"))
			});
			return b
		};

		getTipsId=function(){
			var b=[];
			$("a",a).each(function(){
				b.push($(this).attr("value"))
			});
			return b
		};
		
		getTipsIdAndTag=function(){
			var b=[];
			$("a",a).each(function(){
				b.push($(this).attr("value")+"##"+$(this).attr("title"))
			});
			return b;
		}
	}
	
)()});
</script>
<script type="text/javascript">
// 更新选中标签标签
$(function(){
	setSelectTips();
	$('.plus-tag').append($('.plus-tag a'));
});
var searchAjax = function(name, id, isAdd){
	setSelectTips();
};
// 推荐标签
(function(){
	var str = ['+', '+']
	$('.default-tag a').live('click', function(){
		var $this = $(this),
				name = $this.attr('title'),
				id = $this.attr('value');
		setTips(name, id);
	});
	// 更新高亮显示
	setSelectTips = function(){
		var arrName = getTips();
		if(arrName.length){
			$('#myTags').show();
		}else{
			$('#myTags').hide();
		}
		$('.default-tag a').removeClass('selected');
		$.each(arrName, function(index,name){
			$('.default-tag a').each(function(){
				var $this = $(this);
				if($this.attr('title') == name){
					$this.addClass('selected');
					return false;
				}
			})
		});
	}
})();
var rightClick = function(){
	$('.deleteLink').contextMenu('myMenu1',{
		bindings:{
			'delete': function(t){
				var menuId;
				var title = $('span', t).text();
				var a=$(".plus-tag");
				$("a",a).each(function(){
					var d=$(this);
					if(d.attr("title")==title){
						menuId = d.attr("value");
						d.remove();
						return false
					}
				});
				var b=[];
				$("a",a).each(function(){
					b.push($(this).attr("title"))
				});
				if(b.length){
					$('#myTags').show();
				}else{
					$('#myTags').hide();
				}
				$('.default-tag a').removeClass('selected');
				$.each(b, function(index,title){
					$('.default-tag a').each(function(){
						var $this = $(this);
						if($this.attr('title') == title){
							$this.addClass('selected');
							return false;
						}
					})
				});
				$.ajax({
						type: "POST",
						url: '<%=basePath%>lampstatictis/delSubMenu.do',
				    	data: {MENU_ID:menuId},
						dataType:'json',
						cache: false,
						success: function(data){
							 $.each(data.list, function(i, list){
									nextPage('${page.currentPage}');
							 });
						}
					});
			}
		}
	});
}
</script>
<div class="contextMenu" id="myMenu1">
	<ul>
		<li id="delete"><img src="static/images/cross.png" /> Delete</li>
	</ul>
</div>

</body>
</html>
