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
<html>
<head>
<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>地图</title>
<%@ include file="WEB-INF/jsp/international.jsp"%>
<link rel="stylesheet" type="text/css"
	href="static/map/css/jquery-ui-1.10.4.custom.min.css" />
<link rel="stylesheet" type="text/css"
	href="static/map/css/ui.jqgrid.css" />
<link rel="stylesheet" type="text/css"
	href="static/map/css/ui.jqgrid.css" />
<link rel="stylesheet" type="text/css"
	href="static/map/css/admin-all.css" />
<link rel="stylesheet" type="text/css" href="static/map/css/base.css" />
<link rel="stylesheet" type="text/css" href="static/map/css/formui.css" />
<link rel="stylesheet" type="text/css" href="static/map/css/chur.css" />
<link rel="stylesheet" type="text/css"
	href="static/map/css/bootstrap.min.css" />
<script type="text/javascript" src="static/map/js/jquery-1.7.2.js"></script>
<script type="text/javascript"
	src="static/map/js/jquery-ui-1.10.3.custom.min.js"></script>
<script type="text/javascript" src="static/map/js/grid.locale-cn.js"></script>
<script type="text/javascript"
	src="static/map/js/jquery.jqGrid.4.5.2.min.js"></script>
<script type="text/javascript" src="static/map/js/index.js"></script>
<script type="text/javascript"
	src="static/map/js/ChurAlert.min.js?skin=blue"></script>
<script type="text/javascript" src="static/map/js/chur-alert.1.0.js"></script>
<script type="text/javascript" src="static/map/js/mapContent.js"></script>
<script type="text/javascript" src="static/map/js/map.js"></script>
<script src="http://maps.googleapis.com/maps/api/js?key=AIzaSyBzE9xAESye6Kde-3hT-6B90nfwUkcS8Yw&sensor=false">
</script>
<!-- <script type="text/javascript"
	src="http://api.map.baidu.com/library/DrawingManager/1.4/src/DrawingManager_min.js"></script>
<link rel="stylesheet"
	href="http://api.map.baidu.com/library/DrawingManager/1.4/src/DrawingManager_min.css" /> -->
<!-- 	<script type="text/javascript" src="static/map/js/DrawingManager_min.js"></script> -->
	<link rel="stylesheet" type="text/css" href="static/map/css/DrawingManager_min.css" />
	<base href="<%=basePath%>">
	   <!--  <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" rel="stylesheet" type="text/css" />--> <!-- <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap3-dialog/1.34.5/css/bootstrap-dialog.min.css" rel="stylesheet" type="text/css" /> -->
 <script type="text/javascript" src="static/map/js/jquery-2.1.4.min.js"></script>
<!--<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap3-dialog/1.34.5/js/bootstrap-dialog.min.js"></script>-->
  <link rel="stylesheet" type="text/css" href="static/map/css/bootstrap-dialog.min.css" />
 <script type="text/javascript" src="static/map/js/bootstrap.min.js"></script>
 <script type="text/javascript" src="static/map/js/bootstrap-dialog.min.js"></script>
 
 
 <style type="text/css">
html {
	height: 100%
}

body {
	height: 100%;
	margin: 0px;
	padding: 0px
}

#container {
	height: 100%
}
/* 不出现百度logo */
.anchorBL {
	display: none
}
/* 让弹出框背景不变暗 */
.modal-backdrop {
  opacity: 0 !important;
  filter: alpha(opacity=0) !important;
}
/* 让弹出框不出现蓝色边框 */
*{outline:none;}
</style>
</head>
<body>
	<div id="container"></div>
	<input type=button id='mapclick' onclick="map.setOptions({draggableCursor:'crosshair'});"></input>
	<input type=button id='addMarker' onclick="addClickMarker()"></input>
	<input type=button id='clearMarker' onclick="clearOverlaysByPartMapID()"></input>
	<input type=button id='openMarker' onclick="openPartMap()"></input>
	<input type=hidden id='MarkerXYCoordinate'></input>
	<input type=hidden id='addPartMapFlag'></input>
	<input type =hidden id='partMapName'></input>
	<input type =hidden id='partMapURL'></input>
	<input type =hidden id='partMapID'></input>
	<input type =hidden id='PartMapExist'></input>
	
