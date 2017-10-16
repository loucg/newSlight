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
<%@ include file="../system/index/top.jsp"%>
<!-- jsp国际化文件 -->
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
							
						<!-- 检索  -->
						<form action="groupmem/listOthers.do?id=${termforpage.id }" method="post" name="Form" id="Form">
						<input type="hidden" value="no" id="hasTp1" />
						<div id="zhongxin" style="padding-top: 13px;">
						<table style="margin-top:5px;">
							<tr>
								<td><%=location %>：</td>
								<td>
									<div class="nav-search">
										<span class="input-icon">
											<input type="text" class="nav-search-input" id="nav-search-input" autocomplete="off" name="location" value="${pd.location }"/>
										</span>
									</div>
								</td>
								<td>&nbsp;&nbsp;<%=device_name %>：</td>
								<td>
									<div class="nav-search">
										<span class="input-icon">
											<input type="text" class="nav-search-input" id="nav-search-input" autocomplete="off" name="clientname" value="${pd.clientname }"/>
										</span>
									</div>
								</td>
								<td>&nbsp;&nbsp;<%=pole_number2 %>：</td>
								<td>
									<div class="nav-search">
										<span class="input-icon">
											<input type="text" class="nav-search-input" id="nav-search-input" autocomplete="off" name="lamp_pole_num" value="${pd.lamp_pole_num }"/>
										</span>
									</div>
								</td>
								<td>&nbsp;&nbsp;<%=device_number2 %>：</td>
								<td>
									<div class="nav-search">
										<span class="input-icon">
											<input type="text" class="nav-search-input" id="nav-search-input" autocomplete="off" name="client_code" value="${pd.client_code }"/>
										</span>
									</div>
								</td>
								<c:if test="${QX.cha == 1 }">
								<td style="vertical-align:top;padding-left:2px"><a class="btn btn-light btn-xs" onclick="tosearch();"  title="<%=search2 %>" style="padding: 3px 3px;"><i id="nav-search-icon" class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i></a></td>
								</c:if>
							</tr>
						</table>
						<!-- 检索  -->
						
						
						<table class="table table-striped table-bordered table-hover" style="margin-top:5px;">
							<tr>
								<th class='center'><%=not_divide_group %> <%=group_member %></th>
							</tr>
						</table>
						
						<table id="simple-table" class="table table-striped table-bordered table-hover" style="margin-top:1px;">	
							<thead>
								<tr>
									<th class="center" style="width:35px;">
										<label class="pos-rel">
											<input type="checkbox" class="ace" id="zcheckbox" />
											<span class="lbl"></span>
										</label>
									</th>
									<th class="center" style="width:50px;"><%=number %></th>
									<th class="center"><%=device_number2 %></th>
									<th class="center"><%=device_name %></th>
									<th class="center"><%=pole_number2 %></th>
									<th class="center"><%=location %></th>
									<th class="center"><%=device_type %></th>
									 
								</tr>
							</thead>
													
							<tbody>
							<!-- 开始循环 -->	
							<c:choose>
								<c:when test="${not empty groupOther}">
									<c:if test="${QX.cha == 1 }">
									<c:forEach items="${groupOther}" var="groupother" varStatus="vs">
										<tr>
											<td class='center'>
												<label class="pos-rel">
													<input type='checkbox' name='ids' value="${groupother.id}" class="ace" />
												    <span class="lbl"></span>
												</label>
												<input type='hidden' name='gateway_id' value="${groupother.gateway_id}" class="ace" />
											</td>
											 
											
											</td>
											<td class='center' style="width: 30px;">${vs.index+1}</td>
											<td class='center'>${groupother.client_code}</td> 
											<td class='center'>${groupother.clientname }</td>
											<td class='center'>${groupother.lamp_pole_num }</td>
											<td class='center'>${groupother.location }</td>
											<td class='center'>${groupother.ctyname }</td>
		 
										 
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
									<a class="btn btn-mini btn-danger" onclick="makeAll('<%=make_sure_choose_data %>?',${termforpage.id});" title="<%=multiple_add %>" ><%=add_group_member1 %></a>
									</c:if>
								</td>
								<td style="vertical-align:top;"><div class="pagination" style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div></td>
							</tr>
						</table>
						</div>
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

		<!-- 返回顶部 -->
		<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
			<i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
		</a>

	</div>
	<!-- /.main-container -->

	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../system/index/foot.jsp"%>
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
		$(function() {
			
			//日期框
			$('.date-picker').datepicker({
				autoclose: true,
				todayHighlight: true
			});
			
			//下拉框
			if(!ace.vars['touch']) {
				$('.chosen-select').chosen({allow_single_deselect:true}); 
				$(window)
				.off('resize.chosen')
				.on('resize.chosen', function() {
					$('.chosen-select').each(function() {
						 var $this = $(this);
						 $this.next().css({'width': $this.parent().width()});
					});
				}).trigger('resize.chosen');
				$(document).on('settings.ace.chosen', function(e, event_name, event_val) {
					if(event_name != 'sidebar_collapsed') return;
					$('.chosen-select').each(function() {
						 var $this = $(this);
						 $this.next().css({'width': $this.parent().width()});
					});
				});
				$('#chosen-multiple-style .btn').on('click', function(e){
					var target = $(this).find('input[type=radio]');
					var which = parseInt(target.val());
					if(which == 2) $('#form-field-select-4').addClass('tag-input-style');
					 else $('#form-field-select-4').removeClass('tag-input-style');
				});
			}
			
			
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
		
		//确定新增组员
		function makeAll(msg,id){
			
			bootbox.confirm(msg, function(result) {
				if(result) {
					var str = '';
					var gateway = '';
					for(var i=0;i < document.getElementsByName('ids').length;i++){
					  if(document.getElementsByName('ids')[i].checked){
					  	if(str=='') str += document.getElementsByName('ids')[i].value;
					  	else str += ',' + document.getElementsByName('ids')[i].value;
					  }
					}
					//网关号（缪秀诚加的网关传到后台）
					for(var i=0;i < document.getElementsByName('gateway_id').length;i++){
						  if(document.getElementsByName('ids')[i].checked){
						  	if(gateway=='') gateway += document.getElementsByName('gateway_id')[i].value;
						  	else gateway += ',' + document.getElementsByName('gateway_id')[i].value;
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
					
					if(str==''){
						bootbox.dialog({
							message: "<span class='bigger-110'><%=you_have_not_choose_anything %>!</span>",
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