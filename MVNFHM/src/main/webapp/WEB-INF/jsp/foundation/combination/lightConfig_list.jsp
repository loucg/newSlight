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
<!-- 下拉框 -->
<link rel="stylesheet" href="static/ace/css/chosen.css" />
<!-- jsp文件头和头部 -->
<%@ include file="../../system/index/top.jsp"%>

<style type="text/css">
	.table table-striped table-bordered table-hover{
	　　table-layout: fixed;
	}
	.td{
	　　text-overflow: ellipsis;
	　　white-space: nowrap;
	　　overflow: hidden;
	}
</style>
<script type="text/javascript">
function cutStr(len){
    var obj=document.getElementById('table1').getElementsByTagName('td');
    for (i=0;i<obj.length;i++){
        obj[i].innerHTML=obj[i].innerHTML.substring(0,len)+'…';
    }
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

						<!-- 检索  -->
						<form action="config/getLightConfigList.do?gateway_id=${pd.gateway_id}" method="post" name="Form" id="Form">
						<input type="hidden" id="excel" name="excel" value="0"/>
						<input type="hidden" id="gateway_id" name="gateway_id" value="${pd.gateway_id}"/>
						<!-- <input type="hidden" name="itype" id="itype" value="4"> -->
						<table style="margin-top:5px;" class="table table-striped table-bordered table-hover">
							<tr>
							<td class="center">
								<c:choose>
								<c:when test="${not empty deviceList}">
									<c:forEach items="${gatewaynamelist}" var="gateway" varStatus="vs">
										<%=lamp_config_gatewayname %>${gateway.gateway_code }
									</c:forEach>
								</c:when>
								</c:choose>
							</td>
							</tr>
						</table>
						<table style="margin-top:5px;">
							<tr>
								
								<td>
									<div class="nav-search">
									    <label><%=node_number %>：</label>
										<input class="nav-search-input" autocomplete="off" id="nav-search-input" type="text" name="number" value="${pd.number}" />
									</div>
								</td>
								<td >
								 	<div class="nav-search">
									    <label style="margin-left:12px;"><%=node_name %>：</label>
										<input class="nav-search-input" autocomplete="off" id="nav-search-input" type="text" name="name" value="${pd.name }"  />
									</div>
								</td>
								<!-- 
								<c:if test="${pd.itype==3 }">
								</c:if>
								 -->
								<td>&nbsp;&nbsp;<%=node_type %>：</td>
									<td >
										<c:if test="${pd.itype==5}">
								 			<input type="hidden" name="itype" id="itype" value="5">
									 	</c:if>
										<c:if test="${pd.itype==4}">
								 			<input type="hidden" name="itype" id="itype" value="4">
									 	</c:if>
									 	<c:if test="${pd.itype==3}">
								 			<input type="hidden" name="itype" id="itype" value="3">
									 	</c:if>
									 	<select class="chosen-select form-control" name="type" id="type" data-placeholder="<%=please_choose_device_type%>" style="height:30px;width: 160px;border-width:1px;border-color:'#fff';border-radius:4px">
									 		<!-- <c:if test="${pd.itype==4}">
									 			<option style="display:none" value="6" <c:if test="${pd.itype==4}">selected</c:if>><%=device_combination%></option>
									 		</c:if> -->
									 		<c:if test="${pd.itype==4}">
									 			<option value="126" <c:if test="${pd.type!=0}">style="display:none"</c:if>>请选择类型</option>
												<option value="1" <c:if test="${pd.type==1}">selected="selected"</c:if>><%=integration_power%></option>
												<option value="2" <c:if test="${pd.type==2}">selected="selected"</c:if>><%=single_light_controller%></option>
												<option value="6" <c:if test="${pd.type==6}">selected="selected"</c:if>><%=device_combination%></option>
												<option value="126" <c:if test="${pd.type==126}">selected="selected"</c:if>><%=all%></option>
									 		</c:if>
									 		<!-- <c:if test="${pd.itype==2 }">
												<option style="display:none" value="2" <c:if test="${pd.itype==2}">selected</c:if>><%=single_light_controller%></option>
									 		</c:if> -->
									 		<c:if test="${pd.itype==3 }" >
											<!--	
												<option value="3" <c:if test="${pd.type==3}">selected="selected"</c:if>><%=gateway%></option>
												<option value="4" <c:if test="${pd.type==4}">selected="selected"</c:if>><%=circuit_breaker%></option>
												<option value="5" <c:if test="${pd.type==5}">selected="selected"</c:if>><%=normal_cutoff_device%></option>
												<option value="345" <c:if test="${pd.type==345}">selected="selected"</c:if>><%=all%></option>
											-->
												<option value="0" <c:if test="${pd.type!=0}">style="display:none"</c:if>>请选择类型</option>
												<c:forEach items="${pd.typeList}" var="type">
													<option value="${type.id}" <c:if test="${type.id==pd.type}">selected="selected"</c:if>>
														<c:if test="${sessionScope.session_language=='zh_CN' }">
															${type.typeName1}
														</c:if>
														<c:if test="${sessionScope.session_language=='en_US' }">
															${type.typeName2}
														</c:if>
													</option>
												</c:forEach>
												<option value="999" <c:if test="${pd.type==999}">selected="selected"</c:if>><%=all%></option>
									 		</c:if>
									 		<c:if test="${pd.itype==5 }" >
												<option value="0" <c:if test="${pd.type!=0}">style="display:none"</c:if>>请选择类型</option>
												<c:forEach items="${pd.typeList}" var="type">
													<option value="${type.id}" <c:if test="${type.id==pd.type}">selected="selected"</c:if>>
															${type.typeName}
													</option>
												</c:forEach>
												<option value="999" <c:if test="${pd.type==999}">selected="selected"</c:if>><%=all%></option>
									 		</c:if>
									  	</select>
									</td>
								<c:if test="${QX.cha == 1 }"><td style="vertical-align:top;padding-left:2px;"><button class="btn btn-light btn-xs" style="border-radius:6px" onclick="search();"  title="<%=search2%>"><i id="nav-search-icon" class="ace-icon fa fa-search bigger-110 nav-search-icon white">&nbsp;&nbsp;<%=search1 %></i></button></td></c:if>
								<c:if test="${QX.toExcel == 1 }"><td style="vertical-align:top;padding-left:2px;"><a class="btn btn-light btn-xs" style="border-radius:6px" onclick="toExcel();" title="<%=export_to_excel%>"><i id="nav-search-icon" class="ace-icon fa fa-download bigger-110 nav-search-icon white"></i></a></td></c:if>
								<c:if test="${QX.FromExcel == 1 }"><td style="vertical-align:top;padding-left:2px;"><a class="btn btn-light btn-xs" style="border-radius:6px" onclick="fromExcel();" title="<%=import_from_excel%>"><i id="nav-search-icon" class="ace-icon fa fa-cloud-upload bigger-110 nav-search-icon white"></i></a></td></c:if>
							</tr>
						</table>
						<!-- 检索  -->

						<table id="simple-table" class="table table-striped table-bordered table-hover"  style="margin-top:5px;">
							<thead>
								<tr>
									<th class="center"><%=node_address%></th>
									<th class="center"><%=node_number%></th>
									<th class="center"><%=node_name%></th>
									<th class="center"><%=node_type%></th>
									<th class="center"><%=location%></th>
									<th class="center"><%=coordinate%></th>
									<c:if test="${pd.itype==3 }">
										<th class="center"><%=phone_number%></th>
									</c:if>
									<!-- 
									<c:if test="${pd.itype==2 or pd.itype==4}">
										<th class="center"><%=power_standard%></th>
									</c:if>
									 -->
									 <!-- 
									<c:if test="${pd.itype==1 or pd.itype==2 or pd.itype==4}">
										<th class="center"><%=light_standard%></th>
									</c:if>
									  -->
									<c:if test="${pd.itype==3}">
										<th class="center"><%=sensor_standard%></th>
									</c:if>
									<th class="center"><%=pole%></th>
									<th class="center"><%=pole_number%></th>
									<!-- 
									<th class="center"><%=password%></th>
									 -->
									<th class="center"><%=comment%></th>
									<th class="center"><%=operate%></th>

								</tr>
							</thead>

							<tbody>

							<!-- 开始循环 -->
							<c:choose>
								<c:when test="${not empty deviceList}">
									<c:if test="${QX.cha == 1 }">
									<c:forEach items="${deviceList}" var="var" varStatus="vs">
										<tr>
											<td class="center">${var.node}</td>
											<td class="center">${var.number}</td>
											<td class="center">${var.name}</td>
											<c:if test="${pd.itype==3 }">
												<c:if test="${sessionScope.session_language=='zh_CN' }">
													<td class="center">${var.type1}</td>
												</c:if>
												<c:if test="${sessionScope.session_language=='en_US' }">
													<td class="center">${var.type2}</td>
												</c:if>
											</c:if>
											<c:if test="${pd.itype!=3 }">
												<td class="center">${var.type}</td>
											</c:if>
											<td class="center">${var.location}</td>
											<td class="center">${var.coordinate}</td>
											<c:if test="${pd.itype==3 }">
												<td class="center">${var.mobile}</td>
											</c:if>
											<!-- 
											<c:if test="${pd.itype==2 or pd.itype==4}">
												<td class="center">${var.power}</td>
											</c:if>
											 -->
											<!-- 
											<c:if test="${pd.itype==1 or pd.itype==2 or pd.itype==4}">
												<td class="center">${var.lamp}</td>
											</c:if>	
											 -->
											<c:if test="${pd.itype==3}">
												<td class="center">${var.sensor}</td>
											</c:if>
											<td class="center">${var.pole}</td>
											<td class="center">${var.polenumber}</td>
											<!-- 
											<td class="center">${var.password}</td>
											 -->
											<td class="center">${var.comment}</td>
											<!--  <td class="center">${var.CREATETIME}</td>
											<td style="width: 60px;" class="center">
												<c:if test="${var.STATUS == '2' }"><span class="label label-important arrowed-in">无效</span></c:if>
												<c:if test="${var.STATUS == '1' }"><span class="label label-success arrowed">有效</span></c:if>
											</td>
											-->
											<td class="center">
												<c:if test="${QX.edit != 1 && QX.del != 1 }">
												<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="ace-icon fa fa-lock" title="<%=no_permission%>"></i></span>
												</c:if>
												<div class="hidden-sm hidden-xs btn-group">
												<!-- //查看配置（有待开发） -->
												   <c:if test="${QX.edit == 1 && pd.itype==3}">
													<a class="btn btn-xs btn-danger" onclick="viewConfig('<%=make_sure_view %>?',${var.id});">
														<%=viewConfig %>
													</a>
													</c:if>
													<!-- //初始化 -->
												    <c:if test="${QX.del == 1 && pd.itype==3}">
													<a class="btn btn-xs btn-danger" onclick="initial('<%=make_sure_Initial %>?',${var.id});">	
														<%=Initialization %>
													</a>
													</c:if>
													
													<c:if test="${QX.edit == 1 }">
														<c:if test="${var.typeid != 5}">
															<a class="btn btn-xs btn-success" style = "border-radius:6px" onclick="edit('${var.id}');"><%=modify%></a>
														</c:if>
														<c:if test="${var.typeid == 5}">
														 	<i class="ace-icon fa fa-pencil-square-o bigger-120" title="无法操作，不是适配的类型"></i>
														</c:if>
													</c:if>
													
												</div>
											</td>
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
										<td colspan="100" class="center" ><%=no_relevant_data%></td>
									</tr>
								</c:otherwise>
							</c:choose>
							</tbody>
						</table>
					<div class="page-header position-relative">
					<table style="width:100%;">
						<tr>
							<td style="vertical-align:top;display:none">
								<c:if test="${QX.add == 1 }">
								<a class="btn btn-sm btn-success" onclick="add();"><%=add2%></a>
								</c:if>
							</td>
							<td style="vertical-align:top;display:none">
								<c:if test="${QX.add == 1 }">
								<a class="btn btn-sm btn-success" onclick="add();"><%=claimGateway %></a>
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

		function add(){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="<%=claimGateway%>";
			 diag.URL = '<%=basePath%>config/goGatewayClaim';
			 diag.Width = 450;
			 diag.Height = 124;
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

		function edit(Id){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="<%=modify%>";
			 diag.URL = '<%=basePath%>config/goDeviceEdit?id='+Id;
			 diag.Width = 650;
			 diag.Height = 640;
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 nextPage('${page.currentPage}');
				}
				diag.close();
			 };
			 diag.show();
		}
		//查看配置
		function viewConfig(msg,Id){
			bootbox.confirm(msg, function(result) {
				if(result) {
					 $.ajax({
							type: "POST",
							url: '<%=basePath%>config/goViewConfig?id='+Id,
							data: {Id:Id},
							dataType:'json',
							//beforeSend: validateData,
							cache: false,
							success: function(data){
								console.log("查看成功") 
							}
						});
		   			}
			});
		}
		
		//初始化按钮
		function initial(msg,Id){
			bootbox.confirm(msg, function(result) {
				if(result) {
					 $.ajax({
							type: "POST",
							url: '<%=basePath%>config/goInitial?id='+Id,
							data: {Id:Id},
							dataType:'json',
							//beforeSend: validateData,
							cache: false,
							success: function(data){
								console.log("初始化成功") 
							}
						});
		   			}
			});
		}
		
		

		//打开上传excel页面
		function fromExcel(){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="<%=import_from_excel%>";
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
			$("#excel").val("0");
		}
		</script>

</body>
</html>