</body>
<script type="text/javascript">

	var choseMaker;//全局变量很重要////////////////////////////////////////////////////////////////
	var choseMakerdata;//全局变量很重要////////////////////////////////////////////////////////////
	var desMakerdata;//全局变量很重要////////////////////////////////////////////////////////////
	var srcMakerdata;
	var moveo='false';   //捕获到的事件
    var moveX;  //box水平宽度
    var moveY;  //box垂直高度
    var gtermid;
    var gGatewayID;
    var gPartMapCoordinate='';
    var gMarker;
    var markers = [];
    var gPartmaps =[];
    var lat = 30.277330575908053;
    var lng = 120.13664131227415;
    var zoom = 12;
    var gCenter =new google.maps.LatLng(lat, lng)
    var mapType = google.maps.MapTypeId.ROADMAP;
  
    var mapOptions = {
        center: gCenter,  //地图的中心点
        zoom: zoom,              //地图缩放比例
        mapTypeId: mapType,  //指定地图展示类型：卫星图像、普通道路
        scrollwheel: true        //是否允许滚轮滑动进行缩放
    };
    var gooleMapFlag = '1'; //google map flag
    var map = new google.maps.Map(document.getElementById("container"), mapOptions); //创建谷歌地图
	
	function getClientsData(mapTermpage2,mapcenter,mapzoom) {
		//地图初始化时候，局部地图也同时初始化
		if(mapcenter==null){
			clearAllOverlays();
		}
		gtermid = mapTermpage2.termid;
		gGatewayID = mapTermpage2.gatewayid;
		var tempobj =mapTermpage2;
		mapTermpage2.typeid=null;
		mapTermpage2.location=null;
		mapTermpage2.name=null;
		mapTermpage2.id=null;
		mapTermpage2.client_attri_id='';
		var partMaplightExists =false;
		$.ajax({
			url : "gomap/addClientMaker",
			type : "POST",
			contentType : "application/json; charset=UTF-8",
			data : JSON.stringify(mapTermpage2),
			dataType : "json",
			success : function(clientdata) {
				if (clientdata.length!=0) {
					var arrpoints=[];
					desMakerdata = clientdata;//记录当前展示的数据
					srcMakerdata=  clientdata;//记录当前展示的数据
					for(var i=0;i<desMakerdata.length;i++){
						if(desMakerdata[i].coordinate_google!=null){
							desMakerdata[i].xcoordinate = desMakerdata[i].coordinate_google.split(",")[0];
							desMakerdata[i].ycoordinate = desMakerdata[i].coordinate_google.split(",")[1];
						}
					}
					gpsTObbd(arrpoints,clientdata,mapcenter,mapzoom);//////坐标转换
					//addClientMaker(clientdata,mapcenter,mapzoom); 
				} else {
					if(!partMaplightExists){
					//desMakerdata = [];
					//map.centerAndZoom("杭州", 14);
					BootstrapDialog.show({
		                type:  BootstrapDialog.TYPE_INFO,
		                title: "<%=remind_infomation%>",
		                message:  "<%=the_packet_has_no_terminal%>",
		                buttons: [{
		                    label: "<%=shut_down%>",
		                    action: function(dialogItself){
		                        dialogItself.close();
		                    }
		                }]
		            });
				}
				}
			},
			error : function() {
				BootstrapDialog.show({
	                type:  BootstrapDialog.TYPE_DANGER,
	                title: "<%=remind_infomation%>",
	                message: "<%=wrong_search%>",
	                buttons: [{
	                    label: "<%=shut_down%>",
	                    action: function(dialogItself){
	                        dialogItself.close();
	                    }
	                }]
	            });
			}
		});
		
		if(mapcenter==null)
		{
			$.ajax({
				url : "gomap/getPartMapInfo",
				type : "POST",
				data : {termid:mapTermpage2.termid,partMapID:$('#partMapID').val(),
					gatewayID:gGatewayID},
				dataType : "json",
				success : function(aPartmap) {
					var tempPartMapID ='';
					if (aPartmap.length!=0) {
						var j=0;
						for(var i=0;i<aPartmap.length;i++){
							document.getElementById('partMapID').value=aPartmap[i].id;
							document.getElementById('MarkerXYCoordinate').value=aPartmap[i].external_coordinate;
							if(aPartmap[i].id!=tempPartMapID){
								addClickMarker();
								gPartmaps[j]=aPartmap[i].id;
								j++;
							}
							partMaplightExists=true;
							tempPartMapID= aPartmap[i].id;
							//用完变量初始化
							document.getElementById('partMapID').value='';
						}
					}
				}	
				});
		}
	}
	//终端的坐标更新
	//newCoordinate:新坐标
	//client_attri_id：终端的ID
	function updateClientCoordinate(newCoordinate,client_attri_id,clientType) {
		$.ajax({
			url : "gomap/upateClientMakerCoordinate",
			type : "POST",
			data: {coordinate:newCoordinate,client_attri_id:client_attri_id,clientType:clientType,mapFlag:gooleMapFlag},
			dataType : "json",
			cache: false,
			success : function(data) {
				for(var i=0;i<desMakerdata.length;i++){
					if(desMakerdata[i].client_attri_id==client_attri_id){
						if(newCoordinate!=null){
							desMakerdata[i].xcoordinate=newCoordinate.split(",")[0];
							desMakerdata[i].ycoordinate=newCoordinate.split(",")[1];
							srcMakerdata[i].coordinate_google_source =newCoordinate.split(",")[0]
							 + ','+newCoordinate.split(",")[1];
						}
						break;
					}
				}	
			},
			error : function() {
				BootstrapDialog.show({
	                type:  BootstrapDialog.TYPE_DANGER,
	                title: "<%=remind_infomation%>",
	                message: "<%=wrong_search%>",
	                buttons: [{
	                    label: "<%=shut_down%>",
	                    action: function(dialogItself){
	                        dialogItself.close();
	                    }
	                }]
	            });
			}
		});
	}
	
	//获取局部图的路灯数据
	//map.addEventListener("click", showInfo);
	function getLightData(termid,clientid,marker) {
		var partMapid =document.getElementById('partMapID').value;
		if(marker!=null){
			partMapid = marker.partMapID;
		}
		$.ajax({
			url : "gomap/getClientInfo",
			type : "POST",
			data : {termid:termid,clientid:clientid,
				partMapID:partMapid,gatewayid:gGatewayID},
			dataType : "json",
			success : function(data) {
				if (data.length!=0) {
					if(clientid==''){
						if(marker!=null){
							marker.partLightData = data;
							marker.selLight ='';
							for(var i=0;i<data.length;i++){
								marker.selLight +="<option value="+data[i].id+">"+data[i].name+"</option>";
							}
						}
					}else{
 						//路灯跳动设置
						lightFlashSet();
					}
					//路灯已经在别的局部图里记载完了就不用下面的任何设置
					$("#serial_number").html(data[0].id);
					$("#lightName").html(data[0].name);
					$("#poleNumber").html(data[0].lamppolenum);
					$("#location").html(data[0].location);
					$("#groupName").html(data[0].termname);
					$("#brightnessValue").html(data[0].brightness);
					//局部地图上选择的路灯
					choseMakerdata= data[0];
					choseMakerdata.partmapflag =true;
				} 
				if(clientid==''){
					//只有路灯初次装载的时候才执行，局部地图才开启
					var strX;
					var strY;
					if(marker!=null && marker.coordinate!=null){
					 strX = marker.coordinate.split(",")[0];
					 strY = marker.coordinate.split(",")[1];
					}else{
						return ;
					}
					document.getElementById('MarkerXYCoordinate').value=marker.coordinate;
					document.getElementById('partMapID').value=marker.partMapID;
					var sContent = getmarkedContent(marker);
					marker.content =sContent;
					var infoWindow = new google.maps.InfoWindow
					({content: marker.content, maxWidth: 950 ,maxHeight: 400}); // 创建信息窗口对象
					infoWindow.open(map, marker); //开启信息窗口   
					$.ajax({
						url : "gomap/getPartMapInfo",
						type : "POST",
						data : {partMapID:document.getElementById('partMapID').value,gatewayID:gGatewayID,termid:gtermid},
						dataType : "json",
						success : function(aPartmap) {
								var tempMarkerPoint ='';
								if (aPartmap.length!=0) {
									for(var i=0;i<aPartmap.length;i++){
										if(aPartmap[i].inner_coordinate!=null){
											addLightToMapsub(
												aPartmap[i].inner_coordinate.split(",")[0],
												aPartmap[i].inner_coordinate.split(",")[1],	
												aPartmap[i].c_client_id
											)
										}
									}
									lightFlashSet();
								}
						
							}	
						});
				}
				if (marker!= null) {
					changeCenter(marker);
				}
			},
			error : function() {
				BootstrapDialog.show({
	                type:  BootstrapDialog.TYPE_DANGER,
	                title: "<%=remind_infomation%>",
	                message: "<%=wrong_search%>",
	                buttons: [{
	                    label: "<%=shut_down%>",
	                    action: function(dialogItself){
	                        dialogItself.close();
	                    }
	                }]
	            });
			}
		});
	
	}

	
	//路灯跳动设置
	function lightFlashSet(){
		var count=$("#selLight option").length; 
		//路灯跳动全清除
		for(var i=0;i<count;i++){
			var tempdiv = document.getElementById('light'+$("#selLight").get(0).options[i].value);
			if(tempdiv!=null){
				tempdiv.style.backgroundImage="url('uploadFiles/uploadImgs/partmap/light_green.png')";
			}
		}
		if(document.getElementById('light'+$('#selLight').val())!=null){
 			document.getElementById('light'+$('#selLight').val()).style.backgroundImage
 				="url('uploadFiles/uploadImgs/partmap/light_green_active.gif')";
		}
	}
		//得到所有的Marker和路灯数据
		function gpsTObbd(arrpoints,clientdata,mapcenter,mapzoom) {
	        var i = markers.length ;  
	        var j = 0 ;  
	        var ajaxLen =0;//要发起几次请求。  
	        for (j=0; j < clientdata.length; j++) {  
	        	var marker=null ;
				if(clientdata[j].coordinate_google!=null){
	           		clientdata[j].xcoordinate = clientdata[j].coordinate_google.split(",")[0];
	           		clientdata[j].ycoordinate = clientdata[j].coordinate_google.split(",")[1];
				}
          		marker = attachlightToMap(clientdata[j])
				
 	        }
	        if(marker!=null){
	        	changeCenter(marker);
	        }
		}
		//增加灯到地图
	
		function attachlightToMap(clientdata){
			var statuscolor;
			var clienttype;
			if ("正常" == clientdata.status) {
       			statuscolor = "green";
       		} else if ("异常" == clientdata.status) {
       			statuscolor = "red";
       		} else if ("断电" == clientdata.status) {
       			statuscolor = "grey";
       		} else {
       			statuscolor = "green";
       		}
             	//灯的类型定义
      		if ( clientdata.aliastypename.indexOf("灯" ) >=0) {
      			clienttype = "light_";
      		} else if (clientdata.aliastypename.indexOf("断路器" ) >=0) {
      			clienttype = "breaker_";
      		} else if (clientdata.aliastypename.indexOf("网关") >= 0) {
      			clienttype = "gateway_";
      		} else {
      			clienttype = "light_";
      		}
      		var lat =clientdata.xcoordinate;
      		var lng =clientdata.ycoordinate;
      		var marker;
//            	//灯的各种终端类型显示。（路灯，网关等）
          	var imageURL = "static/map/img/" + clienttype + statuscolor+ ".png"; 
          	
          	if ( clientdata.aliastypename.indexOf("灯" ) >=0) {
          		//路灯的场合，已经在局部地图上追加的部分，就不在地图上显示。
				if(clientdata.partMaplinetCnt==0){
					 marker = new google.maps.Marker({
	       	            position:new google.maps.LatLng(lat,lng),
	       	            icon: imageURL,
	       	             map: map,
	       	          	draggable: true
	       	          });
					}
          	}else{
      			 marker = new google.maps.Marker({
       	            position:new google.maps.LatLng(lat, lng),
       	            icon: imageURL,
       	             map: map,
       	          	draggable: true
       	          });
       		 }
          		if(marker!=null){
					
					marker.clientdata = clientdata;
					marker.aliastypename =clientdata.aliastypename;
					marker.client_attri_id = clientdata.client_attri_id;
					marker.id = clientdata.id;
					markers[markers.length]= marker;
					//i++;
					attachInformation(map,marker);
					dragMarker(map,marker);
          		}
          		
          		return marker;

		}
		
		//追加窗口信息事件
		function attachInformation(map,marker) {
			google.maps.event.addListener(marker,'click', function(e) {//这里是自定义覆盖物的事件
				var infoWindow = new google.maps.InfoWindow({content: marker.content,size: new google.maps.Size(650,150)}); // 创建信息窗口对象
				var clientData={} ;
				var tempCondition ={};
				tempCondition.termid=gtermid;
				tempCondition.gatewayid=gGatewayID;
				tempCondition.id = marker.id;
				$.ajax({
					url : "gomap/addClientMaker",
					type : "POST",
					contentType : "application/json; charset=UTF-8",
					data : JSON.stringify(tempCondition),
					dataType : "json",
					success : function(clientdata) {
						if(clientdata.length>0){
							if(clientdata.length>0){
								marker.content =  getInfoContent(clientdata[0]);
								marker.clientdata=clientdata[0];
								var infoWindow = new google.maps.InfoWindow	({content: marker.content}); // 创建信息窗口对象
								gMarker = marker
				   				infoWindow.open(map, marker); //开启信息窗口   
								choseMakerdata= marker.clientdata;
								choseMakerdata.partmapflag =false;
							}else{
								alert('There are no  light data');
							}
						}
		 
					}});
              });
			}
		//拖动事件发生
		function dragMarker(map,marker){
			marker.addListener("dragend", function(MouseEvent) {//这里是定义拖动事件
					var cType ='1';
					var tempxyCoordinate =MouseEvent.latLng;
					var xPoint= tempxyCoordinate.lat();
					var yPoint= tempxyCoordinate.lng();
					if (marker.aliastypename.indexOf("断路器" ) >=0) {
       					cType ='3';
	       			} else if (marker.aliastypename.indexOf("网关") >= 0) {
	       				cType ='2';
	       			}
					updateClientCoordinate(xPoint+','+yPoint,marker.client_attri_id ,cType);
					
			});
		}
	
