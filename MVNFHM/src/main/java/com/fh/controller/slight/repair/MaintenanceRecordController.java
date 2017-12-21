package com.fh.controller.slight.repair;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.entity.system.Role;
import com.fh.entity.system.User;
import com.fh.hzy.util.LogType;
import com.fh.hzy.util.UserUtils;
import com.fh.service.fhoa.department.DepartmentManager;
import com.fh.service.slight.repair.MaintenanceRecordService;
import com.fh.service.slight.repair.NodeRepairService;
import com.fh.service.system.fhlog.FHlogManager;
import com.fh.service.system.role.RoleManager;
import com.fh.util.Const;
import com.fh.util.Jurisdiction;
import com.fh.util.PageData;


/** 
 * 类名称：MaintenanceRecordController
 * 创建人：wap
 * 创建时间：2017-12-14
 */
@Controller
@RequestMapping(value="/repair")
public class MaintenanceRecordController extends BaseController {
	
	String menuUrl = "repair/listMaintenanceRecord"; //菜单地址(权限用)
	
	@Resource(name="departmentService")
	private DepartmentManager departmentService;
	@Resource(name="maintenanceRecordService")
	private MaintenanceRecordService maintenanceRecordService;
	@Resource(name="nodeRepairService")
	private NodeRepairService nodeRepairService;
	@Resource(name="fhlogService")
	private FHlogManager FHLOG;
		
	
	/**
	 * 获取所有维修记录列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/listMaintenanceRecord")
	public ModelAndView listMaintenanceRecord(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"显示维修记录");
		
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		
		pd.put("userids", departmentService.getUseridsInDepartment(pd));
		page.setPd(pd);
		
		List<PageData> maintenanceList = maintenanceRecordService.getMaintenanceRecordList(page);
		
		mv.addObject("pd", pd);
		mv.addObject("maintenanceList", maintenanceList);
		mv.setViewName("repair/maintenance_record_list");
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
	}
	
	/**
	 * 显示故障信息
	 * @return
	 * @throws Exception
	 */ 
	@RequestMapping("/goFaultInfo")
	public ModelAndView goFaultInfo() throws Exception{
		ModelAndView mv = this.getModelAndView();
		
		PageData pd = new PageData();
		pd = this.getPageData();
		
		String device_type = pd.getString("device_type");
		if(device_type.equals("1")) {
			//节点
			pd = nodeRepairService.getFaultNodeById(pd);
		}else if(device_type.equals("2")) {
			//网关
			pd = maintenanceRecordService.getFaultGatewayById(pd);
		}
		pd.put("device_type", device_type);
		
		mv.addObject("pd", pd);
		mv.setViewName("repair/fault_info");
		return mv;
	}
	
	/**
	 * 显示修复人员详细信息
	 * @return
	 * @throws Exception
	 */ 
	@RequestMapping("/goUserInfo")
	public ModelAndView goUserInfo() throws Exception{
		ModelAndView mv = this.getModelAndView();
		
		Page page = new Page();
		PageData pd = new PageData();
		pd = this.getPageData();
		
		page.setPd(pd);
		
		String userid = pd.getString("user_id");
		pd.put("userids", "('" + userid +"')");
		
		List<PageData> userInfoList = departmentService.geAllUserInDepartment(page);
		if(userInfoList.size()>0) {
			pd = userInfoList.get(0);
		}		
		
		mv.addObject("pd", pd);
		mv.setViewName("repair/user_info");
		return mv;
	}

}
