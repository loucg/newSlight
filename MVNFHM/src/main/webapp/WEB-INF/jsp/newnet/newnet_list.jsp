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
<%@include file="../international.jsp"%>  <!--国际化标签  -->
<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">
<!-- 下拉框 -->
<link rel="stylesheet" href="static/ace/css/chosen.css" />
<!-- jsp文件头和头部 -->
<%@ include file="../system/index/top.jsp"%>

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
						<form action="newnet/getNewnetList" method="post" name="Form" id="Form">
						<table style="margin-top:5px;">
							<tr>
							   <td>
									<div class="nav-search">
									    <label><%=name%>：</label>
										<input class="nav-search-input" autocomplete="off" id="nav-search-input" type="text" name="name" value="${pd.name}" placeholder="<%=please_enter_name%>" />
									</div>
								</td>
								 <td>
									<div class="nav-search" style="margin-left:8px;">
									    <label><%=serial_number%>：</label>
										<input class="nav-search-input" autocomplete="off" id="nav-search-input" type="text" name="code" value="${pd.code}" placeholder="<%=please_enter_serial_number%>" />
									</div>
								</td>
								<td style="vertical-align:center;padding-left:4px;padding-bottom:4px;"><button class="btn btn-mini btn-light" onclick="search();"  title="<%=search1%>"><i id="nav-search-icon" class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i></button></td>
							</tr>
						</table>
						<!-- 检索  -->
					
						<table id="simple-table" class="table table-striped table-bordered table-hover"  style="margin-top:5px;">
							<thead>
								<tr>
									<th class="center"><%=gateway_number%></th>
									<th class="center"><%=gateway_name%></th>
									<th class="center"><%=gateway_location%></th>
									<th class="center"><%=comment%></th>
									<th class="center"><%=device_counter%></th>
									<th class="center"><%=work_status%></th>
									<th class="center"><%=operate%></th>
									 
								</tr>
							</thead>
													
							<tbody>
								
							<!-- 开始循环 -->	
							<c:choose>
								<c:when test="${not empty newnetList}">
									<c:if test="${QX.cha == 1 }">
									<c:forEach items="${newnetList}" var="var" varStatus="vs">
										<tr>
													<td class="center">${var.code}</td>
													<td class="center">${var.name}</td>								 
													<td class="center">${var.location}</td>
													<td class="center">${var.comment}</td>
													<td class="center"><a style="cursor:pointer;" onclick="delCrew('${var.id}');">${var.number}</a></td>
													<td class="center">
														<c:if test="${var.status == '1' }"><span class="label label-important arrowed-in"><%=normal%></span></c:if>
														<c:if test="${var.status == '2' }"><span class="label label-success arrowed"><%=exception%></span></c:if>
														<c:if test="${var.status == '3' }"><span class="label label-success arrowed"><%=blockout%></span></c:if>
													</td> 
											 <td class="center">
											 <div class="hidden-sm hidden-xs btn-group">
													<c:if test="${QX.edit == 1 }">
													<a class="btn btn-xs btn-success" onclick="addCrew('${var.id}');">
														<%=add_device%>
													</a>
													</c:if>
													<c:if test="${QX.del == 1 }">
													<a class="btn btn-xs btn-danger" onclick="delCrew('${var.id}');">
														<%=delete_device%>
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
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<script type="text/javascript">
		$(function(){
			top.hangge();
			if(${pd.first}==1){
				bootbox.confirm("<%=add_device_tips%>", function(result) {
				});
			}
		})
		
		//检索
		function search(){
			top.jzts();
			$("#Form").submit();
		}
			
		//添加终端
		function addCrew(id){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="<%=add_device%>";
			 diag.URL = '<%=basePath%>newnet/goClientList?id='+id;
			 diag.Width = 1200;
			 diag.Height = 600;
			 diag.Modal = true;				//有无遮罩窗口
			 diag. ShowMaxButton = true;	//最大化按钮
		     diag.ShowMinButton = true;		//最小化按钮
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
		
		//踢删终端
		function delCrew(id){
			top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="<%=delete_device%>";
			 diag.URL = '<%=basePath%>newnet/goOwnClientList?id='+id;
			 diag.Width = 1200;
			 diag.Height = 600;
			 diag.Modal = true;				//有无遮罩窗口
			 diag. ShowMaxButton = true;	//最大化按钮
		     diag.ShowMinButton = true;		//最小化按钮
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
	
		
		</script>
		
</body>
</html>

