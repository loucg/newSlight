<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
<%--
	function fun1(){
		$.ajax({
			url:"Httpcmd/receivedata",
			data:SEND=3570000000,
			success:function(data){
				alert("ajax请求成功");
			},
			error:function(){
				alert("发生错误！")
			}
		})
	}
--%>
	 function fun1(){
		alert("进入fun1");
		location.href("<%=basePath%>httpcmd/receivedata");
	//	location.URL("Httpcmd/receivedata");
	} 
</script>
</head>
<body onload="fun1();">
<a href="<%=basePath%>httpcmd/receivedata">111</a>
</body>
</html>