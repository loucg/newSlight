package com.fh.controller.slight.newnet;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.hzy.util.CMDType;
import com.fh.hzy.util.UserUtils;
import com.fh.service.fhoa.department.DepartmentManager;
import com.fh.service.slight.newnet.NewnetService;
import com.fh.service.system.fhlog.FHlogManager;
import com.fh.service.system.role.RoleManager;
import com.fh.util.AppUtil;
import com.fh.util.Jurisdiction;
import com.fh.util.PageData;

/** 
 * 类名称：NewnetController
 * 创建人：mxc
 * 创建时间：2017-03-01
 */
@Controller
@RequestMapping(value="/newnet")
public class NewnetController extends BaseController {
	
	String menuUrl = "repair/newnet"; //菜单地址(权限用)
	@Resource(name="newnetService")
	private NewnetService newnetService;
	@Resource(name="departmentService")
	private DepartmentManager departmentService;
	@Resource(name="roleService")
	private RoleManager roleService;
	@Resource(name="fhlogService")
	private FHlogManager fhlogService;
	
	private String newnetJsp = "newnet/newnet_list";                 //网关列表jsp
	private String newnetAddJsp = "newnet/add_client_list";  					//添加终端jsp
	private String newnetDeleteJsp = "newnet/delete_client_list";
	private String saveRsultJsp = "save_result";  				//保存修改jsp
	
	/**
	 * 获取网关列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/getNewnetList")
	public ModelAndView getNewnetList(Page page) throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		if(pd.getString("first")!=null&&pd.getString("first").equals("1")){}
		else{pd.put("first", 0);}
		pd.put("roleid", UserUtils.getRoleid());
		pd.put("rolename", "维修调试");
		pd.put("weixiuroleid", roleService.getRoleIdByName(pd));
		pd.put("userids", departmentService.getUseridsInDepartment(pd));
		page.setPd(pd);
		List<PageData> nPList = newnetService.getNewnetList(page);
		mv.addObject("pd", pd);
		
		mv.addObject("newnetList", nPList);
		mv.setViewName(newnetJsp);
		
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
	}

	
	
	/**
	 * 跳转终端页面
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/goClientList")
	public ModelAndView goClientList(Page page) throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("roleid", UserUtils.getRoleid());
		pd.put("rolename", "维修调试");
		pd.put("weixiuroleid", roleService.getRoleIdByName(pd));
		pd.put("userids", departmentService.getUseridsInDepartment(pd));
		page.setPd(pd);
		List<PageData> list  = newnetService.getClientList(page);
		mv.addObject("pd", pd);
		mv.addObject("clientList", list);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		mv.setViewName(newnetAddJsp);
		return mv;
	}
	
	/**
	 * 跳转已有终端页面
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/goOwnClientList")
	public ModelAndView goOwnClientList(Page page) throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		page.setPd(pd);
		List<PageData> list  = newnetService.getOwnClientList(page);
		System.out.println("gatewayid="+pd.getString("id"));
		mv.addObject("id", pd.getString("id"));
		mv.addObject("clientList", list);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		mv.setViewName(newnetDeleteJsp);
		return mv;
	}
	/**
	 * 为网关添加终端
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/addClient")
	@ResponseBody
	public Object addClient() throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> map = new HashMap<String,Object>();
		List<PageData> pdList = new ArrayList<PageData>();
		pd.put("gateway", pd.getString("id"));
		String DATA_IDS = pd.getString("DATA_IDS");
		System.out.println("ids:  "+DATA_IDS);
		if(null !=DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			for(int i=0;i<ArrayDATA_IDS.length;i++){
				pd.put("client", ArrayDATA_IDS[i]);
				newnetService.addClients(pd);
				pd.put("msg", "ok");
			}
			fhlogService.saveDeviceLog(UserUtils.getUserid(), "添加终端进入网关", ArrayDATA_IDS,pd.getString("id")
						, CMDType.ADD_DEVICE_TO_GATEWAY, null);
		}else{
			pd.put("msg", "no");
		}
		pdList.add(pd);
		map.put("list", pdList);
		return AppUtil.returnObject(pd, map);
	}
	
	/**
	 * 批量踢删成员
	 */
	@RequestMapping("/removeClient")
	@ResponseBody
	public Object removeClient() throws Exception{
		PageData pd = new PageData();
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		String gatewayid = pd.getString("id");
		pd.put("gateway", gatewayid);
		if(null !=DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			for(int i=0;i<ArrayDATA_IDS.length;i++){
				pd.put("client", ArrayDATA_IDS[i]);
				newnetService.deleteClients(pd);
				pd.put("msg", "ok");
			}
			fhlogService.saveDeviceLog(UserUtils.getUserid(), "从网关踢删终端", ArrayDATA_IDS,pd.getString("id"), CMDType.REMOVE_DEVICE_TO_GATEWAY, null);
		}else{
			pd.put("msg", "no");
		}
		
		pdList.add(pd);
		map.put("list", pdList);
		return AppUtil.returnObject(pd, map);
	}
		
}
