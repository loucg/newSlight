<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
						<form action="smsplatform/${msg}.do" name="Form" id="Form" method="post">
							<input type="hidden" name="id" id="id" value="${pd.id}"/>
							<input type="hidden" name="b_note_id" id="b_note_id" value="${pd.b_note_id}"/>
							<div id="zhongxin" style="padding-top: 13px;">
							<table id="table_report" class="table table-striped table-bordered table-hover">
								<tr>
									<td style="width:100px;text-align: right;padding-top: 13px;"><%=equipment_type %>:</td>
									<td><select onchange="changeFaultType(this.value);" class="chosen-select form-control" name="device_type" id="device_type" data-placeholder="<%=please_enter_repair_person%>" style="height:30px;width: 160px;border-width:1px;border-color:'#fff';border-radius:4px">
											<option value="1" <c:if test="${1==pd.device_type}">selected="selected"</c:if>><%=gateway %></option>
											<option value="2" <c:if test="${2==pd.device_type}">selected="selected"</c:if>><%=node %></option>
								    </select>
								    </td>
								</tr>
								<tr>
									<td style="width:100px;text-align: right;padding-top: 13px;"><%=fault_type %>:</td>
									<td id ="gatewayFaultList" style = "display: none">
										<select class="chosen-select form-control" name="gateway_fault_type" id="gateway_fault_type" style="height:30px;width: 160px;border-width:1px;border-color:'#fff';border-radius:4px">
										<c:forEach items="${gatewayStatus}" var="gs">
											<option value="${gs.value}" <c:if test="${gs.value==pd.fault_type}">selected="selected"</c:if>>${gs.name}</option>
										</c:forEach>
								    </select>
									</td>
									<td id ="nodeFaultList" style = "display: none">
										<select class="chosen-select form-control" name="node_fault_type" id="node_fault_type" style="height:30px;width: 160px;border-width:1px;border-color:'#fff';border-radius:4px">
										<c:forEach items="${nodeStatus}" var="ns">
											<option value="${ns.value}" <c:if test="${ns.value==pd.fault_type}">selected="selected"</c:if>>${ns.name}</option>
										</c:forEach>
								    </select>
									</td>
								</tr>
								<tr>
									<td style="width:100px;text-align: right;padding-top: 13px;"><%=location %>:</td>
									<td><input type="text" name="location" id="location" value="${pd.location}" maxlength="255" style="width:99%;" placeholder="<%=please_input_device_address %>" /></td>
								</tr>
								<tr>
									<td style="width:100px;text-align: right;padding-top: 13px;"><%=remind_admin %>:</td>
									<td>
								  		<input type="checkbox" id="send_to_admin" name="send_to_admin" value = "1" <c:if test="${pd.send_to_admin == '1'}">checked</c:if>/>
									</td>
								</tr>
								<tr>
									<td style="width:100px;text-align: right;padding-top: 13px;"><%=sms_destination %>:</td>
									<td>
									<select class="chosen-select form-control" name="send_to_person" id="send_to_person" data-placeholder="<%=please_enter_repair_person%>" style="height:30px;width: 160px;border-width:1px;border-color:'#fff';border-radius:4px">
										<option value="" <c:if test="${pd.send_to_person!=''}">style="display:none"</c:if>><%=please_input_sms_to_who%></option>
										<c:forEach items="${userList}" var="user">
											<option value="${user.USER_ID}" <c:if test="${user.USER_ID==pd.send_to_person}">selected="selected"</c:if>>${user.NAME}</option>
										</c:forEach>
								    </select>
							    </td>
								</tr>
								<tr>
									<td style="text-align: center;" colspan="2">
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
	<!-- /.main-content -->
</div>
<!-- /.main-container -->

<!-- basic scripts -->
<!-- 页面底部js¨ -->
<%@ include file="../../system/index/foot.jsp"%>
<!-- ace scripts -->
<script src="static/ace/js/ace/ace.js"></script>
<!-- 上传控件 -->
<script src="static/ace/js/ace/elements.fileinput.js"></script>
<!--提示框-->
<script type="text/javascript" src="static/js/jquery.tips.js"></script>			

<script type="text/javascript">
		$(top.hangge());
		$(function() {
			if(${pd.device_type} == 1){
				$("#gatewayFaultList").show();
				$("#nodeFaultList").hide();
			}
			if(${pd.device_type} == 2){
				$("#gatewayFaultList").hide();
				$("#nodeFaultList").show();
			}
			//上传
			$('#tp').ace_file_input({
				no_file:'<%=please_choose_picture %>',
				btn_choose:'<%=choose %>',
				btn_change:'<%=change %>',
				droppable:false,
				onchange:null,
				thumbnail:false, //| true | large
				whitelist:'gif|png|jpg|jpeg',
				//blacklist:'gif|png|jpg|jpeg'
				//onchange:''
				//
			});
		});
	
	//保存
	function save(){
		if($("#location").val()==""){
			$("#location").tips({
				side:3,
	            msg:'<%=please_input_device_address %>',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#location").focus();
			return false;
		}
		if($("#send_to_person").val()==""){
			$("#send_to_person").tips({
				side:3,
	            msg:'<%=please_input_sms_to_who %>',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#send_to_person").focus();
			return false;
		}
		$("#Form").submit();
		$("#zhongxin").hide();
		$("#zhongxin2").show();
	}
	function changeFaultType(obj){
		if(obj == '1'){
			$("#gatewayFaultList").show();
			$("#nodeFaultList").hide();
		}
		if(obj == '2'){
			$("#gatewayFaultList").hide();
			$("#nodeFaultList").show();
		}
	}
</script>
</body>
</html>