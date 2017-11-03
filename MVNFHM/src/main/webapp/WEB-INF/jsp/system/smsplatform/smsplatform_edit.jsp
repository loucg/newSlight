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
							<div id="zhongxin" style="padding-top: 13px;">
							<table id="table_report" class="table table-striped table-bordered table-hover">
								<tr>
									<td style="width:100px;text-align: right;padding-top: 13px;"><%=sms_platform_name %>:</td>
									<td><input type="text" name="NAME" id="NAME" value="${pd.name}" maxlength="32" style="width:99%;" placeholder="<%=please_enter_sms_platform_name %>" title="<%=company_name %>"/></td>
								</tr>
								<tr>
									<td style="width:100px;text-align: right;padding-top: 13px;"><%=sms_platform_data %>:</td>
									<td><input type="text" name="B_NOTE_URL" id="B_NOTE_URL" value="${pd.b_note_url}" maxlength="120" style="width:99%;" placeholder="<%=please_enter_sms_platform_data %>" title="<%=sms_platform_data %>"/></td>
								</tr>
								<tr>
									<td style="width:100px;text-align: right;padding-top: 13px;"><%=sms_platform_contact %>:</td>
									<td><input type="text" name="CONTACT" id="CONTACT" value="${pd.contact}" maxlength="120" style="width:99%;" placeholder="<%=enter_company_contact_here %>" title="<%=sms_platform_contact %>"/></td>
								</tr>
								<tr>
									<td style="width:100px;text-align: right;padding-top: 13px;"><%=status %>:</td>
									<td>
									<select class="chosen-select form-control" name="STATUS" id="STATUS" data-placeholder="<%=please_choose_status %>" style="vertical-align:top;width: 120px;">
									<option value="1" <c:if test="${pd.status=='1'}">selected="selected"</c:if>><%=effective %></option>
									<option value="2" <c:if test="${pd.status=='2'}">selected="selected"</c:if>><%=invalid %></option>
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
			if($("#NAME").val()==""){
			$("#NAME").tips({
				side:3,
	            msg:'<%=please_enter_sms_platform_name%>',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#NAME").focus();
			return false;
		}
			if($("#B_NOTE_URL").val()==""){
				$("#B_NOTE_URL").tips({
					side:3,
		            msg:'<%=please_enter_sms_platform_data %>',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#B_NOTE_URL").focus();
				return false;
			}
			if($("#CONTACT").val()==""){
				$("#CONTACT").tips({
					side:3,
		            msg:'<%=please_enter_contact %>',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#CONTACT").focus();
				return false;
			}
		
		if($("#STATUS").val()==""){
			$("#STATUS").tips({
				side:3,
	            msg:'<%=please_choose_status %>',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#STATUS").focus();
			return false;
		}
		$("#Form").submit();
		$("#zhongxin").hide();
		$("#zhongxin2").show();
	}
	
</script>
</body>
</html>