package com.fh.controller.system.collocation;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.hzy.util.LogType;
import com.fh.hzy.util.UserUtils;
import com.fh.service.system.collocation.CollocationManager;
import com.fh.service.system.fhlog.FHlogManager;
import com.fh.util.Jurisdiction;
import com.fh.util.PageData;

@Controller
@RequestMapping(value="/collocation")
public class CollocationController extends BaseController{
	String menuUrl = "collocation/list.do"; //菜单地址(权限用)
	@Resource(name="fhlogService")
	private FHlogManager FHLOG;
	@Resource(name="collocationService")
	private CollocationManager collocationService;
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"查看系统配置");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String functionkey = pd.getString("functionkey");					//检索条件
		if(null != functionkey && !"".equals(functionkey)){
			pd.put("functionkey", functionkey.trim());
		}
		String functiontype = pd.getString("functiontype");					//检索条件
		if(null != functiontype && !"".equals(functiontype)){
			pd.put("functiontype", functiontype.trim());
		}
		page.setPd(pd);
		List<PageData>	varList = collocationService.list(page);	//列出Dictionaries列表
		mv.addObject("pd", pd);		//传入上级所有信息
		/*mv.addObject("companyid", companyid);			//上级ID
		mv.addObject("companyname", departmentService.findcompanyname(companyid));			//上级ID
*/		mv.setViewName("system/collocation/collocation_list");
		mv.addObject("varList", varList);
		mv.addObject("QX",Jurisdiction.getHC());				//按钮权限
		/*mv.addObject("pd", departmentService.findById(pd));		//传入上级所有信息
		mv.addObject("DEPARTMENT_ID", DEPARTMENT_ID);			//上级ID
		mv.setViewName("fhoa/department/department_list");
		mv.addObject("varList", varList);
		mv.addObject("QX",Jurisdiction.getHC());				//按钮权限
*/		
		FHLOG.save(UserUtils.getUserid(), "查看配置", LogType.system);
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
			pd = collocationService.findById(pd);	//根据ID读取
			mv.addObject("pd", pd);					//放入视图容器
			mv.setViewName("system/collocation/collocation_edit");
			mv.addObject("msg", "edit");
			return mv;
		}

		/**修改
		 * @param
		 * @throws Exception
		 */
		@RequestMapping(value="/edit")
		public ModelAndView edit() throws Exception{
			logBefore(logger, Jurisdiction.getUsername()+"修改系统配置");
			if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
			ModelAndView mv = this.getModelAndView();
			PageData pd = new PageData();
			pd = this.getPageData();
			collocationService.edit(pd);
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
			mv.setViewName("system/collocation/collocation_edit");
			mv.addObject("msg", "save");
			return mv;
		}
		
		/**保存
		 * @param
		 * @throws Exception
		 */
		@RequestMapping(value="/save")
		public ModelAndView save() throws Exception{
			logBefore(logger, Jurisdiction.getUsername()+"新增系统配置");
			if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
			ModelAndView mv = this.getModelAndView();
			PageData pd = new PageData();
			pd = this.getPageData();
			int ID=0;
			PageData pd1 = collocationService.getid("1");
			if(pd1==null){
				ID=1;
			}
			else{
				ID=Integer.parseInt(pd1.get("ID").toString());
				ID=ID+1;
			}
			//ID=ID+1;
			pd.put("ID", ID);
			collocationService.save(pd);
			mv.addObject("msg","success");
			mv.setViewName("save_result");
			return mv;
		}
}
