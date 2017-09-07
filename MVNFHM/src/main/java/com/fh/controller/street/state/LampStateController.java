package com.fh.controller.street.state;

import java.util.ArrayList;
import java.util.Date;
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
import com.fh.entity.system.User;
import com.fh.hzy.util.CMDType;
import com.fh.hzy.util.UserUtils;
import com.fh.service.fhoa.department.DepartmentManager;
import com.fh.service.street.state.LampStateService;
import com.fh.service.system.fhlog.FHlogManager;
import com.fh.util.AppUtil;
import com.fh.util.Const;
import com.fh.util.Jurisdiction;
import com.fh.util.PageData;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

/**
 * 路灯状态-路灯状态列表
 * @author xiaozhou
 * 创建时间：2017年2月17日
 */
@Controller
@RequestMapping(value="/state/lamp")
public class LampStateController extends BaseController{

	String menuUrl = "state/lamp/listLamps.do";		//页面配置的菜单地址
    @Resource(name="lampStateService")
    private LampStateService lampStateService;
    @Resource(name="departmentService")
    private DepartmentManager departmentService;
    @Resource(name="fhlogService")
	private FHlogManager fhlogService;
    
	
	/**
	 * 显示路灯状态列表
	 * @param page
	 * @return
	 */
	@RequestMapping("/listLamps")
	public ModelAndView listLamps(Page page) throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		//PageData lampstatus = new PageData();
		pd = this.getPageData();
		String tname = pd.getString("tname");			//检索条件：组名
		if(null !=tname && !"".equals(tname)){
			pd.put("tname", tname.trim());
		}
		String cname = pd.getString("cname");		//检索条件：名称
		if(null !=cname && !"".equals(cname)){
			pd.put("cname", cname.trim());
		}
		String ccode = pd.getString("ccode");		//检索条件：编号
		if(null !=ccode && !"".equals(ccode)){
			pd.put("ccode", ccode.trim());
		}
		String location = pd.getString("location");		//检索条件：位置
		if(null !=location && !"".equals(location)){
			pd.put("location", location.trim());
		}
		String lstatus = pd.getString("lstatus");		//检索条件：状态
		if(null !=lstatus && !"".equals(lstatus)){
			//lampstatus = lampStateService.getStatus(pd);
			//lstatus = lampstatus.getString("name");
			pd.put("lstatus", lstatus.trim());
		}
		//获得登录的用户id
		User user = (User)Jurisdiction.getSession().getAttribute(Const.SESSION_USER);
		String sys_user_id = user.getUSER_ID();
		pd.put("sys_user_id", sys_user_id);
		
		String userids = departmentService.getUseridsInDepartment(pd);
		pd.put("userids", userids);
		
		page.setPd(pd);
		List<PageData> lampStateList = lampStateService.listLampState(page);	//获取列表
		mv.setViewName("street/state/lampstate_list");
		mv.addObject("lampStateList", lampStateList);
		mv.addObject("pd", pd);
		mv.addObject("QX", Jurisdiction.getHC());
		
		
		System.out.println(lampStateList);
		
        
        
