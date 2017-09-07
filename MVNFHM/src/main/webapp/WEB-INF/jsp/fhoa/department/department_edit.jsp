<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
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
					
					<form action="department/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="ID" id="ID" value="${pd.ID}"/>
						<input type="hidden" name="companyid" id="companyid" value="${pd.companyid}"/>
						<%-- <input type="hidden" name="PARENT_ID" id="PARENT_ID" value="${null == pd.PARENT_ID ? DEPARTMENT_ID:pd.PARENT_ID}"/> --%>
						<div id="zhongxin">
						<table id="table_report" class="table table-striped table-bordered table-hover" style="margin-top:15px;">
						<c:if test="${msg == 'edit'}">
						<tr>
								<td style="width:79px;text-align: right;padding-top: 13px;"><%=superior_department %>:</td>
								<td>
									<div class="col-xs-4 label label-lg label-light arrowed-in arrowed-right">
										<%-- <b>${null == pd.SUPERIOR_DEPARTMENT_ID ?'<%=none_this_department_is_top %>':pds.NAME}</b> --%>
										<b>
										<c:if test="${null == pd.SUPERIOR_DEPARTMENT_ID}"><%=none_this_department_is_top %></c:if>
										<c:if test="${null != pd.SUPERIOR_DEPARTMENT_ID}">${pds.NAME}</c:if>
										</b>
									</div>
								</td>
							</tr>
						</c:if>
							<tr>
								<td style="width:79px;text-align: right;padding-top: 13px;"><%=department_name %>:</td>
								<td><input type="text" name="NAME" id="NAME" value="${pd.NAME}" maxlength="50" placeholder="<%=enter_the_department_name_here %>" title="<%=department_name %>" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:79px;text-align: right;padding-top: 13px;"><%=superior_department %>:</td>
								<td style="vertical-align:top;padding-left:2px;">
								 	<select class="chosen-select form-control" name="SUPERIOR_DEPARTMENT_ID" id="SUPERIOR_DEPARTMENT_ID" data-placeholder="<%=please_choose_the_superior_department %>" style="vertical-align:top;width: 120px;">
									<option value=""><%=none %></option>
									<c:forEach items="${varList}" var="superdepart">
									<c:if test="${superdepart.ID!=pd.ID}">
										<option value="${superdepart.ID }" <c:if test="${pd.SUPERIOR_DEPARTMENT_ID==superdepart.ID}">selected="selected"</c:if>>${superdepart.NAME }</option>
									</c:if>
									</c:forEach>
								  	</select>
								</td>
							</tr>
							<tr>
								<td style="width:79px;text-align: right;padding-top: 13px;"><%=status %>:</td>
								<td style="vertical-align:top;padding-left:2px;">
								<select class="chosen-select form-control" name="STATUS" id="STATUS" data-placeholder="<%=please_choose_status %>" style="vertical-align:top;width: 120px;">
									<option value="1" <c:if test="${pd.STATUSNAME=='有效'}">selected="selected"</c:if>><%=effective %></option>
									<option value="2" <c:if test="${pd.STATUSNAME=='无效'}">selected="selected"</c:if>><%=invalid %></option>
								  	</select>
								  </td>
							</tr>
							<tr>
								<td style="width:70px;text-align: right;padding-top: 13px;"><%=department_description %>:</td>
								<td>
									<textarea rows="3" cols="46" name="EXPLAIN" id="EXPLAIN" placeholder="<%=enter_the_department_here %>" title="<%=department_description %>"  style="width:98%;">${pd.EXPLAIN}</textarea>
								</td>
							</tr>
							<tr>
								<td class="center" colspan="10">
									<a class="btn btn-mini btn-primary" onclick="save();"><%=save %></a>
									<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();"><%=cancel %></a>
								</td>
							</tr>
						</table>
						</div>
						
						<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green"><%=committing %></h4></div>
						
					</form>
	
					<div id="zhongxin2" class="center" style="display:none"><img src="static/images/jzx.gif" style="width: 50px;" /><br/><h4 class="lighter block green"></h4></div>
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
	<%@ include file="../../system/index/foot.jsp"%>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
		<script type="text/javascript">
		$(top.hangge());
		//保存
		function save(){
			if($("#NAME").val()==""){
				$("#NAME").tips({
					side:3,
		            msg:'<%=please_enter_department_name %>',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#NAME").focus();
			return false;
		}
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
			
		}
		
		//判断编码是否存在
		function hasBianma(){
			var BIANMA = $.trim($("#BIANMA").val());
			if("" == BIANMA)return;
			$.ajax({
				type: "POST",
				url: '<%=basePath%>department/hasBianma.do',
		    	data: {BIANMA:BIANMA,tm:new Date().getTime()},
				dataType:'json',
				cache: false,
				success: function(data){
					 if("success" == data.result){
					 }else{
						$("#BIANMA").tips({
							side:1,
				            msg:'编码'+BIANMA+'已存在,重新输入',
				            bg:'#AE81FF',
				            time:5
				        });
						$('#BIANMA').val('');
					 }
				}
			});
		}
		</script>
</body>
</html>