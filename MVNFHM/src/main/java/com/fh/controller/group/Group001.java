package com.fh.controller.group;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.entity.system.User;
import com.fh.service.fhoa.department.DepartmentManager;
import com.fh.service.group.GroupService;
import com.fh.util.Const;
import com.fh.util.Jurisdiction;
import com.fh.util.PageData;

/**
 * 菜单管理权限实验方法
 */
@Controller
@RequestMapping(value="/group001")
public class Group001 extends BaseController{

	String menuUrl = "group/listGroups001.do";		//页面配置的菜单地址
    @Resource(name="groupService")
    private GroupService groupService;
    @Resource(name="departmentService")
    private DepartmentManager departmentService;
	
	/**
	 * 显示分组列表
	 * @param page
	 * @return
	 */
	@RequestMapping("/listGroups001")
	public ModelAndView listGroup(Page page) throws Exception{
		System.out.println("");
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
		mv.setViewName("groupmanage/groupmanage_list");
		mv.addObject("groupList", groupList);
		mv.addObject("pd", pd);
		mv.addObject("QX", Jurisdiction.getHC());
		
		return mv;
	}
	
	/**
	 * 去新增分组页面
	 */
	@RequestMapping("/goAdd001")
	public ModelAndView goAdd() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		mv.setViewName("groupmanage/groupmanage_edit");
		mv.addObject("msg", "save");
		mv.addObject("pd", pd);
		return mv;
	}
	
	/**新增分组页面的保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save001")
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
		
		String userids = departmentService.getUseridsInDepartment(pd);
		pd.put("userids", userids);
		
		//logBefore(logger, pd.getString("name")+pd.getString("explain")+pd.getString("type"));
		groupService.addGroup(pd);
		
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**去编辑分组页面
	 * @return
	 */
	@RequestMapping("/goUpdate001")
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
	}
	
	/**编辑分组页面的保存
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/update001")
	public ModelAndView update() throws Exception{
		logBefore(logger, "be sure edit group");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		//获得登录的用户id
		User user = (User)Jurisdiction.getSession().getAttribute(Const.SESSION_USER);
		String sys_user_id = user.getUSER_ID();
		pd.put("sys_user_id", sys_user_id);
		
		String userids = departmentService.getUseridsInDepartment(pd);
		pd.put("userids", userids);
		
		logBefore(logger, pd.getString("name")+pd.getString("explain")+pd.getString("status"));
		groupService.updateGroup(pd);
		
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
}
