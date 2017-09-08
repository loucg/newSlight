package com.fh.controller.strategy;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.crypto.hash.SimpleHash;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.entity.system.Department;
import com.fh.entity.system.Role;
import com.fh.entity.system.User;
import com.fh.entity.system.StrategyType;
import com.fh.service.fhoa.department.DepartmentManager;
import com.fh.service.system.fhlog.FHlogManager;
import com.fh.service.system.menu.MenuManager;
import com.fh.service.strategy.StrategyManager;
import com.fh.service.strategy.StrategyTypeManager;
import com.fh.service.system.user.UserManager;
import com.fh.util.AppUtil;
import com.fh.util.Const;
import com.fh.util.Jurisdiction;
import com.fh.util.PageData;


/** 
 * 类名称：StrategyController
 * 创建人：wap
 * 更新时间：2017年2月7日
 * @version
 */
@Controller
@RequestMapping(value="/strategy")
public class StrategyController extends BaseController {
	
	String menuUrl = "strategy/listStrategys.do"; //菜单地址(权限用)
	@Resource(name="userService")
	private UserManager userService;
	@Resource(name="menuService")
	private MenuManager menuService;
	@Resource(name="fhlogService")
	private FHlogManager FHLOG;
	@Resource(name="strategyService")
	private StrategyManager strategyService;
	@Resource(name="strategyTypeService")
	private StrategyTypeManager strategyTypeService;
	@Resource(name="departmentService")
	private DepartmentManager departmentService;
	

	/**显示策略列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/listStrategys")
	public ModelAndView listStrategys(Page page)throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String name = pd.getString("name");				//检索条件：策略名称
		if(null !=name && !"".equals(name)){
			pd.put("name", name.trim());
		}
		String explain = pd.getString("explain");		//检索条件：应用说明
		if(null !=explain && !"".equals(explain)){
			pd.put("explain", explain.trim());
		}
		String termid = pd.getString("termid");			//组状态画面过来时使用
		if(null !=explain && !"".equals(termid)){
			pd.put("termid", termid.trim());
		}
		
		String userids = departmentService.getUseridsInDepartment(pd);
        pd.put("userids", userids);
        
//		if(pd.getString("op")!=null && pd.getString("op").equals("add")) {
			//选择策略的时候只检索有效的策略
//			pd.put("status", "1");
//		}
		
		page.setPd(pd);
		List<PageData>	strategyList = strategyService.listStrategys(page);	//列出策略列表
		
		if(strategyList!=null) {
			for(int i=0; i<strategyList.size(); i++) {
				PageData strategyPd = strategyList.get(i);
				// C：30、40、30 T：40、60、0
				strategyPd = splitAdjustValue(strategyPd);
			}
		}
		
		
		mv.setViewName("strategy/strategy_list");
		mv.addObject("strategyList", strategyList);
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
	}
	
	/**去新增策略页面
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/goAddS")
	public ModelAndView goAddS()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		List<StrategyType> strategyTypeList = strategyTypeService.getStrategyTypeList(pd);		//列出策略类型列表
		
		mv.setViewName("strategy/strategy_edit");
		mv.addObject("msg", "saveS");
		mv.addObject("pd", pd);
		mv.addObject("strategyTypeList", strategyTypeList);
		return mv;
	}
	
	/**保存策略
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/saveS")
	public ModelAndView saveS() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增策略");
		
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		
		//获得登录的用户id
		User user = (User)Jurisdiction.getSession().getAttribute(Const.SESSION_USER);
		String sys_user_id = user.getUSER_ID();
		pd.put("B_USER_ID", sys_user_id);
		logBefore(logger, pd.getString("name")+pd.getString("explain")+pd.getString("type"));
		
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
		String TDATE = df.format(new Date());
		pd.put("TDATE", TDATE);				//创建时间
		
		String type_id = pd.getString("TYPE");
		pd.put("B_STRATEGY_TYPE_ID", type_id);				//策略类型
		
		String brightInput = pd.getString("BRIGHTINPUT");
		String bright = pd.getString("BRIGHT");
		
		if((bright==null || bright.isEmpty()) && brightInput!=null) {
			pd.put("BRIGHT", brightInput);		
		}	
		
		//System.out.println(pd);
		strategyService.addStrategy(pd);
		mv.addObject("msg","addSuccess");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**去修改策略页面
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/goEditS")
	public ModelAndView goEditS() throws Exception{
		logBefore(logger, "准备修改策略");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = strategyService.findById(pd);								//根据ID读取
		
		// C：30、40、30 T：40、60、0
		pd = splitAdjustValue(pd);
		List<StrategyType> strategyTypeList = strategyTypeService.getStrategyTypeList(pd);		//列出策略类型列表

		mv.setViewName("strategy/strategy_edit");
		mv.addObject("msg", "editS");
		mv.addObject("pd", pd);
		mv.addObject("strategyTypeList", strategyTypeList);
		return mv;
	}
			
	/**
	 * 修改策略
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/editS")
	public ModelAndView editS() throws Exception{
		logBefore(logger,"正在修改策略");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
				
		//获得登录的用户id
		User user = (User)Jurisdiction.getSession().getAttribute(Const.SESSION_USER);
		String sys_user_id = user.getUSER_ID();
		pd.put("B_USER_ID", sys_user_id);
		System.out.println(sys_user_id);
		
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
		String tdate = df.format(new Date());
		pd.put("TDATE", tdate);				//创建时间
		System.out.println(tdate);
		
		String brightInput = pd.getString("BRIGHTINPUT");
		String bright = pd.getString("BRIGHT");
		
		if((bright==null || bright.isEmpty()) && brightInput!=null) {
			pd.put("BRIGHT", brightInput);		
		}
		
		strategyService.edit(pd);	//执行修改
		mv.addObject("msg","editSuccess");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**删除策略
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/deleteS")
	@ResponseBody
	public Object deleteS() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"删除策略");
		
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		
		PageData pd = new PageData();
		pd = this.getPageData();
		logBefore(logger, pd.getString("strategy_ids"));		
		
		Page page = new Page(); 
		page.setPd(pd);
		strategyService.deleteStrategyByIds(page);

		Map<String,String> map = new HashMap<String,String>();
		map.put("result", "success");
		return AppUtil.returnObject(new PageData(), map);
	}
	
	/**把色光/冷暖调节值value拆分成value1,value2,value3
	 * @return
	 */
	private PageData splitAdjustValue(PageData pd) {
		// C：30、40、30 T：40、60、0
		String value = pd.getString("value");

		if(value!=null && value.length()>2) {
			value = value.substring(2);
			String[] valList = value.split("、");
			pd.put("value1", valList[0]);
			pd.put("value2", valList[1]);
			pd.put("value3", valList[2]);
		}
		
		return pd;
	}
	
		
	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}

}


