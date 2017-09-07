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
<base href="<%=basePath%>">
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, user-scalable=yes">

<script src="static/echart/echarts.js"></script>

<!-- 下拉框 -->
<link rel="stylesheet" href="static/ace/css/chosen.css" />
<!-- jsp文件头和头部 -->
<%@ include file="../system/index/top.jsp"%>
<!-- 日期框 -->
<link rel="stylesheet" href="static/ace/css/datepicker.css" />
<style type="text/css">
		.div1{
		    margin:0 auto;
		    background-image:url(static/images/lightStatus.jpg);
		    background-size:100% 100%;
		}
</style>
</head>
<body class="no-skin">
	<!-- /section:basics/navbar.layout -->
	<div class="main-container" id="main-container">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">
				<div class="page-content">
					<div class="row">
						<div class="col-xs-12">
						<!-- 检索  -->
						<form action="status/strategy/getGroupList" method="post" name="Form" id="Form">
						<input type="hidden" id="excel" name="excel" value="0"/>
						<table style="margin-top:5px;">
							<tr>
							
								<td>
								<div class="nav-search">
								<label><%=start_time%>：</label>
								<input class="span10 date-picker" name="starttime" id="starttime"  value="${pd.starttime}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:100px; height:28px" placeholder="<%=start_time%>" />
								</div>
								</td>
								<td>
								<div class="nav-search" style="padding-left:12px;">
								<label><%=deadline%>：</label>
								<input class="span10 date-picker" name="endtime" name="endtime"  value="${pd.endtime}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:100px;height:28px" placeholder="<%=deadline%>" />
								</div>
								</td>
								<td style="background-color:#ffffff;">&nbsp;&nbsp;<%=search_type%>：</td>
								<td >
								 	<select class="chosen-select form-control" name="type" id="type" data-placeholder="<%=please_choose_device_type%>" style="height:30px;width: 160px;border-width:1px;border-color:'#fff';border-radius:4px">
										<option value="1" <c:if test="${pd.type==1}">selected</c:if>><%=day%></option>
										<option value="2" <c:if test="${pd.type==2}">selected</c:if>><%=month%></option>
								  	</select>
								</td>
								<c:if test="${QX.cha == 1 }"><td style="vertical-align:top;padding-left:2px;"><button class="btn btn-light btn-xs" onclick="search();"  title="<%=search2%>"><i id="nav-search-icon" class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i></button></td></c:if>
							</tr>
						</table>
						<!-- 检索  -->
						<c:choose>
							<c:when test="${not empty groupList}">
								<c:if test="${QX.cha == 1 }">
								<c:forEach items="${groupList}" var="table" varStatus="vvs">
									<table id="simple-table"  class="table table-striped table-bordered table-hove"  style="margin-top:5px;">
										<tbody>
											<th class="center" style="width:9%;"><%=function%>/<%=group_name%></th>
											<c:forEach items="${table}" var="item" varStatus="vs">
												<td class="center" style="width:9%;">${item.name}</td>											
											</c:forEach>
										</thead>
										<tbody>
											<th class="center"><%=light_rate%></th>
											<c:forEach items="${table}" var="item" varStatus="vs">
												<td class="center">${item.per }</td>
											</c:forEach>
										</tbody>
										<tbody>
											<th class="center"><%=total_power%>></th>
											<c:forEach items="${table}" var="item" varStatus="vs">
												<td class="center">${item.power }</td>
											</c:forEach>
										</tbody>
										<tbody>
											<th class="center"><%=control_strategy%></th>
											<c:forEach items="${table}" var="item" varStatus="vs">
												<td class="center">${item.strategy }</td>
											</c:forEach>
										</tbody>
									</table>
								</c:forEach>
								</c:if>
								
								<c:if test="${QX.cha == 0 }">
									<tr>
										<td colspan="100" class="center"><%=you_have_no_permission%></td>
									</tr>
								</c:if>
							</c:when>
							<c:otherwise>
								<tr class="main_info">
									<td colspan="100" class="center" ><%=no_relevant_data%></td>
								</tr>
							</c:otherwise>
						</c:choose>
						<c:if test="${QX.cha==1 }">
							<div id="strategy">
								<c:forEach items="${strategyList }" var="strategy" varStatus="vs">
									<h3 hidden="true">${strategy.name }</h3>
									<p hidden="true">${strategy.json}</p> 
									<div id="${vs.index}" title="${strategy.name }" style="height:400px;"></div>
								</c:forEach>
							</div>
						</c:if>
					</form>
					</div>
					<!-- /.col -->
				</div>
				<!-- /.row -->
			</div>
			<!-- /.page-content -->
		</div>
	</div>
	<!-- /.main-content -->

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
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	<script type="text/javascript">
		
		$(function(){
			//日期框
			
			top.hangge();
			$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
			
            var div = document.getElementById("strategy");
            var jsons = div.getElementsByTagName("p"); //p节点存储了json的值获取所有p
            var names = div.getElementsByTagName("h3");
            for(var i=0;i<names.length;i++){
            	var jsonObj = $.parseJSON(jsons[i].innerHTML);
            	var x_data = new Array();
            	var series_data = new Array();
            	for(var j=0;j<jsonObj.t_i.length;j++){
            		x_data[x_data.length] = jsonObj.t_i[j].timestamp;
            		series_data[series_data.length] = jsonObj.t_i[j].intensity;
            	} 
            	
               	var myChart = echarts.init(document.getElementById(i)); 
                   // 指定图表的配置项和数据
                var option = {
                    title: {
                        text: names[i].innerHTML
                    },
                    
                    tooltip: {},
                    xAxis: {
                        data: x_data
                    },
                    yAxis: {},
                    series: [{
                        name: names[i].innerHTML,
                        type: 'line',
                        data: series_data
                    }]
                };
                   
                myChart.setOption(option);          
            }
		});
	
		
		
    </script>
	
</body>
</html>
