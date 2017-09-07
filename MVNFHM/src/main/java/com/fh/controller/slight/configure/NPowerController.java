package com.fh.controller.slight.configure;
import java.util.Properties;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.List;


import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.hzy.util.InternationalUtils;
import com.fh.hzy.util.UserUtils;
import com.fh.service.fhoa.department.DepartmentManager;
import com.fh.service.fhoa.department.impl.DepartmentService;
import com.fh.service.slight.configure.ConfigureService;
import com.fh.service.slight.language.InternationalService;
import com.fh.service.system.fhlog.FHlogManager;
import com.fh.util.Const;
import com.fh.util.FileDownload;
import com.fh.util.FileUpload;
import com.fh.util.Jurisdiction;
import com.fh.util.ObjectExcelRead;
import com.fh.util.ObjectExcelView;
import com.fh.util.PageData;
import com.fh.util.PathUtil;

@Controller
@RequestMapping("/npower")
public class NPowerController extends BaseController{
	String menuUrl = "npower/getNPowerList"; //菜单地址(权限用)
	
	private String nPowerJsp = "foundation/npower/npower_list"; //普通电源查询jsp
	private String nPowerEditJsp = "foundation/npower/npower_edit";  						//普通电源修改jsp
	private String nPowerCreateJsp = "foundation/npower/npower_edit";  						//普通电源新增jsp
	private String uploadJsp="foundation/npower/uploadexcel";
	private String saveRsultJsp = "save_result";  				//保存修改jsp
	
	@Resource(name="configureService")
	private ConfigureService configureService;
	@Resource(name="fhlogService")
	private FHlogManager FHLOG;
	
	/**
	 * 获取普通电源列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/getNPowerList")
	public ModelAndView getNPowerList(Page page) throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		page.setPd(pd);
		List<PageData> nPList = configureService.getNPowerList(page);
		if(pd.get("excel")!=null&&pd.getString("excel").equals("1")){
			ObjectExcelView erv = new ObjectExcelView();					//执行excel操作
			mv = new ModelAndView(erv,ConfigureUtils.exportNPower(nPList));
			return mv;
			
		}else{
			mv.addObject("pd", pd);
			mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
			mv.addObject("nPowerList", nPList);
			mv.setViewName(nPowerJsp);
			pd.put("userid", UserUtils.getUserid());
			return mv;
		}
		
		
		
	}
	
	/**
	 * 跳转普通电源修改页面
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/goNPowerEdit")
	public ModelAndView goNPowerEdit()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = configureService.getNPowerById(pd);
		mv.addObject("pd", pd);
		mv.addObject("msg", "editNPower");
		mv.setViewName(nPowerEditJsp);

		
		return mv;
	
	}
	
	/**
	 * 跳转普通电源新增页面
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/goNPowerCreate")
	public ModelAndView goNPowerCreate() throws Exception{
		ModelAndView mv = this.getModelAndView();
		mv.addObject("msg", "createNPower");
		mv.setViewName(nPowerCreateJsp);
		return mv;
	}
	
	/**
	 * 修改普通电源
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/editNPower")
	public ModelAndView editNPower() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		configureService.editNPower(pd);
		mv.addObject("msg", "success");
		mv.setViewName(saveRsultJsp);
		return mv;
		
	}
	
	/**
	 * 新增普通电源
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/createNPower")
	public ModelAndView createNPower() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		configureService.createNPower(pd);
		mv.addObject("msg", "success");
		mv.setViewName(saveRsultJsp);
		return mv;
		
	}
	
	/**下载普通电源模版
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value="/downExcel")
	public void downExcel(HttpServletResponse response)throws Exception{
		String xlsname = "npower.xls";
		FileDownload.fileDownload(response, PathUtil.getClasspath() + Const.FILEPATHFILE + xlsname, xlsname);
	}
	
	/**打开上传EXCEL页面
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/goUploadExcel")
	public ModelAndView goUploadExcel()throws Exception{
		ModelAndView mv = this.getModelAndView();
		mv.setViewName(uploadJsp);
		return mv;
	}
	
	/**从EXCEL导入到数据库
	 * @param file
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/readExcel")
	public ModelAndView readExcel(
			@RequestParam(value="excel",required=false) MultipartFile file
			) throws Exception{
		
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;}
		if (null != file && !file.isEmpty()) {
			String filePath = PathUtil.getClasspath() + Const.FILEPATHFILE;								//文件上传路径
			
			String fileName =  FileUpload.fileUp(file, filePath, "npower");
			System.out.println("filename: "+fileName);
			//执行上传
			List<PageData> listPd = (List)ObjectExcelRead.readExcel(filePath, fileName, 2, 0, 0);		//执行读EXCEL操作,读出的数据导入List 2:从第3行开始；0:从第A列开始；0:第0个sheet
			for(int i=0;i<listPd.size();i++){		
				pd.put("name", listPd.get(i).getString("var0"));							//姓名
				pd.put("vendor", listPd.get(i).getString("var1"));
				pd.put("type", ConfigureUtils.getType(listPd.get(i).getString("var2")));
				pd.put("power", listPd.get(i).getString("var3"));
				pd.put("comment", listPd.get(i).getString("var4"));
				configureService.createNPower(pd);
			}
			mv.addObject("msg","success");
		}
		mv.setViewName(saveRsultJsp);
		return mv;
	}
}
