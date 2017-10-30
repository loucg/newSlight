package com.fh.controller.clienttype;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.controller.slight.configure.ConfigureUtils;
import com.fh.entity.Page;
import com.fh.service.clienttype.ClienttypeService;
import com.fh.service.system.fhlog.FHlogManager;
import com.fh.util.AppUtil;
import com.fh.util.Const;
import com.fh.util.DateUtil;
import com.fh.util.FileDownload;
import com.fh.util.FileUpload;
import com.fh.util.Jurisdiction;
import com.fh.util.ObjectExcelRead;
import com.fh.util.ObjectExcelView;
import com.fh.util.PageData;
import com.fh.util.PathUtil;

@Controller
@RequestMapping("/clienttype")
public class ClientTypeController extends BaseController{
	
	String menuUrl = "clienttype/getGatewayList.do"; //菜单地址(权限用)
	private String sensorListJsp = "clienttype/sensor/sensor_list";       //传感器 list jsp
	private String sensorEditJsp = "clienttype/sensor/sensor_edit";       //传感器 edit jsp
	private String gatewayListJsp = "clienttype/gateway/gateway_list";       //网关 list jsp
	private String gatewayEditJsp = "clienttype/gateway/gateway_edit";       //网关 edit jsp
	private String lampListJsp = "clienttype/lamp/lamp_list";       //路灯 list jsp
	private String lampEditJsp = "clienttype/lamp/lamp_edit";       //路灯 edit jsp
	
