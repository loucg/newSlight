package com.fh.controller.strategy;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
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
import com.fh.entity.system.StrategyType;
import com.fh.service.fhoa.department.DepartmentManager;
import com.fh.service.system.fhlog.FHlogManager;
import com.fh.service.system.menu.MenuManager;

import com.fh.service.strategy.Strategy2Manager;
import com.fh.service.strategy.StrategySetManager;
import com.fh.service.strategy.StrategyTypeManager;
import com.fh.service.system.user.UserManager;
import com.fh.util.AppUtil;
import com.fh.util.Const;
import com.fh.util.Jurisdiction;
import com.fh.util.PageData;
import com.fh.util.Tools;

/** 
 * 类名称：Strategy2Controller
 * 创建人：wap
 * 更新时间：2017年7月30日
 * @version
 */
@Controller
@RequestMapping(value="/strategy")
public class Strategy2Controller extends BaseController {
	
	String menuUrl = "/strategy/listStrategy2.do"; //菜单地址(权限用)
	@Resource(name="userService")
	private UserManager userService;
	@Resource(name="menuService")
	private MenuManager menuService;
	@Resource(name="fhlogService")
	private FHlogManager FHLOG;
	@Resource(name="strategy2Service")
	private Strategy2Manager strategy2Service;
	@Resource(name="strategyTypeService")
	private StrategyTypeManager strategyTypeService;
	@Resource(name="departmentService")
	private DepartmentManager departmentService;
	@Resource(name="strategySetService")
	private StrategySetManager strategySetService;
	

	/**显示策略组中策略列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/listStrategy2")
	public ModelAndView listStrategy2(Page page)throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String name = pd.getString("name");			//检索条件：策略名称
		if(null !=name && !"".equals(name)){
			pd.put("name", name.trim());
		}
		String explain = pd.getString("explain");		//检索条件：应用说明
		if(null !=explain && !"".equals(explain)){
			pd.put("explain", explain.trim());
		}
		page.setPd(pd);
		List<PageData>	strategy2List = strategy2Service.listStrategy2(page);	//列出策略列表
	
		// 调节值显示
		if(strategy2List!=null) {
			for(int i=0; i<strategy2List.size(); i++) {
				PageData strategyPd = strategy2List.get(i);
				// C：30、40、30 T：40、60、0
				strategyPd = AppUtil.splitAdjustValue(strategyPd);
			}
		}
		
		// 取得策略包名称
		String setId = pd.getString("strategysetid");
		pd.put("id", setId);
		PageData pdSet = strategySetService.findStrategySetById(pd);
		if(pdSet!=null && pdSet.getString("name")!=null) {
			pd.put("strategySetName", pdSet.getString("name"));
		}
		
		mv.setViewName("strategy/strategy2_list");
		mv.addObject("strategy2List", strategy2List);
		mv.addObject("pd", pd);
		mv.addObject("msg", "listStrategy2");
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
	}
	
	
	/**去新增策略页面
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/goAddS2")
	public ModelAndView goAddS2()throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"去新增策略包策略");
		
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		List<StrategyType> strategyTypeList = strategyTypeService.getStrategyTypeList(pd);		//列出策略类型列表
		
		mv.setViewName("strategy/strategy_edit");
		mv.addObject("msg", "addS2");
		mv.addObject("pd", pd);
		mv.addObject("strategyTypeList", strategyTypeList);
		return mv;
	}
	
	/**保存策略包策略
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/addS2")
	public ModelAndView addS2() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增策略包策略");
		
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		
		//获得登录的用户id
		User user = (User)Jurisdiction.getSession().getAttribute(Const.SESSION_USER);
		String sys_user_id = user.getUSER_ID();
		pd.put("B_USER_ID", sys_user_id);
		logBefore(logger, pd.getString("name")+pd.getString("explain")+pd.getString("type"));
		
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
		String TDATE = df.format(new Date());
		pd.put("TDATE", TDATE);				//创建时间
		
		String type_id = pd.getString("TYPE");
		pd.put("B_STRATEGY_TYPE_ID", type_id);				//策略类型
		
		String brightInput = pd.getString("BRIGHTINPUT");
		String bright = pd.getString("BRIGHT");
		
		if((bright==null || bright.isEmpty()) && brightInput!=null) {
			pd.put("BRIGHT", brightInput);		
		}	
		
		//System.out.println(pd);
		strategy2Service.addStrategy2(pd);
		mv.addObject("msg","addSuccess");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**保存被选中策略
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/saveS2")
	@ResponseBody
	public Object saveS2() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增策略中策略");
		
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		
		PageData pd = new PageData();
		pd = this.getPageData();
		logBefore(logger, pd.getString("strategyset_id")+pd.getString("strategy_ids"));	
	
		Page page = new Page();
		page.setPd(pd);
		strategy2Service.selectStrategy2(page);
		
		Map<String,String> map = new HashMap<String,String>();
		map.put("result", "success");
		
		return AppUtil.returnObject(new PageData(), map);
	}
	

	/**删除被选中策略
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/deleteS2")
	@ResponseBody
	public Object deleteS2() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"删除策略中策略");
		
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		
		PageData pd = new PageData();
		pd = this.getPageData();
		logBefore(logger, pd.getString("strategy_ids"));		
		
		Page page = new Page(); 
		page.setPd(pd);
		strategy2Service.deleteStrategy2ById(page);
		
		Map<String,Object> map = new HashMap<String,Object>();		
		map.put("result", "success");
		
		return AppUtil.returnObject(pd, map);
	}
	
	/**去修改策略组中策略画面
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/goEditS2")
	public ModelAndView goEditS2() throws Exception{
		logBefore(logger, "准备修改策略组中策略");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = strategy2Service.findStrategy2ById(pd);								//根据ID读取
		// C：30、40、30 T：40、60、0	
		pd = AppUtil.splitAdjustValue(pd);

		List<StrategyType> strategyTypeList = strategyTypeService.getStrategyTypeList(pd);		//列出策略类型列表

		mv.setViewName("strategy/strategy_edit");
		mv.addObject("msg", "editS2");
		mv.addObject("pd", pd);
		mv.addObject("strategyTypeList", strategyTypeList);
		return mv;
	}
	
	/**
	 * 修改策略中策略
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/editS2")
	public ModelAndView editS2() throws Exception{
		logBefore(logger,"正在修改策略中策略");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
				
		//获得登录的用户id
		User user = (User)Jurisdiction.getSession().getAttribute(Const.SESSION_USER);
		String sys_user_id = user.getUSER_ID();
		pd.put("B_USER_ID", sys_user_id);
		System.out.println(sys_user_id);
		
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
		String tdate = df.format(new Date());
		pd.put("TDATE", tdate);				//创建时间
		System.out.println(tdate);
		
		String brightInput = pd.getString("BRIGHTINPUT");
		String bright = pd.getString("BRIGHT");
		
		if((bright==null || bright.isEmpty()) && brightInput!=null) {
			pd.put("BRIGHT", brightInput);		
		}
		
		//TODO  C：30、40、30
		//pd.put("VALUE", "C:30、40、30");

		strategy2Service.editStrategy2(pd);	//执行修改
		mv.addObject("msg","editSuccess");
		mv.setViewName("save_result");
		return mv;
	}
	

	
	
	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}

}


