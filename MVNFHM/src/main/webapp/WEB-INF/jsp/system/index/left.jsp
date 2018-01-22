﻿<%@page import="com.fh.entity.system.Language"%>
<div id="sidebar" class="sidebar responsive">
	<script type="text/javascript">
		try{ace.settings.check('sidebar' , 'fixed')}catch(e){}
	</script>


	<ul class="nav nav-list" id="main">
		<li class="">
			<a href="main/index">
				<i><img src="static/login/images/home.png" class="imgage"/></i>
				<span class="menu-text"><%=background_home_page %></span>
			</a>
		</li>

	<c:forEach items="${menuList}" var="menu1">
	<c:if test="${menu1.hasMenu && '1' == menu1.MENU_STATE}">
		<li class=""  id="lm${menu1.MENU_ID }">
			<a style="cursor:pointer;" class="dropdown-toggle" <c:if test="${menu1.MENU_ID==335}">target="mainFrame" onclick="openFrame()"</c:if><c:if test="${menu1.MENU_ID==368}"> target="mainFrame" onclick="openStatisticFrame()"</c:if>>
				<i class="${menu1.MENU_ICON == null ? 'menu-icon fa fa-leaf black' : menu1.MENU_ICON}">
				<c:if test="${menu1.MENU_ICON == 'ztree_map'}"><img src="static/login/images/map.png" class="imgage"/></c:if>
				<c:if test="${menu1.MENU_ICON == 'ztree_group'}"><img src="static/login/images/fzkz_icon.png" class="imgage"/></c:if>
				<c:if test="${menu1.MENU_ICON == 'ztree_strategy'}"><img src="static/login/images/strategy_ztree.png" class="imgage"/></c:if>
				<c:if test="${menu1.MENU_ICON == 'ztree_devicestatus'}"><img src="static/login/images/devicestatus.png" class="imgage"/></c:if>
				<c:if test="${menu1.MENU_ICON == 'ztree_basesetting'}"><img src="static/login/images/basesetting.png" class="imgage"/></c:if>
				
				</i>
					<span class="menu-text">
					<c:if test="${sessionScope.session_language=='en_US' }">
						${menu1.MENU_NAME_EN }
					</c:if>
					<c:if test="${sessionScope.session_language=='zh_CN' }">
						${menu1.MENU_NAME }
					</c:if>
					</span>
				<c:if test="${'[]' != menu1.subMenu}"><b class="arrow fa fa-angle-down"></b></c:if>
			</a>
			<b class="arrow"></b>
			<ul id="inner" hidden="true">
			</ul>
			<c:if test="${'[]' != menu1.subMenu}">
			<ul class="submenu">
			<c:forEach items="${menu1.subMenu}" var="menu2">
				<c:if test="${menu2.hasMenu && '1' == menu2.MENU_STATE}">
				<li class="" id="z${menu2.MENU_ID }">
					<a style="cursor:pointer;" <c:if test="${not empty menu2.MENU_URL && '#' != menu2.MENU_URL}">target="mainFrame" onclick="siMenu('z${menu2.MENU_ID }','lm${menu1.MENU_ID }','${menu2.MENU_NAME }','${menu2.MENU_URL }')"</c:if><c:if test="${'[]' != menu2.subMenu}"> class="dropdown-toggle"</c:if>>
						<i class="${menu2.MENU_ICON == null ? 'menu-icon fa fa-leaf black' : menu2.MENU_ICON}"><c></i>
							<c:if test="${sessionScope.session_language=='en_US' }">
								${menu2.MENU_NAME_EN }
							</c:if>
							<c:if test="${sessionScope.session_language=='zh_CN' }">
								${menu2.MENU_NAME }
							</c:if>
						<c:if test="${'[]' != menu2.subMenu}"><b class="arrow fa fa-angle-down"></b></c:if>
					</a>
					<b class="arrow"></b>
					<c:if test="${'[]' != menu2.subMenu}">
					<ul class="submenu">
						<c:forEach items="${menu2.subMenu}" var="menu3">
						<c:if test="${menu3.hasMenu && '1' == menu3.MENU_STATE}">
							<li class="" id="m${menu3.MENU_ID }">
								<a style="cursor:pointer;" <c:if test="${not empty menu3.MENU_URL && '#' != menu3.MENU_URL}">target="mainFrame" onclick="siMenu('m${menu3.MENU_ID }','z${menu2.MENU_ID }','${menu3.MENU_NAME }','${menu3.MENU_URL }')"</c:if><c:if test="${'[]' != menu3.subMenu}"> class="dropdown-toggle"</c:if>>
									<i class="${menu3.MENU_ICON == null ? 'menu-icon fa fa-leaf black' : menu3.MENU_ICON}"></i>
										<c:if test="${sessionScope.session_language=='en_US' }">
											${menu3.MENU_NAME_EN }
										</c:if>
										<c:if test="${sessionScope.session_language=='zh_CN' }">
											${menu3.MENU_NAME }
										</c:if>
									<c:if test="${'[]' != menu3.subMenu}"><b class="arrow fa fa-angle-down"></b></c:if>
								</a>
								<b class="arrow"></b>

								<c:if test="${'[]' != menu3.subMenu}">
								<ul class="submenu">
									<c:forEach items="${menu3.subMenu}" var="menu4">
									<c:if test="${menu4.hasMenu && '1' == menu4.MENU_STATE}">
									<li class="" id="n${menu4.MENU_ID }">
										<c:if test="${'[]' != menu4.subMenu}">
										<a style="cursor:pointer;" target="mainFrame" target="mainFrame" onclick="siMenu('n${menu4.MENU_ID }','m${menu3.MENU_ID }','${menu4.MENU_NAME }','menu/otherlistMenu.do?MENU_ID=${menu4.MENU_ID }')">
										</c:if>
										<c:if test="${'[]' == menu4.subMenu}">
										<a style="cursor:pointer;" target="mainFrame" <c:if test="${not empty menu4.MENU_URL && '#' != menu4.MENU_URL}">target="mainFrame" onclick="siMenu('n${menu4.MENU_ID }','m${menu3.MENU_ID }','${menu4.MENU_NAME }','${menu4.MENU_URL }')"</c:if>>
										</c:if>
											<i class="${menu4.MENU_ICON == null ? 'menu-icon fa fa-leaf black' : menu4.MENU_ICON}"></i>
											<c:if test="${sessionScope.session_language=='en_US' }">
												${menu4.MENU_NAME_EN }
											</c:if>
											<c:if test="${sessionScope.session_language=='zh_CN' }">
												${menu4.MENU_NAME }
											</c:if>
										</a>
										<b class="arrow"></b>
									</li>
									</c:if>
									</c:forEach>
								</ul>
								</c:if>
							</li>
							</c:if>
						</c:forEach>
					</ul>
					</c:if>
				</li>
				</c:if>
			</c:forEach>
			</ul>
			</c:if>
		</li>
	</c:if>
	</c:forEach>
	</ul><!-- /.nav-list -->

	<!-- #section:basics/sidebar.layout.minimize -->
	<div class="sidebar-toggle sidebar-collapse" id="sidebar-collapse">
		<i class="ace-icon fa fa-angle-double-right" data-icon1="ace-icon fa fa-angle-double-left" data-icon2="ace-icon fa fa-angle-double-right" id="icon"></i>
	</div >

	<!-- /section:basics/sidebar.layout.minimize -->
	<script type="text/javascript">
		try{ace.settings.check('sidebar' , 'collapsed')}catch(e){}
		window.onload=function(){
			if(document.getElementById("inner")==null){
				changeMenus();
			}
		}
		function openFrame(){
			top.mainFrame.tabAddHandler(335,"设备状态","equimentanaylise/retrieve");
		}
		// 打开div
		function openStatisticFrame(){
			top.mainFrame.tabAddHandler(368,"数据分析","lampstatictis/analysis");
		}
	</script>
<style type="text/css"> /** 重置浏览器默认标签样式 */ 
	.imgage{padding-left:11px;width:30px;}
	/* .ztree_map{background-image:url('map.png');} */
</style>
</div>
