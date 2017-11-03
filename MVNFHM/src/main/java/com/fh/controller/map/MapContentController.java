package com.fh.controller.map;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.session.Session;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.entity.map.JsonResultBean;
import com.fh.entity.map.JsonStatus;
import com.fh.entity.map.c_client;
import com.fh.entity.map.c_partmap;
import com.fh.entity.map.c_term;
import com.fh.entity.map.draw_client;
import com.fh.entity.system.User;
import com.fh.service.map.C_clientManager;
import com.fh.service.system.fhlog.FHlogManager;
import com.fh.service.system.user.UserManager;
import com.fh.util.AppUtil;
import com.fh.util.Const;
import com.fh.util.FileUpload;
import com.fh.util.Jurisdiction;
import com.fh.util.PageData;
import com.fh.util.PathUtil;

@Controller
@RequestMapping(value = "/gomap")
public class MapContentController extends BaseController {

	String menuUrl = "gomap/content.do"; // 菜单地址(权限用)
	// 局部地图页面
	private String partmapJsp = "map/partmap_list";
	@Resource(name = "c_clientService")
	private C_clientManager c_clientService;

	@Resource(name = "fhlogService")
	private FHlogManager fhlogService;
	@Resource(name = "userService")
	private UserManager userService;

	/**
	 * add part map to db, and
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/addpartmap")
	public ModelAndView addpartmap(Page page) throws Exception {
		logBefore(logger, "根据用户名获取会员信息");
		// System.out.println(1);
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		// List<PageData> lstpartMapInfo =
		// c_clientService.getCountClientfromPartMap(page);
		// mv.addObject("result", "success");
		// mv.addObject("varList", lstpartMapInfo);
		mv.addObject("pd", pd);
		mv.setViewName("map/partmap_add");
		return mv;
	}

	/**
	 * 上传局部图
	 * 
	 * @param file
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/readMapJPG")
	public ModelAndView readMapJPG(@RequestParam(value = "mappic", required = false) MultipartFile file,
			HttpServletRequest request) throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String fileName = null;
		String filePath = null;
		if (null != file && !file.isEmpty()) {
			filePath = PathUtil.getClasspath() + Const.FILEPATHMAPIMG; //
			// 文件上传路径
			logBefore(logger, filePath + " uploaded file path");
			String xypointFileName = request.getParameter("xycoordinate");
			xypointFileName = xypointFileName.replace(".", "-").replace(".", "-");
			// filePath =
			// "C:\\loucg\\github\\git\\MVNFHM\\src\\main\\webapp\\uploadFiles\\uploadImgs\\partmap\\";
			fileName = FileUpload.fileUp(file, filePath, xypointFileName); // 执行上传

			if (null != request.getParameter("xycoordinate")) {
				pd.put("XPoint", request.getParameter("xycoordinate").split(",")[0]);
				pd.put("YPoint", request.getParameter("xycoordinate").split(",")[1]);
			}
			// fileName.replaceAll(".", "-");
			// 保存局部图概要信息
			c_partmap cp = new c_partmap();
			cp.setId(request.getParameter("partMapid"));
			cp.setC_termid(request.getParameter("termID"));
			cp.setExternal_coordinate(request.getParameter("xycoordinate"));
			cp.setMap_pictrue_path(fileName);
			cp.setPartmap_name(request.getParameter("mapPicName"));
			cp.setC_client_type_id("1");
			pd.put("mapPicName", request.getParameter("mapPicName"));
			if (cp.getId() != null && cp.getId().trim().length() > 0) {
				c_clientService.updatePartMapHeader(cp);

			} else {
				c_clientService.insertPartMapHeader(cp);
			}

			pd.put("partMapid", cp.getId());
			pd.put("termID", cp.getC_termid());
		}
		mv.addObject("pd", pd);
		mv.setViewName("map/partmap_add");
		mv.addObject("msg", "success");
		return mv;
	}

	// /**
	// * 同态路灯增加
	// *
	// * @param
	// * @return
	// * @throws Exception
	// */
	// @RequestMapping(value = "/addLight")
	// @ResponseBody
	// public Object addLight() throws Exception {
	// String sourceFilePath = "";
	// String waterFilePath = "";
	// String saveFilePath = "";
	// String filePath =
	// "C:\\Projects\\light\\git\\newSlight\\MVNFHM\\src\\main\\webapp\\uploadFiles\\uploadImgs\\partmap\\";
	// // String filePath = PathUtil.getClasspath() + Const.FILEPATHMAPIMG;
	// logBefore(logger, filePath + " File Path");
	// ModelAndView mv = this.getModelAndView();
	// PageData pd = new PageData();
	// Map<String, Object> map = new HashMap<String, Object>();
	// pd = this.getPageData();
	// NewImageUtils newImageUtils = new NewImageUtils();
	// sourceFilePath = filePath + pd.getString("picName");
	// waterFilePath = filePath + "light_green.png";
	// saveFilePath = filePath + pd.getString("picName");
	// String xpoint = pd.getString("XPoint");
	// String ypoint = pd.getString("YPoint");
	//
	// BufferedImage buffImg = NewImageUtils.watermark(new File(sourceFilePath),
	// new
	// File(waterFilePath),
	// Integer.parseInt(xpoint), Integer.parseInt(ypoint), 1.0f);
	// newImageUtils.generateWaterFile(buffImg, saveFilePath);
	// mv.setViewName("map/partmap_add");
	// mv.addObject("msg", "success");
	// List<PageData> pdList = new ArrayList<PageData>();
	// pdList.add(pd);
	// map.put("list", pdList);
	// return AppUtil.returnObject(pd, map);
	// }

