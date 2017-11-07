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
<!-- jsp文件头和头部 -->
<%@ include file="../../system/index/top.jsp"%>
<!-- 下拉框 -->
<script src="static/ace/js/chosen.jquery.js"></script>
<script type="text/javascript">


	//保存
	function save(){
			if($("#number").val()==""){
				$("#number").tips({
					side:3,
		            msg:'<%=please_type_device_number%>',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#number").focus();
				return false;
			}
			if($("#name").val()==""){
				$("#name").tips({
					side:3,
		            msg:'<%=please_type_device_name%>',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#name").focus();
				return false;
			}
			if($("#polenumber").val()==""){
				$("#polenumber").tips({
					side:3,
		            msg:'<%=please_enter_pole_number%>',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#polenumber").focus();
				return false;
			}
			if(($("#longitude").val()<=0||$("longitude").val()>=180)&&$("#longitude").val()!=""){
				$("#longitude").tips({
					side:3,
		            msg:'<%=please_enter_0_180_number%>',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#longitude").focus();
				return false;
			}
			if(($("#latitude").val()<=0||$("#latitude").val()>=90)&&$("#latitude").val()!=""){
				$("#latitude").tips({
					side:3,
		            msg:'<%=please_enter_0_90_number%>',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#latitude").focus();
				return false;
			}
			hasK();
	}

	//判断关键词是否存在
	function hasK(){
		var name = $("#name").val();
		var COMMAND_ID = "${pd.COMMAND_ID}";
		$.ajax({
			type: "POST",
			url: '<%=basePath%>textmsg/hasK.do',
	    	data: {name:name,COMMAND_ID:COMMAND_ID,tm:new Date().getTime()},
			dataType:'json',
			cache: false,
			success: function(data){
				 if("success" == data.result){
					$("#Form").submit();
					$("#zhongxin").hide();
					$("#zhongxin2").show();
				 }else{
					$("#name").tips({
						side:3,
			            msg:'此关键词已存在(全局)!',
			            bg:'#AE81FF',
			            time:3
			        });
					return false;
				 }
			}
		});
	}
	
	function testNumber(){
		
		var number=$("#number").val();
		var result = $.ajax(
			{
				type:"post",				
				url:"<%=basePath%>sensor/testNumber",
				dataType:"json",
				data:{
						number:number
					},
				success:function(data){
					if(data.count!="0"){
						$("#number_tips").removeAttr("hidden");
					}else{
						$("#number_tips").attr("hidden", "true");
					}
				}
			}		
		);
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
	});
	
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

					<form action="sensor/${msg }" name="Form" id="Form" method="post">
						<input type="hidden" name="id" id="id" value="${pd.id}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:96px;text-align: right;padding-top: 13px;">*<%=node_address%>:</td>
								<td><input style="width:50%;" type="text" name="node" id="node" value="${pd.node}" maxlength="500" readonly="readonly"/>
								</td>
							</tr>
							<tr>
								<td style="width:96px;text-align: right;padding-top: 13px;">*<%=node_number%>:</td>
								<td><input style="width:50%;" type="text" name="number" id="number" value="${pd.number}" maxlength="500" readonly="readonly"/>
								</td>
							</tr>
							<tr>
								<td style="width:96px;text-align: right;padding-top: 13px;">*<%=node_name%>:</td>
								<td><input style="width:95%;" type="text" name="name" id="name" value="${pd.name}" maxlength="500" /></td>
							</tr>
							<tr>
								<td style="width:96px;text-align: right;padding-top: 13px;">*<%=device_type%>:</td>
								<td>
									<select class="chosen-select form-control" name="typeid" id="typeid" data-placeholder="<%=please_choose_device_type%>" style="float:left;width:95%;">
										<c:forEach items="${clientTypeList}" var="cType">
											<option value="${cType.id}" <c:if test="${pd.typeid==cType.id}">selected</c:if>>${cType.name}</option>
										</c:forEach>
								  	</select>
								 </td>
							</tr>

							<tr>
								<td style="width:79px;text-align: right;padding-top: 13px;"><%=location%>:</td>
								<td><input style="width:95%;" type="text" name="location" id="locationE" value="${pd.location}" /></td>
							</tr>
							<tr>
								<td style="width:79px;text-align: right;padding-top: 13px;"><%=longitude%>:</td>
								<td><input style="width:95%;" type="number" name="longitude" id="longitude" value="${pd.longitude}" /></td>
							</tr>
							<tr>
								<td style="width:79px;text-align: right;padding-top: 13px;"><%=latitude%>:</td>
								<td><input style="width:95%;" type="number" name="latitude" id="latitude" value="${pd.latitude}" /></td>
							</tr>
							<!-- 电源类型不再显示
							<tr id="power">
								<td style="width:79px;text-align: right;padding-top: 13px;"><%=power_standard%>:</td>
								<td>
								 	<select class="chosen-select form-control" name="power" id="power" style="float:left;width:95%;">
								 	<option value="">请选择电源类型</option>
									<c:forEach items="${powerList}" var="role">
										<option value="${role.id}" <c:if test="${pd.powerid==role.id}">selected</c:if>>${role.name}</option>
									</c:forEach>
								  	</select>
								</td>
							</tr>
							 -->
							
							<!-- 灯类型不再显示
							<tr id="lamp">
								<td style="width:79px;text-align: right;padding-top: 13px;"><%=light_standard%>:</td>
								<td>
								 	<select class="chosen-select form-control" name="lamp" id="lamp" style="float:left;width:95%;">
								 	<option value="">请选择灯类型</option>
									<c:forEach items="${lampList}" var="role">
										<option value="${role.id}" <c:if test="${pd.lampid==role.id}">selected</c:if>>${role.name}</option>
									</c:forEach>
								  	</select>
								</td>
							</tr>
							 -->
							
							<!-- 传感器不再显示
							<tr id="sensor">
								<td style="width:79px;text-align: right;padding-top: 13px;"><%=sensor_standard%>:</td>
								<td>
								 	<select class="chosen-select form-control" name="sensor" id="sensor" style="float:left;width:95%;">
								 	<option value="">请选择传感器类型</option>
									<c:forEach items="${sensorList}" var="role">
										<option value="${role.id}" <c:if test="${pd.sensor==role.id}">selected</c:if>>${role.name}</option>
									</c:forEach>
								  	</select>
								</td>
							</tr>
							 -->
							<tr>
								<td style="width:79px;text-align: right;padding-top: 13px;"><%=pole%>:</td>
								<td>
								 	<select class="chosen-select form-control" name="pole" id="pole" style="float:left;width:95%;">
								 	<option value="">请选择电线杆类型</option>
									<c:forEach items="${poleList}" var="role">
										<option value="${role.id }" <c:if test="${pd.poleid==role.id}">selected</c:if>>${role.name}</option>
									</c:forEach>
								  	</select>
								</td>
							</tr>
							<tr>
								<td style="width:79px;text-align: right;padding-top: 13px;">*<%=pole_number%>:</td>
								<td><input style="width:95%;" type="text" name="polenumber" id="polenumber" value="${pd.polenumber}" maxlength="500" /></td>
							</tr>
							<tr>
								<td style="width:79px;text-align: right;padding-top: 13px;display:none"><%=password%>:</td>
								<td><input style="width:95%;display:none" type="text" name="password" id="password" value="${pd.password}" maxlength="500"/></td>
							</tr>
							<tr>
								<td style="width:79px;text-align: right;padding-top: 13px;"><%=comment%>:</td>
								<td><input style="width:95%;" type="text" name="comment" id="comment" value="${pd.comment}" maxlength="500" /></td>
							</tr>
							<tr>
								<td style="text-align: center;" colspan="10">
									<a class="btn btn-mini btn-primary" onclick="save();"><%=save%></a>
									<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();"><%=cancel%></a>
								</td>
							</tr>
						</table>
						</div>
						<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green"><%=committing%></h4></div>
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
