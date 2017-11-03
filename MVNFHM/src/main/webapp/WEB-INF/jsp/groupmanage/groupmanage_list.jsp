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
								<td>&nbsp;&nbsp;<%=summary %>：</td>
								<td>
									<div class="nav-search">
										<span class="input-icon">
											<input type="text" class="nav-search-input" id="nav-search-input" autocomplete="off" name="explain" value="${pd.explain }"/>
										</span>
									</div>
								</td>
								<%-- <td>&nbsp;&nbsp;<%=status %>：</td>
								<td style="vertical-align:top;padding-left:2px;"> 
								 	<select class="chosen-select form-control" name="status" id="status" data-placeholder=" " style="vertical-align:top;width: 130px;height:30px">
										<option value=""></option>
										<option value="3"<c:if test="${pd.status == '3'}">selected</c:if> ><%=total %></option>
										<option value="1"<c:if test="${pd.status == '1'}">selected</c:if> ><%=effective %></option>
										<option value="2"<c:if test="${pd.status == '2'}">selected</c:if> ><%=invalid %></option>
									</select>
								</td> --%>
								<c:if test="${QX.cha == 1 }">
								<td style="vertical-align:top;padding-left:2px"><a class="btn btn-light btn-xs" onclick="tosearch();"  title="<%=search2 %>" style="padding: 3px 3px;"><i id="nav-search-icon" class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i></a></td>
								</c:if>
							</tr>
						</table>
						<!-- 检索  -->
					
						<table id="simple-table" class="table table-striped table-bordered table-hover" style="margin-top:5px;">	
							<thead>
								<tr>
									<th class="center" style="width:35px;">
										<label class="pos-rel">
											<input type="checkbox" class="ace" id="zcheckbox" />
											<span class="lbl"></span>
										</label>
									</th>
									<th class="center" style="width:50px;"><%=number %></th>
									<th class="center"><%=name %></th>
									<th class="center"><%=summary %></th>
<%-- 									<th class="center"><%=status %></th> --%>
<%-- 									<th class="center"><%=ctrl_strategy %></th> --%>
									<th class="center" style="width:100px;"><%=menber_number %></th>
									<!-- 策略包 -->
									<th class="center" style="width:400px;"><%=strategy_set %></th>
									<th class="center" style="width:200px;"><%=operate %></th>
								</tr>
							</thead>
													
							<tbody>
							<!-- 开始循环 -->	
							<c:choose>
								<c:when test="${not empty groupList}">
									<c:if test="${QX.cha == 1 }">
									<c:forEach items="${groupList}" var="group" varStatus="vs">
										<tr>
										<th class="center">	
											<label class="pos-rel"><input type="checkbox" class="ace" name='ids' id="ids${vs.index}" value="${group.id}" /><span class="lbl"></span></label>
										</th>
											<td class='center' style="width: 30px;">${vs.index+1}<input type='hidden' name="hdstrategyIds" value="${group.strategy_num}"/></td>
											<td class='center'>${group.name}<input type='hidden' name="hdgroupname" value="${group.name}"/></td>
											<td class='center'>${group.explain}</td>
<%-- 											<td class='center'>${group.STATUS}</td> --%>
<%-- 											<td class='center'>${group.strategy_num}</td> --%>
											<!-- 成员数量 -->
											<td class='center' style="background-color: #E1FFFF;"><a onclick="viewGroupMems('${group.id}')" style="cursor:pointer;">${group.number }</a></td>
											<!-- 策略包 -->
									   		<td class='center'>
										   		<table style="width:100%;">
										   		<tr><td>
<%-- 										   			<select class="chosen-select form-control" name="strategyset" id="strategyset${vs.index}" style="height:30px;width: 158px;border-width:1px;border-color:'#fff';border-radius:4px"> --%>
<%-- 										   			<c:forEach items="${group.strategysetList}" var="strategyset" varStatus="strategysetvs">  --%>
<%-- 											 			<option value=${strategyset.id}>${strategyset.name}</option> --%>
<%-- 										   			</c:forEach> --%>
<!-- 													</select> -->
														<c:forEach items="${group.strategysetList}" var="strategyset" varStatus="strategysetvs"><a onclick="viewStrategyMems('${group.id}','${strategyset.id}')" style="cursor:pointer;">${strategyset.name} </a></c:forEach>
												</td><td  style="width:35px;">
													<c:if test="${group.number>0 }">
