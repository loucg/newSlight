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
<!-- jsp文件头和头部 -->
<%@ include file="../../system/index/top.jsp"%>
<%@ include file="../../international.jsp"%>
<script type="text/javascript">
	//保存
	function save(){
			if($("#name").val()==""){
				$("#name").tips({
					side:3,
		            msg:'<%=enter_function_key_here %>',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#name").focus();
				return false;
			}
			if($("#value").val()==""){
				$("#value").tips({
					side:3,
		            msg:'<%=enter_function_values_here %>',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#value").focus();
				return false;
			}
			if($("#type").val()==""){
				$("#type").tips({
					side:3,
		            msg:'<%=enter_function_classification_here %>',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#type").focus();
				return false;
			}
			if($("#explain").val()==""){
				$("#explain").tips({
					side:3,
		            msg:'<%=enter_function_Brief_here %>',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#explain").focus();
				return false;
			}
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
	}
</script>
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

					<form action="collocation/${msg }" name="Form" id="Form" method="post">
						<input type="hidden" name="id" id="id" value="${pd.ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:96px;text-align: right;padding-top: 13px;"><%=function_key %>:</td>
								<td><input style="width:95%;" type="text" name="name" id="name" value="${pd.NAME}" maxlength="500" placeholder="<%=enter_function_key_here %>" title="<%=function_key %>"/></td>
							</tr>
							<tr>
								<td style="width:96px;text-align: right;padding-top: 13px;"><%=function_value %>:</td>
								<td><input style="width:95%;" type="text" name="value" id="value" value="${pd.VALUE}" maxlength="500" placeholder="<%=enter_function_values_here %>" title="<%=function_value %>"/></td>
							</tr>
							<tr>
								<td style="width:96px;text-align: right;padding-top: 13px;"><%=functional_classification %>:</td>
								<td><input style="width:95%;" type="text" name="type" id="type" value="${pd.TYPE}" maxlength="500" placeholder="<%=enter_function_classification_here %>" title="<%=functional_classification %>"/></td>
							</tr>
							<tr>
								<td style="width:96px;text-align: right;padding-top: 13px;"><%=function_Brief %>:</td>
								<td><input style="width:95%;" type="text" name="explain" id="explain" value="${pd.EXPLAIN}" maxlength="500" placeholder="<%=enter_function_Brief_here %>" title="<%=function_Brief %>"/></td>
							</tr>
							<tr>
								<td style="text-align: center;" colspan="10">
									<a class="btn btn-mini btn-primary" onclick="save();"><%=save %></a>
									<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();"><%=cancel %></a>
								</td>
							</tr>
						</table>
						</div>
						<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green"><%=committing %></h4></div>
					</form>

					</div>
					<!-- /.col -->
				</div>
				<!-- /.row -->
			</div>
			<!-- /.page-content -->
		</div>
	</div>
</div>
<!-- 页面底部js¨ -->
<%@ include file="../../system/index/foot.jsp"%>
<!-- ace scripts -->
<script src="static/ace/js/ace/ace.js"></script>
<!-- ace scripts -->
<script src="static/ace/js/ace/ace.js"></script>
<!--提示框-->
<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<script type="text/javascript">
	$(top.hangge());
	</script>
</body>
</html>
