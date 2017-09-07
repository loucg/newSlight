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
<!-- Autocomplete -->
<!-- <link rel="stylesheet" href="//apps.bdimg.com/libs/jqueryui/1.10.4/css/jquery-ui.min.css">
<script src="//apps.bdimg.com/libs/jquery/1.10.2/jquery.min.js"></script>
<script src="//apps.bdimg.com/libs/jqueryui/1.10.4/jquery-ui.min.js"></script>
<link rel="stylesheet" href="static/ace/css/jquery-ui.css"> -->
<!-- 下拉框 -->
<link rel="stylesheet" href="static/ace/css/chosen.css" />
<!-- jsp文件头和头部 -->
<%@ include file="../../system/index/top.jsp"%>
<!-- jsp国际化文件 -->
<%@ include file="../../international.jsp"%>
<!-- 百度echarts -->
<script src="plugins/echarts/echarts.min.js"></script>
<!-- 日期框 -->
<link rel="stylesheet" href="static/ace/css/datepicker.css" />
</head>
<body class="no-skin">

	<!-- /section:basics/navbar.layout -->
	<div class="main-container" id="main-container" align="center">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">
				<div class="page-content">
					<div class="row">
						<div class="col-xs-12" >
						<div align="left">	
						<!-- 检索  -->
						<form action="power/street/graphPowers.do" method="post" name="Form" id="Form">
						<table style="margin-top:5px;">
							<tr>
								<td><%=group_name %>：</td>
								<td>
									<div class="nav-search">
										<span class="input-icon">
											<input type="text" class="nav-search-input" id="groupName" autocomplete="on" name="groupName" value="${pd.groupName }" />
										</span>
									</div>
								</td>
								<td>&nbsp;&nbsp;<%=strategy %>：</td>
								<td>
									<div class="nav-search">
										<span class="input-icon">
											<input type="text" class="nav-search-input" id="nav-search-input" autocomplete="on" name="strategy" value="${pd.strategy }"/>
										</span>
									</div>
								</td>
								<td style="padding-left:5px;"><input class="span10 date-picker" id="startTime" name="startTime"  value="${pd.startTime}" type="text" data-date-format="yyyy-mm-dd" style="width:88px;height:30px" placeholder="<%=start_time %>" readonly="readonly"/></td>
								<td style="padding-left:5px;"><input class="span10 date-picker" id="endTime" name="endTime"  value="${pd.endTime}" type="text" data-date-format="yyyy-mm-dd" style="width:88px;height:30px" placeholder="<%=end_time %>" readonly="readonly"/></td>
								<td>&nbsp;&nbsp;<%=statistical_type %>：</td>
								<td style="vertical-align:top;padding-left:2px;" > 
								 	<select class="chosen-select form-control" name="staType" id="staType" data-placeholder=" " style="vertical-align:top; width: 50px; height:31px">
									<!-- <option value=""></option> -->
									<option value="1" <c:if test="${pd.staType == '1' }">selected</c:if> ><%=date %></option>
									<option value="2" <c:if test="${pd.staType == '2' }">selected</c:if> ><%=month %></option>
									</select>
								</td>
								<c:if test="${QX.cha == 1 }">
								<td style="vertical-align:top;padding-left:2px"><a class="btn btn-light btn-xs" onclick="tosearch();"  title="<%=search2 %>" style="padding: 4px 4px;"><i id="nav-search-icon" class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i></a></td>
								</c:if>
							</tr>
						</table>
						</form>
						</div>
						<div id="main" style="width:1200px; height:550px;" align="center"></div>
							
							<script type="text/javascript">
							      // 基于准备好的dom，初始化echarts实例
							      var myChart = echarts.init(document.getElementById('main'));
							
							        
							        
							     // 指定图表的配置项和数据
							     //var xxx = ["衬衫","羊毛衫","雪纺衫","裤子","高跟鞋","袜子"];
							     //var yyy = [5, 20, 36, 10, 10, 20];
							     //var xxx = ['2017-03-04',3]; 
							     
							     
							     
							         var option = {
							            title: {
							                text: ''
							            },
							            tooltip: {
							            	 trigger: 'axis'
							            },
							            legend: {
							                data:['<%=energy_consumption %>']
							            },
							            xAxis: {
							                data: [${pd.xz}],
							                axisLabel :{  
							                    interval:0,
							                    rotate:30
							                }
							            },
							            yAxis: {},
							            series: [{
							                name: '<%=energy_consumption %>', 
							                type: 'bar',
							                itemStyle: {
							                    normal: {
							                    	color: '#C1232B',
							　　　　　　　　　　　　　　//以下为是否显示，显示位置和显示格式的设置了
							                        label: {
							                            show: true,
							                            position: 'top',
							                            formatter: '{c}',
							                            textStyle : {
							                                /* fontSize : '20',
							                                fontFamily : '微软雅黑',
							                                fontWeight : 'bold', */
							                                color: 'black'
							                            }
							                        }
							                    }
							                },
							                data: [${pd.yz}]
							            }]
							        }; 
	
							        // 使用刚指定的配置项和数据显示图表。
							        myChart.setOption(option);
							        
							   </script>
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
	<%@ include file="../../system/index/foot.jsp"%>
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
			
			var stime = $("#startTime").val();
			var etime = $("#endTime").val();
			if(stime > etime){
				$("#endTime").tips({
					side:3,
		            msg:'<%=endtime_biger_than_starttime %>',
		            bg:'#AE81FF',
		            time:3
		        });
				$("#endTime").focus();
				return false;
			}else{
				top.jzts();
				$("#Form").submit();
			}
			
			/* top.jzts();
			$("#Form").submit(); */
		}
		$(function() {
			//日期框
			$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
			
			/*  function log( message ) {
			      $( "<div>" ).text( message ).prependTo( "#log" );
			      $( "#log" ).scrollTop( 0 );
			} 
			 
			    $( "#groupName" ).autocomplete({
			      source: "/MVNFHM/json/a.json",
			      minLength: 2
			       select: function( event, ui ) {
			        log( ui.item ?
			          "Selected: " + ui.item.value + " aka " + ui.item.id :
			          "Nothing selected, input was " + this.value );
			      } 
			    }); */
		});
		
	</script>
<!-- <script type="text/javascript" src="static/ace/js/jquery.js"></script> -->
</body>
</html>