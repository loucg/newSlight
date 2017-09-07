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
import com.fh.service.group.GroupService;
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
 * 组控操作
 */
@Controller
@RequestMapping(value="/grouplamp")
public class GroupLampController extends BaseController{

	String menuUrl = "grouplamp/listGroups2.do";		//页面配置的菜单地址
    @Resource(name="groupService")
    private GroupService groupService;
    @Resource(name="departmentService")
    private DepartmentManager departmentService;
    @Resource(name="lampStateService")
    private LampStateService lampStateService;
    @Resource(name="fhlogService")
	private FHlogManager fhlogService;
	
	/**
	 * 显示分组列表
	 * @param page
	 * @return
	 */
	@RequestMapping("/listGroups2")
	public ModelAndView listGroup(Page page) throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String name = pd.getString("name");			//检索条件：名称
		if(null !=name && !"".equals(name)){
			pd.put("name", name.trim());
		}
		String explain = pd.getString("explain");		//检索条件：说明项
		if(null !=explain && !"".equals(explain)){
			pd.put("explain", explain.trim());
		}
		//获得登录的用户id
		User user = (User)Jurisdiction.getSession().getAttribute(Const.SESSION_USER);
		String sys_user_id = user.getUSER_ID();
		pd.put("sys_user_id", sys_user_id);
		
		String userids = departmentService.getUseridsInDepartment(pd);
		pd.put("userids", userids);
		
		page.setPd(pd);
		List<PageData> groupList = groupService.listGroup(page);	//获取列表
		mv.setViewName("street/state/groupControl");
		mv.addObject("groupList", groupList);
		mv.addObject("pd", pd);
		mv.addObject("QX", Jurisdiction.getHC());
		
		return mv;
	}
	
	
	/**
	 * 去组控调节策略的页面
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
		mv.setViewName("street/state/group_strategy");
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
		
		mv.setViewName("street/state/strategy_edit");
		
		mv.addObject("msg", "adjustStr");
		mv.addObject("strategyList", strategyList);
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		
		return mv;
	}
	
	/**
	 * 保存策略
	 */
	@RequestMapping("/AdjustStr")
	public ModelAndView AdjustStr(Page page) throws Exception {
		//保存策略（修改c_term表中的b_strl_strategy_id字段）
		logBefore(logger, "group AdjustStr page");
		
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String str_id = pd.getString("str_id");
		System.out.println("str_id:"+str_id);
		page.setPd(pd);
			
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
			//日志的添加 2017-5-5
//			fhlogService.saveDeviceLog(UserUtils.getUserid(), "组控调节策略", ArrayDATA_IDS, null, CMDType.GROUP_STRATEGY, value);
			fhlogService.saveDeviceLog(UserUtils.getUserid(), "组控调节策略", ArrayDATA_IDS, null, CMDType.GROUP_STRATEGY, null);
		}else{
			System.out.println();
			System.out.println("mei you shu ju ");
		}
		return null;
	}
	
	/**
	 * 去组控调节亮度的页面
	 * @return
	 */
	@RequestMapping("/goAdjustBrt")
	public ModelAndView goAdjustBrt() throws Exception {
		logBefore(logger, "goAdjustBrt page");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		mv.setViewName("street/state/group_bright");
		mv.addObject("msg", "adjustBrt");
		mv.addObject("pd", pd);
		
		return mv;
	}
	
	/**
	 * 组控亮度调节页面的保存
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/adjustBrt")
	public ModelAndView adjustBrt() throws Exception{
		logBefore(logger, "be sure group adjustBrt");
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
			//日志的添加 2017-5-5
			//fhlogService.saveDeviceLog(userid, comment, deviceids, gatewayid, cmdType, value);
			fhlogService.saveDeviceLog(UserUtils.getUserid(), "组控调光", ArrayDATA_IDS, null, 10, pd.getString("brightness"));
			
		}else{
			System.out.println();
			System.out.println("mei you shu ju ");
		}
		
		
		
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	
	 /**组控开灯
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/groupopenLight")
	@ResponseBody
	public Object groupopenLight() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"--groupopenLight");
		
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		Date tdate = new Date();
		pd.put("tdate", tdate);
		String DATA_IDS = pd.getString("DATA_IDS");
		System.out.println(DATA_IDS);
		System.out.println();
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
			fhlogService.saveDeviceLog(UserUtils.getUserid(), "组控开灯", ArrayDATA_IDS, null, 9, "100");
		}else{
			pd.put("msg", "no");
		}
		
		
				
		pdList.add(pd);
		map.put("list", pdList);
		return AppUtil.returnObject(pd, map);
	}
	
	 /**组控关灯
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/groupoffLight")
	@ResponseBody
	public Object offLight() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"--groupoffLight");
		
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
			fhlogService.saveDeviceLog(UserUtils.getUserid(), "组控关灯", ArrayDATA_IDS, null, 9, "0");
			pd.put("msg", "ok");
		}else{
			pd.put("msg", "no");
		}
		
		pdList.add(pd);
		map.put("list", pdList);
		return AppUtil.returnObject(pd, map);
	}
	
}

