<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
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

							<!-- 检索  -->
							<form action="smsplatform/gosms.do" method="post" name="Form"
								id="Form">
								<%-- 		<table id="simple-table1" class="table table-striped table-bordered table-hover" style="margin-top:5px; margin-bottom:-6px">	
							<thead>
								<tr>
									<th class="center" style="width:100%;">${companyname}</th>
								</tr>
							</thead>
							</table> --%>
								<table id="simple-table"
									class="table table-striped table-bordered table-hover"
									style="margin-top: 5px; border: 0">
									<thead>
										<tr>
											<th class="center" style="width: 50px;"><%=number%></th>
											<th class="center"><%=sms_platform_name%></th>
											<th class="center"><%=sms_platform_data%></th>
											<th class="center"><%=sms_platform_contact%></th>
											<th class="center"><%=status%></th>
											<th class="center"><%=operate%></th>
										</tr>
									</thead>

									<tbody>
										<!-- 开始循环 -->
										<c:choose>
											<c:when test="${not empty varList}">
												<c:if test="${QX.cha == 1 }">
													<c:forEach items="${varList}" var="var" varStatus="vs">
														<tr>
															<td class='center' style="width: 30px;">${vs.index+1}</td>
															<td class='center'>${var.NAME}</td>
															<td class='center'>${var.NAME}</td>
															<td class='center'>${var.NAME}</td>
															<td class='center'>${var.STATUSNAME}</td>
															<td class="center"><c:if
																	test="${QX.edit != 1 && QX.del != 1 }">
																	<span
																		class="label label-large label-grey arrowed-in-right arrowed-in"><i
																		class="ace-icon fa fa-lock"
																		title="<%=no_permission%>"></i></span>
																</c:if>
																<div class="hidden-sm hidden-xs btn-group">
																	<c:if test="${QX.edit == 1 }">
																		<a class="btn btn-xs btn-success" title="<%=edit %>"
																			onclick="edit('${var.ID}');"> <i
																			class="ace-icon fa fa-pencil-square-o bigger-120"
																			title="<%=edit%>"></i>
																		</a>
																	</c:if>
																	<%-- 	<c:if test="${QX.del == 1 }">
													<a class="btn btn-xs btn-danger" onclick="del('${var.DEPARTMENT_ID}');">
														<i class="ace-icon fa fa-trash-o bigger-120" title="删除"></i>
													</a>
													</c:if> --%>
																</div>
																<div class="hidden-md hidden-lg">
																	<div class="inline pos-rel">
																		<button
																			class="btn btn-minier btn-primary dropdown-toggle"
																			data-toggle="dropdown" data-position="auto">
																			<i class="ace-icon fa fa-cog icon-only bigger-110"></i>
																		</button>

																		<ul
																			class="dropdown-menu dropdown-only-icon dropdown-yellow dropdown-menu-right dropdown-caret dropdown-close">
																			<c:if test="${QX.edit == 1 }">
																				<li><a style="cursor: pointer;"
																					onclick="edit('${var.ID}');"
																					class="tooltip-success" data-rel="tooltip"
																					title="<%=modify %>"> <span class="green">
																							<i
																							class="ace-icon fa fa-pencil-square-o bigger-120"></i>
																					</span>
																				</a></li>
																			</c:if>
																			<%-- <c:if test="${QX.del == 1 }">
															<li>
																<a style="cursor:pointer;" onclick="del('${var.DEPARTMENT_ID}');" class="tooltip-error" data-rel="tooltip" title="删除">
																	<span class="red">
																		<i class="ace-icon fa fa-trash-o bigger-120"></i>
																	</span>
																</a>
															</li>
															</c:if> --%>
																		</ul>
																	</div>
																</div></td>
														</tr>

													</c:forEach>
												</c:if>
												<c:if test="${QX.cha == 0 }">
													<tr>
														<td colspan="100" class="center"><%=you_have_no_permission%></td>
													</tr>
												</c:if>
											</c:when>
											<c:otherwise>
												<tr class="main_info">
													<td colspan="100" class="center"><%=no_relevant_data%></td>
												</tr>
											</c:otherwise>
										</c:choose>
									</tbody>
								</table>
								<div class="page-header position-relative">
									<table style="width: 100%;">
										<tr>
											<td style="vertical-align: top;"><c:if
													test="${QX.add == 1 }">
													<a class="btn btn-sm btn-success"
														onclick="add('${companyid}');"><%=add2%></a>
												</c:if> <c:if
													test="${null != pd.DEPARTMENT_ID && pd.DEPARTMENT_ID != ''}">
													<a class="btn btn-sm btn-success"
														onclick="goSondict('${pd.PARENT_ID}');"><%=return1%></a>
												</c:if></td>
											<td style="vertical-align: top;"><div class="pagination"
													style="float: right; padding-top: 0px; margin-top: 0px;">${page.pageStr}</div></td>
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
		<a href="#" id="btn-scroll-up"
			class="btn-scroll-up btn btn-sm btn-inverse"> <i
			class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
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
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<script type="text/javascript">
		$(top.hangge());//关闭加载状态
		//检索
		function gsearch(){
			top.jzts();
			$("#Form").submit();
		}
		
		//去此ID下子级列表
		function goSondict(DEPARTMENT_ID){
			top.jzts();
			window.location.href="<%=basePath%>department/list.do?DEPARTMENT_ID="+DEPARTMENT_ID;
		};
		
		//新增
		function add(companyid){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="<%=add2%>";
			 diag.URL = '<%=basePath%>department/goAdd.do?companyid='+companyid;
			 diag.Width = 470;
			 diag.Height = 280;
			 diag.CancelEvent = function(){ //关闭事件
				 if('none' == diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display){
					 parent.location.href="<%=basePath%>department/listAllDepartment.do?companyid=${companyid}&dnowPage=${page.currentPage}";
				}
				diag.close();
			 };
			 diag.show();
		}
		
		//删除
		function del(Id){
			bootbox.confirm("确定要删除吗?", function(result) {
				if(result) {
					top.jzts();
					var url = "<%=basePath%>department/delete.do?DEPARTMENT_ID="+Id+"&tm="+new Date().getTime();
					$.get(url,function(data){
						if("success" == data.result){
							parent.location.href="<%=basePath%>department/listAllDepartment.do?DEPARTMENT_ID=${DEPARTMENT_ID}&dnowPage=${page.currentPage}";
						}else if("false" == data.result){
							top.hangge();
							bootbox.dialog({
								message: "<span class='bigger-110'>删除失败！请先删除子级部门.</span>",
								buttons: 			
								{
									"button" :
									{
										"label" : "确定",
										"className" : "btn-sm btn-success"
									}
								}
							});
						}
					});
				}
			});
		}
		
		//修改
		function edit(Id){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="<%=modify%>";
			 diag.URL = '<%=basePath%>department/goEditdepartmrnt.do?DEPARTMENT_ID='+Id;
			 diag.Width = 470;
			 diag.Height = 320;
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 parent.location.href="<%=basePath%>
		department/listAllDepartment.do?companyid=${companyid}&dnowPage=${page.currentPage}";
				}
				diag.close();
			};
			diag.show();
		}
	</script>


</body>
</html>