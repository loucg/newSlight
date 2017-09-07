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
<%@include file="../international.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">
<!-- 下拉框 -->
<link rel="stylesheet" href="static/ace/css/chosen.css" />
<!-- jsp文件头和头部 -->
<%@ include file="../system/index/top.jsp"%>
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
						<form action="strategyGroup/listOthers.do" method="post" name="Form" id="Form">
						<input type="hidden" value="no" id="hasTp1" />
						<input type="hidden" id="strategy_id" name="strategy_id" value="${pd.strategy_id}">
						<div id="zhongxin" style="padding-top: 13px;">
						<table style="margin-top:5px;">
							<tr>
								<td><%=group_name %>：</td>
								<td>
									<div class="nav-search">
											<input type="text" class="nav-search-input" id="term_name-input" autocomplete="off" name="term_name" placeholder="<%=please_enter_group_name %>" value="${pd.term_name}"/>
									</div>
								</td>
								<td>&nbsp;&nbsp;<%=group_explain %>：</td>
								<td>
									<div class="nav-search">
											<input type="text" class="nav-search-input" id="term_explain-input" autocomplete="off" name="term_explain" placeholder="<%=please_enter_group_explain %>" value="${pd.term_explain}"/>
									</div>
								</td>
								<c:if test="${QX.cha == 1 }">
								<td style="vertical-align:top;padding-left:2px;">&nbsp;&nbsp;<a class="btn btn-light btn-xs" onclick="clearSearchs();"  title="<%=clear_search_ %>" style="padding: 4px 4px;"><i id="nav-clear-icon" class="ace-icon fa fa-search bigger-110 nav-search-icon red"></i></a></td>
								</c:if>
								<c:if test="${QX.cha == 1 }">
								<td style="vertical-align:top;padding-left:2px">&nbsp;&nbsp;<a class="btn btn-light btn-xs" onclick="tosearch();"  title="<%=search2 %>" style="padding: 4px 4px;"><i id="nav-search-icon" class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i></a></td>
								</c:if>
							</tr>
						</table>
						<!-- 检索  -->

						<!-- 一览表  -->
						<table class="table table-striped table-bordered table-hover" style="margin-top:5px;">
							<tr>
<%-- 								<th class='center'>“${strategyforpage.name }<%=strategy %>” <%=add_app_select %></th> --%>
							</tr>
						</table>
						
						<table id="simple-table" class="table table-striped table-bordered table-hover" style="margin-top:1px;">	
							<thead>
								<tr>
									<th class="center" style="width:35px;">
									<label class="pos-rel"><input type="checkbox" class="ace" id="zcheckbox" /><span class="lbl"></span></label>
									</th>
									<th class="center" style="width:50px;"><%=number %></th>
									<th class="center"><%=group_name %></th>
									<th class="center"><%=group_explain %></th>
									<th class="center"><%=device_counter %></th>
								</tr>
							</thead>
													
							<tbody>
							<!-- 开始循环 -->	
							<c:choose>
								<c:when test="${not empty strategyOther}">
									<c:if test="${QX.cha == 1 }">
									<c:forEach items="${strategyOther}" var="strategyOther" varStatus="vs">
										<tr>
											<td class='center'>
												<label class="pos-rel"><input type='checkbox' name='ids' value="${strategyOther.term_id}" class="ace" /><span class="lbl"></span></label>
											</td>
											<td class='center' style="width: 30px;">${vs.index+1+(page.currentPage-1)*page.showCount}</td>
											<td class='center'><a onclick="viewGroupMems('${strategyOther.term_id}')" style="cursor:pointer;">${strategyOther.term_name}</a></td>
											<td class='center'>${strategyOther.term_explain}</td>  
											<td class='center'>${strategyOther.number}</td>  
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
										<td colspan="100" class="center" ><%=app_group_has_assigned %></td>
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
									<a class="btn btn-warning btn-mini" onclick="makeAll('<%=make_sure_add_app_group %>','${pd.strategy_id}');" title="<%=multiple_add_app_group %>" ><%=add1 %></a>
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
		
		//清空检索条件
		function clearSearchs(){
			$("#term_name-input").val("");
			$("#term_explain-input").val("");
		}
		
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
		
		//确定新增应用组
		function makeAll(msg,strategy_id){
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
							message: "<span class='bigger-110'><%=you_have_not_choose_any_app_group %></span>",
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
						if(msg == '<%=make_sure_add_app_group %>'){
							top.jzts();
							$.ajax({
								type: "POST",
								url: '<%=basePath%>strategyGroup/addGroups.do?strategy_id='+strategy_id,
						    	data: {DATA_IDS:str},
								dataType:'json',
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
		
		//踢删应用组
		function delGroup(id){
			top.jzts();
			var diag = new top.Dialog();
			diag.Drag=true;
			diag.Title ="<%=keck_delete_app_group %>";
			diag.URL = '<%=basePath%>strategyGroup/listGroups.do?strategy_id='+id;
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
		
		//查看组员
		function viewGroupMems(id){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="<%=group_member %>";
			 diag.URL = '<%=basePath%>groupmem/listMems.do?id='+id+'&title='+'chakan';
			 diag.Width = 1200;
			 diag.Height = 600;
			 diag.CancelEvent = function(){ //关闭事件
				diag.close();
			 };
			 diag.show();
		}
		
	</script>


</body>
</html>