///////////////////////////////////////////////////////////////////////////////////////////
// //局部图的上传的窗口打开
	google.maps.event.addListener(map,"click",function(e){
		if($('#addPartMapFlag').val()=='1'){
			$("#addPartMapFlag").attr("value",'');//
			var tempxyCoordinate =e.latLng;
			var xPoint= tempxyCoordinate.lat();
			var yPoint= tempxyCoordinate.lng();
			map.setOptions({draggableCursor:'default'})
			top.jzts();
			var diag = new top.Dialog();
			diag.Drag=true;
			diag.Title ='<%=part_map_add%>';   
			diag.URL = '<%=basePath%>/gomap/addpartmap.do?XPoint='+xPoint+'&YPoint='+yPoint+'&termID='+gtermid+'&gatewayid='+gGatewayID
			diag.Width = 400;
			diag.Height = 300;
			diag.Modal = true;				//有无遮罩窗口
			diag.ShowMaxButton = true;	//最大化按钮
			diag.ShowMinButton = true;		//最小化按钮
			diag.CancelEvent = function(){ //关闭事件
			if(diag.innerFrame.contentWindow.document.getElementById('partMapID').value!=''){
				gMarker.partMapID = diag.innerFrame.contentWindow.document.getElementById('partMapID').value;
				document.getElementById('partMapID').value =diag.innerFrame.contentWindow.document.getElementById('partMapID').value;
			}
			
			diag.close();
			};
			diag.show();
		}else{
		//	getLightData(gtermid,'',null);
		}
	
	});
	
	
	function clearAllOverlays(){
		//局部图ID也初始化
		document.getElementById('partMapID').value ='';
		document.getElementById('PartMapExist').value ='';
		gPartmaps =[];
		//所有的Marks删除
		for(var i=0;i<markers.length;i++){
			var marker =markers[i];
			if(marker!=null){
				marker.setMap(null); 
			}
		}
	}
	
	//清除指定的局部地图覆盖层
	function clearOverlaysByPartMapID(){
		for(var i=0;i<markers.length;i++){
			var marker =markers[i];
			if(marker!=null){
				if(marker.partMapID==document.getElementById('partMapID').value){
					marker.setMap(null);
					return;
				}
			}
		}

	}
	
	//指定灯的Marks删除
	function clearOverlaysByClientID(clinetid){
		//指定灯的Marks删除
		for(var i=0;i<markers.length;i++){
			var marker =markers[i];
			if(marker!=null){
				if(marker.id==clinetid){
					marker.setMap(null);
					markers[i]=null;
					//坐标重置
					if(desMakerdata[i]!=null && gMarker!=null){
						for(var j=0;j<desMakerdata.length;j++){
							if(desMakerdata[j].id==clinetid){
								desMakerdata[j].xcoordinate = gMarker.coordinate.split(",")[0];
								desMakerdata[j].ycoordinate = gMarker.coordinate.split(",")[1];
								return;
							}
						}
					}
					
				}
			}
		}
	}

	//打开局部子画面
	function openPartMapSub(marker,addLight){
// 		//当List画面修改的时候才追加路灯。
		getLightData(gtermid,'',marker);
		
	}
	
	//打开指定的覆盖层
	function openPartMap(){
		document.getElementById('PartMapExist').value ='1';
		var partmapExistFlag=false;
		if(gMarker!=null){
			if(gMarker.partMapID==document.getElementById('partMapID').value){
				openPartMapSub(gMarker,true);
				partmapExistFlag=true;
			}
		}
		if(!partmapExistFlag){
			for(var i=0;i<markers.length;i++){
				var marker =markers[i];
				if(marker.partMapID==document.getElementById('partMapID').value){
					openPartMapSub(marker,true);
					partmapExistFlag=true;
				}
			}
		}
		if(!partmapExistFlag){
			document.getElementById('PartMapExist').value ='0';
			alert('<%=forbitModifyPartMap%>')
		}
	}
	
	//增加指定的覆盖层
	function addClickMarker(){
		if(document.getElementById('MarkerXYCoordinate').value!=null&&
				document.getElementById('MarkerXYCoordinate').value!=undefined){
			var strX;
			var strY;
			if(document.getElementById('MarkerXYCoordinate').value!=null){
				strX = document.getElementById('MarkerXYCoordinate').value.split(",")[0];
				strY = document.getElementById('MarkerXYCoordinate').value.split(",")[1];
			}
			var imageURL = 'static/map/img/partMapMarkers.jpg';
  			var marker = new google.maps.Marker({
   	            position:new google.maps.LatLng(strX, strY),
   	            icon: imageURL,
   	             map: map,
   	          });
  			marker.coordinate = document.getElementById('MarkerXYCoordinate').value;
			marker.partMapID =  document.getElementById('partMapID').value;
			gMarker =marker;
			markers[markers.length] = marker;
			gPartmaps[gPartmaps.length]=marker.partMapID;
			if(marker!=null){
				marker.addListener('click', function(e) {//这里是自定义覆盖物的事件
					if($('#addPartMapFlag').val()!='1'){
						getLightData(gtermid,'',marker);
						
					}
					gMarker = this;
				});
				changeCenter(marker);
			}
			
			
		}
	}
	


		 var o, //捕获到的事件
	     X,  //box水平宽度
	     Y;  //box垂直高度
	 function getObject(obj,e){    //获取捕获到的对象
	        o = obj;
	        document.all?o.setCapture() : window.captureEvents(Event.MOUSEMOVE);  
	        X = e.clientX - parseInt(o.style.left);   //获取宽度，
	        Y = e.clientY - parseInt(o.style.top);   //获取高度，
	    }
	 document.onmousemove = function(dis){    //鼠标移动事件处理
	        if(!o){    //如果未获取到相应对象则返回
	            return;
	        }
	        if(!dis){  //事件
	            dis = event ;
	        }
	        o.style.left = dis.clientX - X +"px";     //设定box样式随鼠标移动而改变
	        o.style.top = dis.clientY - Y + "px";
	    };
	    document.onmouseup = function(){    //鼠标松开事件处理
	        if(!o){   //如果未获取到相应对象则返回
	            return;
	        }
	        document.all?o.releaseCapture() : window.captureEvents(Event.MOUSEMOVE|Event.MOUSEUP)
	        o = '';   //还空对象
	    };
	    
	 //增加路灯到局部图片  (sub function)
	function addLightToMapsub(xPoint,yPoint,clientid){
		var div = document.createElement("div");
		div.style.position = "absolute";
		// 可以根据参数设置元素外观   
		div.style.width = "15px";
		div.style.height = "15px";
		div.style.left = xPoint+"px";
		div.style.top = yPoint+"px";
		var backgroundimage = "url('uploadFiles/uploadImgs/partmap/light_green_active.gif')";
		div.style.backgroundImage = backgroundimage;
		div.id = "light"+clientid;
		div.name =xPoint+','+yPoint;
		div.onclick = function() {
			
		};
		div.onmousedown = function(e){ 
	        getObject(this,e||event);  
	    	//this.name =o.style.left+','+o.style.top;
	    };
	    div.onmouseup = function(e){ 
	    	this.name =o.style.left.replace("px","")+','+o.style.top.replace("px","");;
	    };

		document.getElementById('partMapImg').appendChild(div);
	
	}
	//增加路灯到局部图片
	function addLightToMap() 
	{
		if((document.getElementById('selLight').value)==''){
			//alert('请选择需要加载的路灯');
			alert('<%=road_light_open_faliue%>');
		}else{
			//if(confirm("确定需要该位置加载路灯吗?")){
				if(confirm('<%=part_map_load_light%>')){
				
				 if(!document.getElementById('light'+$('#selLight').val())){
					 	addLightToMapsub(event.offsetX,event.offsetY,$("#selLight").val());
					}else{
						//alert('该路灯已经存在，不能重复添加，可以移动路灯位置');
						alert('<%=part_map_light_exists%>');
					}
			
			}
		}
	}
	//删除已经添加在局部地图上的路灯
	function delLightFromPartMap(){
		//div 存在的时候删除
		if(confirm("确定要删除该路灯吗?")){
			if(document.getElementById('light'+$('#selLight').val())){
				var tempdiv = document.getElementById('light'+$('#selLight').val());
				document.getElementById('partMapImg')
				.removeChild(document.getElementById('light'+$('#selLight').val()))
				$.ajax({
					url : "gomap/delPartMapDetail",
					type : "POST",
					data : {
							CLIENT_ID:tempdiv.id.replace("light",""),
							ID:$('#partMapID').val(),

					},
					dataType : "json",
					success : function(clientdata) {
					//路灯重新加载
					for(var i=0;i<srcMakerdata.length;i++){
						if(srcMakerdata[i]!=null &&
								srcMakerdata[i].client_attri_id==$('#selLight').val()){
							if(srcMakerdata[i].coordinate_google_source!=null){
								srcMakerdata[i].xcoordinate = srcMakerdata[i].coordinate_google_source.split(",")[0];
								srcMakerdata[i].ycoordinate = srcMakerdata[i].coordinate_google_source.split(",")[1];
								
							}
							attachlightToMap(srcMakerdata[i]);
							break;
						}
					}
					alert('<%=part_map_light_del_success%>');
					},
					error : function() {
						BootstrapDialog.show({
			                type:  BootstrapDialog.TYPE_DANGER,
			                title: "<%=remind_infomation%>",
			                message:  "<%=Part_map_delLightFromPartMapFailed%>",
			                buttons: [{
			                    label: "<%=shut_down%>",
			                    action: function(dialogItself){
			                        dialogItself.close();
			                    }
			                }]
			            }); 
					}
				});
			}else{
				//alert('此路灯已经删除或者不存在！');	
				alert('<%=part_map_light_del_confirm%>')
				
			}
		}
	}
	
	//保存已经添加在局部地图上的路灯
	function addLightToPartMap(){
		var count=$("#selLight option").length; 
		var succssflag=true;
		var lightnum =0;
		for(var i=0;i<count;i++){
			var tempdiv = document.getElementById('light'+$("#selLight ").get(0).options[i].value);
			if(tempdiv!=null){
				lightnum++;
				$.ajax({
					url : "gomap/savePartMapToDetail",
					type : "POST",
					data : {
							ID :$("#partMapID").val(),
							INNER_COORDINATE:tempdiv.name.replace("px",""),
							CLIENT_ID:tempdiv.id.replace("light",""),
					},
					dataType : "json",
					success : function(clientdata) {
						succssflag=true;	
						
					},
					error : function() {
						BootstrapDialog.show({
			                type:  BootstrapDialog.TYPE_DANGER,
			                title: "<%=remind_infomation%>",
			                message:  "<%=Part_map_addLightToPartMapFailuer%>",
			                buttons: [{
			                    label: "<%=shut_down%>",
			                    action: function(dialogItself){
			                        dialogItself.close();
			                    }
			                }]
			            }); 
						succssflag=false;
					}
				});
				
				clearOverlaysByClientID($("#selLight ").get(0).options[i].value);
			}
			if(!succssflag){
				return;
			}
		}
		if(lightnum>0){
			//alert("路灯已保存完毕！");
			alert('<%=part_map_light_save_finished%>');
		}else{
			//alert("没有要保存的路灯！");
			alert('<%=part_map_noLight_need_save%>');
		}
	}
	
	function change_light(clientid){
		getLightData(gtermid,clientid,null);
		
	}
	//增加路标（marker）到地图
	function getmarkedContent(marker){
		 //路灯
		var id='';
		var name='';
		var lamppolenum='';
		var location='';
		var termname='';
		var brightness='';
		var filename =''
		if (marker.partLightData!=null&&marker.partLightData!=''){
			id=marker.partLightData[0].id ;
			name =marker.partLightData[0].name;
			lamppolenum =marker.partLightData[0].lamppolenum;
			location =marker.partLightData[0].location;
			termname=marker.partLightData[0].termname;
			brightness = marker.partLightData[0].brightness;
			filename = marker.partLightData[0].map_pictrue_path;
		}
	   var sContent_light =   
		   "<html>"+
		   "<head>"+
		   "<title>"+"Insert title here"+"</title>"+
		   "<style type='text/css' > .image {border:1px solid #000;width: 380px;height:460px;overflow:hidden}"+
		   " .image img{max-width:400px;_width:expression(this.width>400?'400px':this.width)}"+
		   " .table_c  {border:1px solid #000;width:500px;height:500px;overflow:hidden}"+
		   " .light_green  {width:15px;height:15px;overflow:hidden;position: absolute;background-image:url(static/map/img/light_green.png)}"+
		   " .light_red  {width:15px;height:15px;overflow:hidden;position: absolute;background-image:url(static/map/img/light_red.png)}"+
		   " .light_grey  {width:15px;height:15px;overflow:hidden;position: absolute;background-image:url(static/map/img/light_grey.png)}"+
		   " .center  {text-align:center}"+
		   "</style>"+
		   "</head>"+
		   "<body>"+
		   "<table class='table-striped  table-hover' style='margin-top:5px;height=180px;width=990px' border='1' >"+
		   "<tr>"+
		   "<td width=400px rowspan=9>"+
		   "<div id='partMapImg' class='image'>"+
 		   		"<img onclick=addLightToMap() src=uploadFiles/uploadImgs/partmap/"+filename+ "/>"+
			"</div>"+
			"</td>"+
			"<td class='center' width='170px'>路灯选择"+
			"</td>"+
			"<td class='center' colspan=3 ><select id='selLight' onchange='change_light(this.options[this.options.selectedIndex].value)' style='width:150px;'>"+
			 marker.selLight +
			"</select>"+
			"</td>"+
			 "</tr>"+
			"<tr height=5px>"+
			"<td class='center'>"+"<%=serial_number%>"+
			"</td>"+
			"<td class='center' id='serial_number' colspan=3>"+id +
			"</td>"+
			
		   "</tr>"+
		   "<tr height=5px>"+
		   "<td class='center' >"+"<%=name%>"+
			"</td>"+
			"<td class='center'id='lightName' colspan=3>"+name +
			"</td>"+
		   "</tr>"+
		   "<tr height=5px>"+
		   "<td class='center'>"+"<%=pole_number2%>"+
			"</td>"+
			"<td class='center' id='poleNumber' colspan=3>"+lamppolenum +
			"</td>"+
		   "</tr>"+
		   "<tr height=5px>"+
		   "<td class='center'>"+"<%=location%>"+
			"</td>"+
			"<td class='center' id='location' colspan=3>"+location +
			"</td>"+
		   "</tr>"+
		   "<tr height=5px>"+
		   "<td class='center' >"+"<%=group_name%>"+
			"</td>"+
			"<td class='center' id='groupName' colspan=3>"+termname +
			"</td>"+
		   "</tr>"+
		   "<tr height=5px>"+
		   "<td class='center'>"+"<%=brightness_value%>"+
			"</td>"+
			"<td class='center' id='brightnessValue' colspan=3>"+brightness +
			"</td>"+
		   "</tr>"+

		   "<tr height=100px>"+
		   "<td> "+
		   "<div class='bottom'>"+
     		"<div class='b1' onclick ='TurnOnLight()'>"+
					"<div class='bimg1'>"+
						"<img src='static/map/img/bulb_on.png'>"+
						"<a href='javascript:void(0)'>"+"<%=open_light%>"+"</a>"+
					"</div>"+
			"</div>"+
			 "</td><td width=120px> "+	
		"<div class='b2' onclick ='TurnOffLight()'>"+
			"<div class='bimg2'>"+
					"<img src='static/map/img/bulb_off.png'>"+
					"<a href='javascript:void(0)'>"+"<%=shut_down_light%>"+"</a>"+
			"</div>"+
		
		"</div>"+
		 "</td><td width=160px> "+	
		"<div class='b3' onclick ='PolicyControl()'>"+
			"<div class='bimg3'>"+
					"<img src='static/map/img/policy_control.png'>"+
					"<a href='javascript:void(0)' >"+"<%=control_strategy%>"+"</a>"+
			"</div>"+
		"</div>"+
		 "</td><td width=120px> "+	
			"<div class='btx4'>"+
				"<%=brightness_value%>"+":"+
				"<select style='width:60px;' onchange='change_bright(this.options[this.options.selectedIndex].value)'>"
			        var lightop="";
					for(var i = 0; i <=100; i=i+10){
						var lightop2="";
						if(marker.partLightData!=null &&marker.partLightData!=''
								&&i!=marker.partLightData[0].brightness)
							{

								lightop2="<option value="+i+">"+i+"</option>";
							}else{
								lightop2="<option value="+i+" selected = 'selected'>"+i+"</option>";
							}
						lightop=lightop+lightop2;
					}
					 sContent_light=sContent_light+lightop+
		    	"</select>"+
	    	"</div>"+
    	"</td>"+		
			"</div>"+
			"</td>"+
		   "</tr>"+
		   "<tr height=95px>"+
		   "<td colspan=4 class='center'>"+
		   "<a class='btn btn-xs btn-success' onclick='addLightToPartMap();'><%=part_map_confirm_light %></a>&nbsp;&nbsp;"+
		   "<a class='btn btn-xs btn-danger' onclick='delLightFromPartMap();'><%=part_map_delete_light %></a>"+
			"</td>"+
		   "</tr>"+
			 "</table>"+
		   "</body>"+
		  
		   "</html>";
		 
		   return sContent_light;
	}
