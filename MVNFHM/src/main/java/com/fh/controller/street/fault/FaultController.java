package com.fh.controller.street.fault;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.entity.system.User;
import com.fh.service.fhoa.department.DepartmentManager;
import com.fh.service.group.mem.GroupMemService;
import com.fh.service.street.fault.FaultService;
import com.fh.util.Const;
import com.fh.util.Jurisdiction;
import com.fh.util.PageData;
import com.fh.util.Tools;

/**
 * 路灯状态-故障列表
 * @author xiaozhou
 * 创建时间：2017年2月21日
 */
@Controller
@RequestMapping(value="/fault/street")
public class FaultController extends BaseController{

	String menuUrlG = "fault/street/listGateways.do";		//页面配置的菜单地址
	String menuUrlC = "fault/street/listLamps.do";		    //页面配置的菜单地址
    
	@Resource(name="faultService")
    private FaultService faultService;
	@Resource(name="departmentService")
	private DepartmentManager departmentService;
	/*@Resource(name="lampStateService")
    private LampStateService lampStateService;*/
	
	/**
	 * 显示 网关故障列表
	 * @param page
	 * @return
	 */
	@RequestMapping("/listGateways")
	public ModelAndView listGateways(Page page) throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String name = pd.getString("name");			//检索条件：名称
		if(null !=name && !"".equals(name)){
			pd.put("name", name.trim());
		}
		String gateway_code = pd.getString("gateway_code");		//检索条件：编号
		if(null !=gateway_code && !"".equals(gateway_code)){
			pd.put("gateway_code", gateway_code.trim());
		}
		String location = pd.getString("location");		//检索条件：位置
		if(null !=location && !"".equals(location)){
			pd.put("location", location.trim());
		}
		String lstatus = pd.getString("lstatus");		//检索条件：状态
		if(null !=lstatus && !"".equals(lstatus)){
			pd.put("lstatus", lstatus.trim());
		}
		//获得登录的用户id
		User user = (User)Jurisdiction.getSession().getAttribute(Const.SESSION_USER);
		String sys_user_id = user.getUSER_ID();
		pd.put("sys_user_id", sys_user_id);
		
		String userids = departmentService.getUseridsInDepartment(pd);
		pd.put("userids", userids);
		
		page.setPd(pd);
		List<PageData> gatewayfaultList = faultService.listGatewayFault(page);	//获取列表
		mv.setViewName("street/fault/gatewayfault_list");
		mv.addObject("gatewayfaultList", gatewayfaultList);
		mv.addObject("pd", pd);
		mv.addObject("QX", Jurisdiction.getHC());
		