	private String gatewayUploadJsp="clienttype/gateway/uploadexcel";
	private String sensorUploadJsp="clienttype/sensor/uploadexcel";
	private String lampUploadJsp="clienttype/lamp/uploadexcel";
	private String saveRsultJsp = "save_result";  				//保存修改jsp
	
	
	@Resource(name="clienttypeService")
	private ClienttypeService clienttypeService;
	@Resource(name="fhlogService")
	private FHlogManager FHLOG;
	/**
	 * 获取网关终端类型
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/getGatewayList")
	public ModelAndView getGatewayList(Page page) throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		page.setPd(pd);
		List<PageData> gatewayList = clienttypeService.getGatewayList(page);
		if(pd.get("excel")!=null&&pd.getString("excel").equals("1")){
			ObjectExcelView erv = new ObjectExcelView();					//执行excel操作
			mv = new ModelAndView(erv,ClientTypeUtils.exportGatewaytype(gatewayList));
			return mv;
		}else{
			mv.addObject("pd", pd);
			mv.addObject("tagFlg", "1");
			mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
			mv.addObject("gatewayList", gatewayList);
			mv.setViewName(gatewayListJsp);
			return mv;
		}
	}
	/**
	 * 获取传感器终端类型
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/getSensorList")
	public ModelAndView getSensorList(Page page) throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		page.setPd(pd);
		List<PageData> sensorList = clienttypeService.getSensorList(page);
		if(pd.get("excel")!=null&&pd.getString("excel").equals("1")){
			ObjectExcelView erv = new ObjectExcelView();					//执行excel操作
			mv = new ModelAndView(erv,ClientTypeUtils.exportSensortype(sensorList));
			return mv;
		}else{
			mv.addObject("pd", pd);
			mv.addObject("tagFlg", "3");
			mv.addObject("sensorList", sensorList);
			mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
			mv.setViewName(sensorListJsp);
			return mv;
		}
	}
	/**
	 * 获取终端类型
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/getLampList")
	public ModelAndView getLampList(Page page) throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		page.setPd(pd);
		List<PageData> clientList = clienttypeService.getClientList(page);
		if(pd.get("excel")!=null&&pd.getString("excel").equals("1")){
			ObjectExcelView erv = new ObjectExcelView();					//执行excel操作
			mv = new ModelAndView(erv,ClientTypeUtils.exportLamp(clientList));
			return mv;
		}else{
			mv.addObject("pd", pd);
			mv.addObject("tagFlg", "4");
			mv.addObject("clientList", clientList);
			mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
			mv.setViewName(lampListJsp);
			return mv;
		}
	}
	/**
	 * 跳转网关修改页面
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/goGatewayEdit")
	public ModelAndView goGatewayEdit() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = clienttypeService.getGatewayById(pd);
		mv.addObject("pd", pd);
		mv.addObject("msg", "editGateway");
		mv.setViewName(gatewayEditJsp);
		return mv;
	
	}
	
	/**
	 * 跳转网关新增页面
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/goGatewayCreate")
	public ModelAndView goGatewayCreate() throws Exception{
		ModelAndView mv = this.getModelAndView();
		mv.addObject("msg", "createGateway");
		mv.setViewName(gatewayEditJsp);
		return mv;
	}
	
	
	/**
	 * 修改网关
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/editGateway")
	public ModelAndView editGateway(HttpServletRequest request,
			@RequestParam(value="id",required=false) String id,
			@RequestParam(value="name_CH",required=false) String name_CH,
			@RequestParam(value="name_EN",required=false) String name_EN,
			@RequestParam(value="status",required=false) String status,
			@RequestParam(value="Vmax",required=false) String Vmax,
			@RequestParam(value="Imax",required=false) String Imax,
			@RequestParam(value="Vset",required=false) String Vset,
			@RequestParam(value="Iset",required=false) String Iset,
			@RequestParam(value="explain",required=false) String explain) throws Exception{
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		logBefore(logger, Jurisdiction.getUsername()+"修改网关类型");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		if(Jurisdiction.buttonJurisdiction(menuUrl, "edit")){
			pd.put("name_CH", name_CH);		//地址
			pd.put("name_EN1", name_EN);
			pd.put("status", status);					//联系人
			pd.put("Vmax", Vmax);			//手机号码
			pd.put("Imax", Imax);						//是否显示图片
			pd.put("Vset", Vset);						//状态
			pd.put("Iset", Iset);						//地图
			pd.put("explain", explain);						//短信平台
			pd.put("id", id);	
			clienttypeService.editGateway(pd);
		}
		mv.addObject("msg", "success");
		mv.setViewName(saveRsultJsp);
		return mv;
		
	}
	
	/**
	 * 新增网关
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/createGateway")
	public ModelAndView createGateway(HttpServletRequest request,
			@RequestParam(value="name_CH",required=false) String name_CH,
			@RequestParam(value="name_EN",required=false) String name_EN,
			@RequestParam(value="status",required=false) String status,
			@RequestParam(value="Vmax",required=false) String Vmax,
			@RequestParam(value="Imax",required=false) String Imax,
			@RequestParam(value="Vset",required=false) String Vset,
			@RequestParam(value="Iset",required=false) String Iset,
			@RequestParam(value="explain",required=false) String explain) throws Exception{
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		logBefore(logger, Jurisdiction.getUsername()+"增加网关类型");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		if(Jurisdiction.buttonJurisdiction(menuUrl, "edit")){
			pd.put("name_CH", name_CH);		//地址
			pd.put("name_EN", name_EN);
			pd.put("status", status);					//联系人
			pd.put("Vmax", Vmax);			//手机号码
			pd.put("Imax", Imax);						//是否显示图片
			pd.put("Vset", Vset);						//状态
			pd.put("Iset", Iset);						//地图
			pd.put("explain", explain);						//短信平台
			clienttypeService.createGateway(pd);
		}
		mv.addObject("msg", "success");
		mv.setViewName(saveRsultJsp);
		return mv;
		
	}
	
	/**
	 * 跳转网关修改页面
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/goSensorEdit")
	public ModelAndView goSensorEdit() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = clienttypeService.getSensorById(pd);
		mv.addObject("pd", pd);
		mv.addObject("msg", "editSensor");
		mv.setViewName(sensorEditJsp);
		return mv;
	
	}
	
	/**
	 * 跳转网关新增页面
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/goSensorCreate")
	public ModelAndView goSensorCreate() throws Exception{
		ModelAndView mv = this.getModelAndView();
		mv.addObject("msg", "createSensor");
		mv.setViewName(sensorEditJsp);
		return mv;
	}
	
	
	/**
	 * 修改网关
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/editSensor")
	public ModelAndView editSensor(
			HttpServletRequest request,
			@RequestParam(value="tp",required=false) MultipartFile file,
			@RequestParam(value="id",required=false) String id,
			@RequestParam(value="name",required=false) String name,
			@RequestParam(value="image",required=false) String image,
			@RequestParam(value="status",required=false) String status,
			@RequestParam(value="Vmax",required=false) String Vmax,
			@RequestParam(value="Imax",required=false) String Imax,
			@RequestParam(value="Vset",required=false) String Vset,
			@RequestParam(value="Iset",required=false) String Iset,
			@RequestParam(value="explain",required=false) String explain
			) throws Exception{
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		logBefore(logger, Jurisdiction.getUsername()+"修改传感器类型");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		if(Jurisdiction.buttonJurisdiction(menuUrl, "edit")){
			pd.put("name", name);		//地址
			pd.put("status", status);					//联系人
			pd.put("Vmax", Vmax);			//手机号码
			pd.put("Imax", Imax);						//是否显示图片
			pd.put("Vset", Vset);						//状态
			pd.put("Iset", Iset);						//地图
			pd.put("explain", explain);						//短信平台
			pd.put("id", id);						//ID
			if(null == image){image = "";}
			String  ffile = DateUtil.getDays(), fileName = "";
			if (null != file && !file.isEmpty()) {
				String filePath = PathUtil.getClasspath() + Const.FILEPATHIMG + ffile;	//文件上传路径
				fileName = FileUpload.fileUp(file, filePath, this.get32UUID());			//执行上传
				pd.put("image", ffile + "/" + fileName);									//路径
				//pd.put("NAME", fileName);
			}else{
				pd.put("image", image);
			}
			clienttypeService.editSensor(pd);
		}
		mv.addObject("msg", "success");
		mv.setViewName(saveRsultJsp);
		return mv;
		
	}
	
	/**
	 * 新增网关
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/createSensor")
	public ModelAndView createSensor(HttpServletRequest request,
			@RequestParam(value="tp",required=false) MultipartFile file,
			@RequestParam(value="id",required=false) String id,
			@RequestParam(value="name",required=false) String name,
			@RequestParam(value="image",required=false) String image,
			@RequestParam(value="status",required=false) String status,
			@RequestParam(value="Vmax",required=false) String Vmax,
			@RequestParam(value="Imax",required=false) String Imax,
			@RequestParam(value="Vset",required=false) String Vset,
			@RequestParam(value="Iset",required=false) String Iset,
			@RequestParam(value="explain",required=false) String explain) throws Exception{
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		logBefore(logger, Jurisdiction.getUsername()+"新增传感器类型");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		if(Jurisdiction.buttonJurisdiction(menuUrl, "add")){
			pd.put("name", name);		//地址
			pd.put("status", status);					//联系人
			pd.put("Vmax", Vmax);			//手机号码
			pd.put("Imax", Imax);						//是否显示图片
			pd.put("Vset", Vset);						//状态
			pd.put("Iset", Iset);						//地图
			pd.put("explain", explain);						//短信平台
			pd.put("id", id);						//ID
			if(null == image){image = "";}
			String  ffile = DateUtil.getDays(), fileName = "";
			if (null != file && !file.isEmpty()) {
				String filePath = PathUtil.getClasspath() + Const.FILEPATHIMG + ffile;	//文件上传路径
				fileName = FileUpload.fileUp(file, filePath, this.get32UUID());			//执行上传
				pd.put("image", ffile + "/" + fileName);									//路径
				//pd.put("NAME", fileName);
			}else{
				pd.put("image", image);
			}
			clienttypeService.createSensor(pd);
		}
		mv.addObject("msg", "success");
		mv.setViewName(saveRsultJsp);
		return mv;
	}
	/**
	 * 跳转网关修改页面
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/goLampEdit")
	public ModelAndView goLampEdit() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = clienttypeService.getClientById(pd);
		mv.addObject("pd", pd);
		mv.addObject("msg", "editLamp");
		mv.setViewName(lampEditJsp);
		return mv;
	
	}
	
	/**
	 * 跳转网关新增页面
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/goLampCreate")
	public ModelAndView goLampCreate() throws Exception{
		ModelAndView mv = this.getModelAndView();
		mv.addObject("msg", "createLamp");
		mv.setViewName(lampEditJsp);
		return mv;
	}
	
	
	/**
	 * 修改网关
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/editLamp")
	public ModelAndView editLamp(
			HttpServletRequest request,
			@RequestParam(value="tp",required=false) MultipartFile file,
			@RequestParam(value="id",required=false) String id,
			@RequestParam(value="name",required=false) String name,
			@RequestParam(value="status",required=false) String status,
			@RequestParam(value="Vmax",required=false) String Vmax,
			@RequestParam(value="Imax",required=false) String Imax,
			@RequestParam(value="Vset",required=false) String Vset,
			@RequestParam(value="Iset",required=false) String Iset,
			@RequestParam(value="explain",required=false) String explain
			) throws Exception{
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		logBefore(logger, Jurisdiction.getUsername()+"修改传感器类型");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		if(Jurisdiction.buttonJurisdiction(menuUrl, "edit")){
			pd.put("name", name);		//地址
			pd.put("status", status);					//联系人
			pd.put("Vmax", Vmax);			//手机号码
			pd.put("Imax", Imax);						//是否显示图片
			pd.put("Vset", Vset);						//状态
			pd.put("Iset", Iset);						//地图
			pd.put("explain", explain);						//短信平台
			pd.put("id", id);						//ID
			clienttypeService.editClient(pd);
		}
		mv.addObject("msg", "success");
		mv.setViewName(saveRsultJsp);
		return mv;
		
	}
	
	/**
	 * 新增网关
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/createLamp")
	public ModelAndView createLamp(HttpServletRequest request,
			@RequestParam(value="tp",required=false) MultipartFile file,
			@RequestParam(value="id",required=false) String id,
			@RequestParam(value="name",required=false) String name,
			@RequestParam(value="status",required=false) String status,
			@RequestParam(value="Vmax",required=false) String Vmax,
			@RequestParam(value="Imax",required=false) String Imax,
			@RequestParam(value="Vset",required=false) String Vset,
			@RequestParam(value="Iset",required=false) String Iset,
			@RequestParam(value="explain",required=false) String explain) throws Exception{
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		logBefore(logger, Jurisdiction.getUsername()+"新增传感器类型");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		if(Jurisdiction.buttonJurisdiction(menuUrl, "add")){
			pd.put("name", name);		//地址
			pd.put("status", status);					//联系人
			pd.put("Vmax", Vmax);			//手机号码
			pd.put("Imax", Imax);						//是否显示图片
			pd.put("Vset", Vset);						//状态
			pd.put("Iset", Iset);						//地图
			pd.put("explain", explain);						//短信平台
			pd.put("id", id);						//ID
			clienttypeService.createClient(pd);
		}
		mv.addObject("msg", "success");
		mv.setViewName(saveRsultJsp);
		return mv;
	}
	/**删除图片
	 * @param out
	 * @throws Exception 
	 */
	@RequestMapping(value="/delSensorPic")
	public void delSensorPic(PrintWriter out) throws Exception {
		PageData pd = new PageData();
		pd = this.getPageData();
		String PATH = pd.getString("image");													 		//图片路径
		//DelAllFile.delFolder(PathUtil.getClasspath()+ Const.FILEPATHIMG + pd.getString("PATH")); 	//删除图片
		if(PATH != null){
			clienttypeService.delSensorPic(pd);																//删除数据库中图片数据
		}	
		out.write("success");
		out.close();
	}
	
