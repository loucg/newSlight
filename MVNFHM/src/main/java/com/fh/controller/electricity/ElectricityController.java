package com.fh.controller.electricity;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.entity.system.User;
import com.fh.hzy.util.CMDType;
import com.fh.hzy.util.UserUtils;
import com.fh.service.electricity.ElectricityService;
import com.fh.service.system.fhlog.FHlogManager;
import com.fh.util.Const;
import com.fh.util.Jurisdiction;
import com.fh.util.PageData;

/**
 * 通电设置
 * @author xiaozhou
 * 创建时间： 2017年1月12日
 */
@Controller
@RequestMapping(value="/electricity")
public class ElectricityController extends BaseController{
	
	String menuUrl = "electricity/retrieve.do";  //页面配置的菜单地址
	@Resource(name="electricityService")
	private ElectricityService electricityService;
	@Resource(name="fhlogService")
	private FHlogManager fhlogService;
	
	/**
	 * 显示用户拥有的终端（单灯控制器、一体化电源、断路器、网关、普通断路器）
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/retrieve")
	public ModelAndView retrieve(Page page) throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String gateway_code = pd.getString("gateway_code");			//检索条件：终端编号
		if(null !=gateway_code && !"".equals(gateway_code)){
			pd.put("gateway_code", gateway_code.trim());
		}
		String name = pd.getString("name");				//检索条件
		if(null != name && !"".equals(name)){
			pd.put("name", name.trim());
		}
		//获得登录的用户id
		User user = (User)Jurisdiction.getSession().getAttribute(Const.SESSION_USER);
		String sys_user_id = user.getUSER_ID();
		pd.put("sys_user_id", sys_user_id);
		page.setPd(pd);
		List<PageData> electricityList = electricityService.listElectricity(page);  //列出终端列表
		mv.setViewName("electricity/electricity_list");
		mv.addObject("electricityList", electricityList);		//对应jsp页面内的名称
		mv.addObject("pd", pd);
		mv.addObject("QX", Jurisdiction.getHC());
		
		return mv;
	}
	/**
	 * 通电设置修改时间
	 * 去修改页面
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/goUpdate")
	public ModelAndView goUpdate() throws Exception {
		logBefore(logger, "goUpdate electricity page");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		
		pd = electricityService.findById(pd);
		System.out.println(pd.getString("name")+"name--------------------------地址"+pd.getString("location"));
		mv.setViewName("electricity/electricity_edit");
		mv.addObject("msg", "update");
		mv.addObject("pd", pd);
		
		return mv;
	}
	
	/**
	 * 确定修改
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/update")
	public ModelAndView update() throws Exception{
		logBefore(logger, "be sure edit electricity");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		//System.out.println(pd.getString("powerup"));
		//String userName = Jurisdiction.getUsername();
		//pd.put("b_user_id", userName);
		Date tdate = new Date();
		//获得登录的用户id
		User user = (User)Jurisdiction.getSession().getAttribute(Const.SESSION_USER);
		String sys_user_id = user.getUSER_ID();
		pd.put("sys_user_id", sys_user_id);
		pd.put("tdate", tdate);
		System.out.println(tdate);
		electricityService.update(pd);
		
		String powerup = pd.getString("powerup");
		if(powerup.length()==4){
			powerup = "0"+powerup;
		}
		String powerdown = pd.getString("powerdown");
		if(powerdown.length()==4){
			powerdown = "0"+powerdown;
		}
		String value = powerup.replace(":", "")+powerdown.replace(":", "");
		
		
		//日志的添加 2017-4-15 啊
		fhlogService.saveDeviceLog(UserUtils.getUserid(), "修改上电/断电时间", 
				null, pd.getString("id"), CMDType.CUTOFF_CONTROL, value);
		
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**
	 * 通电设置上电/断电
	 * 去修改页面(批量修改)
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/goSettime")
	public ModelAndView goSettime() throws Exception {
		logBefore(logger, "goSettime electricity page");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		/*String DATA_IDS = pd.getString("DATA_IDS");
		System.out.println();
		System.out.println(DATA_IDS);*/
		//pd = electricityService.findById(pd);
		mv.setViewName("electricity/electricity_settime");
		mv.addObject("msg", "settime");
		mv.addObject("pd", pd);
		
		return mv;
	}
	
	/**
	 * 确定(批量)修改
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/settime")
	public ModelAndView settime() throws Exception{
		logBefore(logger, "be sure settime electricity");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Date tdate = new Date();
		pd.put("tdate", tdate);
		//获得登录的用户id
		User user = (User)Jurisdiction.getSession().getAttribute(Const.SESSION_USER);
		String sys_user_id = user.getUSER_ID();
		pd.put("sys_user_id", sys_user_id);
		String DATA_IDS = pd.getString("DATA_IDS");
		String ArrayDATA_IDS[] = null;
		if(null !=DATA_IDS && !"".equals(DATA_IDS)){
			ArrayDATA_IDS = DATA_IDS.split(",");
			for(int i=0;i<ArrayDATA_IDS.length;i++){
				pd.put("id", ArrayDATA_IDS[i]);
				electricityService.update(pd);
				
				String powerup = pd.getString("powerup");
				if(powerup.length()==4){
					powerup = "0"+powerup;
				}
				String powerdown = pd.getString("powerdown");
				if(powerdown.length()==4){
					powerdown = "0"+powerdown;
				}
				String value = powerup.replace(":", "")+powerdown.replace(":", "");
				
				//日志的添加 2017-4-15
				fhlogService.saveDeviceLog(UserUtils.getUserid(), "批量修改上电/断电时间", 
						null, ArrayDATA_IDS[i], CMDType.CUTOFF_CONTROL, value);
				System.out.println();
			}
		}else{
			System.out.println();
			System.out.println("mei you shu ju ");
		}
		
		
		
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
}
