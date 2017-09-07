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
						<form action="group/listGroups.do" method="post" name="Form" id="Form">
						<table style="margin-top:5px;">
							<tr>
								<td><%=name %>：</td>
								<td>
									<div class="nav-search">
										<span class="input-icon">
											<input type="text" class="nav-search-input" id="nav-search-input" autocomplete="off" name="name" value="${pd.name }"/>
										</span>
									</div>
								</td>
								<td>&nbsp;&nbsp;<%=explain_item %>：</td>
								<td>
									<div class="nav-search">
										<span class="input-icon">
											<input type="text" class="nav-search-input" id="nav-search-input" autocomplete="off" name="explain" value="${pd.explain }"/>
										</span>
									</div>
								</td>
								<c:if test="${QX.cha == 1 }">
								<td style="vertical-align:top;padding-left:2px"><a class="btn btn-light btn-xs" onclick="tosearch();"  title="<%=search2 %>" style="padding: 3px 3px;"><i id="nav-search-icon" class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i></a></td>
								</c:if>
							</tr>
						</table>
						<!-- 检索  -->
					
						<table id="simple-table" class="table table-striped table-bordered table-hover" style="margin-top:5px;">	
							<thead>
								<tr>
									<th class="center" style="width:50px;"><%=number %></th>
									<th class="center"><%=name %></th>
									<th class="center"><%=summary %></th>
									<th class="center"><%=status %></th>
<%-- 									<th class="center"><%=ctrl_strategy %></th>s --%>
									<th class="center"><%=menber_number %></th>
									<th class="center" style="width: 150px;"><%=operate %></th>
								</tr>
							</thead>
													
							<tbody>
							<!-- 开始循环 -->	
							<c:choose>
								<c:when test="${not empty groupList}">
									<c:if test="${QX.cha == 1 }">
									<c:forEach items="${groupList}" var="group" varStatus="vs">
										<tr>
											<td class='center' style="width: 30px;">${vs.index+1}</td>
											<td class='center'>${group.name}</td>
											<td class='center'>${group.explain}</td>
											<td class='center'>${group.STATUS}</td>
