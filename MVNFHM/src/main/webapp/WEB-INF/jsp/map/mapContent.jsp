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
<%@ include file="../system/index/top.jsp"%>
<%@ include file="../international.jsp"%>
<link rel="stylesheet" type="text/css"
	href="static/map/css/jquery-ui-1.10.4.custom.min.css" />
<link rel="stylesheet" type="text/css" href="static/map/css/ui.jqgrid.css" />
<link rel="stylesheet" type="text/css" href="static/map/css/ui.jqgrid.css" />
<link rel="stylesheet" type="text/css" href="static/map/css/admin-all1.css" />
<link rel="stylesheet" type="text/css" href="static/map/css/base.css" />
<link rel="stylesheet" type="text/css" href="static/map/css/formui.css" />
<link rel="stylesheet" type="text/css" href="static/map/css/chur.css" />
<link rel="stylesheet" type="text/css" href="static/map/css/bootstrap.min.css" />
<script type="text/javascript" src="static/map/js/jquery-2.1.4.min.js"></script>
<!-- <script src="https://code.jquery.com/jquery-2.1.4.min.js"></script> -->
<script type="text/javascript"
	src="static/map/js/jquery-ui-1.10.3.custom.min.js"></script>
<script type="text/javascript" src="static/map/js/grid.locale-cn.js"></script>
<script type="text/javascript" src="static/map/js/jquery.jqGrid.4.5.2.min.js"></script>
<script type="text/javascript" src="static/map/js/index.js"></script>
<script type="text/javascript" src="static/map/js/ChurAlert.min.js?skin=blue"></script>
<script type="text/javascript" src="static/map/js/chur-alert.1.0.js"></script>
<script type="text/javascript" src="static/map/js/mapContent.js"></script>
<script type="text/javascript" src="static/map/js/map.js"></script>
<script type="text/javascript"
	src="http://api.map.baidu.com/api?v=2.0&ak=H0j9w4M81wm8pl1klUsAPQklDddKFqc9">
	
</script>
<link rel="stylesheet" type="text/css" href="static/map/css/bootstrap.min-3.3.7.css" />
 <!-- <link rel="stylesheet" href="bootstrap.min-3.3.7.css">
 --><!-- <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap3-dialog/1.34.5/css/bootstrap-dialog.min.css" rel="stylesheet" type="text/css" />
 --><!-- <script src="https://code.jquery.com/jquery-2.1.4.min.js"></script> -->
<!-- <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script> -->
<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap3-dialog/1.34.5/js/bootstrap-dialog.min.js"></script>
 -->
 <link rel="stylesheet" type="text/css" href="static/map/css/bootstrap-dialog.min.css" />
 <script type="text/javascript" src="static/map/js/bootstrap.min.js"></script>
 <script type="text/javascript" src="static/map/js/bootstrap-dialog.min.js"></script>
 </head>
<body>
<div class="warp">
		<!--左边菜单开始-->
		<div class="left_c left">
			<!-- <div class="panel  panel-primary">
				<div class="panel-heading">
					<h3 class="panel-title">路灯列表</h3>
				</div>
			</div>  -->
			<!-- <h1>路灯列表</h1> -->
		 <div style="width: 235px;height:40px; border-bottom: 1px solid ;">
			<nav class="navbar navbar-default" style="height:40px;border:0px;" role="navigation">
				<ul class="nav navbar-nav" style="height:40px;width:235px;">
					<li class="active"  style="border-width: 0px 0px 1px 0px;height:40px;width:117px;text-align:center;"><a id="g"   style="height:40px;font-size:13px;font-weight:normal; font-family:宋体 ;text-align:center;"><%=road_light_list_1%></a></li>
					<li style="border-width: 0px 0px 1px 0px; height:40px;width:117px;text-align:center;"><a id="s" style="height:40px;font-size:13px;font-weight:normal;font-family:宋体 ;text-align:center;" ><%=road_light_list_2%></a></li>
				</ul>
			</nav>
		</div>
			<div class="acc"></div>
			<div class="searchacc"></div>
		</div>
		<!--左边菜单结束-->
		<!--右边框架开始-->
		<div class="searchdiv">
			<table class="tbform">
				<tbody>
					<tr>
						<td class="tdl"><span><%=group_name %>:</span> <select class="ipt"
							id="groupname" onchange="changegroupname()">
								<option value=""></option>
						</select></td>
						<td class="tdl"><span><%=type%>:</span> <select class="ipt"
							id="terminaltype" onchange="changeterminaltype()">
								<option value=""></option>
						</select></td>
						<td class="tdl"><span><%=address%>:</span> <select class="ipt"
							id="address" onchange="changeAddress()">
								<option value=""></option>
						</select></td>
						<td class="tdl"><span><%=name %>:</span> <select class="ipt"
							id="terminalname"  onchange="changeterminalname()">
								<option value=""></option>
						</select></td>
						<td class="tdl"><span><%=serial_number %>:</span> <select class="ipt"
							id="terminalid">
								<option value=""></option>
						</select></td>
						<td class="tdl" style="width: 15%;"><input class="btn btn-primary"
							id="check" type="button"  value=<%=search1%> style="padding-left:10px;"/> <!-- <input class="btn btn-warning "
							id="reset" type="button" value="重   置" /> --></td>
					</tr>

				</tbody>
			</table>
		</div>
		<div class="right_c">
			<div class="nav-tip" onClick="javascript:void(0)">&nbsp;</div>
		</div>
		<div class="Conframe" id="inc">
			<iframe name="Conframe" id="Conframe" frameborder=0 src="map.jsp">
			</iframe>
		</div>
		<!--右边框架结束-->
		<!--底部开始-->
		<!--  <div class="bottom_c">地图</div> -->
		<!--底部结束-->
	</div>
	
	<%@ include file="../system/index/foot.jsp"%>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
