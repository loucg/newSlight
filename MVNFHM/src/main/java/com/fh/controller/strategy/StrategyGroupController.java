package com.fh.controller.strategy;

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
import com.fh.entity.system.StrategyType;
import com.fh.entity.system.User;
import com.fh.service.fhoa.department.DepartmentManager;
import com.fh.service.group.GroupService;
import com.fh.service.group.mem.GroupMemService;
import com.fh.service.strategy.StrategyGroupManager;
import com.fh.service.strategy.StrategyManager;
import com.fh.util.AppUtil;
import com.fh.util.Const;
import com.fh.util.Jurisdiction;
import com.fh.util.PageData;

/** 
 * 类名称：StrategyGroupController
 * 创建人：zjc
 * 更新时间：2017年2月18日
 * @version
 */
@Controller
@RequestMapping(value="/strategyGroup")
public class StrategyGroupController extends BaseController{

	String menuUrl = "strategyGroup/listGroups.do";		//页面配置的菜单地址
    @Resource(name="groupMemService")
    private GroupMemService groupMemService;
    @Resource(name="groupService")
    private GroupService groupService;
    @Resource(name="strategyService")
	private StrategyManager strategyService;
    @Resource(name="strategyGroupService")
	private StrategyGroupManager strategyGroupService;
    @Resource(name="departmentService")
	private DepartmentManager departmentService;

	
	/**
	 * 显示已分配平台分组
	 * @param page
	 * @return
	 */
	@RequestMapping("/listGroups")
	public ModelAndView listGroups(Page page) throws Exception{
		logBefore(logger,"显示已分配平台分组");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();

		pd = this.getPageData();
		String term_name = pd.getString("term_name");			//检索条件：组名
		if(null != term_name && !"".equals(term_name)){
			pd.put("term_name", term_name.trim());
		}
		String term_explain = pd.getString("term_explain");		//检索条件：组说明
		if(null !=term_explain && !"".equals(term_explain)){
			pd.put("term_explain", term_explain.trim());
		}
		page.setPd(pd);

		System.out.println("fdffffffffffffffffffffffffffffffffffffffffffffff"+page);
		List<PageData> strategyGroup = strategyGroupService.listGroups(page);	//获取列表
		mv.setViewName("strategy/strategyGroup_list");
		mv.addObject("strategyGroup", strategyGroup);
		mv.addObject("pd", pd);
		mv.addObject("QX", Jurisdiction.getHC());
		return mv;
	}
	
	/**
	 * 显示未分配平台分组
	 * @param page
	 * @return
	 */
	@RequestMapping("/listOthers")
	public ModelAndView listOthers(Page page) throws Exception{
		logBefore(logger,"显示未分配平台分组");		
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		
		pd = this.getPageData();
		String term_name = pd.getString("term_name");			//检索条件：组名
		if(null != term_name && !"".equals(term_name)){
			pd.put("term_name", term_name.trim());
		}
		String term_explain = pd.getString("term_explain");		//检索条件：组说明
		if(null !=term_explain && !"".equals(term_explain)){
			pd.put("term_explain", term_explain.trim());
		}
		
		String userids = departmentService.getUseridsInDepartment(pd);
        pd.put("userids", userids);

		page.setPd(pd);
		List<PageData> strategyOther = strategyGroupService.listOthers(page);	//获取列表
		mv.setViewName("strategy/strategyOther_list");

		mv.addObject("strategyOther", strategyOther);
		mv.addObject("pd", pd);
		mv.addObject("QX", Jurisdiction.getHC());
		return mv;
	}
	
	/**
	 * 批量新增应用组
	 */
	@RequestMapping("/addGroups")
	@ResponseBody
	public Object addGroups() throws Exception{
		logBefore(logger,"批量新增应用组");
		PageData pd = new PageData();
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();

		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		
		if(null !=DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			for(int i=0;i<ArrayDATA_IDS.length;i++){
				pd.put("c_term_id", ArrayDATA_IDS[i]);
				strategyGroupService.addGroup(pd);
				pd.put("msg", "ok");
			}
		}else{
			pd.put("msg", "no");
			System.out.println("There is no data!");
		}
		
		pdList.add(pd);
		map.put("list", pdList);

		return AppUtil.returnObject(pd, map);
	}
	
	/**
	 * 批量踢删应用组
	 */
	@RequestMapping("/removeGroups")
	@ResponseBody
	public Object removeGroups() throws Exception{
		logBefore(logger,"批量踢删应用组");
		PageData pd = new PageData();
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");		
		
		if(null !=DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			for(int i=0;i<ArrayDATA_IDS.length;i++){
				pd.put("c_term_id", ArrayDATA_IDS[i]);
				strategyGroupService.removeGroup(pd);
				pd.put("msg", "ok");
			}
		}else{
			pd.put("msg", "no");
			System.out.println("There is no data! ");
		}
		
		pdList.add(pd);
		map.put("list", pdList);
		
		return AppUtil.returnObject(pd, map);
	}
	
	/**去参照分组画面
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/viewGroups")
	public ModelAndView viewGroups(Page page) throws Exception{
		logBefore(logger,"显示已分配平台分组");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();

		pd = this.getPageData();
		String term_name = pd.getString("term_name");			//检索条件：组名
		if(null != term_name && !"".equals(term_name)){
			pd.put("term_name", term_name.trim());
		}
		String term_explain = pd.getString("term_explain");		//检索条件：组说明
		if(null !=term_explain && !"".equals(term_explain)){
			pd.put("term_explain", term_explain.trim());
		}
		page.setPd(pd);

		System.out.println("fdffffffffffffffffffffffffffffffffffffffffffffff"+page);
		List<PageData> strategyGroup = strategyGroupService.listGroups(page);	//获取列表
		mv.setViewName("strategy/strategyGroup_list");
		mv.addObject("strategyGroup", strategyGroup);
		mv.addObject("pd", pd);
		mv.addObject("msg", "view");
		mv.addObject("QX", Jurisdiction.getHC());
		return mv;
	}
	
	
}
