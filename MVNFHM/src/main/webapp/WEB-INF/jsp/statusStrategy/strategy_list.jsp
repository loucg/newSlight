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
<!-- jsp 国际化-->
<%@ include file="../international.jsp" %>
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
<!-- ace settings handler -->
<script src="static/ace/js/ace-extra.js"></script>
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
						
						<form action="strategy/listStrategys.do" method="post" name="strategyForm" id="strategyForm">
						<input type="hidden" id="termid" name="termid" value="${pd.termid}">
<%-- 						<input type="hidden" id="op" name="op" value="${pd.op}"> --%>
						<div id="zhongxin" style="padding-top: 13px;">

						<!-- 检索  -->
						<table style="margin-top:5px;">
							<tr>
							    <td><%=strategy_name %>：</td>
								<td>
									<div class="nav-search">
										<input type="text" class="nav-search-input" id="name-input" autocomplete="off" name="name" placeholder="<%=please_enter_strategy_name %>" value="${pd.name}"/>
									</div>
								</td>
								<td>&nbsp;&nbsp;<%=app_explain %>：</td>
								<td>
									<div class="nav-search">
										<input type="text" class="nav-search-input" id="explain-input" autocomplete="off" name="explain" placeholder="<%=please_enter_app_explain %>" value="${pd.explain}"/>
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
									<!-- 选择框 -->
									<c:if test="${empty pd.termid }">
									<th class="center" style="width:35px;">
									<label class="pos-rel"><input type="checkbox" class="ace" id="zcheckbox" /><span class="lbl"></span></label>
									</th>
									</c:if>
									<th class="center" style="width:50px"><%=number %></th>
									<th class="center" style="width:100px"><%=type %></th>
									<th class="center"><%=strategy_name %></th>
									<th class="center" style="width:100px"><%=start_date %></th>
									<th class="center" style="width:100px"><%=end_date %></th>
									<th class="center" style="width:80px"><%=month_cycle %></th>
									<th class="center" style="width:100px"><%=day_apply_days %></th>
									<th class="center" style="width:50px"><%=time %></th>
									<th class="center" style="width:120px"><%=adjust_value %></th>
									<th class="center" style="width:120px"><%=brightness %></th>
									<c:if test="${empty pd.termid }">
									<th class="center" style="width:80px"><%=term_num_in_strategy %></th>
									</c:if>
									<th class="center"><%=send_status %></th>
									<th class="center"><%=app_explain %></th>
									<c:if test="${empty pd.termid }">
									<th class="center" style="width:200px"><%=operate %></th>
									</c:if>
								</tr>
							</thead>
							<tbody>
								
							<!-- 开始循环 -->	
							<c:choose>
								<c:when test="${not empty strategyList}">
									<c:if test="${QX.cha == 1 }">
									<c:forEach items="${strategyList}" var="strategy" varStatus="vs">
										<tr>
											<!-- 选择框 -->	
											<c:if test="${empty pd.termid }">
											<td class='center'>
												<label class="pos-rel"><input type='checkbox' name='ids' id="ids${vs.index}" value="${strategy.id}" class="ace" /><span class="lbl"></span></label>
												<input type="hidden" id="status2${vs.index}" name="status2" value="${strategy.status2}">
												<input type="hidden" id="termcnt${vs.index}" name="termcnt" value="${strategy.termcnt}">
											</td>
											</c:if>
											<!-- 序号 -->	
											<td class='center'>${vs.index+1+(page.currentPage-1)*page.showCount}</td>
											<!-- 类型 -->	
											<td class="center">${strategy.strategy_type }</td>
											<!-- 名称 -->
											<td class="center">${strategy.name }</td>
											<!-- 开始日期 -->
											<td class="center">${strategy.datetime1 }</td>
											<!-- 结束日期  -->
											<td class="center">${strategy.datetime2 }</td>
											<c:if test="${strategy.b_strategy_type_id=='1' }">
												<!-- 月/周期 -->
												<td class="center">${strategy.month }</td>
												<!-- 日/执行天数 -->
												<td class="center">${strategy.day }</td>												
											</c:if>
											<c:if test="${strategy.b_strategy_type_id=='2' }">
												<!-- 月/周期 -->
												<td class="center">${strategy.period }</td>
												<!-- 日/执行天数 -->
												<td class="center">${strategy.days }</td>
											</c:if>
											<!-- 时间 -->
											<td class="center">${strategy.time }</td>
											<!-- 调节值 -->
											<td id="adjustvalue" class="center">
												<table width="100%" border=0>
												<c:if test="${fn:startsWith(strategy.value, 'C')}">  
													<tr><td style="color:white;background-color:red;">${strategy.value1 }</td></tr>
													<tr><td style="color:white;background-color:green;">${strategy.value2 }</td></tr>
													<tr><td style="color:white;background-color:blue;">${strategy.value3 }</td></tr>
												</c:if>
												<c:if test="${fn:startsWith(strategy.value, 'T')}">
													<tr><td style="background-color:yellow;">${strategy.value1 }</td>
													<td style="background-color:white;">${strategy.value2 }</td></tr>
												</c:if>
												</table>
											</td>
											<!-- 亮度 -->
											<td class="center">
												<c:choose><c:when test="${'0' == strategy.bright}"><%=off %></c:when><c:when test="${'255' == strategy.bright}"><%=on %></c:when>
												<c:otherwise>${strategy.bright }</c:otherwise></c:choose>
											</td>
											<!-- 组数量 -->
											<c:if test="${empty pd.termid }">
											<td class="center">
												<c:choose><c:when test="${strategy.termcnt>0}">
													<a onclick="viewGroupMems('${strategy.id}')" style="cursor:pointer;">${strategy.termcnt }</a>
												</c:when><c:otherwise>
													${strategy.termcnt }
												</c:otherwise></c:choose>
											</td>
											</c:if>
												<!-- 下发状态 -->
												<td class="center">${strategy.send_status }</td>
											<!-- 说明 -->
											<td class="center">${strategy.explain }</td>
											
											<c:if test="${empty pd.termid }">
												<!-- 操作 -->
											 	<td class="center">
													<c:if test="${QX.edit != 1 && QX.del != 1 }">
													<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="ace-icon fa fa-lock" title="<%=no_permission %>"></i></span>
													</c:if>
													<c:if test="${strategy.status2=='2' }">
														<div class="btn-group">
														<c:if test="${QX.edit == 1 }">
															<a class="btn btn-mini btn-info" title="<%=edit %>" onclick="editStrategy(${strategy.id});"><%=edit %></a>
														</c:if>
														<c:if test="${QX.add == 1 }">
															<a class="btn btn-mini btn-success" title="<%=add_group %>" onclick="selectGroup(${strategy.id});"><%=add_group%></a>
														</c:if>
														<c:if test="${QX.del == 1 }">
															<a class="btn btn-xs btn-danger" title="<%=keck_delete_group %>" onclick="deleteGroup('${strategy.id}');"><%=keck_delete_group %></a>
														</c:if>
														</div>
													</c:if>
													<c:if test="${strategy.status2=='1' }">
													<span class="label label-large label-grey arrowed-in-right arrowed-in" title="已下发,无法操作"><i class="ace-icon fa fa-lock" ></i></span>
													</c:if>
												</td>
											</c:if>
										</tr>
									</c:forEach>
									</c:if>
									<c:if test="${QX.cha == 0 }">
										<tr>
											<td colspan="10" class="center"><%=you_have_no_permission %></td>
										</tr>
									</c:if>
								</c:when>
								<c:otherwise>
									<tr class="main_info">
										<td colspan="12" class="center"><%=no_relevant_data %></td>
									</tr>
								</c:otherwise>
							</c:choose>
							</tbody>
						</table>
						
					<div class="page-header position-relative">
					<table style="width:100%;">
						<tr>
							<c:if test="${empty pd.termid }">
							<td style="vertical-align:top;width:150px">
