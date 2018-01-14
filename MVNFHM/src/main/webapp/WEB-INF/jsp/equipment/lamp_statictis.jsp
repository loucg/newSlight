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
<%@include file="../international.jsp"%>  <!--国际化标签  -->
<!DOCTYPE html>
<html lang="en">
<head>
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="css/zzsc.css">
<link rel="stylesheet" href="css/dcalendar.picker.css"/>
<style type="text/css">
.circle{
	width:100px;
	height:100px;
	text-align:center;
	background-color:#90EE90;
	border-radius:50%;
	-moz-border-radius:50%;
	-webkit-border-radius:50%;
	line-height:100px;
	font-size:20px;
}

.circle2{
	width:100px;
	height:100px;
	text-align:center;
	background-color:#F08080;
	border-radius:50%;
	-moz-border-radius:50%;
	-webkit-border-radius:50%;
	line-height:100px;
	font-size:20px
}

.arc {
    width: 110px;
    height: 110px;  
    position: absolute;
    border-radius: 50%;
    background: #ffffff  ;
}
.arc_left, .arc_right {
    width: 110px; 
    height: 110px;
    position: absolute;
    top: 0;left: 0;
}
.left, .right {
    display: block;
    width:110px; 
    height:110px;
    background:blue;
    border-radius: 50%;
    position: absolute;
    top: 0;
    left: 0;
/*     transform: rotate(30deg); */
}
.arc_right, .right {
    clip:rect(0,auto,auto,55px);
}
.arc_left, .left {
    clip:rect(0,55px,auto,0);
}
.mask {
    width: 102px;
    height: 102px;
    border-radius: 50%;
    left: 4px;
    top: 4px;
    background: #FFF;
    position: absolute;
    text-align: center;
    line-height: 102px;
    font-size: 16px;
}
.block_title {
    font-size:14px;
}
.block_sub_title {
    font-size:12px;
    color:white;
}
.block_num {
    font-size:20px;
    color:white;
}

.border-table {   
	border-collapse: collapse;
	border: 1px;   
	}   
	

.today{
	text-align:center;
	background-color:#F08080;
}
.calander_Body{
	text-align:center;
	background-color:#90EE90;
}

.calander_Head{
	align:center;
	background-color:#9393FF;
	size:20px;
	text-align:center;
}
.circle3{
	width:100px;
	height:100px;
	text-align:center;
	background-color:#9393FF;
	border-radius:50%;
	-moz-border-radius:50%;
	-webkit-border-radius:50%;
	line-height:100px;
	font-size:20px
}
	div.ui-datepicker{height:500px;width:91%;}
	.demoHeaders {
		margin-top: 2em;
	}
	#dialog-link {
		padding: .4em 1em .4em 20px;
		text-decoration: none;
		position: relative;
	}
	#dialog-link span.ui-icon {
		margin: 0 5px 0 0;
		position: absolute;
		left: .2em;
		top: 50%;
		margin-top: -8px;
	}
	#icons {
		margin: 0;
		padding: 0;
	}
	#icons li {
		margin: 2px;
		position: relative;
		padding: 4px 0;
		cursor: pointer;
		float: left;
		list-style: none;
	}
	#icons span.ui-icon {
		float: left;
		margin: 0 4px;
	}
	.fakewindowcontain .ui-widget-overlay {
		position: absolute;
	}
	select {
		width: 200px;
	}
	.dot{
		display:list-item; 
		list-style-type:disc; 
		margin-left:2em;
	}
	.chart-table{
		width: 800px;
		height: 300px;
		border: 0px solid green;
		background:url(static/images/panel.png) no-repeat 0 0;
/*  		background-position: 100% 100%; */
		background-size: 100% 100%;
	}
	.title-back {
 	  display: inline-block;
	  color: white !important;
/* 	  text-shadow: 0 -1px 0 rgba(0, 0, 0, 0.25); */
/* 	  background-image: none !important; */
	  border: 10px solid #FFF;
	  -webkit-transition: background-color 0.15s, border-color 0.15s, opacity 0.15s;
	  -o-transition: background-color 0.15s, border-color 0.15s, opacity 0.15s;
	  transition: background-color 0.15s, border-color 0.15s, opacity 0.15s;
/* 	  cursor: pointer; */
	  vertical-align: middle;
	  margin: 0;
/*  	  position: relative;  */
/*  	  border-top-left-radius: 10px; transparent*/
	  background-color: #007cf9 !important;
 	  border-color: #007cf9;
 	  width:100%;height:100%;
	}
	.title-bar {
		color: white !important;
		background-color: #007cf9;
	}
	.divtable{
		display:inline-table;
		margin-left:20px;
		border:1px solid transparent;
	}
	.divtd{
		display:inline-table;
		margin:0px;
		border:1px solid transparent;
	}
