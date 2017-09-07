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
						<form action="group/listClients.do?" method="post" name="Form" id="Form">
						<input type="hidden" id="gateway_id" name="gateway_id" value="${pd.gateway_id }"/>
						<input type="hidden" id="term_id" name="term_id" value="${pd.term_id }"/>
						<input type="hidden" id="client_ids" name="client_ids" value="${pd.client_ids }"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table style="margin-top:5px;">
							<tr>
								<td>
									<div class="nav-search" style="margin-left:14px;">
									    <label><%=device_number%>：</label>
										<input class="nav-search-input" autocomplete="off" id="code-input" type="text" name="code" value="${pd.code}" placeholder="<%=please_enter_client_code%>" />
									</div>
								</td>
								 <td>
									<div class="nav-search" style="margin-left:8px;">
									    <label><%=device_name%> ：</label>
										<input class="nav-search-input" autocomplete="off" id="name-input" type="text" name="name" value="${pd.name}" placeholder="<%=please_enter_client_name%>" /> 
									</div>
								</td>
								<c:if test="${QX.cha == 1 }">
								<td style="vertical-align:top;padding-left:2px;">&nbsp;&nbsp;<a class="btn btn-light btn-xs" onclick="clearSearchs();"  title="<%=clear_search_ %>" style="padding: 4px 4px;"><i id="nav-clear-icon" class="ace-icon fa fa-search bigger-110 nav-search-icon red"></i></a></td>
								</c:if>
								<c:if test="${QX.cha == 1 }">
								<td style="vertical-align:top;padding-left:2px;">&nbsp;&nbsp;<a class="btn btn-light btn-xs" onclick="searchs();"  title="<%=search2 %>" style="padding: 4px 4px;"><i id="nav-search-icon" class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i></a></td>
								</c:if>
							</tr>
						</table>
						<!-- 检索  -->

						<table id="simple-table" class="table table-striped table-bordered table-hover"  style="margin-top:5px;">
							<thead>
								<tr>
									<!-- 选择框 -->
									<th class="center" style="width:35px;">
									<label class="pos-rel"><input type="checkbox" class="ace" id="zcheckbox" /><span class="lbl"></span></label>
									</th>
									<th class="center" ><%=number %></th>
									<th class="center" ><%=device_number %></th>
									<th class="center" ><%=device_name %></th>
								</tr>
							</thead>

							<tbody>
							<!-- 开始循环 -->
							<c:choose>
								<c:when test="${not empty clientList}">
									<c:if test="${QX.cha == 1 }">
									<c:forEach items="${clientList}" var="var" varStatus="vs">
										<tr>
											<!-- 选择框 -->	
											<td class='center'>
												<label class="pos-rel"><input type='checkbox' name='ids' id="ids${vs.index}" value="${var.client_id}" class="ace" ${var.checked}/><span class="lbl"></span></label>
											</td>
											<!-- 序号 -->
											<td class='center' style="width: 50px;">${vs.index+1}</td>
											<!-- 终端编号 -->
											<td class="center">${var.client_code}</td>
											<!-- 终端描述 -->
											<td>${fn:substring(var.name,0,50)}</td>
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
								<td style="vertical-align:top;">
									<c:if test="${QX.add == 1 }">
									<!-- 添加终端 -->
									<a class="btn btn-mini btn-primary" onclick="makeAll('<%=make_sure_add_client%>');"><%=make_sure %></a>
									<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();"><%=cancel%></a>
									</c:if>
								</td>
								<td style="vertical-align:top;"><div class="pagination" style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div></td>
							</tr>
						</table>
						</div>
						</div>
					<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green"><%=committing %>...</h4></div>
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
</body>
	<script type="text/javascript">
		$(top.hangge());
	
		//清空检索条件
		function clearSearchs(){
			$("#code-input").val("");
			$("#name-input").val("");
		}
	
		//检索
		function searchs(){
			top.jzts();
			$("#Form").submit();
		}		
		
		//批量操作 添加策略
		function makeAll(msg){
			var str = '';
			var emstr = '';
			var phones = '';
			var username = '';
			
			for(var i=0;i < document.getElementsByName('ids').length;i++)
			{
				if(document.getElementsByName('ids')[i].checked){
					var idsid = document.getElementsByName('ids')[i].id;
					var index = idsid.substr(3); 
	
					if(str=='') str += document.getElementsByName('ids')[i].value;
					else str += ',' + document.getElementsByName('ids')[i].value;
				  }
			}	
					
			$("#client_ids").val(str);
			$("#Form").attr("action","group/toListGateways.do ");
		    $("#Form").submit();
		};

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

</html>
