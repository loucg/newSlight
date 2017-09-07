package com.fh.controller.slight.status;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.fh.controller.base.BaseController;
import com.fh.hzy.util.DateUtils;
import com.fh.hzy.util.Strategy;
import com.fh.hzy.util.UserUtils;
import com.fh.service.fhoa.department.DepartmentManager;
import com.fh.service.slight.status.StatusStrategyService;
import com.fh.util.Jurisdiction;
import com.fh.util.PageData;


/**
 * 
 * @author hongzhiyuanzj
 *
 */

@Controller
@RequestMapping("/status/strategy")
public class StatusStrategyController extends BaseController{
	
	private String strategyJsp = "statusStrategy/strategy_list";
	
	@Resource(name="statusStrategyService")
	public StatusStrategyService statusStrategyService;
	@Resource(name="departmentService")
	private DepartmentManager departmentService;
	
	@RequestMapping("/getGroupList")
	public ModelAndView getGroupList() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("userids", departmentService.getUseridsInDepartment(pd));
		int type = 1;
		if(pd.getString("type")!=null){
			type = Integer.valueOf(pd.getString("type"));
		}
		
		if(pd.getString("starttime")==null||pd.getString("starttime").equals("")){
			pd.put("starttime", DateUtils.getCurrentDate());
		}else{
			pd.put("starttime", DateUtils.getDate(pd.getString("starttime")));
		}
		if(pd.getString("endtime")==null||pd.getString("endtime").equals("")){
			if(type==1)pd.put("endtime", DateUtils.getDefaultNextDay());
			if(type==2)pd.put("endtime", DateUtils.getDefaultNextMonth());
		}else{
			pd.put("endtime", DateUtils.getDate(pd.getString("endtime")));
			
		}
		List<PageData> tableList;
		if(type==1){
			tableList = statusStrategyService.getDayGroupList(pd);
		}else{
			tableList = statusStrategyService.getMonthGroupList(pd);
		}
		List<PageData> strategyList = statusStrategyService.getStrategyList(pd);
		System.out.println(tableList);
		if(tableList==null||tableList.isEmpty()||tableList.get(0)==null){
			mv.addObject("groupList", null);
		}else{
			List<List<PageData>> groupList = new ArrayList<List<PageData>>();
			int table_number = tableList.size()/10+1;
			List<PageData> temp = null; 
			for(int i=0;i<table_number;i++){
				temp = new ArrayList<>();
				for(int j=0;j<10;j++){
					try{
						temp.add(tableList.get(j+10*i));
					}catch(Exception e){
						temp.add(new PageData());
					}
				}
				groupList.add(temp);
			}
			mv.addObject("groupList", groupList);
		}
		

//		for(int i=0;i<strategyList.size();i++){
//			Strategy strategy = JSON.parseObject(strategyList.get(i).getString("json"), Strategy.class);
//			Collections.sort(strategy.getT_i());
//			String json = JSON.toJSONString(strategy);
//			strategyList.get(i).put("json", json);
//		}
		
		mv.addObject("QX", Jurisdiction.getHC());
		System.out.println(DateUtils.toDateString((Date)pd.get("starttime")));
		System.out.println(DateUtils.toDateString((Date)pd.get("endtime")));
		pd.put("starttime", DateUtils.toDateString((Date)pd.get("starttime")));
		pd.put("endtime", DateUtils.toDateString((Date)pd.get("endtime")));
		mv.addObject("pd", pd);
		
		mv.addObject("strategyList", strategyList);
		mv.setViewName(strategyJsp);
		return mv;
	}

}
