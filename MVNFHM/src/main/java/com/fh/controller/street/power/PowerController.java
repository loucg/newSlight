package com.fh.controller.street.power;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.service.street.power.PowerService;
import com.fh.util.Jurisdiction;
import com.fh.util.PageData;

/**
 * 路灯状态-能耗状态
 * @author xiaozhou
 * 创建时间：2017年2月21日
 */
@Controller
@RequestMapping(value="/power/street")
public class PowerController extends BaseController{

	String menuUrl = "power/street/graphPowers.do";		//页面配置的菜单地址
    
	@Resource(name="powerService")
    private PowerService powerService;
	
	/**
	 * 显示图
	 * @param page
	 * @return
	 */
	@RequestMapping("/graphPowers")
	public ModelAndView graphPowers(Page page) throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		String a = "";
		pd = this.getPageData();
		String groupName = pd.getString("groupName");			//检索条件：组名
		if(null !=groupName && !"".equals(groupName)){
			pd.put("groupName", groupName.trim());
			a = a + "group";
		}
		String strategy = pd.getString("strategy");		//检索条件：策略
		if(null !=strategy && !"".equals(strategy)){
			pd.put("strategy", strategy.trim());
			a = a + "str";
		}
		String startTime = pd.getString("startTime");	//检索条件：开始时间
		if(null !=startTime && !"".equals(startTime)){
			pd.put("startTime", startTime.trim());
		}
		String endTime = pd.getString("endTime");		//检索条件：结束时间
		if(null !=endTime && !"".equals(endTime)){
			pd.put("endTime", endTime.trim());
		}
		String staType = pd.getString("staType");		//检索条件：统计类型
		if(null !=staType && !"".equals(staType)){
			pd.put("staType", staType.trim());
			if(staType == "1" || staType.equals("1")){
				a = a + "day";
			}else
				a = a + "month";
		}
		System.out.println(a);
		
		List<PageData> powerList = null;
		
		switch (a) {
		//case "":
		case "day":
		case "group":
		case "str":	
		case "groupstr":	
		case "groupday":	
		case "strday":	
	    case "groupstrday":	
			System.out.println("按天");
			searchbyDay(pd, page, powerList);
			break;
			
			
		case "month":
		case "groupmonth":	
		case "strmonth":	
		case "groupstrmonth":	
			searchAllbyMonth(pd, page, powerList);
			System.out.println("按月");
			break;

		default:
			defaultSearch(pd, page, powerList);
			System.out.println("默认查询");
			break;
		}
		
		mv.setViewName("street/power/powerstate_graph");
		mv.addObject("pd", pd);
		mv.addObject("QX", Jurisdiction.getHC());
		
