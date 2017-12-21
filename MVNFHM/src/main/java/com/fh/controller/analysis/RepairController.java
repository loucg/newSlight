package com.fh.controller.analysis;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.controller.clienttype.ClientTypeUtils;
import com.fh.entity.Page;
import com.fh.entity.system.Role;
import com.fh.entity.system.User;
import com.fh.hzy.util.LogType;
import com.fh.hzy.util.UserUtils;
import com.fh.service.analysis.repair.RepairanalysisManager;
import com.fh.service.fhoa.department.DepartmentManager;
import com.fh.service.slight.gateway.GatewayService;
import com.fh.service.system.fhlog.FHlogManager;
import com.fh.service.system.user.UserManager;
import com.fh.util.AppUtil;
import com.fh.util.Const;
import com.fh.util.Jurisdiction;
import com.fh.util.ObjectExcelView;
import com.fh.util.PageData;

@Controller
@RequestMapping(value="/repair")
public class RepairController extends BaseController{
	String menuUrl = "repair/listGateway"; //菜单地址(权限用)
	@Resource(name="fhlogService")
	private FHlogManager FHLOG;
	@Resource(name="repairanalysisService")
	private RepairanalysisManager repairanalysisService;
	@Resource(name="gatewayService") 
	private GatewayService gatewayService;
	@Resource(name="departmentService")
	private DepartmentManager departmentService;
	@Resource(name="userService")
	private UserManager userService;
	private String saveRsultJsp = "save_result";  				//保存修改jsp
	
