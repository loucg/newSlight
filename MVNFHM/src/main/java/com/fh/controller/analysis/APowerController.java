package com.fh.controller.analysis;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.hzy.util.LogType;
import com.fh.hzy.util.UserUtils;
import com.fh.service.analysis.power.PoweranalysisManager;
import com.fh.service.fhoa.department.DepartmentManager;
import com.fh.service.system.fhlog.FHlogManager;
import com.fh.util.Jurisdiction;
import com.fh.util.ObjectExcelView;
import com.fh.util.PageData;

@Controller
@RequestMapping(value="/poweranalysis")
public class APowerController extends BaseController{
	String menuUrl = "poweranalysis/powerlist.do"; //菜单地址(权限用)
	@Resource(name="fhlogService")
	private FHlogManager FHLOG;
	@Resource(name="analysispowerService")
	private PoweranalysisManager analysispowerService;
	@Resource(name="departmentService")
	private DepartmentManager departmentService;
	
	/**故障列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/powerlist")
	public ModelAndView list(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"查看能耗统计");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String groupname = pd.getString("groupname");					//组名
		if(null != groupname && !"".equals(groupname)){
			pd.put("groupname", groupname.trim());
		}
		String strategy = pd.getString("strategy");					//终端名称
		if(null != strategy && !"".equals(strategy)){
			pd.put("strategy", strategy.trim());
		}
		String type = pd.getString("type");					//终端编号
		if(null != type && !"".equals(type)){
			pd.put("type", type.trim());
		}
		String starttime = pd.getString("starttime");					//故障类型
		if(null != starttime && !"".equals(starttime)){
			pd.put("starttime", starttime.trim());
		}
		String endtime = pd.getString("endtime");					//故障类型
		if(null != endtime && !"".equals(endtime)){
			pd.put("endtime", endtime.trim());
		}
		String userids = departmentService.getUseridsInDepartment(pd);
        pd.put("userids", userids);
		if(type!=null&&type.equals("2")){
			Calendar cale = null;  
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			String firstday, lastday;  
	        // 获取前月的第一天  
	        cale = Calendar.getInstance();
			Date date = format.parse(starttime);
	        cale.setTime(date);
	        cale.add(Calendar.MONTH, 0);  
	        cale.set(Calendar.DAY_OF_MONTH, 1);  
	        firstday = format.format(cale.getTime());  
	        // 获取前月的最后一天  
	        cale = Calendar.getInstance(); 
	        Date date1 = format.parse(endtime);
	        cale.setTime(date1);
	        cale.add(Calendar.MONTH, 1);  
	        cale.set(Calendar.DAY_OF_MONTH, 0);  
	        lastday = format.format(cale.getTime());
			pd.put("starttime", firstday.trim());
			pd.put("endtime", lastday.trim());
		}
		if((null == starttime || "".equals(starttime))&&(null == endtime || "".equals(endtime))&&(type!=null&&type.equals("1")))
		{
			 Calendar cale = null;  
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			String firstday, lastday;  
	        // 获取前月的第一天  
	        cale = Calendar.getInstance();  
	        cale.add(Calendar.MONTH, 0);  
	        cale.set(Calendar.DAY_OF_MONTH, 1);  
	        firstday = format.format(cale.getTime());  
	        // 获取前月的最后一天  
	        cale = Calendar.getInstance();  
	        cale.add(Calendar.MONTH, 1);  
	        cale.set(Calendar.DAY_OF_MONTH, 0);  
	        lastday = format.format(cale.getTime());
	        pd.put("starttime", firstday.trim());
	        pd.put("endtime", lastday.trim());
		}
		if((null == starttime || "".equals(starttime))&&(null == endtime || "".equals(endtime))&&(null == type || "".equals(type)))
		{
			Calendar cale = null;  
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM");
			String firstday;  
	        // 获取前月的第一天  
	        cale = Calendar.getInstance();   
	        firstday = format.format(cale.getTime()); 
	        pd.put("starttime", firstday.trim());
	        pd.put("endtime", firstday.trim());
	        pd.put("type", "2");
		}
		page.setPd(pd);
		List<PageData>	varList = null ;
		if(type!=null&&type.equals("1")){
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");  
	        Calendar cal = Calendar.getInstance();    
	        cal.setTime(sdf.parse(pd.getString("starttime")));    
	        long time1 = cal.getTimeInMillis();                 
	        cal.setTime(sdf.parse(pd.getString("endtime")));    
	        long time2 = cal.getTimeInMillis();         
	        long between_days=(time2-time1)/(1000*3600*24);
	        if(Integer.parseInt(String.valueOf(between_days))>31){
	                Date date = sdf.parse(pd.getString("starttime"));
	                Calendar cl = Calendar.getInstance();
	                cl.setTime(date);
	                // cl.set(Calendar.DATE, day);
	                cl.add(Calendar.DATE, 31);
	                String temp = "";
	                temp = sdf.format(cl.getTime());
	                pd.put("endtime", temp);
	        }
			varList = analysispowerService.list(page);	//列出Dictionaries列表
		}
		else if((type!=null&&type.equals("2"))){
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	        Calendar c1 = Calendar.getInstance();
	        Calendar c2 = Calendar.getInstance();
	        c1.setTime(sdf.parse(pd.getString("starttime")));
	        c2.setTime(sdf.parse(pd.getString("endtime")));
	        int result1 = c2.get(Calendar.MONTH) - c1.get(Calendar.MONTH);
	        int result2 = c2.get(Calendar.YEAR) - c1.get(Calendar.YEAR);
	        int result = result2*12+result1;
	        if(result>13){
	        	Calendar c = Calendar.getInstance();//获得一个日历的实例
	            Date date = sdf.parse(pd.getString("starttime"));
	            c.setTime(date);//设置日历时间
	            c.add(Calendar.MONTH,13);//在日历的月份上增加6个月
	            String lasttime=sdf.format(c.getTime());
	            c = Calendar.getInstance(); 
		        Date date1 = sdf.parse(lasttime);
		        c.setTime(date1);
		        c.add(Calendar.MONTH, 1);  
		        c.set(Calendar.DAY_OF_MONTH, 0);  
		        lasttime = sdf.format(c.getTime());
	            pd.put("endtime", lasttime);
	        }
			varList = analysispowerService.monthlist(page);	//列出Dictionaries列表
		}
		else if((null == starttime || "".equals(starttime))&&(null == endtime || "".equals(endtime))&&(null == type || "".equals(type))){
			varList = analysispowerService.firstmonthlist(page);
			 Calendar cale = null;  
				SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
				String firstday, lastday;  
		        // 获取前月的第一天  
		        cale = Calendar.getInstance();  
		        cale.add(Calendar.MONTH, 0);  
		        cale.set(Calendar.DAY_OF_MONTH, 1);  
		        firstday = format.format(cale.getTime());  
		        // 获取前月的最后一天  
		        cale = Calendar.getInstance();  
		        cale.add(Calendar.MONTH, 1);  
		        cale.set(Calendar.DAY_OF_MONTH, 0);  
		        lastday = format.format(cale.getTime());
		        pd.put("starttime", firstday.trim());
		        pd.put("endtime", lastday.trim());
			
		}
		else if (null == type || "".equals(type)){
			varList = analysispowerService.monthlist(page);	//列出Dictionaries列表
		}
		if(pd.get("excel")!=null&&pd.getString("excel").equals("1")){
			ObjectExcelView erv = new ObjectExcelView();					//执行excel操作
			mv = new ModelAndView(erv,FaultUtils.exportPower(varList));
			FHLOG.save(UserUtils.getUserid(), "导出能耗统计excel", LogType.getPowerexport());
			return mv;
		}else{
			mv.addObject("pd", pd);		//传入上级所有信息
			/*mv.addObject("companyid", companyid);			//上级ID
			mv.addObject("companyname", departmentService.findcompanyname(companyid));			//上级ID
	*/		mv.setViewName("analysis/power_list");
			mv.addObject("varList", varList);
			mv.addObject("QX",Jurisdiction.getHC());				//按钮权限
			/*mv.addObject("pd", departmentService.findById(pd));		//传入上级所有信息
			mv.addObject("DEPARTMENT_ID", DEPARTMENT_ID);			//上级ID
			mv.setViewName("fhoa/department/department_list");
			mv.addObject("varList", varList);
			mv.addObject("QX",Jurisdiction.getHC());				//按钮权限
	*/		
			return mv;
		}
		
	}

}