<%-- 											<td class='center'>${group.strategy_num}</td> --%>
											<td class='center'><a onclick="viewGroupMems('${group.id}')" style="cursor:pointer;">${group.number }</a></td>
									   <%-- <td class='center'>${group.number}</td> --%>
											<td class='center'>
												<c:if test="${QX.edit != 1 && QX.del != 1 }">
												<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="ace-icon fa fa-lock" title="<%=no_permission %>"></i></span>
												</c:if>
												<div class="hidden-sm hidden-xs btn-group">
													<c:if test="${QX.edit == 1 }">
													<a class="btn btn-xs btn-success" title="<%=edit %>" onclick="editGroup('${group.id}');">
														<%=edit %>
													</a>
													</c:if>
												<%-- 有策略时不可操作 --%>
												<c:if test="${group.strategy_num <= 0 }">
													<c:if test="${QX.edit == 1 }">
													<a class="btn btn-xs btn-danger" onclick="addCrew('${group.id}');" >
														<%=add2 %>
													</a>
													</c:if>
													<c:if test="${QX.del == 1 }">
													<a class="btn btn-xs btn-danger" onclick="delCrew('${group.id}','${group.name}' );">
														<%=kick_delete %>
													</a>
												</c:if> 
												</c:if>
												<%-- 有策略时不可操作 --%>
												<c:if test="${group.strategy_num <= 0 }">
													<div class="inline pos-rel">
														<button
															class="btn btn-minier btn-blue dropdown-toggle"
															data-toggle="dropdown" data-position="auto">
															<i
																class="ace-icon fa fa-caret-down icon-only bigger-120"></i>
														</button>
	
														<ul class="dropdown-menu dropdown-only-icon dropdown-blue dropdown-menu-right dropdown-caret dropdown-close">
															<c:if test="${QX.edit == 1 }">
															<li><a class="tooltip-info" data-rel="tooltip" title="<%=smart_divide_group_by_odd_and_even %>" onclick="groupOddeven('${group.id}','${group.number}');">
																<span class="black"><%=smart_divide_group_by_odd_and_even %>
																</span>
															</a></li>
															<li><a class="tooltip-success" data-rel="tooltip" title="<%=smart_divide_group_by_power %>" onclick="groupPower('${group.id}','${group.number}');">
																<span class="black"><%=smart_divide_group_by_power %>
																</span>
															</a></li>
															</c:if>
														</ul>
													</div>
												</c:if>
												<c:if test="${group.strategy_num > 0 }">
													<span class="label label-large label-grey arrowed-in-right arrowed-in" title="关联有策略时不能进行其他操作！"><i class="ace-icon fa fa-lock" ></i></span>
												</c:if>
												</div> 
												
												<%-- <div class="hidden-md hidden-lg">
													<div class="inline pos-rel">
														<button
															class="btn btn-minier btn-yellow dropdown-toggle"
															data-toggle="dropdown" data-position="auto">
															<i
																class="ace-icon fa fa-caret-down icon-only bigger-120"></i>
														</button>
	
														<ul class="dropdown-menu dropdown-only-icon dropdown-yellow dropdown-menu-right dropdown-caret dropdown-close">
															<c:if test="${QX.edit == 1 }">
															<li><a class="tooltip-info" data-rel="tooltip" title="编辑" onclick="editGroup('${group.id}');">
																<span class="blue">
																	<i class="ace-icon glyphicon glyphicon-picture bigger-120" title="编辑"></i>
																</span>
															</a></li>
															<li><a class="tooltip-success" data-rel="tooltip" onclick="addCrew('${group.id}');">
																<span class="green">
																	<i class="ace-icon fa fa-pencil-square-o bigger-120" title="新增"></i>
																</span>
															</a></li>
															</c:if>
															<c:if test="${QX.del == 1 }">
															<li><a class="tooltip-error" data-rel="tooltip" onclick="delCrew('${group.id}','${group.name}' );">
																<span class="red"> <i class="ace-icon fa fa-trash-o bigger-120"  title="踢删"></i>
																</span>
															</a></li>
															</c:if>
														</ul>
													</div>
												</div>  --%>
												
												
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
									<a class="btn btn-mini btn-success" onclick="add();"><%=add_divide_group %></a>
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
		});	
		
		//修改
		function editGroup(id){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="<%=modify %>";
			 diag.URL = '<%=basePath%>group/goUpdate.do?id='+id;
			 diag.Width = 469;
			 diag.Height = 188;
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					nextPage('${page.currentPage}');
				}
				diag.close();
			 };
			 diag.show();
		}
		

		//新增组
		function add(){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="<%=add2 %>";
			 diag.URL = '<%=basePath%>group/goAdd.do';
			 diag.Width = 460;
			 diag.Height = 188;
			 diag.Modal = true;				//有无遮罩窗口
			 diag. ShowMaxButton = true;	//最大化按钮
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
		
		//新增组员
		function addCrew(id){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="<%=add_group_member2 %>";
			 diag.URL = '<%=basePath%>group/listGateways.do?term_id='+id;
			 diag.Width = 1200;
			 diag.Height = 600;
			 diag.Modal = true;				//有无遮罩窗口
			 diag. ShowMaxButton = true;	//最大化按钮
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
		
		//踢删组员
		function delCrew(id,name){
			top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="<%=keck_delete_group_member %>";
			 diag.URL = '<%=basePath%>groupmem/listMems.do?id='+id;
			 diag.Width = 1200;
			 diag.Height = 600;
			 diag.Modal = true;				//有无遮罩窗口
			 diag. ShowMaxButton = true;	//最大化按钮
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
			 diag.URL = '<%=basePath%>groupmem/listMems.do?id='+id;
			 diag.Width = 1200;
			 diag.Height = 600;
			 diag.Modal = true;				//有无遮罩窗口
			 diag. ShowMaxButton = true;	//最大化按钮
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
		
		
		//智能拆分组-奇偶分组
		function groupOddeven(id,number){
			bootbox.confirm("<%=make_sure_divider_group_by_odd_and_even %>?", function(result) {
				if(result) {
					//top.jzts();
					var url = '<%=basePath%>smartgroup/groupOddeven.do?id='+id+'&number='+number;
					$.get(url,function(data){
						if(data){
							nextPage('${page.currentPage}');
							console.info("----------");
						}else{
							
							bootbox.confirm("<%=this_group_can_not_divide_odd_and_even %>！！！", function(result2) {
								nextPage('${page.currentPage}');
								
							});
							
						}
					});
				}
			});
		}
		
		
		
		//智能拆分组-功率分组
		function groupPower(id, number){
			bootbox.confirm("<%=make_sure_divider_group_by_power %>?", function(result) {
				if(result) {
					//top.jzts();
					var url = '<%=basePath%>smartgroup/groupPower.do?id='+id+'&number='+number;
					$.get(url,function(data){
						if(data){
							nextPage('${page.currentPage}');
							console.info("----------");
						}else{
							
							bootbox.confirm("<%=this_group_can_not_divide_by_power %>！！！", function(result2) {
								nextPage('${page.currentPage}');
								
							});
							
						}
					});
				}
			});
		}
		
		
		
		
	</script>


</body>
</html>