	@RequestMapping(value = "/content")
	public ModelAndView content() throws Exception {
		// System.out.println(1);
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		mv.setViewName("map/mapContent");
		String companyid = getCompanyID();
		if ("1".equals(companyid)) {
			pd.put("maptype", "1");
		} else {
			pd.put("maptype", "2");
		}
		mv.addObject("pd", pd);
		return mv;
	}

	private String getCompanyID() throws Exception {
		Session session = Jurisdiction.getSession();
		User user = (User) session.getAttribute(Const.SESSION_USER); // 读取session中的用户信息(单独用户信息)
		if (user != null) {
			User userr = (User) session.getAttribute(Const.SESSION_USERROL); // 读取session中的用户信息(含角色信息)
			PageData company = userService.findcompanyByUsername(user.getUSERNAME());
			return company.getString("map_type");
		}
		return "";
	}

	// 左边列表的controller
	@RequestMapping(value = "/lefe_c", method = RequestMethod.POST)
	public @ResponseBody HashMap<Integer, List<c_client>> getLeft_c(HttpServletRequest request, @RequestBody c_client p)
			throws Exception {
		List<c_term> listct = c_clientService.queryAllterm();
		HashMap<Integer, List<c_client>> left_c = new HashMap<Integer, List<c_client>>();
		// 查询所有分组的等
		if (listct.size() != 0) {
			for (int i = 0; i < listct.size(); i++) {
				p.setTermid(listct.get(i).getId());
				c_client more = new c_client();
				more.setHavenest(true);
				more.setXcoordinate(120.147428);
				more.setYcoordinate(30.277798);
				more.setTermid(listct.get(i).getId());
				more.setTermname(listct.get(i).getName());
				List<c_client> listc = c_clientService.queryAllterm_client(p);
				// if(listc.size()==0){more.setTermname(more.getTermname()+"(该分组没有成员)");}
				int totalcount = c_clientService.queryCountterm_client(p);
				if ((p.getBegin() + p.getRows()) >= totalcount) {
					more.setHavenest(false);
				}
				listc.add(more);
				left_c.put(listct.get(i).getId(), listc);
			}
		}

		p.setTermid(-999);
		c_client more = new c_client();
		more.setHavenest(true);
		more.setTermid(-999);
		more.setXcoordinate(120.147428);
		more.setYcoordinate(30.277798);
		List<c_client> listg = c_clientService.queryAllterm_gateway(p);
		int totalcountg = c_clientService.queryCountgateway(p);
		if ((p.getBegin() + p.getRows()) >= totalcountg) {
			more.setHavenest(false);
		}
		listg.add(more);
		left_c.put(-999, listg);
		return left_c;
	}

