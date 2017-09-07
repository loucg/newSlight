<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
	<base href="<%=basePath%>">
	  <link rel="stylesheet" href="//apps.bdimg.com/libs/jqueryui/1.10.4/css/jquery-ui.min.css">
	  <script src="//apps.bdimg.com/libs/jquery/1.10.2/jquery.min.js"></script>
	  <script src="//apps.bdimg.com/libs/jqueryui/1.10.4/jquery-ui.min.js"></script>
	  <link rel="stylesheet" href="static/ace/css/jquery-ui.css">
	<!-- 下拉框 -->
	<link rel="stylesheet" href="static/ace/css/chosen.css" />
	<!-- jsp文件头和头部 -->
	<%@ include file="../../system/index/top.jsp"%>
	<!-- jsp国际化文件 -->
<%@ include file="../../international.jsp"%>
	<!-- 日期框 -->
	<link rel="stylesheet" href="static/ace/css/datepicker.css" />
	<!-- 时间 -->
	<link rel="stylesheet" href="static/ace/css/bootstrap-timepicker.css" />

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
					
					<form action="grouplamp/${msg }.do" name="brightForm" id="brightForm" method="post">
						<input type="hidden" value="no" id="hasTp1" />
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr style="display:none">
						   		 <td><input type="text" name="DATA_IDS" id="DATA_IDS" value="${pd.DATA_IDS }" /></td>
						    </tr>
							<p>
							  <label for="brightness"><%=brightness_level %>：</label>
							  <input type="text" id="brightness" name="brightness" style="border:0; color:#f6931f; font-weight:bold;width:40px">
							  <label for="brightness">(0-100)</label>
							</p>
							 
							<div id="slider-vertical" style="margin-bottom:30px"></div>
								
							<div style="text-align: center; margin-bottom:5px" colspan="10">
								<a class="btn btn-mini btn-primary" onclick="save();"><%=save %></a>
								<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();"><%=cancel %></a>
							</div>
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
	<%@ include file="../../system/index/foot.jsp"%>
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	<!-- 时间 -->
	<script src="static/ace/js/date-time/bootstrap-timepicker.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
		<script type="text/javascript">
		$(top.hangge());
		
		//保存
		function save(){
			$("#brightForm").submit(); 
			$("#zhongxin").hide();
			$("#zhongxin2").show();
			
		}
		
		$(function() {
			//滑块
		    $( "#slider-vertical" ).slider({
		        
		        range: "min",
		        min: 0,
		        max: 100,
		        value: 0,
		        slide: function( event, ui ) {
		          $( "#brightness" ).val( ui.value );
		        }
		      });
		      $( "#brightness" ).val( $( "#slider-vertical" ).slider( "value" ) );
			
		});

			//清除空格
		String.prototype.trim=function(){
		     return this.replace(/(^\s*)|(\s*$)/g,'');
		};
		</script>
</body>
</html>