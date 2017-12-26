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

					<form action="repair/${msg}" name="Form" id="Form" method="post">
						<input type="hidden" name="id" id="id" value="${pd.id}"/>
<%-- 						<input type="hidden" name="c_client_id" id="c_client_id" value="${pd.c_client_id}"/> --%>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:79px;text-align: right;padding-top: 13px;" nowrap="nowrap"><%=fault_no %>:</td>
								<td><input style="width:98%;" type="text" name="register" id="register" value="${pd.fault_no}" disabled/></td>
							</tr>
							<tr>
								<td style="width:79px;text-align: right;padding-top: 13px;" nowrap="nowrap"><%=fault_device_type %>:</td>
								<td><input style="width:98%;" type="text" name="devicetype" id="devicetype" value="<%=node %>" disabled/></td>
							</tr>
							<tr>
								<td style="width:79px;text-align: right;padding-top: 13px;" nowrap="nowrap"><%=registrant %>:</td>
								<td><input style="width:98%;" type="text" value="${pd.username}" disabled/></td>
							</tr>
							<tr>
								<td style="width:79px;text-align: right;padding-top: 13px;" nowrap="nowrap"><span style="color:red;">*</span><%=maintenance_man%>:</td>
								<td>
									<select class="chosen-select form-control" name="repairman" id="repairman" title="<%=maintenance_man %>" style="vertical-align:top;width:98%;" 
										onchange="switchAdjustItems(this.value)">
										<option value=""><%=please_choose_maintainer %></option>
										<c:forEach items="${maintainerList}" var="maintainer">
											<option value="${maintainer.b_user_id }" <c:if test="${maintainer.b_user_id == pd.repairman }">selected</c:if> >${maintainer.username }</option>
										</c:forEach>
									</select>
								</td>
							</tr>
							<tr>
								<td style="width:79px;text-align: right;padding-top: 13px;" nowrap="nowrap"><span style="color:red;">*</span><%=repair_operate %>:</td>
								<td><textarea style="width:98%;height:100px;" type="text" name="operate" id="operate" maxlength="255" title="<%=repair_operate%>" placeholder="<%=please_enter_repair_operate%>">${pd.operate}</textarea></td>
							</tr>
<!-- 							<tr> -->
<%-- 								<td style="width:79px;text-align: right;padding-top: 13px;"><%=repair_result%>:</td> --%>
<!-- 								<td> -->
<%-- 									<select class="chosen-select form-control" name="result" id="result" data-placeholder="<%=please_choose_repair_result%>" style="float:left;padding-left: 12px;width:95%;"> --%>
<%-- 										<option value="1" <c:if test="${pd.result==1}">selected</c:if>><%=wait_repair%></option> --%>
<%-- 										<option value="2" <c:if test="${pd.result==2}">selected</c:if>><%=has_repair%></option> --%>
<%-- 										<option value="3" <c:if test="${pd.result==3}">selected</c:if>><%=destroy%></option> --%>
<%-- 										<option value="3" <c:if test="${pd.result==4}">selected</c:if>><%=repair_self%></option> --%>
<!-- 								  	</select> -->
<!-- 								 </td> -->
<!-- 							</tr> -->
<!-- 							<tr> -->
<%-- 								<td style="width:79px;text-align: right;padding-top: 13px;"><%=repair_instructions%>:</td> --%>
<%-- 								<td><input style="width:95%;" type="text" name="explain" id="explain" value="${pd.explain}" maxlength="500" placeholder="<%=please_enter_repire_explain%>" title="<%=repair_instructions%>"/></td> --%>
<!-- 							</tr> -->
							<tr>
								<td style="text-align: center;" colspan="10">
									<a class="btn btn-mini btn-primary" onclick="save();"><%=save%></a>
									<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();"><%=cancel%></a>
								</td>
							</tr>
						</table>
						</div>
						<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green"><%=committing%>...</h4></div>
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
