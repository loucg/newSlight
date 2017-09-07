package com.fh.controller.slight.configure;

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
import com.fh.service.slight.configure.ConfigureService;
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
@RequestMapping("/sim")
public class SimController extends BaseController{
	
	String menuUrl = "sim/getSimList"; //菜单地址(权限用)
	
	private String simJsp = "foundation/simcard/simcard_list";    //Sim卡杆查询jsp
	private String simEditJsp = "foundation/simcard/simcard_edit";  							//Sim卡修改jsp
	private String simCreateJsp = "foundation/simcard/simcard_edit";  							//Sim卡新增jsp
	
	private String uploadJsp="foundation/simcard/uploadexcel";
	private String saveRsultJsp = "save_result";  				//保存修改jsp
	
	@Resource(name="configureService")
	private ConfigureService configureService;
	@Resource(name="fhlogService")
	private FHlogManager FHLOG;
	
	
	/**
	 * 获取Sim卡列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/getSimList")
	public ModelAndView getSimList(Page page) throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		page.setPd(pd);
		List<PageData> nPList = configureService.getSimList(page);
		if(pd.get("excel")!=null&&pd.getString("excel").equals("1")){
			ObjectExcelView erv = new ObjectExcelView();					//执行excel操作
			mv = new ModelAndView(erv,ConfigureUtils.exportSimcard(nPList));
			return mv;
			
		}else{
			mv.addObject("pd", pd);
			mv.addObject("simList", nPList);
			mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
			mv.setViewName(simJsp);
			return mv;
		}
	}
	
	/**get
	 * 跳转Sim卡修改页面
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/goSimEdit")
	public ModelAndView goSimEdit() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = configureService.getSimById(pd);
		mv.addObject("pd", pd);
		mv.addObject("msg", "editSim");
		mv.setViewName(simEditJsp);
		return mv;
	}
	
	/**
	 * 跳转Sim卡新增页面
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/goSimCreate")
	public ModelAndView goSimCreate(Page page) throws Exception{
		ModelAndView mv = this.getModelAndView();
		mv.addObject("msg", "createSim");
		mv.setViewName(simCreateJsp);
		return mv;
	}
	
	/**
	 * 修改Sim卡
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/editSim")
	public ModelAndView editSim() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		configureService.editSim(pd);
		mv.addObject("msg", "success");
		mv.setViewName(saveRsultJsp);
		return mv;
		
	}
	
	/**
	 * 新增Sim卡
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/createSim")
	public ModelAndView createSim() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		configureService.createSim(pd);
		mv.addObject("msg", "success");
		mv.setViewName(saveRsultJsp);
		return mv;
		
	}
	
	
	/**下载灯模版
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value="/downExcel")
	public void downExcel(HttpServletResponse response)throws Exception{
		String xlsname = "sim.xls";
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
			String fileName =  FileUpload.fileUp(file, filePath, "userexcel");							//执行上传
			List<PageData> listPd = (List)ObjectExcelRead.readExcel(filePath, fileName, 2, 0, 0);		//执行读EXCEL操作,读出的数据导入List 2:从第3行开始；0:从第A列开始；0:第0个sheet

			for(int i=0;i<listPd.size();i++){		
				pd.put("iccid", listPd.get(i).getString("var0"));							//姓名
				pd.put("mobile", listPd.get(i).getString("var1"));
				pd.put("type", ConfigureUtils.getType(listPd.get(i).getString("var2")));
				pd.put("status", ConfigureUtils.getSimStatus(listPd.get(i).getString("var3")));
				pd.put("money", listPd.get(i).getString("var4"));
				pd.put("comment", listPd.get(i).getString("var5"));
				configureService.createSim(pd);
			}
			mv.addObject("msg","success");
		}
		mv.setViewName(saveRsultJsp);
		return mv;
	}
}
