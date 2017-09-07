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
				<table border="1" style="margin-left:5px; width:100%;height:100%" >
					<tr>
						<td  colspan="3"  width=60% height=300px>
							<table border="1" style='margin-left:5px;margin-right:5px'>
								<tr height="5px">
								</tr>
								<tr>
									<td width=100%>
	   								<div id="main" style="height:300px;width:950px"></div>
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
						                    legend: {
						                        data:["<%=equip_collect%>"],
						                    	textStyle:{fontSize:15}
						                    },
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
					    		<%=sequenceselect %>
									<select class="chosen-select form-control"  name="TYPE" 
										id="id" data-placeholder="请选择" style="vertical-align:top;width: 120px;" onchange="switchAdjustItems(this.value)">
										<option value="0" <c:if test="${pd.TYPE==0}">selected</c:if>><%=equip_7days %></option>
										<option value="1" <c:if test="${pd.TYPE==1}">selected</c:if>><%=equip_7week %></option>
										<option value="2" <c:if test="${pd.TYPE==2}">selected</c:if>><%=equip_7month %></option>
									</select>
									</td>
									</tr>
						</table>
					</td>
					<td rowspan=2 width=40% align=center>
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
										  document.write("<font style='font-weight:bold;font-size:15px';margin-left:20px;>"+"<%=equip_currentdate%>："+y+"<%=equip_year%>"+(today.getMonth()+1)+"<%=equip_month%>"+d+"<%=equip_day_week0%></font>");
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
						</td>
						</tr>
						<tr>
							<td valign="bottom" style="margin-left:5px; width:62%; height=300px" >
								<table border="1" style="margin-left:5px; width:99.6%" >
								<tr height="10px">
								</tr>
								<tr>
								<td width=33%>
									<table border="0">
									<tr>
									<td></td>
									</tr>
									<tr>
										<td align="center" bgcolor=#90EE90>
										<font size=3px><%=equip_gateway_onlinenum %></font>
										</td>
									</tr>
										<tr height=10px></tr>
										<tr>
											<c:forEach items="${equipment_analyse}" var="equipment" varStatus="vs">
											<td><div class="circle">${equipment.onlineGateWayCount} <%=equip_unit1 %>	</div></td>
											<td width=10%></td>
											<td width=75%>
											<table border="1" class="table table-striped table-bordered table-hover">
												<tr>
												<td align="center" width=75% ><font style="font-weight:bold;" size=2px><%=equip_gateway_num %></font></td>
												<td  align="center" width=25% ><font style="font-weight:bold;" size=2px><%=equip_gateway_onlinerate %></font></td>
												</tr>
												<tr>
												<td  align="center"><font style="font-weight:bold;" color="#90EE90" size=5px>${equipment.gatewayCount}</font></td>
												<td  align="center"><font style="font-weight:bold;" color="#90EE90" size=5px>${equipment.gatewyOnlineRate}</font></td>
												</tr>
												
											</table>
											<td width=5%></td>
											
											</c:forEach>
										<td width=5%></td>
										</tr>
										
										
									</table>
								</td>
								
								<td width=30%>
									<table border="0">
									<tr>
									<td></td>
									</tr>
										<tr>
										<td align="center"  bgcolor=#9393FF>
										
										<font size=3px ><%=equip_light_onlinenum %></font>
										
										</td>
										<td height=10px></td>
										</tr>
										<tr height=10px></tr>
										<tr>
										<c:forEach items="${equipmentLight}" var="equipmentlight" varStatus="vs">
										<td><div class="circle3">${equipmentlight.onlineLightCount} 
										</div></td>
										<td width=10%></td>
										<td width=85%>
										<table border="1" class="table table-striped table-bordered table-hover">
											<tr>
											<td  width=60%  align="center"><font style="font-weight:bold;" size=2px><%=equip_light_num %></font></td>
											<td  width=40%  align="center"><font style="font-weight:bold;" size=2px><%=equip_light_onlinrate %></font></td>
											</tr>
											<tr>
											<td  align="center"><font style="font-weight:bold;" color="#9393FF" size=5px>${equipmentlight.lightCount}</font></td>
											<td   align="center"><font style="font-weight:bold;" color="#9393FF" size=5px>${equipmentlight.onlineLightRate}</font></td>
											</tr>
										
										</table>
										</td>
										</c:forEach>
										
										<td width=5%></td>
										</tr>
									</table>
								</td>
								<td width=30%>
									<table border="0">
									<tr>
									<td></td>
									</tr>
										<tr>
										<td align="center"   bgcolor=#F08080>
										
										<font size=3px><%=equip_faultnum %></font>
										
										</td>
										<td height=10px></td>
										</tr>
										<tr height=10px></tr>
										<tr>
										<c:forEach items="${equipment_fault}" var="equipmentfault" varStatus="vs">
										<td><div class="circle2">${equipmentfault.faultnum}<%=equip_unit2 %>	</div></td>
										<td width=10%></td>
										<td width=75%>
										<table border="1" class="table table-striped table-bordered table-hover">
										<tr>
											<td  width=50% align="center"><font style="font-weight:bold;" size=2px><%=equip_num %></font></td>
											<td width=50% align="center" ><font style="font-weight:bold;" size=2px><%=equip_fault_rate %></font></td>
											</tr>
											<tr>
											<td align="center" ><font style="font-weight:bold;" color="#F08080" size=5px>${equipmentfault.equipmentcnt}</font></td>
											<td align="center" ><font style="font-weight:bold;" color="#F08080" size=5px>${equipmentfault.faultRate}</font></td>
											</tr>
										
										</table>
										</td>
										</c:forEach>
										<td width=5%></td>
									</tr>
									</table>
								</td>
								</tr>
								
							</table>
						</td>
							
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