</body>
<script type="text/javascript">
	$(top.hangge());
</script>
<script type="text/javascript">
var pagedata={page:1,rows:20,begin:0,end:0,havenest:true,termid:null};//分页的全局变量，很重要 
var mapTermpage= new Object();//分页的全局变量，很重要 
var mapTermpagein= new Object();//分页的全局变量，很重要 
function getmapTermpage()
{
	var data=mapTermpage;
	return data;
}
function getmapTermpagein()
{
	var data=mapTermpagein;
	return data;
}
function setmapTermpage(index,data)
{
	mapTermpage[index]=data;
}
function gpsTObbdLfet_c(clientdata)
{	
	var star;
	if(clientdata.length<=1){
		star="<div class=\"panel-default\"><div class=\"panel-heading\"> <a style=\" float:left;width:10px;height:10px;border:1px solid #000}\" ><span class=\"glyphicon glyphicon-star-empty\"></span>";
	}else{
		star="<div class=\"panel-default\"><div class=\"panel-heading\"> <a style=\" float:left;width:10px;height:10px;border:1px solid #000}\" ><span class=\"glyphicon glyphicon-star\"></span>";
	}
	var accdivpre = star+"</a><a style=\"\" class=\"one\" id="+clientdata[0].termid+"><span style=\"font-size:12px;font-weight:normal; color:black;font-family:宋体\">"+clientdata[0].termname+"</span></a></div><ul class=\"kid\">";
	for(var i=0;i<clientdata.length;i++){
		if(clientdata[i].id!=null){
			var accdivli ="<li><b class=\"tip\"></b><a style=\" outline: none; margin-left:25px;\" class=\"onekid\"  id="+clientdata[i].id+"><span style=\"font-size:11px;color:black; font-family:宋体\">"+clientdata[i].name+"</span></a></li>";
			accdivpre=accdivpre+accdivli;
			}else if(clientdata[i].havenest==true){
				mapTermpage[clientdata[0].termid].havenest=true;
				var accdivli ="<li id=\"moreli\"><b class=\"tip\"></b><a  style=\" outline: none; margin-left:25px;\" class=\"onekid\" color:black;  id="+"more"+"><span style=\"color:black;\">"+"....."+"</span></a></li>";
				accdivpre=accdivpre+accdivli;
				} else {
						 mapTermpage[clientdata[0].termid].havenest=false;
					 }
				 }
	var accdivaft= "</ul></div>"; 
	accdivpre=accdivpre+accdivaft;
	$('.acc').append(accdivpre);
}
function gpsTObbdMore(clientdata,termid,choseterm)
{
    for(var i=0;i<clientdata.length;i++){
		var accdivli
		if(clientdata[i].id!=null){
		accdivli ="<li><b class=\"tip\"></b><a  style=\" outline: none; margin-left:25px;\" class=\"onekid\"  id="+clientdata[i].id+"><span style=\"font-size:11px;color:black;  font-family:宋体\">"+clientdata[i].name+"</span></a></li>";
		}else if(clientdata[i].havenest==true){
			mapTermpage[termid].havenest=true;
			accdivli ="<li id=\"moreli\"><b class=\"tip\"></b><a  style=\" outline: none; margin-left:25px;\" class=\"onekid\"  id="+"more"+"><span style=\"color:black;\">"+"....."+"</span></a></li>";
		}else {
				mapTermpage[termid].havenest=false;
		}
		choseterm.parent().parent().children("ul").append(accdivli);
		accdivli="";
	}   	
}

