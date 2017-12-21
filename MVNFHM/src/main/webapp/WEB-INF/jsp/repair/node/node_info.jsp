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
<%@ include file="../../international.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">
<!-- jsp文件头和头部 -->
<%@ include file="../../system/index/top.jsp"%>
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

					<form action="repair/goNodeInfo.do" name="userForm" id="userForm" method="post">
						<input type="hidden" name="c_client_id" id="c_client_id" value="${pd.c_client_id }"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<!-- 所属网关 -->
								<td style="width:85px;text-align: right;padding-top: 13px;"><%=belong_gateway %>:</td>
								<td><input type="text" name="gateway_name" id="gateway_name"  value="${pd.gateway_name }" style="width:98%;" disabled="disabled"/></td>
							</tr>
							<tr>
								<!-- 节点地址 -->
								<td style="width:85px;text-align: right;padding-top: 13px;"><%=node_address %>:</td>
								<td><input type="email" name="node" id="node"  value="${pd.node }" style="width:98%;" disabled="disabled"/></td>
							</tr>
							<tr>
								<!-- 节点编号-->
								<td style="width:85px;text-align: right;padding-top: 13px;"><%=node_number %>:</td>
								<td><input type="number" name="client_code" id="client_code"  value="${pd.client_code }" style="width:98%;" disabled="disabled"/></td>
							</tr>
							<tr>
								<!-- 节点名称-->
								<td style="width:85px;text-align: right;padding-top: 13px;"><%=node_name %>:</td>
								<td><input type="email" name="client_name" id="client_name"  value="${pd.client_name }" style="width:98%;" disabled="disabled"/></td>
							</tr>
							<tr>
								<!-- 节点类型-->
								<td style="width:85px;text-align: right;padding-top: 13px;"><%=node_type %>:</td>
								<td><input type="text" name="client_type_name" id="client_type_name"value="${pd.client_type_name }" style="width:98%;" disabled="disabled"/></td>
							</tr>
							<tr>
								<!-- 位置-->
								<td style="width:85px;text-align: right;padding-top: 13px;"><%=location %>:</td>
								<td><input type="text" name="location" id="location"value="${pd.location }" style="width:98%;" disabled="disabled"/></td>
							</tr>
							<tr>
								<!-- 灯杆号-->
								<td style="width:85px;text-align: right;padding-top: 13px;"><%=pole_number %>:</td>
								<td><input type="text" name="lamp_pole_num" id="lamp_pole_num"value="${pd.lamp_pole_num }" style="width:98%;" disabled="disabled"/></td>
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
<%@ include file="../../system/index/foot.jsp"%>
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