		return mv;
	}
	
	/**
	 * 去灯的详细信息界面
	 */
	
	@RequestMapping("/goViewDetail")
	public ModelAndView goViewDetail() throws Exception {
		logBefore(logger, "goViewDetail");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		//获得登录的用户id
		User user = (User)Jurisdiction.getSession().getAttribute(Const.SESSION_USER);
		String sys_user_id = user.getUSER_ID();
		pd.put("sys_user_id", sys_user_id);
		
		String userids = departmentService.getUseridsInDepartment(pd);
		pd.put("userids", userids);
		//System.out.println(userids);
		pd = lampStateService.viewLampDetail(pd);
		mv.setViewName("street/state/lampstate_view");
		//mv.addObject("msg", "update");
		mv.addObject("pd", pd);
		
		return mv;
	}
	
	/**
	 * 去调节策略的页面
	 * @return
	 */
	@RequestMapping("/goAdjustStr")
	public ModelAndView goAdjustStr(Page page) throws Exception {
		logBefore(logger, "goAdjustStr page");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		page.setPd(pd);
		//获取策略并解析
		/*List<PageData>	strategyList = lampStateService.getStrategy(page);	//列出策略列表
		JsonParser parse =new JsonParser();                                 //创建json解析器
		for(int i = 0 ; i < strategyList.size(); i++){
			List<Object> t_i = new ArrayList<Object>();
			List<String> timestamp = new ArrayList<String>();
			List<String> intensity = new ArrayList<String>();
			if(strategyList.get(i).getString("json") != null && !strategyList.get(i).getString("json").equals("")){
				JsonObject json=(JsonObject) parse.parse(strategyList.get(i).getString("json"));
				strategyList.get(i).put("odd_even", json.get("odd_even").getAsString());
				JsonArray temp = json.get("t_i").getAsJsonArray();
				for(int j = 0; j < temp.size(); j++){
					t_i.add(temp.get(j).getAsJsonObject());
					timestamp.add(temp.get(j).getAsJsonObject().get("timestamp").getAsString());
					intensity.add(temp.get(j).getAsJsonObject().get("intensity").getAsString());
				}	
			}
			strategyList.get(i).put("t_i", t_i);
			strategyList.get(i).put("timestamp", timestamp);
			strategyList.get(i).put("intensity", intensity);
		}
        System.out.println(strategyList);*/
        
		System.out.println(pd.getString("DATA_IDS"));
		pd.put("DATA_IDS", pd.getString("DATA_IDS"));
		mv.setViewName("street/state/strategy_edit");
		mv.addObject("msg", "adjustStr");
		//mv.addObject("strategyList", strategyList);
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		
		return mv;
	}
	
	/**ajax获取策略数据
	 * @return
	 */
	@RequestMapping(value="/getLevels")
	@ResponseBody
	public Object getLevels(Page page){
		Map<String,Object> map = new HashMap<String,Object>();
		String errInfo = "success";
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			//String DICTIONARIES_ID = pd.getString("DICTIONARIES_ID");
			//DICTIONARIES_ID = Tools.isEmpty(DICTIONARIES_ID)?"0":DICTIONARIES_ID;
			List<PageData>	strList = lampStateService.getStrategy(page); //获取策略列表
			List<PageData> pdList = new ArrayList<PageData>();
			for(PageData d :strList){
				PageData pdf = new PageData();
				pdf.put("str_id", d.get("id"));
				pdf.put("str_name", d.get("name"));
				pdList.add(pdf);
			}
			map.put("list", pdList);	
		} catch(Exception e){
			errInfo = "error";
			logger.error(e.toString(), e);
		}
		map.put("result", errInfo);				//返回结果
		return AppUtil.returnObject(new PageData(), map);
	}
	
	
	//加载时间和亮度
	@RequestMapping("/adjustStr")
	public ModelAndView getStrs(Page page) throws Exception {
		logBefore(logger, "adjustStr page");
		
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String str_id = pd.getString("str_id");
		System.out.println("str_id:"+str_id);
		page.setPd(pd);
		//获取策略并解析
		List<PageData> strategyList = new ArrayList<PageData>();
		String value = "";
		try {
			strategyList = lampStateService.getStrategy(page);
			pd.put("str_name", strategyList.get(0).getString("name"));
			//列出策略列表
			
			JsonParser parse =new JsonParser();                                 //创建json解析器
			for(int i = 0 ; i < strategyList.size(); i++){
				List<Object> t_i = new ArrayList<Object>();
				List<String> timestamp = new ArrayList<String>();
				List<String> intensity = new ArrayList<String>();
				if(strategyList.get(i).getString("json") != null && !strategyList.get(i).getString("json").equals("")){
					JsonObject json=(JsonObject) parse.parse(strategyList.get(i).getString("json"));
					strategyList.get(i).put("odd_even", json.get("odd_even").getAsString());
					JsonArray temp = json.get("t_i").getAsJsonArray();
					for(int j = 0; j < temp.size(); j++){
						t_i.add(temp.get(j).getAsJsonObject());
						timestamp.add(temp.get(j).getAsJsonObject().get("timestamp").getAsString());
						intensity.add(temp.get(j).getAsJsonObject().get("intensity").getAsString());
						
						String times = temp.get(j).getAsJsonObject().get("timestamp").getAsString();
						String inten = temp.get(j).getAsJsonObject().get("intensity").getAsString();
						if(times.length()==4){
							times = "0"+times; }
						times = times.replace(":", "");
						value += times+":"+ inten+"、";
						
					}	
				}
				strategyList.get(i).put("t_i", t_i);
				strategyList.get(i).put("timestamp", timestamp);
				strategyList.get(i).put("intensity", intensity);
				
				
			}
			System.out.println("---------------------"+strategyList);
		} catch (Exception e) {
			
			e.printStackTrace();
		}
		value = value.substring(0, value.length()-1);
		System.out.println(value);
		//{"odd_even":"1","t_i":[{"timestamp":"1:03","intensity":"20"},{"timestamp":"1:04","intensity":"20"}]}
		
		//保存策略（修改c_term表中的b_strl_strategy_id字段）
		User user = (User)Jurisdiction.getSession().getAttribute(Const.SESSION_USER);
		String sys_user_id = user.getUSER_ID();
		pd.put("sys_user_id", sys_user_id);
		
		String userids = departmentService.getUseridsInDepartment(pd);
		pd.put("userids", userids);
		
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null !=DATA_IDS && !"".equals(DATA_IDS)){
			String[] ArrayDATA_IDS = DATA_IDS.split(";");
			for(int i=0;i<ArrayDATA_IDS.length;i++){
				pd.put("id", ArrayDATA_IDS[i]);
				lampStateService.upTermStrid(pd);
			}
			//日志的添加 2017-4-15 啊
			fhlogService.saveDeviceLog(UserUtils.getUserid(), "调节策略", ArrayDATA_IDS, null, CMDType.STRATEGY, value);
		}else{
			System.out.println();
			System.out.println("mei you shu ju ");
		}
		
		
		mv.setViewName("street/state/strategy_edit");
		
		mv.addObject("msg", "adjustStr");
		mv.addObject("strategyList", strategyList);
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		
		return mv;
	}
	
	/**
	 * 去调节亮度的页面
	 * @return
	 */
	@RequestMapping("/goAdjustBrt")
	public ModelAndView goAdjustBrt() throws Exception {
		logBefore(logger, "goAdjustBrt page");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		mv.setViewName("street/state/lampstate_bright");
		mv.addObject("msg", "adjustBrt");
		mv.addObject("pd", pd);
		
		return mv;
	}
	
	/**
	 * 亮度调节页面的保存
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/adjustBrt")
	public ModelAndView adjustBrt() throws Exception{
		logBefore(logger, "be sure adjustBrt");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Date tdate = new Date();
		pd.put("tdate", tdate);
		//获得登录的用户id
		User user = (User)Jurisdiction.getSession().getAttribute(Const.SESSION_USER);
		String sys_user_id = user.getUSER_ID();
		pd.put("sys_user_id", sys_user_id);
		
		String userids = departmentService.getUseridsInDepartment(pd);
		pd.put("userids", userids);
		
		String DATA_IDS = pd.getString("DATA_IDS");
		
		if(null !=DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(";");
			for(int i=0;i<ArrayDATA_IDS.length;i++){
				pd.put("id", ArrayDATA_IDS[i]);
				lampStateService.adjustBrt(pd);
			}
			System.out.println(DATA_IDS);
			System.out.println(ArrayDATA_IDS.toString());
			//日志的添加 2017-4-15
			//fhlogService.saveDeviceLog(userid, comment, deviceids, gatewayid, cmdType, value);
			fhlogService.saveDeviceLog(UserUtils.getUserid(), "调节亮度", ArrayDATA_IDS, null, 7, pd.getString("brightness"));
			
		}else{
			System.out.println();
			System.out.println("mei you shu ju ");
		}
		
		
		
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	
	 /**开灯
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/openLight")
	@ResponseBody
	public Object openLight() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"--openLight");
		
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		Date tdate = new Date();
		pd.put("tdate", tdate);
		String DATA_IDS = pd.getString("DATA_IDS");
		System.out.println(DATA_IDS);
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(";");
			for(int i=0;i<ArrayDATA_IDS.length;i++){
				pd.put("id", ArrayDATA_IDS[i]);
				pd.put("brightness", "100");
				System.out.println(ArrayDATA_IDS[i]);
				lampStateService.adjustBrt(pd);
			}
			pd.put("msg", "ok");
			System.out.println(ArrayDATA_IDS);
			//日志的添加 2017-4-15
			fhlogService.saveDeviceLog(UserUtils.getUserid(), "开灯", ArrayDATA_IDS, null, 6, "100");
		}else{
			pd.put("msg", "no");
		}
		
		
				
		pdList.add(pd);
		map.put("list", pdList);
		return AppUtil.returnObject(pd, map);
	}
	
	 /**关灯
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/offLight")
	@ResponseBody
	public Object offLight() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"--offLight");
		
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		Date tdate = new Date();
		pd.put("tdate", tdate);
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(";");
			for(int i=0;i<ArrayDATA_IDS.length;i++){
				pd.put("id", ArrayDATA_IDS[i]);
				pd.put("brightness", "0");
				lampStateService.adjustBrt(pd);
			}
			//日志的添加 2017-4-15
			fhlogService.saveDeviceLog(UserUtils.getUserid(), "关灯", ArrayDATA_IDS, null, 6, "0");
			pd.put("msg", "ok");
		}else{
			pd.put("msg", "no");
		}
		
		pdList.add(pd);
		map.put("list", pdList);
		return AppUtil.returnObject(pd, map);
	}

	
	/**
	 * 去新增分组页面
	 */
