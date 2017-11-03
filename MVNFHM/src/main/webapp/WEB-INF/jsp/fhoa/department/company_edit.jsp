<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
<!-- jsp文件头和头部 -->
<%@ include file="../../system/index/top.jsp"%>
<%@ include file="../../international.jsp"%>
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
						<form action="department/${msg }.do" name="Form" id="Form" method="post" enctype="multipart/form-data">
							<input type="hidden" name="ID" id="ID" value="${pd.ID}"/>
							<div id="zhongxin" style="padding-top: 13px;">
							<table id="table_report" class="table table-striped table-bordered table-hover">
								<tr>
									<td style="width:100px;text-align: right;padding-top: 13px;"><%=company_name %>:</td>
									<td><input type="text" name="NAME" id="NAME" value="${pd.NAME}" maxlength="32" style="width:99%;" placeholder="<%=enter_company_name_here %>" title="<%=company_name %>"/></td>
								</tr>
								<tr>
									<td style="width:100px;text-align: right;padding-top: 13px;"><%=company_location %>:</td>
									<td><input type="text" name="ADDRESS" id="ADDRESS" value="${pd.ADDRESS}" maxlength="32" style="width:99%;" placeholder="<%=enter_company_location_here %>" title="<%=company_location %>"/></td>
								</tr>
								<tr>
									<td style="width:100px;text-align: right;padding-top: 13px;"><%=company_contact %>:</td>
									<td><input type="text" name="CONTACTS" id="CONTACTS" value="${pd.CONTACTS}" maxlength="32" style="width:99%;" placeholder="<%=enter_company_contact_here %>" title="<%=company_contact %>"/></td>
								</tr>
								<tr>
									<td style="width:100px;text-align: right;padding-top: 13px;"><%=phone %>:</td>
									<td><input type="text" name="TELEPHONE" id="TELEPHONE" value="${pd.TELEPHONE}" maxlength="32" style="width:99%;" placeholder="<%=enter_phone_number_here %>" title="<%=phone %>"/></td>
								</tr>
								<tr>
									<td style="width:100px;text-align: right;padding-top: 13px;"><%=map_type %>:</td>
									<td>
									<select class="chosen-select form-control" name="MAP_TYPE" id="MAP_TYPE" style="vertical-align:top;width: 120px;">
										<option value=""></option>
										<c:forEach items="${mapList}" var="map">
											<option value="${map.id}" <c:if test="${map.id == pd.MAP_TYPE}">selected</c:if>>${map.name }</option>
										</c:forEach>
								  	</select>
									</td>
								</tr>
								<tr>
									<td style="width:100px;text-align: right;padding-top: 13px;"><%=sms_platform %>:</td>
									<td>
									<select class="chosen-select form-control" name="SMSPLATFORM" id="SMSPLATFORM" style="vertical-align:top;width: 120px;">
										<option value=""></option>
										<c:forEach items="${smsList}" var="sms">
											<option value="${sms.id }" <c:if test="${sms.id == pd.SMSPLATFORM }">selected</c:if>>${sms.name }</option>
										</c:forEach>
								  	</select>
									</td>
								</tr>
								<tr>
									<td style="width:100px;text-align: right;padding-top: 13px;"><%=LOGO %>:</td>
									<td>
										<c:if test="${pd == null || pd.LOGO_PATH == '' || pd.LOGO_PATH == null }">
										<input type="file" id="tp" name="tp" onchange="fileType(this)"/>
										</c:if>
										<c:if test="${pd != null && pd.LOGO_PATH != '' && pd.LOGO_PATH != null }">
											<img src="<%=basePath%>uploadFiles/uploadImgs/${pd.LOGO_PATH}" width="210"/>
											<input type="button" class="btn btn-mini btn-danger" value="<%=delete %>" onclick="delP('${pd.LOGO_PATH}','${pd.ID }');" />
											<input type="hidden" name="LOGO_PATH" id="LOGO_PATH" value="${pd.LOGO_PATH }"/>
										</c:if>
									</td>
								</tr>
								<tr>
									<td style="width:100px;text-align: right;padding-top: 13px;"><%=if_display_LOGO %>:</td>
									<td>
									<select class="chosen-select form-control" name="ISDISPLAYLOGO" id="ISDISPLAYLOGO" data-placeholder="<%=please_choose_if_display_LOGO %>" style="vertical-align:top;width: 120px;">
									<option value="true" <c:if test="${pd.ISDISPLAYLOGO=='true'}">selected="selected"</c:if>><%=yes %></option>
									<option value="false" <c:if test="${pd.ISDISPLAYLOGO=='false'}">selected="selected"</c:if>><%=no %></option>
								  	</select>
									</td>
								</tr>
								<tr>
									<td style="width:100px;text-align: right;padding-top: 13px;"><%=status %>:</td>
									<td>
									<select class="chosen-select form-control" name="STATUS" id="STATUS" data-placeholder="<%=please_choose_status %>" style="vertical-align:top;width: 120px;">
									<option value="1" <c:if test="${pd.STATUSNAME=='有效'}">selected="selected"</c:if>><%=effective %></option>
									<option value="2" <c:if test="${pd.STATUSNAME=='无效'}">selected="selected"</c:if>><%=invalid %></option>
								  	</select>
									</td>
								</tr>
								<tr>
									<td style="text-align: center;" colspan="2">
										<a class="btn btn-mini btn-primary" onclick="save();"><%=save %></a>
										<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();"><%=cancel %></a>
									</td>
								</tr>
							</table>
							</div>
							<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green"><%=committing %></h4></div>
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

