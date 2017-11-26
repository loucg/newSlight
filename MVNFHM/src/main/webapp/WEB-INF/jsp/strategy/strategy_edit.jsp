<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
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
	<!-- 时间 -->
	<link rel="stylesheet" href="static/ace/css/bootstrap-timepicker.css" />
	<!-- 色光 -->
	<link rel="stylesheet" href="static/ace/css/bootstrap-slider.css" />
	<link rel="stylesheet" href="static/ace/css/mesilider.css" />

	<script type="text/javascript">
	var jsessionid = "<%=session.getId()%>";  //勿删，uploadify兼容火狐用到
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
					
					<form action="strategy/${msg }.do" name="strategyForm" id="strategyForm" method="post">
						<input type="hidden" value="no" id="hasTp1" />
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover" border="1">
							<tr style="display:none">
						   		 <td><input type="text" name="ID" id="id" value="${pd.id }" /></td>
						   		 <td><input type="text" name="strategyset_id" id="strategyset_id" value="${pd.strategyset_id }" /></td>
						    </tr>
						    <!-- 名称 -->
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;" nowrap="nowrap"><span style="color:red;">*</span><%=strategy_name %>:</td>
								<td><input type="text" name="NAME" id="name" value="${pd.name }" maxlength="50" title="<%=strategy_name %>" style="width:98%;" placeholder="<%=please_enter_strategy_name %>"/></td>
							</tr>
							<!-- 类型 -->
						    <tr>
								<td style="width:75px;text-align: right;padding-top: 13px;"><span style="color:red;">*</span><%=type %>:</td>
								<td>
									<select class="chosen-select form-control" name="TYPE" id="type" maxlength="100" title="<%=type %>" style="vertical-align:top;width:98%;" 
										onchange="switchAdjustItems(this.value)">
										<option value=""><%=please_choose_type %></option>
										<c:forEach items="${strategyTypeList}" var="strategyType">
											<option value="${strategyType.id }" <c:if test="${strategyType.id == pd.b_strategy_type_id }">selected</c:if> >${strategyType.name }</option>
										</c:forEach>
									</select>
								</td>
						    </tr>
						    <!-- 开始日期 -->
						    <tr>
								<td style="width:75px;text-align: right;padding-top: 13px;"><span style="color:red;">*</span><%=start_date %>:</td>
								<td>
						    		<input class="span10 date-picker" name="DATETIME1" id="datetime1" value="${pd.datetime1}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:123px; height:28px;" placeholder="<%=please_choose_start_date %>" title="<%=start_date %>"/>
								</td>
						    </tr>
						    <!-- 结束日期 -->
						    <tr>
								<td style="width:75px;text-align: right;padding-top: 13px;"><span style="color:red;">*</span><%=end_date %>:</td>
								<td>
						    		<input class="span10 date-picker" name="DATETIME2" id="datetime2" value="${pd.datetime2}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:123px; height:28px;" placeholder="<%=please_choose_end_date %>" title="<%=end_date %>"/>
								</td>
						    </tr>
						   	<!-- 月 -->
						    <tr id="tr_month" style="display:none">
								<td style="width:75px;text-align: right;padding-top: 13px;"><span style="color:red;">*</span><%=month %>:</td>
								<td>
									<select id="month" name="MONTH" class="selectmonth" rel="${pd.month}" FirstText="<%=please_choose_month %>"></select>
								</td>
						    </tr>
						    <!-- 日 -->
						    <tr id="tr_day" style="display:none">
								<td style="width:75px;text-align: right;padding-top: 13px;"><span style="color:red;">*</span><%=day %>:</td>
								<td>
									<select id="day" name="DAY" class="selectday" rel="${pd.day}" FirstText="<%=please_choose_day %>"></select>
								</td>
						    </tr>
						   <!-- 周期 -->
						    <tr id="tr_period" style="display:none">
								<td style="width:75px;text-align: right;padding-top: 13px;"><span style="color:red;">*</span><%=period %>:</td>
								<td>
							    	<input autocomplete="off" id="period" maxlength="10" type="number" name="PERIOD" onkeyup="filternum(this)" value="${pd.period }" placeholder="<%=please_enter_period %>"/>
								</td>
						    </tr>
						    <!-- 执行天数 -->
						    <tr id="tr_days" style="display:none">
								<td style="width:75px;text-align: right;padding-top: 13px;"><span style="color:red;">*</span><%=apply_days %>:</td>
								<td>
							    	<input autocomplete="off" id="days" maxlength="10" type="number" name="DAYS" onkeyup="filternum(this)" value="${pd.days }" placeholder="<%=please_enter_days %>"/>
								</td>
						    </tr>
						    <!-- 时间 -->
						    <tr>
								<td style="width:75px;text-align: right;padding-top: 13px;"><span style="color:red;">*</span><%=time %>:</td>
    							<td>
    								<input class="span10 time-picker" type="text" name="TIME" id="time" value="${pd.time }" maxlength="100" title="<%=time %>" style="text-align: left;" placeholder="<%=ex_24_hours %>"/>
    							</td>
						    </tr>
						    <!-- 色光  -->
						    <tr id="tr_colouredlight">
								<td style="width:75px;text-align: right;padding-top: 13px;"><%=coloured_light %>:</td>
    							<td>
     								<input type="hidden" name="VALUE" id="value" value="${pd.value }" />
									<table border="0"><tr><td>
									<select class="chosen-select form-control" name="VALUESEL" id="valuesel" title="<%=coloured_light %>" style="vertical-align:top;width;100px" onchange="switchAdjustValue(this.value)">
										<option value=""><%=please_choose_lightcolor %></option>
										<option value="C" <c:if test="${fn:startsWith(pd.value, 'C')}">selected</c:if> ><%=coloured_light %></option>
										<option value="T" <c:if test="${fn:startsWith(pd.value, 'T')}">selected</c:if> ><%=warn_cold %></option>
									</select>