	@RequestMapping(value = "/lefe_cnext", method = RequestMethod.POST)
	public @ResponseBody List<c_client> lefe_cnext(HttpServletRequest request, @RequestBody c_client p)
			throws Exception {
		if (p.getTermid() != -999) {
			List<c_client> listc = c_clientService.queryAllterm_client(p);
			int totalcount = c_clientService.queryCountterm_client(p);
			// c_client more = new c_client(p);
			c_client more = new c_client();
			more.setXcoordinate(120.147428);
			more.setYcoordinate(30.277798);
			more.setHavenest(true);
			if ((p.getBegin() + p.getRows()) >= totalcount) {
				more.setHavenest(false);
			}
			listc.add(more);
			return listc;
		} else {
			List<c_client> listc = c_clientService.queryAllterm_gateway(p);
			int totalcount = c_clientService.queryCountgateway(p);
			// c_client more = new c_client(p);
			c_client more = new c_client();
			more.setHavenest(true);
			more.setXcoordinate(120.147428);
			more.setYcoordinate(30.277798);
			if ((p.getBegin() + p.getRows()) >= totalcount) {
				more.setHavenest(false);
			}
			listc.add(more);
			return listc;
		}

	}

	// 正上方搜索条件的controller
	@RequestMapping(value = "/getgroupname")
	public @ResponseBody List<c_term> getGroupname() throws Exception {
		List<c_term> listct = c_clientService.queryAllterm();
		c_term ct = new c_term();
		ct.setId(-999);
		ct.setName("网关/断路器组");
		listct.add(ct);
		return listct;
	}

	@RequestMapping(value = "/getTypenameByGroup/{groupname}")
	public @ResponseBody List<c_client> getTypenameByGroup(@PathVariable("groupname") int groupnameid)
			throws Exception {
		if (groupnameid != -999) {
			List<c_client> listcype = c_clientService.getTypenameByGroup(groupnameid);
			return listcype;
		} else {
			List<c_client> listgype = c_clientService.getTypenameByGroupGateway(groupnameid);
			return listgype;
		}

	}

	@RequestMapping(value = "/getAddressByType", method = RequestMethod.POST)
	public @ResponseBody List<c_client> getAddressByType(HttpServletRequest request, @RequestBody c_client cc)
			throws Exception {

		if (cc.getTermid() != -999) {
			List<c_client> listcype = c_clientService.getAddressByType(cc);
			return listcype;
		} else {
			List<c_client> listgype = c_clientService.getAddressByTypeGataway(cc);
			return listgype;

		}

	}

	@RequestMapping(value = "/getClientnameByaddress", method = RequestMethod.POST)
	public @ResponseBody List<c_client> getClientnameByaddress(HttpServletRequest request, @RequestBody c_client cc)
			throws Exception {

		if (cc.getTermid() != -999) {
			List<c_client> listcype = c_clientService.getClientnameByaddress(cc);
			return listcype;
		} else {
			List<c_client> listgype = c_clientService.getClientnameByaddressGateway(cc);
			return listgype;

		}

	}

	@RequestMapping(value = "/getClientigByname", method = RequestMethod.POST)
	public @ResponseBody List<c_client> getClientigByname(HttpServletRequest request, @RequestBody c_client cc)
			throws Exception {
		if (cc.getTermid() != -999) {
			List<c_client> listcype = c_clientService.getClientigByname(cc);
			return listcype;
		} else {
			List<c_client> listgype = c_clientService.getClientigBynameGateway(cc);
			return listgype;

		}

	}

	// 获取第一次加载所需的termid
	@RequestMapping(value = "/getFirstTermId")
	public @ResponseBody int getFirstTermId() throws Exception {
		List<c_term> listct = c_clientService.queryAllterm();
		if (listct.size() != 0) {
			for (int i = 0; i < listct.size(); i++) {
				c_client c = new c_client();
				c.setTermid(listct.get(i).getId());
				int countCbytermid = c_clientService.queryCountterm_client(c);
				if (countCbytermid != 0) {
					return listct.get(i).getId();
				}
			}
		} else
			return -1000;
		return -1000;/////////////////// ????????
	}

