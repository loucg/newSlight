<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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

<!-- jsp文件头和头部 -->
<%@ include file="../index/top.jsp"%>
<!-- 百度echarts -->
<script src="plugins/echarts/echarts.min.js"></script>

<style type="text/css"> /** 重置浏览器默认标签样式 */ 

body,ul,li{	margin:0;
			padding:0;
			}
.xttblog{   width: 1400px;
			padding-top:100px; 
			margin-left: 20px;
 			 }
.box{		margin-left: 1%;
			margin-top: 5px;
			margin-bottom:20px;
			list-style-type:none;
			}
.box:after{ content: ".";
 			display: block;
  			line-height: 10;
   			width:0;
    		height: 0;
     		clear: both;
      		visibility: hidden;
       		overflow: hidden;
       		 }
.box li{	float:left;
			line-height: 10px;
			cursor: pointer;
			padding-left : 100px;
			}
.box li a,.box li a:visited{ 
			display:block;
			border: 0px solid #ccc; 
			width: 180px;
			/* height: 230px; */ 
			text-align: center;
			margin-left: -5px; 
			margin-top: -5px;
			position: relative;
			z-index: 1; 
			}
/* .box li a:hover{
			display:block;
			border: 5px solid #ccc; 
			background:#ddd;
			color:#f00;
			z-index: 2;
			} 
.max a:hover{
			display:block;
			border: 5px solid #ccc; 
			background:#ddd;
			color:#f00;
			z-index: 2;
			}  */
			img{
			cursor:pointer;
			transition:all 0.6s;
			height:200px;
			width:240px;
			}
			img:hover{
			transform:scale(1.15);
			}
</style>
</head>
<body >

 
 
<!-- <div style="margin-top:2px">
<img src="static/login/images/main.jpg" />
</div> -->
 	<!-- /section:basics/navbar.layout -->
 	<c:if test="${sessionScope.session_language=='zh_CN' }">
	<div class="main-container" id="main-container" style="background:url('static/login/images/bg.png') no-repeat;width:100%;height:566px;margin-top:5px;background-size:cover">	
	     	<div class="xttblog"> 		
			<ul class="box">
<!-- 			<li><a onclick="edit(3,'日志管理','fhlog/list.do');" ><img src="static/login/images/czrz.jpg"/></a></li>  -->
<!-- 			<li><a onclick="edit(314,'管理','strategy/listStrategys.do');" ><img src="static/login/images/clkz.jpg"/></a></li> -->
<!-- 			<li><a onclick="edit(347,'地图控制','gomap/content.do');" ><img src="static/login/images/dtkz.jpg"/></a></li> -->
<!-- 			<li><a onclick="edit(371,'故障统计','analysis/faultlist');" ><img src="static/login/images/gzbj.jpg"/></a></li> -->
				<li><a onclick="edit(3,'设备状态','equimentanaylise/retrieve.do');" ><img src="static/login/images/sbzt.png" /></a></li>
	 			<li><a onclick="edit(80,'分组控制','group/listGroups.do');"><img src="static/login/images/fzkz.png"/></a></li> 
	 			<li><a onclick="edit(347,'地图控制','gomap/content.do');" ><img src="static/login/images/dtkz.png"/></a></li> 
			
			</ul>	
		    <ul class="box">
			<li><a onclick="edit(314,'策略包','strategy/listStrategySet.do');" ><img src="static/login/images/clsd.png"/></a></li> 
	 		<li><a onclick="edit(369,'数据分析','poweranalysis/powerlist');"><img src="static/login/images/sjfx.png"/></a></li> 
			<li><a onclick="edit(344,'维修记录','repair/weixiu');"><img src="static/login/images/tswx.png"/></a></li>