	/**删除图片
	 * @param out
	 * @throws Exception 
	 */
	@RequestMapping(value="/delLampPic")
	public void delLampPic(PrintWriter out) throws Exception {
		PageData pd = new PageData();
		pd = this.getPageData();
		String PATH = pd.getString("image");													 		//图片路径
		//DelAllFile.delFolder(PathUtil.getClasspath()+ Const.FILEPATHIMG + pd.getString("PATH")); 	//删除图片
		if(PATH != null){
			clienttypeService.delLampPic(pd);																//删除数据库中图片数据
		}	
		out.write("success");
		out.close();
	}
	
	/**下载网关类型模版
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value="/downGatewayExcel")
	public void downGatewayExcel(HttpServletResponse response)throws Exception{
		String xlsname = "c_gateway_type.xls";
		FileDownload.fileDownload(response, PathUtil.getClasspath() + Const.FILEPATHFILE + xlsname, xlsname);
	}
	
	/**下载传感器类型模版
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value="/downSensorExcel")
	public void downSensorExcel(HttpServletResponse response)throws Exception{
		String xlsname = "c_sensor_type.xls";
		FileDownload.fileDownload(response, PathUtil.getClasspath() + Const.FILEPATHFILE + xlsname, xlsname);
	}
	
	/**下载路灯类型模版
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value="/downLampExcel")
	public void downLampExcel(HttpServletResponse response)throws Exception{
		String xlsname = "c_client_type.xls";
		FileDownload.fileDownload(response, PathUtil.getClasspath() + Const.FILEPATHFILE + xlsname, xlsname);
	}
	
	/**打开网关上传EXCEL页面
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/goGatewayUploadExcel")
	public ModelAndView goGatewayUploadExcel()throws Exception{
		ModelAndView mv = this.getModelAndView();
		mv.setViewName(gatewayUploadJsp);
		return mv;
	}
	
	/**打开传感器上传EXCEL页面
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/goSensorUploadExcel")
	public ModelAndView goSensorUploadExcel()throws Exception{
		ModelAndView mv = this.getModelAndView();
		mv.setViewName(sensorUploadJsp);
		return mv;
	}
	
	/**打开路灯上传EXCEL页面
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/goLampUploadExcel")
	public ModelAndView goLampUploadExcel()throws Exception{
		ModelAndView mv = this.getModelAndView();
		mv.setViewName(lampUploadJsp);
		return mv;
	}
	
	/**从EXCEL导入到数据库
	 * @param file
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/readGatewayExcel")
	public ModelAndView readGatewayExcel(
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
				pd.put("name_CH", listPd.get(i).getString("var0"));							
				pd.put("name_EN", listPd.get(i).getString("var1"));
				pd.put("status", ClientTypeUtils.getStatus(listPd.get(i).getString("var2")));
				pd.put("Vmax", listPd.get(i).getString("var3"));
				pd.put("Imax", listPd.get(i).getString("var4"));
				pd.put("Vset", listPd.get(i).getString("var5"));
				pd.put("Iset", listPd.get(i).getString("var6"));
				pd.put("explain", listPd.get(i).getString("var7"));
				clienttypeService.createGateway(pd);
			}
			mv.addObject("msg","success");
		}
		mv.setViewName(saveRsultJsp);
		return mv;
	}
	
	/**从EXCEL导入到数据库
	 * @param file
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/readSensorExcel")
	public ModelAndView readSensorExcel(
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
				pd.put("name", listPd.get(i).getString("var0"));							
				pd.put("status", ClientTypeUtils.getStatus(listPd.get(i).getString("var1")));
				pd.put("Vmax", listPd.get(i).getString("var2"));
				pd.put("Imax", listPd.get(i).getString("var3"));
				pd.put("Vset", listPd.get(i).getString("var4"));
				pd.put("Iset", listPd.get(i).getString("var5"));
				pd.put("explain", listPd.get(i).getString("var6"));
				clienttypeService.createSensor(pd);
			}
			mv.addObject("msg","success");
		}
		mv.setViewName(saveRsultJsp);
		return mv;
	}
	
	/**从EXCEL导入到数据库
	 * @param file
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/readLampExcel")
	public ModelAndView readLampExcel(
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
				pd.put("name", listPd.get(i).getString("var0"));							
				pd.put("status", ClientTypeUtils.getStatus(listPd.get(i).getString("var1")));
				pd.put("Vmax", listPd.get(i).getString("var2"));
				pd.put("Imax", listPd.get(i).getString("var3"));
				pd.put("Vset", listPd.get(i).getString("var4"));
				pd.put("Iset", listPd.get(i).getString("var5"));
				pd.put("explain", listPd.get(i).getString("var6"));
				clienttypeService.createClient(pd);
			}
			mv.addObject("msg","success");
		}
		mv.setViewName(saveRsultJsp);
		return mv;
	}
	
	/**
	 * 删除
	 * @param DEPARTMENT_ID
	 * @param
	 * @throws Exception 
	 */
	@RequestMapping(value="/deleteGateway")
	@ResponseBody
	public Object deleteGateway(@RequestParam String id) throws Exception{
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		logBefore(logger, Jurisdiction.getUsername()+"删除网关终端类型");
		Map<String,String> map = new HashMap<String,String>();
		PageData pd = new PageData();
		pd.put("id", id);
		PageData pg  = clienttypeService.getGatewayTypeCount(pd);
		String count = pg.get("count").toString();
		String errInfo = "success";
		if("0".equals(count)){
			clienttypeService.delGateway(pd);	//执行删除
		} else {
			errInfo = "false";
		}
			
		map.put("result", errInfo);// 执行成功
		return AppUtil.returnObject(new PageData(), map);
	}
	
