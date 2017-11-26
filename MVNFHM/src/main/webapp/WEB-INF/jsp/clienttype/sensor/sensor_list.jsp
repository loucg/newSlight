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
						<form action="clienttype/getSensorList" method="post" name="Form" id="Form">
						<input type="hidden" id="excel" name="excel" value="0"/>
						<input type="hidden" id="tagFlg" name="tagFlg" value="${tagFlg }"/>
								<table style="margin-top: 5px;">
									<tr>
										<td style = "width:400px">&nbsp;</td>
										<td>
											<ul id="myTab" class="nav nav-tabs">
												<li id = "gatewayTag"><a href="#gateway" onclick="goALLList('1');"
													data-toggle="tab"><%=gateway_type %></a></li>
												<!-- <li id = "breakerTag" style="padding-left: 20px;"><a href="#breaker" onclick="goALLList('2');"
													data-toggle="tab">断路器类型</a></li> -->
												<li id = "sensorTag" style="padding-left: 20px;"><a href="#sensor" onclick="goALLList('3');"
													data-toggle="tab"><%=sensor_type %></a></li>
												<li id = "clientTag" style="padding-left: 20px;"><a href="#client" onclick="goALLList('4');"
													data-toggle="tab"><%=lamp_type %></a></li>
											</ul>
										</td>
										<c:if test="${QX.cha == 1 }">
											<c:if test="${QX.toExcel == 1 }">
												<td style="padding-left: 2px;"><a
													class="btn btn-light btn-xs" onclick="toExcel();"
													title="<%=export_to_excel%>"><i id="nav-search-icon"
														class="ace-icon fa fa-download bigger-110 nav-search-icon white"></i></a></td>
											</c:if>
											<c:if test="${QX.FromExcel == 1 }">
												<td style="padding-left: 2px;"><a
													class="btn btn-light btn-xs" onclick="fromExcel();"
													title="<%=importt%>"><i id="nav-search-icon"
														class="ace-icon fa fa-cloud-upload bigger-110 nav-search-icon white"></i></a></td>
											</c:if>
										</c:if>
									</tr>
								</table>
								<!-- 检索  -->

						<table id="simple-table" class="table table-striped table-bordered table-hover"  style="margin-top:5px;">
							<thead>
								<tr>
									<th class="center" style="width: 50px;"><%=number%></th>
									<th class="center"><%=standard%>/<%=name%></th>
									<th class="center"><%=image%></th>
								    <th class="center"><%=status%></th>
								    <th class="center"><%=max_voltage%></th>
								    <th class="center"><%=max_current%></th>
								    <th class="center"><%=set_voltage%></th>
								    <th class="center"><%=set_current%></th>
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

											<td class='center' style="width: 30px;">${vs.index+1}</td>
											<td class="center">${var.name}</td>
											<td class="center">
												<c:if test="${var.image!=null&&var.image!=''}">
													<img src="<%=basePath%>uploadFiles/uploadImgs/${var.image}" width="100">
												</c:if>
											</td>											
											<td class="center"><c:if test="${var.status == '1'}">有效</c:if><c:if test="${var.status == '2'}">无效</c:if></td>
											<td class="center">${var.Vmax}</td>
								    		<td class="center">${var.Imax}</td>
								   			<td class="center">${var.Vset}</td>
								    		<td class="center">${var.Iset}</td>									
											<td class="center">${var.explain}</td>
											<td class="center" style="width:100px;">
												<c:if test="${QX.edit != 1 && QX.del != 1 }">
												<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="ace-icon fa fa-lock" title="<%=no_permission%>"></i></span>
												</c:if>
												<div class="hidden-sm hidden-xs btn-group">
													<c:if test="${QX.edit == 1 }">
														<a style="cursor: pointer;"
															onclick="edit('${var.id}');" class="tooltip-success"
															data-rel="tooltip" title="<%=modify %>"> <span
															class="green"> <i
																class="ace-icon fa fa-pencil-square-o bigger-120"></i>
														</span>
														</a>
													</c:if>
													<c:if test="${QX.del == 1 }">
														<a style="cursor: pointer;"
															onclick="del('${var.id}');" class="tooltip-error"
															data-rel="tooltip" title="删除"> <span class="red">
																<i class="ace-icon fa fa-trash-o bigger-120"></i>
														</span>
														</a>
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
							<td style="vertical-align:top;">
								<c:if test="${QX.add == 1 }">
								<a class="btn btn-sm btn-success" onclick="add();"><%=add2%></a>
								</c:if>

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

		function goALLList(flg){
			top.jzts();
			if(flg == 1){
				window.location.href="<%=basePath%>clienttype/getGatewayList";
			} else if (flg == 2){
				window.location.href="<%=basePath%>clienttype/getBreakerList";
			} else if (flg == 3){
				window.location.href="<%=basePath%>clienttype/getSensorList";
			} else if (flg == 4){
				window.location.href="<%=basePath%>clienttype/getLampList";
			} else {
				window.location.href="<%=basePath%>clienttype/getGatewayList";
			}
		}
		
		//新增
		function add(){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="<%=add2%>";
			 diag.URL = '<%=basePath%>clienttype/goSensorCreate';
			 diag.Width = 650;
			 diag.Height = 424;
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
		function edit(Id){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="<%=edit%>";
			 diag.URL = '<%=basePath%>clienttype/goSensorEdit?id='+Id;
			 diag.Width = 650;
			 diag.Height = 424;
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 nextPage('${page.currentPage}');
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
					var url = '<%=basePath%>clienttype/deleteSensor.do?id='+Id+'&tm='+new Date().getTime();
					$.get(url,function(data){
						if("success" == data.result){
							nextPage(${page.currentPage});
						}else if("false" == data.result){
							top.hangge();
							bootbox.dialog({
								message: "<span class='bigger-110'>删除失败！这个传感器类型正在使用中.</span>",
								buttons: 			
								{
									"button" :
									{
										"label" : "确定",
										"className" : "btn-sm btn-success"
									}
								}
							});
						}
					});
				}
			});
		}

		//导出excel
		function toExcel(){
			$("#excel").val("1");
			$("#Form").submit();
			$("#excel").val("0");
		}
		
		//打开上传excel页面
		function fromExcel(){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="<%=importt%>";
			 diag.URL = '<%=basePath%>clienttype/goSensorUploadExcel';
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
		$(function(){
			if('${tagFlg}' == '1'){
				$('#gatewayTag').addClass("active");
			} else if ('${tagFlg}' == '2'){
				$('#breakerTag').addClass("active");
			}else if ('${tagFlg}' == '3'){
				$('#sensorTag').addClass("active");
			}else if ('${tagFlg}' == '4'){
				$('#clientTag').addClass("active");
			}
		})
		</script>

</body>
</html>
