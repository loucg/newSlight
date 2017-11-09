/*
 * 20170912 modify by wzg
 * 
 * 内容:
 * typeid 项目丢失
 * lamp,power，sensor删除
 * 增加查询终端类型的查询
 * 
 */

package com.fh.controller.slight.configure;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.entity.system.User;
import com.fh.hzy.util.UserUtils;
import com.fh.service.fhoa.department.DepartmentManager;
import com.fh.service.slight.configure.ConfigureService;
import com.fh.service.street.state.GatewayStateService;
import com.fh.service.system.fhlog.FHlogManager;
import com.fh.util.AppUtil;
import com.fh.util.Const;
import com.fh.util.FileDownload;
import com.fh.util.FileUpload;
import com.fh.util.Jurisdiction;
import com.fh.util.ObjectExcelRead;
import com.fh.util.ObjectExcelView;
import com.fh.util.PageData;
import com.fh.util.PathUtil;

@Controller
@RequestMapping("/config")
public class ConfigureController extends BaseController {

	//网关界面
	private String deviceJsp = "foundation/combination/combination_list";
	
	//选择界面
	private String branchJsp = "foundation/combination/selectBranch";
		
	//断路器界面
	private String circuitBreakerJsp = "foundation/combination/circuit_breaker_list";
		
	//路灯配置界面
	private String lightConfigJsp = "foundation/combination/lightConfig_list";
	
	//编辑网关页面
	private String GatewayEditJsp = "foundation/combination/combination_edit";
	
	//查看网关配置页面
	private String GatewayViewJsp = "foundation/combination/gatewayparam_view";
	
	//编辑路灯页面
	private String deviceEditJsp = "foundation/combination/light_edit";
	
	private String deviceCreateJsp = "foundation/combination/combination_edit";

	//网关认领页面
	private String gatewayClaimJsp="foundation/combination/combination_gatewayClaim";
	
	private String uploadJsp = "foundation/combination/uploadexcel";
	private String saveRsultJsp = "save_result"; // 保存修改jsp

	@Resource(name = "configureService")
	private ConfigureService configureService;
	@Resource(name = "fhlogService")
	private FHlogManager FHLOG;
	@Resource(name = "departmentService")
	private DepartmentManager departmentService;
	@Resource(name = "gatewayStateService")
	private GatewayStateService gatewayStateService;

