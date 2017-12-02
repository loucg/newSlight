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
<script type="text/javascript"
	src="http://api.map.baidu.com/api?v=2.0&ak=H0j9w4M81wm8pl1klUsAPQklDddKFqc9">
</script>
<!-- <script type="text/javascript"
	src="http://api.map.baidu.com/library/DrawingManager/1.4/src/DrawingManager_min.js"></script>
<link rel="stylesheet"
	href="http://api.map.baidu.com/library/DrawingManager/1.4/src/DrawingManager_min.css" /> -->
	<script type="text/javascript" src="static/map/js/DrawingManager_min.js"></script>
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
	<input type=button id='mapclick' onclick="map.setDefaultCursor('crosshair')"></input>
	<input type=button id='addMarker' onclick="addClickMarker()"></input>
	<input type=button id='clearMarker' onclick="clearOverlaysByPartMapID('')"></input>
	<input type=button id='openMarker' onclick="openPartMap()"></input>
	<input type=button id='reloadMap' onclick="reloadMap()"></input>
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
    var baiduMapFlag=2;
    var markers=[];
    var gPartinfoWindow;
    var gLightInfoWindow;


	////////////////////////////////////////////////////////////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////////////////////////////////////
	var map = new BMap.Map("container", {
		//minZoom : 15,
		enableMapClick : false
	});// 创建地图实例   构造底图时，关闭底图可点功能
	map.centerAndZoom("杭州", 15);// 初始化地图，设置中心点坐标和地图级别
	var top_left_navigation = new BMap.NavigationControl(); //左上角，添加默认缩放平移控件
	map.addControl(top_left_navigation);
	map.enableScrollWheelZoom(true);//启用滚轮放大缩小
	//map.setDefaultCursor("url('bird.cur')"); //设置地图默认的鼠标指针样式
	map.setDefaultCursor("default"); //设置地图默认的鼠标指针样式
	map.disableDoubleClickZoom(true);

	var menu = new BMap.ContextMenu();
	var CircleAndRectangle = null;
	var txtMenuItem = [  {
		text : "<%=open_light%>",
		callback : function() {
			var tid=parent.getChosetermid();
			TurnOnOROffLight(1,drawdata,tid);
			CircleAndRectangle.removeContextMenu(menu);
			map.removeOverlay(CircleAndRectangle);
			CircleAndRectangle = null;
		}
	}, {
		text : "<%=shut_down_light%>",
		callback : function() {
			var tid=parent.getChosetermid();
			TurnOnOROffLight(2,drawdata,tid);
			CircleAndRectangle.removeContextMenu(menu);
			map.removeOverlay(CircleAndRectangle);
			CircleAndRectangle = null;
		}
	} , {
		text : "<%=brightness_adjustment%>",
		callback : function() {
			LightBrightnessDialog();
			/* CircleAndRectangle.removeContextMenu(menu);
			map.removeOverlay(CircleAndRectangle);
			CircleAndRectangle = null; */
		}
	} ,  {
		text :"<%=clear_draw%>",
		callback : function() {
			CircleAndRectangle.removeContextMenu(menu);
			parent.cleardrawdata();//删除原有的左边框选列表
			map.removeOverlay(CircleAndRectangle);
			CircleAndRectangle = null;
		}
	}  ];
	for (var i = 0; i < txtMenuItem.length; i++) {
		menu.addItem(new BMap.MenuItem(txtMenuItem[i].text,
				txtMenuItem[i].callback, 100));
	}

	var drawingManager = new BMapLib.DrawingManager(map, {
		isOpen : false, //是否开启绘制模式
		enableDrawingTool : true, //是否显示工具栏
		drawingToolOptions : {
			anchor : BMAP_ANCHOR_TOP_RIGHT, //位置
			offset : new BMap.Size(5, 5), //偏离值
			scale : 0.8, //工具栏缩放比例
			drawingModes : [ BMAP_DRAWING_CIRCLE, BMAP_DRAWING_RECTANGLE],
			drawingTypes : [
                BMAP_DRAWING_MARKER,  
                BMAP_DRAWING_CIRCLE,//圆的样式
             	BMAP_DRAWING_POLYLINE,
				BMAP_DRAWING_POLYGON,
              	BMAP_DRAWING_RECTANGLE //矩形的样式
				]
		}

	});
	drawingManager.addEventListener('circlecomplete', function(e, overlay) {
		//	circlecomplete
		if (CircleAndRectangle != null) {
			CircleAndRectangle.removeContextMenu(menu);
		}
		map.removeOverlay(CircleAndRectangle);
		CircleAndRectangle = overlay;
		overlay.addContextMenu(menu);
		map.addContextMenu(menu);
		map.addOverlay(overlay);
		var radius = parseInt(e.getRadius());
		var center = e.getCenter();
		var bound = e.getBounds();
		judgeSelection(bound);
		drawingManager.close();
	});
	drawingManager.addEventListener('rectanglecomplete', function(e, overlay) {
		//	circlecomplete
		if (CircleAndRectangle != null) {
			CircleAndRectangle.removeContextMenu(menu);
		}
		map.removeOverlay(CircleAndRectangle);
		CircleAndRectangle = overlay;
		overlay.addContextMenu(menu);
		map.addOverlay(overlay);
		//var radius = parseInt(e.getRadius());
		var bound = e.getBounds();
		judgeSelection(bound);
		drawingManager.close();
	});
	//
	function reloadMap(){
    	var reloadPage2={};
    	reloadPage2.termid = gtermid;
    	reloadPage2.gatewayid=gGatewayID;
		getClientsData(reloadPage2,null,null);

    }
	//map.addEventListener("click", showInfo);
	function getClientsData(mapTermpage2,mapcenter,mapzoom) {
		//地图初始化时候，局部地图也同时初始化
		if(mapcenter==null){
			map.clearOverlays();
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
					srcMakerdata= clientdata;
					for(var i=0;i<desMakerdata.length;i++){
						if(desMakerdata[i].coordinate!=null){
							desMakerdata[i].xcoordinate = desMakerdata[i].coordinate.split(",")[0];
							desMakerdata[i].ycoordinate = desMakerdata[i].coordinate.split(",")[1];
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
							document.getElementById('partMapName').value =aPartmap[i].partmap_name;
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
	
	//灯到数据装载
	function gpsTObbd(arrpoints,clientdata,mapcenter,mapzoom) {
        var marker=null ;
        for (var j=0; j <  clientdata.length; j++) { 
			if(clientdata[j].coordinate!=null){
           		clientdata[j].xcoordinate = clientdata[j].coordinate.split(",")[0];
           		clientdata[j].ycoordinate = clientdata[j].coordinate.split(",")[1];
			}
         		marker = attachlightToMap(clientdata[j])
		}
        if(marker!=null){
        	changeCenter(marker);
        }
	}
	//终端的坐标更新
	//newCoordinate:新坐标
	//client_attri_id：终端的ID
	function updateClientCoordinate(newCoordinate,client_attri_id,clientType) {
		$.ajax({
			url : "gomap/upateClientMakerCoordinate.do",
			type : "POST",
			data: {coordinate:newCoordinate,client_attri_id:client_attri_id,clientType:clientType,mapFlag:baiduMapFlag},
			dataType : "json",
			cache: false,
			success : function(data) {
				for(var i=0;i<desMakerdata.length;i++){
					if(desMakerdata[i].client_attri_id==client_attri_id){
						desMakerdata[i].xcoordinate=newCoordinate.split(",")[0];
						desMakerdata[i].ycoordinate=newCoordinate.split(",")[1];
						srcMakerdata[i].coordinate_baidu_source =newCoordinate.split(",")[0]
						 + ','+newCoordinate.split(",")[1];
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
					var strX;
					var strY;
					//只有路灯初次装载的时候才执行，局部地图才开启
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
					var opts = {
							width : 1050, // 信息窗口宽度
							height : 500, // 信息窗口高度
						};
					var point = new BMap.Point(strX,strY);
					
					if(gPartinfoWindow!=null){
						gPartinfoWindow.close();
						gPartinfoWindow =null;
					}
					gPartinfoWindow = new BMap.InfoWindow(marker.content, opts); // 创建信息窗口对象
					gPartinfoWindow.enableCloseOnClick();
					map.openInfoWindow(gPartinfoWindow, point); //开启信息窗口  
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
				//	changeCenter(marker);
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
          //灯的各种终端类型显示。（路灯，网关等）
      		var imageURL = "static/map/img/" + clienttype + statuscolor+ ".png"; 
			var myIcon = new BMap.Icon(imageURL, new BMap.Size(23, 25));
			var point = new BMap.Point(clientdata.xcoordinate, clientdata.ycoordinate);
			//灯的场合，如果局部地图上有就不加
			if ( clientdata.aliastypename.indexOf("灯" ) >=0) {
				if(clientdata.partMaplinetCnt==0){
					var marker = new BMap.Marker(point,{icon:myIcon}); //创建marker对象
      				marker.enableDragging(); //marker可拖拽
      				marker.clientdata =clientdata;
					map.addOverlay(marker);
				}
			}else{
				var marker = new BMap.Marker(point,{icon:myIcon}); //创建marker对象
    				marker.enableDragging(); //marker可拖拽
    				marker.clientdata =clientdata[j];
				map.addOverlay(marker);
			}
			if(marker!=null){
				marker.clientdata = clientdata;
				marker.aliastypename =clientdata.aliastypename;
				marker.client_attri_id = clientdata.client_attri_id;
				marker.id= clientdata.id;
				marker.xcoordinate =clientdata.xcoordinate;
				marker.ycoordinate =clientdata.ycoordinate;
				marker.name =clientdata.name;
				markers[i++]= marker;
				attachInformation(map,marker);//路灯基础数据窗口
				dragMarker(map,marker);//路灯拖动设置
				mouseOverMarker(map,marker,"<%=light_name%>" + marker.name);//鼠标移动到路灯提示
				mouseOutMarker(map,marker);//鼠标移动到路灯后提示关闭
			}
			return marker;
		}
		
		//追加窗口信息事件
		function attachInformation(map,marker) {
			marker.addEventListener('click', function(e) {//这里是自定义覆盖物的事件
				var opts = {
						width : 620, // 信息窗口宽度
						height : 254, // 信息窗口高度
					};
					var point = new BMap.Point(marker.clientdata.xcoordinate, marker.clientdata.ycoordinate);
					var clientData={} ;
					var tempCondition ={};
					tempCondition.termid=gtermid;
					tempCondition.gatewayid=gGatewayID;
					tempCondition.id = marker.id;
					this.partMapID =null;
					$.ajax({
						url : "gomap/addClientMaker",
						type : "POST",
						contentType : "application/json; charset=UTF-8",
						data : JSON.stringify(tempCondition),
						dataType : "json",
						success : function(clientdata) {
							if(clientdata.length>0){
								marker.clientdata=clientdata[0];
								marker.content =  getInfoContent(clientdata[0]);
								choseMakerdata= marker.clientdata;
			    				choseMakerdata.partmapflag =false;
								var infoWindow = new BMap.InfoWindow(marker.content, opts); // 创建信息窗口对象
								infoWindow.enableCloseOnClick();
								map.openInfoWindow(infoWindow, point); //开启信息窗口  
							}else{
								alert('There are no  light data');
							}
		    				
						}});
					
		        });
			;
			}
		
		//拖动事件发生
		function dragMarker(map,marker){
			marker.addEventListener("dragend", function(MouseEvent) {//这里是定义拖动事件
				var p = marker.getPosition(); 
				//默认是灯
				var cType ='1';
				if (marker.clientdata.aliastypename.indexOf("断路器" ) >=0) {
    				cType ='3';
    			} else if (marker.clientdata.aliastypename.indexOf("网关") >= 0) {
    				cType ='2';
    			}
				updateClientCoordinate(p.lng+','+p.lat,marker.clientdata.client_attri_id,cType);
				marker.xcoordinate=p.lng;
				marker.ycoordinate=p.lat;
				
			});
		}
		
		//mouseover点击事件发生
		function mouseOverMarker(map,marker,lightinfo){
			marker.addEventListener("mouseover", function(MouseEvent) {//这里是点击事件
			gPartinfoWindow=null;
			var opts = {
					width : 10, // 信息窗口宽度
					height : 10, // 信息窗口高度
				};
			gLightInfoWindow = new BMap.InfoWindow(lightinfo,opts); 
			var point = new BMap.Point(marker.xcoordinate, 
					marker.ycoordinate);
			 map.openInfoWindow(gLightInfoWindow,point);
			});
		}
		
		//mouseout点击事件发生
		function mouseOutMarker(map,marker){
			marker.addEventListener("mouseout", function(MouseEvent) {//这里是点击事件
				gPartinfoWindow=null;
				if(gLightInfoWindow!=null){
					gLightInfoWindow.close();
				}
			});
		}
		
	//添加覆盖物 
	//var infoWindow;//全局变量，相当重要/////////////////////////////////////////////////////
	function addClientMaker(data,mapcenter,mapzoom) {
	
	}
///////////////////////////////////////////////////////////////////////////////////////////
//局部图的上传的窗口打开
	map.addEventListener("click",function(e){
		if($('#addPartMapFlag').val()=='1'){
			$("#addPartMapFlag").attr("value",'');//
			map.setDefaultCursor("default");
			top.jzts();
			var diag = new top.Dialog();
			diag.Drag=true;
			diag.Title ='<%=part_map_add%>';   
			diag.URL = '<%=basePath%>/gomap/addpartmap.do?XPoint='+e.point.lng+'&YPoint='+e.point.lat+'&termID='+gtermid+'&gatewayid='+gGatewayID
			diag.Width = 450;
			diag.Height = 300;
			diag.Modal = true;				//有无遮罩窗口
			diag.ShowMaxButton = true;	//最大化按钮
			diag.ShowMinButton = true;		//最小化按钮
			diag.CancelEvent = function(){ //关闭事件
			if(diag.innerFrame.contentWindow.document.getElementById('partMapID').value!=''){
//				gMarker.partMapID = diag.innerFrame.contentWindow.document.getElementById('partMapID').value;
//				document.getElementById('partMapID').value =diag.innerFrame.contentWindow.document.getElementById('partMapID').value;
			}
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
		}else{
			
			//getLightData(gtermid,'',null);
		}
	
	});

	function clearOverlaysByClientID(clinetid){
		//所有的Marks删除
		for(var i=0;i<markers.length;i++){
			var marker =markers[i];
			if(marker!=null){
				if(marker.id==clinetid){
					map.removeOverlay(marker);
					//删除后在地图上坐标重置
					if(desMakerdata[i]!=null){
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
	

	function clearAllOverlays(){
		//局部图ID也初始化
		document.getElementById('partMapID').value ='';
		document.getElementById('PartMapExist').value ='';
		gPartmaps =[];
		//所有的Marks删除
		for(var i=0;i<markers.length;i++){
			var marker =markers[i];
			if(marker!=null){
				map.removeOverlay(marker);
			}
		}
	}
	
	//清除指定的局部地图覆盖层
	function clearOverlaysByPartMapID(){
		for(var i=0;i<markers.length;i++){
			var marker =markers[i];
			if(marker!=null){
				if(marker.partMapID==document.getElementById('partMapID').value){
					map.removeOverlay(marker);
					return;
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
		
		for(var i=0;i<map.getOverlays().length;i++){
			var marker =map.getOverlays()[i];
			if(marker.partMapID==document.getElementById('partMapID').value){
				openPartMapSub(marker,true);
				partmapExistFlag=true;
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
			strX = document.getElementById('MarkerXYCoordinate').value.split(",")[0];
			strY = document.getElementById('MarkerXYCoordinate').value.split(",")[1];
			var myIcon = new BMap.Icon('static/map/img/partMapMarkers.jpg', new BMap.Size(23, 25));
			var point = new BMap.Point(strX, strY);
			var marker = new BMap.Marker(point,{icon:myIcon}); //创建marker对象
			marker.coordinate = document.getElementById('MarkerXYCoordinate').value;
			marker.xcoordinate = strX;
			marker.ycoordinate = strY;
			marker.partMapID =  document.getElementById('partMapID').value;
			marker.name = document.getElementById('partMapName').value;
			mouseOverMarker(map,marker,"<%=part_name%>" + marker.name);
			mouseOutMarker(map,marker)
			gMarker = marker;
			markers[markers.length] = marker;
			if(marker!=null){
				marker.addEventListener('click', function(e) {//这里是自定义覆盖物的事件
					if($('#addPartMapFlag').val()!='1'){
					//	if(this.partMapID!=null){
							getLightData(gtermid,'',marker);
					//	}
						
					}
				});
				map.addOverlay(marker);
				
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
	if(confirm('<%=partMap_light_delconfirm%>')){
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
					for(var i=0;i<srcMakerdata.length;i++){
						
						if(srcMakerdata[i]!=null &&
								srcMakerdata[i].id==$('#selLight').val()){
							if(srcMakerdata[i].coordinate_baidu_source!=null){
								srcMakerdata[i].xcoordinate = srcMakerdata[i].coordinate_baidu_source.split(",")[0];
								srcMakerdata[i].ycoordinate = srcMakerdata[i].coordinate_baidu_source.split(",")[1];
								
							}
							srcMakerdata[i].partMaplinetCnt=0;
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
		var strClientIds='';
		var strCordinates='';
		
		for(var i=0;i<count;i++){
			var tempdiv = document.getElementById('light'+$("#selLight ").get(0).options[i].value);
			if(tempdiv!=null){
				lightnum++;
				
				if(strClientIds=='') strClientIds += tempdiv.id.replace("light","");
				else strClientIds += ';' + tempdiv.id.replace("light","");
				
				if(strCordinates=='') strCordinates += tempdiv.name.replace("px","");
				else strCordinates += ';' + tempdiv.name.replace("px","");			
				//删除已经追加的路灯
				clearOverlaysByClientID($("#selLight ").get(0).options[i].value);
			}
			
		}
// 		alert(lightnum);
		if(lightnum>0){
			$.ajax({
				url : "gomap/savePartMapToDetail",
				type : "POST",
				data : {
						ID :$("#partMapID").val(),
						INNER_COORDINATE:strCordinates,
						CLIENT_ID:strClientIds,
						TERMID:gtermid,
						GateWayID:gGatewayID
				},
				dataType : "json",
				success : function(data) {
					succssflag=true;	
					if("failed" == data.result){
						// 已经加入局部图的灯名称显示
						alert(data.clientname+' <%=partmap_already_added %>');
					}else{
						//alert("路灯已保存完毕！");
						alert('<%=part_map_light_save_finished%>');
					}
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
		}else{
			//alert("没有要保存的路灯！");
			alert('<%=part_map_noLight_need_save%>');
		}
	
	}
	
	function change_light(clientid){
		getLightData(gtermid,clientid,null);
		
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
	//改变desMakerdata，用于searchdata
	function changedesMakerdata(data) {
		desMakerdata=data;
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
		var part_name =document.getElementById('partMapName').value;
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
		   "<td width=400px rowspan=10>"+
		   "<div id='partMapImg' class='image'>"+
 		   		"<img onclick=addLightToMap() src=uploadFiles/uploadImgs/partmap/"+filename+ "/>"+
			"</div>"+
			"</td>"+
			"<td class='center' width='170px' height='30px'><%=part_name%>"+
			"</td>"+
			"<td class='center' style='word-break:break-all' width=400px colspan=3 >"+part_name+"</td>"+
			"</td>"+
			 "</tr>"+
			"<tr height=5px>"+	
			"<td class='center' width='170px' height='30px'><%=light_select%>"+
			"</td>"+
			"<td class='center'  width=400px colspan=3 ><select id='selLight' style='width:200px;' onchange='change_light(this.options[this.options.selectedIndex].value)' style='width:150px;'>"+
			 marker.selLight +
			"</select>"+
			"</tr>"+
			"<tr height=5px>"+
			"<td class='center'>"+"<%=serial_number%>"+
			"</td>"+
			"<td class='center' id='serial_number' colspan=3>"+id +
			"</td>"+
			
		   "</tr>"+
		   "<tr height=5px>"+
		   "<td class='center' style='word-break:break-all' >"+"<%=name%>"+
			"</td>"+
			"<td class='center'id='lightName' colspan=3>"+name +
			"</td>"+
		   "</tr>"+
		   "<tr height=5px>"+
		   "<td class='center' >"+"<%=pole_number2%>"+
			"</td>"+
			"<td class='center' id='poleNumber' colspan=3>"+lamppolenum +
			"</td>"+
		   "</tr>"+
		   "<tr height=5px>"+
		   "<td class='center' style='word-break:break-all'>"+"<%=location%>"+
			"</td>"+
			"<td class='center' id='location' colspan=3>"+location +
			"</td>"+
		   "</tr>"+
		   "<tr height=5px>"+
		   "<td class='center' >"+"<%=group_name%>"+
			"</td>"+
			"<td class='center' id='groupName' style='word-break:break-all' colspan=3>"+termname +
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
     		"<div class='b1' onclick ='TurnOnLight(1)'>"+
					"<div class='bimg1'>"+
						"<img src='static/map/img/bulb_on.png'>"+
						"<a href='javascript:void(0)'>"+"<%=open_light%>"+"</a>"+
					"</div>"+
			"</div>"+
			 "</td><td width=80px> "+	
		"<div class='b2' onclick ='TurnOffLight(1)'>"+
			"<div class='bimg2'>"+
					"<img src='static/map/img/bulb_off.png'>"+
					"<a href='javascript:void(0)'>"+"<%=shut_down_light%>"+"</a>"+
			"</div>"+
		
		"</div>"+
		 "</td><td width=100px> "+	
		"<div class='b3' onclick ='PolicyControl()'>"+
			"<div class='bimg3'>"+
					"<img src='static/map/img/policy_control.png'>"+
					"<a href='javascript:void(0)' >"+"<%=control_strategy%>"+"</a>"+
			"</div>"+
		"</div>"+
		 "</td><td width=130px> "+	
			"<div class='btx4'>"+
				"<%=brightness_value%>"+":"+
				"<select style='width:60px;' onchange='change_bright(this.options[this.options.selectedIndex].value,1)'>"
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
		   "<a class='btn btn-xs btn-success' onclick='addLightToPartMap();' ><%=part_map_confirm_light %></a>&nbsp;&nbsp;"+
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
		if(desMakerdata==null)return ;
		for(var i=0;i<desMakerdata.length;i++){
			if(id==desMakerdata[i].id)
				{
				data=desMakerdata[i];
				var x=desMakerdata[i].xcoordinate;
				var y=desMakerdata[i].ycoordinate;

				setTimeout(function() {
					map.panTo(new BMap.Point(x,y)); 
					//map.setZoom(19);
				}, 300);
				setTimeout(function() {
					map.setZoom(10);
				}, 1000);
				
 				}
		}

		CenterMarker(data);
	}
	function CenterMarker(data) {
		if(data!=null && data.xcoordinate!=null&& data.ycoordinate!=null){
			var point = new BMap.Point(data.xcoordinate, data.ycoordinate);
			var marker = new BMap.Marker(point);  // 创建标注
			map.addOverlay(marker);               // 将标注添加到地图中
			marker.setAnimation(BMAP_ANIMATION_BOUNCE); //跳动的动画
			setTimeout(function() {map.removeOverlay(marker);
			}, 2000);
		}else{
			alert("<%=PartMap_Light_No_Exists%>");
			
		}
	}
	//0.3秒后根据Point改变地图的展示中心       
	function changeCenter(data) {
		setTimeout(function() {
			map.panTo(new BMap.Point(data.xcoordinate, data.ycoordinate)); //两秒后移动到第一个点
		}, 300);
		map.centerAndZoom(new BMap.Point(data.xcoordinate, data.ycoordinate),15);
	}
	//判断是否在选择框内
	var drawdata;
	function judgeSelection(bound) {
		var drawtata=[];
		var drawid=[];
		for(var i=0;i<desMakerdata.length;i++){
			var judgepoint = new BMap.Point(desMakerdata[i].xcoordinate,desMakerdata[i].ycoordinate);
			if(bound.containsPoint(judgepoint))
				{
				 drawid.push(desMakerdata[i].id);
				 desMakerdata[i].searchconditions=null;
				 drawtata.push(desMakerdata[i]);
				}
		}
		for(var i=0;i<drawtata.length;i++){
			var a=drawtata[i];
			a.drawid=drawid;
		}
		if(drawtata.length>0){
			parent.cleardrawdata();//删除原有的左边框选列表
			parent.setmapTermpage(-2,drawtata[0]);
			//parent.changedrawdata(drawtata);//用于再次点击时可以加载出来
			parent.gpsTObbddrawing(drawtata);//添加左边框选列表
			drawdata=drawtata;
		}
		else{
				alert("<%=no_data_in_box%>");
				CircleAndRectangle.removeContextMenu(menu);
				map.removeOverlay(CircleAndRectangle);
				CircleAndRectangle = null;
			}
	}
	function TurnOnLight(type) {
		if(type==1){
			//局部图的时候
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
								cleanAllMaker();//清除所有覆盖物
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
								 choseMakerdata.brightness=100;
								 $("#brightnessValue").html(100);
								 $("#brightnessValueLight").html(100);
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
	function TurnOffLight(type) {
		if(type ==1){
			//局部图的时候
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
								 $("#brightnessValueLight").html(0);
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

	function change_bright(bright,type) {
		if(type ==1){
			//局部图的时候
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
					cleanAllMaker();//清除所有覆盖物
					var a;
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
				$("#brightnessValueLight").html(bright);
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
								 $("#brightnessValueLight").html(bright);
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
  "<link rel='styleSheet' type='text/css' href='static/map/css/content_light2.css' />"+
  "</head>"+
  "<body>"+
  "<table class='table-striped  table-hover' style='margin-top:5px;height=180px;width=1090px' border='1' >"+
  	"<tr> "+
	"<td class='center'  colspan=4 style='word-break:break-all' width=100px colspan=3 >"+data.id+"</td>"+
	"</td>"+
	 "</tr>"+
	"<tr height=5px>"+	
	"<td class='center' width='170px' height='30px'><%=serial_number%>"+
	"</td>"+
	"<td class='center' style='word-break:break-all' width=100px colspan=3 >"+data.id+"</td>"+
	"</tr>"+
	"<tr height=5px>"+
	"<td class='center'>"+"<%=name%>"+
	"</td>"+
	"<td class='center'  colspan=3>"+data.name +
	"</td>"+
	
  "</tr>"+
  "<tr height=5px>"+
  "<td class='center' style='word-break:break-all' >"+"<%=pole_number2%>"+
	"</td>"+
	"<td class='center' colspan=3>"+data.lamppolenum +
	"</td>"+
  "</tr>"+
  "<tr height=5px>"+
  "<td class='center'  >"+"<%=location%>"+
	"</td>"+
	"<td class='center' colspan=3>"+ data.location +
	"</td>"+
  "</tr>"
 	+
	  "<tr height=5px>"+
	  "<td class='center' style='word-break:break-all'>"+"<%=group_name%>"+
		"</td>"+
		"<td class='center' colspan=3>"+data.termname +"</td>"+
	  "</tr>"+
	  "<tr height=5px>"+
	  "<td class='center' width='100px'>"+"<%=brightness_value%>"+
		"</td>"+
		"<td class='center'colspan=3 id='brightnessValueLight' style='word-break:break-all'>"+ data.brightness+
		"</td>"+
	  "</tr>"+
	  "<tr height=50px>"+
	  "<div class='bottom'>"+
	  "<td  width=100px> "+
		"<div class='b1' onclick ='TurnOnLight()'>"+
				"<div class='bimg2'>"+
					"<img src='static/map/img/bulb_on.png'>"+
					"<a href='javascript:void(0)'>"+"<%=open_light%>"+"</a>"+
				"</div>"+
				
		"</div>"+
		"</td><td width=110px> "+	
	"<div class='b2' onclick ='TurnOffLight()'>"+
		"<div class='bimg2'>"+
				"<img src='static/map/img/bulb_off.png'>"+
				"<a href='javascript:void(0)'>"+"<%=shut_down_light%>"+"</a>"+
		"</div>"+

	"</div>"+
	"</td><td width=110px> "+	
	"<div class='b3' onclick ='PolicyControl()'>"+
		"<div class='bimg3'>"+
				"<img src='static/map/img/policy_control.png'>"+
				"<a href='javascript:void(0)' >"+"<%=control_strategy%>"+"</a>"+
		"</div>"+
	"</div>"+
	"</td><td width=200px> "+	
		"<div class='btx4'>"+
			"<%=brightness_value%>"+":"+
			"<select style='width:60px;' onchange='change_bright(this.options[this.options.selectedIndex].value)'>"
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
	"</td>"+		
		"</div>"+
		"</td>"+
	  "</tr>"+
	 "</table>"+
  "</body>"+
  "</html>";
  return sContent_light;
}</script>
</html>
