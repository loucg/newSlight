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
<!-- 下拉框 -->
<link rel="stylesheet" href="static/ace/css/chosen.css" />
<!-- jsp文件头和头部 -->
<%@ include file="../system/index/top.jsp"%>
<style type="text/css">

        .mytable{text-align: center; margin: 0 auto;width: 80%;margin-top: 160px;font-size: 20pt;}
        th{color:white; text-align: center;border:solid 2px;border-color:black;}
        td{padding-left: 5px;padding-right: 5px;border:solid 2px;}

		<%--
		div{
		    margin:0 auto;
		    background-image:url(static/images/lightStatus.jpg);
		    background-size:100% 100%;
		}  
        .mytable{text-align: center; margin: 0 auto;width: 80%;margin-top: 160px;font-size: 20pt;}
        th{color:#BDB76B; text-align: center;border:solid 2px;border-color:black;}
        td{color:#FAFAD2;padding-left: 5px;padding-right: 5px;border:solid 2px;border-color:black;}
		--%>
		
</style>
</head>
<%-- 
<body class="no-skin" style="width: 100%; height: 650px;">
--%>
<body class="no-skin" style="width: 100%; height: 100%;">
<div style="width: 100%; height: 100%;">
	<div class="main-container" id="main-container">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">
				<div class="page-content">
					<div class="row">
        <%--
         <table class="mytable" style="background-color: #ADD8E6;">
         --%>
        <table class="mytable">

                <tr>
                <th colspan="4" style="background-color:#438eb9"><%=group_strategy%></th>
                <th colspan="4" style="background-color:#438eb9"><%=status_list%></th>
                <%--
                <th colspan="4"><%=group_strategy%></th>
                <th colspan="4"><%=status_list%></th>
                 --%>
                </tr>
                <tr>
                    <td><%=group_number%></td>
                    <td><a onclick="openFrame(336, '<%=group_strategy%>', 'status/strategy/getGroupList')">${groupAndStrategy.group_number }</a></td>
                    <td><%=strategy_number%></td>
                    <td><a onclick="openFrame(336, '<%=group_strategy%>', 'status/strategy/getGroupList')">${groupAndStrategy.strategy_number}</a></td>
                    <td><%=gatewany_number%></td>
                    <td><a onclick="openFrame(337, '<%=gateway_status%>', 'state/street/listGateways.do')">${normalGateway.gnormal }/${totalGateway.gtotal }</a></td>
                    <td><%=road_light_number%></td>
                    <td><a onclick="openFrame(338, '<%=road_light_status%>', 'state/lamp/listLamps.do')">${normalClient.cnormal }/${totalClient.ctotal }</a></td>
                </tr>
                <tr style="height: 40px">
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <th colspan="4" style="background-color:#438eb9"><%=fault_list%></th>
                    <th colspan="4" style="background-color: #438eb9"><%=energy_status%></th>
                <%--
                    <th colspan="4"><%=fault_list%></th>
                    <th colspan="4"><%=energy_status%></th>
                 --%>
                </tr>
                <tr>
                    <td><%=gateway%></td>
                    <td><a onclick="openFrame(339, '<%=gateway_or_circuit_breaker_exception%>', 'fault/street/listGateways.do')")>${gatewayFault.fgateway }</a></td>
                    <td><%=road_light%></td>
                    <td><a onclick="openFrame(340, '<%=road_light_exception%>', 'fault/street/listLamps.do')">${clientFault.fclient }</a></td>
                    <td><%=total_power%></td>
                    <td><a onclick="openFrame(342, '<%=energy_status%>', 'power/street/graphPowers.do')"><c:if test="${empty todayPower.power}">0</c:if><c:if test="${not empty todayPower.power }">${todayPower.power }</c:if>KW</a></td>
                    <td><%=avg_power_factor%></td>
                    <td>——</td>
                </tr>
                <tr>
                    <td><%=voltage_exception%></td>
                    <td><a onclick="openFrame(341, '<%=voltage_exception%>', 'fault/street/listVos.do')">${pressureFault}</a></td>
                    <td><%=circuit_breaker%></td>
                    <td><a onclick="openFrame(339, '<%=gateway_or_circuit_breaker_exception%>', 'fault/street/listGateways.do')">${cutoffFault.fgateway }</a></td>
                    <td><%=light_rate%></td>
                    <td>——</td>
                    <td>——</td>
                    <td></td>
                </tr>

        </table>
			</div>
				<!-- /.row -->
			</div>
			<!-- /.page-content -->
		</div>
	</div>
	<!-- /.main-content -->

	</div>
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
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<script type="text/javascript">
		$(top.hangge());
		function openFrame(id, name, url){
			top.mainFrame.tabAddHandler(id,name,url);
		}
	</script>

</body>
</html>