</style>
<base href="<%=basePath%>">
<!-- 下拉框 -->
<link rel="stylesheet" href="static/ace/css/chosen.css" />
<!-- jsp文件头和头部 -->
<%@ include file="../system/index/top.jsp"%>
<script src="static/js/echart/echarts.js"></script>
<script src="static/ace/js/ace/ace.js"></script>
</head>
<body class="no-skin" >

	<!-- /section:basics/navbar.layout -->
	<div class="main-container" id="main-container">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">
				<div class="page-content">
				<form action="lampstatictis/retrieve.do" method="post" name="Form" id="Form">
				<c:forEach items="${lampEnergyList}" var="lamp" varStatus="vs">
				 	<input type="hidden" id='${lamp.seq}'  value='${lamp.total_kwh}'>
				 	<input type="hidden" id='${lamp.seq_time}'  value='${lamp.total_sumtime}'>
				 	<input type="hidden" id='${lamp.dateflag}'  value='${lamp.dayname}'>
				</c:forEach>
				<div style="height: 10px"></div>
				<table>
					<tr>
						<td width="1200px;">&nbsp;&nbsp;</td>
						<td width="120px;">
							<a class="title-back" style="border-top-left-radius: 10px;"><div class="dot"><b style="font-size:14px;"><%=sequenceselect %></b></div></a>
						</td>
						<td class="title-bar" style="border="1">
							<select class="chosen-select form-control" name="TYPE" 
								id="TYPE" data-placeholder="请选择" style="vertical-align:top;font-size:12px;" onchange="tosearch(this.value)">
								<option value="0" <c:if test="${pd.TYPE==0}">selected</c:if>><%=equip_7days %></option>
								<option value="1" <c:if test="${pd.TYPE==1}">selected</c:if>><%=equip_7week %></option>
								<option value="2" <c:if test="${pd.TYPE==2}">selected</c:if>><%=equip_7month %></option>
							</select>
						</td>
						<td style="width:20px;height:26px" border="1"><a class="title-back" style="border-top-right-radius: 10px;heigth:20px"></a></td>
					</tr>
				</table>
				<table style="width:100%;height:100%;" border="0">
					<tr>
						<td width=5%>
						<td width=60% height=400px>
						<table class="chart-table" >
						<tr><td colspan="4" style="padding:0px 10px 10px 10px" >
							<table style="width: 800px;height: 300px;">
								<tr>
									<td width="300px;"><a class="title-back" style="border-top-left-radius: 10px;"><div class="dot"><b style="font-size:14px;"><%=lamp_power_collection%></b></div></a></td>
									<td class="title-bar" style="width:100%;text-align:right;" border="1"></td>
									<td class="title-bar" style="width:100px;" border="1">
									<td style="width:100px;" border="1"><a class="title-back" style="border-top-right-radius: 10px;"></a></td>
								</tr>
								<!-- 灯能耗,时长统计图 start-->
								<tr>
									<td colspan="4" width=100% style="text-align:center">
	   								<div id="main" style="height:350px;width:1050px;"></div>
									 <script type="text/javascript">
								        require.config({
								            paths: {
								                echarts: 'static/js/echart/'
								            }
								        });
								        require(
								            [
								                'echarts',
								                'echarts/chart/bar' 
								            ],
								            function (ec) {
								                var myChart = ec.init(document.getElementById('main')); 
								
								                var option = {
								                    tooltip: {
								                        show: true
								                    },
		// 						                    legend: {
								                        data:["<%=equip_collect%>"],
		// 						                    	textStyle:{fontSize:15}
		// 						                    },
													
								                    xAxis : [
								                        {
								                            type : 'category',
								                            data : [document.getElementById('date1').value,document.getElementById('date2').value
								                            	,document.getElementById('date3').value,document.getElementById('date4').value,
								                            	document.getElementById('date5').value,document.getElementById('date6').value,
								                            	document.getElementById('date7').value]
								                        }
								                    ],
								                    yAxis : [
								                        {
								                            type : 'value'
								                        }
								                    ],
								                    grid: {  
								                    	x: 40,
								                    	y: 30,
								                    	x2: 30,
								                    	y2: 40,
								                   	},  
								                    series : [
								                        {
								                            "name":"<%=lamp_power_collection%>",
								                            "type":"bar",
								                            "data":[
								                            	document.getElementById('1').value,
								                            	document.getElementById('2').value, 
								                            	document.getElementById('3').value,
								                            	document.getElementById('4').value,
								                            	document.getElementById('5').value, 
								                            	document.getElementById('6').value,
								                            	document.getElementById('7').value
								                            	]
								                        }
								                    ]
								                };
								               myChart.setOption(option); 
								            }
								        );
									 </script>
									</td>
								</tr>
								
								
							</table>
						</td></tr></table>
						</td>
					</tr>
				</table>
				<div>
					<table style="margin:5px; width:100%;height:100%;" border="0">
					<tr>
						<td width=5%>
						<td width=60% height=400px>
						<table class="chart-table" >
						<tr><td colspan="4" style="padding:0px 10px 20px 10px" >
							<table style="width: 800px;height: 300px;">
								<tr>
									<td width="300px;"><a class="title-back" style="border-top-left-radius: 10px;"><div class="dot"><b style="font-size:14px;"><%=lamp_sumtime_collection%></b></div></a></td>
									<td class="title-bar" style="width:100%;text-align:right;" border="1"></td>
									<td class="title-bar" style="width:100px;" border="1"></td>
									<td style="width:100px;" border="1"><a class="title-back" style="border-top-right-radius: 10px;"></a></td>
								</tr>
								<!-- 灯能耗,时长统计图 start-->
								<tr>
									<td colspan="4" width=100% style="text-align:center">
	   								<div id="maintime" style="height:350px;width:1050px;"></div>
									 <script type="text/javascript">
								        require.config({
								            paths: {
								                echarts: 'static/js/echart/'
								            }
								        });
								        require(
								            [
								                'echarts',
								                'echarts/chart/bar' 
								            ],
								            function (ec) {
								                var myChart = ec.init(document.getElementById('maintime')); 
								
								                var option = {
								                    tooltip: {
								                        show: true
								                    },
		// 						                    legend: {
								                        data:["<%=equip_collect%>"],
		// 						                    	textStyle:{fontSize:15}
		// 						                    },
													
								                    xAxis : [
								                        {
								                            type : 'category',
								                            data : [document.getElementById('date1').value,document.getElementById('date2').value
								                            	,document.getElementById('date3').value,document.getElementById('date4').value,
								                            	document.getElementById('date5').value,document.getElementById('date6').value,
								                            	document.getElementById('date7').value]
								                        }
								                    ],
								                    yAxis : [
								                        {
								                            type : 'value'
								                        }
								                    ],
								                    grid: {  
								                    	x: 40,
								                    	y: 30,
								                    	x2: 30,
								                    	y2: 40,
								                   	},  
								                    series : [
								                        {
								                            "name":"<%=lamp_sumtime_collection%>",
								                            "type":"bar",
								                            "data":[
								                            	document.getElementById('1_1').value,
								                            	document.getElementById('2_2').value,
								                            	document.getElementById('3_3').value,
								                            	document.getElementById('4_4').value,
								                            	document.getElementById('5_5').value,
								                            	document.getElementById('6_6').value,
								                            	document.getElementById('7_7').value
								                            	]
								                        }
								                    ]
								                };
								               myChart.setOption(option); 
								            }
								        );
									 </script>
									</td>
								</tr>
								
								
							</table>
						</td></tr></table>
						</td>
					</tr>
				</table>
				</div>
				</form>
			</div>
		</div>
				<!-- /.page-content -->
		</div>
		</div>	
       
		<!-- /.main-content -->
	
	<!-- /.main-container -->

	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../system/index/foot.jsp"%>
	<script type="text/javascript">
		$(top.hangge());

		//检索
		function tosearch(type){
			top.jzts();
			$("#Form").submit();
		}
		</script>
</body>
</html>
