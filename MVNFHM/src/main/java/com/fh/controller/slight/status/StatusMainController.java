package com.fh.controller.slight.status;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.fh.controller.base.BaseController;
import com.fh.entity.system.Strategy;
import com.fh.hzy.util.UserUtils;
import com.fh.service.fhoa.department.DepartmentManager;
import com.fh.service.slight.status.StatusMainService;
import com.fh.util.PageData;

/**
 * 
 * @author hongzhiyuanzj
 *
 */
@Controller
@RequestMapping("/status/main")
public class StatusMainController extends BaseController{
	
	@Resource(name="statusMainService")
	StatusMainService statusMainService;
	@Resource(name="departmentService")
	private DepartmentManager departmentService;
	
	String statusMainJsp = "statusStrategy/status_main";
	
	@RequestMapping("/getMainData")
	public ModelAndView getMainData() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("userids", departmentService.getUseridsInDepartment(pd));
		mv.addObject("groupAndStrategy", statusMainService.getStgAndGroupCnt(pd));
		mv.addObject("totalGateway", statusMainService.getGatewayTotal(pd));
		mv.addObject("normalGateway", statusMainService.getGatewayNormal(pd));
		mv.addObject("totalClient", statusMainService.getClientTotal(pd));
		mv.addObject("normalClient", statusMainService.getClientNormal(pd));
		pd.put("type", 3);
		mv.addObject("gatewayFault", statusMainService.getGatewayFaultCnt(pd));
		pd.put("type", 4);
		mv.addObject("cutoffFault", statusMainService.getGatewayFaultCnt(pd));
		mv.addObject("clientFault", statusMainService.getClientFaultCnt(pd));
		
		pd.put("state", 2);
		long v = (long)statusMainService.getGatewayFaultCnt(pd).get("fgateway")+(long)(statusMainService.getClientFaultCnt(pd).get("fclient"));
		mv.addObject("pressureFault", v);
		mv.addObject("todayPower", statusMainService.getTodayPower(pd));
		mv.setViewName(statusMainJsp);
	
		return mv;
	}
	
}
