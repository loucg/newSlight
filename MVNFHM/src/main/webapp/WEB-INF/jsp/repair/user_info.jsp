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

					<form action="repair/goMaintenanceUserInfo.do" name="userForm" id="userForm" method="post">
						<input type="hidden" name="USER_ID" id="user_id" value="${pd.USER_ID }"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<!-- 姓名 -->
								<td style="width:85px;text-align: right;padding-top: 13px;" nowrap="nowrap"><%=person_name %>:</td>
								<td><input type="text" name="username" id="username"  value="${pd.username }" style="width:98%;" disabled="disabled"/></td>
							</tr>
							<tr>
								<!-- 邮箱 -->
								<td style="width:85px;text-align: right;padding-top: 13px;" nowrap="nowrap">邮箱:</td>
								<td><input type="email" name="EMAIL" id="EMAIL"  value="${pd.EMAIL }" style="width:98%;" disabled="disabled"/></td>
							</tr>
							<tr>
								<!-- 手机 -->
								<td style="width:85px;text-align: right;padding-top: 13px;" nowrap="nowrap">手机号:</td>
								<td><input type="number" name="PHONE" id="PHONE"  value="${pd.PHONE }" style="width:98%;" disabled="disabled"/></td>
							</tr>
							<tr>
								<!-- 职务 -->
								<td style="width:85px;text-align: right;padding-top: 13px;" nowrap="nowrap">职务:</td>
								<td><input type="email" name="POSITION" id="POSITION"  value="${pd.POSITION }" style="width:98%;" disabled="disabled"/></td>
							</tr>
							<tr>
								<!-- 所在公司 -->
								<td style="width:85px;text-align: right;padding-top: 13px;" nowrap="nowrap">所在公司:</td>
								<td><input type="text" name="companyname" id="companyname"value="${pd.companyname }" style="width:98%;" disabled="disabled"/></td>
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
