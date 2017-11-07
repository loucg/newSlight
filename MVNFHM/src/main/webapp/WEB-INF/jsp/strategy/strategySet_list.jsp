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
						
						<form action="strategy/listStrategySet.do" method="post" name="strategysetForm" id="strategysetForm">
						<div id="zhongxin" style="padding-top: 13px;">
						<input type="hidden" id="c_term_id" name="c_term_id" value="${pd.c_term_id}">
						<!-- 检索  -->
						<table style="margin-top:5px;">
							<tr>
							    <td><%=strategyset_name %>：</td>
								<td>
									<div class="nav-search">
										<input type="text" class="nav-search-input" id="name-input" autocomplete="off" name="name" placeholder="<%=please_enter_strategyset_name %>" value="${pd.name}"/>
									</div>
								</td>
								<td>&nbsp;&nbsp;<%=strategyset_explain %>：</td>
								<td>
									<div class="nav-search">
										<input type="text" class="nav-search-input" id="explain-input" autocomplete="off" name="explain" placeholder="<%=please_enter_strategyset_explain %>" value="${pd.explain}"/>
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
					
						<table id="simple-table" class="table table-striped table-bordered table-hover" style="margin-top:10px;">	
							<thead>
								<tr>
									<!-- 选择框 -->
									<c:if test="${not empty pd.c_term_id }">
									<th class="center" style="width:35px;">
<!-- 										<label class="pos-rel"><input type="checkbox" class="ace" id="zcheckbox" /><span class="lbl"></span></label> -->
									</th>
									</c:if>
									<th class="center" style="width:50px;"><%=number %></th>
									<th class="center" style="width: 30%;"><%=strategyset_name %></th>
									<!-- 策略数 -->	
									<th class="center" style="width:100px;"><%=strategy_number %></th>
									<th class="center"><%=strategyset_explain %></th>
									<c:if test="${empty pd.c_term_id }">
										<!-- 操作 -->
										<th class="center" style="width:220px;"><%=operate %></th>
									</c:if>
								</tr>
							</thead>
							<tbody>
							<!-- 开始循环 -->	
							<c:choose>
								<c:when test="${not empty strategySetList}">
									<c:if test="${QX.cha == 1 }">
									<c:forEach items="${strategySetList}" var="strategySet" varStatus="vs">
										<tr>
											<!-- 选择框 -->	
											<c:if test="${not empty pd.c_term_id }">
											<td class='center'>
<%-- 												<label class="pos-rel"><input type='checkbox' name='ids' id="ids${vs.index}" value="${strategySet.id}" class="ace" /><span class="lbl"></span></label> --%>
													<label class="pos-rel"><input type='radio' name='ids' id="ids${vs.index}" value="${strategySet.id}" class="ace" /><span class="lbl"></span></label>
<%-- 												<input type="hidden" id="status2${vs.index}" name="status2" value="${strategy.status2}"> --%>
<%-- 												<input type="hidden" id="termcnt${vs.index}" name="termcnt" value="${strategy.termcnt}"> --%>
											</td>
											</c:if>
											<!-- 序号 -->	
											<td class='center'>${vs.index+1+(page.currentPage-1)*page.showCount}</td>
											<td class='center'><a onclick="viewStrategyMems('${strategySet.id}')" style="cursor:pointer;">${strategySet.name}</a></td>
											<!-- 策略数 -->	
											<td class='center'>${strategySet.strategycnt}</td>
											<td class='center'>${strategySet.explain}</td>
											<c:if test="${empty pd.c_term_id }">
												<!-- 操作 -->
											 	<td class="center">
													<c:if test="${QX.edit != 1 && QX.del != 1 }">
													<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="ace-icon fa fa-lock" title="<%=no_permission %>"></i></span>
													</c:if>
													<div class="btn-group">
													<c:if test="${QX.edit == 1 }">
														<a class="btn btn-mini btn-info" title="<%=edit %>" onclick="editStrategySet('${strategySet.id}');">
															<%=edit %>
														</a>
													</c:if>
													<c:if test="${QX.del == 1 }">
														<a class="btn btn-xs btn-danger" title="<%=delete %>" onclick="deleteStrategySet('<%=make_sure_del_strategyset%>','${strategySet.id}');">
															<%=delete %>
														</a>
														<%-- <a class="btn btn-warning btn-mini" onclick="selectStrategy(${strategySet.id});" title="<%=select_strategy %>">
															<%=select_strategy %>
														</a>
														<a class="btn btn-xs btn-danger" title="<%=kick_delete_strategy %>" onclick="deleteStrategy(${strategySet.id});">
															<%=kick_delete_strategy %>
														</a> --%>
													</c:if>
													</div>
												</td>
											</c:if>
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
							<c:if test="${empty pd.c_term_id }">
								<td style="vertical-align:top;">
									<c:if test="${QX.add == 1 }">
									<a class="btn btn-warning btn-mini" onclick="addStrategySet()" title="<%=add_strategy_set %>"><%=add_strategy_set %></a>
									</c:if>
								</td>
							</c:if>
							<c:if test="${not empty pd.c_term_id }">
								<!-- 添加策略包 -->
								<td style="vertical-align:top;">
									<c:if test="${QX.edit == 1 }">
									<a class="btn btn-mini btn-success" onclick="applyStrategySet('<%=make_sure_apply_strategyset%>')" title="<%=apply %>"><%=apply %></a>
									</c:if>
									<c:if test="${QX.del == 1 }">
									<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();"><%=cancel%></a>
									</c:if>
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
	$("#strategysetForm").submit();
}

