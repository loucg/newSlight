<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
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
						
						<form action="strategy/${msg }.do" method="post" name="strategy2Form" id="strategy2Form">
						<input type="hidden" id="strategysetid" name="strategysetid" value="${pd.strategysetid}">
						<input type="hidden" id="c_term_id" name="c_term_id" value="${pd.c_term_id}">
						<input type="hidden" id="apply" name="apply" value="${pd.apply}">
						<div id="zhongxin" style="padding-top: 13px;">
						<!-- 返回  -->
						<c:if test="${empty pd.apply }">
							<table style="width:100%;margin-top:5px;">
							<tr>
								<td style="vertical-align:top;">
									<a class="btn btn-mini btn-grey" onclick="goStrategySet('${pd.c_term_id}','${pd.strategysetid}');"><%=return1 %></a>
								</td>
							</tr>
							</table>
						</c:if>
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
<%-- 								<c:if test="${QX.cha == 1 }"> --%>
<%-- 								<td style="vertical-align:top;padding-left:2px;">&nbsp;&nbsp;<a class="btn btn-light btn-xs" onclick="clearSearchs();"  title="<%=clear_search_ %>" style="padding: 4px 4px;"><i id="nav-clear-icon" class="ace-icon fa fa-search bigger-110 nav-search-icon red"></i></a></td> --%>
<%-- 								</c:if> --%>
								<c:if test="${QX.cha == 1 }">
								<td style="vertical-align:top;padding-left:2px;">&nbsp;&nbsp;<a class="btn btn-light btn-xs" onclick="searchs();"  title="<%=search1 %>" style="padding: 3px 3px;"><i id="nav-search-icon" class="ace-icon fa fa-search bigger-110 nav-search-icon white"></i><%=search1 %></a></td>
								</c:if>
							</tr>
						</table>
						<!-- 检索  -->

						<table id="simple-table" class="table table-striped table-bordered table-hover"  style="margin-top:5px;">
							<thead>
								<tr>
									<!-- 选择框 -->
									<c:if test="${empty pd.c_term_id }">
									<th class="center" style="width:35px;" nowrap="nowrap">
									<label class="pos-rel"><input type="checkbox" class="ace" id="zcheckbox" /><span class="lbl"></span></label>
									</th>
									</c:if>
									<th class="center" style="width:50px" nowrap="nowrap"><%=number %></th>
									<th class="center" style="width:100px" nowrap="nowrap"><%=type %></th>
									<th class="center" nowrap="nowrap"><%=strategy_name %></th>
									<th class="center" style="width:100px" nowrap="nowrap"><%=start_date %></th>
									<th class="center" style="width:100px" nowrap="nowrap"><%=end_date %></th>
									<th class="center" style="width:80px" nowrap="nowrap"><%=month_cycle %></th>
									<th class="center" style="width:100px" nowrap="nowrap"><%=day_apply_days %></th>
									<th class="center" style="width:50px" nowrap="nowrap"><%=time %></th>
									<th class="center" style="width:120px" nowrap="nowrap"><%=adjust_value %></th>
									<th class="center" style="width:120px" nowrap="nowrap"><%=brightness %></th>
									<%-- <th class="center" style="width:80px"><%=term_num_in_strategy %></th> --%>