</td><td>
<div id="rgb" class="panelrgb" onselectstart="return false;" <c:if test="${!fn:startsWith(pd.value, 'C')}"> style="display:none"</c:if> >
		<div id="RGB" style="float:left; width:100px; height:65px; margin-right:10px;"></div>
		<div style="float:left; width:160px; ">
			<INPUT id="R" type="text" data-slider-value="${pd.value1 }" data-slider-step="1" data-slider-max="100" data-slider-min="0" data-slider-id="RC" data-slider-tooltip="hide"><SPAN id="rVal" class="sep-left">${pd.value1 }</SPAN>
			<INPUT id="G" type="text" data-slider-value="${pd.value2 }" data-slider-step="1" data-slider-max="100" data-slider-min="0" data-slider-id="GC" data-slider-tooltip="hide"><SPAN id="gVal" class="sep-left">${pd.value2 }</SPAN>
			<INPUT id="B" type="text" data-slider-value="${pd.value3 }" data-slider-step="1" data-slider-max="100" data-slider-min="0" data-slider-id="BC" data-slider-tooltip="hide"><SPAN id="bVal" class="sep-left">${pd.value3 }</SPAN>
		</div>
</div>
<div id="wy" class="panelwy" onselectstart="return false;" <c:if test="${!fn:startsWith(pd.value, 'T')}"> style="display:none" </c:if>>
	<div id="leftdiv" style="float:left;line-height:30px;text-align:center;width:50px; height:30px; border:1px solid #000000; border-right:0px;background-color:#FFFFF0;">50</div>
	<div id="rightdiv" style="float:left;line-height:30px;text-align:center;width:50px; height:30px; border:1px solid #000000; background-color:#FFCC00;">50</div>
	<span class="sep-left"></span>
	<INPUT id="WY" type="text" data-slider-value="${pd.value1 }" data-slider-step="1" data-slider-max="100" data-slider-min="0" data-slider-id="slider5" data-slider-tooltip="hide"><SPAN id="wyVal" class="sep-left">${pd.value1 }</SPAN>
