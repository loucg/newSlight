package com.fh.controller.group;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.annotation.Resource;

import org.apache.shiro.session.Session;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.entity.system.GatewayStrategy;
import com.fh.entity.system.User;
import com.fh.service.fhoa.department.DepartmentManager;
import com.fh.service.group.GroupGatewayService;
import com.fh.service.group.mem.GroupMemService;
import com.fh.util.AppUtil;
import com.fh.util.Const;
import com.fh.util.Jurisdiction;
import com.fh.util.PageData;
import com.fh.util.Tools;

/**
 * 分组设置
 * @author xiaozhou
 * 创建时间：2017年1月17日
 */
@Controller
@RequestMapping(value="/group")
public class GroupGatewayController extends BaseController{

	String menuUrl = "group/listGateways.do";		//页面配置的菜单地址
    @Resource(name="groupGatewayService")
    private GroupGatewayService groupGatewayService;
    @Resource(name="departmentService")
    private DepartmentManager departmentService;
    @Resource(name="groupMemService")
    private GroupMemService groupMemService;

	
	/**
	 * 显示所有网关列表
	 * @param page
	 * @return
	 */
	@RequestMapping("/listGateways")
	public ModelAndView listGateways(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"显示所有网关列表");

		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String name = pd.getString("name");			//检索条件：名称
		if(null !=name && !"".equals(name)){
			pd.put("name", name.trim());
		}
		String code = pd.getString("code");				//检索条件：网关编码
		if(null !=code && !"".equals(code)){
			pd.put("code", code.trim());
		}
		String term_id = pd.getString("term_id");		//平台分组表ID
		if(null !=term_id && !"".equals(term_id)){
			pd.put("term_id", term_id.trim());
		}
		//获得登录的用户id
		User user = (User)Jurisdiction.getSession().getAttribute(Const.SESSION_USER);
		String sys_user_id = user.getUSER_ID();
		pd.put("sys_user_id", sys_user_id);
		
		String userids = departmentService.getUseridsInDepartment(pd);
		pd.put("userids", userids);

		page.setPd(pd);
		List<PageData> gatewayList = groupGatewayService.listGateways(page);	//获取列表

		Session session = Jurisdiction.getSession();
		
		boolean selected = false;
		if(session.getAttribute(session.getId())!=null) {
			selected = (boolean)session.getAttribute(session.getId());
		}
		// 统计所有网关所选终端
		if(gatewayList != null) {
			for(int i=0; i<gatewayList.size(); i++) {			
				PageData gateway = gatewayList.get(i);
				String gatewayId = gateway.get("gateway_id").toString();
				// 指定平台ID,网关ID所对应的被选择终端
				String client_ids="";
				if(selected) {
					client_ids = (String)session.getAttribute(session.getId()+"	"+term_id+"	"+gatewayId);
				}else {
					session.setAttribute(session.getId()+"	"+term_id+"	"+gatewayId, null);
				}
						
				// 被选择终端数整合网关的被选择终端数显示数据 选择数/总数
//				if(!Tools.isEmpty(gateway_id) && gateway_id.equals(gatewayId)) {
					String[] clientsArray = new String[0];
					if(!Tools.isEmpty(client_ids)) {
						clientsArray = client_ids.split(",");
					}			

					int number = Integer.parseInt(gateway.get("number").toString());
					for(int j=0;j<clientsArray.length;j++) {
						int selectednum = clientsArray.length;
						gateway.put("number", number + selectednum );
						gateway.put("client_ids", client_ids);
					}
//				}
			}
		}
		session.setAttribute(session.getId(), null);
					
		mv.setViewName("groupmanage/groupgateway_list");
		mv.addObject("gatewayList", gatewayList);
		mv.addObject("pd", pd);
		mv.addObject("QX", Jurisdiction.getHC());
		
		return mv;
	}

	
	/**
	 * 显示指定网关下所有终端列表
	 * @param page
	 * @return
	 */
	@RequestMapping("/listClients")
	public ModelAndView listClientsByGatewayId(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"显示指定网关下所有终端列表");

		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String name = pd.getString("name");				//检索条件：名称
		if(null !=name && !"".equals(name)){
			pd.put("name", name.trim());
		}
		String code = pd.getString("code");				//检索条件：终端条码
		if(null !=code && !"".equals(code)){
			pd.put("code", code.trim());
		}
		String term_id = pd.getString("term_id");		//平台分组表ID
		if(null !=term_id && !"".equals(term_id)){
			pd.put("term_id", term_id.trim());
		}
		String gateway_id = pd.getString("gateway_id");	//网关ID
		if(null !=gateway_id && !"".equals(gateway_id)){
			pd.put("gateway_id", gateway_id.trim());
		}

		String client_ids = pd.getString("client_ids");	//新选择的终端
		

		//获得登录的用户id
		User user = (User)Jurisdiction.getSession().getAttribute(Const.SESSION_USER);
		String sys_user_id = user.getUSER_ID();
		pd.put("sys_user_id", sys_user_id);
		
		String userids = departmentService.getUseridsInDepartment(pd);
		pd.put("userids", userids);
		
		page.setPd(pd);
		List<PageData> clientList = groupGatewayService.listClientsByGatewayId(page);	//获取列表
		
		//终端选择状态初始化
		if(clientList != null && !Tools.isEmpty(client_ids)) {
			String[] clientsArray = client_ids.split(",");
			for(int i=0; i<clientList.size(); i++) {
				PageData client = clientList.get(i);
				for(int j=0; j<clientsArray.length; j++) {
					if(clientsArray[j].equals(client.get("client_id").toString())){
						client.put("checked", "checked");
					}
				}
			}
		}
		
		mv.setViewName("groupmanage/groupclient_list");
		mv.addObject("clientList", clientList);
		mv.addObject("pd", pd);
		mv.addObject("QX", Jurisdiction.getHC());
		
		return mv;
	}
	
	
	/**
	 * 返回网关列表
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/toListGateways")
	public ModelAndView toListGateways() throws Exception{
		logBefore(logger,"返回网关列表");
		ModelAndView mv = this.getModelAndView();
		
		PageData pd = new PageData();
		pd = this.getPageData();
		
//		Map<String,Object> map = new HashMap<String,Object>();
		String term_id = pd.getString("term_id");
		String gateway_id = pd.getString("gateway_id");
		
		Session session = Jurisdiction.getSession();
		if(!Tools.isEmpty(gateway_id)) {
//			map.put(gateway_id, pd.getString("client_ids"));
			session.setAttribute(session.getId()+"	"+term_id+"	"+gateway_id, pd.getString("client_ids"));		
		}
		session.setAttribute(session.getId(),true);
				
		mv.addObject("msg","");
		mv.setViewName("save_result");
		return mv;
	}
	
}
