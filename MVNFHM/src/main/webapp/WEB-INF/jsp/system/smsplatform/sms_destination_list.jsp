<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">

<!-- jsp文件头和头部 -->
<%@ include file="../../system/index/top.jsp"%>
<%@ include file="../../international.jsp"%>
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
							<form action="smsplatform/goSmsSetting.do" method="post" name="Form" id="Form">
							<input type="hidden" name="b_note_id" id="b_note_id" value="${pd.b_note_id}"/>
							<div id="zhongxin" style="padding-top: 13px;">
								<table id="simple-table" class="table table-striped table-bordered table-hover"	style="margin-top: 15px;">
									<thead>
										<tr>
											<th class="center"><%=equipment_type%></th>
											<th class="center"><%=fault_type%></th>
											<th class="center"><%=location%></th>
											<th class="center"><%=remind_admin%></th>
											<th class="center"><%=sms_destination%></th>
											<th class="center"><%=operate%></th>
										</tr>
									</thead>

									<tbody>
										<!-- 开始循环 -->
										<c:choose>
											<c:when test="${not empty destInfo}">
												<c:if test="${QX.cha == 1 }">
													<c:forEach items="${destInfo}" var="var" varStatus="vs">
														<tr>
															<%-- <td class='center'>
															<select class="chosen-select form-control" name="deviceType" id="deviceType" data-placeholder="<%=please_choose_device_type%>" style="height:30px;width: 160px;border-width:1px;border-color:'#fff';border-radius:4px">
																	<option value="1" <c:if test="${1==pd.device_type}">selected="selected"</c:if>><%=gateway%></option>
																	<option value="2" <c:if test="${2==pd.device_type}">selected="selected"</c:if>><%=node%></option>
															</td> --%>
															<c:if test="${var.device_type == 1}">
																<td class='center'><%=gateway %></td>
																<td class='center'>${var.gateway_fault_name}</td>
															</c:if>
															<c:if test="${var.device_type ==2}">
																<td class='center'><%=node %></td>
																<td class='center'>${var.node_fault_name}</td>
															</c:if>
															<td class='center'>${var.location}</td>
															<td class='center'><input type="checkbox" id="send_to_admin" name="send_to_admin" <c:if test="${var.send_to_admin == '1'}">checked</c:if> onclick="return false;" /></td>
															<td class='center'>${var.person_name}</td>
															<td class="center"><c:if
																	test="${QX.edit != 1 && QX.del != 1 }">
																	<span
																		class="label label-large label-grey arrowed-in-right arrowed-in"><i
																		class="ace-icon fa fa-lock"
																		title="<%=no_permission%>"></i></span>
																</c:if>
																<div class="hidden-sm hidden-xs">
																	<c:if test="${QX.edit == 1 }">
																		<a class="btn btn-xs btn-success" onclick="edit('${var.id}');"><%=edit %></a>
																	</c:if>
																	<c:if test="${QX.del == 1 }">
																		<a class="btn btn-xs btn-danger" onclick="del('${var.id}');"><%=delete %></a>
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
													<td colspan="100" class="center"><%=no_relevant_data%></td>
												</tr>
											</c:otherwise>
										</c:choose>
									</tbody>
								</table>
								<div class="page-header position-relative">
									<table style="width: 100%;">
										<tr>
											<td style="vertical-align: top;"><c:if
													test="${QX.add == 1 }">
													<a class="btn btn-sm btn-success"
														onclick="add(${pd.b_note_id});"><%=add2%></a>
												</c:if></td>
											<td style="vertical-align: top;"><div class="pagination"
													style="float: right; padding-top: 0px; margin-top: 0px;">${page.pageStr}</div></td>
										</tr>
									</table>
								</div>
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
		<a href="#" id="btn-scroll-up"
			class="btn-scroll-up btn btn-sm btn-inverse"> <i
			class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
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
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<script type="text/javascript">
		$(top.hangge());//关闭加载状态
		//检索
		function gsearch(){
			top.jzts();
			$("#Form").submit();
		}
		
		//新增
		function add(b_note_id){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="<%=add_sms_setting%>";
			 diag.URL = '<%=basePath%>smsplatform/goAddSmsSetting.do?b_note_id='+b_note_id;
			 diag.Width = 470;
			 diag.Height = 280;
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
		
		//删除
		function del(Id){
			bootbox.confirm("确定要删除吗?", function(result) {
				if(result) {
					top.jzts();
					var url = "<%=basePath%>smsplatform/deleteSmsSetting.do?id="+Id+"&tm="+new Date().getTime();
					$.get(url,function(data){
						nextPage('${page.currentPage}');
					});
				}
			});
		}
		
		//修改
		function edit(Id){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="<%=modify %>";
			 diag.URL = '<%=basePath%>smsplatform/goDestEdit?id='+Id;
			 diag.Width = 470;
			 diag.Height = 280;
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 nextPage('${page.currentPage}');
				}
				diag.close();
			 };
			 diag.show();
		}
		
/* 		$(function() {
			alert(${addScuccess});
		}); */
	</script>

</body>
</html>