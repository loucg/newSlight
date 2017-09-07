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
<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">
<!-- 下拉框 -->
<link rel="stylesheet" href="static/ace/css/chosen.css" />
<!-- jsp文件头和头部 -->
<%@ include file="../../system/index/top.jsp"%>
<!-- jsp国际化文件 -->
<%@ include file="../../international.jsp"%>
<!-- 日期框 -->
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
						<form action="state/street/listGateways.do" method="post" name="Form" id="Form">
						<table style="margin-top:5px;">
							<tr>
								<td><%=name %>：</td>
								<td>
									<div class="nav-search">
										<span class="input-icon">
											<input type="text" class="nav-search-input" id="nav-search-input" autocomplete="off" name="name" value="${pd.name }"/>
										</span>
									</div>
								</td>
								<td>&nbsp;&nbsp;<%=serial_number %>：</td>
								<td>
									<div class="nav-search">
										<span class="input-icon">
											<input type="text" class="nav-search-input" id="nav-search-input" autocomplete="off" name="gateway_code" value="${pd.gateway_code }"/>
										</span>
									</div>
								</td>
								<td>&nbsp;&nbsp;<%=location %>：</td>
								<td>
									<div class="nav-search">
										<span class="input-icon">
											<input type="text" class="nav-search-input" id="nav-search-input" autocomplete="off" name="location" value="${pd.location }"/>
										</span>
									</div>
								</td>
								<td>&nbsp;&nbsp;<%=status %>：</td>
								<td style="vertical-align:top;padding-left:2px;"> 
								 	<select class="chosen-select form-control" name="status" id="status" data-placeholder=" " style="vertical-align:top;width: 130px;height:30px">
										<option value=""></option>
										<option value=""><%=total %></option>
、										<c:forEach items="${workStatusList}" var="workStatus">
											<option value="${workStatus.value }" <c:if test="${workStatus.value == pd.status }">selected</c:if>>${workStatus.name }</option>
										</c:forEach>
										<%-- <option value="<%=normal %>"           <c:if test="${pd.status == '<%=normal %>' }">selected</c:if> ><%=normal %></option>
										<option value="<%=over_voltage %>"     <c:if test="${pd.status == '<%=over_voltage %>' }">selected</c:if> ><%=over_voltage %></option>
										<option value="<%=over_temperature %>" <c:if test="${pd.status == '<%=over_temperature %>' }">selected</c:if> ><%=over_temperature %></option>
										<option value="<%=open_road %>"        <c:if test="${pd.status == '<%=open_road %>' }">selected</c:if> ><%=open_road %></option>
										<option value="<%=short_circuit %>"    <c:if test="${pd.status == '<%=short_circuit %>' }">selected</c:if> ><%=short_circuit %></option>
										<option value="<%=exception %>"        <c:if test="${pd.status == '<%=exception %>' }">selected</c:if> ><%=exception %></option>
										<option value="<%=blockout %>"         <c:if test="${pd.status == '<%=blockout %>' }">selected</c:if> ><%=blockout %></option>
										<option value="<%=undervoltage %>"     <c:if test="${pd.status == '<%=undervoltage %>' }">selected</c:if> ><%=undervoltage %></option> --%>