	/**
	 * 下载普通电源模版
	 * 
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/downExcel")
	public void downExcel(HttpServletResponse response) throws Exception {
		String xlsname = "device.xls";
		FileDownload.fileDownload(response, PathUtil.getClasspath() + Const.FILEPATHFILE + xlsname, xlsname);
	}

	/**
	 * 打开上传EXCEL页面
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/goUploadExcel")
	public ModelAndView goUploadExcel() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		mv.addObject("pd", pd);
		mv.setViewName(uploadJsp);
		return mv;
	}

	/**
	 * 跳转一体化电源页面
	 * 
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/goYTHPower")
	public ModelAndView goYTHPower(Page page) throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		page.setPd(pd);
		pd.put("itype", 1);
		pd.put("userids", departmentService.getUseridsInDepartment(pd));
		List<PageData> list = configureService.getDeviceList(page);
		mv.addObject("pd", pd);
		mv.addObject("QX", Jurisdiction.getHC()); // 按钮权限
		mv.addObject("deviceList", list);
		mv.setViewName(deviceJsp);
		return mv;
	}

	/**
	 * 跳转单灯控制器
	 * 
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/goDDController")
	public ModelAndView goDDController(Page page) throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("itype", 2);
		pd.put("userids", departmentService.getUseridsInDepartment(pd));
		page.setPd(pd);
		List<PageData> list = configureService.getDeviceList(page);
		mv.addObject("pd", pd);
		mv.addObject("QX", Jurisdiction.getHC()); // 按钮权限
		mv.addObject("deviceList", list);
		mv.setViewName(deviceJsp);
		return mv;

	}

	/**
	 * 跳转网关页面
	 * 
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/goGateway")
	public ModelAndView goGatewayAndBreak(Page page) throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("itype", 3);
		pd.put("userids", departmentService.getUseridsInDepartment(pd));
		List<PageData> typeList = configureService.getTypeList(page);
		pd.put("typeList", typeList);
		page.setPd(pd);
		List<PageData> list = configureService.getGatewayList(page);
		mv.addObject("pd", pd);
		mv.addObject("QX", Jurisdiction.getHC()); // 按钮权限
		mv.addObject("deviceList", list);
		mv.setViewName(deviceJsp);
		return mv;

	}

	/**
	 * 跳转终端组合
	 * 
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/goCombination")
	public ModelAndView goCombination(Page page) throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("itype", 4);
		pd.put("userids", departmentService.getUseridsInDepartment(pd));
		page.setPd(pd);
		List<PageData> deviceList = configureService.getDeviceList(page);
		mv.addObject("pd", pd);
		mv.addObject("QX", Jurisdiction.getHC()); // 按钮权限
		mv.addObject("deviceList", deviceList);
		mv.setViewName(lightConfigJsp);
		return mv;

	}

	/**
	 * 跳转断路器页面
	 * 
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/goBreak")
	public ModelAndView goBreak(Page page) throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("itype", 5);
		pd.put("userids", departmentService.getUseridsInDepartment(pd));
		List<PageData> typeList = configureService.getTypeList2(page);
		pd.put("typeList", typeList);
		page.setPd(pd);
		List<PageData> list = configureService.getBreakerList(page);
		mv.addObject("pd", pd);
		mv.addObject("QX", Jurisdiction.getHC()); // 按钮权限
		mv.addObject("deviceList", list);
		mv.setViewName(circuitBreakerJsp);
		return mv;

	}

	/**
	 * 终端查询
	 * 
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/getDeviceList")
	public ModelAndView getDeviceList(Page page) throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("userids", departmentService.getUseridsInDepartment(pd));
		page.setPd(pd);
		List<PageData> deviceList = null;
		int type = Integer.valueOf((String) pd.get("type"));
		int itype = Integer.valueOf((String) pd.get("itype"));
		if (itype == 4) {
			deviceList = configureService.getDeviceList(page);
			// pd.put("itype", type==6?4:type);
			pd.put("itype", 4);
			pd.put("type", type);
		} else if (itype == 3) {
			deviceList = configureService.getGatewayList(page);
			List<PageData> typeList = configureService.getTypeList(page);
			pd.put("typeList", typeList);
			pd.put("itype", 3);
			pd.put("type", type);
		} else if (itype == 5) {
			deviceList = configureService.getBreakerList(page);
			List<PageData> typeList = configureService.getTypeList2(page);
			pd.put("typeList", typeList);
			pd.put("itype", 5);
			pd.put("type", type);
		}
		if (pd.get("excel") != null && pd.getString("excel").equals("1")) {
			ObjectExcelView erv = new ObjectExcelView(); // 执行excel操作
			mv = new ModelAndView(erv, ConfigureUtils.exportDevice(deviceList));
			return mv;

		} else {
			mv.addObject("pd", pd);
			mv.addObject("QX", Jurisdiction.getHC()); // 按钮权限
			mv.addObject("deviceList", deviceList);
			mv.setViewName(deviceJsp);
			return mv;
		}
	}
	
	/**
	 * 路灯配置查询
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/getLightConfigList")
	public ModelAndView getLightConfigList(Page page) throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
 		pd.put("userids", departmentService.getUseridsInDepartment(pd));
		page.setPd(pd);
		List<PageData> deviceList = null;
		Object strType = pd.get("type");
		int type = 0;
		if (strType != null) {
			type = Integer.valueOf((String)pd.get("type"));
		}
		int itype = Integer.valueOf((String)pd.get("itype"));
		int gatewayId = Integer.valueOf((String)pd.get("gateway_id"));
		List<PageData> gatewaynamelist = null;
		if(itype==4){
			deviceList = configureService.getDeviceList(page);
			pd.put("id", gatewayId);
			gatewaynamelist = gatewayStateService.viewgateWayName(page);
//			pd.put("itype", type==6?4:type);
			pd.put("itype", 4);
			pd.put("type", type);
		}else if(itype==3){
			deviceList = configureService.getGatewayList(page);
			List<PageData> typeList = configureService.getTypeList(page);
			pd.put("typeList", typeList);
			pd.put("itype", 3);
			pd.put("type", type);
		}else if(itype==5){
			deviceList = configureService.getBreakerList(page);
			List<PageData> typeList = configureService.getTypeList2(page);
			pd.put("typeList", typeList);
			pd.put("itype", 5);
			pd.put("type", type);
		}
		if(pd.get("excel")!=null&&pd.getString("excel").equals("1")){
			ObjectExcelView erv = new ObjectExcelView();					//执行excel操作
			mv = new ModelAndView(erv,ConfigureUtils.exportDevice(deviceList));
			return mv;
			
		}else{
			mv.addObject("pd", pd);
			mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
			mv.addObject("deviceList", deviceList);
			mv.addObject("gatewaynamelist", gatewaynamelist);
			mv.setViewName(lightConfigJsp);
			return mv;
		}
	}
	
	/**
	 * 断路器查询
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/getCircuitBreakerList")
	public ModelAndView getCircuitBreakerList(Page page) throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
 		pd.put("userids", departmentService.getUseridsInDepartment(pd));
		page.setPd(pd);
		List<PageData> deviceList = null;
		int type = Integer.valueOf((String)pd.get("type"));
		int itype = Integer.valueOf((String)pd.get("itype"));
		if(itype==4){
			deviceList = configureService.getDeviceList(page);
//			pd.put("itype", type==6?4:type);
			pd.put("itype", 4);
			pd.put("type", type);
		}else if(itype==3){
			deviceList = configureService.getGatewayList(page);
			List<PageData> typeList = configureService.getTypeList(page);
			pd.put("typeList", typeList);
			pd.put("itype", 3);
			pd.put("type", type);
		}else if(itype==5){
			deviceList = configureService.getBreakerList(page);
			List<PageData> typeList = configureService.getTypeList2(page);
			pd.put("typeList", typeList);
			pd.put("itype", 5);
			pd.put("type", type);
		}
		if(pd.get("excel")!=null&&pd.getString("excel").equals("1")){
			ObjectExcelView erv = new ObjectExcelView();					//执行excel操作
			mv = new ModelAndView(erv,ConfigureUtils.exportDevice(deviceList));
			return mv;
			
		}else{
			mv.addObject("pd", pd);
			mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
			mv.addObject("deviceList", deviceList);
			mv.setViewName(circuitBreakerJsp);
			return mv;
		}
	}

	/**
	 * 跳转终端修改页面
	 * 
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/goDeviceEdit")
	public ModelAndView goDeviceEdit(Page page) throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
//		int typeid = Integer.valueOf((String) pd.get("typeid"));
//		List<PageData> lampList = new ArrayList<>();
		List<PageData> poleList = new ArrayList<>();
		List<PageData> clientTypeList = new ArrayList<>();
//		List<PageData> nPList = new ArrayList<>();
//		List<PageData> simList = new ArrayList<>();
//		List<PageData> sensorList = new ArrayList<>();
		// if (typeid==1||typeid==2||typeid==6) {
//		lampList = configureService.getAllLamp(pd);// 灯类型
		// if (typeid==2||typeid==6) {
//		nPList = configureService.getAllNPower(pd);// 电源类型
		// }
		// }else if (typeid==3||typeid==4||typeid==5) {
//		simList = configureService.getAllSim(pd);// SIM卡号
//		sensorList = configureService.getAllSensor(pd);// 传感器类型
		// }
		poleList = configureService.getAllPole(pd);// 灯杆类型
		clientTypeList = configureService.getAllClientType(pd);//终端类型
		
			pd = configureService.getDeviceById(pd);

		
		String coordinate = pd.getString("coordinate");
		if (coordinate.equals(",")) {
			pd.put("longitude", "");
			pd.put("latitude", "");
		} else if (coordinate.substring(0, 1).equals(",")) {
			pd.put("longitude", "");
			pd.put("latitude", coordinate.substring(1));
		} else if (coordinate.substring(coordinate.length() - 1).equals(",")) {
			pd.put("longitude", coordinate.substring(0, coordinate.length() - 1));
			pd.put("latitude", "");
		} else {
			String[] zuobiao = coordinate.split(",");
			pd.put("longitude", zuobiao[0]);
			pd.put("latitude", zuobiao[1]);
		}
		mv.addObject("pd", pd);
//		mv.addObject("powerList", nPList);
//		mv.addObject("lampList", lampList);
		mv.addObject("poleList", poleList);
		mv.addObject("clientTypeList", clientTypeList);
//		mv.addObject("simList", simList);
//		mv.addObject("sensorList", sensorList);

		mv.addObject("msg", "editDevice");
		mv.setViewName(deviceEditJsp);
		return mv;

	}
	
	/**
	 * 跳转网关修改页面
	 * 
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/goGatewayEdit")
	public ModelAndView goGatewayEdit(Page page) throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
//		int typeid = Integer.valueOf((String) pd.get("typeid"));
//		List<PageData> lampList = new ArrayList<>();
		List<PageData> poleList = new ArrayList<>();
//		List<PageData> nPList = new ArrayList<>();
		List<PageData> simList = new ArrayList<>();
//		List<PageData> sensorList = new ArrayList<>();
		// if (typeid==1||typeid==2||typeid==6) {
//		lampList = configureService.getAllLamp(pd);// 灯类型
		// if (typeid==2||typeid==6) {
//		nPList = configureService.getAllNPower(pd);// 电源类型
		// }
		// }else if (typeid==3||typeid==4||typeid==5) {
		simList = configureService.getAllSim(pd);// SIM卡号
//		sensorList = configureService.getAllSensor(pd);// 传感器类型
		// }
		poleList = configureService.getAllPole(pd);// 灯杆类型

//		if (typeid == 1 || typeid == 2 || typeid == 6) {
//			pd = configureService.getDeviceById(pd);
//
//		} else if (typeid == 3 || typeid == 4 || typeid == 5) {
		
		
		pd = configureService.getGatewayAndBreakById(pd);
		
		List<PageData> typeList = configureService.getTypeList(page);
		pd.put("typeList", typeList);
		page.setPd(pd);
		
//		}
		String coordinate = pd.getString("coordinate");
		if (coordinate.equals(",")) {
			pd.put("longitude", "");
			pd.put("latitude", "");
		} else if (coordinate.substring(0, 1).equals(",")) {
			pd.put("longitude", "");
			pd.put("latitude", coordinate.substring(1));
		} else if (coordinate.substring(coordinate.length() - 1).equals(",")) {
			pd.put("longitude", coordinate.substring(0, coordinate.length() - 1));
			pd.put("latitude", "");
		} else {
			String[] zuobiao = coordinate.split(",");
			pd.put("longitude", zuobiao[0]);
			pd.put("latitude", zuobiao[1]);
		}
		mv.addObject("pd", pd);
//		mv.addObject("powerList", nPList);
//		mv.addObject("lampList", lampList);
		mv.addObject("poleList", poleList);
		mv.addObject("simList", simList);
//		mv.addObject("sensorList", sensorList);

		mv.addObject("msg", "editGateway");
		mv.setViewName(GatewayEditJsp);
		return mv;

	}
	
	/**
	 * 查看配置
	 */
	@RequestMapping("/goViewConfig")
	@ResponseBody
	public Object goViewConfig() throws Exception{
		PageData pd = new PageData();
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String Id = pd.getString("Id");
		System.out.println(Id +"++++++++++++++++++++++++++++++");
		pd.put("c_gateway_id", Id);
		//获得登录的用户id
		User user = (User)Jurisdiction.getSession().getAttribute(Const.SESSION_USER);
		String sys_user_id = user.getUSER_ID();
		pd.put("sys_user_id", sys_user_id);
		pd.put("comment","初始化");
		pd.put("b_log_type_id", 21);
		pd.put("tdate", new Date());//创建时间
		System.out.println(pd +"111111=======================");
		configureService.addUserLog(pd);
		
		pd.put("b_cmd_type_id",33);
		pd.put("b_cmd_type_idDouble",34);
		pd.put("status",1);
		//获取b_user_log的id
		Integer b_user_log_id = configureService.searchUserLogId(pd);
		pd.put("b_user_log_id", b_user_log_id);
		pd.put("cmd", "等待数据的加入");
		System.out.println(pd +"=======================");
		configureService.finallyaddpageone(pd); 
		 
		
		pdList.add(pd);
		map.put("list", pdList);
		return AppUtil.returnObject(pd, map);
	
	}