<!-- 			<li><a onclick="edit(67,'基础配置','config/goCombination');"><img src="static/login/images/jcpz.jpg"/></a></li> -->
<!-- 			<li><a onclick="edit(80,'分组设置','group/listGroups.do');"><img src="static/login/images/ldfz.jpg"/></a></li> -->
<!-- 			<li><a onclick="edit(369,'能耗统计','poweranalysis/powerlist');"><img src="static/login/images/sjfx.jpg"/></a></li> -->
<!-- 			<li><a onclick="edit(344,'维修记录','repair/weixiu');"><img src="static/login/images/wxjl.jpg"/></a></li>  -->
			</ul>
			</div> 
			
			<div style="margin-left:846px;margin-top:-353px;cursor: pointer;width: 180px;"> 
			 <ul class="max">
<!-- 			<a onclick="edit(338,'路灯状态','state/lamp/listLamps.do');"><img src="static/login/images/ldfx.jpg"/></a> -->
			</ul>
		 </div>
		<!-- /section:basics/sidebar -->
		<!-- <div class="main-content">
			<div class="main-content-inner"> -->
				<!-- <div class="page-content">
					<div class="hr hr-18 dotted hr-double"></div>
					<div class="row">
						<div class="col-xs-12">

							<div class="alert alert-block alert-success">
								<button type="button" class="close" data-dismiss="alert">
									<i class="ace-icon fa fa-times"></i>
								</button>
								<i class="ace-icon fa fa-check green"></i>
								欢迎使用 FH Admin 系统&nbsp;&nbsp;
								<strong class="green">
									&nbsp;QQ:313596790
									<a href="http://www.fhadmin.org" target="_blank"><small>(&nbsp;www.fhadmin.org&nbsp;)</small></a>
								</strong>
							</div>
							
							
							<div id="main" style="width: 600px;height:300px;"></div>
							
							<script type="text/javascript">
						        // 基于准备好的dom，初始化echarts实例
						        var myChart = echarts.init(document.getElementById('main'));
						
						        // 指定图表的配置项和数据
								var option = {
						            title: {
						                text: 'FH Admin用户统计'
						            },
						            tooltip: {},
						            xAxis: {
						                data: ["系统用户","系统会员"]
						            },
						            yAxis: {},
						            series: [
						               {
						                name: '',
						                type: 'bar',
						                data: [${pd.userCount},${pd.appUserCount}],
						                itemStyle: {
						                    normal: {
						                        color: function(params) {
						                            // build a color map as your need.
						                            var colorList = ['#6FB3E0','#87B87F'];
						                            return colorList[params.dataIndex];
						                        }
						                    }
						                }
						               }
						            ]
						        };	        

						        // 使用刚指定的配置项和数据显示图表。
						        myChart.setOption(option);
						    </script>
							
						</div>
						/.col
					</div>
					/.row
				</div>
			  -->
				<!-- /.page-content -->
		<!-- 	</div>
		</div>
		 -->
		<!-- /.main-content -->


		
    
	</div>
 	</c:if>
 	<c:if test="${sessionScope.session_language=='en_US' }">
			<div class="main-container" id="main-container" style="background:url('static/login/images/bg.png') no-repeat;width:100%;height:566px;margin-top:5px;background-size:cover">	
	     <div class="xttblog"> 		
			<ul class="box">
			<!-- <li><a onclick="edit(3,'日志管理','fhlog/list.do');" ><img src="static/login/images/czrz_01.jpg"/></a></li> 
			<li><a onclick="edit(314,'管理','strategy/listStrategys.do');" ><img src="static/login/images/clkz_01.jpg"/></a></li>
			<li><a onclick="edit(347,'地图控制','gomap/content.do');" ><img src="static/login/images/dtkz_01.jpg"/></a></li>
			<li><a onclick="edit(371,'故障统计','analysis/faultlist');" ><img src="static/login/images/gzbj_01.jpg"/></a></li>
			 -->
			 <li><a onclick="edit(3,'设备状态','equimentanaylise/retrieve.do');" ><img src="static/login/images/sbzt_en.png"/></a></li> 
 			 <li><a onclick="edit(80,'分组控制','group/listGroups.do');"><img src="static/login/images/fzkz_en.png"/></a></li> 
 			 <li><a onclick="edit(347,'地图控制','gomap/content.do');" ><img src="static/login/images/dtkz_en.png"/></a></li> 
			
			</ul>
			 <ul class="box">
			<!-- <li><a onclick="edit(67,'基础配置','config/goCombination');"><img src="static/login/images/jcpz_01.jpg"/></a></li>
			<li><a onclick="edit(80,'分组设置','group/listGroups.do');"><img src="static/login/images/ldfz_01.jpg"/></a></li>
			<li><a onclick="edit(369,'能耗统计','poweranalysis/powerlist');"><img src="static/login/images/sjfx_01.jpg"/></a></li>
			<li><a onclick="edit(344,'维修记录','repair/weixiu');"><img src="static/login/images/wxjl_01.jpg"/></a></li> 
			 -->
			 <li><a onclick="edit(314,'策略包','strategy/listStrategySet.do');" ><img src="static/login/images/clsd_en.png"/></a></li> 
	 		 <li><a onclick="edit(369,'数据分析','poweranalysis/powerlist');"><img src="static/login/images/sjfx_en.png"/></a></li> 
			 <li><a onclick="edit(344,'维修记录','repair/weixiu');"><img src="static/login/images/tswx_en.png"/></a></li>
			</ul>
			</div> 
			
			<div style="margin-left:846px;margin-top:-353px;cursor: pointer;width: 180px;"> 
			 <ul class="max">
			<!-- <a onclick="edit(338,'路灯状态','state/lamp/listLamps.do');"><img src="static/login/images/ldfx_01.jpg"/></a> -->
			</ul>
		 </div>
		<!-- /section:basics/sidebar -->
		<!-- <div class="main-content">
			<div class="main-content-inner"> -->
				<!-- <div class="page-content">
					<div class="hr hr-18 dotted hr-double"></div>
					<div class="row">
						<div class="col-xs-12">

							<div class="alert alert-block alert-success">
								<button type="button" class="close" data-dismiss="alert">
									<i class="ace-icon fa fa-times"></i>
								</button>
								<i class="ace-icon fa fa-check green"></i>
								欢迎使用 FH Admin 系统&nbsp;&nbsp;
								<strong class="green">
									&nbsp;QQ:313596790
									<a href="http://www.fhadmin.org" target="_blank"><small>(&nbsp;www.fhadmin.org&nbsp;)</small></a>
								</strong>
							</div>
							
							
							<div id="main" style="width: 600px;height:300px;"></div>
							
							<script type="text/javascript">
						        // 基于准备好的dom，初始化echarts实例
						        var myChart = echarts.init(document.getElementById('main'));
						
						        // 指定图表的配置项和数据
								var option = {
						            title: {
						                text: 'FH Admin用户统计'
						            },
						            tooltip: {},
						            xAxis: {
						                data: ["系统用户","系统会员"]
						            },
						            yAxis: {},
						            series: [
						               {
						                name: '',
						                type: 'bar',
						                data: [${pd.userCount},${pd.appUserCount}],
						                itemStyle: {
						                    normal: {
						                        color: function(params) {
						                            // build a color map as your need.
						                            var colorList = ['#6FB3E0','#87B87F'];
						                            return colorList[params.dataIndex];
						                        }
						                    }
						                }
						               }
						            ]
						        };	        

						        // 使用刚指定的配置项和数据显示图表。
						        myChart.setOption(option);
						    </script>
							
						</div>
						/.col
					</div>
					/.row
				</div>
			  -->
				<!-- /.page-content -->
		<!-- 	</div>
		</div>
		 -->
		<!-- /.main-content -->


		
    
	</div>
		
	</c:if>
	<!-- /.main-container -->

	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../index/foot.jsp"%>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<!-- inline scripts related to this page -->
	<script type="text/javascript">
		$(top.hangge());
		
		//修改
		function edit(id, name, url){
			top.mainFrame.tabAddHandler(id,name,url);
	
		}
	</script>
<script type="text/javascript" src="static/ace/js/jquery.js"></script>  
 
</body>
</html>