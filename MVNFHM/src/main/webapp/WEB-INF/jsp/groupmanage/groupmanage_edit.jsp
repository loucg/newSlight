<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
	<head>
	<base href="<%=basePath%>">
	<!-- 下拉框 -->
	<link rel="stylesheet" href="static/ace/css/chosen.css" />
	<!-- jsp文件头和头部 -->
	<%@ include file="../system/index/top.jsp"%>
	<!-- jsp国际化文件 -->
	<%@ include file="../international.jsp"%>
	<script type="text/javascript" src="static/ace/js/jquery.js"></script>
	<!-- 上传插件 -->
	<link href="plugins/uploadify/uploadify.css" rel="stylesheet" type="text/css">
	<script type="text/javascript" src="plugins/uploadify/swfobject.js"></script>
	<script type="text/javascript" src="plugins/uploadify/jquery.uploadify.v2.1.4.min.js"></script>
	<!-- 上传插件 -->
	<script type="text/javascript">
	var jsessionid = "<%=session.getId()%>";  //勿删，uploadify兼容火狐用到
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
					
					<form action="group/${msg }.do" name="groupForm" id="groupForm" method="post">
						<input type="hidden" value="no" id="hasTp1" />
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr style="display:none">
						   		 <td><input type="text" name="id" id="id" value="${pd.id }" /></td>
						    </tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;"><%=name %>:</td>
								<td><input type="text" name="name" id="name" value="${pd.name }" maxlength="100" title="<%=name %>" style="width:98%;" /></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;"><%=summary %>:</td>
								<td><input type="text" name="explain" id="explain" value="${pd.explain }" maxlength="100" title="<%=summary %>" style="width:98%;" /></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;"><%=status %>:</td>
								<td>
									<select name="status" maxlength="100" title="<%=status %>" style="width:98%;">
										<option value="1" <c:if test="${pd.status == '1' }">selected</c:if> ><%=effective %></option>
										<option value="2" <c:if test="${pd.status == '2' }">selected</c:if> ><%=invalid %></option>
									</select>
								</td>
							</tr>
							
							<tr>
								<td style="text-align: center;" colspan="10">
									<a class="btn btn-mini btn-primary" onclick="save();"><%=save %></a>
									<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();"><%=cancel %></a>
								</td>
							</tr>
						</table>
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
</div>
<!-- /.main-container -->


	<!-- 页面底部js¨ -->
	<%@ include file="../system/index/foot.jsp"%>
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
		<script type="text/javascript">
		$(top.hangge());
		
		//保存
		function save(){
			
			if($("#name").val()==""){
				$("#name").tips({
					side:3,
		            msg:'<%=please_enter_group_name %>',
		            bg:'#AE81FF',
		            time:3
		        });
				$("#name").focus();
				return false;
			}
			if($("#explain").val()==""){
				$("#explain").tips({
					side:3,
		            msg:'<%=please_enter_summry %>',
		            bg:'#AE81FF',
		            time:3
		        });
				$("#explain").focus();
				return false;
			}else{
				$("#groupForm").submit();
				$("#zhongxin").hide();
				$("#zhongxin2").show();
			}
			
		}
		

			//清除空格
		String.prototype.trim=function(){
		     return this.replace(/(^\s*)|(\s*$)/g,'');
		};
		</script>
</body>
</html>