<%-- 							<c:if test="${'edit' == pd.op}"> --%>
								<c:if test="${QX.add == 1 }">
									<!-- 新增策略 -->
									<a class="btn btn-mini btn-success" onclick="addStrategy();"><%=add_strategy %></a>
								</c:if>
								<c:if test="${QX.del == 1 }">
									<!-- 删除策略 -->
									<a class="btn btn-mini btn-danger" title="<%=delete %>" onclick="makeAll('<%=make_sure_del_strategy%>');"><%=delete_strategy %></a>
								</c:if>
							</td>
							<td style="vertical-align:top;">
								<c:if test="${QX.add == 1 }">
									<!-- 下发策略 -->
									<a class="btn btn-mini btn-success" title="<%=send_strategy %>" onclick="makeAll('<%=make_sure_send_strategy%>');"><%=send_strategy %></a>
								</c:if>
								<c:if test="${QX.del == 1 }">
									<!-- 注销策略 -->
									<a class="btn btn-mini btn-danger" title="<%=cancel_strategy %>" onclick="makeAll('<%=make_sure_cancel_strategy%>');"><%=cancel_strategy %></a>
								</c:if>
<%-- 							</c:if> --%>
							</td>
							</c:if>
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
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	</body>

<script type="text/javascript">
$(top.hangge());

//清空检索条件
function clearSearchs(){
	$("#name-input").val("");
	$("#explain-input").val("");
}

//检索
function searchs(){
	top.jzts();
	$("#strategyForm").submit();
}

