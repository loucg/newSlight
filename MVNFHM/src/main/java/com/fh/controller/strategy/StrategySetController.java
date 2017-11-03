package com.fh.controller.strategy;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.entity.system.User;
import com.fh.service.fhoa.department.DepartmentManager;
import com.fh.service.strategy.StrategySetManager;
import com.fh.service.strategy.StrategyTypeManager;
import com.fh.service.system.fhlog.FHlogManager;
import com.fh.service.system.menu.MenuManager;
import com.fh.service.system.user.UserManager;
import com.fh.util.AppUtil;
import com.fh.util.Const;
import com.fh.util.Jurisdiction;
import com.fh.util.PageData;

/**
 * 类名称：StrategySetController 创建人：wap 更新时间：2017年7月30日
 * 
 * @version
 */
@Controller
@RequestMapping(value = "/strategy")
public class StrategySetController extends BaseController {

	String menuUrl = "strategy/listStrategySet.do"; // 菜单地址(权限用)
	@Resource(name = "userService")
	private UserManager userService;
	@Resource(name = "menuService")
	private MenuManager menuService;
	@Resource(name = "fhlogService")
	private FHlogManager FHLOG;
	@Resource(name = "strategySetService")
	private StrategySetManager strategySetService;
	@Resource(name = "strategyTypeService")
	private StrategyTypeManager strategyTypeService;
	@Resource(name = "departmentService")
	private DepartmentManager departmentService;

	/**
	 * 显示策略包列表
	 * 
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/listStrategySet")
	public ModelAndView listStrategySet(Page page) throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String name = pd.getString("name"); // 检索条件：策略名称
		if (null != name && !"".equals(name)) {
			pd.put("name", name.trim());
		}
		String explain = pd.getString("explain"); // 检索条件：应用说明
		if (null != explain && !"".equals(explain)) {
			pd.put("explain", explain.trim());
		}

		String userids = departmentService.getUseridsInDepartment(pd);
		pd.put("userids", userids);

		page.setPd(pd);
		List<PageData> strategySetList = strategySetService.listStrategySet(page); // 列出策略列表

		mv.setViewName("strategy/strategySet_list");
		mv.addObject("strategySetList", strategySetList);
		mv.addObject("pd", pd);
		mv.addObject("QX", Jurisdiction.getHC()); // 按钮权限
		return mv;
	}

	/**
	 * 去新增策略包页面
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/goAddSet")
	public ModelAndView goAddSet() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();

		mv.setViewName("strategy/strategySet_edit");
		mv.addObject("msg", "saveSet");
		mv.addObject("pd", pd);

		return mv;
	}

	/**
	 * 保存策略包
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/saveSet")
	public ModelAndView saveSet() throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "新增策略包");

		if (!Jurisdiction.buttonJurisdiction(menuUrl, "add")) {
			return null;
		} // 校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();

		// 获得登录的用户id
		User user = (User) Jurisdiction.getSession().getAttribute(Const.SESSION_USER);
		String sys_user_id = user.getUSER_ID();
		pd.put("B_USER_ID", sys_user_id);
		pd.put("USER_ID", sys_user_id);

		logBefore(logger, pd.getString("NAME") + pd.getString("EXPLAIN"));

		pd.put("STATUS", "1"); // 初始有效

		strategySetService.addStrategySet(pd);
		mv.addObject("msg", "addSuccess");
		mv.setViewName("save_result");
		return mv;
	}

	/**
	 * 去修改策略包名称说明页面
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/goEditSet")
	public ModelAndView goEditSet() throws Exception {
		logBefore(logger, "准备修改策略包");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = strategySetService.findStrategySetById(pd); // 根据ID读取

		mv.setViewName("strategy/strategySet_edit");
		mv.addObject("msg", "editSet");
		mv.addObject("pd", pd);
		return mv;
	}

	/**
	 * 修改策略包
	 */
	@RequestMapping(value = "/editSet")
	public ModelAndView editSet() throws Exception {
		logBefore(logger, "正在修改策略包");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		logBefore(logger, pd.getString("NAME") + pd.getString("EXPLAIN"));

		strategySetService.editStrategySet(pd); // 执行修改
		mv.addObject("msg", "editSuccess");
		mv.setViewName("save_result");
		return mv;
	}

	/**
	 * 删除策略包
	 */
	@RequestMapping(value = "/delSet")
	@ResponseBody
	public Object delSet() throws Exception {
		logBefore(logger, "正在删除策略包");
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "del")) {
			return null;
		} // 校验权限

		Map<String, String> map = new HashMap<String, String>();
		PageData pd = new PageData();
		pd = this.getPageData();
		strategySetService.deleteStrategySetById(pd.getString("ID")); // 执行删除(修改)

		map.put("result", "success");
		return AppUtil.returnObject(new PageData(), map);
	}

	/**
	 * 去选择策略包页面
	 */
	@RequestMapping(value = "/goSelectSet")
	public ModelAndView goSelectSet() throws Exception {
		logBefore(logger, "准备选择策略包");
		ModelAndView mv = this.getModelAndView();
		Page page = new Page();
		PageData pd = new PageData();
		pd = this.getPageData();

		String userids = departmentService.getUseridsInDepartment(pd);
		pd.put("userids", userids);

		page.setPd(pd);
		List<PageData> strategySetList = strategySetService.listOtherStrategySet(page); // 列出可选择策略列表

		mv.setViewName("strategy/strategySet_list");
		mv.addObject("strategySetList", strategySetList);
		mv.addObject("pd", pd);
		mv.addObject("QX", Jurisdiction.getHC()); // 按钮权限
		return mv;
	}

	/**
	 * 选择策略包到分组，并且下发策略包所包含策略到命令表
	 */
//	@RequestMapping(value = "/selectSet")
//	public ModelAndView selectSet() throws Exception {
//		logBefore(logger, "准备选择策略包");
//		ModelAndView mv = this.getModelAndView();
//		Page page = new Page();
//		PageData pd = new PageData();
//		pd = this.getPageData();
//
//		String userids = departmentService.getUseridsInDepartment(pd);
//		pd.put("userids", userids);
//
//		page.setPd(pd);
//		List<PageData> strategySetList = strategySetService.listOtherStrategySet(page); // 列出可选择策略列表
//
//		mv.setViewName("strategy/strategySet_list");
//		mv.addObject("strategySetList", strategySetList);
//		mv.addObject("pd", pd);
//		mv.addObject("QX", Jurisdiction.getHC()); // 按钮权限
//		return mv;
//	}

	@InitBinder
	public void initBinder(WebDataBinder binder) {
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format, true));
	}

}