	/**
	 * 初始化
	 */
	@RequestMapping("/goInitial")
	@ResponseBody
	public Object goInitial() throws Exception {
		PageData pd = new PageData();
		Map<String, Object> map = new HashMap<String, Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String Id = pd.getString("Id");
		System.out.println(Id + "++++++++++++++++++++++++++++++");
		pd.put("c_gateway_id", Id);
		// 获得登录的用户id
		User user = (User) Jurisdiction.getSession().getAttribute(Const.SESSION_USER);
		String sys_user_id = user.getUSER_ID();
		pd.put("sys_user_id", sys_user_id);
		pd.put("comment", "初始化");
		pd.put("b_log_type_id", 21);
		pd.put("tdate", new Date());// 创建时间
		System.out.println(pd + "111111=======================");
		configureService.addUserLog(pd);

		pd.put("b_cmd_type_id", 33);
		pd.put("b_cmd_type_idDouble", 34);
		pd.put("status", 1);
		// 获取b_user_log的id
		Integer b_user_log_id = configureService.searchUserLogId(pd);
		pd.put("b_user_log_id", b_user_log_id);
		pd.put("cmd", "等待数据的加入");
		System.out.println(pd + "=======================");
		configureService.finallyaddpageone(pd);
		configureService.finallyaddpagetwo(pd);

		pdList.add(pd);
		map.put("list", pdList);
		return AppUtil.returnObject(pd, map);

	}
	
