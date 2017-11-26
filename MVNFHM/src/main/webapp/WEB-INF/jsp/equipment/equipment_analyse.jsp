<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%

	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
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
	font-size:20px
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
/*  	  border-top-left-radius: 10px; */
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


<!-- jsp文件头和头部 -->
<%@ include file="../system/index/top.jsp"%>
<!-- jsp国际化文件 -->
<%@ include file="../international.jsp"%>
<script src="static/js/echart/echarts.js"></script>
</head>
<body class="no-skin" >

	<!-- /section:basics/navbar.layout -->
	<div class="main-container" id="main-container">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">
				<div class="page-content">
				<form action="equimentanaylise/retrieve.do" method="post" name="Form" id="Form">
				<table style="margin:5px; width:100%;height:100%;" border="0">
					<tr>
						<td width=60% height=300px>
						<table class="chart-table" >
						<tr><td colspan="4" style="padding:20px 10px 40px 10px" >
							<table style="width: 800px;height: 300px;">
							<tr>
								<td style="width:300px;"><a class="title-back" style="border-top-left-radius: 10px;"><div class="dot"><b style="font-size:14px;"><%=equip_collect%></b></div></a></td>
								<td class="title-bar" style="width:100%;text-align:right;" border="1"><%=sequenceselect %></td>
								<td class="title-bar" style="width:100px;" border="1">
									<select class="chosen-select form-control" name="TYPE" 
										id="id" data-placeholder="请选择" style="vertical-align:top;font-size:12px;" onchange="switchAdjustItems(this.value)">
										<option value="0" <c:if test="${pd.TYPE==0}">selected</c:if>><%=equip_7days %></option>
										<option value="1" <c:if test="${pd.TYPE==1}">selected</c:if>><%=equip_7week %></option>
										<option value="2" <c:if test="${pd.TYPE==2}">selected</c:if>><%=equip_7month %></option>
									</select>
								</td>
								<td style="width:100px;" border="1"><a class="title-back" style="border-top-right-radius: 10px;"></a></td>
							</tr>
								<!-- 设备损坏统计图 start-->
								<tr>
									<td colspan="4" width=100% style="text-align:center">
	   								<div id="main" style="height:350px;width:1050px;"></div>
						 			 <c:forEach items="${deviceFaultList}" var="device" varStatus="vs">
									 	<input type="hidden" id='${device.seq}'  value='${device.cnt}'>
									 	<input type="hidden" id='${device.dateflag}'  value='${device.dayname}'>
									 </c:forEach>
    	
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
		<%-- 						                        data:["<%=equip_collect%>"], --%>
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
								                    	x: 30,
								                    	y: 30,
								                    	x2: 30,
								                    	y2: 40,
								                   	},  
								                    series : [
								                        {
								                            "name":"<%=equip_collect%>",
								                            "type":"bar",
								                            "data":[document.getElementById('1').value, document.getElementById('2').value, document.getElementById('3').value, document.getElementById('4').value, document.getElementById('5').value, document.getElementById('6').value,document.getElementById('7').value]
								                        }
								                    ]
								                };
								               myChart.setOption(option); 
								            }
								        );
									 </script>
									</td>
								</tr><!-- 设备损坏统计图 end-->
								<!-- 网关在线个数，设备编码，设备故障数 start -->
								<tr>
									<td valign="bottom" colspan="4">
										<div style="width:100%;color:white;">					
										<!-- 网关在线个数 -->
										<div class="divtable" style="width:320px;height:100%;border-radius:10px;background-color:#3CB371;text-align:center;">
											<c:forEach items="${equipment_analyse}" var="equipment" varStatus="vs">		
											<div class="divtd" style="float:left;margin-top:3px;">
												<div class="dot"><b style="font-size:14px;"><%=equip_gateway_onlinenum%></b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
											</div>
											<div class="divtd">
												<div class="divtd circle" style="background:url(static/images/r-halfgreen.png);background-size:100% 100%;margin-top:15px">
													<b style="font-size:20px;color:white">${equipment.onlineGateWayCount} <%=equip_unit1 %></b>
												</div>
												<div class="divtd" style="float:right;margin-left:50px">
													<div class="divtd" style="text-align:center;">
														<div class="divtd" style="font-size:12px;color:white"><%=equip_gateway_num %></div><br>
														<div class="divtd"><b style="font-size:20px;color:white">${equipment.gatewayCount}</b></div>
													</div>
													<div style="text-align:center;margin-top:10px">
														<div class="divtd" style="font-size:12px;color:white"><%=equip_gateway_onlinerate %></div><br>
														<div class="divtd" style="margin-bottom:0px"><b style="font-size:20px;color:white;">${equipment.gatewyOnlineRate}</b></div>
													</div>
												</div>
											</div>
											</c:forEach>
										</div>
										<!-- 设备编码 -->
										<div class="divtable" style="width:320px;height:100%;border-radius:10px;background-color:#4169E1;text-align:center;">
											<c:forEach items="${equipmentLight}" var="equipmentlight" varStatus="vs">		
											<div class="divtd" style="float:left;margin-top:3px;">
												<div class="dot"><b style="font-size:14px;"><%=equip_light_onlinenum %></b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
											</div>
											<div class="divtd">
												<div class="divtd circle" style="background:url(static/images/r-halfblue.png);background-size:100% 100%;margin-top:15px">
													<b style="font-size:20px;color:white">${equipmentlight.onlineLightCount} <%=equip_unit1 %></b>
												</div>
												<div class="divtd" style="float:right;margin-left:50px">
													<div class="divtd" style="text-align:center;">
														<div class="divtd" style="font-size:12px;color:white"><%=equip_light_num %></div><br>
														<div class="divtd"><b style="font-size:20px;color:white">${equipmentlight.lightCount}</b></div>
													</div>
													<div style="text-align:center;margin-top:10px">
														<div class="divtd" style="font-size:12px;color:white"><%=equip_light_onlinrate %></div><br>
														<div class="divtd" style="margin-bottom:0px"><b style="font-size:20px;color:white;">${equipmentlight.onlineLightRate}</b></div>
													</div>
												</div>
											</div>
											</c:forEach>
										</div>
										
										<!-- 设备故障数 -->
										<div class="divtable" style="width:320px;border-radius:10px;background-color:#EE6363;text-align:center;">
											<c:forEach items="${equipment_fault}" var="equipmentfault" varStatus="vs">		
											<div class="divtd" style="float:left;margin-top:3px;">
												<div class="dot"><b style="font-size:14px;"><%=equip_faultnum %></b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
											</div>
											<div class="divtd">
												<div class="divtd circle" style="background:url(static/images/r-halfred.png);background-size:100% 100%;margin-top:15px">
													<b style="font-size:20px;color:white">${equipmentfault.faultnum} <%=equip_unit1 %></b>
												</div>
												<div class="divtd" style="float:right;margin-left:50px">
													<div class="divtd" style="text-align:center;">
														<div class="divtd" style="font-size:12px;color:white"><%=equip_num %></div><br>
														<div class="divtd"><b style="font-size:20px;color:white">${equipmentfault.equipmentcnt}</b></div>
													</div>
													<div style="text-align:center;margin-top:10px">
														<div class="divtd" style="font-size:12px;color:white"><%=equip_fault_rate %></div><br>
														<div class="divtd" style="margin-bottom:0px"><b style="font-size:20px;color:white;">${equipmentfault.faultRate}</b></div>
													</div>
												</div>
											</div>
											</c:forEach>
										</div>

										</div>
									</td>
									
								</tr>								
								<!-- 网关在线个数，设备编码，设备故障数 end -->
							</table>
						</td></tr></table>
						</td>
						<!-- 当前日期 start-->
						<td width="100%" align=center>
							<script>
								  //判断当前年份是否是闰年(闰年2月份有29天，平年2月份只有28天)
								  function isLeap(year) {
								  return year % 4 == 0 ? (year % 100 != 0 ? 1 : (year % 400 == 0 ? 1 : 0)) : 0;
								  }
								  var i, k,
								  today = new Date(),                 //获取当前日期
								  y = today.getFullYear(),              //获取日期中的年份
								  m = today.getMonth(),                //获取日期中的月份(需要注意的是：月份是从0开始计算，获取的值比正常月份的值少1)
								  d = today.getDate(),                //获取日期中的日(方便在建立日期表格时高亮显示当天)
								  firstday = new Date(y, m, 1),            //获取当月的第一天
								  dayOfWeek = firstday.getDay(),           //判断第一天是星期几(返回[0-6]中的一个，0代表星期天，1代表星期一，以此类推)
								  days_per_month = new Array(31, 28 + isLeap(y), 31, 30, 31, 30, 31, 31, 30, 31, 30, 31),         //创建月份数组
								  str_nums = Math.ceil((dayOfWeek + days_per_month[m]) / 7);                        //确定日期表格所需的行数
								  document.write("<font style='font-weight:bold;font-size:15px';margin-left:20px;>"+"<%=equip_currentdate%>："+y+"<%=equip_year%>"+(today.getMonth()+1)+"<%=equip_month%>"+d+"</font>");
								  document.write("<table border=1 width=80% height=70% style='margin-left:20px;'><tr height=30px ><th class='calander_Head'><%=equip_day_week0%></th><th class='calander_Head'><%=equip_day_week1%></th><th class='calander_Head'><%=equip_day_week2%></th><th class='calander_Head'><%=equip_day_week3%></th><th class='calander_Head' ><%=equip_day_week4%></th><th class='calander_Head'><%=equip_day_week5%></th><th class='calander_Head'><%=equip_day_week6%></th></tr>"); //打印表格第一行(显示星期)
								  for (i = 0; i < str_nums; i += 1) {         //二维数组创建日期表格
								  document.write('<tr height=30px>');
								  for (k = 0; k < 7; k++) {
								   var idx = 7 * i + k;                //为每个表格创建索引,从0开始
								   var date = idx - dayOfWeek + 1;          //将当月的1号与星期进行匹配
								   (date <= 0 || date > days_per_month[m]) ? date = ' ': date = idx - dayOfWeek + 1;  //索引小于等于0或者大于月份最大值就用空表格代替
								   date == d ? document.write('<td class="today">' + date + '</td>') : document.write('<td class="calander_Body">' + date + '</td>');  //高亮显示当天
								  }
								  document.write('</tr>');
								  }
								  document.write('</table>');
							</script>
						</td><!-- 当前日期 end-->
					</tr>
				</table>
				</form>
			</div>
		</div>
				<!-- /.page-content -->
		</div>
		</div>
		<script>
	//设定显示项目
		function switchAdjustItems(type){
			$("#Form").submit();
			
		}
		</script>
		
       
		<!-- /.main-content -->
	
	<!-- /.main-container -->

	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../system/index/foot.jsp"%>
</body>
</html>