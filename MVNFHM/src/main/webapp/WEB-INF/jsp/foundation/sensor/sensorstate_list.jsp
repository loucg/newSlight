﻿<%@ page language="java" contentType="text/html; charset=UTF-8"
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
							
						<form action="sensor/goViewDetail.do?id=${pd.id}" method="post" name="Form" id="Form">
						<table style="margin-top:5px;" class="table table-striped table-bordered table-hover">
							<tr>
							<td class="center">
								<c:choose>
								<c:when test="${not empty sensorDetailList}">
									<c:forEach items="${gatewaynamelist}" var="gateway" varStatus="vs">
										<%=sensor_gatewayname %>${gateway.gateway_code }
									</c:forEach>
								</c:when>
								</c:choose>
							</td>
							</tr>
							</table>
						<table id="simple-table" class="table table-striped table-bordered table-hover" style="margin-top:5px;">	
							<thead>
								<tr>
									<th class="center"><%=node_address %></th>
									<th class="center"><%=node_number %></th>
									<th class="center"><%=node_name %></th>
									<th class="center"><%=work_status %></th>
									<th class="center"><%=voltage %></th>
									<th class="center"><%=power_rate_factor %></th>
									<th class="center"><%=temperature %></th>
								</tr>
							</thead>
													
							<tbody>
							<!-- 开始循环 -->	
							
							<c:choose>
								<c:when test="${not empty sensorDetailList}">
									<c:if test="${QX.cha == 1 }">
									<c:forEach items="${sensorDetailList}" var="sensorState" varStatus="vs">
										<tr>
											<td class='center'>${sensorState.node}</td>
											<td class='center'>${sensorState.sensor_code }</td>
											<td class='center'>${sensorState.cname }</td>
  											<td class='center'>${sensorState.status_name}</td>
									        <td class='center'>${sensorState.voltage}</td>
									        <td class='center'>${sensorState.power_factor}</td>
									        <td class='center'>${sensorState.temperature}</td>
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
								<td style="vertical-align:top;">
								</td>
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
		
		//批量操作
		function makeAll(msg){
			bootbox.confirm(msg, function(result) {
				if(result) {
					var onlamp = '';
					var offlamp = '';
					var bright = '';
					var str = '';
					for(var i=0;i < document.getElementsByName('ids').length;i++)
					{
						  if(document.getElementsByName('ids')[i].checked){
						  	if(onlamp=='') onlamp += document.getElementsByName('ids')[i].value;
						  	else onlamp += ';' + document.getElementsByName('ids')[i].value;
						  	
						  	if(offlamp=='') offlamp += document.getElementsByName('ids')[i].value;
						  	else offlamp += ';' + document.getElementsByName('ids')[i].value;
						  	
						  	if(bright=='') bright += document.getElementsByName('ids')[i].value;
						  	else bright += ';' + document.getElementsByName('ids')[i].value;
						  	
						  	if(str=='') str += document.getElementsByName('ids')[i].value;
						  	else str += ';' + document.getElementsByName('ids')[i].value;
						  }
					}
					if(str==''){
						bootbox.dialog({
							message: "<span class='bigger-110'><%=you_have_not_choose_anything %>!</span>",
							buttons: 			
							{ "button":{ "label":"<%=make_sure %>", "className":"btn-sm btn-success"}}
						});
						$("#zcheckbox").tips({
							side:3,
				            msg:'<%=click_this_choose_all %>"',
				            bg:'#AE81FF',
				            time:8
				        });
						
						return;
					}else{
						if(msg == '<%=make_sure_divider_open_light %>?'){
							top.jzts();
							$.ajax({
								type: "POST",
								url: '<%=basePath%>state/lamp/openLight.do',
						    	data: {DATA_IDS:onlamp},
								dataType:'json',
								//beforeSend: validateData,
								cache: false,
								success: function(data){
									 $.each(data.list, function(i, list){
											nextPage(${page.currentPage});
									 });
								}
							});
						}else if(msg == '<%=make_sure_shut_down_light %>?'){
							top.jzts();
							$.ajax({
								type: "POST",
								url: '<%=basePath%>state/lamp/offLight.do',
						    	data: {DATA_IDS:offlamp},
								dataType:'json',
								//beforeSend: validateData,
								cache: false,
								success: function(data){
									 $.each(data.list, function(i, list){
											nextPage(${page.currentPage});
									 });
								}
							});
						}else if(msg == '<%=make_sure_adjust_brightness %>?'){
							adjustBrt(bright);
						}else if(msg == '<%=make_sure_adjust_strategy %>?'){
							adjustStr(str);
						}
					}
				}
			});
		}	
		
		//去调节亮度界面
		function adjustBrt(bright){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="<%=brightness_adjust %>";
			 diag.URL = '<%=basePath%>state/lamp/goAdjustBrt.do?DATA_IDS='+ bright; 
			 diag.Width = 469;
			 diag.Height = 150;
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					nextPage(${page.currentPage});
				}
				diag.close();
			 };
			 diag.show();
		}
		
		//去调节策略界面
		function adjustStr(str){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="<%=schedule_adjust_brightness %>";
			 diag.URL = '<%=basePath%>state/lamp/goAdjustStr.do?DATA_IDS='+ str;
			 diag.Width = 469;
			 diag.Height = 300;
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					nextPage(${page.currentPage});
				}
				diag.close();
			 };
			 diag.show();
		}
		
		//查看灯的详细信息
		function viewLampDetail(id){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="<%=detail %>";
			 diag.URL = '<%=basePath%>state/lamp/goViewDetail.do?id='+id; 
			 diag.Width = 800;
			 diag.Height = 320;
			 diag.CancelEvent = function(){ //关闭事件
				diag.close();
			 };
			 diag.show();
		}
	</script>


</body>
</html>