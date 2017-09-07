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
<%@include file="../international.jsp"%>  <!--国际化标签  -->
<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">
<!-- 下拉框 -->
<link rel="stylesheet" href="static/ace/css/chosen.css" />
<!-- jsp文件头和头部 -->
<%@ include file="../system/index/top.jsp"%>

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
						<form action="newnet/goOwnClientList" method="post" name="Form" id="Form">
						<input hidden="true" name="id" value="${id}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table style="margin-top:5px;">
							<tr>
								 <td>
									<div class="nav-search">
									    <label><%=serial_number%>：</label>
										<input class="nav-search-input" autocomplete="off" id="nav-search-input" type="text" name="code" value="${pd.code}" placeholder="<%=please_enter_serial_number%>" />
									</div>
								</td>
								<td>
									<div class="nav-search" style="margin-left:8px;">
									    <label><%=name%>：</label>
										<input class="nav-search-input" autocomplete="off" id="nav-search-input" type="text" name="name" value="${pd.name}" placeholder="<%=please_enter_name%>" />
									</div>
								</td>
								<c:if test="${QX.cha == 1 }">
								<td style="vertical-align:top;padding-left:2px"><a class="btn btn-light btn-xs" onclick="tosearch();"  title="检索" style="padding: 3px 3px;"><i id="nav-search-icon" class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i></a></td>
								</c:if>
							</tr>
						</table>
						<!-- 检索  -->
					
						<table id="simple-table" class="table table-striped table-bordered table-hover"  style="margin-top:5px;">
							<thead>
								<tr>
									<th class="center" style="width:35px;">
									<label class="pos-rel"><input type="checkbox" class="ace" id="zcheckbox" /><span class="lbl"></span></label>
									</th>
									<th class="center"><%=number%></th>
									<th class="center"><%=device_number%></th>
									<th class="center"><%=device_name %></th>
									<th class="center"><%=pole_number %></th>
									<th class="center"><%=comment%></th>
									<th class="center"><%=work_status%></th>							 
								</tr>
							</thead>
													
							<tbody>
								
							<!-- 开始循环 -->	
							<c:choose>
								<c:when test="${not empty clientList}">
									<c:if test="${QX.cha == 1 }">
									<c:forEach items="${clientList}" var="var" varStatus="vs">
										<tr>
											<td class='center'>
												<label class="pos-rel"><input type='checkbox' name='ids' value="${var.id}" class="ace" /><span class="lbl"></span></label>
											</td>
											<td class="center">${vs.index+1}</td>
											<td class="center">${var.number}</td>
											<td class="center">${var.name}</td>								 
											<td class="center">${var.polenumber}</td>
											<td class="center">${var.comment}</td>		
											<td class="center">
												<c:if test="${var.status == '1' }"><span class="label label-important arrowed-in"><%=effective%></span></c:if>
												<c:if test="${var.status == '2' }"><span class="label label-success arrowed"><%=invalid%></span></c:if>
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
							
							<td style="vertical-align:top;">
									<c:if test="${QX.del == 1 }">
									<a class="btn btn-mini btn-danger" onclick="makeAll('<%=make_sure_delete_data%>?',${id});" title="<%=delete_all %>" ><%=kick_delete%></a>
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
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<script type="text/javascript">
		$(top.hangge());
		
		//检索
		function tosearch(){
			top.jzts();
			$("#Form").submit();
		}
		
		
		$(function() {
		 	//复选框全选控制
			 var active_class = 'active';
			$('#simple-table > thead > tr > th input[type=checkbox]').eq(0).on('click', function(){
				var th_checked = this.checked;//checkbox inside "TH" table header
				$(this).closest('table').find('tbody > tr').each(function(){
					var row = this;
					if(th_checked) $(row).addClass(active_class).find('input[type=checkbox]').eq(0).prop('checked', true);
					else $(row).removeClass(active_class).find('input[type=checkbox]').eq(0).prop('checked', false);
				});
			}); 
		});	
		
	//确定踢删组员
		function makeAll(msg,id){
			bootbox.confirm(msg, function(result) {
				if(result) {
					var str = '';
					for(var i=0;i < document.getElementsByName('ids').length;i++){
					  if(document.getElementsByName('ids')[i].checked){
					  	if(str=='') str += document.getElementsByName('ids')[i].value;
					  	else str += ',' + document.getElementsByName('ids')[i].value;
					  }
					}
					if(str==''){
						bootbox.dialog({
							message: "<span class='bigger-110'><%=you_have_not_choose_anything%>!</span>",
							buttons: 			
							{ "button":{ "label":"<%=make_sure%>", "className":"btn-sm btn-success"}}
						});
						$("#zcheckbox").tips({
							side:1,
				            msg:'<%=click_this_choose_all%>',
				            bg:'#AE81FF',
				            time:8
				        });
						return;
					}else{
						if(msg == '<%=make_sure_delete_data%>?'){
							top.jzts();
							$.ajax({
								type: "POST",
								url: '<%=basePath%>newnet/removeClient?id='+id,
						    	data: {DATA_IDS:str},
								dataType:'json',
								//beforeSend: validateData,
								cache: false,
								success: function(data){
									$.each(data.list, function(i, list){
										nextPage(${page.currentPage});
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

