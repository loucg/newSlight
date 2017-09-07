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
<!DOCTYPE html>
<html lang="en">
<head>
<title>保存结果</title>
<base href="<%=basePath%>">
<!-- 下拉框 -->
<link rel="stylesheet" href="static/ace/css/chosen.css" />
<!-- jsp文件头和头部 -->
<%@ include file="system/index/top.jsp"%>
<!-- 日期框 -->
<link rel="stylesheet" href="static/ace/css/datepicker.css" />
</head>
<body>
	<div id="zhongxin"></div>
	<!-- /.main-container -->

	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="system/index/foot.jsp"%>
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
	    var msg = "${msg}";
		if(msg=="success" || msg==""){
			document.getElementById('zhongxin').style.display = 'none';
			top.Dialog.close();
		}
		else if("addSuccess"==msg){
			bootbox.alert({  
	            buttons: {  
	               ok: {  
	                    label: '确定',  
	                }  
	            },  
	            message: '新增成功！',  
	            callback: function() {  
	            	document.getElementById('zhongxin').style.display = 'none';
	    		    top.Dialog.close();  
	            },   
	        });
		}
		else if("editSuccess"==msg){
		 	 bootbox.alert({  
	            buttons: {  
	               ok: {  
	                    label: '确定',  
	                }  
	            },  
	            message: '修改成功！',  
	            callback: function() {  
	            	document.getElementById('zhongxin').style.display = 'none';
	    		    top.Dialog.close();  
	            },   
	        });  
		}
		else if("resetSuccess"==msg){
			bootbox.alert({  
	            buttons: {  
	               ok: {  
	                    label: '确定',  
	                }  
	            },  
	            message: '重置成功！',  
	            callback: function() {  
	            	document.getElementById('zhongxin').style.display = 'none';
	    		    top.Dialog.close();  
	            },   
	        });
		}
		else{
			top.Dialog.close();
		}
	</script>
</body>


</html>