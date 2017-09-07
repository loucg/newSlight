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
</body>
<script type="text/javascript">
	var choseMaker;//全局变量很重要////////////////////////////////////////////////////////////////
	var choseMakerdata;//全局变量很重要////////////////////////////////////////////////////////////
	var preMakerdata;//全局变量很重要////////////////////////////////////////////////////////////
	// 定义自定义覆盖物的构造函数  
	function SquareOverlay(center, length, data) {
		this._center = center;
		this._length = length;
		this._data = data;
	}
	// 继承API的BMap.Overlay    
	SquareOverlay.prototype = new BMap.Overlay();
	//实现初始化方法  
	SquareOverlay.prototype.initialize = function(map) {
		// 保存map对象实例   
		this._map = map;
		// 创建div元素，作为自定义覆盖物的容器   
		var div = document.createElement("div");
		div.style.position = "absolute";
		// 可以根据参数设置元素外观   
		div.style.width = this._length + "px";
		div.style.height = this._length + "px";
		var statuscolor;
		var clienttype;

		if ("正常" == this._data.status) {
			statuscolor = "green";
		} else if ("异常" == this._data.status) {
			statuscolor = "red";
		} else if ("断电" == this._data.status) {
			statuscolor = "grey";
		} else {
			statuscolor = "green";
		}
		//clienttype = "light_";
		if ( this._data.aliastypename.indexOf("灯" ) >=0) {
			clienttype = "light_";
		} else if (this._data.aliastypename.indexOf("断路器" ) >=0) {
			clienttype = "breaker_";
		} else if (this._data.aliastypename.indexOf("网关") >= 0) {
			clienttype = "gateway_";
		} else {
			clienttype = "light_";
		}
		var backgroundimage = "url('static/map/img/" + clienttype + statuscolor
				+ ".png')";
		div.style.backgroundImage = backgroundimage;
		// 将div添加到覆盖物容器中   
		map.getPanes().markerPane.appendChild(div);
		/* div.onclick = function() {
		 alert("您点击了标注2");
		 } 
		 div.addEventListener('click', function(e) {
		 //alert('touched');
		 console.log(e);
		 })
		 */

		// 保存div实例   
		this._div = div;
		// 需要将div元素作为方法的返回值，当调用该覆盖物的show、   
		// hide方法，或者对覆盖物进行移除时，API都将操作此元素。   
		return div;
	}
	//实现绘制方法   
	SquareOverlay.prototype.draw = function() {
		// 根据地理坐标转换为像素坐标，并设置给容器    
		var position = this._map.pointToOverlayPixel(this._center);
		this._div.style.left = position.x - this._length / 2 + "px";
		this._div.style.top = position.y - this._length + "px";
	}

	//显示和隐藏覆盖物  
	// 实现显示方法    
	SquareOverlay.prototype.show = function() {
		if (this._div) {
			this._div.style.display = "";
		}
	}
	// 实现隐藏方法    
	SquareOverlay.prototype.hide = function() {
		if (this._div) {
			this._div.style.display = "none";
		}
	}

	//添加其他覆盖物方法  
	SquareOverlay.prototype.hello = function() {
		if (this._div) {
			console.log("hello");
			}
}
//自定义覆盖物添加事件方法     
	SquareOverlay.prototype.addEventListener = function(event, fun) {
		this._div['on' + event] = fun;
	}
	////////////////////////////////////////////////////////////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////////////////////////////////////
	var map = new BMap.Map("container", {
		//minZoom : 15,
		enableMapClick : false
	});// 创建地图实例   构造底图时，关闭底图可点功能
	//map.centerAndZoom("杭州", 15);// 初始化地图，设置中心点坐标和地图级别
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
			drawingModes : [ BMAP_DRAWING_CIRCLE, BMAP_DRAWING_RECTANGLE ]
		}
	//, rectangleOptions: styleOptions //矩形的样式

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
	//map.addEventListener("click", showInfo);
	function getClientsData(mapTermpage2,mapcenter,mapzoom) {
		$.ajax({
			url : "gomap/addClientMaker",
			type : "POST",
			contentType : "application/json; charset=UTF-8",
			data : JSON.stringify(mapTermpage2),
			dataType : "json",
			success : function(clientdata) {
				if (clientdata.length!=0) {
				//console.log(clientdata);
					map.clearOverlays();
					var arrpoints=[];
					for (var i = 0; i < clientdata.length; i++) {
						arrpoints.push( new BMap.Point(clientdata[i].xcoordinate,clientdata[i].ycoordinate));
					}
					preMakerdata = clientdata;//记录当前展示的数据
					gpsTObbd(arrpoints,clientdata,mapcenter,mapzoom);//////坐标转换
					//addClientMaker(clientdata,mapcenter,mapzoom); 
				} else {
					//preMakerdata = [];
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
	 
		function gpsTObbd(arrpoints,clientdata,mapcenter,mapzoom) {
		 	var len = arrpoints.length;//所有点的长度  
	        var points = [];//将大数组分成小数组存放。  50个一组
	        var endPoints = [];//将大数组分成小数组存放。  50个一组
	        var ajaxId = 0;//第几组请求  
	        var i = 0 ;  
	        var j = 0 ;  
	        var ajaxLen =0;//要发起几次请求。  
	  
	        //数组分装  
	        for (; i < len; i++) {     
	            if(i%10 == 0){  //分成小数组
	                ajaxId = Math.floor(i/10);  
	                points[ajaxId] = [];  
	            }  
	            points[ajaxId].push(arrpoints[i]);    
	        }  
	  
	        ajaxLen = points.length;  //一共有几个小数组就有几次请求
	        //闭包和回调。  
	        for (; j < ajaxLen; j++) {  
	            (function() {  
	                var jj = j;  //记录第几次转换
	                //回调函数，添加marker。  
	                var callback = function(data){  
	                    var ajaxId = jj;   
	                    var len = arrpoints.length,i,maker;   
	                    var base = ajaxId * 10; //本数组在原始大数组中的起始位。  
	                    if(data.status === 0) {  
	                        var dateLen = data.points.length;   
	                        for(i=0;i <dateLen;i++){
	                           clientdata[base+i].coordinate=data.points[i].lng+","+data.points[i].lat;
        					   clientdata[base+i].xcoordinate=data.points[i].lng;
        		               clientdata[base+i].ycoordinate=data.points[i].lat;   
	                           endPoints[base+i]=data.points[i];
	                            
	                           var markerpoint = new BMap.Point(data.points[i].lng,data.points[i].lat);
	                           var mySquare = new SquareOverlay(markerpoint, 16, clientdata[base+i]);
	                           map.addOverlay(mySquare);
	                           (function(k) {
	                           mySquare.addEventListener('mouseover', function(e) {//这里是自定义覆盖物的事件   		
	               				map.setDefaultCursor("pointer");
	               				//myDrag.close();
	               				});
	               				mySquare.addEventListener('mouseout', function(e) {//这里是自定义覆盖物的事件   		
	               				map.setDefaultCursor("default"); //设置地图默认的鼠标指针样式
	               				//myDrag.open();
	               				});
	               				mySquare.addEventListener('click', function(e) {//这里是自定义覆盖物的事件
	               				choseMakerdata = clientdata[base+k];
	        					var sContent = getInfoContent(clientdata[base+k]);
	        					var opts = {
	        						width : 304, // 信息窗口宽度
	        						height : 204, // 信息窗口高度
	        					};
	        					var infoWindow = new BMap.InfoWindow(sContent, opts); // 创建信息窗口对象
	        					infoWindow.enableCloseOnClick();
	        					var point = new BMap.Point(data.points[k].lng,data.points[k].lat);
	        					map.openInfoWindow(infoWindow, point); //开启信息窗口   
	               			});
	                      }(i));

	                           
	                             if(clientdata.length == endPoints.length){//加载完毕。  
	                            	 addClientMaker(clientdata,mapcenter,mapzoom)
	                            }   
	                        }  
	                    } else{
	                    	alert("<%=coordinate_conversion_failed%>");
	                    } 
	                    callback = null;//清理内存。  
	                    jj = null;  
	                }  
	                posTrans(points[j],callback);//坐标转换新的数据图标添加到地图上。  
	            })();         
	        }  
	        
	  
		}
	//坐标转换  
    function posTrans(points,callback){  
        var BdPoints = [],len = points.length,i;  
        for (i = 0; i < len; i++) {  
            BdPoints.push(new BMap.Point(points[i].lng,points[i].lat))  
        }  
        var convertor = new BMap.Convertor();  
        convertor.translate(BdPoints, 1, 5, callback);//百度的坐标转换接口。  
    } 
	
	//添加覆盖物 
	//var infoWindow;//全局变量，相当重要/////////////////////////////////////////////////////
	function addClientMaker(data,mapcenter,mapzoom) {
		preMakerdata =data;//记录当前展示的数据
		/* for (var i = 0; i < data.length; i++) {
			var markerpoint = new BMap.Point(data[i].xcoordinate,
					data[i].ycoordinate);
			var mySquare = new SquareOverlay(markerpoint, 16, data[i]);
			map.addOverlay(mySquare);
			//8、 为自定义覆盖物添加点击事件      
			(function(k) {
				mySquare.addEventListener('mouseover', function(e) {//这里是自定义覆盖物的事件   		
					map.setDefaultCursor("pointer");
				});
				mySquare.addEventListener('mouseout', function(e) {//这里是自定义覆盖物的事件   		
					map.setDefaultCursor("default"); //设置地图默认的鼠标指针样式
				});
				mySquare.addEventListener('click', function(e) {//这里是自定义覆盖物的事件   
					//choseMaker = mySquare;
					choseMakerdata = data[k];
					
					var sContent = getInfoContent(data[k]);
					var opts = {
						width : 304, // 信息窗口宽度
						height : 204, // 信息窗口高度
					};
					var infoWindow = new BMap.InfoWindow(sContent, opts); // 创建信息窗口对象
					infoWindow.enableCloseOnClick();
					var point = new BMap.Point(data[k].xcoordinate, data[k].ycoordinate);
					map.openInfoWindow(infoWindow, point); //开启信息窗口    
					//map.addEventListener('click', fo);
				});
			}(i));
		} */
		var Xcoordinate = 0;
		var Ycoordinate = 0;
		var minXcoordinate = data[0].xcoordinate;
		var minYcoordinate = data[0].ycoordinate;
		var maxXcoordinate = data[0].xcoordinate;
		var maxYcoordinate = data[0].ycoordinate;
		for (var i = 0; i < data.length; i++) {
			Xcoordinate = Xcoordinate + data[i].xcoordinate
			Ycoordinate = Ycoordinate + data[i].ycoordinate
			if (data[i].xcoordinate < minXcoordinate) {
				minXcoordinate = data[i].xcoordinate
			}
			if (data[i].xcoordinate > maxXcoordinate) {
				maxXcoordinate = data[i].xcoordinate
			}
			if (data[i].ycoordinate < minYcoordinate) {
				minYcoordinate = data[i].ycoordinate
			}
			if (data[i].ycoordinate > maxYcoordinate) {
				maxYcoordinate = data[i].ycoordinate
			}

		}
		Xcoordinate = Xcoordinate / data.length;
		Ycoordinate = Ycoordinate / data.length;
		//console.log(Xcoordinate);
		//console.log(Ycoordinate);
		var centerdata = {
			xcoordinate : Xcoordinate,
			ycoordinate : Ycoordinate
		};
		changeZoom(centerdata, minXcoordinate, minYcoordinate, maxXcoordinate,
				maxYcoordinate,mapcenter,mapzoom);//设置zoom大小
	}
///////////////////////////////////////////////////////////////////////////////////////////
	map.addEventListener("click",closeinfowindow);
	function closeinfowindow(){
		//setTimeout(function() {map.closeInfoWindow();}, 300);
		  
	}
	//叠加层点击事件    ////已经没有用了   
	function fo(e) {
		infoWindow.enableCloseOnClick();
		setTimeout(function() {map.removeEventListener("click", fo);}, 300); //这里取消绑定。         
		var point = new BMap.Point(e.point.lng, e.point.lat);
		map.openInfoWindow(infoWindow, point); //开启信息窗口    
		infoWindow=null;
		setTimeout(function() {map.removeEventListener("click", fo);}, 300); //这里取消绑定。                
	}
	//0.5秒后根据id改变地图的展示中心       
	function changeCenterByid(id) {
		var data;
		for(var i=0;i<preMakerdata.length;i++){
			if(id==preMakerdata[i].id)
				{
				data=preMakerdata[i];
				var x=preMakerdata[i].xcoordinate;
				var y=preMakerdata[i].ycoordinate;
				setTimeout(function() {
					map.panTo(new BMap.Point(x,y)); 
					//map.setZoom(19);
				}, 300);
				setTimeout(function() {
					map.setZoom(19);
				}, 1000);
				
				}
			
		}
		CenterMarker(data);
	}
	function CenterMarker(data) {
		var point = new BMap.Point(data.xcoordinate, data.ycoordinate);
		var marker = new BMap.Marker(point);  // 创建标注
		map.addOverlay(marker);               // 将标注添加到地图中
		marker.setAnimation(BMAP_ANIMATION_BOUNCE); //跳动的动画
		setTimeout(function() {map.removeOverlay(marker);
		}, 2000);
	}
	//0.3秒后根据Point改变地图的展示中心       
	function changeCenter(data) {
		//console.log(data.xcoordinate, data.ycoordinate);setTimeout(function() {}, 300);
		setTimeout(function() {
			map.panTo(new BMap.Point(data.xcoordinate, data.ycoordinate)); //两秒后移动到第一个点
		}, 300);
		

	}
	//改变地图的zoom大小    
	function changeZoom(center, minx, miny, maxx, maxy,mapcenter,mapzoom) {
		if(mapcenter!=null && mapzoom!=null){
			map.centerAndZoom(mapcenter,mapzoom);
		}else{
			for (var i = 19; i > 0; i--) {
				map.centerAndZoom(new BMap.Point(center.xcoordinate,
					center.ycoordinate), i);
				var bs = map.getBounds(); //获取可视区域
				var bssw = bs.getSouthWest(); //可视区域左下角
				var bsne = bs.getNorthEast(); //可视区域右上角
				if (bssw.lng < minx && bssw.lat<miny&&bsne.lng>maxx
					&& bsne.lat > maxy)
				break;
			
			}
		}
	}
	//清除所有覆盖物   
	function cleanAllMaker() {
		///map.clearOverlays();
	}
	//清除所有覆盖物   
	function cleanAllMaker1() {
		//console.log(12121);
		map.clearOverlays();
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
		preMakerdata=data;
	}
	//判断是否在选择框内
	var drawdata;
	function judgeSelection(bound) {
		var drawtata=[];
		var drawid=[];
		for(var i=0;i<preMakerdata.length;i++){
			var judgepoint = new BMap.Point(preMakerdata[i].xcoordinate,preMakerdata[i].ycoordinate);
			if(bound.containsPoint(judgepoint))
				{
				 drawid.push(preMakerdata[i].id);
				 preMakerdata[i].searchconditions=null;
				 drawtata.push(preMakerdata[i]);
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
	function TurnOnLight() {
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
			//console.log(choseMakerdata);
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
								if(choseMakerdata.searchconditions!=null)
									{a=choseMakerdata.searchconditions;getClientsData(a,mapcenter,mapzoom);}
								else if(choseMakerdata.drawid.length!=0)
									{ a=choseMakerdata;getClientsData(a,mapcenter,mapzoom);}
								else
									{a = parent.getmapTermpagein()[choseMakerdata.termid];getClientsData(a,mapcenter,mapzoom);}
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
			$
					.ajax({
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
								if(choseMakerdata.searchconditions!=null)
								{a=choseMakerdata.searchconditions;getClientsData(a,mapcenter,mapzoom);}
							else if(choseMakerdata.drawid.length!=0)
								{ a=choseMakerdata;getClientsData(a,mapcenter,mapzoom);}
							else
									{a = parent.getmapTermpagein()[choseMakerdata.termid];getClientsData(a,mapcenter,mapzoom);}
								
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
					var mapcenter=map.getCenter();
					var mapzoom=map.getZoom();
					if(choseMakerdata.searchconditions!=null)
					{a=choseMakerdata.searchconditions;getClientsData(a,mapcenter,mapzoom);}
				else if(choseMakerdata.drawid.length!=0)
					{ a=choseMakerdata;getClientsData(a,mapcenter,mapzoom);}
				else
						{a = parent.getmapTermpagein()[choseMakerdata.termid];getClientsData(a,mapcenter,mapzoom);}
					
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
	jQuery.getJSON("gomap/getFirstTermId/", function(data) {
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
			getClientsData(mapTermpage2);
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
            	top.mainFrame.tabAddHandler(196,'策略管理','strategy/listStrategys.do');	 
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
 
 function onchangeDraw_bright(bright) {
		//console.log(bright);
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
   	"<div id= 'main'>"+
   		"<div class = 'head'>"+
   			"<p>"+data .name+"</p>"+
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
							"<a>"+"<%=brightness_value%>"+"："+ data .brightness+"</a>"+
					"</li>"+
   				"</ul>"+
   			"</div>"+
   			"<div class='image'>"+
   				"<img src='static/map/img/light1.png' />"+
   			"</div>"+
   		"</div>"+
   		"<div class='bottom'>"+
       		"<div class='b1' onclick ='TurnOnLight()'>"+
					"<div class='bimg1'>"+
						"<img src='static/map/img/bulb_on.png'>"+
					"</div>"+
					"<div class='btx1'>"+
						"<a href='javascript:void(0)' >"+"<%=open_light%>"+"</a>"+
					"</div>"+
				"</div>"+
				"<div class='b2' onclick ='TurnOffLight()'>"+
					"<div class='bimg2'>"+
							"<img src='static/map/img/bulb_off.png'>"+
					"</div>"+
					"<div class='btx2'>"+
						"<a href='javascript:void(0)' >"+"<%=shut_down_light%>"+"</a>"+
					"</div>"+
				"</div>"+
				"<div class='b3' onclick ='PolicyControl()'>"+
					"<div class='bimg3'>"+
							"<img src='static/map/img/policy_control.png'>"+
					"</div>"+
					"<div class='btx3'>"+
						"<a href='javascript:void(0)' >"+"<%=control_strategy%>"+"</a>"+
					"</div>"+
				"</div>"+
				"<div class='btx4'>"+
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