	/**
	 * 跳转网关认领页面
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/goGatewayClaim")
	public ModelAndView goGatewayClaim() throws Exception{
		ModelAndView mv = this.getModelAndView();
		mv.addObject("msg", "gatewayClaim");
		mv.setViewName(gatewayClaimJsp);
		return mv;
	}
	
	/**
	 * 网关认领
	 * @return
	 * @throws Exception
	 */
 
	@RequestMapping(value="/gatewayClaim" ,produces="application/json;charset=UTF-8")
	@ResponseBody
	public Object gatewayClaim() throws Exception{
		Map<String,String> map = new HashMap<String,String>();
		PageData pd = new PageData();
		pd = this.getPageData();
		String errInfo = "";
		System.out.println(pd +" --------所有数据---------"); 
		pd = configureService.getUserByNameAndPwd(pd);	//根据用户名和密码去读取用户信息
		if(pd!= null){
			System.out.println(pd +" --------测试数据---------"); 
			errInfo = "success";
			pd.put("Status", 2);
			User user = (User) Jurisdiction.getSession().getAttribute(Const.SESSION_USER);
			String sys_user_id = user.getUSER_ID();
			pd.put("sys_user_id", sys_user_id);
			System.out.println("当前登录用户："+sys_user_id);
			System.out.println(pd +" --------测试数据1---------");
			//更改状态值
			configureService.updateStatus(pd);
		}
		// 获得登录的用户id
		map.put("result", errInfo);
		return AppUtil.returnObject(new PageData(), map);

	}

