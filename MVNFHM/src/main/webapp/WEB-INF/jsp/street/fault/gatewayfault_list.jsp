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
						<form action="fault/street/listGateways.do" method="post" name="Form" id="Form">
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
								 	<select class="chosen-select form-control" name="lstatus" id="lstatus" data-placeholder=" " style="vertical-align:top;width: 130px;height:30px">
									<option value=""></option>
									<option value=""><%=total %></option>
									<option value="2" <c:if test="${pd.lstatus == '2' }">selected</c:if> ><%=over_voltage %></option>
									<option value="3" <c:if test="${pd.lstatus == '3' }">selected</c:if> ><%=over_temperature %></option>
									<option value="4" <c:if test="${pd.lstatus == '4' }">selected</c:if> ><%=open_road %></option>
									<option value="5" <c:if test="${pd.lstatus == '5' }">selected</c:if> ><%=short_circuit %></option>
									<option value="6" <c:if test="${pd.lstatus == '6' }">selected</c:if> ><%=exception %></option>
									<option value="8" <c:if test="${pd.lstatus == '8' }">selected</c:if> ><%=undervoltage %></option>
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
									<th class="center"><%=serial_number %></th>
									<th class="center"><%=name %></th>
									<th class="center"><%=location %></th>
									<th class="center"><%=pole_number2 %></th>
									<th class="center"><%=comment %></th>
									<th class="center"><%=voltage %></th>
									<th class="center"><%=start_time %></th>
									<th class="center"><%=exception_description %></th>
								</tr>
							</thead>
													
							<tbody>
							<!-- 开始循环 -->	
							<c:choose>
								<c:when test="${not empty gatewayfaultList}">
									<c:if test="${QX.cha == 1 }">
									<c:forEach items="${gatewayfaultList}" var="gatewayfault" varStatus="vs">
										<tr>
											<td class='center' style="width: 30px;">${vs.index+1}</td>
											<td class='center'>${gatewayfault.gateway_code}</td>
											<td class='center'>${gatewayfault.name}</td>
											<td class='center'>${gatewayfault.location}</td>
											<td class='center'>${gatewayfault.lamp_pole_num}</td>
											<td class='center'>${gatewayfault.acomment}</td>
									        <td class='center'>${gatewayfault.voltage}</td>
									        <td class='center'>${gatewayfault.tdate}</td>
									        <td class='center'>${gatewayfault.fcomment}</td>
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
		
		
	</script>


</body>
</html>