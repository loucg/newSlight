<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
<!-- 下拉框 -->
<link rel="stylesheet" href="static/ace/css/chosen.css" />
<!-- jsp文件头和头部 -->
<%@ include file="../../system/index/top.jsp"%>
<!-- jsp国际化文件 -->
<%@ include file="../../international.jsp"%>
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
							
						<!-- 检索  -->
						<form action="repair/changeGateway" method="post" name="Form" id="Form">
						<!-- 检索  -->
						<input type="hidden" name="faultId" id="faultId" value="${pd.id}">
						<input type="hidden" name="gatewayId" id="gatewayId" value="">
						<input type="hidden" name="faultGatewayid" id="faultGatewayid" value="${pd.faultGatewayid}">
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="simple-table" class="table table-striped table-bordered table-hover" style="margin-top:5px;">
							<thead>
								<tr>
									<th class="center" style="width:35px;">
									<!-- <label class="pos-rel"><input type="checkbox" class="ace" id="zcheckbox" /><span class="lbl"></span></label> -->
									</th>
									<%-- <th class="center" style="width:50px;"><%=number %></th> --%>
									<th class="center"><%=gateway_number%></th>
									<th class="center"><%=gateway_name%></th>
									<th class="center"><%=gateway_type %></th>
									<th class="center"><%=location %></th>
								</tr>
							</thead>
													
							<tbody>
							<!-- 开始循环 -->	
							<c:choose>
								<c:when test="${not empty repairableGatewayList}">
									<c:if test="${QX.cha == 1 }">
									<c:forEach items="${repairableGatewayList}" var="gateway" varStatus="vs">
										<tr>
											<td class='center'>
												<label class="pos-rel"><input type='radio' name='ids' value="${gateway.c_gateway_id}" class="ace" /><span class="lbl"></span></label>
											</td>
											<td class='center'>${gateway.gateway_code}</td>
											<td class='center'>${gateway.name}</td>
											<td class='center'>
												<c:if test="${sessionScope.session_language=='zh_CN' }">
															${gateway.name_CH}
											    </c:if>
												<c:if test="${sessionScope.session_language=='en_US' }">
															${gateway.name_EN}
												</c:if>
											</td>
											<td class='center'>${gateway.location}</td>
										</tr>
									</c:forEach>
									</c:if>
									<c:if test="${QX.cha == 0 }">
										<tr>
											<td colspan="100" class="center"><%=you_have_no_permission %></td>
										</tr>
									</c:if>
								</c:when>
								<c:otherwise>
									<tr class="main_info">
										<td colspan="100" class="center" ><%=no_relevant_data %></td>
									</tr>
								</c:otherwise>
							</c:choose>
							</tbody>
						</table>
						<div class="page-header position-relative">
						<table style="width:100%;">
							<tr>
								<td style="vertical-align:top;">
									<c:if test="${QX.edit == 1 }">
									<a class="btn btn-sm btn-success" 
										onclick="changeGateway('<%=make_sure_change_gateway %>?');" title="<%=change_gateway %>" ><%=change_gateway %></a>
									</c:if>
								</td>
								<td style="vertical-align:top;"><div class="pagination" style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div></td>
							</tr>
						</table>
						</div>
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
		<!-- /.main-content -->

		<!-- 返回顶部 -->
		<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
			<i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
		</a>

	</div>
	<!-- /.main-container -->

	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../../system/index/foot.jsp"%>
	<!-- 删除时确认窗口 -->
	<script src="static/ace/js/bootbox.js"></script>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<script type="text/javascript">
		$(top.hangge());//关闭加载状态
		//检索
		function tosearch(){
			top.jzts();
			$("#Form").submit();
		}
		//批量操作
		function changeGateway(msg){
			bootbox.confirm(msg, function(result) {
				if(result) {
					var gatewayId = '';
					for(var i=0;i < document.getElementsByName('ids').length;i++)
					{
						  if(document.getElementsByName('ids')[i].checked){
							  gatewayId = document.getElementsByName('ids')[i].value;
							  $("#gatewayId").val(gatewayId);
							  $("#Form").submit();
							  $("#zhongxin").hide();
							  $("#zhongxin2").hide();
							  top.Dialog.close();
							  break;
						  }
					}
					if(gatewayId==''){
						bootbox.dialog({
							message: "<span class='bigger-110'><%=you_have_not_choose_anything %>!</span>",
							buttons: 			
							{ "button":{ "label":"<%=make_sure %>", "className":"btn-sm btn-success"}}
						});
						$("#zcheckbox").tips({
							side:3,
				            msg:'<%=click_this_choose_all %>"',
				            bg:'#AE81FF',
				            time:8
				        });
						return;
					}
				}
			});
		}	
		
		
		//查看灯的详细信息
		function viewLampDetail(id){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="<%=detail %>";
			 diag.URL = '<%=basePath%>state/lamp/goViewDetail.do?id='+id; 
			 diag.Width = 800;
			 diag.Height = 320;
			 diag.CancelEvent = function(){ //关闭事件
				diag.close();
			 };
			 diag.show();
		}
		
	</script>


</body>
</html>