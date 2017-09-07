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
	<%@ include file="../../system/index/top.jsp"%>
	<!-- jsp国际化文件 -->
<%@ include file="../../international.jsp"%>
	<!-- 日期框 -->
	<link rel="stylesheet" href="static/ace/css/datepicker.css" />
	<!-- 时间 -->
	<link rel="stylesheet" href="static/ace/css/bootstrap-timepicker.css" />
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
					
					<form action="grouplamp/${msg }.do?DATA_IDS=${pd.DATA_IDS}" name="strategyForm" id="strategyForm" method="post">
						<input type="hidden" value="no" id="hasTp1" />
						<div id="zhongxin" style="padding-top: 13px;">
						
						<table style="margin-top:5px;">
							<tr>
								<td>&nbsp;&nbsp;<%=choose_strategy %>：</td>
								<td style="vertical-align:top;padding-left:20px;"> 
								</td>
								<td>
									<select name="str_id" id="str_id" value="${str.tname }" onchange="change1(this.value)">
		                                <option><%=please_choose %></option>     					 
		                          	</select>
								</td>
								
							</tr>
						</table>
						
						 <table id="simple-table" class="table table-striped table-bordered table-hover" style="margin-top:5px;">	
							<thead>
								<tr>
									<th class="center" style="width: 80px;"><%=strategy %> </th>
									<th class="center"><%=time_and_brightness %></th> 
								</tr>
							</thead>
													
							<tbody>
							<!-- 开始循环 -->	
							<c:choose>
								<c:when test="${not empty strategyList}">
									<c:if test="${QX.cha == 1 }">
									<c:forEach items="${strategyList}" var="strategy" varStatus="vs">
											<td class="center">${strategy.name }</td>
											<td class="center"  >
											<table class="table-striped table-bordered table-hover" height=100% width=100% border=1>
											<c:choose>
											<c:when test="${not empty strategy.timestamp}">
											<c:forEach items="${strategy.timestamp}" var="timestamp" varStatus="vs1">
											<tr>
											<td class="center" width=50%>${timestamp}</td>
											<td class="center" width=50%>${strategy.intensity[vs1.index]}%</td>
											</tr>
											</c:forEach>
											</c:when>
											</c:choose>
											</table>
											</td>
										<%-- <tr>
											<td class="center"  >
												<c:choose>
													<c:when test="${not empty strategy.timestamp}">
														<c:forEach items="${strategy.timestamp}" var="timestamp" varStatus="vs1">
															<tr>
																<td class="center" width=50%>${timestamp}</td>
																<td class="center" width=50%>${strategy.intensity[vs1.index]}</td>
															</tr>
														</c:forEach>
													</c:when>
												</c:choose>
											</td> 
										</tr> --%>
									
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
							
							
						<table id="table_report" class="table table-striped table-bordered table-hover">	
							<tr>
								<td style="text-align: center;" colspan="10">
									<a class="btn btn-mini btn-primary" onclick="save();"><%=save %></a>
									<!-- <a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a> -->
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
	<%@ include file="../../system/index/foot.jsp"%>
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	<!-- 时间 -->
	<script src="static/ace/js/date-time/bootstrap-timepicker.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	
	<script type="text/javascript">
		$(top.hangge());
		
		
		//初始第一级
		$(function() {
			$.ajax({
				type: "POST",
				url: '<%=basePath%>grouplamp/getLevels.do?tm='+new Date().getTime(),
		    	data: {},
				dataType:'json',
				cache: false,
				success: function(data){
					$("#str_id").html('<option><%=please_choose %></option>');
					 $.each(data.list, function(i, dvar){
							$("#str_id").append("<option value="+dvar.str_id+">"+dvar.str_name+"</option>");
					 });
				}
			});
		});
		
		
		//第一级值改变事件(加载数据时间和亮度)
		function change2(value){
			top.jzts();
			$("#strategyForm").submit(); 
			/* $("#zhongxin2").show();
			$("#zhongxin").hide(); */ 
		} 
		
		//保存
		function save(){
			 $.each(function(i, list){
					nextPage('${page.currentPage}');
			 	});
				$("#zhongxin").hide();
				$("#zhongxin2").show();
				top.Dialog.close();
			
		}
		
		function change1(value){
			alert(value);
			$.ajax({
				type: "POST",
				url: '<%=basePath%>grouplamp/adjustStr.do',
				success: function(data2){
					alert(data2);
				}
			})
			/* $("#zhongxin2").show();
			$("#zhongxin").hide(); */ 
		} 
		
		function change3(value){
			alert("准备查看策略详情");
			location.href("grouplamp/adjustStr");
			alert("已经获得策略详情");
			/* $("#zhongxin2").show();
			$("#zhongxin").hide(); */ 
		} 
		
		
  
	</script>
</body>
</html>