	/**
	 * 网关重置
	 */
	@RequestMapping("/gogatewaysearch")
	@ResponseBody
	public Object gatewayrest(Page page) throws Exception {
		PageData pd = new PageData();
		Map<String, Object> map = new HashMap<String, Object>();
		pd = this.getPageData();
		// 获得登录的用户id
		String Id = pd.getString("Id");
		System.out.println(Id + "++++++++++++++++++++++++++++++");
		pd.put("c_gateway_id", Id);
		pd.put("userids", departmentService.getUseridsInDepartment(pd));
		page.setPd(pd);
		List<PageData> gatewayNameList = configureService.getGateWayTermInfo(page);
		map.put("list", gatewayNameList);
		return AppUtil.returnObject(pd, map);

	}

	/**
	 * 网关重置
	 */
	@RequestMapping("/gogatewayrest")
	@ResponseBody
	public Object cleargatewayrest(Page page) throws Exception {
		PageData pd = new PageData();
		Map<String, Object> map = new HashMap<String, Object>();
		pd = this.getPageData();
		// 获得登录的用户id
		String Id = pd.getString("Id");
		System.out.println(Id + "++++++++++++++++++++++++++++++");
		pd.put("c_gateway_id", Id);
		User user = (User) Jurisdiction.getSession().getAttribute(Const.SESSION_USER);
		String sys_user_id = user.getUSER_ID();
		pd.put("userids", sys_user_id);
		page.setPd(pd);
		List<PageData> resultList =configureService.clearGateWayTermInfo(page);
		map.put("result", resultList.get(0));
		return AppUtil.returnObject(pd, map);

	}

