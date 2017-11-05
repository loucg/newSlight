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
import com.fh.service.strategy.Strategy2ApplyManager;
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
 * 类名称：Strategy2ApplyController
 * 
 * @001 2017/11/01 wap add
 */
@Controller
@RequestMapping(value="/strategy")
public class Strategy2ApplyController extends BaseController {
	
	String menuUrl = "/strategy/listStrategy2Apply.do"; //菜单地址(权限用)
	@Resource(name="userService")
	private UserManager userService;
	@Resource(name="menuService")
	private MenuManager menuService;
	@Resource(name="fhlogService")
	private FHlogManager FHLOG;
	@Resource(name="strategy2ApplyService")
	private Strategy2ApplyManager strategy2ApplyService;
	@Resource(name="strategy2Service")
	private Strategy2Manager strategy2Service;
	@Resource(name="departmentService")
	private DepartmentManager departmentService;

	

	/**显示策略组中策略列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/listStrategy2Apply")
	public ModelAndView listStrategy2Apply(Page page)throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		
		String strategySetId = pd.getString("strategysetid");	
		if(null !=strategySetId && !"".equals(strategySetId)){
			pd.put("strategyset_id", strategySetId);
		}
		
		String termId = pd.getString("c_term_id");	
		if(null !=termId && !"".equals(termId)){
			pd.put("c_term_id", termId);
		}		
		
		// 分组的策略包名链接到策略list画面时,[返回]按钮不显示
		pd.put("apply", true);
		
		page.setPd(pd);
		List<PageData>	strategy2List = strategy2ApplyService.listStrategy2BySetId(page);	//列出策略列表
	
		// 调节值显示
		if(strategy2List!=null) {
			for(int i=0; i<strategy2List.size(); i++) {
				PageData strategyPd = strategy2List.get(i);
				// C：30、40、30 T：40、60、0
				strategyPd = AppUtil.splitAdjustValue(strategyPd);
			}
		}

		mv.setViewName("strategy/strategy2_list");
		mv.addObject("strategy2List", strategy2List);
		mv.addObject("pd", pd);
		mv.addObject("msg", "listStrategy2Apply");
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
	}	
	
	
	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}

}