<!-- basic scripts -->
<!-- 页面底部js¨ -->
<%@ include file="../../system/index/foot.jsp"%>
<!-- ace scripts -->
<script src="static/ace/js/ace/ace.js"></script>
<!-- 上传控件 -->
<script src="static/ace/js/ace/elements.fileinput.js"></script>
<!--提示框-->
<script type="text/javascript" src="static/js/jquery.tips.js"></script>			

<script type="text/javascript">
		$(top.hangge());
		$(function() {
			//上传
			$('#tp').ace_file_input({
				no_file:'<%=please_choose_picture %>',
				btn_choose:'<%=choose %>',
				btn_change:'<%=change %>',
				droppable:false,
				onchange:null,
				thumbnail:false, //| true | large
				whitelist:'gif|png|jpg|jpeg',
				//blacklist:'gif|png|jpg|jpeg'
				//onchange:''
				//
			});
		});
	
	//保存
	function save(){
			if($("#NAME").val()==""){
			$("#NAME").tips({
				side:3,
	            msg:'<%=please_enter_company_name %>',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#NAME").focus();
			return false;
		}
			if($("#ADDRESS").val()==""){
				$("#ADDRESS").tips({
					side:3,
		            msg:'<%=please_enter_company_location %>',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#ADDRESS").focus();
				return false;
			}
			if($("#CONTACTS").val()==""){
				$("#CONTACTS").tips({
					side:3,
		            msg:'<%=please_enter_contact %>',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#CONTACTS").focus();
				return false;
			}
			if($("#TELEPHONE").val()==""){
				$("#TELEPHONE").tips({
					side:3,
		            msg:'<%=please_enter_phone %>',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#TELEPHONE").focus();
				return false;
			}
		if(typeof($("#LOGO_PATH").val()) == "undefined"){
			if($("#tp").val()=="" || document.getElementById("tp").files[0] =='<%=please_choose_picture %>'){
				
				$("#tp").tips({
					side:3,
		            msg:'<%=please_choose_picture %>',
		            bg:'#AE81FF',
		            time:3
		        });
				return false;
			}
		}
		
		if($("#ISDISPLAYLOGO").val()==""){
			$("#MASTER_ID").tips({
				side:3,
	            msg:'<%=please_choose_if_display_LOGO %>',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#ISDISPLAYLOGO").focus();
			return false;
		}
		if($("#STATUS").val()==""){
			$("#STATUS").tips({
				side:3,
	            msg:'<%=please_choose_status %>',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#STATUS").focus();
			return false;
		}
		$("#Form").submit();
		$("#zhongxin").hide();
		$("#zhongxin2").show();
	}
	
	//过滤类型
	function fileType(obj){
		var fileType=obj.value.substr(obj.value.lastIndexOf(".")).toLowerCase();//获得文件后缀名
	    if(fileType != '.gif' && fileType != '.png' && fileType != '.jpg' && fileType != '.jpeg'){
	    	$("#tp").tips({
				side:3,
	            msg:'<%=please_upload_picture_format_file %>',
	            bg:'#AE81FF',
	            time:3
	        });
	    	$("#tp").val('');
	    	document.getElementById("tp").files[0] = '<%=please_choose_picture %>';
	    }
	}
	
	//删除图片
	function delP(PATH,PICTURES_ID){
		 if(confirm("<%=make_sure_delete_picture %>？")){
			var url = "department/deltp.do?LOGO_PATH="+PATH+"&ID="+PICTURES_ID;
			$.get(url,function(data){
				if(data=="success"){
					alert("<%=success_delete %>!");
					document.location.reload();
				}
			});
		} 
	}
</script>
</body>
</html>