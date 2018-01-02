package com.fh.controller.system.smsplatform;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.entity.system.User;
import com.fh.service.system.smsplatform.SmsplatformManager;
import com.fh.service.system.status.StatusManager;
import com.fh.service.system.user.UserManager;
import com.fh.util.AppUtil;
import com.fh.util.Const;
import com.fh.util.Jurisdiction;
import com.fh.util.PageData;

/** 
 * 说明：站内信
 * 创建人：FH Q313596790
 * 创建时间：2016-01-17
 */
@Controller
@RequestMapping(value="/smsplatform")
public class SmsPlatformController extends BaseController {
	
	String menuUrl = "smsplatform/list.do"; //菜单地址(权限用)
	@Resource(name="smsplatformService")
	private SmsplatformManager smsplatformService;
	@Resource(name="statusService")
	private StatusManager statusService;
	@Resource(name = "userService")
	private UserManager userService;
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表smsplatform");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		page.setPd(pd);	
		List<PageData>	varList = smsplatformService.listAllSms(page);//列出Fhsms列表
		mv.setViewName("system/smsplatform/smsplatform_list");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());				//按钮权限
		return mv;
	}
	
	 /**去修改页面
		 * @param
		 * @throws Exception
		 */
		@RequestMapping(value="/goEdit")
		public ModelAndView goEdit()throws Exception{
			ModelAndView mv = this.getModelAndView();
			PageData pd = new PageData();
			pd = this.getPageData();
			String id = pd.getString("id");
			pd = smsplatformService.findBySmsId(pd);	//根据ID读取
			mv.addObject("pd", pd);		
			pd.put("id",id);	//放入视图容器
			mv.setViewName("system/smsplatform/smsplatform_edit");
			mv.addObject("msg", "edit");
			return mv;
		}
		
		/**修改
		 * @param
		 * @throws Exception
		 */
		@RequestMapping(value="/edit")
		public ModelAndView edit() throws Exception{
			logBefore(logger, Jurisdiction.getUsername()+"修改短信平台配置");
			if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
			ModelAndView mv = this.getModelAndView();
			PageData pd = new PageData();
			pd = this.getPageData();
			smsplatformService.editSms(pd);
			mv.addObject("msg","success");
			mv.setViewName("save_result");
			return mv;
		}
		
		/**去新增页面
		 * @param
		 * @throws Exception
		 */
		@RequestMapping(value="/goAdd")
		public ModelAndView goAdd()throws Exception{
			ModelAndView mv = this.getModelAndView();
			PageData pd = new PageData();
			pd = this.getPageData();
			mv.addObject("pd", pd);
			mv.setViewName("system/smsplatform/smsplatform_edit");
			mv.addObject("msg", "save");
			return mv;
		}
		
		/**
		 * 删除
		 * @param DEPARTMENT_ID
		 * @param
		 * @throws Exception 
		 */
		@RequestMapping(value="/delete")
		@ResponseBody
		public Object delete(@RequestParam String id) throws Exception{
			if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
			logBefore(logger, Jurisdiction.getUsername()+"删除短信配置平台");
			Map<String,String> map = new HashMap<String,String>();
			PageData pd = new PageData();
			pd.put("id", id);
			smsplatformService.delSms(pd);	//执行删除
			map.put("result", "success");
			return AppUtil.returnObject(new PageData(), map);
		}
		
		/**新增公司
		 * @param request
		 * @param file
		 * @param NAME
		 * @param LOGO_PATH
		 * @param ADDRESS
		 * @param CONTACTS
		 * @param TELEPHONE
		 * @param ISDISPLAYLOGO
		 * @param STATUS
		 * @return
		 * @throws Exception
		 */
		@RequestMapping(value="/save")
		public ModelAndView save(
				HttpServletRequest request,
				@RequestParam(value="NAME",required=false) String NAME,
				@RequestParam(value="CONTACT",required=false) String CONTACT,
				@RequestParam(value="B_NOTE_URL",required=false) String B_NOTE_URL,
				@RequestParam(value="STATUS",required=false) String STATUS
				) throws Exception{
			if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
			logBefore(logger, Jurisdiction.getUsername()+"新增公司");
			ModelAndView mv = this.getModelAndView();
			PageData pd = new PageData();
			pd = this.getPageData();
			if(Jurisdiction.buttonJurisdiction(menuUrl, "add")){
				pd.put("CONTACT", CONTACT);					//联系人
				pd.put("STATUS", STATUS);						//状态
				pd.put("NAME", NAME);						//名称
				pd.put("B_NOTE_URL", B_NOTE_URL);						//名称
				smsplatformService.saveSms(pd);				//执行修改数据库
			}
			mv.addObject("msg","success");
			mv.setViewName("save_result");
			return mv;
		}
		
		/**修改
		 * @param
		 * @throws Exception
		 */
		@RequestMapping(value="/goSmsSetting")
		public ModelAndView goSmsSetting(Page page) throws Exception{
			ModelAndView mv = this.getModelAndView();
			PageData pd = new PageData();
			pd = this.getPageData();
			page.setPd(pd);	
			List<PageData> destInfo = smsplatformService.findSmsDestById(page);	//根据ID读取
			mv.addObject("destInfo", destInfo);		
			mv.setViewName("system/smsplatform/sms_destination_list");
			mv.addObject("pd", pd);
			mv.addObject("QX",Jurisdiction.getHC());				//按钮权限
			return mv;
		}
		
		/**
		 * 删除
		 * @param DEPARTMENT_ID
		 * @param
		 * @throws Exception 
		 */
		@RequestMapping(value="/deleteSmsSetting")
		@ResponseBody
		public Object deleteSmsSetting(@RequestParam String id) throws Exception{
			if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
			logBefore(logger, Jurisdiction.getUsername()+"删除短信配置平台");
			Map<String,String> map = new HashMap<String,String>();
			PageData pd = new PageData();
			pd.put("id", id);
			smsplatformService.delDestination(pd);	//执行删除
			map.put("result", "success");
			return AppUtil.returnObject(new PageData(), map);
		}
		
		
		
	 /**去修改页面
		 * @param
		 * @throws Exception
		 */
		@RequestMapping(value="/goDestEdit")
		public ModelAndView goDestEdit()throws Exception{
			ModelAndView mv = this.getModelAndView();
			PageData pd = new PageData();
			pd = this.getPageData();
			pd = smsplatformService.findSmsSettingInfoById(pd);	//根据ID读取
			List<PageData> gatewayStatus = statusService.getGatewayStatus(pd);
			List<PageData> nodeStatus = statusService.getNodeStatus(pd);
			User user = (User) Jurisdiction.getSession().getAttribute(Const.SESSION_USER);
			pd.put("USER_ID", user.getUSER_ID());
			List<PageData> userList = userService.getUserIdAndNameInfo(pd);
			mv.addObject("pd", pd);
			mv.addObject("gatewayStatus", gatewayStatus);	
			mv.addObject("nodeStatus", nodeStatus);
			mv.addObject("userList", userList);	
			mv.setViewName("system/smsplatform/sms_dest_edit");
			mv.addObject("msg", "editDest");
			return mv;
		}
		
		/**去新增短信配置页面
		 * @param
		 * @throws Exception
		 */
		@RequestMapping(value="/goAddSmsSetting")
		public ModelAndView goAddSmsSetting()throws Exception{
			ModelAndView mv = this.getModelAndView();
			PageData pd = new PageData();
			pd = this.getPageData();
			pd.put("device_type", "1");
			List<PageData> gatewayStatus = statusService.getGatewayStatus(pd);
			List<PageData> nodeStatus = statusService.getNodeStatus(pd);
			User user = (User) Jurisdiction.getSession().getAttribute(Const.SESSION_USER);
			pd.put("USER_ID", user.getUSER_ID());
			List<PageData> userList = userService.getUserIdAndNameInfo(pd);
			mv.addObject("gatewayStatus", gatewayStatus);	
			mv.addObject("nodeStatus", nodeStatus);
			mv.addObject("userList", userList);	
			mv.addObject("pd", pd);
			mv.setViewName("system/smsplatform/sms_dest_edit");
			mv.addObject("msg", "saveDest");
			return mv;
		}
		/**修改
		 * @param
		 * @throws Exception
		 */
		@RequestMapping(value="/editDest")
		public ModelAndView editDest() throws Exception{
			logBefore(logger, Jurisdiction.getUsername()+"修改短信平台配置");
			if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
			ModelAndView mv = this.getModelAndView();
			PageData pd = new PageData();
			pd = this.getPageData();
			if ("1".equals(pd.get("device_type"))) {
				pd.put("fault_type", pd.get("gateway_fault_type"));
			} else if ("2".equals(pd.get("device_type"))) {
				pd.put("fault_type", pd.get("node_fault_type"));
			}
			smsplatformService.editSmsDest(pd);
			mv.addObject("msg","success");
			mv.setViewName("save_result");
			return mv;
		}
		/**新增公司
		 * @param request
		 * @param file
		 * @param NAME
		 * @param LOGO_PATH
		 * @param ADDRESS
		 * @param CONTACTS
		 * @param TELEPHONE
		 * @param ISDISPLAYLOGO
		 * @param STATUS
		 * @return
		 * @throws Exception
		 */
		@RequestMapping(value="/saveDest")
		public ModelAndView saveDest() throws Exception{
			if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
			logBefore(logger, Jurisdiction.getUsername()+"新增短信配置");
			ModelAndView mv = this.getModelAndView();
			PageData pd = new PageData();
			pd = this.getPageData();
			if ("1".equals(pd.get("device_type"))) {
				pd.put("fault_type", pd.get("gateway_fault_type"));
			} else if ("2".equals(pd.get("device_type"))) {
				pd.put("fault_type", pd.get("node_fault_type"));
			}
			String errInfo = "success";
			int count = smsplatformService.getSmsDestCount(pd);
			if (count == 0) {
				smsplatformService.insertDest(pd);				//执行修改数据库
			} else {
				errInfo = "addDuplicate";
			}
			mv.addObject("msg",errInfo);
			mv.setViewName("save_result");
			return mv;
		}
}