// 	//叠加层点击事件    ////已经没有用了   
// 	function fo(e) {
// 		infoWindow.enableCloseOnClick();
// 		setTimeout(function() {map.removeEventListener("click", fo);}, 300); //这里取消绑定。         
// 		var point = new BMap.Point(e.point.lng, e.point.lat);
// 		map.openInfoWindow(infoWindow, point); //开启信息窗口    
// 		infoWindow=null;
// 		setTimeout(function() {map.removeEventListener("click", fo);}, 300); //这里取消绑定。                
// 	}
	//0.5秒后根据id改变地图的展示中心       
	function changeCenterByid(id) {
		var data;
		for(var i=0;i<desMakerdata.length;i++){
			if(id==desMakerdata[i].id)
			{
				data=desMakerdata[i];
				break;
			}
		}
		
		CenterMarker(data);
	}
	//改变地图的中心  
	function CenterMarker(data) {
		if(data!=null && data.xcoordinate!=null&& data.ycoordinate!=null){
			var marker = new google.maps.Marker({
		  	            position:new google.maps.LatLng(data.xcoordinate, data.ycoordinate),
		  	             map: map
		  	          });	
				marker.setAnimation(google.maps.Animation.BOUNCE);//
				map.setCenter(marker.getPosition());
				setTimeout(function() {marker.setMap(null);;
				}, 2000);
		}else{
			alert('<%=PartMap_Light_No_Exists%>');
			
		}
	}
	//0.3秒后根据Point改变地图的展示中心       
	function changeCenter(marker) {
		if(marker==null){
			map.setCenter(gCenter,10);
		}else{
			map.setCenter(marker.getPosition());
		}
		map.setZoom(8);
	}
	//改变地图的zoom大小    
	function changeZoom(center, minx, miny, maxx, maxy,mapcenter,mapzoom) {
		
	}
	//清除所有覆盖物   
	function cleanAllMaker() {
		///map.clearOverlays();
	}
	//清除所有覆盖物   
	function cleanAllMaker1() {
		//console.log(12121);
		//map.clearOverlays();
	}
	//得到选择的哪一个点
	function getMakerIconAndInfo(div, data) {
		//console.log(div);
		//console.log(data);
		//infoWindow.setContent(content: String | HTMLElement);
		//infoWindow.redraw()	;

	}
	//改变PreMakerdata，用于searchdata
	function changePreMakerdata(data) {
// 		desMakerdata=data;
	}
	//判断是否在选择框内
	var drawdata;
	function judgeSelection(bound) {
// 		var drawtata=[];
// 		var drawid=[];
// 		for(var i=0;i<desMakerdata.length;i++){
// 			var judgepoint = new BMap.Point(desMakerdata[i].xcoordinate,desMakerdata[i].ycoordinate);
// 			if(bound.containsPoint(judgepoint))
// 				{
// 				 drawid.push(desMakerdata[i].id);
// 				 desMakerdata[i].searchconditions=null;
// 				 drawtata.push(desMakerdata[i]);
// 				}
// 		}
// 		for(var i=0;i<drawtata.length;i++){
// 			var a=drawtata[i];
// 			a.drawid=drawid;
// 		}
// 		if(drawtata.length>0){
// 			parent.cleardrawdata();//删除原有的左边框选列表
// 			parent.setmapTermpage(-2,drawtata[0]);
// 			//parent.changedrawdata(drawtata);//用于再次点击时可以加载出来
// 			parent.gpsTObbddrawing(drawtata);//添加左边框选列表
// 			drawdata=drawtata;
// 		}
// 		else{
<%-- 				alert("<%=no_data_in_box%>"); --%>
// 				CircleAndRectangle.removeContextMenu(menu);
// 				map.removeOverlay(CircleAndRectangle);
// 				CircleAndRectangle = null;
// 			}
	}
	function TurnOnLight() {
		if(choseMakerdata.partmapflag ==true){
			if(document.getElementById('light'+$('#selLight').val())==null){
				//alert('该路灯没有在局部图上加载。不能进行此操作');
				alert('<%=part_map_light_notexist_inPart%>')
				return;
			}
		}
		if (choseMakerdata.brightness != 0) {
			 BootstrapDialog.show({
	                type:  BootstrapDialog.TYPE_DANGER,
	                title: "<%=remind_infomation%>",
	                message: "<%=road_light_has_open_status%>",
	                buttons: [{
	                    label: "<%=shut_down%>",
	                    action: function(dialogItself){
	                        dialogItself.close();
	                    }
	                }]
	            });  
		} else {
		//	console.log(choseMakerdata);
			
			$.ajax({
						url : "gomap/updateClientAttr_status",
						type : "POST",
						contentType : "application/json; charset=UTF-8",
						data : JSON.stringify(choseMakerdata),
						dataType : "json",
						success : function(data) {
							if (data.status == "SUCCESS") {
								//choseMaker.style.backgroundImage = "url('map/img/light_green.png')";
								//cleanAllMaker();//清除所有覆盖物
								var a;
								var mapcenter=map.getCenter();
								var mapzoom=map.getZoom();
								 BootstrapDialog.show({
						                type:  BootstrapDialog.TYPE_PRIMARY,
						                title: "<%=remind_infomation%>",
						                message: "<%=road_light_open_success%>",
						                buttons: [{
						                    label:"<%=shut_down%>",
						                    action: function(dialogItself){
						                        dialogItself.close();
						                    }
						                }]
						            }); 
								//infoWindow.setContent("11111");
								//infoWindow.redraw()	;
								 choseMakerdata.brightness=100;
								 $("#brightnessValue").html(100);
								 $("#brightnessValueLight").html("<%=brightness_value%>"+"："+100);
							} else {
								BootstrapDialog.show({
					                type:  BootstrapDialog.TYPE_DANGER,
					                title: "<%=remind_infomation%>",
					                message: "<%=road_light_open_faliue%>",
					                buttons: [{
					                    label: "<%=shut_down%>",
					                    action: function(dialogItself){
					                        dialogItself.close();
					                    }
					                }]
					            }); 
							}

						},
						error : function() {
							BootstrapDialog.show({
				                type:  BootstrapDialog.TYPE_DANGER,
				                title: "<%=remind_infomation%>",
				                message:  "<%=road_light_open_faliue%>",
				                buttons: [{
				                    label: "<%=shut_down%>",
				                    action: function(dialogItself){
				                        dialogItself.close();
				                    }
				                }]
				            }); 
						}

					});

		}

	}
	function TurnOffLight() {
		if(choseMakerdata.partmapflag ==true){
			if(document.getElementById('light'+$('#selLight').val())==null){
			//	alert('改路灯没有在局部图上加载。不能进行此操作');
				alert('<%=part_map_light_notexist_inPart%>')
				return;
			}
		}
		if (choseMakerdata.brightness == 0) {
			BootstrapDialog.show({
                type:  BootstrapDialog.TYPE_DANGER,
                title: "<%=remind_infomation%>",
                message: "<%=road_light_has_shut_status%>",
                buttons: [{
                    label: "<%=shut_down%>",
                    action: function(dialogItself){
                        dialogItself.close();
                    }
                }]
            }); 
		} else {
			
			$.ajax({
						url : "gomap/updateClientAttr_status",
						type : "POST",
						contentType : "application/json; charset=UTF-8",
						data : JSON.stringify(choseMakerdata),
						dataType : "json",
						success : function(data) {
							if (data.status == "SUCCESS") {
								//choseMaker.style.backgroundImage = "url('map/img/light_grey.png')";
								cleanAllMaker();//清除所有覆盖物
								var a;
								var mapcenter=map.getCenter();
								var mapzoom=map.getZoom();
								 BootstrapDialog.show({
						                type:  BootstrapDialog.TYPE_PRIMARY,
						                title: "<%=remind_infomation%>",
						                message: "<%=road_light_shut_down_success%>",
						                buttons: [{
						                    label: "<%=shut_down%>",
						                    action: function(dialogItself){
						                        dialogItself.close();
						                    }
						                }]
						            }); 
								 $("#brightnessValueLight").html("<%=brightness_value%>"+"："+0);
							} else {
								BootstrapDialog.show({
					                type:  BootstrapDialog.TYPE_DANGER,
					                title: "<%=remind_infomation%>",
					                message: "<%=road_light_shut_down_faliue%>",
					                buttons: [{
					                    label:"<%=shut_down%>",
					                    action: function(dialogItself){
					                        dialogItself.close();
					                    }
					                }]
					            }); 
							}
							choseMakerdata.brightness=0;
							$("#brightnessValue").html(0);
						},
						error : function() {
							BootstrapDialog.show({
				                type:  BootstrapDialog.TYPE_DANGER,
				                title: "<%=remind_infomation%>",
				                message: "<%=road_light_shut_down_faliue%>",
				                buttons: [{
				                    label: "<%=shut_down%>",
				                    action: function(dialogItself){
				                        dialogItself.close();
				                    }
				                }]
				            });
						}

					});

		}

	}

	function change_bright(bright) {
		
		if(choseMakerdata.partmapflag ==true){
			if(document.getElementById('light'+$('#selLight').val())==null){
				//alert('改路灯没有在局部图上加载。不能进行此操作');
				alert('<%=part_map_light_notexist_inPart%>')
				return;
			}
		}
		choseMakerdata.brightness = bright;
		
		//console.log(bright);
		$.ajax({
			url : "gomap/updateClientAttr_brightness",
			type : "POST",
			contentType : "application/json; charset=UTF-8",
			data : JSON.stringify(choseMakerdata),
			dataType : "json",
			success : function(data) {
				if (data.status == "SUCCESS") {
					//cleanAllMaker();//清除所有覆盖物
					var a;
					var mapcenter=map.getCenter();
					var mapzoom=map.getZoom();
					BootstrapDialog.show({
	                type:  BootstrapDialog.TYPE_PRIMARY,
	                title: "<%=remind_infomation%>",
	                message:"<%=road_light_brightness_update_success%>",
	                buttons: [{
	                    label: "<%=shut_down%>",
	                    action: function(dialogItself){
	                        dialogItself.close();
	                    }
	                }]
	            }); 
					$("#brightnessValue").html(bright);
					$("#brightnessValueLight").html("<%=brightness_value%>"+"："+bright);

				} else {
						BootstrapDialog.show({
		                type:  BootstrapDialog.TYPE_DANGER,
		                title: "<%=remind_infomation%>",
		                message: "<%=road_light_brightness_update_faliue%>",
		                buttons: [{
		                    label: "<%=shut_down%>",
		                    action: function(dialogItself){
		                        dialogItself.close();
		                    }
		                }]
		            });
				}

			},
			error : function() {
				BootstrapDialog.show({
	                type:  BootstrapDialog.TYPE_DANGER,
	                title: "<%=remind_infomation%>",
	                message: "<%=road_light_brightness_update_faliue%>",
	                buttons: [{
	                    label:"<%=shut_down%>",
	                    action: function(dialogItself){
	                        dialogItself.close();
	                    }
	                }]
	            });
			}

		});
	}
	
	
	
	
