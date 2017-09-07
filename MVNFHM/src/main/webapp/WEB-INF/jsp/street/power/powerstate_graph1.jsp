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
<%@ include file="../../system/index/top.jsp"%>
<!-- jsp国际化文件 -->
<%@ include file="../../international.jsp"%>
<!-- 百度echarts -->
<script src="plugins/echarts/echarts.min.js"></script>
</head>
<body class="no-skin">

	<!-- /section:basics/navbar.layout -->
	<div class="main-container" id="main-container">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">
				<div class="page-content">
					<div class="hr hr-18 dotted hr-double"></div>
					<div class="row">
						<div class="col-xs-12">

							
							
							<div id="main" style="width: 600px;height:300px;"></div>
							<script type="text/javascript">
						      // 基于准备好的dom，初始化echarts实例
						      var myChart = echarts.init(document.getElementById('main'));
						
						        
						        
						     // 指定图表的配置项和数据
						    /*  var xxx = ["衬衫","羊毛衫","雪纺衫","裤子","高跟鞋","袜子"];
						     var yyy = [5, 20, 36, 10, 10, 20]; */
						     
						     
						     
						         var option = {
						            title: {
						                text: 'ECharts 入门示例'
						            },
						            tooltip: {},
						            legend: {
						                data:['能耗']
						            },
						            xAxis: {
						                data: [${pd.xz}]
						                
						            },
						            yAxis: {},
						            series: [{
						                name: '能耗',
						                type: 'bar',
						                data: [${pd.yz}]
						            }]
						        }; 

						        // 使用刚指定的配置项和数据显示图表。
						        myChart.setOption(option);
						        
						    </script>
							
						</div>
						<!-- /.col -->
					</div>
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
	<%@ include file="../../system/index/foot.jsp"%>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<!-- inline scripts related to this page -->
	<script type="text/javascript">
		$(top.hangge());
	</script>
<script type="text/javascript" src="static/ace/js/jquery.js"></script>
</body>
</html>