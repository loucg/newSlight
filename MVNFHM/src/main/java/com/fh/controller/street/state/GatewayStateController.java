package com.fh.controller.street.state;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.entity.system.User;
import com.fh.service.fhoa.department.DepartmentManager;
import com.fh.service.street.state.GatewayStateService;
import com.fh.util.Const;
import com.fh.util.Jurisdiction;
import com.fh.util.PageData;

/**
 * 路灯状态-网关状态列表
 * 
 * @author xiaozhou 创建时间：2017年2月16日
 */
@Controller
@RequestMapping(value = "/state/street")
public class GatewayStateController extends BaseController {

	String menuUrl = "state/street/listGateways.do"; // 页面配置的菜单地址
	@Resource(name = "gatewayStateService")
	private GatewayStateService gatewayStateService;
	@Resource(name = "departmentService")
	private DepartmentManager departmentService;

	/**
	 * 显示 网关状态列表
	 * 
	 * @param page
	 * @return
	 */
	@RequestMapping("/listGateways")
	public ModelAndView listGateways(Page page) throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String name = pd.getString("name"); // 检索条件：名称
		if (null != name && !"".equals(name)) {
			pd.put("name", name.trim());
		}
		String gateway_code = pd.getString("gateway_code"); // 检索条件：编号
		if (null != gateway_code && !"".equals(gateway_code)) {
			pd.put("gateway_code", gateway_code.trim());
		}
		String location = pd.getString("location"); // 检索条件：位置
		if (null != location && !"".equals(location)) {
			pd.put("location", location.trim());
		}
		String status = pd.getString("status"); // 检索条件：状态
		if (null != status && !"".equals(status)) {
			pd.put("status", status.trim());
		}
		// 获得登录的用户id
		User user = (User) Jurisdiction.getSession().getAttribute(Const.SESSION_USER);
		String sys_user_id = user.getUSER_ID();
		pd.put("sys_user_id", sys_user_id);

		String userids = departmentService.getUseridsInDepartment(pd);
		pd.put("userids", userids);

		page.setPd(pd);
		List<PageData> gatewayStateList = gatewayStateService.listGatewayState(page); // 获取列表
		pd.put("main_id", "3");
		List<PageData> workStatusList = gatewayStateService.getWorkStatus(pd);
		// mv.setViewName("street/state/gatewaystate_list");
		mv.setViewName("street/state/gatewaystate_list_new");
		mv.addObject("gatewayStateList", gatewayStateList);
		mv.addObject("workStatusList", workStatusList);

		mv.addObject("pd", pd);
		mv.addObject("QX", Jurisdiction.getHC());

		return mv;
	}

	/**
	 * 1显示同一网关下的所有终端信息
	 */

	@RequestMapping("/goViewDetail")
	public ModelAndView goViewDetail(Page page) throws Exception {
		logBefore(logger, "goViewDetail");
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
		// System.out.println(userids);
		List<PageData> clientDetailsList = gatewayStateService.viewClientDetail(page);
		List<PageData> gatewaynamelist = gatewayStateService.viewgateWayName(page);
		mv.setViewName("street/state/clientinfo_list");
		mv.addObject("clientDetailsList", clientDetailsList);
		mv.addObject("gatewaynamelist", gatewaynamelist);
		mv.addObject("pd", pd);
		mv.addObject("QX", Jurisdiction.getHC());
		return mv;
	}
	
	/**
	 * 打开选择页面
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/goSenlampStatePage")
	public ModelAndView goSenlampStatePage(Page page) throws Exception {
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
		int lampCount = gatewayStateService.getLampCount(page);
		int sensorCount = gatewayStateService.getSensorCount(page);
		pd.put("lampCount", lampCount);
		pd.put("sensorCount", sensorCount);
		mv.setViewName("street/state/selectBranch");
		mv.addObject("pd", pd);
		return mv;
	}

}
