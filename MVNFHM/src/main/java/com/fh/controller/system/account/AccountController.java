package com.fh.controller.system.account;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
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
import com.fh.entity.system.Dictionaries;
import com.fh.entity.system.Language;
import com.fh.entity.system.Role;
import com.fh.entity.system.Status;
import com.fh.hzy.util.LogType;
import com.fh.hzy.util.UserUtils;
import com.fh.service.fhoa.department.DepartmentManager;
import com.fh.service.system.fhlog.FHlogManager;
import com.fh.service.system.language.LanguageManager;
import com.fh.service.system.menu.MenuManager;
import com.fh.service.system.role.RoleManager;
import com.fh.service.system.status.StatusManager;
import com.fh.service.system.user.UserManager;
import com.fh.util.AppUtil;
import com.fh.util.Const;
import com.fh.util.FileDownload;
import com.fh.util.FileUpload;
import com.fh.util.GetPinyin;
import com.fh.util.Jurisdiction;
import com.fh.util.ObjectExcelRead;
import com.fh.util.PageData;
import com.fh.util.ObjectExcelView;
import com.fh.util.PathUtil;
import com.fh.util.Tools;

/** 
 * 类名称：AccountController
 * 创建人：zjc
 * 更新时间：2017年1月25日
 * @version
 */
@Controller
@RequestMapping(value="/account")
public class AccountController extends BaseController {
	
	String menuUrl = "account/listAccounts.do"; //菜单地址(权限用)
	@Resource(name="userService")
	private UserManager userService;
	@Resource(name="roleService")
	private RoleManager roleService;
	@Resource(name="menuService")
	private MenuManager menuService;
	@Resource(name="fhlogService")
	private FHlogManager FHLOG;
	@Resource(name="languageService")
	private LanguageManager languageService;
	@Resource(name="statusService")
	private StatusManager statusService;
	@Resource(name="departmentService")
	private DepartmentManager departmentService;
	
