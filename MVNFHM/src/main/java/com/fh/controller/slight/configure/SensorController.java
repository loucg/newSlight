package com.fh.controller.slight.configure;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.entity.system.User;
import com.fh.hzy.util.UserUtils;
import com.fh.service.fhoa.department.DepartmentManager;
import com.fh.service.slight.configure.ConfigureService;
import com.fh.service.street.state.GatewayStateService;
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
	@Resource(name = "gatewayStateService")
	private GatewayStateService gatewayStateService;

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
		List<PageData> typeList = configureService.getAllSensor(pd);
		List<PageData> sensorList = configureService.getSensorList(page);
		if(pd.get("excel")!=null&&pd.getString("excel").equals("1")){
			ObjectExcelView erv = new ObjectExcelView();					//执行excel操作
			mv = new ModelAndView(erv,ConfigureUtils.exportSensor(sensorList,typeList));
			return mv;
			
		}else{
			mv.addObject("pd", pd);
			mv.addObject("sensorList", sensorList);
			mv.addObject("typeList", typeList);
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
		List<PageData> typeList = configureService.getAllSensor(pd);
		List<PageData> poleList = configureService.getAllPole(pd);// 灯杆类型
		String coordinate = pd.getString("coordinate");
		if (coordinate == null || "".equals(coordinate)) {
			pd.put("longitude", "");
			pd.put("latitude", "");
		}else if (coordinate.equals(",")) {
			pd.put("longitude", "");
			pd.put("latitude", "");
		} else if (coordinate.substring(0, 1).equals(",")) {
			pd.put("longitude", "");
			pd.put("latitude", coordinate.substring(1));
		} else if (coordinate.substring(coordinate.length() - 1).equals(",")) {
			pd.put("longitude", coordinate.substring(0, coordinate.length() - 1));
			pd.put("latitude", "");
		} else {
			String[] zuobiao = coordinate.split(",");
			pd.put("longitude", zuobiao[0]);
			pd.put("latitude", zuobiao[1]);
		}
		mv.addObject("pd", pd);
		mv.addObject("clientTypeList", typeList);
		mv.addObject("poleList", poleList);
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
		pd.put("coordinate", pd.getString("longitude") + "," + pd.getString("latitude"));
		pd.put("status", 1);
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
		String xlsname = "sensor.xls";
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
			List<PageData> typeList = configureService.getAllSensor(pd);
			for (int i = 0; i < listPd.size(); i++) {
				String typeName = listPd.get(i).getString("var2");
				String typeId = "0";
				for(PageData pg : typeList){
					if(typeName.equals(pg.getString("name"))){
						typeId = pg.get("id").toString();
						break;
					}
				}
				pd.put("number", listPd.get(i).getString("var0")); // ID
				pd.put("name", listPd.get(i).getString("var1")); // 姓名
				pd.put("location", listPd.get(i).getString("var3"));
				pd.put("coordinate", listPd.get(i).getString("var4"));
				pd.put("polenumber", listPd.get(i).getString("var5"));
				pd.put("comment", listPd.get(i).getString("var6"));
				pd.put("status", 1);
				pd.put("typeid", typeId);
				pd.put("userid", UserUtils.getUserid());
					configureService.createSensor(pd);
			}
			mv.addObject("msg", "success");
		}
		mv.setViewName(saveRsultJsp);
		return mv;
	}
	
	@RequestMapping("/testNumber")
	@ResponseBody
	public PageData testNumber() throws Exception {
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = configureService.getSensorByNumber(pd);
		long d = (long) pd.get("count");
		pd.put("count", d);
		return pd;

	}
	
	/**
	 * 显示同一网关下的所有传感器信息
	 */

	@RequestMapping("/goViewDetail")
	public ModelAndView goViewDetail(Page page) throws Exception {
		logBefore(logger, "goViewDetail");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		// 获得登录的用户id
		User user = (User) Jurisdiction.getSession().getAttribute(Const.SESSION_USER);
		String sys_user_id = user.getUSER_ID();
		pd.put("sys_user_id", sys_user_id);

		String userids = departmentService.getUseridsInDepartment(pd);
		pd.put("userids", userids);
		page.setPd(pd);
		List<PageData> sensorDetailList = gatewayStateService.viewSensorDetail(page);
		List<PageData> gatewaynamelist = gatewayStateService.viewgateWayName(page);
		mv.setViewName("foundation/sensor/sensorstate_list");
		mv.addObject("sensorDetailList", sensorDetailList);
		mv.addObject("gatewaynamelist", gatewaynamelist);
		mv.addObject("pd", pd);
		mv.addObject("QX", Jurisdiction.getHC());
		return mv;
	}
}
