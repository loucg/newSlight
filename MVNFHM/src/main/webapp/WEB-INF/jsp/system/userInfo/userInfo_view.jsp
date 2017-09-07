<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">
<!-- 下拉框 -->
<link rel="stylesheet" href="static/ace/css/chosen.css" />
<!-- jsp文件头和头部 -->
<%@ include file="../index/top.jsp"%>
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
								<table id="simple-table"
									class="table table-striped table-bordered table-hover"
									style="margin-top: 5px;">
									<thead>
										<tr>
											<th class="center">登录名</th>
											<th class="center">密码</th>
											<th class="center">姓名</th>
											<th class="center">手机</th>
											<th class="center">邮箱</th>
											<th class="center">联系地址</th>
											<th class="center">职务</th>
											<th class="center">公司</th>
											<th class="center">语言</th>
											<th class="center">操作</th>
										</tr>
									</thead>
									<tbody>
										<c:choose>
											<c:when test="${not empty userInfo}">
														<tr>
															<td class="center">${userInfo.USERNAME }</td>
															<td class="center">${userInfo.PASSWORD }</td>
															<td class="center">${userInfo.NAME }</td>
															<td class="center">${userInfo.PHONE }</td>
															<td class="center">${userInfo.EMAIL }</td>
															<td class="center">${userInfo.ADDRESS }</td>
															<td class="center">${userInfo.POSITION }</td>
															<td class="center">${userInfo.COMPANY }</td>
															<td class="center">${userInfo.LANGUAGE}</td>
															<td class="center">
																<div class="hidden-sm hidden-xs btn-group">
																		<a class="btn btn-xs btn-success" title="修改"
																			onclick="editUserInfo('${userInfo.USER_ID}');"> <i
																			class="ace-icon fa fa-pencil-square-o bigger-120"
																			title="修改"></i>
																		</a>
																</div>
															</td>
														</tr>
											</c:when>
										</c:choose>
									</tbody>
								</table>
						</div>
					</div>
				</div>
				<!-- /.page-content -->
			</div>
		</div>
		<!-- /.main-content -->
	</div>
	<!-- /.main-container -->
	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../index/foot.jsp"%>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
</body>
<script type="text/javascript">
$(top.hangge());
//修改
function editUserInfo(user_id){
	 top.jzts();
	 var diag = new top.Dialog();
	 diag.Drag=true;
	 diag.Title ="资料";
	 diag.URL = '<%=basePath%>userInfo/goEditUserInfo.do?USER_ID='+user_id;
	 diag.Width = 469;
	 diag.Height = 510;
	 diag.CancelEvent = function(){ //关闭事件
		 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
		window.location.reload();//刷新当前页面
		 }
		diag.close();
	 };
	 diag.show();
}
</script>
</html>