///////////////////////////////////////////////////////////////////////////////////////////////////////////////	
		
	function TurnOnOROffLight(takeid,choseMakerdata,chosetermid,bright) {
		var drawdataid=[];
		
	    for(var i=0;i<choseMakerdata.length;i++){
	    	drawdataid.push(choseMakerdata[i].id);
	    }
		var updatedata={
				"takeid":takeid,
				"drawid":drawdataid,
				"bright":bright
		};
		if (choseMakerdata[0].termid==-999) {
			BootstrapDialog.show({
                type:  BootstrapDialog.TYPE_DANGER,
                title: "<%=remind_infomation%>",
                message: "<%=Gatewayrouter_not_this_operations%>",
                buttons: [{
                    label:"<%=shut_down%>",
                    action: function(dialogItself){
                        dialogItself.close();
                    }
                }]
            }); 
		} else {
			
			$.ajax({
						url : "gomap/updateClientDraw_status",
						type : "POST",
						contentType : "application/json; charset=UTF-8",
						data : JSON.stringify(updatedata),
						dataType : "json",
						success : function(data) {
							if (data.status == "SUCCESS") {
								cleanAllMaker();//清除所有覆盖物
								var a;
								var mapcenter=map.getCenter();
								var mapzoom=map.getZoom();
								if(chosetermid=="search")
								{a=parent.getmapTermpage()[-1];getClientsData(a,mapcenter,mapzoom);}
							else if(chosetermid=="draw")
								{a=parent.getmapTermpage()[-2];getClientsData(a,mapcenter,mapzoom);}
							else
								{a = parent.getmapTermpagein()[choseMakerdata[0].termid];getClientsData(a,mapcenter,mapzoom);}
								changeCenter(gMarker);
								 BootstrapDialog.show({
						                type:  BootstrapDialog.TYPE_PRIMARY,
						                title: "<%=remind_infomation%>",
						                message:"<%=light_operating_successfully%>",
						                buttons: [{
						                    label: "<%=shut_down%>",
						                    action: function(dialogItself){
						                        dialogItself.close();
						                    }
						                }]
						            }); 

							} else {
								BootstrapDialog.show({
					                type:  BootstrapDialog.TYPE_DANGER,
					                title: "<%=remind_infomation%>",
					                message: "<%=light_operating_err%>",
					                buttons: [{
					                    label: "<%=shut_down%>",
					                    action: function(dialogItself){
					                        dialogItself.close();
					                    }
					                }]
					            }); 
							}

						},
						error : function() {
							BootstrapDialog.show({
				                type:  BootstrapDialog.TYPE_DANGER,
				                title: "<%=remind_infomation%>",
				                message: "<%=light_operating_err%>",
				                buttons: [{
				                    label: "<%=shut_down%>",
				                    action: function(dialogItself){
				                        dialogItself.close();
				                    }
				                }]
				            });
						}

					});

		}

	}