	/**
	 * 删除
	 * @param DEPARTMENT_ID
	 * @param
	 * @throws Exception 
	 */
	@RequestMapping(value="/deleteSensor")
	@ResponseBody
	public Object deleteSensor(@RequestParam String id) throws Exception{
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		logBefore(logger, Jurisdiction.getUsername()+"删除网关终端类型");
		Map<String,String> map = new HashMap<String,String>();
		PageData pd = new PageData();
		pd.put("id", id);
		PageData pg  = clienttypeService.getSensorTypeCount(pd);
		String count = pg.get("count").toString();
		String errInfo = "success";
		if("0".equals(count)){
			clienttypeService.delSensor(pd);	//执行删除
		} else {
			errInfo = "false";
		}
			
		map.put("result", errInfo);// 执行成功
		return AppUtil.returnObject(new PageData(), map);
	}
	
	/**
	 * 删除
	 * @param DEPARTMENT_ID
	 * @param
	 * @throws Exception 
	 */
	@RequestMapping(value="/deleteLamp")
	@ResponseBody
	public Object deleteLamp(@RequestParam String id) throws Exception{
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		logBefore(logger, Jurisdiction.getUsername()+"删除网关终端类型");
		Map<String,String> map = new HashMap<String,String>();
		PageData pd = new PageData();
		pd.put("id", id);
		PageData pg  = clienttypeService.getClientTypeCount(pd);
		String count = pg.get("count").toString();
		String errInfo = "success";
		if("0".equals(count)){
			clienttypeService.delLamp(pd);	//执行删除
		} else {
			errInfo = "false";
		}
			
		map.put("result", errInfo);// 执行成功
		return AppUtil.returnObject(new PageData(), map);
	}
}