//新增策略包
function addStrategySet(){
	 top.jzts();
	 var diag = new top.Dialog();
	 diag.Drag=false;
	 diag.Title ="<%=add_strategy_set %>";
	 diag.URL = '<%=basePath%>strategy/goAddSet.do';
	 diag.Width = 469;
	 diag.Height = 210;
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


//修改策略包
function editStrategySet(strategySet_id){
	 top.jzts();
	 var diag = new top.Dialog();
	 diag.Drag=false;
	 diag.Title ="<%=modify_strategy_set %>";
	 diag.URL = '<%=basePath%>strategy/goEditSet.do?id='+strategySet_id;
	 diag.Width = 469;
	 diag.Height = 210;
	 diag.CancelEvent = function(){ //关闭事件
		 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
			nextPage('${page.currentPage}');
		}
		diag.close();
	 };
	 diag.show();
}

//删除策略包
function deleteStrategySet(msg,strategySet_id){
	bootbox.confirm(msg, function(result) {
		if(result) {
			top.jzts();
			$.ajax({
				type: "POST",
				url: '<%=basePath%>strategy/delSet.do?',
				data: {ID:strategySet_id},
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
		}
	});
}


<%-- //踢删策略
function deleteStrategy(strategySet_id){
	 top.jzts();
	 var diag = new top.Dialog();
	 diag.Drag=true;
	 diag.Title ="<%=kick_delete_strategy %>";
	 diag.URL = "<%=basePath%>strategy/listStrategy2.do?op=del&strategysetid="+strategySet_id;
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
 --%>
<%-- //选择策略
function selectStrategy(strategySet_id){
	 top.jzts();
	 var diag = new top.Dialog();
	 diag.Drag=true;
	 diag.Title ="<%=select_strategy %>";
	 diag.URL = "<%=basePath%>strategy/listStrategys.do?op=add&strategysetid="+strategySet_id;
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

//查看所选策略
function viewStrategyMems(strategySet_id){
	top.jzts();
	window.location.href="<%=basePath%>strategy/listStrategy2.do?strategysetid="+strategySet_id+"&c_term_id=${pd.c_term_id }";
}

//选择策略包到分组
function applyStrategySet(msg,c_term_id){
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
				if(msg == "<%=make_sure_apply_strategyset %>"){
					top.jzts();
					$.ajax({
						type: "POST",
						url: '<%=basePath%>strategy/insertApplySet.do?',
						data: {strategyset_ids:str,c_term_id:document.getElementById('c_term_id').value},
						dataType:'json',
						//beforeSend: validateData,
						cache: false,
						success: function(data){
							if("success" == data.result){
// 								nextPage('${page.currentPage}');
								$("#zhongxin").hide();
								$("#zhongxin2").show();
				    		    top.Dialog.close();
							}else{
								setTimeout("self.location=self.location",0);			
								alert(data.msg);
							}
						}
					});
				}
			}
		}
	});
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
