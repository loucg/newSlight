package com.fh.controller.analysis;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.controller.slight.configure.ConfigureUtils;
import com.fh.entity.Page;
import com.fh.hzy.util.LogType;
import com.fh.hzy.util.UserUtils;
import com.fh.service.analysis.light.LightanalysisManager;
import com.fh.service.analysis.repair.RepairanalysisManager;
import com.fh.service.fhoa.department.DepartmentManager;
import com.fh.service.system.fhlog.FHlogManager;
import com.fh.util.Jurisdiction;
import com.fh.util.ObjectExcelView;
import com.fh.util.PageData;

@Controller
@RequestMapping(value="/lightanalysis")
public class LightController extends BaseController{
	String menuUrl = "lightanalysis/list.do"; //菜单地址(权限用)
	@Resource(name="fhlogService")
	private FHlogManager FHLOG;
	@Resource(name="lightanalysisService")
	private LightanalysisManager lightanalysisService;
	@Resource(name="departmentService")
	private DepartmentManager departmentService;
	
	/**故障列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"查看亮灯统计");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String groupname = pd.getString("groupname");					//检索条件
		if(null != groupname && !"".equals(groupname)){
			pd.put("groupname", groupname.trim());
		}
		String name = pd.getString("name");					//检索条件
		if(null != name && !"".equals(name)){
			pd.put("name", name.trim());
		}
		String number = pd.getString("number");					//检索条件
		if(null != number && !"".equals(number)){
			pd.put("number", number.trim());
		}
		String location = pd.getString("location");					//检索条件
		if(null != location && !"".equals(location)){
			pd.put("location", location.trim());
		}
		String starttime = pd.getString("starttime");					//故障类型
		if(null != starttime && !"".equals(starttime)){
			pd.put("starttime", starttime.trim());
		}
		String endtime = pd.getString("endtime");					//故障类型
		if(null != endtime && !"".equals(endtime)){
			pd.put("endtime", endtime.trim());
		}
		if((null == starttime || "".equals(starttime))&&(null == endtime || "".equals(endtime)))
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
		String userids = departmentService.getUseridsInDepartment(pd);
        pd.put("userids", userids);
		page.setPd(pd);
		List<PageData>	varList = lightanalysisService.list(page);	//列出Dictionaries列表
		if(pd.get("excel")!=null&&pd.getString("excel").equals("1")){
			ObjectExcelView erv = new ObjectExcelView();					//执行excel操作
			mv = new ModelAndView(erv,FaultUtils.exportLight(varList));
			FHLOG.save(UserUtils.getUserid(), "导出亮灯统计excel", LogType.lightexport);
			return mv;
		}else{
			mv.addObject("pd", pd);		//传入上级所有信息
			/*mv.addObject("companyid", companyid);			//上级ID
			mv.addObject("companyname", departmentService.findcompanyname(companyid));			//上级ID
	*/		mv.setViewName("analysis/light_list");
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
