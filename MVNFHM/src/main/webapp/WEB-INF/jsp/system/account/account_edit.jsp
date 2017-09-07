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
<%@include file="../../international.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">
<!-- 下拉框 -->
<link rel="stylesheet" href="static/ace/css/chosen.css" />
<!-- jsp文件头和头部 -->
<%@ include file="../index/top.jsp"%>
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
								<form action="account/${msg }.do" name="accountForm" id="accountForm" method="post">
									<input type="hidden" name="USER_ID" id="user_id" value="${pd.USER_ID }"/>
									<div id="zhongxin" style="padding-top: 9px;">
									<table id="table_report" class="table table-striped table-bordered table-hover">
										<tr>
											<td style="width:79px;text-align: right;padding-top: 4px;"><span style="color:red;">*</span><%=company_name %>:</td>
											<td id="gongsi">
											<select class="chosen-select form-control" name="COMPANY" id="company" data-placeholder="<%=please_choose_company %>" title="<%=company_name %>" style="vertical-align:top;width:98%;" onchange="change1(this.value)" >
											<option value=""><%=please_choose_company %></option>
											<c:forEach items="${companyList}" var="company">
												<option value="${company.COMPANY}" <c:if test="${company.NAME == pd.COMPANY }">selected</c:if>>${company.NAME}</option>
											</c:forEach>
											</select>
											</td>
										</tr>
										<tr>
											<td style="width:79px;text-align: right;padding-top: 4px;"><span style="color:red;">*</span><%=department_name %>:</td>
											<td id="bumen">
											<select class="chosen-select form-control" name="DEPARTMENT" id="department" data-placeholder="<%=please_choose_department %>" title="<%=department_name %>" style="vertical-align:top;width:98%;" >
											<option value=""><%=please_choose_department %></option>
											<c:forEach items="${departmentList}" var="department">
												<option value="${department.ID}" <c:if test="${department.NAME == pd.DEPARTMENT }">selected</c:if>>${department.NAME}</option>
											</c:forEach>
											</select>
											</td>
										</tr>
										<tr>
											<td style="width:79px;text-align: right;padding-top: 4px;"><span style="color:red;">*</span><%=log_name %>:</td>
											<td><input type="text" name="USERNAME" id="username" value="${pd.USERNAME }" maxlength="32" placeholder="<%=enter_this_log_name_here %>" title="<%=log_name %>" style="width:98%;"/></td>
										</tr>
										<tr>
											<td style="width:79px;text-align: right;padding-top: 4px;"><span style="color:red;">*</span><%=person_name %>:</td>
											<td><input type="text" name="NAME" id="name"  value="${pd.NAME }"  maxlength="32" placeholder="<%=enter_person_name_here %>" title="<%=person_name %>" style="width:98%;"/></td>
										</tr>
										<tr>
											<td style="width:79px;text-align: right;padding-top: 4px;"><%=contact_address %>:</td>
											<td><input type="text" name="ADDRESS" id="address"  value="${pd.ADDRESS }"  maxlength="32" placeholder="<%=enter_contact_address_here %>" title="<%=contact_address %>" style="width:98%;"/></td>
										</tr>
										<tr>
											<td style="width:79px;text-align: right;padding-top: 4px;"><span style="color:red;">*</span><%=phone %>:</td>
											<td><input type="number" name="PHONE" id="phone"  value="${pd.PHONE }"  maxlength="32" placeholder="<%=enter_phone_number_here %>" title="<%=phone %>" style="width:98%;"/></td>
										</tr>
										<tr>
											<td style="width:79px;text-align: right;padding-top: 4px;"><%=email %>:</td>
											<td><input type="email" name="EMAIL" id="email"  value="${pd.EMAIL }" maxlength="32" placeholder="<%=enter_email_here %>" title="<%=email %>" style="width:98%;"/></td>
										</tr>
										<tr>
											<td style="width:79px;text-align: right;padding-top: 4px;"><%=position %>:</td>
											<td><input type="text" name="POSITION" id="position"  value="${pd.POSITION }"  maxlength="32" placeholder="<%=enter_position_here %>" title="<%=position %>" style="width:98%;"/></td>
										</tr>
										<tr>
											<td style="width:79px;text-align: right;padding-top: 4px;"><span style="color:red;">*</span><%=language1 %>:</td>
											<td id="yuyan">
											<select class="chosen-select form-control" name="LANGUAGE_ID" id="language_id" data-placeholder="<%=please_choose_language %>" title="<%=language1 %>" style="vertical-align:top;width:98%;" >
											<option value=""><%=please_choose_language %></option>
											<c:forEach items="${languageList}" var="language">
												<option value="${language.id }" <c:if test="${language.id == pd.LANGUAGE_ID }">selected</c:if>>${language.name }</option>
											</c:forEach>
											</select>
											</td>
										</tr>
										<tr>
											<td style="width:79px;text-align: right;padding-top: 4px;"><span style="color:red;">*</span><%=charactor %>:</td>
											<td id="juese">
											<select class="chosen-select form-control" name="ROLE_ID" id="role_id" data-placeholder="<%=please_choose_charactor %>" title="<%=charactor %>" style="vertical-align:top;width:98%;" >
											<option value=""><%=please_choose_charactor %></option>
											<c:forEach items="${roleList}" var="role">
												<option value="${role.ROLE_ID }" <c:if test="${role.ROLE_ID == pd.ROLE_ID }">selected</c:if>>${role.ROLE_NAME }</option>
											</c:forEach>
											</select>
											</td>
										</tr>
										<tr>
											<td style="width:79px;text-align: right;padding-top: 4px;"><span style="color:red;">*</span><%=status %>:</td>
											<td id="zhuangtai">
											<select class="chosen-select form-control" name="STATUS_ID" id="status_id" data-placeholder="<%=please_choose_status %>" title="<%=status %>" style="vertical-align:top;width:98%;" >
											<option value=""><%=please_choose_status %></option>
											<c:forEach items="${statusList}" var="status">
												<option value="${status.value }" <c:if test="${status.value == pd.STATUS_ID }">selected</c:if>>${status.name }</option>
											</c:forEach>
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
									<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green"><%=committing %>...</h4></div>
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
	<%@ include file="../index/foot.jsp"%>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<!-- inline scripts related to this page -->
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
</body>
<script type="text/javascript">
	$(top.hangge());
	
	$(document).ready(function(){
		if($("#user_id").val()!=""){
			//默认不能修改的数据
			$("#username").attr("readonly","readonly");
			$("#username").css("color","gray");
		}
	});
	
	//第一级值改变事件(初始第二级)
	function change1(value){
		$.ajax({
			type: "POST",
			url: '<%=basePath%>account/getLevels.do?tm='+new Date().getTime(),
	    	data: {COMPANY_ID:value},
			dataType:'json',
			cache: false,
			success: function(data){
				$("#department").html('<option value=""><%=please_choose_department %></option>');
				 $.each(data.list, function(i, dvar){
						$("#department").append("<option value="+dvar.ID+">"+dvar.NAME+"</option>");
				 });
			}
		});
	}
	
	$(document).ready(function(){
		if($("#user_id").val()!=""){
			$("#loginname").attr("readonly","readonly");
			$("#loginname").css("color","gray");
		}
	});
	//保存
	function save(){
		//公司判断
		if($("#company").val()==""){
			$("#company").tips({
				side:3,
	            msg:'<%=please_choose_company %>',
	            bg:'#AE81FF',
	            time:3
	        });
			$("#company").focus();
			return false;
		}
		//部门判断
		if($("#department").val()==""){
			$("#department").tips({
				side:3,
	            msg:'<%=please_choose_department %>',
	            bg:'#AE81FF',
	            time:3
	        });
			$("#department").focus();
			return false;
		}
		
		/* if($("#username").val()=="" || $("#username").val()=="此登录名已存在!"){
			$("#username").tips({
				side:3,
	            msg:'输入登录名',
	            bg:'#AE81FF',
	            time:3
	        });
			$("#username").focus();
			$("#username").val('');
			$("#username").css("background-color","white");
			return false;
		}else{
			$("#username").val(jQuery.trim($('#username').val()));
		} */
		//登录名判断
		if($("#username").val()==""){
			$("#username").tips({
				side:3,
	            msg:'<%=enter_this_log_name_here %>',
	            bg:'#AE81FF',
	            time:3
	        });
			$("#username").focus();
			return false;
		}else{
			var re = /^[a-zA-z]\w{3,15}$/;
		    if(!re.test($("#username").val())){
		    	$("#username").tips({
					side:3,
		            msg:'<%=login_name_contain_letter_number_4_16 %>',
		            bg:'#AE81FF',
		            time:3
		        });
				$("#username").focus();
				return false;
		    }
		}
		/* else if(escape($("#username").val()).indexOf("%u") >= 0){
			$("#username").tips({
				side:3,
	            msg:'登录名不能含有汉字',
	            bg:'#AE81FF',
	            time:3
	        });
			$("#username").focus();
			return false;
		} */
		//else
		//{
		//	hasU();
		//	$("#username").val(jQuery.trim($('#username').val()));		
		//}
		//姓名判断
		if($("#name").val()==""){
			$("#name").tips({
				side:3,
	            msg:'<%=enter_person_name_here %>',
	            bg:'#AE81FF',
	            time:3
	        });
			$("#name").focus();
			return false;
		}else{
			// [\u4e00-\u9fa5]汉字编码范围 
			var checkC = new RegExp("^[\u4e00-\u9fa5]{1,10}$");
			var checkE = new RegExp("^[a-zA-Z ]{1,20}$");
			if (!checkC.test($("#name").val())&&!checkE.test($("#name").val())){
				//alert(!checkC.test($("#name").val()));
				//alert(!checkE.test($("#name").val()));
				$("#name").tips({
					side:3,
		            msg:'<%=type_wrong_name_check_special %>',
		            bg:'#AE81FF',
		            time:3
		        });
				$("#name").focus(); 
				return false; 
				} 
		}
		//手机判断
		var myreg = /^1[3|4|5|8][0-9]\d{4,8}$/;
		if($("#phone").val()==""){
			$("#phone").tips({
				side:3,
	            msg:'<%=enter_phone_number_here %>',
	            bg:'#AE81FF',
	            time:3
	        });
			$("#phone").focus();
			return false;
		}else if($("#phone").val().length != 11 && !myreg.test($("#phone").val())){
			$("#phone").tips({
				side:3,
	            msg:'<%=phone_number_type_not_correct %>',
	            bg:'#AE81FF',
	            time:3
	        });
			$("#phone").focus();
			return false;
		}
		//邮箱判断
		if($("#email").val()!=""){
			if(!ismail($("#email").val())){
			$("#email").tips({
				side:3,
	            msg:'<%=email_type_not_correct %>',
	            bg:'#AE81FF',
	            time:3
	        });
			$("#email").focus();
			return false;
		}
		}
		//语言判断
		if($("#language_id").val()==""){
			$("#yuyan").tips({
				side:3,
	            msg:'<%=please_choose_language %>',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#language_id").focus();
			return false;
		}
		//角色判断
		if($("#role_id").val()==""){
			$("#juese").tips({
				side:3,
	            msg:'<%=please_choose_charactor %>',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#role_id").focus();
			return false;
		}
		//状态判断
		if($("#status_id").val()==""){
			$("#zhuangtai").tips({
				side:3,
	            msg:'<%=please_choose_status %>',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#status_id").focus();
			return false;
		}
		
		/*
		if($("#address").val()==""){
			$("#address").tips({
				side:3,
	            msg:'输入联系地址',
	            bg:'#AE81FF',
	            time:3
	        });
			$("#address").focus();
			return false;
		}*/
		
		/*
		if($("#email").val()==""){
			$("#email").tips({
				side:3,
	            msg:'输入邮箱',
	            bg:'#AE81FF',
	            time:3
	        });
			$("#email").focus();
			return false;
		}
		*/
		if($("#user_id").val()==""){ //新增帐号无user_id
			hasU();
		}else{
			$("#accountForm").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}
	}
	function ismail(mail){
		return(new RegExp(/^(?:[a-zA-Z0-9]+[_\-\+\.]?)*[a-zA-Z0-9]+@(?:([a-zA-Z0-9]+[_\-]?)*[a-zA-Z0-9]+\.)+([a-zA-Z]{2,})+$/).test(mail));
		}
	
	//判断用户名是否存在
	function hasU(){
		var USERNAME = $.trim($("#username").val());
		$.ajax({
			type: "POST",
			url: '<%=basePath%>account/hasU.do',
	    	data: {USERNAME:USERNAME},
			dataType:'json',
			cache: false,
			success: function(data){
				 if("success" == data.result){
					$("#accountForm").submit();
					$("#zhongxin").hide();
					$("#zhongxin2").show();
				 }else{
					//$("#username").css("background-color","#D16E6C");
					//setTimeout("$('#username').val('此用户名已存在!')",500);
					 $("#username").tips({
							side:3,
				            msg:'<%=this_login_name_has_exist %>',
				            bg:'#AE81FF',
				            time:3
				        });
						$("#username").focus();
				 }
			}
		});
	}
	
	<%-- //判断邮箱是否存在
	function hasE(USERNAME){
		var EMAIL = $.trim($("#EMAIL").val());
		$.ajax({
			type: "POST",
			url: '<%=basePath%>user/hasE.do',
	    	data: {EMAIL:EMAIL,USERNAME:USERNAME,tm:new Date().getTime()},
			dataType:'json',
			cache: false,
			success: function(data){
				 if("success" != data.result){
					 $("#EMAIL").tips({
							side:3,
				            msg:'邮箱 '+EMAIL+' 已存在',
				            bg:'#AE81FF',
				            time:3
				        });
					 $("#EMAIL").val('');
				 }
			}
		});
	} --%>
	
	<%-- //判断编码是否存在
	function hasN(USERNAME){
		var NUMBER = $.trim($("#NUMBER").val());
		$.ajax({
			type: "POST",
			url: '<%=basePath%>user/hasN.do',
	    	data: {NUMBER:NUMBER,USERNAME:USERNAME,tm:new Date().getTime()},
			dataType:'json',
			cache: false,
			success: function(data){
				 if("success" != data.result){
					 $("#NUMBER").tips({
							side:3,
				            msg:'编号 '+NUMBER+' 已存在',
				            bg:'#AE81FF',
				            time:3
				        });
					 $("#NUMBER").val('');
				 }
			}
		});
	} --%>
	/*
	$(function() {
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
	*/
</script>
</html>