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
<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">
<!-- 下拉框 -->
<link rel="stylesheet" href="static/ace/css/chosen.css" />
<!-- jsp文件头和头部 -->
<%@ include file="../system/index/top.jsp"%>
<%@ include file="../international.jsp"%>
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
						<form action="repair/list" method="post" name="Form" id="Form">
						<input type="hidden" id="excel" name="excel" value="0"/>
						<input type="hidden" name="itype" id="itype" value="4">
						<table style="margin-top:5px;">
							<tr>
								
								<td>
									<div class="nav-search">
									    <label><%=group_name %>：</label>
										<input class="nav-search-input" autocomplete="off" id="groupname" type="text" name="groupname" value="${pd.groupname}" />
									</div>
								</td>
								<td >
								 	<div class="nav-search">
									    <label style="margin-left:12px;"><%=name %>：</label>
										<input class="nav-search-input" autocomplete="off" id="name" type="text" name="name" value="${pd.name }"  />
									</div>
								</td>
								<td >
								 	<div class="nav-search">
									    <label style="margin-left:12px;"><%=serial_number %>：</label>
										<input class="nav-search-input" autocomplete="off" id="number" type="text" name="number" value="${pd.number }"  />
									</div>
								</td>
								<td >
								 	<div class="nav-search">
									    <label style="margin-left:12px;"><%=location %>：</label>
										<input class="nav-search-input" autocomplete="off" id="location" type="text" name="location" value="${pd.location }"  />
									</div>
								</td>
								
								<%-- <c:if test="${QX.cha == 1 }"><td style="vertical-align:top;padding-left:2px;"><button class="btn btn-light btn-xs" onclick="search();"  title="检索"><i id="nav-search-icon" class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i></button></td></c:if>
								<c:if test="${QX.toExcel == 1 }"><td style="vertical-align:top;padding-left:2px;"><a class="btn btn-light btn-xs" onclick="toExcel();" title="导出到EXCEL"><i id="nav-search-icon" class="ace-icon fa fa-download bigger-110 nav-search-icon blue"></i></a></td></c:if> --%>
								</tr>
								<tr>
								<td >
									<div class="nav-search">
										<label><%=gateway %>：</label>
									 	<input class="nav-search-input" autocomplete="off" id="wgname" type="text" name="wgname" value="${pd.wgname }"  />
								  	</div>
								</td>
								<td>
								<div class="nav-search">
								<label  style="margin-left:12px;"><%=start_time %>：</label>
								<input class="span10 date-picker" name="starttime" id="starttime"  value="${pd.starttime}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:123px;height:28px" placeholder="<%=start_time %>" title="<%=start_time %>"/>
								</div>
								</td>
								<td>
								<div class="nav-search">
								<label  style="margin-left:12px;"><%=end_time %>：</label>
								<input class="span10 date-picker" name="endtime" name="endtime"  value="${pd.endtime}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:123px;height:28px" placeholder="<%=end_time %>" title="<%=end_time %>"/>
								</div>
								</td>
								<td style="vertical-align:inherit;padding-left:12px;">
								<c:if test="${QX.cha == 1 }"><button class="btn btn-light btn-xs" onclick="search();"  title="<%=search2%>"><i id="nav-search-icon" class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i></button></c:if>
								<c:if test="${QX.toExcel == 1 }"><a class="btn btn-light btn-xs" onclick="toExcel();" title="<%=export_to_excel %>>"><i id="nav-search-icon" class="ace-icon fa fa-download bigger-110 nav-search-icon blue"></i></a></c:if>
								</td>
								<%-- <td>&nbsp;&nbsp;状态：</td>
								<td>
								 	<select class="chosen-select form-control" name="status" id="status" data-placeholder="请选择状态" style="height:30px;width: 160px;margin-left:20px;border-width:1px;border-color:'#fff';border-radius:4px">
								 		<option value="">全部</option>
										<option value="1" <c:if test="${pd.status==1}">selected</c:if>>有效</option>
										<option value="2" <c:if test="${pd.status==2}">selected</c:if>>无效</option>
								  	</select>
								</td> --%>
								<%-- <c:if test="${QX.FromExcel == 1 }"><td style="vertical-align:top;padding-left:2px;"><a class="btn btn-light btn-xs" onclick="fromExcel();" title="从EXCEL导入"><i id="nav-search-icon" class="ace-icon fa fa-cloud-upload bigger-110 nav-search-icon blue"></i></a></td></c:if> --%>
							</tr>
						</table>
						<!-- 检索  -->

						<table id="simple-table" class="table table-striped table-bordered table-hover"  style="margin-top:5px;">
							<thead>
								<tr>
									<th class="center" style="width:50px"><%=group_name %></th>
									<th class="center"><%=device_number %></th>
									<th class="center"><%=device_name %></th>
									<th class="center"><%=location %></th>
									<th class="center"><%=pole_number %></th>
									<th class="center"><%=gateway %></th>
									<th class="center"><%=fault_type %></th>
									<th class="center"><%=start_time %></th>
									<th class="center"><%=exception_description %></th>
									<th class="center"><%=registrant %></th>
									<th class="center"><%=maintenance_man %></th>
									<th class="center"><%=repair_time %></th>
									<th class="center"><%=repair_result %></th>
									<th class="center"><%=repair_instructions %></th>
								</tr>
							</thead>

							<tbody>

							<!-- 开始循环 -->
							<c:choose>
								<c:when test="${not empty varList}">
									<c:if test="${QX.cha == 1 }">
									<c:forEach items="${varList}" var="var" varStatus="vs">
										<tr>
											<td class="center" style="width:50px">${var.groupname}</td>
											<td class="center">${var.client_code}</td>
											<td class="center">${var.name}</td>
											<td class="center">${var.location}</td>
											<td class="center">${var.lamp_pole_num}</td>
											<td class="center">${var.wgname}</td>
											<td class="center">
											<c:if test="${var.type=='1'}"><%=lamp_open_circuit %></c:if>
											<c:if test="${var.type=='2'}"><%=lamp_short %></c:if>
											<c:if test="${var.type=='3'}"><%=abnormal_lamp %></c:if>
											<c:if test="${var.type=='4'}"><%=gateway_anomaly %></c:if>
											<c:if test="${var.type=='5'}"><%=circuit_breaker_abnormality %></c:if>
											</td>
											<td class="center">${var.tdate}</td>
											<td class="center">${var.comment}</td>
											<td class="center">${var.register}</td>
											<td class="center">${var.repairman}</td>
											<td class="center">${var.repairtime}</td>
											<%-- <td class="center">${var.result}</td> --%>
											<td class="center">
													    <c:if test="${var.result == '1' }"><span class="label label-important arrowed-in"><%=wait_repair%></span></c:if>
														<c:if test="${var.result == '2' }"><span class="label label-success arrowed"><%=has_repair%></span></c:if>
														<c:if test="${var.result == '3' }"><span class="label label-success arrowed"><%=destroy%></span></c:if>
														<c:if test="${var.result == '4' }"><span class="label label-success arrowed"><%=repair_self%></span></c:if>
													</td>
											<td class="center">${var.explain}</td>
											<!--  <td class="center">${var.CREATETIME}</td>
											<td style="width: 60px;" class="center">
												<c:if test="${var.STATUS == '2' }"><span class="label label-important arrowed-in">无效</span></c:if>
												<c:if test="${var.STATUS == '1' }"><span class="label label-success arrowed">有效</span></c:if>
											</td>
											-->
											<%-- <td class="center" style="width:50px;">
												<c:if test="${QX.edit != 1 && QX.del != 1 }">
												<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="ace-icon fa fa-lock" title="无权限"></i></span>
												</c:if>
												<div class="hidden-sm hidden-xs btn-group">
													<c:if test="${QX.edit == 1 }">
													<a class="btn btn-xs btn-success" onclick="edit('${var.id}','${var.typeid}');">修改</a>
													</c:if>
												</div>
											</td> --%>
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
							<%-- <td style="vertical-align:top;">
								<c:if test="${QX.add == 1 }">
								<a class="btn btn-sm btn-success" onclick="add();">新增</a>
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
	<%@ include file="../system/index/foot.jsp"%>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<!-- 删除时确认窗口 -->
	<script src="static/ace/js/bootbox.js"></script>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<script type="text/javascript">
		$(top.hangge());

		//检索
		function search(){
			top.jzts();
			$("#Form").submit();
		}

		//新增
		function add(){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="新增";
			 diag.URL = '<%=basePath%>config/goDeviceCreate';
			 diag.Width = 650;
			 diag.Height = 640;
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

		//修改
		function edit(Id, type){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="修改";
			 diag.URL = '<%=basePath%>config/goDeviceEdit?id='+Id+'&typeid='+type;
			 diag.Width = 650;
			 diag.Height = 640;
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 nextPage('${page.currentPage}');
				}
				diag.close();
			 };
			 diag.show();
		}

		//打开上传excel页面
		function fromExcel(){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="EXCEL 导入到数据库";
			 diag.URL = '<%=basePath%>config/goUploadExcel?type=1';
			 diag.Width = 300;
			 diag.Height = 150;
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 if('${page.currentPage}' == '0'){
						 top.jzts();
						 setTimeout("self.location.reload()",100);
					 }else{
						 nextPage('${page.currentPage}');
					 }
				}
				diag.close();
			 };
			 diag.show();
		}
		
		//导出excel
		function toExcel(){
			$("#excel").val("1");
			$("#Form").submit();
			$("#excel").val("0");
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
