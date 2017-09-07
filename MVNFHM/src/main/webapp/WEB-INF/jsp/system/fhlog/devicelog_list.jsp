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
<!-- 下拉框 -->
<link rel="stylesheet" href="static/ace/css/chosen.css" />
<!-- jsp文件头和头部 -->
<%@ include file="../../system/index/top.jsp"%>
<!-- 日期框 -->
<link rel="stylesheet" href="static/ace/css/datepicker.css" />
</head>
<style type="text/css">
	.ellipse{width:200px;}
</style>
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
						<form action="fhlog/deviceLogList" method="post" name="Form" id="Form">
						<table style="margin-top:5px;">
							<tr>
								<td>
									<div class="nav-search">
									    <label><%=user%>：</label>
										<input class="nav-search-input" autocomplete="off" id="username" type="text" name="username" value="${pd.username}" />
									</div>
								</td>
								<td>&nbsp;&nbsp;<%=status%>：</td>
								<td style="vertical-align:top;padding-left:2px;"> 
								 	<select class="chosen-select form-control" name="type" id="type"  style="vertical-align:top;width: 130px;">
										<option value=""></option>
										<option value="" selected><%=total%></option>
										<c:forEach items="${logtypeList}" var="item" varStatus="vs">
											<option value="${item.id}" <c:if test="${pd.type == item.id}">selected</c:if> >${item.name}</option>
										</c:forEach>
									</select>
								</td>
								<td>
									<div class="nav-search" style="padding-left:12px;">
										<label><%=start_time%>：</label>
										<input class="span10 date-picker" name="starttime" id="starttime"  value="${pd.starttime}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:100px; height:28px"  title="<%=start_time%>"/>
									</div>
								</td>
								<td>
									<div class="nav-search" style="padding-left:12px;">
										<label><%=end_time%>：</label>
										<input class="span10 date-picker" name="endtime" name="endtime"  value="${pd.endtime}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:100px;height:28px" title="<%=end_time%>"/>
									</div>
								</td>
								<c:if test="${QX.cha == 1 }">
									<td style="vertical-align:top;padding-left:2px"><a class="btn btn-light btn-xs" onclick="tosearch();"  title="<%=search2%>"><i id="nav-search-icon" class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i></a></td>
								</c:if>
								<c:if test="${QX.toExcel == 1 }"><td style="vertical-align:top;padding-left:2px;"><a class="btn btn-light btn-xs" onclick="toExcel();" title="<%=export_to_excel%>"><i id="nav-search-icon" class="ace-icon fa fa-download bigger-110 nav-search-icon blue"></i></a></td></c:if>
							</tr>
						</table>
						<!-- 检索  -->
					
						<table id="simple-table" class="table table-striped table-bordered table-hover" style="margin-top:5px;">	
							<thead>
								<tr>
									<th class="center"><%=user%></th>
									<th class="center"><%=operate_time%></th>
									<th class="center"><%=command_type%></th>
									<th class="center"><%=gateway%>/<%=circuit_breaker%></th>
									<th class="center"><%=light%>/<%=device%></th>
									<th class="center"><%=content%></th>
									<th class="center"><%=status%></th>
									<th class="center"><%=feedback_time%></th>
									
								</tr>
							</thead>
													
							<tbody>
							<!-- 开始循环 -->	
							<c:choose>
								<c:when test="${not empty varList}">
									<c:if test="${QX.cha == 1 }">
									<c:forEach items="${varList}" var="var" varStatus="vs">
										<tr>
											<td class='center'>${var.name}</td>
											<td class='center'>${var.operate_time}</td>
											<td class='center'>${var.cmd_type}</td>
											<td class='center'>${var.gateway}</td>
											<td class='center'>${var.device}</td>
											<td class='center ellipse'" title="${var.comment}">${var.comment}</td>
											<td class='center'>${var.status}</td>
											<td class='center'>${var.feedback_time}</td>
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
		
		var tds = $("td.ellipse");
		for(var i=0;i<tds.length;i++){
			var comment = tds[i].innerHTML
			if(comment.length>=20){
				tds[i].innerHTML = comment.substring(0,20)+"…" 
			}
		}
		
		//检索
		function tosearch(){
			top.jzts();
			$("#Form").submit();
		}
		$(function() {
			$("td.ellipse").val("哈哈");
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
		
		
		//导出excel
		function toExcel(){
			window.location.href='<%=basePath%>fhlog/excelDevice';
		}
	</script>


</body>
</html>