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
<!-- jsp 国际化-->
<%@ include file="../international.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">
<!-- 下拉框 -->
<link rel="stylesheet" href="static/ace/css/chosen.css" />
<!-- jsp文件头和头部 -->
<%@ include file="../system/index/top.jsp"%>
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
						<form action="group/listGateways.do?" method="post" name="Form" id="Form">
						<input type="hidden" id="term_id" name="term_id" value="${pd.term_id }"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table style="margin-top:5px;">
							<tr>
								<td>
									<div class="nav-search" style="margin-left:14px;">
									    <label><%=gateway_number%>：</label>
										<input class="nav-search-input" autocomplete="off" id="code-input" type="text" name="code" value="${pd.code}" placeholder="<%=please_enter_gateway_number%>" />
									</div>
								</td>
								 <td>
									<div class="nav-search" style="margin-left:8px;">
									    <label><%=gateway_name%> ：</label>
										<input class="nav-search-input" autocomplete="off" id="name-input" type="text" name="name" value="${pd.name}" placeholder="<%=please_enter_gateway_name%>" /> 
									</div>
								</td>
								<c:if test="${QX.cha == 1 }">
								<td style="vertical-align:top;padding-left:2px;">&nbsp;&nbsp;<a class="btn btn-light btn-xs" onclick="clearSearchs();"  title="<%=clear_search_ %>" style="padding: 4px 4px;"><i id="nav-clear-icon" class="ace-icon fa fa-search bigger-110 nav-search-icon red"></i></a></td>
								</c:if>
								<c:if test="${QX.cha == 1 }">
								<td style="vertical-align:top;padding-left:2px;">&nbsp;&nbsp;<a class="btn btn-light btn-xs" onclick="searchs();"  title="<%=search2 %>" style="padding: 4px 4px;"><i id="nav-search-icon" class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i></a></td>
								</c:if>
							</tr>
						</table>
						<!-- 检索  -->

						<table id="simple-table" class="table table-striped table-bordered table-hover"  style="margin-top:5px;">
							<thead>
								<tr>
									<th class="center" ><%=number%></th>
									<th class="center" ><%=gateway_number%></th>
									<th class="center" ><%=gateway_name%></th>
									<th class="center" ><%=device_counter%></th>
								</tr>
							</thead>

							<tbody>
							<!-- 开始循环 -->
							<c:choose>
								<c:when test="${not empty gatewayList}">
									<c:if test="${QX.cha == 1 }">
									<c:forEach items="${gatewayList}" var="var" varStatus="vs">
										<tr>
											<td class="center" style="width: 50px;">${vs.index+1}</td>
											<td class="center"><a onclick="selectClient('${var.gateway_id}', '${var.client_ids}')" style="cursor:pointer;">${var.gateway_code }</a></td>
											<td>${fn:substring(var.name,0,50)}</td>
											<td class="center" style="width: 150px;">${var.number}/${var.total}
												<input type="hidden" id="gatewayid" name="gatewayid" value="${var.gateway_id}"/>
												<input type="hidden" id="clientids" name="clientids" value="${var.client_ids}"/>
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
								<td>
									<c:if test="${QX.add == 1 }">
									<!-- 确定 -->
									<a class="btn btn-mini btn-success" onclick="save('<%=make_sure_choose_data %>?', '${pd.term_id}');" title="<%=multiple_add %>" ><%=add_group_member1 %></a>
									<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();"><%=cancel%></a>
									</c:if>
								</td>
								<td style="vertical-align:top;"><div class="pagination" style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div></td>
							</tr>
						</table>
						</div>
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
	<%@ include file="../system/index/foot.jsp"%>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
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
		$(top.hangge());
	
		//清空检索条件
		function clearSearchs(){
			$("#name-input").val("");
			$("#code-input").val("");
		}
	
		//检索
		function searchs(){
			top.jzts();
			$("#Form").submit();
		}
		
		//选择终端
		function selectClient(gateway_id, client_ids){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="<%=add_device %>";
			 diag.URL = '<%=basePath%>group/listClients.do?term_id=${pd.term_id }&gateway_id='+gateway_id+'&client_ids='+client_ids;
			 diag.Width = 1200;
			 diag.Height = 600;
			 diag.Modal = true;				//有无遮罩窗口
			 diag.ShowMaxButton = true;	//最大化按钮
		     diag.ShowMinButton = true;		//最小化按钮
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
		
		// 确定新增组员
		function save(msg, id){
			bootbox.confirm(msg, function(result) {
				if(result) {
					var str = '';
					var gateway = '';
					
					for(var i=0;i < document.getElementsByName('clientids').length;i++){
					  	if(str=='') str += document.getElementsByName('clientids')[i].value;
					  	else str += ',' + document.getElementsByName('clientids')[i].value;
					}
					
					//网关号（缪秀诚加的网关传到后台）
					for(var i=0;i < document.getElementsByName('gatewayid').length;i++){
// 						alert('clientids' + document.getElementsByName('clientids')[i].value);
						if(document.getElementsByName('clientids')[i].value!=''){
// 							alert('gatewayid'+document.getElementsByName('gatewayid')[i].value);
						  	if(gateway=='') gateway += document.getElementsByName('gatewayid')[i].value;
						  	else gateway += ',' + document.getElementsByName('gatewayid')[i].value;
						}
					}
					
					//去重网关号
					var result = '';
					var IDS1 = gateway.split(",");
					for(var i=0; i<IDS1.length; i++)
					{
					if(result.indexOf(IDS1[i]) == -1 ) 
						result = result + IDS1[i] + ",";
					}
// 					alert('clientidsttttt'+str);
// 					alert('gatewayidttttt'+result);
					if(str==''){
						bootbox.dialog({
							message: "<span class='bigger-110'><%=please_choose_client_by_gateway %>!</span>",
							buttons: 			
							{ "button":{ "label":"<%=make_sure %>", "className":"btn-sm btn-success"}}
						});
						$("#zcheckbox").tips({
							side:1,
				            msg:'<%=click_this_choose_all %>',
				            bg:'#AE81FF',
				            time:8
				        });
						return;
					}else{
						if(msg == '<%=make_sure_choose_data %>?'){
							top.jzts();
							$.ajax({
								type: "POST",
								url: '<%=basePath%>groupmem/addMems.do?id='+id,
						    	data: {DATA_IDS:str,DATA_IDS1:result},
								dataType:'json',
								//beforeSend: validateData,
								cache: false,
								success: function(data){
									$.each(data.list, function(i, list){
										nextPage('${page.currentPage}');
								 	});
									$("#zhongxin").hide();
									$("#zhongxin2").show();
									top.Dialog.close(); 
								}
							});
						}
					}
				}
			});
		};


		</script>

</body>
</html>