<%-- 									<c:if test="${empty pd.c_term_id }"> --%>
<%-- 										<th class="center"><%=send_status %></th> --%>
<%-- 									</c:if> --%>
									<th class="center" nowrap="nowrap"><%=app_explain %></th>
									<c:if test="${empty pd.c_term_id }">
										<th class="center" style="width:100px" nowrap="nowrap"><%=operate %></th>
									</c:if>
								</tr>
							</thead>
							<tbody>
								
							<!-- 开始循环 -->	
							<c:choose>
								<c:when test="${not empty strategy2List}">
									<c:if test="${QX.cha == 1 }">
									<c:forEach items="${strategy2List}" var="strategy2" varStatus="vs">
										<tr>
											<!-- 选择框 -->
											<c:if test="${empty pd.c_term_id }">
												<td class='center'>
													<c:if test="${'1'!=strategy2.status2 }">
													<label class="pos-rel"><input type='checkbox' name='ids' id="ids${vs.index}" value="${strategy2.id}" class="ace" /><span class="lbl"></span></label>
													</c:if>
													<input type="hidden" id="status2${vs.index}" name="status2" value="${strategy2.status2}">
												</td>
											</c:if>
											<!-- 序号 -->	
											<td class='center'>${vs.index+1+(page.currentPage-1)*page.showCount}</td>
											<!-- 类型 -->	
											<td class="center">${strategy2.strategy_type }</td>
											<!-- 名称 -->
											<td class="center">${strategy2.name }</td>
											<!-- 开始日期 -->
											<td class="center">${strategy2.datetime1 }</td>
											<!-- 结束日期  -->
											<td class="center">${strategy2.datetime2 }</td>
											<c:if test="${strategy2.b_strategy_type_id=='1' }">
												<!-- 月/周期 -->
												<td class="center">${strategy2.month }</td>
												<!-- 日/执行天数 -->
												<td class="center">${strategy2.day }</td>												
											</c:if>
											<c:if test="${strategy2.b_strategy_type_id=='2' }">
												<!-- 月/周期 -->
												<td class="center">${strategy2.period }</td>
												<!-- 日/执行天数 -->
												<td class="center">${strategy2.days }</td>
											</c:if>
											<!-- 时间 -->
											<td class="center">${strategy2.time }</td>
											<!-- 调节值 -->
											<td id="adjustvalue" class="center">
												<table style="width:150px;" >
												<c:if test="${fn:startsWith(strategy2.value, 'C')}">  
													<tr><td><img src="static/images/light-red.png" /></td><td width="50px">${strategy2.value1 }</td></tr>
													<tr><td><img src="static/images/light-green.png" /></td><td width="50px">${strategy2.value2 }</td></tr>
													<tr><td><img src="static/images/light-blue.png" /></td><td width="50px">${strategy2.value3 }</td></tr>
												</c:if>
												<c:if test="${fn:startsWith(strategy2.value, 'T')}">
													<tr><td style="background-color:yellow;">${strategy2.value1 }</td>
													<td style="background-color:white;">${strategy2.value2 }</td></tr>
												</c:if>
												</table>
											</td>
											<!-- 亮度 -->
											<td class="center">
												<c:choose><c:when test="${'0' == strategy2.bright}"><%=off %></c:when><c:when test="${'255' == strategy2.bright}"><%=on %></c:when>
												<c:otherwise>${strategy2.bright }</c:otherwise></c:choose>
											</td>
											<!-- 组数量 -->
											<%-- <td class="center">
												<c:choose><c:when test="${strategy2.termcnt>0}">
													<a onclick="viewGroupMems('${strategy2.id}')" style="cursor:pointer;">${strategy2.termcnt }</a>
												</c:when><c:otherwise>
													${strategy2.termcnt }
												</c:otherwise></c:choose>
											</td> --%>
<%-- 											<c:if test="${empty pd.c_term_id }"> --%>
												<!-- 下发状态 -->
<%-- 												<td class="center">${strategy2.send_status }</td> --%>
<%-- 											</c:if> --%>
											<!-- 说明 -->
											<td class="center">${strategy2.explain }</td>
											
											<c:if test="${empty pd.c_term_id }">
												<!-- 操作 -->
											 	<td class="center">
													<c:if test="${QX.edit != 1 && QX.del != 1 }">
													<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="ace-icon fa fa-lock" title="<%=no_permission %>"></i></span>
													</c:if>
													<c:if test="${strategy2.status2=='2' }">
														<div class="btn-group">
														<c:if test="${QX.edit == 1 }">
<%-- 															<a class="btn btn-mini btn-info" title="<%=edit %>" onclick="editStrategy2(${strategy2.id});"><%=edit %></a> --%>
															<a style="cursor: pointer;" onclick="editStrategy2(${strategy2.id});" class="tooltip-success" data-rel="tooltip" title="<%=modify %>">
																<span class="green"> <i class="ace-icon fa fa-pencil bigger-140"></i></span>
															</a>
														</c:if>
														</div>
													</c:if>
													<c:if test="${strategy2.status2=='1' }">
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
							<c:if test="${empty pd.c_term_id }">
								<td style="vertical-align:top;">
									<a class="btn btn-sm btn-info btn-blue" onclick="addStrategy('${pd.strategysetid}');" title="<%=add_strategy %>">
										<i class="ace-icon fa fa-plus-square bigger-120 white"></i>&nbsp;<%=add_strategy %>
									</a>
									<a class="btn btn-sm btn-danger" title="<%=delete_strategy %>" onclick="makeAll('<%=make_sure_del_strategy%>');">
										<i class="ace-icon fa fa-trash-o bigger-120 white"></i>&nbsp;<%=delete_strategy %>
									</a>
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
	$("#strategy2Form").submit();
}


