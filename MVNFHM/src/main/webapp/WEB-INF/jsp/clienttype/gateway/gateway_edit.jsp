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
		if($("#name_CH").val()==""){
			$("#name_CH").tips({
				side:3,
	            msg:'<%=please_input_ch_name%>',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#name_CH").focus();
			return false;
		}
		if($("#name_EN").val()==""){
			$("#name_EN").tips({
				side:3,
	            msg:'<%=please_input_en_name%>',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#name_EN").focus();
			return false;
		}
		if($("#Vmax").val()==""){
			$("#Vmax").tips({
				side:3,
	            msg:'<%=please_input_max_vol%>',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#Vmax").focus();
			return false;
		}
		if($("#Imax").val()==""){
			$("#Imax").tips({
				side:3,
	            msg:'<%=please_input_max_curr%>',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#Imax").focus();
			return false;
		}
		if($("#Vset").val()==""){
			$("#Vset").tips({
				side:3,
	            msg:'<%=please_input_set_vol%>',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#Vset").focus();
			return false;
		}
		if($("#Iset").val()==""){
			$("#Iset").tips({
				side:3,
	            msg:'<%=please_input_set_curr%>',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#Iset").focus();
			return false;
		}
		hasK();
	}
	//判断关键词是否存在
	function hasK(){
		var name = $("#name").val();
		var id = "${pd.id}";
		$.ajax({
			type: "POST",
			url: '<%=basePath%>textmsg/hasK.do',
	    	data: {name:name,id:id,tm:new Date().getTime()},
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

					<form action="clienttype/${msg }" name="Form" id="Form" method="post">
						<input type="hidden" name="id" id="id" value="${pd.id}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:100px;text-align: right;padding-top: 13px;"><%=name_ch%>:</td>
								<td><input style="width:95%;" type="text" name="name_CH" id="name_CH" value="${pd.name_CH}" maxlength="64" title="名称_中文"/></td>
							</tr>
							<tr>
								<td style="width:100px;text-align: right;padding-top: 13px;"><%=name_en%>:</td>
									<td><input style="width:95%;" type="text" name="name_EN" id="name_EN" value="${pd.name_EN}" maxlength="64" title="名称_英文"/></td>
							</tr>
							<tr>
								<td style="width:100px;text-align: right;padding-top: 13px;"><%=status%>:</td>
								<td>
									<select class="chosen-select form-control" name="status" id="status" data-placeholder="<%=please_choose_status %>" style="vertical-align:top;width: 120px;">
										<option value="1" <c:if test="${pd.status=='1'}">selected="selected"</c:if>><%=effective %></option>
										<option value="2" <c:if test="${pd.status=='2'}">selected="selected"</c:if>><%=invalid %></option>
								  	</select>
								</td>
							</tr>
							<tr>
								<td style="width:100px;text-align: right;padding-top: 13px;"><%=max_voltage%>:</td>
								<td><input style="width:95%;" type="text" name="Vmax" id="Vmax" value="${pd.Vmax}" maxlength="64" title="<%=standard%>/<%=name%>"/></td>
							</tr>
							<tr>
								<td style="width:100px;text-align: right;padding-top: 13px;"><%=max_current%>:</td>
								<td><input style="width:95%;" type="text" name="Imax" id="Imax" value="${pd.Imax}" maxlength="64" title="<%=standard%>/<%=name%>"/></td>
							</tr>
							<tr>
								<td style="width:100px;text-align: right;padding-top: 13px;"><%=set_voltage%>:</td>
								<td><input style="width:95%;" type="text" name="Vset" id="Vset" value="${pd.Vset}" maxlength="64" title="<%=standard%>/<%=name%>"/></td>
							</tr>
							<tr>
								<td style="width:100px;text-align: right;padding-top: 13px;"><%=set_current%>:</td>
								<td><input style="width:95%;" type="text" name="Iset" id="Iset" value="${pd.Iset}" maxlength="64" title="<%=standard%>/<%=name%>"/></td>
							</tr>
							<tr>
								<td style="width:100px;text-align: right;padding-top: 13px;"><%=comment%>:</td>
								<td><input style="width:95%;" type="text" name="explain" id="explain" value="${pd.explain}" maxlength="255"  title="<%=comment%>"/></td>
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