//新增策略
function addStrategy(){
	 top.jzts();
	 var diag = new top.Dialog();
	 diag.Drag=false;
	 diag.Title ="<%=add_strategy %>";
	 diag.URL = '<%=basePath%>strategy/goAddS.do';
	 diag.Width = 500;
	 diag.Height = 550;
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


//添加应用组
function selectGroup(strategy_id){
	 top.jzts();
	 var diag = new top.Dialog();
	 diag.Drag=true;
	 diag.Title ="<%=add_app_group %>";
	 diag.URL = '<%=basePath%>strategyGroup/listOthers.do?'+'&strategy_id='+strategy_id;
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

//踢删应用组
function deleteGroup(strategy_id){
	top.jzts();
	 var diag = new top.Dialog();
	 diag.Drag=true;
	 diag.Title ="<%=keck_delete_app_group %>";
	 diag.URL = '<%=basePath%>strategyGroup/listGroups.do?strategy_id='+strategy_id;
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

//修改策略
function editStrategy(strategy_id){
	 top.jzts();
	 var diag = new top.Dialog();
	 diag.Drag = false;
	 diag.Title = "<%=modify_strategy %>";
	 diag.URL = '<%=basePath%>strategy/goEditS.do?id='+strategy_id;
	 diag.Width = 500;
	 diag.Height = 550;
	 diag.CancelEvent = function(){ //关闭事件
		 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
			nextPage('${page.currentPage}');
		}
		diag.close();
	 };
	 diag.show();
}

//查看所选分组
function viewGroupMems(strategy_id){
	top.jzts();
	 var diag = new top.Dialog();
	 diag.Drag=true;
	 diag.Title ="<%=view_assigned_app_group %>";
	 diag.URL = '<%=basePath%>strategyGroup/viewGroups.do?strategy_id='+strategy_id;
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


//批量操作 删除策略/下发策略/注销策略
function makeAll(msg){
	bootbox.confirm(msg, function(result) {
		if(result) {
			var str = '';
			var emstr = '';
			var phones = '';
			var username = '';
			
			for(var i=0;i < document.getElementsByName('ids').length;i++)
			{
				if(document.getElementsByName('ids')[i].checked){
					var idsid = document.getElementsByName('ids')[i].id;
					var index = idsid.substr(3); 
					
					if(msg == "<%=make_sure_del_strategy %>"){
						//已下发的不能删除
						if(document.getElementsByName('status2')[index].value=='1'){
							$("#"+idsid).tips({
								side:3,
					            msg:'<%=strategy_is_sent %>',
					            bg:'#AE81FF',
					            time:8
					        });
							return;
						}					
					}else if(msg == "<%=make_sure_send_strategy %>"){						
						//已下发的不能再下发
						if(document.getElementsByName('status2')[index].value=='1'){
							$("#"+idsid).tips({
								side:3,
					            msg:'<%=strategy_is_sent %>',
					            bg:'#AE81FF',
					            time:8
					        });
							return;
						}
						//组数量为0 的不能再下发
						if(document.getElementsByName('termcnt')[index].value=='0'){
							$("#"+idsid).tips({
								side:3,
					            msg:'<%=this_strategy_not_assign_app_group %>',
					            bg:'#AE81FF',
					            time:8
					        });
							return;
						}
					}else if(msg == "<%=make_sure_cancel_strategy %>"){						
						// 未下发的不能注销
						if(document.getElementsByName('status2')[index].value=='2'){
							$("#"+idsid).tips({
								side:3,
					            msg:'<%=strategy_is_not_sent %>',
					            bg:'#AE81FF',
					            time:8
					        });
							return;
						}
					}
	
					if(str=='') str += document.getElementsByName('ids')[i].value;
					else str += ',' + document.getElementsByName('ids')[i].value;
				  }
			}
			
			if(str==''){
				bootbox.dialog({
					message: "<span class='bigger-110'><%=you_have_not_choose_anything %></span>",
					buttons: 			
					{ "button":{ "label":"<%=make_sure %>", "className":"btn-sm btn-success"}}
				});
				$("#zcheckbox").tips({
					side:3,
		            msg:'<%=click_this_choose_all %>',
		            bg:'#AE81FF',
		            time:8
		        });
				
				return;
			}else{
				if(msg == "<%=make_sure_del_strategy %>"){
					top.jzts();
					$.ajax({
						type: "POST",
						url: '<%=basePath%>strategy/deleteS.do?',
						data: {strategy_ids:"("+str+")"},
						dataType:'json',
						//beforeSend: validateData,
						cache: false,
						success: function(data){
							if("success" == data.result){
								nextPage('${page.currentPage}');
								$("#zhongxin").hide();
								$("#zhongxin2").show();
				    		    top.Dialog.close(); 
							}
						}
					});	
				}else if(msg == "<%=make_sure_send_strategy %>"){
					top.jzts();
					$.ajax({
						type: "POST",
						url: '<%=basePath%>strategy/sendS2.do?',
						data: {strategy_ids:"("+str+")"},
						dataType:'json',
						//beforeSend: validateData,
						cache: false,
						success: function(data){
							if("success" == data.result){
								nextPage('${page.currentPage}');
							}
						}
					});					
				}else if(msg == "<%=make_sure_cancel_strategy %>"){
					top.jzts();
					$.ajax({
						type: "POST",
						url: '<%=basePath%>strategy/cancelS2.do?',
						data: {strategy_ids:"("+str+")"},
						dataType:'json',
						//beforeSend: validateData,
						cache: false,
						success: function(data){
							if("success" == data.result){
								nextPage('${page.currentPage}');
							}
						}
					});					
				}
			}
		}
	});
};

$(function() {
	//日期框
	$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
	
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

		
</script>
</html>
