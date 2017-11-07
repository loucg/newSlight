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
<%@include file="../../international.jsp"%>  <!--国际化标签  -->
<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">

<!-- jsp文件头和头部 -->
<%@ include file="../../system/index/top.jsp"%>

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
							<form action="" name="Form" id="Form" method="post">
								<input type="hidden" id="id" name="id" value="${pd.id }"/>
								<div id="zhongxin">
								<table style="width:95%;" >
									<tr>
										<td style="text-align: center;padding-top: 10px;width:80px">
											<a onclick="viewLampDetail('${pd.id }')" style="cursor:pointer;"><%=lamp_config_page%></a>
										</td>
									</tr>
									<tr>
										<td style="text-align: center;padding-top: 10px;width:80px">
											<a onclick="viewSensorDetail('${pd.id }')" style="cursor:pointer;"><%=sensor_config_page%></a>
										</td>
									</tr>
								</table>
								</div>
								<div id="zhongxin2" class="center" style="display:none"><br/><img src="static/images/jzx.gif" /><br/><h4 class="lighter block green"></h4></div>
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
	<%@ include file="../../system/index/foot.jsp"%>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<!-- 上传控件 -->
	<script src="static/ace/js/ace/elements.fileinput.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<script type="text/javascript">
		$(top.hangge());
		/* 灯状态画面 */
		function viewLampDetail(id){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="<%=lamp_config_page %>";
			 diag.URL = '<%=basePath%>config/getLightConfigList.do?gateway_id='+id+'&itype=4'; 
			 diag.Width = 1760;
			 diag.Height = 620;
			 diag.CancelEvent = function(){ //关闭事件
				diag.close();
				top.Dialog.close();
			 };
			 diag.show();
		}
		/* 传感器状态画面 */
		function viewSensorDetail(id){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="<%=sensor_config_page %>";
			 diag.URL = '<%=basePath%>sensor/getSensorList.do?gateway_id='+id; 
			 diag.Width = 1260;
			 diag.Height = 620;
			 diag.CancelEvent = function(){ //关闭事件
				diag.close();
				top.Dialog.close();
			 };
			 diag.show();
		}
	</script>

</body>
</html>