		return mv;
	}
	

	//查询按天
	private void searchbyDay(PageData pd, Page page, List<PageData> powerList) throws Exception {

		page.setPd(pd);
		powerList = powerService.listPowerByDay(page);
		StringBuilder day = new StringBuilder();
		StringBuilder power = new StringBuilder();
		for(PageData pd1 : powerList)
		{
			day.append("'").append((String)pd1.get("day")).append("'").append(",");
			power.append((String)pd1.get("power")).append(",");
		
		}
		if(day.length()>=1){
			String xz = day.deleteCharAt(day.length()-1).toString();
			String yz = power.deleteCharAt(power.length()-1).toString();
			pd.put("xz", xz);
			pd.put("yz", yz);
		}else {
			pd.put("xz", 0);
			pd.put("yz", 0);
		}
		
	}
	
	   //查询按月
		private void searchAllbyMonth(PageData pd, Page page, List<PageData> powerList) throws Exception {
			
			//抽取开始时间和结束时间
			//将开始时间改为：****-**-00
			//将结束时间改为：****-**-31
			
			String sTime = pd.getString("startTime");
			if(null !=sTime && !"".equals(sTime)){
				pd.put("sTime", sTime.trim().substring(0, 8) + "00");
			}
			String eTime = pd.getString("endTime");
			if(null !=eTime && !"".equals(eTime)){
				pd.put("eTime", eTime.trim().substring(0, 8) + "31");
			}
			
			page.setPd(pd);
			powerList = powerService.listPowerByMonth(page);
			StringBuilder monthly = new StringBuilder();
			StringBuilder power = new StringBuilder();
			for(PageData pd1 : powerList)
			{
				monthly.append("'").append((String)pd1.get("monthly")).append("'").append(",");
				power.append((String)pd1.get("power")).append(",");
			
			}
			if(monthly.length()>=1){
				String xz = monthly.deleteCharAt(monthly.length()-1).toString();
				String yz = power.deleteCharAt(power.length()-1).toString();
				pd.put("xz", xz);
				pd.put("yz", yz);
			}else {
				pd.put("xz", 0);
				pd.put("yz", 0);
			}
		}
		
			
	//默认查询
	private void defaultSearch(PageData pd, Page page, List<PageData> powerList) throws Exception{
		//获取上月的第一天和最后一天
		SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd");
		Calendar calendar=Calendar.getInstance();
		calendar.add(Calendar.MONTH, -1);
		calendar.set(Calendar.DAY_OF_MONTH, 1);
		System.out.println("上个月第一天："+format.format(calendar.getTime()));
		pd.put("startTime", format.format(calendar.getTime()));
		calendar.set(Calendar.DAY_OF_MONTH, calendar.getActualMaximum(Calendar.DAY_OF_MONTH));
		System.out.println("上个月最后一天："+format.format(calendar.getTime()));
		pd.put("endTime", format.format(calendar.getTime()));
		
		page.setPd(pd);
		powerList = powerService.listPowerDaily(page);
		StringBuilder day = new StringBuilder();
		StringBuilder power = new StringBuilder();
		for(PageData pd1 : powerList)
		{
			day.append("'").append((String)pd1.get("day")).append("'").append(",");
			power.append((String)pd1.get("power")).append(",");
		
		}
		if (day.length()!=0) {
			
			String xz = day.deleteCharAt(day.length()-1).toString();
			String yz = power.deleteCharAt(power.length()-1).toString();
			pd.put("xz", xz);
			pd.put("yz", yz);
		
		}
		
	}	
	
	//所有查询按天
/*	private void searchAllbyDay(PageData pd, Page page, List<PageData> powerList) throws Exception {
		page.setPd(pd);
		powerList = powerService.listPowerDaily(page);
		StringBuilder day = new StringBuilder();
		StringBuilder power = new StringBuilder();
		for(PageData pd1 : powerList)
		{
			day.append("'").append((String)pd1.get("day")).append("'").append(",");
			power.append((String)pd1.get("power")).append(",");
		
		}
		if(day.length()>=1){
			String xz = day.deleteCharAt(day.length()-1).toString();
			String yz = power.deleteCharAt(power.length()-1).toString();
			pd.put("xz", xz);
			pd.put("yz", yz);
		}else {
			pd.put("xz", 0);
			pd.put("yz", 0);
		}
	}*/
		//查询分组,策略 按月
/*		private void searchGroupbyMonth(PageData pd, Page page, List<PageData> powerList) throws Exception {
			//抽取开始时间和结束时间
			//将开始时间改为：****-**-00
			//将结束时间改为：****-**-31
			
			String sTime = pd.getString("startTime");
			if(null !=sTime && !"".equals(sTime)){
				pd.put("sTime", sTime.trim().substring(0, 8) + "00");
			}
			String eTime = pd.getString("endTime");
			if(null !=eTime && !"".equals(eTime)){
				pd.put("eTime", eTime.trim().substring(0, 8) + "31");
			}
			
			page.setPd(pd);
			powerList = powerService.listPowerMonth(page);
			StringBuilder monthly = new StringBuilder();
			StringBuilder power = new StringBuilder();
			for(PageData pd1 : powerList)
			{
				monthly.append("'").append((String)pd1.get("monthly")).append("'").append(",");
				power.append((String)pd1.get("power")).append(",");
			
			}
			if(monthly.length()>=1){
				String xz = monthly.deleteCharAt(monthly.length()-1).toString();
				String yz = power.deleteCharAt(power.length()-1).toString();
				pd.put("xz", xz);
				pd.put("yz", yz);
			}else {
				pd.put("xz", 0);
				pd.put("yz", 0);
			}
		}*/



	
	
	
}
