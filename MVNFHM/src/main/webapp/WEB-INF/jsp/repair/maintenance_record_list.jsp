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
<!-- jsp 国际化-->
<%@ include file="../international.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">
<!-- 下拉框 -->
<link rel="stylesheet" href="static/ace/css/chosen.css" />
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

						<!-- 检索  -->
						<form action="repair/listMaintenanceRecord.do" method="post" name="Form" id="Form">
						<table style="margin-top:5px;">
							<tr>
								<td>
									<div class="nav-search" style="margin-left:8px;">
										<label><%=fault_no %>:</label>
										<input class="nav-search-input" autocomplete="off" id="fault_no" type="text" name="fault_no" value="${pd.fault_no}" placeholder="<%=please_enter_fault_no%>" />
									</div>
								</td>
								<td>&nbsp;&nbsp;<%=equipment_type %>:</td>
								<td style="vertical-align:top;padding-left:2px;"> 
								 	<select class="chosen-select form-control" name="device_type" id="device_type" data-placeholder="<%=please_select_device_type %>" style="vertical-align:top;width: 130px;height:30px">
										<option value=""></option>
										<option value="1" <c:if test="${pd.device_type == 1 }">selected</c:if> ><%=node %></option>
										<option value="2" <c:if test="${pd.device_type == 2 }">selected</c:if> ><%=gateway %></option>
									</select>
								</td>
								<td style="padding-left:18px;padding-bottom:4px;">
									<label><%=repair_time%>:&nbsp;&nbsp;</label>
									<input class="span10 date-picker" autocomplete="off" name="Start" id="Start" type="text" value="${pd.Start}" data-date-format="yyyy-mm-dd" style="width:110px;height:28px;" placeholder="<%=please_choose_start_time%>" title="<%=please_choose_start_time%>"/>
								</td>
								<td style="padding-left:0px;padding-bottom:4px;">
									<label><span style="padding-left:8px;padding-right:8px;">~</span></label>
									<input class="span10 date-picker" autocomplete="off" name="End" name="End" type="text" value="${pd.End}" data-date-format="yyyy-mm-dd" style="width:110px;height:28px;" placeholder="<%=please_choose_end_time%>" title="<%=please_choose_end_time%>"/>
								</td>
								<td>
									<div class="nav-search" style="margin-left:8px;">
									    <label><%=maintenance_man%>:</label>
										<input class="nav-search-input" autocomplete="off" id="maintainer" type="text" name="maintainer" value="${pd.maintainer}" placeholder="<%=please_enter_maintainer%>" />
									</div>
								</td>
								 <td>
									<div class="nav-search" style="margin-left:8px;">
									    <label><%=registrant%>:</label>
										<input class="nav-search-input" autocomplete="off" id="registrant" type="text" name="registrant" value="${pd.registrant}" placeholder="<%=please_enter_registrant%>" />
									</div>
								</td>
								<td style="text-align:right;padding-left:8px;padding-bottom:4px"><button class="btn btn-mini btn-light" onclick="search();"  title="<%=search1%>"><i id="nav-search-icon" class="ace-icon fa fa-search bigger-110 nav-search-icon white"></i><%=search1%></button></td>
							</tr>
						</table>
						<!-- 检索  -->

						<table id="simple-table" class="table table-striped table-bordered table-hover"  style="margin-top:5px;">
							<thead>
								<tr>
									<th class="center" style="width: 50px;" nowrap="nowrap"><%=fault_no%></th>
									<th class="center" nowrap="nowrap"><%=equipment_type%></th>
									<th class="center" nowrap="nowrap"><%=repair_time%></th>
									<th class="center" nowrap="nowrap"><%=repair_operate%></th>
									<th class="center" nowrap="nowrap"><%=maintenance_man%></th>
									<th class="center" nowrap="nowrap"><%=registrant%></th>
								</tr>
							</thead>

							<tbody>

							<!-- 开始循环 -->
							<c:choose>
								<c:when test="${not empty maintenanceList}">
								 	<c:if test="${QX.cha == 1 }">
 									<c:forEach items="${maintenanceList}" var="var" varStatus="vs">
										<tr>
											<!-- 故障编号 -->
											<td class="center"><a onclick="viewFaultInfo('${var.fault_id}','${var.device_type}')" style="cursor:pointer;">${var.fault_no}</a></td>
											<!-- 设备类型 -->
											<td class="center"><c:if test="${var.device_type == '1' }"><%=node%></c:if><c:if test="${var.device_type == '2' }"><%=gateway%></c:if></td>
											<!-- 修复时间 -->
											<td class="center">${var.tdate}</td>
											<!-- 修复操作 -->
											<td class="center">${var.operate}</td>
											<!-- 修复人员 -->
											<td class="center"><a onclick="viewUserInfo('${var.repairman}','<%=maintenance_man %>')" style="cursor:pointer;">${var.repairman_name}</a></td>
											<!-- 登记人员 -->
											<td class="center"><a onclick="viewUserInfo('${var.register}','<%=registrant %>')" style="cursor:pointer;">${var.register_name}</a></td>
										</tr>
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
							</tbody>
						</table>
					<div class="page-header position-relative">
					<table style="width:100%;">
						<tr>
							<td style="vertical-align:top;"><div class="pagination" style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div></td>
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
	<!-- /.main-content -->

	<!-- 返回顶部 -->
	<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
		<i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
	</a>

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
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<script type="text/javascript">
		$(top.hangge());

		//检索
		function search(){
			top.jzts();
			$("#Form").submit();
		}
		
		//显示故障信息
		function viewFaultInfo(fault_id, device_type){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ='<%=fault_detail%>';
			 diag.URL = '<%=basePath%>repair/goFaultInfo?id='+fault_id+'&device_type='+device_type;
			 diag.Width = 650;
			 diag.Height = 380;
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 if('${page.currentPage}' == '0'){
						 top.jzts();
						 setTimeout("self.location=self.location",100);
					 }else{
						 nextPage('${page.currentPage}');
					 }
				}
				diag.close();
			 };
			 diag.show();
		}

		//显示维修人员，登记人员信息
		function viewUserInfo(user_id, atitle){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title = atitle;
			 diag.URL = '<%=basePath%>repair/goUserInfo?user_id='+user_id;
			 diag.Width = 650;
			 diag.Height = 300;
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 if('${page.currentPage}' == '0'){
						 top.jzts();
						 setTimeout("self.location=self.location",100);
					 }else{
						 nextPage('${page.currentPage}');
					 }
				}
				diag.close();
			 };
			 diag.show();
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
