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
import com.fh.service.slight.repair.NodeRepairService;
import com.fh.service.system.fhlog.FHlogManager;
import com.fh.service.system.role.RoleManager;
import com.fh.util.Const;
import com.fh.util.Jurisdiction;
import com.fh.util.PageData;


/** 
 * 类名称：NodeRepairController
 * 创建人：wap
 * 创建时间：2017-12-12
 */
@Controller
@RequestMapping(value="/repair")
public class NodeRepairController extends BaseController {
	
	String menuUrl = "repair/listFaultNode"; //菜单地址(权限用)
	@Resource(name="nodeRepairService")
	private NodeRepairService nodeRepairService;
	@Resource(name="departmentService")
	private DepartmentManager departmentService;
	@Resource(name="roleService")
	private RoleManager roleService;
	@Resource(name="fhlogService")
	private FHlogManager FHLOG;
		
	
	/**
	 * 获取节点故障列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/listFaultNode")
	public ModelAndView listFaultNode(Page page) throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
//		pd.put("roleid", UserUtils.getRoleid());
//		pd.put("rolename", "维修调试");
//		pd.put("weixiuroleid", roleService.getRoleIdByName(pd));
		pd.put("userids", departmentService.getUseridsInDepartment(pd));
		page.setPd(pd);
		
		List<PageData> faultNodeList = nodeRepairService.getFaultNodeList(page);
		mv.addObject("pd", pd);
		
		mv.addObject("faultNodeList", faultNodeList);
		mv.setViewName("repair/node/fault_node_list");
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
	}


	 /**
	 * 跳转节点维修记录新增页面
	 * @param page
	 * @return
	 * @throws Exception
	 */ 
	@RequestMapping("/goNodeRepairCreate")
	public ModelAndView goNodeRepairCreate() throws Exception{
		ModelAndView mv = this.getModelAndView();
		
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = nodeRepairService.getFaultNodeById(pd);
		
		// 登记人
		User user = (User)Jurisdiction.getSession().getAttribute(Const.SESSION_USER);
		pd.put("username", user.getNAME());
		
		// 修复人
		pd.put("userids", departmentService.getUseridsInDepartment(pd));
		Page page = new Page();
		page.setPd(pd);
		List<PageData> maintainerList= departmentService.geAllUserInDepartment(page);
		
		mv.addObject("pd", pd);
		mv.addObject("maintainerList", maintainerList);
		mv.addObject("msg", "createNodeRepair");		
//		FHLOG.save(UserUtils.getUserid(), "去登记节点维修记录", LogType.repairlogin);
		mv.setViewName("repair/node/fault_node_edit");
		return mv;
	}
	
	 /**
	 * 新增节点维修记录
	 * @return
	 * @throws Exception
	 */ 
	@RequestMapping("/createNodeRepair")
	public ModelAndView createNodeRepair() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("tdate", Calendar.getInstance().getTime());//创建时间
		
		// 登记人
		User user = (User)Jurisdiction.getSession().getAttribute(Const.SESSION_USER);
		pd.put("register", user.getUSER_ID());
				
		nodeRepairService.insertNodeRepair(pd);
		
		mv.addObject("msg", "success");
		mv.setViewName("save_result");
		FHLOG.save(UserUtils.getUserid(), "登记终端维修记录", LogType.repairlogin);
		return mv;

	} 
	
	/**
	 * 显示修复人员详细信息
	 * @param page
	 * @return
	 * @throws Exception
	 */ 
	@RequestMapping("/goNodeInfo")
	public ModelAndView goNodeInfo() throws Exception{
		ModelAndView mv = this.getModelAndView();
		
		PageData pd = new PageData();
		pd = this.getPageData();		
		
		
		String c_client_id = pd.getString("c_client_id");
		pd.put("c_client_id", c_client_id);
		
		pd = nodeRepairService.getNodeInfoById(pd);
		
		mv.addObject("pd", pd);
		mv.setViewName("repair/node/node_info");
		return mv;
	}

}
