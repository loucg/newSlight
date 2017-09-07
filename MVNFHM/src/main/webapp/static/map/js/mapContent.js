function init() {

	$("#check").click(function() {
						var termid = $("#groupname").val();
						if (termid == "") {
							termid = null;
						}
						var typeid = $("#terminaltype").val();
						if (typeid == "") {
							typeid = null;
						}
						var location = $("#address").val();
						if (location == "") {
							location = null;
						}
						var name = $("#terminalname").val();
						if (name == "") {
							name = null;
						}
						var id = $("#terminalid").val();
						if (id == "") {
							id = null;
						}

						var postSearchData = {
							"termid" : termid,
							"typeid" : typeid,
							"location" : location,
							"name" : name,
							"id" : id
						};
						if(postSearchData.termid==null||postSearchData.termid==""){Conframe.window.searcherr();}
						else{
						$.ajax({
									url : "gomap/getSearchClient",
									type : "POST",
									contentType : "application/json; charset=UTF-8",
									data : JSON.stringify(postSearchData),
									dataType : "json",
									success : function(data) {
										if (data.length!= 0) {
											//searchdata = data;// //全局变量，很重要/////////////////////////////////////
											//Conframe.window.changePreMakerdata(data);
											//console.log(data);
											//data[0].searchconditions.drawid=null;
											
											
											setChosetermid2("search");
											mapTermpage[-1]=data[0].searchconditions;
											//console.log(mapTermpage);
											$("#search").parent().parent().remove();
											gpsTObbdSearch(data);//左边加框
											Conframe.window.cleanAllMaker1();
											var arrpoints=[];
											for (var i = 0; i < data.length; i++) {
												arrpoints.push( new BMap.Point(data[i].xcoordinate,data[i].ycoordinate));
											}
											Conframe.window.gpsTObbd(arrpoints,data);
											Conframe.window.searchsuccess();
											
										} else {
											Conframe.window.searcherr();
										}
									},
									error : function() {
										Conframe.window.searcherr();
									}
								});
						}
					});
	$("#reset").click(function() {
		$("#groupname").val("");
		$("#terminaltype").empty();$("#terminaltype").append("<option  value=\"\"> </option>");
		$("#address").empty();$("#address").append("<option  value=\"\"> </option>");
		$("#terminalname").empty();$("#terminalname").append("<option  value=\"\"> </option>");
		$("#terminalid").append("<option  value=\"\"> </option>");
	});
}
