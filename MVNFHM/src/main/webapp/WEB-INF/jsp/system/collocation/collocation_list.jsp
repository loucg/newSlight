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
<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">
<!-- 下拉框 -->
<link rel="stylesheet" href="static/ace/css/chosen.css" />
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

						<!-- 检索  -->
						<form action="collocation/list.do" method="post" name="Form" id="Form">
						<input type="hidden" id="excel" name="excel" value="0"/>
						<input type="hidden" name="itype" id="itype" value="4">
						<table style="margin-top:5px;">
							<tr>
								
								<td>
									<div class="nav-search">
									    <label><%=function_key %>：</label>
										<input class="nav-search-input" autocomplete="off" id="functionkey" type="text" name="functionkey" value="${pd.functionkey}" placeholder="<%=enter_function_key_here %>" />
									</div>
								</td>
								<td >
								 	<div class="nav-search">
									    <label style="margin-left:12px;"><%=functional_classification %>：</label>
										<input class="nav-search-input" autocomplete="off" id="functiontype" type="text" name="functiontype" value="${pd.functiontype }" placeholder="<%=enter_function_classification_here %>" />
									</div>
								</td>
								<c:if test="${QX.cha == 1 }"><td style="vertical-align:top;padding-left:2px;"><button class="btn btn-light btn-xs" onclick="search();"  title="<%=search2 %>"><i id="nav-search-icon" class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i></button></td></c:if>
							</tr>
						</table>
						<!-- 检索  -->

						<table id="simple-table" class="table table-striped table-bordered table-hover"  style="margin-top:5px;">
							<thead>
								<tr>
									<th class="center" style="width:50px;"><%=number %></th>
									<th class="center" ><%=function_key %></th>
									<th class="center" ><%=function_value %></th>
									<th class="center" ><%=functional_classification %></th>
									<th class="center" ><%=function_Brief %></th>
									<th class="center" ><%=operate %></th>
								</tr>
							</thead>

							<tbody>

							<!-- 开始循环 -->
							<c:choose>
								<c:when test="${not empty varList}">
									<c:if test="${QX.cha == 1 }">
									<c:forEach items="${varList}" var="var" varStatus="vs">
										<tr>
													<td class='center' style="width: 30px;">${vs.index+1+(page.currentPage-1)*page.showCount}</td>
													<td class="center">${var.NAME}</td>
													<td class="center">${var.VALUE}</td>
													<td class="center">${var.TYPE}</td>
													<td class="center">${var.EXPLAIN}</td>
													<!--  <td class="center">${var.CREATETIME}</td>
													<td style="width: 60px;" class="center">
														<c:if test="${var.STATUS == '2' }"><span class="label label-important arrowed-in">无效</span></c:if>
														<c:if test="${var.STATUS == '1' }"><span class="label label-success arrowed">有效</span></c:if>
													</td>
													-->
											<td class="center">
												<div class='hidden-phone visible-desktop btn-group'>
													<c:if test="${QX.edit != 1 && QX.del != 1 }">
													<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="ace-icon fa fa-lock" title="<%=no_permission %>"></i></span>
													</c:if>
													<c:if test="${QX.edit == 1 }">
													<a style="cursor:pointer;" class="green" onclick="edit('${var.ID}');" title="<%=modify %>">
														<i class="ace-icon fa fa-pencil bigger-130"></i>
													</a>
													</c:if>

												</div>
											</td>
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
								<c:if test="${QX.add == 1 }">
								<a class="btn btn-sm btn-success" onclick="add();"><%=add2 %></a>
								</c:if>
							</td>
							<td style="vertical-align:top;"><div class="pagination" style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div></td>
						</tr>
					</table>
					</div>
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
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<!-- 删除时确认窗口 -->
	<script src="static/ace/js/bootbox.js"></script>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<script type="text/javascript">
		$(top.hangge());

		//检索
		function search(){
			top.jzts();
			$("#Form").submit();
		}

		//新增
		function add(){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="<%=add2 %>";
			 diag.URL = '<%=basePath%>collocation/goAdd';
			 diag.Width = 650;
			 diag.Height = 270;
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 if('${page.currentPage}' == '0'){
						 top.jzts();
						 setTimeout("self.location=self.location",100);
					 }else{
						 nextPage('${page.currentPage}');
					 }
				}
				diag.close();
			 };
			 diag.show();
		}

		//修改
		function edit(Id, type){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="<%=modify %>";
			 diag.URL = '<%=basePath%>collocation/goEdit.do?id='+Id;
			 diag.Width = 650;
			 diag.Height = 270;
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 nextPage('${page.currentPage}');
				}
				diag.close();
			 };
			 diag.show();
		}

		//打开上传excel页面
		function fromExcel(){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="EXCEL 导入到数据库";
			 diag.URL = '<%=basePath%>config/goUploadExcel?type=1';
			 diag.Width = 300;
			 diag.Height = 150;
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 if('${page.currentPage}' == '0'){
						 top.jzts();
						 setTimeout("self.location.reload()",100);
					 }else{
						 nextPage('${page.currentPage}');
					 }
				}
				diag.close();
			 };
			 diag.show();
		}
		
		//导出excel
		function toExcel(){
			$("#excel").val("1");
			$("#Form").submit();
		}
		</script>

</body>
</html>
