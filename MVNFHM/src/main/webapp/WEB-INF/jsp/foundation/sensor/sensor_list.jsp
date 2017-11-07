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
<%@include file="../../international.jsp"%>  <!--国际化标签  -->
<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">
<!-- 下拉框 -->
<link rel="stylesheet" href="static/ace/css/chosen.css" />
<!-- jsp文件头和头部 -->
<%@ include file="../../system/index/top.jsp"%>

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
						<form action="sensor/getSensorList.do?gateway_id=${pd.gateway_id}" method="post" name="Form" id="Form">
						<input type="hidden" id="excel" name="excel" value="0"/>
						<input type="hidden" id="gateway_id" name="gateway_id" value="${pd.gateway_id}"/>
						<table style="margin-top:5px;" class="table table-striped table-bordered table-hover">
							<tr>
							<td class="center">
								<c:choose>
								<c:when test="${not empty sensorList}">
									<c:forEach items="${gatewaynamelist}" var="gateway" varStatus="vs">
										<%=sensor_config_gatewayname %>${gateway.gateway_code }
									</c:forEach>
								</c:when>
								</c:choose>
							</td>
							</tr>
						</table>
						<table style="margin-top:5px;">
							<tr>
								
								<td>
									<div class="nav-search">
									    <label><%=node_number%>：</label>
										<input class="nav-search-input" autocomplete="off" id="nav-search-input" type="text" name="number" value="${pd.number}" />
									</div>
								</td>
								<td >
								 	<div class="nav-search">
									    <label style="margin-left:12px;"><%=node_name%>：</label>
										<input class="nav-search-input" autocomplete="off" id="nav-search-input" type="text" name="name" value="${pd.name }"  />
									</div>
								</td>
								<td>&nbsp;&nbsp;<%=node_type%>：</td>
									<td >
									 	<select class="chosen-select form-control" name="type" id="type" data-placeholder="<%=please_choose_device_type%>" style="height:30px;width: 160px;border-width:1px;border-color:'#fff';border-radius:4px">
											<option value="-1" <c:if test="${pd.type!=-1}"> style="display:none"</c:if>>请选择类型</option>
											<c:forEach items="${typeList}" var="type">
												<option value="${type.id}" <c:if test="${type.id==pd.type}">selected="selected"</c:if>>${type.name}</option>
											</c:forEach>
											<option value="999" <c:if test="${pd.type==999}">selected="selected"</c:if>><%=all%></option>
									  	</select>
									</td>
								<c:if test="${QX.cha == 1 }"><td style="vertical-align:top;padding-left:2px;"><button class="btn btn-light btn-xs" onclick="search();"  title="<%=search2%>"><i id="nav-search-icon" class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i></button></td></c:if>
								<c:if test="${QX.toExcel == 1 }"><td style="vertical-align:top;padding-left:2px;"><a class="btn btn-light btn-xs" onclick="toExcel();" title="<%=export_to_excel%>"><i id="nav-search-icon" class="ace-icon fa fa-download bigger-110 nav-search-icon blue"></i></a></td></c:if>
								<c:if test="${QX.FromExcel == 1 }"><td style="vertical-align:top;padding-left:2px;"><a class="btn btn-light btn-xs" onclick="fromExcel('${pd.gateway_id}');" title="<%=import_from_excel%>"><i id="nav-search-icon" class="ace-icon fa fa-cloud-upload bigger-110 nav-search-icon blue"></i></a></td></c:if>
							</tr>
						</table>
						<!-- 检索  -->

						<table id="simple-table" class="table table-striped table-bordered table-hover"  style="margin-top:5px;">
							<thead>
								<tr>
									<th class="center"><%=node_address%></th>
									<th class="center"><%=node_number%></th>
									<th class="center"><%=node_name%></th>
									<th class="center"><%=node_type%></th>
									<th class="center"><%=location%></th>
									<th class="center"><%=coordinate%></th>
									<th class="center"><%=pole%></th>
									<th class="center"><%=pole_number%></th>
									<th class="center"><%=comment%></th>
									<th class="center"><%=operate%></th>
								</tr>
							</thead>

							<tbody>

							<!-- 开始循环 -->
							<c:choose>
								<c:when test="${not empty sensorList}">
									<c:if test="${QX.cha == 1 }">
									<c:forEach items="${sensorList}" var="var" varStatus="vs">
										<tr>
											<td class="center">${var.node}</td>
											<td class="center">${var.number}</td>
											<td class="center">${var.name}</td>
											<td class="center">${var.type}</td>
											<td class="center">${var.location}</td>
											<td class="center">${var.coordinate}</td>
											<c:if test="${pd.itype==3 }">
												<td class="center">${var.mobile}</td>
											</c:if>
											<c:if test="${pd.itype==2 or pd.itype==4}">
												<td class="center">${var.power}</td>
											</c:if>
											<c:if test="${pd.itype==1 or pd.itype==2 or pd.itype==4}">
												<td class="center">${var.lamp}</td>
											</c:if>	
											<c:if test="${pd.itype==3}">
												<td class="center">${var.sensor}</td>
											</c:if>
											<td class="center">${var.pole}</td>
											<td class="center">${var.polenumber}</td>
											<td class="center">${var.comment}</td>
											<td class="center" style="width:50px;">
												<c:if test="${QX.edit != 1 && QX.del != 1 }">
												<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="ace-icon fa fa-lock" title="<%=no_permission%>"></i></span>
												</c:if>
												<div class="hidden-sm hidden-xs btn-group">
													<c:if test="${QX.edit == 1 }">
													<a class="btn btn-xs btn-success" onclick="edit('${var.id}');"><%=edit%></a>
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
								<a class="btn btn-sm btn-success" onclick="add();"><%=add2%></a>
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
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<script type="text/javascript">
		$(top.hangge());

		//检索
		function tosearch(){
			top.jzts();
			$("#Form").submit();
		}

		//新增
		function add(){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="<%=add2%>";
			 diag.URL = '<%=basePath%>sensor/goSensorCreate';
			 diag.Width = 650;
			 diag.Height = 640;
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



		//修改
		function edit(Id){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="<%=edit%>";
			 diag.URL = '<%=basePath%>sensor/goSensorEdit?id='+Id;
			 diag.Width = 650;
			 diag.Height = 624;
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 nextPage(${page.currentPage});
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
		
		//打开上传excel页面
		function fromExcel(Id){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="<%=importt%>";
			 diag.URL = '<%=basePath%>sensor/goUploadExcel?gateway_id='+Id;
			 diag.Width = 300;
			 diag.Height = 150;
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 if('${page.currentPage}' == '0'){
						 top.jzts();
						 setTimeout("self.location.reload()",100);
					 }else{
						 nextPage(${page.currentPage});
					 }
				}
				diag.close();
			 };
			 diag.show();
		}	
		</script>

</body>
</html>