//添加应用组
function selectGroup(strategy2_id){
	 top.jzts();
	 var diag = new top.Dialog();
	 diag.Drag=true;
	 diag.Title ="<%=add_app_group %>";
	 diag.URL = '<%=basePath%>strategyGroup/listOthers.do?'+'&strategy2_id='+strategy2_id;
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
function deleteGroup(strategy2_id){
	top.jzts();
	 var diag = new top.Dialog();
	 diag.Drag=true;
	 diag.Title ="<%=keck_delete_app_group %>";
	 diag.URL = '<%=basePath%>strategyGroup/listGroups.do?strategy2_id='+strategy2_id;
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
function editStrategy2(strategy_id){
	 top.jzts();
	 var diag = new top.Dialog();
	 diag.Drag = false;
	 diag.Title = "<%=modify_strategy %>";
	 diag.URL = '<%=basePath%>strategy/goEditS2.do?id='+strategy_id+'&backurl=strategy/listStrategy2.do';
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
<%-- function viewGroupMems(strategy2_id){
	top.jzts();
	 var diag = new top.Dialog();
	 diag.Drag=true;
	 diag.Title ="<%=keck_delete_app_group %>";
	 diag.URL = '<%=basePath%>strategyGroup/viewGroups.do?strategy2_id='+strategy2_id;
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
} --%>

//选择策略
<%-- function selectStrategy(strategySet_id){
	 top.jzts();
	 var diag = new top.Dialog();
	 diag.Drag=true;
	 diag.Title ="<%=select_strategy %>";
	 diag.URL = "<%=basePath%>strategy/listStrategys.do?strategysetid="+strategySet_id;
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
} --%>

//新建策略
function addStrategy(strategySet_id){
	 top.jzts();
	 var diag = new top.Dialog();
	 diag.Drag=true;
	 diag.Title ="<%=add_strategy %>";
	 diag.URL = "<%=basePath%>strategy/goAddS2.do?strategyset_id="+strategySet_id;
	 diag.Width = 500;
	 diag.Height = 550;
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


//批量操作 删除策略/* /下发策略/注销策略 */
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
					
<%-- 					if(msg == "<%=make_sure_send_strategy %>"){ --%>
// 						//已下发的不能再下发和删除
// 						var idsid = document.getElementsByName('ids')[i].id;
// 						var index = idsid.substr(3); 
						
// 						if(document.getElementsByName('status2')[index].value=='1'){
// 							$("#"+idsid).tips({
// 								side:3,
<%-- 					            msg:'<%=strategy_is_sended %>', --%>
// 					            bg:'#AE81FF',
// 					            time:8
// 					        });
// 							return;
// 						}
<%-- 					}else if(msg == "<%=make_sure_cancel_strategy %>"){ --%>
// 						// 未下发的不能注销
// 						var idsid = document.getElementsByName('ids')[i].id;
// 						var index = idsid.substr(3); 
						
// 						if(document.getElementsByName('status2')[index].value=='2'){
// 							$("#"+idsid).tips({
// 								side:3,
<%-- 					            msg:'<%=strategy_is_not_sended %>', --%>
// 					            bg:'#AE81FF',
// 					            time:8
// 					        });
// 							return;
// 						}
// 					} 
	 
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
						url: '<%=basePath%>strategy/deleteS2.do?',
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
				<%-- }else if(msg == "<%=make_sure_send_strategy %>"){
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
					}); --%>					
				}
			}
		}
	});
};

//返回策略组一览画面
function goStrategySet(c_term_id,strategysetid){	
	top.jzts();
	if(c_term_id==''){
		window.location.href="<%=basePath%>strategy/listStrategySet.do?c_term_id="+ c_term_id+ "&strategysetid="+ strategysetid;
	}else{
		window.location.href="<%=basePath%>strategy/goSelectSet.do?c_term_id="+ c_term_id+ "&strategysetid="+ strategysetid;
	}
	//companyid="+strategysetid;
}


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
