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
<!-- jsp 国际化-->
<%@ include file="../international.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">
<!-- jsp文件头和头部 -->
<%@ include file="../system/index/top.jsp"%>
<link rel="stylesheet" href="static/ace/css/datepicker.css" />
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

					<form action="repair/goFaultInfo.do" name="Form" id="Form" method="post">
						<input type="hidden" name="id" id="id" value="${pd.id}"/>
<%-- 						<input type="hidden" name="c_client_id" id="c_client_id" value="${pd.c_client_id}"/> --%>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:85px;text-align: right;padding-top: 13px;" nowrap="nowrap"><%=fault_no %>:</td>
								<td><input style="width:98%;" type="text" name="register" id="register" value="${pd.fault_no}" disabled/></td>
<%-- 								<td>${pd.fault_no}</td> --%>
							</tr>
							<tr>
								<td style="width:85px;text-align: right;padding-top: 13px;" nowrap="nowrap"><%=equipment_type %>:</td>
								<td><input style="width:98%;" type="text" name="device_type" id="device_type" value="<c:if test="${pd.device_type == '1' }"><%=node%></c:if><c:if test="${pd.device_type == '2' }"><%=gateway%></c:if>" disabled/></td>
<%-- 								<td><c:if test="${pd.device_type == '1' }"><%=node%></c:if><c:if test="${pd.device_type == '2' }"><%=gateway%></c:if></td> --%>
							</tr>
							<tr>
								<td style="width:85px;text-align: right;padding-top: 13px;" nowrap="nowrap"><%=fault_Device_code %>:</td>
								<td><input style="width:98%;" type="text" name="device_type" id="device_type" value="${pd.code}" disabled/></td>
							</tr>
							<tr>
								<td style="width:85px;text-align: right;padding-top: 13px;"><%=equipment_name %>:</td>
								<td><input style="width:98%;" type="text" value="${pd.name}" disabled/></td>
							</tr>
							<tr>
								<td style="width:85px;text-align: right;padding-top: 13px;"><%=location%>:</td>
								<td><input style="width:98%;" type="text" value="${pd.location}" disabled/></td>
							</tr>
							<tr>
								<td style="width:85px;text-align: right;padding-top: 13px;"><%=pole_number %>:</td>
								<td><input style="width:98%;" type="text" value="${pd.polenumber}" disabled/></td>
							</tr>
							<tr>
								<td style="width:85px;text-align: right;padding-top: 13px;"><%=fault_type %>:</td>
								<td><c:if test="${pd.type == '1' }"><span class="label label-important arrowed-in"><%=lamp_open_circuit%></span></c:if><c:if test="${pd.type == '2' }"><span class="label label-success arrowed"><%=lamp_short%></span></c:if><c:if test="${pd.type == '3' }"><span class="label label-success arrowed"><%=abnormal_lamp%></span></c:if><c:if test="${pd.type == '4' }"><span class="label label-success arrowed"><%=gateway_anomaly%></span></c:if><c:if test="${pd.type == '5' }"><span class="label label-success arrowed"><%=circuit_breaker_abnormality%></span></c:if>
								</td>
							</tr>
							<tr>
								<td style="width:85px;text-align: right;padding-top: 13px;"><%=fault_time %>:</td>
								<td><input style="width:98%;" type="text" value="<fmt:formatDate type = "both" value = "${pd.startime}" />" disabled/></td>
							</tr>
							<tr>
								<td style="text-align: center;" colspan="10">
									<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();"><%=cancel%></a>
								</td>
							</tr>
						</table>
						</div>
					</form>

					</div>
					<!-- /.col -->
				</div>
				<!-- /.row -->
			</div>
			<!-- /.page-content -->
		</div>
	</div>
</div>
<!-- 页面底部js¨ -->
<%@ include file="../system/index/foot.jsp"%>
<!-- ace scripts -->
<script src="static/ace/js/ace/ace.js"></script>
<!-- ace scripts -->
<script src="static/ace/js/ace/ace.js"></script>
		<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
<!--提示框-->
<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<script type="text/javascript">
	$(top.hangge());

	//保存
	function save(){
		if($("#repairman").val()==""){
			$("#repairman").tips({
				side:3,
	            msg:'<%=please_choose_maintainer%>',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#repairman").focus();
			return false;
		}

		if($("#operate").val()==""){
			$("#operate").tips({
				side:3,
	            msg:'<%=please_enter_repair_operate%>',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#operate").focus();
			return false;
		}

		$("#Form").submit();
		$("#zhongxin").hide();
		$("#zhongxin2").show();
	}

	$(function() {
		//日期框
		$('.date-picker').datepicker({autoclose: true,todayHighlight: true});

		//下拉框
		if(!ace.vars['touch']) {
			$('.chosen-select').chosen({allow_single_deselect:true});
			$(window)
			.off('resize.chosen')
			.on('resize.chosen', function() {
				$('.chosen-select').each(function() {
					 var $this = $(this);
					 $this.next().css({'width': $this.parent().width()});
				});
			}).trigger('resize.chosen');
			$(document).on('settings.ace.chosen', function(e, event_name, event_val) {
				if(event_name != 'sidebar_collapsed') return;
				$('.chosen-select').each(function() {
					 var $this = $(this);
					 $this.next().css({'width': $this.parent().width()});
				});
			});
			$('#chosen-multiple-style .btn').on('click', function(e){
				var target = $(this).find('input[type=radio]');
				var which = parseInt(target.val());
				if(which == 2) $('#form-field-select-4').addClass('tag-input-style');
				 else $('#form-field-select-4').removeClass('tag-input-style');
			});
		}


		//复选框全选控制
		var active_class = 'active';
		$('#simple-table > thead > tr > th input[type=checkbox]').eq(0).on('click', function(){
			var th_checked = this.checked;//checkbox inside "TH" table header
			$(this).closest('table').find('tbody > tr').each(function(){
				var row = this;
				if(th_checked) $(row).addClass(active_class).find('input[type=checkbox]').eq(0).prop('checked', true);
				else $(row).removeClass(active_class).find('input[type=checkbox]').eq(0).prop('checked', false);
			});
		});
	});

	</script>
</body>
</html>
