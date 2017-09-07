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

<script type="text/javascript">

	//保存
	function save(){
		if($("#iccid").val()==""){
		$("#iccid").tips({
			side:3,
						msg:'<%=please_enter_iccid%>',
						bg:'#AE81FF',
						time:2
				});
		$("#iccid").focus();
		return false;
	}
			if($("#mobile").val()==""){
			$("#mobile").tips({
				side:3,
	            msg:'<%=please_enter_phone%>',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#mobile").focus();
			return false;
		}
		hasK();
	}
	//判断关键词是否存在
	function hasK(){
		var iccid = $("#iccid").val();
		var mobile =  $("#mobile").val();
		$.ajax({
			type: "POST",
			url: '<%=basePath%>textmsg/hasK.do',
	    	data: {iccid:iccid,mobile:mobile,tm:new Date().getTime()},
			dataType:'json',
			cache: false,
			success: function(data){
				 if("success" == data.result){
					$("#Form").submit();
					$("#zhongxin").hide();
					$("#zhongxin2").show();
				 }else{
					$("#mobile").tips({
						side:3,
			            msg:'此SIM卡已存在(全局)!',
			            bg:'#AE81FF',
			            time:3
			        });
					return false;
				 }
			}
		});
	}
	function setType(value){
		$("#type").val(value);
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

					<form action="sim/${msg}" name="Form" id="Form" method="post">
						<input type="hidden" name="id" id="id" value="${pd.id}"/>
						<input type="hidden" name="type" id="type" value="${pd.type}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:79px;text-align: right;padding-top: 13px;">ICCID:</td>
								<td><input style="width:95%;" type="text" name="iccid" id="iccid" value="${pd.iccid}" maxlength="500" placeholder="ICCID" title="ICCID"/></td>
							</tr>
							<tr>
								<td style="width:79px;text-align: right;padding-top: 13px;"><%=phone_number%>:</td>
								<td><input style="width:95%;" type="text" name="mobile" id="mobile" value="${pd.mobile}" maxlength="500" placeholder="mobile" title="mobile"/></td>
							</tr>
							<tr>
								<td style="width:79px;text-align: right;padding-top: 13px;"><%=type%>:</td>
								<td>
									<label style="float:left;padding-left: 12px;"><input class="ace" name="form-field-radio" id="form-field-radio1" onclick="setType('1');" <c:if test="${pd.type == '1' }">checked="checked"</c:if> type="radio" value="icon-edit"><span class="lbl"><%=jiebu%></span></label>
									<label style="float:left;padding-left: 5px;"><input class="ace"  name="form-field-radio" id="form-field-radio2" onclick="setType('2');" <c:if test="${pd.type == '2' }">checked="checked"</c:if> type="radio" value="icon-edit"><span class="lbl"><%=self_prepare%></span></label>
								</td>
								</tr>
								<tr>
								<td style="width:79px;text-align: right;padding-top: 13px;"><%=status%>:</td>
								<td>
									<select class="chosen-select form-control" name="status" id="status" data-placeholder="<%=please_choose_status%>" style="float:left;width:95%;">
										<option value="1" <c:if test="${pd.status==1}">selected</c:if>><%=test%></option>
										<option value="2" <c:if test="${pd.status==2}">selected</c:if>><%=wait_start_use%></option>
										<option value="3" <c:if test="${pd.status==3}">selected</c:if>><%=normal%></option>
										<option value="4" <c:if test="${pd.status==4}">selected</c:if>><%=arrears%></option>
										<option value="5" <c:if test="${pd.status==5}">selected</c:if>><%=stop_mobile%></option>
										<option value="6" <c:if test="${pd.status==6}">selected</c:if>><%=unregister_mobile%></option>
								  	</select>
								 </td>
								</tr>

							<tr>
								<td style="width:79px;text-align: right;padding-top: 13px;"><%=comment%>:</td>
								<td><input style="width:95%;" type="text" name="comment" id="comment" value="${pd.comment}" maxlength="500" title="<%=comment%>"/></td>
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
