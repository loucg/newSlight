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
<%@ include file="../../international.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">
<!-- 下拉框 -->
<link rel="stylesheet" href="static/ace/css/chosen.css" />
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

						<!-- 检索  -->
						<form action="repair/gateway" method="post" name="Form" id="Form">
						<table style="margin-top:5px;">
							<tr>
								 <td>
									<div class="nav-search" style="margin-left:8px;">
									    <label><%=gateway_name%> ：</label>
										<input class="nav-search-input" autocomplete="off" id="nav-search-input" type="text" name="name" value="${pd.name}" placeholder="<%=please_enter_gateway_name%>" /> 
									</div>
								</td>
								<td>
									<div class="nav-search" style="margin-left:14px;">
									    <label><%=gateway_number%>：</label>
										<input class="nav-search-input" autocomplete="off" id="nav-search-input" type="text" name="code" value="${pd.code}" placeholder="<%=please_enter_gateway_number%>" />
									</div>
								</td>
								 <td>
									<div class="nav-search" style="margin-left:14px;">
									    <label><%=location%>：</label>
										<input class="nav-search-input" autocomplete="off" id="nav-search-input" type="text" name="location" value="${pd.location}" placeholder="<%=please_enter_location%>" />
									</div>
								</td>
								<td>
									<div class="nav-search" style="margin-left:14px;">
										<label><%=please_choose_start_time%>:</label>
										<input class="span10 date-picker" name="Start" id="Start"  value="${pd.Start}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:100px;height:28px;padding-top:2px;" placeholder="<%=please_choose_start_time%>" title="<%=start_time%>"/>
									</div>
								</td>
								<td>
									<div class="nav-search" style="margin-left:14px;">
										<label><%=please_choose_end_time%>:</label>
										<input class="span10 date-picker" name="End" name="End"  value="${pd.End}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:100px;height:28px;padding-top:2px;" placeholder="<%=please_choose_end_time%>" title="<%=end_time%>"/>
									</div>
								</td>
								<c:if test="${QX.cha == 1 }">
									<td style="vertical-align:right;padding-left:4px;padding-bottom:4px;"><button class="btn btn-mini btn-light" onclick="search();"  title="<%=search1%>" style="padding: 4px 4px;"><i id="nav-search-icon" class="ace-icon fa fa-search bigger-110 nav-search-icon white"></i><%=search1%></button></td>
								</c:if>
							</tr>
						</table>
						<!-- 检索  -->

						<table id="simple-table" class="table table-striped table-bordered table-hover"  style="margin-top:5px;">
							<thead>
								<tr>
									<th class="center" ><%=number%></th>
									<!-- <th class="center" >组名</th> -->
									<th class="center" ><%=gateway_number%></th>
									<th class="center" ><%=gateway_name%></th>
									<th class="center" ><%=location%></th>
									<th class="center" ><%=pole_number%></th>
									<!-- <th class="center" >网关</th> -->
									<th class="center" ><%=fault_type%></th>
									<th class="center"><%=start_time%></th>
									<th class="center"><%=exception_description%></th>
									<th class="center"><%=registrant%></th>
									<th class="center"><%=maintenance_man%></th>
									<th class="center"><%=repair_time%></th>
									<th class="center"><%=repair_result%></th>
									<th class="center"><%=repair_instructions%></th>
									<th class="center"><%=repair_register%></th>


								</tr>
							</thead>

							<tbody>

							<!-- 开始循环 -->
							<c:choose>
								<c:when test="${not empty gatewayList}">
									<c:if test="${QX.cha == 1 }">
									<c:forEach items="${gatewayList}" var="var" varStatus="vs">
										<tr>

											<td class='center' style="width: 30px;">${vs.index+1}</td>
													<%-- <td class="center">${var.cname}</td> --%>
													<td class="center">${var.code}</td>
													<td>${ fn:substring(var.name ,0,50)}</td>

													<td class="center">${var.location}</td>
													<td class="center">${var.polenumber}</td>
													<%-- <td class="center">${var.gateway}</td> --%>
													<td class="center">
														<c:if test="${var.type == '1' }"><span class="label label-important arrowed-in"><%=lamp_open_circuit%></span></c:if>
														<c:if test="${var.type == '2' }"><span class="label label-success arrowed"><%=lamp_short%></span></c:if>
														<c:if test="${var.type == '3' }"><span class="label label-success arrowed"><%=abnormal_lamp%></span></c:if>
														<c:if test="${var.type == '4' }"><span class="label label-success arrowed"><%=gateway_anomaly%></span></c:if>
														<c:if test="${var.type == '5' }"><span class="label label-success arrowed"><%=circuit_breaker_abnormality%></span></c:if>
													</td>
													<td class="center">${var.startime}</td>
													<td class="center">${var.comment}</td>
													<td class="center">${var.register}</td>
													<td class="center">${var.repairman}</td>
													<td class="center">${var.tdate}</td>
													<td class="center">
													    <c:if test="${var.result == '1' }"><span class="label label-important arrowed-in"><%=wait_repair%></span></c:if>
														<c:if test="${var.result == '2' }"><span class="label label-success arrowed"><%=has_repair%></span></c:if>
														<c:if test="${var.result == '3' }"><span class="label label-success arrowed"><%=destroy%></span></c:if>
														<c:if test="${var.result == '4' }"><span class="label label-success arrowed"><%=repair_self%></span></c:if>
														
													</td>
													<td class="center">${var.explain}</td>

											 <td class="center" style="width: 60px;">
												 <div class='hidden-phone visible-desktop btn-group'>

													<c:if test="${var.register !=null}">
													<a class="btn btn-xs btn-danger" onclick="edit('${var.id}');"><%=edit%></a>
														<%-- <c:if test="${var.tdate != '' }">
														<a style="cursor:pointer;" class="green" onclick="edit('${var.id}');" title="编辑">
															<i class="ace-icon fa fa-pencil bigger-130"></i>编辑
														</a> --%>
														<%-- </c:if > --%>
														<%-- <c:if test="${var.tdate == '' }">
														 <a class="btn btn-sm btn-success" onclick="add('${var.id}');" title="新增"></a>
														</c:if > --%>
								 				  </c:if>

														<c:if test="${var.register ==null}">
														<a class="btn btn-xs btn-danger" onclick="add('${var.id}');"><%=registe%></a>
														</c:if>

												 </div>
											</td>
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
							<%-- <td style="vertical-align:top;">
								<c:if test="${QX.add == 1 }">
								<a class="btn btn-sm btn-success" onclick="add();">维修登记</a>
								</c:if>
							</td> --%>
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
	<%@ include file="../../system/index/foot.jsp"%>
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

		//修改
		function edit(id){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="<%=modify%>";
			 diag.URL = '<%=basePath%>repair/goGatewayEdit?id='+id;
			 diag.Width = 650;
			 diag.Height = 280;
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 nextPage(${page.currentPage});
				}
				diag.close();
			 };
			 diag.show();
		}

		//新增
		function add(id){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="<%=add2%>";
			 diag.URL = '<%=basePath%>repair/goGatewayCreate?id='+id;
			 diag.Width = 650;
			 diag.Height = 280;
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 if('${page.currentPage}' == '0'){
						 top.jzts();
						 setTimeout("self.location=self.location",100);
					 }else{
						 nextPage(${page.currentPage});
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