	// 加载地图的maker
	@RequestMapping(value = "/addClientMaker", method = RequestMethod.POST)
	public @ResponseBody List<c_client> addClientMaker(HttpServletRequest request, @RequestBody c_client cc)
			throws Exception {
		if (-999 != cc.getTermid()) {
			if (cc.getRows() != 0) {
				List<c_client> clientlist = c_clientService.addClientMaker(cc);
				return clientlist;
			} else {
				if (cc.getDrawid().size() != 0) {
					System.out.println(cc.getDrawid().size());
					List<c_client> cd = c_clientService.getClientByDraw(cc.getDrawid());
					// System.out.println("1111111111111111111111");
					System.out.println(cd.size());
					return cd;
				} else {
					List<c_client> clientlist = c_clientService.getSearchClient(cc);
					return clientlist;
				}
			}
		} else {
			if (cc.getRows() != 0) {
				List<c_client> gatewaylist = c_clientService.queryAllterm_gateway(cc);
				return gatewaylist;
			} else {
				if (cc.getDrawid().size() != 0) {
					// System.out.println(cc.getDrawid().size());
					List<c_client> cd = c_clientService.getGatewayByDraw(cc.getDrawid());
					// System.out.println("1111111111111111111111");
					// System.out.println(cd.size());
					return cd;
				} else {
					List<c_client> gatewaylist = c_clientService.getSearchGateway(cc);
					return gatewaylist;
				}
			}
		}

	}

	// 根据搜索条件加载maker
	@RequestMapping(value = "/getSearchClient", method = RequestMethod.POST)
	public @ResponseBody List<c_client> getSearchClient(HttpServletRequest request, @RequestBody c_client cc)
			throws Exception {
		if (cc.getTermid() != -999) {
			List<c_client> clientlist = c_clientService.getSearchClient(cc);
			return clientlist;
		} else {
			List<c_client> glist = c_clientService.getSearchGateway(cc);
			return glist;
		}
	}

	// 改变终端通坐标
	@RequestMapping("/upateClientMakerCoordinate")
	@ResponseBody
	public Object updateClientAttr_Coordinate() throws Exception {
		PageData pd = new PageData();
		Map<String, Object> map = new HashMap<String, Object>();
		pd = this.getPageData();
		c_client cc = new c_client();
		cc.setClient_attri_id(pd.getString("client_attri_id"));
		cc.setCoordinate(pd.getString("coordinate"));
		cc.setClientType(pd.getString("clientType"));
		cc.setMapFlag(pd.getString("mapFlag"));
		c_clientService.updateClientAttr_Coordinate(cc);
		List<PageData> pdList = new ArrayList<PageData>();
		pdList.add(pd);

		return AppUtil.returnObject(pd, map);
	}

	// 删除终端通坐标
	@RequestMapping("/delPartMapInfo")
	@ResponseBody
	public Object delPartMapInfo() throws Exception {
		PageData pd = new PageData();
		Map<String, Object> map = new HashMap<String, Object>();
		pd = this.getPageData();
		c_partmap cp = new c_partmap();
		cp.setId(pd.getString("ID"));
		c_clientService.delPartMapDetail(cp);
		c_clientService.delPartMapHeader(cp);
		map.put("result", "success");
		return AppUtil.returnObject(pd, map);
	}

	// 删除终端通坐标
	@RequestMapping("/delPartMapDetail")
	@ResponseBody
	public Object delPartMapDetail() throws Exception {
		PageData pd = new PageData();
		Map<String, Object> map = new HashMap<String, Object>();
		pd = this.getPageData();
		c_partmap cp = new c_partmap();
		cp.setId(pd.getString("ID"));
		cp.setC_client_id((pd.getString("CLIENT_ID")));
		c_clientService.delPartMapDetail(cp);
		map.put("result", "success");
		return AppUtil.returnObject(pd, map);
	}

