package com.fh.controller.strategy;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.entity.system.GatewayStrategy;
import com.fh.entity.system.User;
import com.fh.service.fhoa.department.DepartmentManager;
import com.fh.service.strategy.Strategy2ApplyManager;
import com.fh.service.strategy.Strategy2Manager;
import com.fh.service.strategy.StrategyManager;
import com.fh.service.strategy.StrategySetApplyManager;
import com.fh.service.strategy.StrategySetManager;
import com.fh.service.strategy.StrategySetOperateManager;
import com.fh.service.system.fhlog.FHlogManager;
import com.fh.service.system.menu.MenuManager;
import com.fh.service.system.user.UserManager;
import com.fh.util.AppUtil;
import com.fh.util.Const;
import com.fh.util.Jurisdiction;
import com.fh.util.PageData;
import com.fh.util.StringUtil;

/**
 * 类名称：StrategyOperateController 创建人：wap 更新时间：2017年7月30日
 * 
 * @version
 */
@Controller
@RequestMapping(value = "/strategy")
public class StrategySetOperateController extends BaseController {

	String menuUrl = "/strategy/insertApplySet.do"; // 菜单地址(权限用)
	@Resource(name = "userService")
	private UserManager userService;
	@Resource(name = "menuService")
	private MenuManager menuService;
	@Resource(name = "fhlogService")
	private FHlogManager FHLOG;
	@Resource(name = "strategy2Service")
	private Strategy2Manager strategy2Service;
	@Resource(name = "strategy2ApplyService")
	private Strategy2ApplyManager strategy2ApplyService;
	@Resource(name = "strategySetService")
	private StrategySetManager strategySetService;
	@Resource(name = "strategySetOperateService")
	private StrategySetOperateManager strategySetOperateService;
	@Resource(name = "strategySetApplyService")
	private StrategySetApplyManager strategySetApplyService;
	@Resource(name = "departmentService")
	private DepartmentManager departmentService;

	@Resource(name = "sqlSessionTemplate")
	private SqlSessionTemplate sqlSessionTemplate;

	/**
	 * 应用所选策略包
	 */
	@RequestMapping(value = "/insertApplySet")
	@ResponseBody
	public Object insertApplySet() throws Exception {
		logBefore(logger, "应用策略包开始");
		
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		
		// 获得登录的用户id
		User user = (User) Jurisdiction.getSession().getAttribute(Const.SESSION_USER);
		String sys_user_id = user.getUSER_ID();
		pd.put("sys_user_id", sys_user_id);
		System.out.println(sys_user_id);

		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");// 设置日期格式
		String tdate = df.format(new Date());
		pd.put("tdate", tdate); // 创建时间
		System.out.println(tdate);

		String userids = departmentService.getUseridsInDepartment(pd);
		pd.put("userids", userids);

		String termId = pd.getString("c_term_id"); // 分组ID
		pd.put("c_term_id", termId);
		System.out.println(termId);

		String strategysetIds = pd.getString("strategyset_ids"); // 策略包ID
//		pd.put("strategyset_ids", "("+strategysetIds+")");

		Page page = new Page();
		page.setPd(pd);;
		
		// 查询分组ID所包含所有网关
		List<PageData> gatewayList = strategySetOperateService.getGatewayListByTermId(pd);
		if (gatewayList == null) {
			logBefore(logger, "平台未领取网关");
			logBefore(logger, "应用策略包异常结束");
			map.put("result", "failed.");
			map.put("msg", "平台未领取网关");
			return AppUtil.returnObject(pd, map);
		}

		// 判断是否网关策略是否超载
		if(isStrategyNumOver(strategysetIds, gatewayList)) {
			logBefore(logger, "超出网关最大承载策略数量");
			logBefore(logger, "应用策略包异常结束");
			map.put("result", "failed.");
			map.put("msg", "超出网关最大承载策略数量");
			return AppUtil.returnObject(pd, map);
		}
		
		strategySetOperateService.insertApplyStrategySet(page, gatewayList);
		logBefore(logger, "应用策略包结束");

		map.put("result", "success");
		return AppUtil.returnObject(pd, map);
	}

	/**
	 * 删除所选策略包
	 */
	@RequestMapping(value = "/delApplySet")
	@ResponseBody
	public Object delApplySet() throws Exception {
		logBefore(logger, "删除所选策略包开始");

		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = new PageData();
		pd = this.getPageData();

		// 获得登录的用户id
		User user = (User) Jurisdiction.getSession().getAttribute(Const.SESSION_USER);
		String sys_user_id = user.getUSER_ID();
		pd.put("sys_user_id", sys_user_id);
		System.out.println(sys_user_id);

		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");// 设置日期格式
		String tdate = df.format(new Date());
		pd.put("tdate", tdate); // 创建时间
		System.out.println(tdate);

		String termId = pd.getString("c_term_id"); // 分组ID
		pd.put("c_term_id", termId);
		System.out.println(termId);

		String strategysetId = pd.getString("strategyset_id"); // 应用策略包ID
		pd.put("strategyset_id", strategysetId);
		
		// 根据策略ID查找网关
		Page page = new Page();
		page.setPd(pd);

		// orderby c_gateway_id
		List<PageData> strategyGatewayList = strategySetOperateService.getGatewayStrategy(pd);
		if (strategyGatewayList == null) {
			logBefore(logger, "无可删除网关策略");
			map.put("result", "failed.");
			return AppUtil.returnObject(pd, map);
		}
		
		strategySetOperateService.deleteAppliedStrategySet(page, strategyGatewayList);

		logBefore(logger, "删除所选策略包结束");
		map.put("result", "success");
		return AppUtil.returnObject(pd, map);
	}	


	/**
	 * 判断是否超过每个网关的策略承载数
	 * 
	 * @param commandList 所有策略命令
	 * @return true 超过; false 未超过
	 * @throws Exception
	 */
	private boolean isStrategyNumOver(String strategysetIds, List<PageData> gatewayList) throws Exception {
		// 查询指定策略包中所有有效策略数量
		Page page = new Page();
		PageData pd = new PageData();
		pd.put("strategyset_ids", "("+strategysetIds+")");
		page.setPd(pd);			
		PageData countPd = strategy2Service.getStrategy2CountBySetId(page);		
		int strategyNum = Integer.valueOf(countPd.get("number").toString());
		
		for (int gw = 0; gw < gatewayList.size(); gw++) {
			PageData gwPd = gatewayList.get(gw);
			String gatewayId = String.valueOf(gwPd.get("c_gateway_id"));
			// 根据网关ID获取已生成的网关序列号
			pd.put("c_gateway_id", gatewayId);			
			PageData strategyGatewayPd = strategySetOperateService.getStrategyNumByGatewayId(pd);
			
			int strategyGatewayNum = Integer.valueOf(strategyGatewayPd.get("number").toString());
			
			if ((strategyNum + strategyGatewayNum) > 100) {
				return true;
			}
		}

		return false;
	}

	@InitBinder
	public void initBinder(WebDataBinder binder) {
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format, true));
	}

}
