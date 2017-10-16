<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
	<head>
	<base href="<%=basePath%>">
	<!-- jsp文件头和头部 -->
	<%@ include file="../system/index/top.jsp"%>
	<%@ include file="../international.jsp"%>
</head>
<body class="no-skin">
<div class="main-container" id="main-container">
	<div class="main-content">
		<div class="main-content-inner">
			<div class="page-content">
				<div class="row">
						<form action="gomap/readMapJPG" name="Form" id="Form" method="post" enctype="multipart/form-data">
						<div id="zhongxin" style="padding-top: 3px;background-color:#E3E3E3;text-align:center"><%=part_map_markerInfo%></div>
					<table id="simple-table" class="table table-striped table-bordered table-hover" style="margin-top:5px;">	
						<tbody>
							<tr>
								<td class='center'><%=part_map_name %></td>
								<td ><input type=text name="mapPicName" id="mapPicName" size=30 value="${pd.mapPicName }"/></td>
							</tr>
							<tr>
								<td class='center'><%=part_map_pic %></td>
								<td><input type="file" id="mappic" name="mappic" size=30 onchange="fileType(this)"/></td>
							</tr>
							<tr>
								<td class='center'><%=part_map_coordinate %></td>
								<td><input type='text' name="xycoordinate"  id="xycoordinat" size=30 value="${pd.XPoint },${pd.YPoint }"/></td>
							</tr>
							<input type =hidden id='partMapURL'name="partMapURL" value="${pd.mapFilePath}"></input>
							<input type =hidden id='termID' name="termID"  value="${pd.termID}"></input>
							<input type =hidden id='partMapID' name="partMapID"  value="${pd.partMapid}"></input>
						</tbody>
					</table>
						</div>
						<div class="page-header position-relative">
						<table style="width:100%;">
							<tr>
								<td style="text-align:center">
<%-- 									<c:if test="${QX.add == 1 }"> --%>
									<a class="btn btn-mini btn-success" onclick="save();"  onmouseover="this.style.cursor='hand'"><%=confirm %></a>
<%-- 									</c:if> --%>
								</td>
							</tr>
						</table>
						</div>
						<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green">提交中...</h4></div>
					</form>
				
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
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<!-- 上传控件 -->
	<script src="static/ace/js/ace/elements.fileinput.js"></script>
		<script type="text/javascript">
		$(top.hangge());
		$(function() {
			//上传
			$('#mappic').ace_file_input({
				no_file:'<%=please_choose_jpg%> ...',
				btn_choose:'<%=choose%>',
				btn_change:'<%=change%>',
				droppable:false,
				onchange:null,
				thumbnail:false, //| true | large
				whitelist:'excel|excel',
				blacklist:'gif|png|jpg|jpeg'
			});
		});
		
		//保存
		function save(){
			if($("#mappic").val()=="" || document.getElementById("mappic").files[0] =='<%=please_choose_jpg%>'){
				$("#mappic").tips({
					side:3,
		            msg:'<%=please_choose_jpg%>',
		            bg:'#AE81FF',
		            time:3
		        });
				return false;
			}
			if($("#mapPicName").val()==""){
				alert('请输入局部图名称');
				return false
			}
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
			window.parent.window.frames["mainFrame"].frames["page_347"].frames["Conframe"].document.getElementById('MarkerXYCoordinate').value=document.getElementById('xycoordinat').value;
			window.parent.window.frames["mainFrame"].frames["page_347"].frames["Conframe"].document.getElementById('addMarker').click();
			window.parent.window.frames["mainFrame"].frames["page_347"].frames["Conframe"].document.getElementById('partMapName').value= document.getElementById('mapPicName').value;
		}
		function fileType(obj){
			var fileType=obj.value.substr(obj.value.lastIndexOf(".")).toLowerCase();//获得文件后缀名
		    if(fileType != '.jpg'){
		    	$("#mappic").tips({
					side:3,
		            msg:'',
		            bg:'#AE81FF',
		            time:3
		        });
		    	$("#mappic").val('');
		    	document.getElementById("mappic").files[0] = '<%=please_choose_jpg%>';
		    }
		    window.parent.window.frames["mainFrame"].frames["page_347"].frames["Conframe"].document.getElementById('partMapURL').value=document.getElementById("mappic").files[0].name;
		}
		</script>
</body>
</html>