</script>
<script type="text/javascript">
	jQuery.getJSON("gomap/getFirstTerm/", function(data) {
		if (data != -1000) {
			//alert(data);
			var mapTermpage2 = {
				page : 1,
				rows : 20,
				begin : 0,
				end : 0,
				havenest : false,
				termid : data
			};
			gtermid = mapTermpage2.termid;
			getClientsData(mapTermpage2,null,null);
			parent.setChosetermid2(data);
		} else {
			BootstrapDialog.show({
                type:  BootstrapDialog.TYPE_INFO,
                title: "<%=remind_infomation%>",
                message: "<%=no_data_any_term%>",
                buttons: [{
                    label: "<%=shut_down%>",
                    action: function(dialogItself){
                        dialogItself.close();
                    }
                }]
            });
		}
	});
</script>
<script type="text/javascript"> 
function searchsuccess() {
	BootstrapDialog
	.show({
		type : BootstrapDialog.TYPE_PRIMARY,
		title : "<%=remind_infomation%>",
		message :"<%=search_seccess_please_look_light_list2_on_left%>",
		buttons : [ {
			label : "<%=shut_down%>",
			action : function(dialogItself) {
				dialogItself.close();
			}
		} ]
	});
}
function searcherr() {
	BootstrapDialog
	.show({
		type : BootstrapDialog.TYPE_DANGER,
		title : "<%=remind_infomation%>",
		message : "<%=search_device_not_exist_or_wrong%>",
		buttons : [ {
			label : "<%=shut_down%>",
			action : function(dialogItself) {
				dialogItself.close();
			}
		} ]
	});
}
function searchConerr() {
	BootstrapDialog.show({
        type:  BootstrapDialog.TYPE_DANGER,
        title: "<%=remind_infomation%>",
        message:"<%=download_wrong_please_refresh%>",
        buttons: [{
            label: "<%=shut_down%>",
            action: function(dialogItself){
                dialogItself.close();
            }
        }]
    }); 
}
 function PolicyControl() {
	 BootstrapDialog.show({
         title: "<%=strate_control%>",
         /* cssClass :'dialog', */
       /*   draggable: true, */
        // message:$('<div></div>').load('remote.html'),
        message:"<%=jump_to_strategy_control_page%>",
         buttons: [{
             label: "<%=make_sure%>",
             action: function(dialogItself) {
            	 dialogItself.close();
            	///////////////////////////////////////////////////////////////////////////////////////////////////
            	///////////////////////////////////////////////////////////////////////////////////////////////////
             	top.mainFrame.tabAddHandler('z387','<%=strategy_set%>','strategy/listStrategySet.do');	 
            	///////////////////////////////////////////////////////////////////////////////////////////////////
            	///////////////////////////////////////////////////////////////////////////////////////////////////
            	///////////////////////////////////////////////////////////////////////////////////////////////////
            	// window.parent.location.href="strategy/listStrategys.do";
             }
         },{
             label: "<%=cancel%>",
             action: function(dialogItself) {
            	 dialogItself.close();
             }
         }]
     });
} 
 
 function LightBrightnessDialog() {
	 var s="<div class='spandiv'><span>"+"<%=brightness_adjustment%>"+"：</span></div><select class='LightBrightnessDialog' style='float: right;height: 30px;' onchange='onchangeDraw_bright(this.options[this.options.selectedIndex].value)'>"
			+"<option value="+0+">"+0+"</option>"
		 	+"<option value="+10+">"+10+"</option>"
	 		+"<option value="+20+">"+20+"</option>"
	 		+"<option value="+30+">"+30+"</option>"
	 		+"<option value="+40+">"+40+"</option>"
	 		+"<option value="+50+">"+50+"</option>"
	 		+"<option value="+60+">"+60+"</option>"
	 		+"<option value="+70+">"+70+"</option>"
	 		+"<option value="+80+">"+80+"</option>"
	 		+"<option value="+90+">"+90+"</option>"
	 		+"<option value="+100+">"+100+"</option>"
	 		+"</select>"
			
	 BootstrapDialog.show({
         title: "<%=brightness_adjustment%>",
         message:$('<div>'+s+'</div>'),
         buttons: [{
             label: "<%=make_sure%>",
             action: function(dialogItself) {
            	 setDraw_brightDialog();
            	 dialogItself.close();
             }
         },{
             label: "<%=cancel%>",
             action: function(dialogItself) {
            	 dialogItself.close();
            	 CircleAndRectangle.removeContextMenu(menu);
           	  map.removeOverlay(CircleAndRectangle);
           	  CircleAndRectangle = null;
             }
         }]
     });
} 

 function setDraw_brightDialog() {
	 var bright=$(".LightBrightnessDialog").val();
	  //setDraw_bright(bright);
	  var tid=parent.getChosetermid();
	  TurnOnOROffLight(3,drawdata,tid,bright);
	  CircleAndRectangle.removeContextMenu(menu);
	  map.removeOverlay(CircleAndRectangle);
	  CircleAndRectangle = null;
	}
