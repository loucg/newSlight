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
import com.fh.service.fhoa.department.DepartmentManager;
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
@RequestMapping("/sensor")
public class SensorController extends BaseController{
	String menuUrl = "sensor/getNPowerList"; //菜单地址(权限用)
	
	private String sensorJsp = "foundation/sensor/sensor_list"; //传感器杆查询jsp
	private String sensorEditJsp = "foundation/sensor/sensor_edit";  						//传感器修改jsp
	private String sensorCreateJsp = "foundation/sensor/sensor_edit";  						//传感器新增jsp
	
	private String uploadJsp="foundation/sensor/uploadexcel";
	private String saveRsultJsp = "save_result";  				//保存修改jsp
	
	
	@Resource(name="configureService")
	private ConfigureService configureService;
	@Resource(name="fhlogService")
	private FHlogManager FHLOG;
	@Resource(name="departmentService")
	private DepartmentManager departmentService;
	

	/**
	 * 获取传感器列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/getSensorList")
	public ModelAndView getSensorList(Page page) throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("userids", departmentService.getUseridsInDepartment(pd));
		page.setPd(pd);
		List<PageData> nPList = configureService.getSensorList(page);
		if(pd.get("excel")!=null&&pd.getString("excel").equals("1")){
			ObjectExcelView erv = new ObjectExcelView();					//执行excel操作
			mv = new ModelAndView(erv,ConfigureUtils.exportNPower(nPList));
			return mv;
			
		}else{
			mv.addObject("pd", pd);
			mv.addObject("sensorList", nPList);
			mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
			mv.setViewName(sensorJsp);
			return mv;
		}
	}
	
	/**
	 * 跳转传感器修改页面
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/goSensorEdit")
	public ModelAndView goSensorEdit() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = configureService.getSensorById(pd);
		mv.addObject("pd", pd);
		mv.addObject("msg", "editSensor");
		mv.setViewName(sensorEditJsp);
		return mv;
	
	}
	
	/**
	 * 跳转传感器新增页面
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/goSensorCreate")
	public ModelAndView goSensorCreate() throws Exception{
		ModelAndView mv = this.getModelAndView();
		mv.addObject("msg", "createSensor");
		mv.setViewName(sensorCreateJsp);
		return mv;
	}
	
	/**
	 * 修改传感器
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/editSensor")
	public ModelAndView editSensor() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		configureService.editSensor(pd);
		mv.addObject("msg", "success");
		mv.setViewName(saveRsultJsp);
		return mv;
		
	}
	/**
	 * 新增传感器
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/createSensor")
	public ModelAndView createSensor() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		configureService.createSensor(pd);
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
			String fileName =  FileUpload.fileUp(file, filePath, "userexcel");							//执行上传
			List<PageData> listPd = (List)ObjectExcelRead.readExcel(filePath, fileName, 2, 0, 0);		//执行读EXCEL操作,读出的数据导入List 2:从第3行开始；0:从第A列开始；0:第0个sheet

			for(int i=0;i<listPd.size();i++){		
				pd.put("name", listPd.get(i).getString("var0"));							//姓名
				pd.put("vendor", listPd.get(i).getString("var1"));
				pd.put("type", ConfigureUtils.getType(listPd.get(i).getString("var2")));
				pd.put("power", listPd.get(i).getString("var3"));
				pd.put("comment", listPd.get(i).getString("var4"));
				configureService.createSensor(pd);
			}
			mv.addObject("msg","success");
		}
		mv.setViewName(saveRsultJsp);
		return mv;
	}
}