function gpsTObbdSearch(clientdata)
{
    var accdivpre = "<div class=\"panel-default\"><div class=\"panel-heading\"><a style=\" float:left;width:10px;height:10px;border:1px solid #000}\" ><span class=\"glyphicon glyphicon-hand-right\"></span></a><a class=\"one\" id=\"search\"><span style=\"font-size:12px;color:black;  font-weight:normal;font-family:宋体\">"
		+"<%=search_get_device%>"
		+ "</span></a></div><ul class=\"kid\">";
        for(var i=0;i<clientdata.length;i++){
        	var accdivli = "<li><b class=\"tip\"></b><a  style=\" outline: none; margin-left:25px;\" class=\"onekid\"  id="
				+ clientdata[i].id
				+ "><span style=\"font-size:11px;color:black;  font-family:宋体\">"
				+ clientdata[i].name
				+ "</span></a></li>";
			accdivpre = accdivpre+ accdivli;
		}
    var accdivaft = "</ul></div>";
	accdivpre = accdivpre + accdivaft;
	$('.searchacc').append(accdivpre);
        			
}

function gpsTObbddrawing(clientdata)
{
    var accdivpre = "<div class=\"panel-default\"><div class=\"panel-heading\"><a style=\" float:left;width:10px;height:10px;border:1px solid #000}\" ><span class=\"glyphicon glyphicon-hand-right\"></span></a><a class=\"one\" id=\"draw\"><span style=\"font-size:12px;color:black;  font-weight:normal;font-family:宋体\">"
		+ "<%=circle_select%>"
		+ "</span></a></div><ul class=\"kid\">";
        for(var i=0;i<clientdata.length;i++){
        	var accdivli = "<li><b class=\"tip\"></b><a  style=\" outline: none; margin-left:20px;\" class=\"onekid\"  id="
				+ clientdata[i].id
				+ "><span style=\"font-size:11px;color:black;  font-family:宋体\">"
				+ clientdata[i].name
				+ "</span></a></li>";
			accdivpre = accdivpre+ accdivli;
		}
    var accdivaft = "</ul></div>";
	accdivpre = accdivpre + accdivaft;
	$('.searchacc').append(accdivpre);      			
}
var choseterm;//表示选择的term；
var chosetermid; //表示选择的term的id；
function setChosetermid(){
	//console.log(1234567890);
	chosetermid=choseterm.attr("id");
	//console.log(chosetermid);
}
function setChosetermid2(data){
	//console.log(data);
	chosetermid=data;
}
function getChosetermid(){
	var chose=chosetermid;
	return chose;
}
//加载左边的列表
	$.ajax({
		url : "gomap/lefe_c",
		type : "POST",
		contentType : "application/json; charset=UTF-8",
		data : JSON.stringify(pagedata),
		dataType : "json",
		success : function(data) {
			if (data != null) {
				//console.log(data);
				 for(var key in data)   {
					 var pagedata1={page:1,rows:20,begin:0,end:0,havenest:false,termid:data[key][0].termid};///////////
					 var pagedata2={page:1,rows:20,begin:0,end:0,havenest:false,termid:data[key][0].termid};///////////
					 mapTermpage[data[key][0].termid]=pagedata2;
					 mapTermpagein[data[key][0].termid]=pagedata1;
					 gpsTObbdLfet_c(data[key]);
					 }
				
				 for(var c in mapTermpage)   {
					 mapTermpage[c].begin= mapTermpage[c].begin+ mapTermpage[c].rows;
				 }
				 //console.log(mapTermpage);
				 
			} else {
			}
		},
		error : function() {
		}
	});


	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// 获取路灯搜索条件
	//加载组名
	jQuery.getJSON("gomap/getgroupname", function(data) {
		//console.log(data);
		for (var i = 0; i < data.length; i++) {
			$("#groupname").append(
					"<option value=" + data[i].id + ">" + data[i].name
							+ "</option>");
		}
	});
	//加载终端类型
	function changegroupname() {

		$("#terminaltype").empty();
		$("#address").empty();
		$("#terminalname").empty();
		$("#terminalid").empty();

		jQuery.getJSON("gomap/getTypenameByGroup/" + $("#groupname").val(),
						function(data) {
							$("#terminaltype").append(
									"<option  value=\"\"> </option>");
							for (var i = 0; i < data.length; i++) {
								$("#terminaltype").append(
										"<option  value=" + data[i].typeid + ">"
												+ data[i].typename
												+ "</option>");
							}
						});
	}

	//加载终端地址
	function changeterminaltype() {
		$("#address").empty();
		$("#terminalname").empty();
		$("#terminalid").empty();
		var condinate = {
			termid : $("#groupname").val(),
			typeid : $("#terminaltype").val()
		};
		$.ajax({
			url : "gomap/getAddressByType",
			type : "POST",
			contentType : "application/json; charset=UTF-8",
			data : JSON.stringify(condinate),
			dataType : "json",
			success : function(data) {
				if (data != null) {
					$("#address").append("<option  value=\"\"> </option>");
					for (var i = 0; i < data.length; i++) {
						$("#address").append(
								"<option  value=" + data[i].location + ">"
										+ data[i].location + "</option>");
					}
				} else {
				}
			},
			error : function() {
				Conframe.window. searchConerr();
			}
		});
	}
	//加载终端名稱	
	function changeAddress() {
		$("#terminalname").empty();
		$("#terminalid").empty();
		var condinate = {
			termid : $("#groupname").val(),
			typeid : $("#terminaltype").val(),
			location : $("#address").val()
		};
		$
				.ajax({
					url : "gomap/getClientnameByaddress",
					type : "POST",
					contentType : "application/json; charset=UTF-8",
					data : JSON.stringify(condinate),
					dataType : "json",
					success : function(data) {
						if (data != null) {
							$("#terminalname").append(
									"<option  value=\"\"> </option>");
							for (var i = 0; i < data.length; i++) {
								$("#terminalname").append(
										"<option  value=" + data[i].name + ">"
												+ data[i].name + "</option>");
							}
						} else {
						}
					},
					error : function() {
						Conframe.window. searchConerr();
					}
				});
	}
	function changeterminalname() {
		$("#terminalid").empty();
		var condinate = {
			termid : $("#groupname").val(),
			typeid : $("#terminaltype").val(),
			location : $("#address").val(),
			name : $("#terminalname").val()
		};
		$.ajax({
			url : "gomap/getClientigByname",
			type : "POST",
			contentType : "application/json; charset=UTF-8",
			data : JSON.stringify(condinate),
			dataType : "json",
			success : function(data) {
				if (data != null) {
					$("#terminalid").append("<option  value=\"\"> </option>");
					for (var i = 0; i < data.length; i++) {
						$("#terminalid").append(
								"<option  value=" + data[i].id + ">"
										+ data[i].id + "</option>");
					}
				} else {
				}
			},
			error : function() {
				Conframe.window. searchConerr();
				
			}
		});
	}
	/*
	 jQuery.getJSON("map/getterminalname/"+ $("#address").val(), function(data) {
	 for (var i = 0; i < data.length; i++) {$("#terminalname").append(
	 "<option value=" + data[i].terminalname + ">"+ data[i].terminalname + "</option>");
	 }
	 });
	 jQuery.getJSON("map/getterminalid/"+ $("#address").val(), function(data) {
	 for (var i = 0; i < data.length; i++) {$("#terminalid").append(
	 "<option value=" + data[i].terminalid + ">"+ data[i].terminalid + "</option>");
	 }
	 });
	 */
	var searchdata;//全局变量，很重要
	function changesearchdata(data)
	{
		searchdata=data;
	}
	var drawdata;//全局变量，很重要
	function changedrawdata(data)
	{
		drawdata=data;
	}
	function cleardrawdata()
	{
		$("#draw").parent().parent().remove();
	}
	$(function() {
		init();
	});
</script>

	<script type="text/javascript">
	$('.searchacc').hide();
	$(function () {
	   $('#s').click(function () {
		   $('#g').parent().removeClass("active");
		   $('.acc').hide();
		   $('.searchacc').show();
	  		$(this).parent().addClass("active");
	   });
				
   $('#g').click(function () {
		   $('#s').parent().removeClass("active");
		   $('.searchacc').hide();
		   $('.acc').show();
	  		 $(this).parent().addClass("active");
	   });
	
	});
	
	</script>
</html>