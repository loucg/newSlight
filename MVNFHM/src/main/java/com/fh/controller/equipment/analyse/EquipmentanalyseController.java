package com.fh.controller.equipment.analyse;

import java.math.RoundingMode;
import java.text.DecimalFormat;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.entity.system.User;
import com.fh.service.equipment.EquipmentService;
import com.fh.service.fhoa.department.DepartmentManager;
import com.fh.util.Const;
import com.fh.util.Jurisdiction;
import com.fh.util.PageData;

@Controller
@RequestMapping(value = "/equimentanaylise")
public class EquipmentanalyseController extends BaseController {
	@Resource(name = "equipmentservice")

	private EquipmentService equipmentService;
	@Resource(name = "departmentService")
	private DepartmentManager departmentService;

	/**
	 * 显示用户拥有的终端（单灯控制器、一体化电源、断路器、网关、普通断路器）
	 * 
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/retrieve")
	public ModelAndView retrieve(Page page) throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String gateway_code = pd.getString("gateway_code"); // 检索条件：终端编号
		if (null != gateway_code && !"".equals(gateway_code)) {
			pd.put("gateway_code", gateway_code.trim());
		}
		String name = pd.getString("name"); // 检索条件
		if (null != name && !"".equals(name)) {
			pd.put("name", name.trim());
		}
		// 获得登录的用户id
		User user = (User) Jurisdiction.getSession().getAttribute(Const.SESSION_USER);
		String sys_user_id = user.getUSER_ID();
		pd.put("sys_user_id", sys_user_id);
		page.setPd(pd);
		String userids = departmentService.getUseridsInDepartment(pd);
		pd.put("userids", userids);
		PageData pdtemp = new PageData();
		List<PageData> equipmentGateWayList = equipmentService.listGatenum(page); // 列出网关列表
		if (equipmentGateWayList.size() > 0 ) {
			pdtemp = equipmentGateWayList.get(0);
			int getWayCount = Integer.parseInt(pdtemp.get("gatewayCount").toString());
			int onlineGateWayCount = Integer.parseInt(pdtemp.get("onlineGateWayCount").toString());
			DecimalFormat df = new DecimalFormat("0.0");//
			df.setRoundingMode(RoundingMode.HALF_UP);
			String rate = "0";
			if (getWayCount != 0) {
			rate = df.format(100 * (float)onlineGateWayCount / (float)getWayCount);//
			}
			pdtemp.put("gatewyOnlineRate", rate + "%");
			equipmentGateWayList.set(0, pdtemp);

		} else {
			pdtemp.put("gatewayCount", 0);
			pdtemp.put("onlineGateWayCount", 0);
			pdtemp.put("OnlinegatewayRate", "0%");
			equipmentGateWayList.set(0, pdtemp);
		}
		mv.setViewName("equipment/equipment_analyse");
		mv.addObject("equipment_analyse", equipmentGateWayList); // 对应jsp页面内的名称

		List<PageData> LightList = equipmentService.listLightnum(page); //
		// 列出终端列表
		PageData pdtemplight = new PageData();
		if (LightList.size() > 0 ) {
			pdtemplight = LightList.get(0);
			int lightCount = Integer.parseInt(pdtemplight.get("lightCount").toString());
			int onlineLightCount = Integer.parseInt(pdtemplight.get("onlineLightCount").toString());
			DecimalFormat df = new DecimalFormat("0.0");//
			df.setRoundingMode(RoundingMode.HALF_UP);
			String rate = "0";
			if (lightCount != 0) {
				rate = df.format(100 * (float)onlineLightCount / (float)lightCount);//
			}
			pdtemplight.put("onlineLightRate", rate + "%");
			LightList.set(0, pdtemplight);

		} else {
			pdtemplight.put("lightCount", 0);
			pdtemplight.put("onlineLightCount", 0);
			pdtemplight.put("onlineLightRate", "0%");
			LightList.set(0, pdtemplight);
		}
		// mv.setViewName("equipment/equipment_light");
		mv.addObject("equipmentLight", LightList); // 对应jsp页面内的名称

		List<PageData> equipmentfaultList = equipmentService.listEquipmentFaultNum(page); //
		List<PageData> equipmenttList = equipmentService.listEquipmentNum(page); //
		// 列出终端列表
		PageData pdEquipmentFault = new PageData();
		PageData pdEquipmen = new PageData();
		if (equipmenttList.size() > 0  ) {
			pdEquipmentFault = equipmentfaultList.get(0);
			int faultCount = Integer.parseInt(pdEquipmentFault.get("faultnum").toString());
			pdEquipmen = equipmenttList.get(0);
			int equipmentcnt = Integer.parseInt(pdEquipmen.get("equipmentcnt").toString());
			DecimalFormat df = new DecimalFormat("0.0");//
			df.setRoundingMode(RoundingMode.HALF_UP);
			String rate = "0";
			if (faultCount != 0) {
				rate = df.format(100 * (float)faultCount / (float)equipmentcnt);//
			}
			pdEquipmentFault.put("faultnum", faultCount);
			pdEquipmentFault.put("equipmentcnt", equipmentcnt);
			pdEquipmentFault.put("faultRate", rate + "%");
			equipmenttList.set(0, pdEquipmentFault);

		} else {
			pdEquipmentFault.put("faultnum", 0);
			pdEquipmentFault.put("equipmentcnt", 0);
			pdEquipmentFault.put("faultRate", "0%");
			equipmenttList.set(0, pdEquipmentFault);
		}
		mv.addObject("equipment_fault", equipmenttList); // 对应jsp页面内的名称

		// 设备统计处理1
		equipmentService.delete(page); //
		// 设备统计处理2
		equipmentService.update(page);
		List<PageData> deviceFaultList = null;
		// 7日
		if ("0".equals(pd.get("TYPE"))) {
			deviceFaultList = equipmentService.listDeviceFaultStatitcsNum(page); //
		}
		// 7周
		if ("1".equals(pd.get("TYPE"))) {
			deviceFaultList = equipmentService.listDeviceFaultStatitcsNumbyweek(page); //
		}
		// 7月
		if ("2".equals(pd.get("TYPE"))) {
			deviceFaultList = equipmentService.listDeviceFaultStatitcsNumbymonth(page); //
		}
		if (pd.get("TYPE") == null) {
			pd.put("TYPE", "0");
			deviceFaultList = equipmentService.listDeviceFaultStatitcsNum(page); //
		}
		mv.addObject("deviceFaultList", deviceFaultList); //
		mv.addObject("pd", pd);
		return mv;
	}

}