	/**网关维修列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/listGateway")
	public ModelAndView listGateway(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"网关维修");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String groupname = pd.getString("groupname");					//检索条件
		if(null != groupname && !"".equals(groupname)){
			pd.put("groupname", groupname.trim());
		}
		String name = pd.getString("name");					//检索条件
		if(null != name && !"".equals(name)){
			pd.put("name", name.trim());
		}
		String number = pd.getString("number");					//检索条件
		if(null != number && !"".equals(number)){
			pd.put("number", number.trim());
		}
		String location = pd.getString("location");					//检索条件
		if(null != location && !"".equals(location)){
			pd.put("location", location.trim());
		}
		String wgname = pd.getString("wgname");					//检索条件
		if(null != wgname && !"".equals(wgname)){
			pd.put("wgname", wgname.trim());
		}
		String starttime = pd.getString("starttime");					//故障类型
		if(null != starttime && !"".equals(starttime)){
			pd.put("starttime", starttime.trim());
		}
		String endtime = pd.getString("endtime");					//故障类型
		if(null != endtime && !"".equals(endtime)){
			pd.put("endtime", endtime.trim());
		}
		if((null == starttime || "".equals(starttime))&&(null == endtime || "".equals(endtime)))
		{
			Calendar cale = null;  
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			String firstday, lastday;  
	        // 获取前月的第一天  
	        cale = Calendar.getInstance();  
	        cale.add(Calendar.MONTH, 0);  
	        cale.set(Calendar.DAY_OF_MONTH, 1);  
	        firstday = format.format(cale.getTime());  
	        // 获取前月的最后一天  
	        cale = Calendar.getInstance();  
	        cale.add(Calendar.MONTH, 1);  
	        cale.set(Calendar.DAY_OF_MONTH, 0);  
	        lastday = format.format(cale.getTime());
	        pd.put("starttime", firstday.trim());
	        pd.put("endtime", lastday.trim());
		}
		String userids = departmentService.getUseridsInDepartment(pd);
        pd.put("userids", userids);
		page.setPd(pd);
		List<PageData>	varList = repairanalysisService.listGateway(page);	//列出Dictionaries列表
		if(pd.get("excel")!=null&&pd.getString("excel").equals("1")){
			ObjectExcelView erv = new ObjectExcelView();					//执行excel操作
//			mv = new ModelAndView(erv,FaultUtils.exportRepair(varList));
			FHLOG.save(UserUtils.getUserid(), "导出维修统计excel", LogType.repairexport);
			return mv;
		}else{
			mv.addObject("pd", pd);		//传入上级所有信息
			mv.setViewName("repair/gateway/fault_gateway_list");
			mv.addObject("varList", varList);
			mv.addObject("QX",Jurisdiction.getHC());				//按钮权限
			return mv;
		}
	}
	
	/**故障列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"查看维修统计");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String groupname = pd.getString("groupname");					//检索条件
		if(null != groupname && !"".equals(groupname)){
			pd.put("groupname", groupname.trim());
		}
		String name = pd.getString("name");					//检索条件
		if(null != name && !"".equals(name)){
			pd.put("name", name.trim());
		}
		String number = pd.getString("number");					//检索条件
		if(null != number && !"".equals(number)){
			pd.put("number", number.trim());
		}
		String location = pd.getString("location");					//检索条件
		if(null != location && !"".equals(location)){
			pd.put("location", location.trim());
		}
		String wgname = pd.getString("wgname");					//检索条件
		if(null != wgname && !"".equals(wgname)){
			pd.put("wgname", wgname.trim());
		}
		String starttime = pd.getString("starttime");					//故障类型
		if(null != starttime && !"".equals(starttime)){
			pd.put("starttime", starttime.trim());
		}
		String endtime = pd.getString("endtime");					//故障类型
		if(null != endtime && !"".equals(endtime)){
			pd.put("endtime", endtime.trim());
		}
		if((null == starttime || "".equals(starttime))&&(null == endtime || "".equals(endtime)))
		{
			Calendar cale = null;  
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			String firstday, lastday;  
	        // 获取前月的第一天  
	        cale = Calendar.getInstance();  
	        cale.add(Calendar.MONTH, 0);  
	        cale.set(Calendar.DAY_OF_MONTH, 1);  
	        firstday = format.format(cale.getTime());  
	        // 获取前月的最后一天  
	        cale = Calendar.getInstance();  
	        cale.add(Calendar.MONTH, 1);  
	        cale.set(Calendar.DAY_OF_MONTH, 0);  
	        lastday = format.format(cale.getTime());
	        pd.put("starttime", firstday.trim());
	        pd.put("endtime", lastday.trim());
		}
		String userids = departmentService.getUseridsInDepartment(pd);
        pd.put("userids", userids);
		page.setPd(pd);
		List<PageData>	varList = repairanalysisService.list(page);	//列出Dictionaries列表
		if(pd.get("excel")!=null&&pd.getString("excel").equals("1")){
			ObjectExcelView erv = new ObjectExcelView();					//执行excel操作
			mv = new ModelAndView(erv,FaultUtils.exportRepair(varList));
			FHLOG.save(UserUtils.getUserid(), "导出维修统计excel", LogType.repairexport);
			return mv;
		}else{
			mv.addObject("pd", pd);		//传入上级所有信息
			/*mv.addObject("companyid", companyid);			//上级ID
			mv.addObject("companyname", departmentService.findcompanyname(companyid));			//上级ID
	*/		mv.setViewName("analysis/repair_list");
			mv.addObject("varList", varList);
			mv.addObject("QX",Jurisdiction.getHC());				//按钮权限
			/*mv.addObject("pd", departmentService.findById(pd));		//传入上级所有信息
			mv.addObject("DEPARTMENT_ID", DEPARTMENT_ID);			//上级ID
			mv.setViewName("fhoa/department/department_list");
			mv.addObject("varList", varList);
			mv.addObject("QX",Jurisdiction.getHC());				//按钮权限
	*/		
			return mv;
		}
		
	}
	
	
	
	/**
	 * 获取可替换的网关信息
	 */
	@RequestMapping("/goRepairGatewayList")
	public ModelAndView goRepairGatewayList(Page page) throws Exception {
		logBefore(logger, "goRepairGatewayList");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		// 获得登录的用户id
		User user = (User) Jurisdiction.getSession().getAttribute(Const.SESSION_USER);
		String sys_user_id = user.getUSER_ID();
		pd.put("sys_user_id", sys_user_id);

		String userids = departmentService.getUseridsInDepartment(pd);
		pd.put("userids", userids);
		page.setPd(pd);
		List<PageData> repairableGatewayList = repairanalysisService.listRepairableGateway(page);
		mv.addObject("repairableGatewayList", repairableGatewayList);
		mv.setViewName("repair/gateway/repairable_gateway_list");
		mv.addObject("pd", pd);
		mv.addObject("QX", Jurisdiction.getHC());
		return mv;
	}
	
	/**
	 * 获取可替换的网关信息
	 */
	@RequestMapping("/changeGateway")
	public ModelAndView changeGateway(Page page) throws Exception {
		logBefore(logger, "changeGateway");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		page.setPd(pd);
		String newGatewayId = pd.getString("gatewayId");
		String oldGatewayid = pd.getString("faultGatewayid");
		pd.put("oldGatewayid", Integer.valueOf(oldGatewayid));
		pd.put("newGatewayid", Integer.valueOf(newGatewayId));
		// 更换网关
		 List<PageData> nodeList =repairanalysisService.updateGateway(pd);
		ObjectExcelView erv = new ObjectExcelView();
		mv = new ModelAndView(erv,ClientTypeUtils.exportNode(nodeList));
		mv.addObject("msg", "success");
		mv.setViewName(saveRsultJsp);
		return mv;
	}
	
	 /** 完成网关维修
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/completeRepair")
	@ResponseBody
	public Object completeRepair() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"--completeRepair");
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String faultId = pd.getString("DATA_IDS");
		if(null != faultId){
			pd.put("id", faultId);
			repairanalysisService.updateCompleteInfo(pd);
		}else{
			pd.put("msg", "no");
		}
		pdList.add(pd);
		map.put("list", pdList);
		return AppUtil.returnObject(pd, map);
	}
	 /** 完成网关维修
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/cancelRepair")
	@ResponseBody
	public Object cancelRepair() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"--cancelRepair");
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String faultId = pd.getString("DATA_IDS");
		if(null != faultId){
			pd.put("id", faultId);
			repairanalysisService.updateCancelInfo(pd);
		}else{
			pd.put("msg", "no");
		}
		pdList.add(pd);
		map.put("list", pdList);
		return AppUtil.returnObject(pd, map);
	}
	
	/**查看维修人，登记人信息
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/viewUserInfo")
	public ModelAndView viewUserInfo() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = userService.findById(pd);								//根据ID读取
		mv.setViewName("system/userInfo/userInfo_view");
		mv.addObject("pd", pd);
		return mv;
	}
}