<%-- 													<a class="btn btn-xs btn-danger" onclick="deleteStrategySet('${group.id}','strategyset${vs.index}')" ><%=del_apply_strategyset %></a> --%>
<%-- 													<a class="btn btn-xs btn-success" onclick="selectStrategySet('${group.id}','${group.number }')" ><%=add_apply_strategyset %></a> --%>
														<c:if test="${QX.del == 1 && group.strategy_num > 0}">
														<a onclick="deleteStrategySet('${group.id}','${group.strategysetList[0].id}')" style="cursor:pointer;" alt="<%=del_apply_strategyset %>" title="<%=del_apply_strategyset %>"><img src="<%=basePath%>static/images/remove.jpg" /></a>
														</c:if><c:if test="${QX.add == 1 && group.strategy_num <= 0}">														
														<a onclick="selectStrategySet('${group.id}','${group.number }')" style="cursor:pointer;" alt="<%=add_apply_strategyset %>" title="<%=add_apply_strategyset %>"><img src="<%=basePath%>static/images/add.jpg" /></a>
														</c:if>
													</c:if>
												</td></tr>
										   		</table>
<%-- 										   		<a class="btn btn-xs btn-success" onclick="selectStrategySet('${group.id}')" ><%=add2 %></a> --%>
<%-- 										   		<a onclick="selectStrategySet('${group.id}')" style="cursor:pointer;">&nbsp;+&nbsp;</a> --%>
									   		</td>
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
									<c:if test="${QX.del == 1 }">
									<a class="btn btn-xs btn-danger" onclick="del();"><%=del_divide_group %></a>
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
		

		//新增分组
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

		//修改分组
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
		
		//删除分组
		function del(){
			var str='';
			 if(confirm("确定要删除分组？")){
				for(var i=0;i < document.getElementsByName('ids').length;i++){
					if(document.getElementsByName('ids')[i].checked){
						if(document.getElementsByName('hdstrategyIds')[i].value>0){
							alert('分组:'+document.getElementsByName('hdgroupname')[i].value+' 有策略存在，不能删除,请重新选择！');
							return;
						}
						if(str=='') str += document.getElementsByName('ids')[i].value;
						else str += ',' + document.getElementsByName('ids')[i].value;
					}
				}
			 }else{
				 return ;
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
				 $.ajax({
						type: "POST",
						url: '<%=basePath%>group/goDel.do?',
						data: {group_ids:""+str+""},
						dataType:'json',
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
		}
		
		//加入策略包
		function selectStrategySet(group_id){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="<%=add_apply_strategyset %>";
			 diag.URL = "<%=basePath%>strategy/goSelectSet.do?c_term_id="+group_id;
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
		
		//查看策略包中策略 
		function viewStrategyMems(group_id, strategysetid){
			top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="<%=strategyset_member %>";
			 diag.URL = "<%=basePath%>strategy/listStrategy2Apply.do?c_term_id="+group_id+"&strategysetid="+strategysetid;
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
		
		//删除策略包
		function deleteStrategySet(group_id, strategysetid){
			if(confirm('<%=make_sure_del_strategyset %>')){
				$.ajax({
					type: "POST",
					url: '<%=basePath%>strategy/delApplySet.do',
			    	data: {c_term_id:group_id,strategyset_id:strategysetid},
					dataType:'json',
					cache: false,
					success: function(data){
						nextPage('${page.currentPage}');
						$("#zhongxin").hide();
						$("#zhongxin2").show();
		    		    top.Dialog.close(); 
					}
				});
			}
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
			diag.URL = '<%=basePath%>group/listGateways.do?term_id='+id+'&op=v';	//v 查看
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
		<%-- function viewGroupMems(id){
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
		} --%>
			
		
		
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