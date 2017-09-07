package com.fh.controller.map;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.entity.map.JsonResultBean;
import com.fh.entity.map.JsonStatus;
import com.fh.entity.map.c_client;
import com.fh.entity.map.c_term;
import com.fh.entity.map.draw_client;
import com.fh.service.map.C_clientManager;
import com.fh.service.system.fhlog.FHlogManager;
import com.fh.util.Jurisdiction;
import com.fh.util.PageData;

@Controller
@RequestMapping(value="/gomap")
public class MapContentController extends BaseController{
	
	String menuUrl = "gomap/content.do"; //菜单地址(权限用)
	@Resource(name="c_clientService")
	private C_clientManager c_clientService;
	
	 @Resource(name="fhlogService")
		private FHlogManager fhlogService;
	
	
	
	@RequestMapping(value="/content")
	public ModelAndView content()throws Exception{
		//System.out.println(1);
		ModelAndView mv = this.getModelAndView();
		mv.setViewName("map/mapContent");	
		return mv;
	}
	// 左边列表的controller
		@RequestMapping(value = "/lefe_c", method = RequestMethod.POST)
		public @ResponseBody HashMap<Integer, List<c_client>> getLeft_c(HttpServletRequest request,
				@RequestBody c_client p) throws Exception {
			List<c_term> listct = c_clientService.queryAllterm();
			HashMap<Integer, List<c_client>> left_c = new HashMap<Integer, List<c_client>>();
			//查询所有分组的等
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
					//if(listc.size()==0){more.setTermname(more.getTermname()+"(该分组没有成员)");}
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
		public @ResponseBody List<c_client> lefe_cnext(HttpServletRequest request, @RequestBody c_client p) throws Exception {
			if(p.getTermid()!=-999){
			List<c_client> listc = c_clientService.queryAllterm_client(p);
			int totalcount = c_clientService.queryCountterm_client(p);
			//c_client more = new c_client(p);
			c_client more = new c_client();
			more.setXcoordinate(120.147428);
			more.setYcoordinate(30.277798);
			more.setHavenest(true);
			if ((p.getBegin() + p.getRows()) >= totalcount) {
				more.setHavenest(false);
			}
			listc.add(more);
			return listc;
			}else{
				List<c_client> listc = c_clientService.queryAllterm_gateway(p);
				int totalcount = c_clientService.queryCountgateway(p);
				//c_client more = new c_client(p);
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
			c_term ct=new c_term();
			ct.setId(-999);
			ct.setName("网关/断路器组");
			listct.add(ct);
			return listct;
		}

		@RequestMapping(value = "/getTypenameByGroup/{groupname}")
		public @ResponseBody List<c_client> getTypenameByGroup(@PathVariable("groupname") int groupnameid) throws Exception {
			if(groupnameid!=-999){
			List<c_client> listcype = c_clientService.getTypenameByGroup(groupnameid);
			return listcype;
			}else{
			List<c_client> listgype = c_clientService.getTypenameByGroupGateway(groupnameid);
			return listgype;
			}

		}

		@RequestMapping(value = "/getAddressByType", method = RequestMethod.POST)
		public @ResponseBody List<c_client> getAddressByType(HttpServletRequest request, @RequestBody c_client cc) throws Exception {
			
			if(cc.getTermid()!=-999){
				List<c_client> listcype = c_clientService.getAddressByType(cc);
				return listcype;
			}else
			{
				List<c_client> listgype = c_clientService.getAddressByTypeGataway(cc);
				return listgype;
				
			}

		}

		@RequestMapping(value = "/getClientnameByaddress", method = RequestMethod.POST)
		public @ResponseBody List<c_client> getClientnameByaddress(HttpServletRequest request, @RequestBody c_client cc) throws Exception {
			
			if(cc.getTermid()!=-999){
				List<c_client> listcype = c_clientService.getClientnameByaddress(cc);
				return listcype;
			}else
			{
				List<c_client> listgype = c_clientService.getClientnameByaddressGateway(cc);
				return listgype;
				
			}
			

		}

		@RequestMapping(value = "/getClientigByname", method = RequestMethod.POST)
		public @ResponseBody List<c_client> getClientigByname(HttpServletRequest request, @RequestBody c_client cc) throws Exception {
			if(cc.getTermid()!=-999){
				List<c_client> listcype = c_clientService.getClientigByname(cc);
				return listcype;
			}else
			{
				List<c_client> listgype = c_clientService.getClientigBynameGateway(cc);
				return listgype;
				
			}

		}

		
		
		// 获取第一次加载所需的termid
		@RequestMapping(value = "/getFirstTermId")
		public @ResponseBody int getFirstTermId() throws Exception {
			List<c_term> listct = c_clientService.queryAllterm();
			if (listct.size() != 0) {
				for(int i=0;i<listct.size();i++)
				{
					c_client c=new c_client();
					c.setTermid(listct.get(i).getId());
					int countCbytermid = c_clientService.queryCountterm_client(c);
					if(countCbytermid!=0)
					{
						return listct.get(i).getId();
					}
				}
			} else
				return -1000;
			return -1000;///////////////////????????
		}


		// 加载地图的maker
		@RequestMapping(value = "/addClientMaker", method = RequestMethod.POST)
		public @ResponseBody List<c_client> addClientMaker(HttpServletRequest request, @RequestBody c_client cc) throws Exception {
			if(-999!=cc.getTermid()){
				if(cc.getRows()!=0){
					List<c_client> clientlist = c_clientService.addClientMaker(cc);
					return clientlist;
					}else{ 
						if(cc.getDrawid().size()!=0){
							System.out.println(cc.getDrawid().size());
							List<c_client> cd = c_clientService.getClientByDraw(cc.getDrawid());
							//System.out.println("1111111111111111111111");
							System.out.println(cd.size());
							return cd;
						}else{
							List<c_client> clientlist = c_clientService.getSearchClient(cc);
							return clientlist;
							}
			}
			}else{
				if(cc.getRows()!=0){
					List<c_client> gatewaylist = c_clientService.queryAllterm_gateway(cc);					
					return gatewaylist;
					}else{
						if(cc.getDrawid().size()!=0){
							//System.out.println(cc.getDrawid().size());
							List<c_client> cd = c_clientService.getGatewayByDraw(cc.getDrawid());
							//System.out.println("1111111111111111111111");
							//System.out.println(cd.size());
							return cd;
						}else{
							List<c_client> gatewaylist = c_clientService.getSearchGateway(cc);					
							return gatewaylist;
					}
				}
			}
			
		}

		// 根据搜索条件加载maker
		@RequestMapping(value = "/getSearchClient", method = RequestMethod.POST)
		public @ResponseBody List<c_client> getSearchClient(HttpServletRequest request, @RequestBody c_client cc) throws Exception {
			if(cc.getTermid()!=-999){
				List<c_client> clientlist = c_clientService.getSearchClient(cc);
				return clientlist;
			}else{
					List<c_client> glist = c_clientService.getSearchGateway(cc);
					return glist;
			}
		}

		
		
		// 改变终端通断电
		@RequestMapping(value = "/updateClientAttr_status", method = RequestMethod.POST)
		public @ResponseBody JsonResultBean updateClientAttr_status(HttpServletRequest request, @RequestBody c_client cc) throws Exception {
			c_clientService.updateClientAttr_status(cc);
			JsonResultBean result = new JsonResultBean();
			result.setStatus(JsonStatus.SUCCESS);
			return result;
		}
		
		// 改变框选终端通断电
		@RequestMapping(value = "/updateClientDraw_status", method = RequestMethod.POST)
		public @ResponseBody JsonResultBean updateClientDraw_status(HttpServletRequest request, @RequestBody draw_client dc) throws Exception {
	        //System.out.println(dc.getTakeid());
	        //System.out.println(dc.getDrawid().size());
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

}