		return mv;
	}
	
	
	/**
	 * 显示 路灯异常列表
	 * @param page
	 * @return
	 */
	@RequestMapping("/listLamps")
	public ModelAndView listLamps(Page page) throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String tname = pd.getString("tname");			//检索条件：组名
		if(null !=tname && !"".equals(tname)){
			pd.put("tname", tname.trim());
		}
		String cname = pd.getString("cname");		//检索条件：名称
		if(null !=cname && !"".equals(cname)){
			pd.put("cname", cname.trim());
		}
		String ccode = pd.getString("ccode");		//检索条件：编号
		if(null !=ccode && !"".equals(ccode)){
			pd.put("ccode", ccode.trim());
		}
		String location = pd.getString("location");		//检索条件：位置
		if(null !=location && !"".equals(location)){
			pd.put("location", location.trim());
		}
		String lstatus = pd.getString("lstatus");		//检索条件：状态
		if(null !=lstatus && !"".equals(lstatus)){
			pd.put("lstatus", lstatus.trim());
		}
		//获得登录的用户id
		User user = (User)Jurisdiction.getSession().getAttribute(Const.SESSION_USER);
		String sys_user_id = user.getUSER_ID();
		pd.put("sys_user_id", sys_user_id);
		
		String userids = departmentService.getUseridsInDepartment(pd);
		pd.put("userids", userids);
		
		page.setPd(pd);
		List<PageData> lampfaultList = faultService.listLampFault(page);	//获取路灯异常列表
		mv.setViewName("street/fault/lampfault_list");
		mv.addObject("lampfaultList", lampfaultList);
		mv.addObject("pd", pd);
		mv.addObject("QX", Jurisdiction.getHC());
		
		return mv;
	}
	
	/**
	 * 显示 电压异常列表
	 * @param page
	 * @return
	 */
	@RequestMapping("/listVos")
	public ModelAndView listVos(Page page) throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String name = pd.getString("name");			//检索条件：名称
		if(null !=name && !"".equals(name)){
			pd.put("name", name.trim());
		}
		String code = pd.getString("code");		//检索条件：编号
		if(null !=code && !"".equals(code)){
			pd.put("code", code.trim());
		}
		String location = pd.getString("location");		//检索条件：位置
		if(null !=location && !"".equals(location)){
			pd.put("location", location.trim());
		}
		String lstatus = pd.getString("lstatus");		//检索条件：状态
		if(null !=lstatus && !"".equals(lstatus)){
			pd.put("lstatus", lstatus.trim());
		}
		//获得登录的用户id
		User user = (User)Jurisdiction.getSession().getAttribute(Const.SESSION_USER);
		String sys_user_id = user.getUSER_ID();
		pd.put("sys_user_id", sys_user_id);
		
		String userids = departmentService.getUseridsInDepartment(pd);
		pd.put("userids", userids);
		
		page.setPd(pd);
		List<PageData> vofaultList = faultService.listVoFault(page);	//获取列表
		mv.setViewName("street/fault/vofault_list");
		mv.addObject("vofaultList", vofaultList);
		mv.addObject("pd", pd);
		mv.addObject("QX", Jurisdiction.getHC());
		
		return mv;
	}
	
	/**
	 * 显示 所有设备异常列表
	 * @param page
	 * @return
	 */
	@RequestMapping("/listDevices")
	public ModelAndView listDevices(Page page) throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String cname = pd.getString("cname");		//检索条件：名称
		if(null !=cname && !"".equals(cname)){
			pd.put("cname", cname.trim());
		}
		String ccode = pd.getString("code");		//检索条件：编号
		if(null !=ccode && !"".equals(ccode)){
			pd.put("code", ccode.trim());
		}
		String location = pd.getString("location");		//检索条件：位置
		if(null !=location && !"".equals(location)){
			pd.put("location", location.trim());
		}
		String lstatus = pd.getString("lstatus");		//检索条件：状态
		if(null !=lstatus && !"".equals(lstatus)){
			pd.put("lstatus", lstatus.trim());
		}
		String devType = pd.getString("devType");		//检索条件：设备种类
		//获得登录的用户id
		User user = (User)Jurisdiction.getSession().getAttribute(Const.SESSION_USER);
		String sys_user_id = user.getUSER_ID();
		pd.put("sys_user_id", sys_user_id);
		
		String userids = departmentService.getUseridsInDepartment(pd);
		pd.put("userids", userids);
		
		page.setPd(pd);
		List<PageData> devfaultList = null;
		
		if ("1".equals(devType)){
			devfaultList = faultService.listGatewayFault(page);	//获取网关异常列表
		} else if ("2".equals(devType)){
			devfaultList = faultService.listBreakerFault(page);	//获取断路器异常列表
		}else if ("3".equals(devType)){
			devfaultList = faultService.listLampFault(page);	//获取路灯异常列表
		} else if ("4".equals(devType)){
			devfaultList = faultService.listSensorFault(page);	//获取传感器异常列表
		}else {
			devfaultList = faultService.listAllFault(page);
		}
		mv.setViewName("street/fault/devicefault_list");
		mv.addObject("devfaultList", devfaultList);
		mv.addObject("pd", pd);
		mv.addObject("QX", Jurisdiction.getHC());
		
		return mv;
	}
}
