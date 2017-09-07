package com.fh.controller.analysis;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.hzy.util.LogType;
import com.fh.hzy.util.UserUtils;
import com.fh.service.analysis.fault.FaultanalysisManager;
import com.fh.service.fhoa.department.DepartmentManager;
import com.fh.service.system.fhlog.FHlogManager;
import com.fh.util.Jurisdiction;
import com.fh.util.ObjectExcelView;
import com.fh.util.PageData;

@Controller
@RequestMapping(value="/analysis")
public class FalutController extends BaseController{
	String menuUrl = "analysis/faultlist.do"; //菜单地址(权限用)
	@Resource(name="fhlogService")
	private FHlogManager FHLOG;
	@Resource(name="faultanalysisService")
	private FaultanalysisManager faultanalysisService;
	@Resource(name="departmentService")
	private DepartmentManager departmentService;
	
	/**故障列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/faultlist")
	public ModelAndView list(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"查看故障统计");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String groupname = pd.getString("groupname");					//组名
		if(null != groupname && !"".equals(groupname)){
			pd.put("groupname", groupname.trim());
		}
		String name = pd.getString("name");					//终端名称
		if(null != name && !"".equals(name)){
			pd.put("name", name.trim());
		}
		String number = pd.getString("number");					//终端编号
		if(null != number && !"".equals(number)){
			pd.put("number", number.trim());
		}
		String location = pd.getString("location");					//位置
		if(null != location && !"".equals(location)){
			pd.put("location", location.trim());
		}
		String type = pd.getString("type");					//故障类型
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
		List<PageData>	varList = faultanalysisService.list(page);	//列出Dictionaries列表
		if(pd.get("excel")!=null&&pd.getString("excel").equals("1")){
			ObjectExcelView erv = new ObjectExcelView();					//执行excel操作
			mv = new ModelAndView(erv,FaultUtils.exportFault(varList));
			FHLOG.save(UserUtils.getUserid(), "导出故障统计excel", LogType.getFaultexport());
			return mv;
		}else{
			mv.addObject("pd", pd);		//传入上级所有信息
			/*mv.addObject("companyid", companyid);			//上级ID
			mv.addObject("companyname", departmentService.findcompanyname(companyid));			//上级ID
	*/		mv.setViewName("analysis/falut_list");
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