</script>
<script type="text/javascript">


function getInfoContent(data) {
	 //路灯

	 var sContent_light =   
   "<html>"+
   "<head>"+
   "<meta charset='UTF-8'>"+
   "<title>"+"Insert title here"+"</title>"+
   "<link rel='styleSheet' type='text/css' href='static/map/css/base.css' />"+
   "<link rel='styleSheet' type='text/css' href='static/map/css/content_light.css' />"+
   "</head>"+
   "<body>"+
  	"<div id= 'main' style='width:330px;overflow:hidden;'>"+
   		"<div class = 'head'>"+
   			"<p>"+data.name+"</p>"+
   		"</div>"+
   		"<div class = 'mid'>"+
   			"<div class='introduction'>"+
   				"<ul >"+
   					"<li>"+
   						"<a>"+"<%=serial_number%>"+"："+data.id+"</a>"+
   					"</li>"+
   					"<li>"+
   						"<a>"+"<%=name%>"+"："+ data.name+"</a>"+
   					"</li>"+
   					"<li>"+
   						"<a>"+"<%=pole_number2%>"+"："+ data.lamppolenum+"</a>"+
   					"</li>"+
   					"<li >"+
   						"<a>"+"<%=location%>"+"："+ data.location+"</a>"+
   					"</li>"+
   					"<li >"+
							"<a>"+"<%=group_name%>"+"："+ data.termname+"</a>"+
						"</li>"+
						"<li >"+
							"<a id='brightnessValueLight' >"+"<%=brightness_value%>"+"："+ data.brightness+"</a>"+
					"</li>"+
   				"</ul>"+
   			"</div>"+
//    			"<div class='image'>"+
//    				"<img src='static/map/img/light1.png' />"+
//    			"</div>"+
   		"</div>"+
   		"<div class='bottom' style='width:320px;'>"+
       		"<div class='b1' onclick ='TurnOnLight()' style='width:50px;'>"+
					"<div class='bimg1'>"+
						"<img src='static/map/img/bulb_on.png'>"+
					"</div>"+
					"<div class='btx1'>"+
						"<a href='javascript:void(0)' >"+"<%=open_light%>"+"</a>"+
					"</div>"+
				"</div>"+
				"<div class='b2' onclick ='TurnOffLight()' style='width:50px;'>"+
					"<div class='bimg2'>"+
							"<img src='static/map/img/bulb_off.png'>"+
					"</div>"+
					"<div class='btx2'>"+
						"<a href='javascript:void(0)' >"+"<%=shut_down_light%>"+"</a>"+
					"</div>"+
				"</div>"+
				"<div class='b3' onclick ='PolicyControl()' style='width:80px;'>"+
					"<div class='bimg3'>"+
							"<img src='static/map/img/policy_control.png'>"+
					"</div>"+
					"<div class='btx3' style='margin-top:5px;'>"+
						"<a href='javascript:void(0)' >"+"<%=control_strategy%>"+"</a>"+
					"</div>"+
				"</div>"+
				"<div class='btx4' style='width:110px;'>"+
					"<h2 class='sh'>"+"<%=brightness_value%>"+":</h2>"+
					"<select class='s1'  onchange='change_bright(this.options[this.options.selectedIndex].value)'>"
					
			        var lightop="";
   				for(var i = 0; i <=100; i=i+10){
   					var lightop2="";
   					if(i!=data.brightness)
   						{
   							lightop2="<option value="+i+">"+i+"</option>";
   						}else{
   							lightop2="<option value="+i+" selected = 'selected'>"+i+"</option>";
   						}
   					lightop=lightop+lightop2;
   				}
					 sContent_light=sContent_light+lightop+
			    	"</select>"+
			    "</div>"+
			"</div>"+
   	"</div>"+
   "</body>"+
   "</html>";
   
   
  //断路器
   var sContent_Breaker =   
       "<html>"+
       "<head>"+
       "<meta charset='UTF-8'>"+
       "<title>"+"Insert title here"+"</title>"+
       "<link rel='styleSheet' type='text/css' href='static/map/css/base.css' />"+
       "<link rel='styleSheet' type='text/css' href='static/map/css/content_breaker.css' />"+
       "</head>"+
       "<body>"+
       	"<div id= 'main'>"+
       		"<div class = 'head'>"+
       			"<p>"+data.name+"</p>"+
       		"</div>"+
       		"<div class = 'mid'>"+
       			"<div class='introduction'>"+
       				"<ul >"+
       					"<li>"+
       						"<a>"+"<%=serial_number%>"+"："+data .id+"</a>"+
       					"</li>"+
       					"<li>"+
       						"<a>"+"<%=name%>"+"："+  data .name+"</a>"+
       					"</li>"+
       					"<li>"+
       						"<a>"+"<%=pole_number2%>"+"："+ data .lamppolenum+"</a>"+
       					"</li>"+
       					"<li >"+
       						"<a>"+"<%=location%>"+"："+data .location+"</a>"+
       					"</li>"+
       					"<li >"+
   							"<a>"+"<%=blockout_time%>"+"："+data .powerdown+"</a>"+
   						"</li>"+
   						"<li >"+
								"<a>"+"<%=electricity_time%>"+"："+data .powerup+"</a>"+
						"</li>"+
       				"</ul>"+
       			"</div>"+
       			"<div class='image'>"+
       				"<img src='static/map/img/breaker.png' />"+
       			"</div>"+
       		"</div>"+
       	"</div>"+
       "</body>"+
       "</html>";
       var op="";
   if(data.cclientgateway!=null){
 
   	for(var i = 0; i < data.cclientgateway.length; i++){
   		op=op+"<option value='1'>"+data.cclientgateway[i]+"</option>";
   	}
   	  //console.log(op);
   }
       //网关
       var sContent_Gateway =   
	        "<html>"+
	        "<head>"+
	        "<meta charset='UTF-8'>"+
	        "<title>"+"Insert title here"+"</title>"+
	        "<link rel='styleSheet' type='text/css' href='static/map/css/base.css' />"+
	        "<link rel='styleSheet' type='text/css' href='static/map/css/content_gateway.css' />"+
	        "</head>"+
	        "<body>"+
	        	"<div id= 'main'>"+
	        		"<div class = 'head'>"+
	        			"<p>"+ data .name+"</p>"+
	        		"</div>"+
	        		"<div class = 'mid'>"+
	        			"<div class='introduction'>"+
	        				"<ul >"+
	        					"<li>"+
	        						"<a>"+"<%=serial_number%>"+"："+data .id+"</a>"+
	        					"</li>"+
	        					"<li>"+
	        						"<a>"+"<%=name%>"+"："+  data .name+"</a>"+
	        					"</li>"+
	        					"<li>"+
	        						"<a>"+"<%=pole_number2%>"+"："+ data .lamppolenum+"</a>"+
	        					"</li>"+
	        					"<li >"+
	        						"<a>"+"<%=location%>"+"："+data .location+"</a>"+
	        					"</li>"+
	        					"<li >"+//+JSON.stringify(data.cclientgateway)+
	        						"<a>"+"<%=menber_list%>"+"："+"</a>"+
	        					"</li>"+
		        					"<select class='s2'>"+
										op+
						    	    "</select>"+		
       						"</li>"+
	        				"</ul>"+
	        			"</div>"+
	        			"<div class='image'>"+
	        				"<img src='static/map/img/gateway.png' />"+
	        			"</div>"+
	        		"</div>"+
	        	"</div>"+
	        "</body>"+
	        "</html>";
       if(data.aliastypename.indexOf("灯" ) >=0){
       	return sContent_light;
       }else if(data.aliastypename.indexOf("断路器" ) >=0){
       	return sContent_Breaker;
       }else if(data.aliastypename.indexOf("网关") >= 0){
       	return sContent_Gateway;
       }else {
       	return "无";
       }
       	
}</script>
</html>