	// 保存局部地图及其附属的灯。
	@RequestMapping("/savePartMapToDetail")
	@ResponseBody
	public Object savePartMapToDetail() throws Exception {
		PageData pd = new PageData();
		Map<String, Object> map = new HashMap<String, Object>();
		pd = this.getPageData();
		c_partmap cp = new c_partmap();
		cp.setId(pd.getString("ID"));
		cp.setC_client_id(pd.getString("CLIENT_ID"));
		cp.setInner_coordinate(pd.getString("INNER_COORDINATE"));
		c_clientService.delPartMapDetail(cp);
		c_clientService.insertPartMapDetail(cp);
		List<PageData> pdList = new ArrayList<PageData>();
		pdList.add(pd);
		return AppUtil.returnObject(pd, map);
	}

	// 保存局部地图及其附属的灯。

	public Object savePartMapHeader(PageData pd) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		c_partmap cp = new c_partmap();
		cp.setC_termid(pd.getString("TERM_ID"));
		cp.setExternal_coordinate(pd.getString("EXTERNAL_COORDINATE"));
		cp.setMap_pictrue_path(pd.getString("PARTMAP_URL"));
		cp.setPartmap_name(pd.getString("PARTMAP_NAME"));
		cp.setC_client_type_id((pd.getString("CLIENT_TYPE")));
		c_clientService.insertPartMapHeader(cp);
		List<PageData> pdList = new ArrayList<PageData>();
		pdList.add(pd);
		return AppUtil.returnObject(pd, map);
	}

	// 获取终端通坐标
	@RequestMapping("/getClientInfo")

	public @ResponseBody List<c_client> getClientInfo() throws Exception {
		PageData pd = new PageData();
		pd = this.getPageData();
		c_client cc = new c_client();
		if (pd.getString("termid") != null) {
			cc.setTermid(Integer.parseInt(pd.getString("termid")));
		}
		cc.setClient_attri_id(pd.getString("clientid"));
		cc.setPartMap_Id(pd.getString("partMapID"));
		List<c_client> clientlist = c_clientService.getSearchClient(cc);
		return clientlist;

	}

	// 获取局部地图信息
	@RequestMapping("/getPartMapInfo")
	public @ResponseBody List<c_partmap> getPartMapInfo() throws Exception {
		PageData pd = new PageData();
		pd = this.getPageData();
		c_partmap cp = new c_partmap();
		cp.setId(pd.getString("partMapID"));
		cp.setC_termid((pd.getString("termid")));
		cp.setC_client_id(pd.getString("clinetid"));
		List<c_partmap> partMapInfo = c_clientService.getPartMapInfo(cp);
		return partMapInfo;

	}

	// 改变终端通断电
	@RequestMapping(value = "/updateClientAttr_status", method = RequestMethod.POST)
	public @ResponseBody JsonResultBean updateClientAttr_status(HttpServletRequest request, @RequestBody c_client cc)
			throws Exception {
		c_clientService.updateClientAttr_status(cc);
		JsonResultBean result = new JsonResultBean();
		result.setStatus(JsonStatus.SUCCESS);
		return result;
	}

	// 改变框选终端通断电
	@RequestMapping(value = "/updateClientDraw_status", method = RequestMethod.POST)
	public @ResponseBody JsonResultBean updateClientDraw_status(HttpServletRequest request, @RequestBody draw_client dc)
			throws Exception {
		// System.out.println(dc.getTakeid());
		// System.out.println(dc.getDrawid().size());
		c_clientService.updateClientDraw_status(dc);
		JsonResultBean result = new JsonResultBean();
		result.setStatus(JsonStatus.SUCCESS);
		return result;
	}

	// 改变电灯亮度值
	@RequestMapping(value = "/updateClientAttr_brightness", method = RequestMethod.POST)
	public @ResponseBody JsonResultBean updateClientAttr_brightness(HttpServletRequest request,
			@RequestBody c_client cc) throws Exception {
		c_clientService.updateClientAttr_brightness(cc);
		JsonResultBean result = new JsonResultBean();
		result.setStatus(JsonStatus.SUCCESS);
		return result;
	}

	/**
	 * 局部地图控制
	 * 
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/goPartMap")
	public ModelAndView goDeviceEdit(Page page) throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		List<PageData> lstpartMapInfo = c_clientService.getCountClientfromPartMap(page);
		mv.addObject("result", "success");
		mv.addObject("varList", lstpartMapInfo);
		mv.setViewName(partmapJsp);
		return mv;

	}

}