</div>
</td></tr></table>
							</td>
						    </tr>
						    <!-- 亮度 -->
						    <tr id="tr_birghtness">
								<td style="width:75px;text-align: right;padding-top: 13px;"><span style="color:red;">*</span><%=brightness %>:</td>
    							<td>
									<div style="position:relative;"><span style="width:18px;overflow:hidden;">
 									<select class="chosen-select form-control" name="BRIGHT" id="bright" maxlength="100" title="<%=brightness %>" 
										onchange="writeToInput(this.value)" style="vertical-align:top;width:98%;height:33px;" >
										<option value=""><%=please_choose_bright %></option>
										<option value="255" <c:if test="${pd.bright == '255' }">selected</c:if>><%= on %></option>
										<option value="0" <c:if test="${pd.bright == '0' }">selected</c:if> ><%= off %></option>
										<option value="10" <c:if test="${pd.bright == '10' }">selected</c:if> >10</option>
										<option value="20" <c:if test="${pd.bright == '20' }">selected</c:if> >20</option>
										<option value="30" <c:if test="${pd.bright == '30' }">selected</c:if> >30</option>
										<option value="40" <c:if test="${pd.bright == '40' }">selected</c:if> >40</option>
										<option value="50" <c:if test="${pd.bright == '50' }">selected</c:if> >50</option>
										<option value="60" <c:if test="${pd.bright == '60' }">selected</c:if> >60</option>
										<option value="70" <c:if test="${pd.bright == '70' }">selected</c:if> >70</option>
										<option value="80" <c:if test="${pd.bright == '80' }">selected</c:if> >80</option>
										<option value="90" <c:if test="${pd.bright == '90' }">selected</c:if> >90</option>
										<option value="100" <c:if test="${pd.bright == '100' }">selected</c:if> >100</option>
									</select></span>
									<input type="text" name="BRIGHTINPUT" id="brightinput" maxlength="3" title="<%=brightness %>" onkeyup="writeToSelect(this.value)" style="position:absolute;left:0px;width:92%;height:33px;border-right:0px;" placeholder="<%=please_choose_bright %>">
									</div>
    							</td>
						    </tr>
						    <%-- <!-- 有效状态  -->
						    <tr>
								<td style="width:75px;text-align: right;padding-top: 13px;"><span style="color:red;">*</span><%=status %>:</td>
								<td>
									<select class="chosen-select form-control" name="STATUS" id="status" maxlength="100" title="<%=status %>" style="vertical-align:top;width:98%;">
										<option value=""><%=please_choose_status %></option>
										<option value="1" <c:if test="${pd.status == '1' }">selected</c:if> ><%=effective %></option>
										<option value="2" <c:if test="${pd.status == '2' }">selected</c:if> ><%=invalid %></option>
									</select>
								</td>
						    </tr> --%>
						    <!-- 说明 -->
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;" nowrap="nowrap"><%=app_explain %>:</td>
								<td><input autocomplete="off" type="text" name="EXPLAIN" id="explain" value="${pd.explain }" maxlength="100" title="<%=app_explain %>" style="width:98%;" placeholder="<%=please_enter_app_explain %>"/></td>
							</tr>
						</table>
						<table id="table_report" class="table table-striped table-bordered table-hover">	
							<tr>
								<td style="text-align: center;" colspan="10">
									<a class="btn btn-mini btn-primary" onclick="save();"><%=save %></a>
									<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();"><%=cancel %></a>
								</td>
							</tr>
						</table>
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
</div>
<!-- /.main-container -->


	<!-- 页面底部js¨ -->
	<%@ include file="../system/index/foot.jsp"%>
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<!-- 日期框 --> 
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	<!-- 时间 -->
	<script src="static/ace/js/date-time/bootstrap-timepicker.js"></script>
	<!-- 月日 -->
	<script src="static/ace/js/date-time/monthday.js"></script>
	<!--色光-->
	<script type="text/javascript" src="static/js/bootstrap-slider.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	
	
	
	<script type="text/javascript">
	//色光/冷暖调节
	var r,g,b,wy;
	
		$(top.hangge());
		
		
		//保存
		function save(){
			//名称
			if(checkInput($("#name"),'<%=please_enter_strategy_name %>')==false) 
				return false;
			//类型
			if(checkInput($("#type"),'<%=please_choose_type %>')==false) 
				return false;
			
			//开始日期
			var tdate = new Date();
			var today = tdate.getFullYear() + "-" + add_zero(tdate.getMonth()+1) + "-" + add_zero(tdate.getDate());
			if(checkInput($("#datetime1"),'<%=please_choose_start_date %>')==false) 
				return false;
			if($("#datetime1").val() < today){
				$("#datetime1").tips({
					side:3,
		            msg: '<%=please_choose_futureday %>',
		            bg:'#AE81FF',
		            time:3
		        });
				$("#datetime1").focus();
				return false;
			}
			//结束日期
			if(checkInput($("#datetime2"),'<%=please_choose_end_date %>')==false) 
				return false;
			if($("#datetime2").val() < today){
				$("#datetime2").tips({
					side:3,
		            msg: '<%=please_choose_futureday %>',
		            bg:'#AE81FF',
		            time:3
		        });
				$("#datetime2").focus();
				return false;
			}
			if($("#datetime1").val() > $("#datetime2").val()){
				$("#datetime2").tips({
					side:3,
		            msg: '<%=totm_less_fromtm %>',
		            bg:'#AE81FF',
		            time:3
		        });
				$("#datetime2").focus();
				return false;
			}

			
			//定时调节
			if($("#type").val()=='1'){
				//月
				if(checkInput($("#month"),'<%=please_choose_month %>')==false) 
					return false;
				//日
				if(checkInput($("#day"),'<%=please_choose_day %>')==false) 
					return false;
			}
			//周期调节
			if($("#type").val()=='2'){
				//周期
				if(checkInput($("#period"),'<%=please_enter_period %>')==false) 
					return false;
				//执行天数
				if(checkInput($("#days"),'<%=please_enter_period %>')==false) 
					return false;
				//执行天数大于周期 error
				var daysnum = Number($("#days").val());
				var periodnum = Number($("#period").val());
				if(daysnum > periodnum){
					$("#days").tips({
						side:3,
			            msg: '<%=days_morethan_cycle %>',
			            bg:'#AE81FF',
			            time:3
			        });
					$("#days").focus();
					return false;
				}
			}
			//时间
			if(checkInput($("#time"),'<%=please_choose_time %>')==false) 
				return false;
			<%-- //色光/冷暖
			if(checkInput($("#valuesel"),'<%=please_choose_lightcolor %>')==false) 
				return false; --%>
			//亮度
			if($("#bright").val()==null || $("#bright").val()==""){
				if($("#brightinput").val()==""){
					$("#bright").tips({
						side:3,
			            msg: '<%=please_choose_bright %>',
			            bg:'#AE81FF',
			            time:3
			        });
					$("#bright").focus();
					return false;
				}else{
					var num = Number($("#brightinput").val());
					if(num <=0 || num >100){
						$("#bright").tips({
							side:3,
				            msg: '<%=please_enter_1_100 %>',
				            bg:'#AE81FF',
				            time:3
				        });
						$("#bright").focus();
						return false;
					}
				}
			}
			
			<%-- //状态
			if(checkInput($("#status"),'<%=please_choose_status %>')==false) 
				return false; --%>

			//色光/冷暖 未选设置默认值
			if( $("#valuesel").val()==null ||  $("#valuesel").val()==""){
				$("#value").val("C:0、0、0");
			}

		    $("#strategyForm").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
			
		}
		
		
		function add_zero(temp)
		{
			 if(temp<10) return "0"+temp;
			 else return temp;
		}
		
		function checkInput(tipObject,tipMsg){
			if(tipObject.val()==null || tipObject.val()==""){
				tipObject.tips({
					side:3,
		            msg: tipMsg,
		            bg:'#AE81FF',
		            time:3
		        });
				tipObject.focus();
				return false;
			}
		}
		
			

		//设定显示项目
		function switchAdjustItems(type){
			$("#tr_month").css('display','none');
			$("#tr_day").css('display','none');
			$("#tr_period").css('display','none');
			$("#tr_days").css('display','none');
			
		  	// 定时调节
			if(type=='1'){
		  		$("#tr_month").css('display','');	//月
		  		$("#tr_day").css('display','');		//日
		  		$("#period").val("");
		  		$("#days").val("");
		 	}
		  	
			// 周期调节
			if(type=='2' ){
		  		$("#tr_period").css('display','');	//周期
		  		$("#tr_days").css('display','');	//执行天数
		  		$("#month").val("");
		  		$("#day").val("");
		 	}
		}
		
		// 设定色光冷暖
		// C：30、40、30    红绿蓝三色调至30%、40%、30%
		// T：40、60、0      冷暖调至40%、60%
		function switchAdjustValue(type){
			$("#rgb").css("display","none");
			$("#wy").css("display","none");
			
			if(type=='C' ){
				r.setValue('0',true,true);
				g.setValue('0',true,true);
				b.setValue('0',true,true);
				$("#rgb").css("display","");
				$("#wy").css("display","none");
			}else if(type=='T' ){
				wy.setValue('0',true,true);
				$("#rgb").css("display","none");
				$("#wy").css("display","");
			}
		}
		
		
		// 亮度值显示到手写框
		function writeToInput(value){
			if(value=='0'){
				$("#brightinput").val('<%=off%>');
			}else if(value=='255'){
				$("#brightinput").val('<%=on%>');
			}else{
				$("#brightinput").val(value);
			}
		}
		
		// 亮度值反应到下拉框
		function writeToSelect(value){
			//只能输入数字
			$("#brightinput").val(value.replace(/[^\d]/g,''));
			
			$("#bright").val("");
			//if(value=='0' || value=='255') return;
			$("#bright").val(value);

		}

		// 忽略输入的非数字
		function filternum(obj){
			obj.value = obj.value.replace(/[^\d]/g,'');
		}

		//清除空格
		String.prototype.trim=function(){
		     return this.replace(/(^\s*)|(\s*$)/g,'');
		};


