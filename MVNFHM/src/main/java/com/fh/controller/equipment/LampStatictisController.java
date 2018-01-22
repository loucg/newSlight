package com.fh.controller.equipment;

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
import com.fh.entity.system.Menu;
import com.fh.entity.system.User;
import com.fh.service.equipment.LampStatictisService;
import com.fh.service.fhoa.department.DepartmentManager;
import com.fh.service.system.menu.MenuManager;
import com.fh.util.AppUtil;
import com.fh.util.Const;
import com.fh.util.Jurisdiction;
import com.fh.util.PageData;

@Controller
@RequestMapping(value = "/lampstatictis")
public class LampStatictisController extends BaseController {
	@Resource(name = "lampStatictisService")
	private LampStatictisService lampStatictisService;
	@Resource(name = "departmentService")
	private DepartmentManager departmentService;
	@Resource(name="menuService")
	private MenuManager menuService;

	/**
	 * 显示指定时间的能耗，时长
	 * 
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/retrieve")
	public ModelAndView retrieve(Page page) throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		page.setPd(pd);
		// 获得登录的用户id
		User user = (User) Jurisdiction.getSession().getAttribute(Const.SESSION_USER);
		String sys_user_id = user.getUSER_ID();
		pd.put("sys_user_id", sys_user_id);
		String userids = departmentService.getUseridsInDepartment(pd);
		pd.put("userids", userids);
		List<PageData> lampEnergyList = null;
		// 7日
		if ("0".equals(pd.get("TYPE"))) {
			lampEnergyList = lampStatictisService.listLampEnergyStatitcsNumByDay(page); //
			calc(lampEnergyList);
		}
		// 7周
		if ("1".equals(pd.get("TYPE"))) {
			lampEnergyList = lampStatictisService.listLampEnergyStatitcsNumByWeek(page); //
		}
		// 7月
		if ("2".equals(pd.get("TYPE"))) {
			lampEnergyList = lampStatictisService.listLampEnergyStatitcsNumByMonth(page); //
		}
		if (pd.get("TYPE") == null) {
			pd.put("TYPE", "0");
			lampEnergyList = lampStatictisService.listLampEnergyStatitcsNumByDay(page); //
			calc(lampEnergyList);
		}
		mv.setViewName("equipment/lamp_statictis");//对应jsp页面内的名称
		mv.addObject("lampEnergyList", lampEnergyList); //
		mv.addObject("pd", pd);
		return mv;
	}
	
	/**
	 * 显示指定时间的能耗，时长
	 * 
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/analysis")
	public ModelAndView analysis(Page page) throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		page.setPd(pd);
		// 获得登录的用户id
		User user = (User) Jurisdiction.getSession().getAttribute(Const.SESSION_USER);
		String sys_user_id = user.getUSER_ID();
		pd.put("sys_user_id", sys_user_id);
		pd.put("USER_ID", sys_user_id);
		// 获取menu信息
		List<Menu> menuList= menuService.selectMenuInfo(pd);
		List<Menu> menuCardList= menuService.selectMenuCard(pd);
		mv.setViewName("analysis/statictis_collection");//对应jsp页面内的名称
		mv.addObject("pd", pd);
		mv.addObject("menuList", menuList);
		mv.addObject("menuCardList", menuCardList);
		return mv;
	}
	
	 /** 保存卡片
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/saveSubMenu")
	@ResponseBody
	public Object saveSubMenu() throws Exception{
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		String menuId = pd.getString("MENU_ID");
		// 获得登录的用户id
		User user = (User) Jurisdiction.getSession().getAttribute(Const.SESSION_USER);
		String sys_user_id = user.getUSER_ID();
		pd.put("USER_ID", sys_user_id);
		pd.put("MENU_ID", menuId);
		lampStatictisService.saveMenuCard(pd);
		return AppUtil.returnObject(pd, map);
	}
	
	 /** 删除卡片
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/delSubMenu")
	@ResponseBody
	public Object delSubMenu() throws Exception{
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		String menuId = pd.getString("MENU_ID");
		// 获得登录的用户id
		User user = (User) Jurisdiction.getSession().getAttribute(Const.SESSION_USER);
		String sys_user_id = user.getUSER_ID();
		pd.put("USER_ID", sys_user_id);
		pd.put("MENU_ID", menuId);
		lampStatictisService.delMenuCard(pd);
		return AppUtil.returnObject(pd, map);
	}
	private void calc(List<PageData> lampEnergyList){
		if (lampEnergyList != null && lampEnergyList.size() > 0) {
			for(int i = 0 ; i < lampEnergyList.size()-1; i++) {
				((PageData)lampEnergyList.get(i)).put("total_kwh", 
						Double.valueOf(((PageData)lampEnergyList.get(i)).get("total_kwh").toString()) - Double.valueOf(((PageData)lampEnergyList.get(i+1)).get("total_kwh").toString()));
				((PageData)lampEnergyList.get(i)).put("total_sumtime", 
						Double.valueOf(((PageData)lampEnergyList.get(i)).get("total_sumtime").toString()) - Double.valueOf(((PageData)lampEnergyList.get(i+1)).get("total_sumtime").toString()));
			}
		}
	}
}