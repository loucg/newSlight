package com.fh.controller.system.fhlog;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
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
import com.fh.hzy.util.LogUtils;
import com.fh.util.AppUtil;
import com.fh.util.ObjectExcelView;
import com.fh.util.PageData;
import com.fh.util.Jurisdiction;
import com.fh.service.system.fhlog.FHlogManager;

/** 
 * 说明：操作日志记录
 * 创建人：FH Q313596790
 * 创建时间：2016-05-10
 */
@Controller
@RequestMapping(value="/fhlog")
public class FHlogController extends BaseController {
	
	String menuUrl = "fhlog/list.do"; //菜单地址(权限用)
	@Resource(name="fhlogService")
	private FHlogManager fhlogService;
	
	/**删除
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value="/delete")
	public void delete(PrintWriter out) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"删除FHlog");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		fhlogService.delete(pd);
		out.write("success");
		out.close();
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表FHlog");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String lastStart = pd.getString("starttime");	//开始时间
		String lastEnd = pd.getString("endtime");		//结束时间
		if(lastStart != null && !"".equals(lastStart)){
			pd.put("lastStart", lastStart+" 00:00:00");
		}
		if(lastEnd != null && !"".equals(lastEnd)){
			pd.put("lastEnd", lastEnd+" 00:00:00");
		}
		page.setPd(pd);
		List<PageData>	varList = fhlogService.list(page);		//列出FHlog列表
		mv.setViewName("system/fhlog/fhlog_list");
		mv.addObject("varList", varList);
		mv.addObject("logtypeList", fhlogService.getLogTypeList(pd));
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());				//按钮权限
		return mv;
	}
	
	
	@RequestMapping(value="/deviceLogList")
	public ModelAndView deviceLogList(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表FHlog");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String lastStart = pd.getString("starttime");	//开始时间
		String lastEnd = pd.getString("endtime");		//结束时间
		if(lastStart != null && !"".equals(lastStart)){
			pd.put("lastStart", lastStart+" 00:00:00");
		}
		if(lastEnd != null && !"".equals(lastEnd)){
			pd.put("lastEnd", lastEnd+" 00:00:00");
		}
		page.setPd(pd);
		List<PageData>	varList = fhlogService.getDeviceLogList(page);		//列出FHlog列表
		mv.setViewName("system/fhlog/devicelog_list");
		mv.addObject("varList", varList);
		mv.addObject("logtypeList", fhlogService.getDeviceTypeList(pd));
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());				//按钮权限
		return mv;
	}
	
	 /**批量删除
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/deleteAll")
	@ResponseBody
	public Object deleteAll() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"批量删除FHlog");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			fhlogService.deleteAll(ArrayDATA_IDS);
			pd.put("msg", "ok");
		}else{
			pd.put("msg", "no");
		}
		pdList.add(pd);
		map.put("list", pdList);
		return AppUtil.returnObject(pd, map);
	}
	
	 /**导出到excel
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/excel")
	public ModelAndView exportExcel() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"导出FHlog到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("用户");	//1
		titles.add("操作时间");	//2
		titles.add("类型");  //3
		titles.add("内容");	//4
		dataMap.put("titles", titles);
		List<PageData> varOList = fhlogService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("name"));	    //1
			vpd.put("var2", varOList.get(i).getString("time"));	    //2
			vpd.put("var3", varOList.get(i).getString("type"));
			vpd.put("var4", varOList.get(i).getString("comment"));	    //3
			varList.add(vpd);
		}
		dataMap.put("varList", varList);
		ObjectExcelView erv = new ObjectExcelView();
		mv = new ModelAndView(erv,dataMap);
		return mv;
	}
	
	 /**导出到终端日志
		 * @param
		 * @throws Exception
		 */
		@RequestMapping(value="/excelDevice")
		public ModelAndView exportExcelDevice() throws Exception{
			logBefore(logger, Jurisdiction.getUsername()+"导出FHlog到excel");
			if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
			ModelAndView mv = new ModelAndView();
			PageData pd = new PageData();
			pd = this.getPageData();
			Map<String,Object> dataMap = new HashMap<String,Object>();
			List<String> titles = new ArrayList<String>();
			titles.add("用户");	//1
			titles.add("操作时间");	//2
			titles.add("命令类型");  //3
			titles.add("网关/断路器");	//4
			titles.add("灯/终端");	
			titles.add("内容");
			titles.add("状态");	
			titles.add("反馈时间");	
			dataMap.put("titles", titles);
			List<PageData> varOList = fhlogService.getAllDeviceList(pd);
			List<PageData> varList = new ArrayList<PageData>();
			for(int i=0;i<varOList.size();i++){
				PageData vpd = new PageData();
				vpd.put("var1", varOList.get(i).getString("name"));	    //1
				vpd.put("var2", varOList.get(i).getString("operate_time"));	    //2
				vpd.put("var3", varOList.get(i).getString("cmd_type"));
				vpd.put("var4", varOList.get(i).getString("gateway"));	    //3
				vpd.put("var5", varOList.get(i).getString("device"));
				vpd.put("var6", varOList.get(i).getString("comment"));
				vpd.put("var7", varOList.get(i).getString("status"));
				vpd.put("var8", varOList.get(i).getString("feedback_time"));
				varList.add(vpd);
			}
			dataMap.put("varList", varList);
			ObjectExcelView erv = new ObjectExcelView();
			mv = new ModelAndView(erv,dataMap);
			return mv;
		}
	
	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}
}