	/**显示用户列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/listAccounts")
	public ModelAndView listAccounts(Page page)throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		page.setPd(pd);
		List<PageData> accountList = userService.listAccountsPage(page);	//列出帐号列表
		pd.put("ROLE_ID", "1");
		List<Role> roleList = roleService.listAllRolesByPId(pd);//列出所有系统用户角色
		List<Department> companyList = departmentService.listAllDepartmentsByPId(pd);//列出所有公司
		mv.setViewName("system/account/account_list");
		mv.addObject("accountList", accountList);
		mv.addObject("companyList", companyList);
		mv.addObject("roleList", roleList);
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
	}
	
	/**去修改帐号页面
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/goEditA")
	public ModelAndView goEditA() throws Exception{
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		if("1".equals(pd.getString("USER_ID"))){return null;}		//不能修改admin用户
		pd.put("ROLE_ID", "1");
		List<Role> roleList = roleService.listAllRolesByPId(pd);	//列出所有系统用户角色
		List<Language> languageList = languageService.listAllLanguagesByPId(pd);//列出所有语言
		List<Status> statusList = statusService.listAllAccountStatusById(pd);//列出所有状态
		List<Department> companyList = departmentService.listAllDepartmentsByPId(pd);//列出所有公司
		mv.addObject("fx", "user");
		pd = userService.findAccountById(pd);
		Integer companyid = (Integer) pd.get("COMPANY_ID");
		List<PageData> departmentList;
		if(companyid != null){
		    departmentList = departmentService.listselectdepartment(companyid.toString());//列出公司下所有部门
		}
		else{//若未选择公司
			departmentList = null;
		}
		mv.setViewName("system/account/account_edit");
		mv.addObject("msg", "editA");
		mv.addObject("pd", pd);
		mv.addObject("roleList", roleList);
		mv.addObject("companyList", companyList);
		mv.addObject("departmentList", departmentList);
		mv.addObject("languageList", languageList);
		mv.addObject("statusList", statusList);
		return mv;
	}
	
	/**去重置密码页面
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/goResetP")
	public ModelAndView goResetP() throws Exception{
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		if("1".equals(pd.getString("USER_ID"))){return null;}		//不能修改admin用户
		pd.put("ROLE_ID", "1");
		mv.addObject("fx", "user");
		pd = userService.findAccountById(pd);
		mv.setViewName("system/account/account_resetPassword");
		mv.addObject("msg", "resetP");
		mv.addObject("pd", pd);
		return mv;
	}
	
	/**
	 * 重置密码
	 */
	@RequestMapping(value="/resetP")
	public ModelAndView resetP() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"重置密码");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("PASSWORD", new SimpleHash("SHA-1", pd.getString("USERNAME"), "cba#321").toString());	//密码加密，初始密码为cba#321
		userService.resetP(pd);	//执行修改
		FHLOG.save(UserUtils.getUserid(), "重置密码："+pd.getString("USERNAME"), LogType.resetpassword);
		mv.addObject("msg","resetSuccess");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**
	 * 修改帐号
	 */
	@RequestMapping(value="/editA")
	public ModelAndView editA() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改ser");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		userService.editA(pd);	//执行账户修改
		userService.editAccountDP(pd);	//执行账户部门职务修改
		mv.addObject("msg","editSuccess");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**去新增用户页面
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/goAddA")
	public ModelAndView goAddA()throws Exception{
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("ROLE_ID", "1");
		List<Role> roleList = roleService.listAllRolesByPId(pd);//列出所有系统用户角色
		List<Language> languageList = languageService.listAllLanguagesByPId(pd);//列出所有语言
		List<Status> statusList = statusService.listAllAccountStatusById(pd);//列出所有状态
		List<Department> companyList = departmentService.listAllDepartmentsByPId(pd);//列出所有公司
		mv.setViewName("system/account/account_edit");
		mv.addObject("msg", "saveA");
		mv.addObject("pd", pd);
		mv.addObject("roleList", roleList);
		mv.addObject("languageList", languageList);
		mv.addObject("companyList", companyList);
		mv.addObject("statusList", statusList);
		return mv;
	}
	
	/**保存用户
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/saveA")
	public ModelAndView saveA() throws Exception{
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		logBefore(logger, Jurisdiction.getUsername()+"新增user");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("USER_ID", this.get32UUID());	//ID 主键
		pd.put("LAST_LOGIN", "");				//最后登录时间
		pd.put("IP", "");						//IP
		pd.put("BZ", "");						//备注
		pd.put("NUMBER", "");					//编号
		pd.put("SKIN", "default");
		pd.put("RIGHTS", "");		
		pd.put("PASSWORD", new SimpleHash("SHA-1", pd.getString("USERNAME"), "cba#321").toString());	//密码加密
		pd.put("DEPARTMENT_ID", "1");
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
		String TDATE = df.format(new Date());
		pd.put("TDATE", TDATE);				        //创建时间
		//if(null == userService.findByUsername(pd)){	//判断用户名是否存在
			userService.saveA(pd); 					//执行帐号保存
			userService.saveAccountDP(pd); 			//执行帐号职务保存
			mv.addObject("msg","addSuccess");
		//}else{
		//	mv.addObject("msg","failed");
		//}
		mv.setViewName("save_result");
		return mv;
	}
	
	/**判断用户名是否存在
	 * @return
	 */
	@RequestMapping(value="/hasU")
	@ResponseBody
	public Object hasU(){
		Map<String,String> map = new HashMap<String,String>();
		String errInfo = "success";
		PageData pd = new PageData();
		try{
			pd = this.getPageData();System.out.println(userService.findByUsername(pd));
			if(userService.findByUsername(pd) != null){
				errInfo = "error";
			}
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		map.put("result", errInfo);				//返回结果
		return AppUtil.returnObject(new PageData(), map);
	}
	
	/**判断邮箱是否存在
	 * @return
	 */
	@RequestMapping(value="/hasE")
	@ResponseBody
	public Object hasE(){
		Map<String,String> map = new HashMap<String,String>();
		String errInfo = "success";
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			if(userService.findByUE(pd) != null){
				errInfo = "error";
			}
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		map.put("result", errInfo);				//返回结果
		return AppUtil.returnObject(new PageData(), map);
	}
	
	/**判断编码是否存在
	 * @return
	 */
	@RequestMapping(value="/hasN")
	@ResponseBody
	public Object hasN(){
		Map<String,String> map = new HashMap<String,String>();
		String errInfo = "success";
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			if(userService.findByUN(pd) != null){
				errInfo = "error";
			}
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		map.put("result", errInfo);				//返回结果
		return AppUtil.returnObject(new PageData(), map);
	}
	
	/**去修改用户页面(个人修改)
	 * @return
	 * @throws Exception
	 */
	/*
	@RequestMapping(value="/editUserInfo")
	public ModelAndView goEditMyU() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		mv.addObject("fx", "head");
		pd.put("ROLE_ID", "1");
		List<Role> roleList = roleService.listAllRolesByPId(pd);	//列出所有系统用户角色
		pd.put("USERNAME", Jurisdiction.getUsername());
		pd = userService.findByUsername(pd);						//根据用户名读取
		mv.setViewName("system/user/user_edit");
		mv.addObject("msg", "editU");
		mv.addObject("pd", pd);
		mv.addObject("roleList", roleList);
		return mv;
	}
	*/
	/**查看用户
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/view")
	public ModelAndView view() throws Exception{
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		if("admin".equals(pd.getString("USERNAME"))){return null;}	//不能查看admin用户
		pd.put("ROLE_ID", "1");
		List<Role> roleList = roleService.listAllRolesByPId(pd);	//列出所有系统用户角色
		pd = userService.findByUsername(pd);						//根据ID读取
		mv.setViewName("system/user/user_view");
		mv.addObject("msg", "editU");
		mv.addObject("pd", pd);
		mv.addObject("roleList", roleList);
		return mv;
	}
	
	/**去修改用户页面(在线管理页面打开)
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/goEditUfromOnline")
	public ModelAndView goEditUfromOnline() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		if("admin".equals(pd.getString("USERNAME"))){return null;}	//不能查看admin用户
		pd.put("ROLE_ID", "1");
		List<Role> roleList = roleService.listAllRolesByPId(pd);	//列出所有系统用户角色
		pd = userService.findByUsername(pd);						//根据ID读取
		mv.setViewName("system/user/user_edit");
		mv.addObject("msg", "editU");
		mv.addObject("pd", pd);
		mv.addObject("roleList", roleList);
		return mv;
	}
	
	/**显示用户列表(弹窗选择用)
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/listUsersForWindow")
	public ModelAndView listUsersForWindow(Page page)throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		String lastLoginStart = pd.getString("lastLoginStart");	//开始时间
		String lastLoginEnd = pd.getString("lastLoginEnd");		//结束时间
		if(lastLoginStart != null && !"".equals(lastLoginStart)){
			pd.put("lastLoginStart", lastLoginStart+" 00:00:00");
		}
		if(lastLoginEnd != null && !"".equals(lastLoginEnd)){
			pd.put("lastLoginEnd", lastLoginEnd+" 00:00:00");
		} 
		page.setPd(pd);
		List<PageData>	userList = userService.listUsersBystaff(page);	//列出用户列表(弹窗选择用)
		pd.put("ROLE_ID", "1");
		List<Role> roleList = roleService.listAllRolesByPId(pd);//列出所有系统用户角色
		mv.setViewName("system/user/window_user_list");
		mv.addObject("userList", userList);
		mv.addObject("roleList", roleList);
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
	}
	
	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}
	
	/**获取连级数据
	 * @return
	 */
	@RequestMapping(value="/getLevels")
	@ResponseBody
	public Object getLevels(){
		Map<String,Object> map = new HashMap<String,Object>();
		String errInfo = "success";
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			String COMPANY_ID = pd.getString("COMPANY_ID");
			COMPANY_ID = Tools.isEmpty(COMPANY_ID)?"0":COMPANY_ID;
			List<PageData>	departmentList = departmentService.listselectdepartment(COMPANY_ID); //用传过来的ID获取此ID下的子列表数据
			map.put("list", departmentList);	
		} catch(Exception e){
			errInfo = "error";
			logger.error(e.toString(), e);
		}
		map.put("result", errInfo);				//返回结果
		return AppUtil.returnObject(new PageData(), map);
	}
	
}