package com.fh.controller.fhoa.department;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.util.AppUtil;
import com.fh.util.Const;
import com.fh.util.DateUtil;
import com.fh.util.DelAllFile;
import com.fh.util.FileUpload;
import com.fh.util.PageData;
import com.fh.util.PathUtil;
import com.fh.util.Jurisdiction;
import com.fh.service.fhoa.department.DepartmentManager;
import com.fh.service.system.fhlog.FHlogManager;

/** 
 * 说明：组织机构
 * 创建人：FH Q313596790
 * 创建时间：2015-12-16
 */
@Controller
@RequestMapping(value="/department")
public class DepartmentController extends BaseController {
	
	String menuUrl = "department/list.do"; //菜单地址(权限用)
	@Resource(name="departmentService")
	private DepartmentManager departmentService;
	@Resource(name="fhlogService")
	private FHlogManager FHLOG;
	
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增department");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		int ID=0;
		//String companyid = pd.getString("companyid");
		//pd.put("DEPARTMENT_ID", this.get32UUID());	//主键
		PageData pd1 = departmentService.getid("1");
		if(pd1==null){
			ID=1;
		}
		else{
			ID=Integer.parseInt(pd1.get("ID").toString());
			ID=ID+1;
		}
		//ID=ID+1;
		pd.put("ID", ID);
		departmentService.save(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
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
	public Object delete(@RequestParam String DEPARTMENT_ID) throws Exception{
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		logBefore(logger, Jurisdiction.getUsername()+"删除department");
		Map<String,String> map = new HashMap<String,String>();
		PageData pd = new PageData();
		pd.put("DEPARTMENT_ID", DEPARTMENT_ID);
		String errInfo = "success";
		if(departmentService.listSubDepartmentByParentId(DEPARTMENT_ID).size() > 0){//判断是否有子级，是：不允许删除
			errInfo = "false";
		}else{
			departmentService.delete(pd);	//执行删除
		}
		map.put("result", errInfo);
		return AppUtil.returnObject(new PageData(), map);
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改department");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		departmentService.edit(pd);
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
	@RequestMapping(value="/savecompany")
	public ModelAndView savecompany(
			HttpServletRequest request,
			@RequestParam(value="tp",required=false) MultipartFile file,
			@RequestParam(value="NAME",required=false) String NAME,
			@RequestParam(value="LOGO_PATH",required=false) String LOGO_PATH,
			@RequestParam(value="ADDRESS",required=false) String ADDRESS,
			@RequestParam(value="CONTACTS",required=false) String CONTACTS,
			@RequestParam(value="TELEPHONE",required=false) String TELEPHONE,
			@RequestParam(value="ISDISPLAYLOGO",required=false) String ISDISPLAYLOGO,
			@RequestParam(value="STATUS",required=false) String STATUS
			) throws Exception{
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		logBefore(logger, Jurisdiction.getUsername()+"新增公司");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		if(Jurisdiction.buttonJurisdiction(menuUrl, "add")){
			pd.put("ADDRESS", ADDRESS);		//地址
			pd.put("CONTACTS", CONTACTS);					//联系人
			pd.put("TELEPHONE", TELEPHONE);			//手机号码
			pd.put("ISDISPLAYLOGO", ISDISPLAYLOGO);						//是否显示图片
			pd.put("STATUS", STATUS);						//状态
			int ID=0;
			//String companyid = pd.getString("companyid");
			//pd.put("DEPARTMENT_ID", this.get32UUID());	//主键
			PageData pd1 = departmentService.getcompanyid("1");
			if(pd1==null){
				ID=1;
			}
			else{
				ID=Integer.parseInt(pd1.get("ID").toString());
				ID=ID+1;
			}
			//ID=ID+1;
			pd.put("ID", ID);
			pd.put("NAME", NAME);						//名称
			if(null == LOGO_PATH){LOGO_PATH = "";}
			String  ffile = DateUtil.getDays(), fileName = "";
			if (null != file && !file.isEmpty()) {
				String filePath = PathUtil.getClasspath() + Const.FILEPATHIMG + ffile;	//文件上传路径
				fileName = FileUpload.fileUp(file, filePath, this.get32UUID());			//执行上传
				pd.put("LOGO_PATH", ffile + "/" + fileName);									//路径
				//pd.put("NAME", fileName);
			}else{
				pd.put("LOGO_PATH", LOGO_PATH);
			}
			//Watermark.setWatemark(PathUtil.getClasspath() + Const.FILEPATHIMG + ffile + "/" + fileName);//加水印
			departmentService.addcompany(pd);				//执行修改数据库
		}
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**修改公司
	 * @param request
	 * @param file
	 * @param ID
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
	@RequestMapping(value="/companyedit")
	public ModelAndView companyedit(
			HttpServletRequest request,
			@RequestParam(value="tp",required=false) MultipartFile file,
			@RequestParam(value="ID",required=false) String ID,
			@RequestParam(value="NAME",required=false) String NAME,
			@RequestParam(value="LOGO_PATH",required=false) String LOGO_PATH,
			@RequestParam(value="ADDRESS",required=false) String ADDRESS,
			@RequestParam(value="CONTACTS",required=false) String CONTACTS,
			@RequestParam(value="TELEPHONE",required=false) String TELEPHONE,
			@RequestParam(value="ISDISPLAYLOGO",required=false) String ISDISPLAYLOGO,
			@RequestParam(value="STATUS",required=false) String STATUS
			) throws Exception{
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		logBefore(logger, Jurisdiction.getUsername()+"修改公司");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		if(Jurisdiction.buttonJurisdiction(menuUrl, "edit")){
			pd.put("ADDRESS", ADDRESS);		//地址
			pd.put("CONTACTS", CONTACTS);					//联系人
			pd.put("TELEPHONE", TELEPHONE);			//手机号码
			pd.put("ISDISPLAYLOGO", ISDISPLAYLOGO);						//是否显示图片
			pd.put("STATUS", STATUS);						//状态
			pd.put("ID", ID);						//ID
			pd.put("NAME", NAME);						//名称
			if(null == LOGO_PATH){LOGO_PATH = "";}
			String  ffile = DateUtil.getDays(), fileName = "";
			if (null != file && !file.isEmpty()) {
				String filePath = PathUtil.getClasspath() + Const.FILEPATHIMG + ffile;	//文件上传路径
				fileName = FileUpload.fileUp(file, filePath, this.get32UUID());			//执行上传
				pd.put("LOGO_PATH", ffile + "/" + fileName);									//路径
				//pd.put("NAME", fileName);
			}else{
				pd.put("LOGO_PATH", LOGO_PATH);
			}
			//Watermark.setWatemark(PathUtil.getClasspath() + Const.FILEPATHIMG + ffile + "/" + fileName);//加水印
			departmentService.editcompany(pd);				//执行修改数据库
		}
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表department");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String companyid = pd.getString("companyid");					//检索条件
		if(null != companyid && !"".equals(companyid)){
			pd.put("companyid", companyid.trim());
		}
		page.setPd(pd);
		List<PageData>	varList = departmentService.list(page);	//列出Dictionaries列表
		 for(PageData tmp:varList){
	            if(tmp.get("SUPERIOR_DEPARTMENT_ID")!=""||tmp.get("SUPERIOR_DEPARTMENT_ID")!=null){
	            	String parent = departmentService.searchparentname(tmp.get("SUPERIOR_DEPARTMENT_ID"));
	            	tmp.put("parentname", parent);
	            }
	        }
		mv.addObject("pd", pd);		//传入上级所有信息
		mv.addObject("companyid", companyid);			//上级ID
		mv.addObject("companyname", departmentService.findcompanyname(companyid));			//上级ID
		mv.setViewName("fhoa/department/department_list");
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
	
	/**公司列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/companylist")
	public ModelAndView companylist(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表department");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String companycontact = pd.getString("companycontact");					//检索条件
		if(null != companycontact && !"".equals(companycontact)){
			pd.put("companycontact", companycontact.trim());
		}
		String companyname = pd.getString("companyname");					//检索条件
		if(null != companyname && !"".equals(companyname)){
			pd.put("companyname", companyname.trim());
		}
		String companyid = pd.getString("companyid");					//检索条件
		if(null != companyid && !"".equals(companyid)){
			pd.put("companyid", companyid.trim());
		}
		//pd.put("DEPARTMENT_ID", DEPARTMENT_ID);					//上级ID
		page.setPd(pd);
		List<PageData>	varList = departmentService.companylist(page);	//列出Dictionaries列表
		//mv.addObject("pd", departmentService.findById(pd));		//传入上级所有信息
		//mv.addObject("DEPARTMENT_ID", DEPARTMENT_ID);			//上级ID
		mv.setViewName("fhoa/department/company_list");
		mv.addObject("varList", varList);
		mv.addObject("QX",Jurisdiction.getHC());				//按钮权限
		return mv;
	}
	
	/**
	 * 显示列表ztree
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/listAllDepartment")
	public ModelAndView listAllDepartment(Model model,String DEPARTMENT_ID)throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try{
			JSONArray arr = JSONArray.fromObject(departmentService.listAllDepartment("0","0"));
			String json = arr.toString();
			json = json.replaceAll("DEPARTMENT_ID", "id").replaceAll("PARENT_ID", "pId").replaceAll("NAME", "name").replaceAll("subDepartment", "nodes").replaceAll("hasDepartment", "checked").replaceAll("treeurl", "url");
			model.addAttribute("zTreeNodes", json);
			mv.addObject("DEPARTMENT_ID",DEPARTMENT_ID);
			mv.addObject("pd", pd);	
			mv.addObject("companyid", pd.getString("companyid"));	
			mv.setViewName("fhoa/department/department_ztree");
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
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
		String companyid = null == pd.get("companyid")?"":pd.get("companyid").toString();
		pd.put("companyid", companyid);					//上级ID
		//mv.addObject("pds",departmentService.findById(pd));		//传入上级所有信息
		List<PageData>	varList = departmentService.listselectdepartment(companyid);	//列出公司下的所有部门
		//mv.addObject("pds",departmentService.findById(pd));				//传入上级所有信息
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.setViewName("fhoa/department/department_edit");
		mv.addObject("msg", "save");
		return mv;
	}	
	
	/**去新增公司页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goAddcompany")
	public ModelAndView goAddcompany()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		//String companyid = null == pd.get("companyid")?"":pd.get("companyid").toString();
		//pd.put("companyid", companyid);					//上级ID
		//mv.addObject("pds",departmentService.findById(pd));		//传入上级所有信息
		//List<PageData>	varList = departmentService.listselectdepartment(companyid);	//列出公司下的所有部门
		//mv.addObject("pds",departmentService.findById(pd));				//传入上级所有信息
		//mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.setViewName("fhoa/department/company_edit");
		mv.addObject("msg", "savecompany");
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
		String DEPARTMENT_ID = pd.getString("DEPARTMENT_ID");
		pd = departmentService.findById(pd);	//根据ID读取
		mv.addObject("pd", pd);					//放入视图容器
		pd.put("DEPARTMENT_ID",pd.get("PARENT_ID").toString());			//用作上级信息
		mv.addObject("pds",departmentService.findById(pd));				//传入上级所有信息
		mv.addObject("DEPARTMENT_ID", pd.get("PARENT_ID").toString());	//传入上级ID，作为子ID用
		pd.put("DEPARTMENT_ID",DEPARTMENT_ID);							//复原本ID
		mv.setViewName("fhoa/department/department_edit");
		mv.addObject("msg", "edit");
		return mv;
	}
	
	/**去修改部门页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goEditdepartmrnt")
	public ModelAndView goEditdepartmrnt()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String DEPARTMENT_ID = pd.getString("DEPARTMENT_ID");
		pd = departmentService.finddepartmentById(pd);	//根据ID读取
		mv.addObject("pd", pd);					//放入视图容器
		if(pd.get("SUPERIOR_DEPARTMENT_ID")!=null){
			pd.put("DEPARTMENT_ID", pd.get("SUPERIOR_DEPARTMENT_ID").toString());
			mv.addObject("pds",departmentService.findById(pd));				//传入上级所有信息
		}
		else{
			mv.addObject("pds","");				//传入上级所有信息
		}
		pd.put("companyid",pd.get("B_COMPANY_ID").toString());			//用作上级信息
		pd.put("ID", pd.get("ID").toString());
		//mv.addObject("DEPARTMENT_ID", pd.get("PARENT_ID").toString());	//传入上级ID，作为子ID用
		List<PageData>	varList = departmentService.listselectdepartment(pd.get("B_COMPANY_ID").toString());	//列出公司下的所有部门
		pd.put("DEPARTMENT_ID",DEPARTMENT_ID);							//复原本ID
		mv.addObject("varList", varList);
		mv.setViewName("fhoa/department/department_edit");
		mv.addObject("msg", "edit");
		return mv;
	}

	/**删除图片
	 * @param out
	 * @throws Exception 
	 */
	@RequestMapping(value="/deltp")
	public void deltp(PrintWriter out) throws Exception {
		PageData pd = new PageData();
		pd = this.getPageData();
		String PATH = pd.getString("LOGO_PATH");													 		//图片路径
		//DelAllFile.delFolder(PathUtil.getClasspath()+ Const.FILEPATHIMG + pd.getString("PATH")); 	//删除图片
		if(PATH != null){
			departmentService.delTp(pd);																//删除数据库中图片数据
		}	
		out.write("success");
		out.close();
	}
	
	/**去修改部门页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goEditcompany")
	public ModelAndView goEditcompany()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.getString("companyid");
		pd = departmentService.findcompanyById(pd);	//根据ID读取
		mv.addObject("pd", pd);
		mv.setViewName("fhoa/department/company_edit");
		mv.addObject("msg", "companyedit");
		return mv;
	}
	
	/**判断编码是否存在
	 * @return
	 */
	@RequestMapping(value="/hasBianma")
	@ResponseBody
	public Object hasBianma(){
		Map<String,String> map = new HashMap<String,String>();
		String errInfo = "success";
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			if(departmentService.findByBianma(pd) != null){
				errInfo = "error";
			}
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		map.put("result", errInfo);				//返回结果
		return AppUtil.returnObject(new PageData(), map);
	}
	
	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}
}
