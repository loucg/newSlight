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
	<!-- 下拉框 -->
	<link rel="stylesheet" href="static/ace/css/chosen.css" />
	<!-- jsp文件头和头部 -->
	<%@ include file="../system/index/top.jsp"%>
	<%@ include file="../international.jsp"%>
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
					<form action="gomap/goPartMap.do" name="Form" id="Form" method="post">
						<div id="zhongxin" style="padding-top: 13px;">
					<table id="simple-table" class="table table-striped table-bordered table-hover" style="margin-top:5px;">	
							<thead>
								<tr>
								
									<th class="center" style="width:50px;"><%=number %></th>
									<th class="center"><%=name %></th>
									<th class="center"><%=coordidate %></th>
									<th class="center"><%=terminal_Num %></th>
<%-- 									<th class="center"><%=ctrl_strategy %></th>s --%>
									<th class="center"><%=picture %></th>
									<th class="center" style="width: 100px;"><%=operate %></th>
								</tr>
							</thead>
							<tbody>
							<c:choose>
							<c:when test="${not empty varList}">
									<c:forEach items="${varList}" var="var" varStatus="vs">
										<tr>
									
											<td class='center' style="width: 30px;">${vs.index+1}<input type='hidden' name="hdstrategyIds" value="${group.strategy_num}"/></td>
											<td class='center'>${var.partmap_name}<input type='hidden' name="hdgroupname" value="${var.partmap_name}"/></td>
											<td class='center' style="width: 50px;">${var.external_coordinate}</td>
											<td class='center'>${var.clinetCnt}</td>
											<td class='center'><img src="<%=basePath%>uploadFiles/uploadImgs/partmap/${var.map_pictrue_path}" width="100" height=50px></td>
											<td class='center'>
											<a class="btn btn-xs btn-danger" onclick="edit('${var.external_coordinate}','${var.ID}');">
												修改	
											</a>
											<a class="btn btn-xs btn-success" onclick="del('${var.ID}');">
														删除
											</a>
											
											</td>
											
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr class="main_info">
										<td colspan="100" class="center" ><%=no_relevant_data %></td>
									</tr>
								</c:otherwise>
								</c:choose>
								<c:if test="${QX.cha == 0 }">
										<tr>
											<td colspan="100" class="center"><%=you_have_no_permission %></td>
										</tr>
								</c:if>
							</tbody>
							
						</table>
						</div>
						
						<div class="page-header position-relative">
						<table style="width:100%;">
							<tr>
								<td style="vertical-align:top;">
<%-- 									<c:if test="${QX.add == 1 }"> --%>
									<a class="btn btn-mini btn-success" onclick="add();"  onmouseover="this.style.cursor='hand'"><%=confirm %></a>
									<td style="vertical-align:top;"><div class="pagination" style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div></td>
<%-- 									</c:if> --%>
								</td>
							</tr>
						</table>
						</div>
						<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green">提交中...</h4></div>
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
		function add(){
			window.parent.window.frames["mainFrame"].frames["page_347"].frames["Conframe"].document.getElementById('mapclick').click();
			window.parent.window.frames["mainFrame"].frames["page_347"].frames["Conframe"].document.getElementById('addPartMapFlag').value= '1';
			top.Dialog.close(); 
  		}
		//删除组
		function del(partmapID){

			 if(confirm("确定要删除局部地图吗？")){
				 $.ajax({
						url : "gomap/delPartMapInfo",
						type : "POST",
						data : {
								ID:partmapID
						},
						dataType : "json",
						success : function(data) {
							if("success" == data.result){
								 nextPage('${page.currentPage}');
									 $("#zhongxin").hide();
									$("#zhongxin2").show();
					    		    //top.Dialog.close(); 
								}
						}
					});
				 window.parent.window.frames["mainFrame"].frames["page_347"].frames["Conframe"].document.getElementById('partMapID').value=partmapID
				 window.parent.window.frames["mainFrame"].frames["page_347"].frames["Conframe"].document.getElementById('clearMarker').click();
			 }
		}
		
		function edit(xycoordinate,partmapID){
			window.parent.window.frames["mainFrame"].frames["page_347"].frames["Conframe"].document.getElementById('partMapID').value=partmapID;
			window.parent.window.frames["mainFrame"].frames["page_347"].frames["Conframe"].document.getElementById('MarkerXYCoordinate').value=xycoordinate;
			window.parent.window.frames["mainFrame"].frames["page_347"].frames["Conframe"].document.getElementById('openMarker').click();
			top.Dialog.close();
	}
		
		</script>
</body>
</html>