/*	@RequestMapping("/goAdd")
	public ModelAndView goAdd() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		mv.setViewName("groupmanage/groupmanage_edit");
		mv.addObject("msg", "save");
		mv.addObject("pd", pd);
		return mv;
	}*/
	
	/**新增分组页面的保存
	 * @param
	 * @throws Exception
	 */
/*	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增group");
		
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		//获得登录的用户id
		User user = (User)Jurisdiction.getSession().getAttribute(Const.SESSION_USER);
		String sys_user_id = user.getUSER_ID();
		pd.put("sys_user_id", sys_user_id);
		//logBefore(logger, pd.getString("name")+pd.getString("explain")+pd.getString("type"));
		groupService.addGroup(pd);
		
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}*/
	
	/**去编辑分组页面
	 * @return
	 */
/*	@RequestMapping("/goUpdate")
	public ModelAndView goUpdate() throws Exception {
		logBefore(logger, "goUpdate group page");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		
		pd = groupService.findById(pd);
		mv.setViewName("groupmanage/groupmanage_edit");
		mv.addObject("msg", "update");
		mv.addObject("pd", pd);
		
		return mv;
	}*/
	
	/**编辑分组页面的保存
	 * @return
	 * @throws Exception
	 */
/*	@RequestMapping("/update")
	public ModelAndView update() throws Exception{
		logBefore(logger, "be sure edit group");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		//获得登录的用户id
		User user = (User)Jurisdiction.getSession().getAttribute(Const.SESSION_USER);
		String sys_user_id = user.getUSER_ID();
		pd.put("sys_user_id", sys_user_id);
		logBefore(logger, pd.getString("name")+pd.getString("explain")+pd.getString("status"));
		groupService.updateGroup(pd);
		
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}*/
	
}