<%-- 									<option value=""><%=total %>全部</option>
										<option value="<%= %>正常" <c:if test="${pd.status == '<%= %>正常' }">selected</c:if> ><%= %>正常</option>
										<option value="<%= %>过压" <c:if test="${pd.status == '<%= %>过压' }">selected</c:if> ><%= %>过压</option>
										<option value="<%= %>过温" <c:if test="${pd.status == '<%= %>过温' }">selected</c:if> ><%= %>过温</option>
										<option value="<%= %>开路" <c:if test="${pd.status == '<%= %>开路' }">selected</c:if> ><%= %>开路</option>
										<option value="<%= %>短路" <c:if test="${pd.status == '<%= %>短路' }">selected</c:if> ><%= %>短路</option>
										<option value="<%= %>异常" <c:if test="${pd.status == '<%= %>异常' }">selected</c:if> ><%= %>异常</option>
										<option value="<%= %>断电" <c:if test="${pd.status == '<%= %>断电' }">selected</c:if> ><%= %>断电</option>
										<option value="<%= %>欠压" <c:if test="${pd.status == '<%= %>欠压' }">selected</c:if> ><%= %>欠压</option> --%>
									</select>
								</td>
								<c:if test="${QX.cha == 1 }">
								<td style="vertical-align:top;padding-left:2px"><a class="btn btn-light btn-xs" onclick="tosearch();"  title="<%=search2 %>" style="padding: 4px 4px;"><i id="nav-search-icon" class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i></a></td>
								</c:if>
							</tr>
						</table>
						<!-- 检索  -->
					
						<table id="simple-table" class="table table-striped table-bordered table-hover" style="margin-top:5px;">	
							<thead>
								<tr>
									<th class="center" style="width:50px;"><%=number %></th>
									<th class="center"><%=gateway_number %></th>
									<th class="center"><%=gateway_name %></th>
									<th class="center"><%=gateway_location %></th>
									<th class="center"><%=signal_strength %></th>
									<th class="center"><%=comment %></th>
									<th class="center"><%=voltage %></th>
									<th class="center"><%=device_counter %></th>
									<th class="center"><%=work_status %></th>
									<th class="center"><%=time %></th>
								</tr>
							</thead>
													
							<tbody>
							<!-- 开始循环 -->	
							<c:choose>
								<c:when test="${not empty gatewayStateList}">
									<c:if test="${QX.cha == 1 }">
									<c:forEach items="${gatewayStateList}" var="gatewayState" varStatus="vs">
										<tr>
											<td class='center' style="width: 30px;">${vs.index+1}</td>
											<td class='center'><a onclick="viewLampDetailUnderGateway('${gatewayState.id}')" style="cursor:pointer;">${gatewayState.gateway_code}</a></td>
											<td class='center'>${gatewayState.name}</td>
											<td class='center'>${gatewayState.location}</td>
											<td class='center'>
												<c:if test="${gatewayState.interstatus == 0}">
													<img src="<%=basePath%>uploadFiles/uploadImgs/weak_signal.png" alt="弱信号"/>
												</c:if>
												<c:if test="${gatewayState.interstatus == 1}">
													<img src="<%=basePath%>uploadFiles/uploadImgs/strong_signal.png" alt="有信号"/>
												</c:if>
												<c:if test="${gatewayState.interstatus == 2}">
													<img src="<%=basePath%>uploadFiles/uploadImgs/no_signal.png" alt="无信号"/>
												</c:if>
											</td>
											<td class='center'>${gatewayState.comment}</td>
											<td class='center'>${gatewayState.voltage}</td>
											<td class='center'>${gatewayState.client_num}</td>
									        <td class='center'>${gatewayState.status_name}</td>
									        <td class='center'>${gatewayState.tdate}</td>
										</tr>
									</c:forEach>
									</c:if>
									<c:if test="${QX.cha == 0 }">
										<tr>
											<td colspan="100" class="center"><%=you_have_no_permission %></td>
										</tr>
									</c:if>
								</c:when>
								<c:otherwise>
									<tr class="main_info">
										<td colspan="100" class="center" ><%=no_relevant_data %></td>
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
	<%@ include file="../../system/index/foot.jsp"%>
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
		$(top.hangge());//关闭加载状态
		//检索
		function tosearch(){
			top.jzts();
			$("#Form").submit();
		}
		$(function() {
		
 			//日期框
			$('.date-picker').datepicker({
				autoclose: true,
				todayHighlight: true
			});
			
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
		});	
		
		//查看同一网关下的终端信息
		function viewLampDetailUnderGateway(id){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="<%=detail %>";
			 diag.URL = '<%=basePath%>state/street/goViewDetail.do?id='+id; 
			 diag.Width = 1400;
			 diag.Height = 320;
			 diag.CancelEvent = function(){ //关闭事件
				diag.close();
			 };
			 diag.show();
		}
	</script>


</body>
</html>