	/**
	 * 跳转终端新增页面
	 * 
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/goDeviceCreate")
	public ModelAndView goDeviceCreate() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		List<PageData> powerList = configureService.getAllNPower(pd);
		List<PageData> lampList = configureService.getAllLamp(pd);
		List<PageData> poleList = configureService.getAllPole(pd);
		List<PageData> simList = configureService.getAllSim(pd);
		List<PageData> sensorList = configureService.getAllSensor(pd);

		mv.addObject("powerList", powerList);
		mv.addObject("lampList", lampList);
		mv.addObject("poleList", poleList);
		mv.addObject("simList", simList);
		mv.addObject("sensorList", sensorList);

		mv.addObject("msg", "createDevice");
		mv.setViewName(deviceCreateJsp);
		return mv;
	}

	/**
	 * 修改网关
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/editGateway")
	public ModelAndView editGateway() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		int typeid = Integer.valueOf((String) pd.get("typeid"));
		pd.put("coordinate", pd.getString("longitude") + "," + pd.getString("latitude"));
		pd.put("status", 1);

		// power、sim、sensor--------pd中无这几列

		// if(pd.getString("power")!=null){

//		if (typeid == 1) {// 一体化电源
//			if (pd.getString("pole").equals("")) {// 共用-灯杆
//				pd.put("pole", null);
//			}
////			if (pd.getString("lamp").equals("")) {// 终端-灯
////				pd.put("lamp", null);
////			}
//
//		}

//		if (typeid == 2 || typeid == 6) {// 单灯控制器、终端组合
//			if (pd.getString("pole").equals("")) {// 共用-灯杆
//				pd.put("pole", null);
//			}
////			if (pd.getString("lamp").equals("")) {// 终端-灯
////				pd.put("lamp", null);
////			}
////			if (pd.getString("power").equals("")) {// 终端-电源
////				pd.put("power", null);
////			}
//
//		}

//		if (typeid == 3 || typeid == 4 || typeid == 5) {// 网关、断路器、普通断路器
////			if (pd.getString("mobile").equals("")) {// 网关-卡
////				pd.put("mobile", null);
////			}
////			if (pd.getString("sensor").equals("")) {// 网关-传感器
////				pd.put("sensor", null);
////			}
//			if (pd.getString("pole").equals("")) {// 共用-灯杆
//				pd.put("pole", null);
//			}
//
//		}

//		if (typeid == 1 || typeid == 2 || typeid == 6) {
//			configureService.editDevice(pd);
//		} else if (typeid == 3 || typeid == 4 || typeid == 5) {
		if (pd.getString("mobile").equals("")) {// 共用-灯杆
			pd.put("mobile", null);
		}
			configureService.editGateway(pd);

//		}
		mv.setViewName(saveRsultJsp);
		return mv;

	}
	
	/**
	 * 修改灯终端
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/editDevice")
	public ModelAndView editDevice() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		int typeid = Integer.valueOf((String) pd.get("typeid"));
		pd.put("coordinate", pd.getString("longitude") + "," + pd.getString("latitude"));
		pd.put("status", 1);

		// power、sim、sensor--------pd中无这几列

		// if(pd.getString("power")!=null){

		if (typeid == 1) {// 一体化电源
			if (pd.getString("pole").equals("")) {// 共用-灯杆
				pd.put("pole", null);
			}
//			if (pd.getString("lamp").equals("")) {// 终端-灯
//				pd.put("lamp", null);
//			}

		}

		if (typeid == 2 || typeid == 6) {// 单灯控制器、终端组合
			if (pd.getString("pole").equals("")) {// 共用-灯杆
				pd.put("pole", null);
			}
//			if (pd.getString("lamp").equals("")) {// 终端-灯
//				pd.put("lamp", null);
//			}
//			if (pd.getString("power").equals("")) {// 终端-电源
//				pd.put("power", null);
//			}

		}

		if (typeid == 3 || typeid == 4 || typeid == 5) {// 网关、断路器、普通断路器
			if (pd.getString("mobile").equals("")) {// 网关-卡
				pd.put("mobile", null);
			}
//			if (pd.getString("sensor").equals("")) {// 网关-传感器
//				pd.put("sensor", null);
//			}
			if (pd.getString("pole").equals("")) {// 共用-灯杆
				pd.put("pole", null);
			}

		}

		if (typeid == 1 || typeid == 2 || typeid == 6) {
			configureService.editDevice(pd);
		} else if (typeid == 3 || typeid == 4 || typeid == 5) {
			configureService.editGateway(pd);

		}
		mv.setViewName(saveRsultJsp);
		return mv;

	}

	/**
	 * 新增终端
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/createDevice")
	public ModelAndView createDevice() throws Exception {

		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		int typeid = Integer.valueOf((String) pd.get("typeid"));
		pd.put("userid", UserUtils.getUserid());
		pd.put("coordinate", pd.getString("longitude") + "," + pd.getString("latitude"));
		pd.put("status", 1);
//		System.out.println("power=" + pd.getString("power"));
		System.out.println("pole=" + pd.getString("pole"));
//		System.out.println("lamp=" + pd.getString("lamp"));
		if (typeid == 1 || typeid == 2 || typeid == 6) {
			configureService.createDevice(pd);
		} else if (typeid == 3 || typeid == 4 || typeid == 5) {
			configureService.createGateway(pd);

		}
		mv.setViewName(saveRsultJsp);
		return mv;
	}

	/**
	 * 从EXCEL导入到数据库
	 * 
	 * @param file
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/readExcel")
	public ModelAndView readExcel(@RequestParam(value = "excel", required = false) MultipartFile file)
			throws Exception {

		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		if (null != file && !file.isEmpty()) {
			String filePath = PathUtil.getClasspath() + Const.FILEPATHFILE; // 文件上传路径
			String fileName = FileUpload.fileUp(file, filePath, "userexcel"); // 执行上传
			List<PageData> listPd = (List) ObjectExcelRead.readExcel(filePath, fileName, 2, 0, 0); // 执行读EXCEL操作,读出的数据导入List
																									// 2:从第3行开始；0:从第A列开始；0:第0个sheet

			for (int i = 0; i < listPd.size(); i++) {

				int type = ConfigureUtils.getDeviceType(listPd.get(i).getString("var2"));
				pd.put("number", listPd.get(i).getString("var0")); // ID
				pd.put("name", listPd.get(i).getString("var1")); // 姓名
				pd.put("location", listPd.get(i).getString("var3"));
				pd.put("coordinate", listPd.get(i).getString("var4"));
				pd.put("polenumber", listPd.get(i).getString("var5"));
				pd.put("password", listPd.get(i).getString("var6"));
				pd.put("comment", listPd.get(i).getString("var7"));
				pd.put("status", 1);
				pd.put("typeid", type);
				pd.put("userid", UserUtils.getUserid());
				if (type == 1 || type == 2 || type == 6) {
					// pd.put("mobile", listPd.get(i).getString("var5"));
					// pd.put("sensor", listPd.get(i).getString("var8"));
					// pd.put("pole", listPd.get(i).getString("var9"));
					configureService.createDevice(pd);
				}
				if (type == 3 || type == 4 || type == 5) {
					// pd.put("power", listPd.get(i).getString("var6"));
					// pd.put("lamp", listPd.get(i).getString("var7"));
					// pd.put("pole", listPd.get(i).getString("var9"));
					configureService.createGateway(pd);
				}

			}
			mv.addObject("msg", "success");
		}
		mv.setViewName(saveRsultJsp);
		return mv;
	}

	@RequestMapping("/testNumber")
	@ResponseBody
	public PageData testNumber() throws Exception {
		PageData pd = new PageData();
		pd = this.getPageData();
		String number = pd.getString("number");
		pd = configureService.getDeviceByNumber(pd);
		long d = (long) pd.get("count");
		pd.put("number", number);
		pd = configureService.getGatewayByNumber(pd);
		long g = (long) pd.get("count");
		pd.put("count", d + g);
		return pd;

	}
	
	/**
	 * 查看网关配置
	 */
	@RequestMapping("/goViewGatewayNet")
	public ModelAndView goViewGatewayNet() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String id = pd.getString("id");
		pd.put("c_gateway_id", id);
		//获得登录的用户id
		User user = (User)Jurisdiction.getSession().getAttribute(Const.SESSION_USER);
		String sys_user_id = user.getUSER_ID();
		pd.put("sys_user_id", sys_user_id);
		pd.put("comment","网关配置");
		pd.put("b_log_type_id", 22);
		pd.put("tdate", new Date());//创建时间
		configureService.addUserLog(pd);
		
		pd.put("b_cmd_type_id",33);
		pd.put("b_cmd_type_idDouble",34);
		pd.put("status",1);
		//获取b_user_log的id
		Integer b_user_log_id = configureService.searchUserLogId(pd);
		pd.put("b_user_log_id", b_user_log_id);
		pd.put("cmd", "等待数据的加入");
		configureService.finallyaddpageone(pd); 
		// 查看网关配置
		pd = configureService.viewGatewayNet(pd);
		mv.addObject("pd", pd);
		mv.setViewName(GatewayViewJsp);
		return mv;
	}
	
	/**
	 * 画面选择配置
	 */
	@RequestMapping("/goDeviceConfigPage")
	public ModelAndView goDeviceConfigPage() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		mv.setViewName(branchJsp);
		mv.addObject("pd", pd);
		return mv;
	}
	
}