$(function() {
	//日期框
	$('.date-picker').datepicker({autoclose: true,todayHighlight: true});

	//时间框
	$('.time-picker').timepicker({
	    minuteStep: 1,
	    showMeridian: false,//am,pm
	    defaultTime: false
	});
	
	$.ms_DatePicker({
        MonthSelector: ".selectmonth",
        DaySelector: ".selectday"
    });
	$.ms_DatePicker();
	
	//初期调节项目显示
	switchAdjustItems("${pd.b_strategy_type_id }");
	writeToInput("${pd.bright }");

	
	var RGBChange = function() {
		  $('#RGB').css('background', 'rgb('+r.getValue()+'%,'+g.getValue()+'%,'+b.getValue()+'%)');
		  $("#rVal").text(r.getValue());
		  $("#gVal").text(g.getValue());
		  $("#bVal").text(b.getValue());
		  $("#value").val("C:"+ r.getValue()+"、"+ g.getValue()+"、"+ b.getValue());
	};
	
	var WYChange = function() {
		$("#wyVal").text(wy.getValue());
		$("#leftdiv").text(wy.getValue());
		$("#rightdiv").text(100-wy.getValue());
		$("#leftdiv").css("width",wy.getValue()+"px");
		$("#rightdiv").css("width",(100-wy.getValue())+"px");
		$("#value").val("T:"+ wy.getValue()+"、"+(100-wy.getValue())+"、0");
	};
	r = $('#R').slider()
				.on('slide', RGBChange)
				.data('slider');
	g = $('#G').slider()
				.on('slide', RGBChange)
				.data('slider');
	b = $('#B').slider()
				.on('slide', RGBChange)
				.data('slider');
	wy = $("#WY").slider()
				  .on('slide', WYChange)
				  .data('slider');
	//初期色光/冷暖显示
	if(($("#valuesel").val()=='C')) RGBChange();
	if(($("#valuesel").val()=='T')) WYChange();
	
// 	$("#WY").on('slide', function(slideEvt) {
// 		$("#wyVal").text(slideEvt.value);
// 		$("#leftdiv").text(slideEvt.value);
// 		$("#rightdiv").text(100-slideEvt.value);
// 		$("#leftdiv").css("width",slideEvt.value+"px");
// 		$("#rightdiv").css("width",(100-slideEvt.value)+"px");
// 		$("value").val("T:"+ slideEvt.value+"、"+(100-slideEvt.value)+"、0");
// 	});	

});
        

		</script>
</body>
</html>