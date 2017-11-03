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
	@Transactional
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
		pd.put("strategyset_ids", "("+strategysetIds+")");
		String[] strategysets = strategysetIds.split(",");

		Page page = new Page();
		page.setPd(pd);

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
		if(isStrategyNumOver(page, gatewayList)) {
			logBefore(logger, "超出网关最大承载策略数量");
			logBefore(logger, "应用策略包异常结束");
			map.put("result", "failed.");
			map.put("msg", "超出网关最大承载策略数量");
			return AppUtil.returnObject(pd, map);
		}

			
		List<String> strategySetApplyIds = new ArrayList<String>();
		if (gatewayList.size() > 0) {
			for(int i=0; i<strategysets.length; i++) {
				// 登录《应用策略包:b_strategy_term_apply》表
				pd.put("b_strategyset_apply_id", "");
				pd.put("strategyset_id", strategysets[i]);
				strategySetApplyService.addStrategySet(pd);
				// 登录《应用策略包中策略:b_ctrl_strategy2_apply》表
				strategy2ApplyService.addStrategy2(pd);
				
				strategySetApplyIds.add(pd.get("b_strategyset_apply_id").toString());
			}
		}

		// 查询应用策略包所包含所有应用策略
		String setApplyString = StringUtils.join((String[])strategySetApplyIds.toArray(new String[strategySetApplyIds.size()]),",");
		pd.put("strategyset_ids", "("+setApplyString+")");
		List<PageData> strategy2ApplyList = strategy2ApplyService.findStrategy2BySetIds(page);
		
		for (int i = 0; i < strategy2ApplyList.size(); i++) {
			PageData pdStrategy2 = strategy2ApplyList.get(i);
			String strategy2Id = pdStrategy2.get("id").toString();
			
			pd.put("b_ctrl_strategy_id", strategy2Id);

			// 登录《策略与网关控制组对应表:b_strategy_gatewayterm》表
			// 登录《策略与平台组对应表:b_strategy_clientterm》表
			strategySetOperateService.addGroup(pd);
		}
		
		// 根据网关ID生成网关策略表序列号,1网关ID对应策略100条
		for (int gw = 0; gw < gatewayList.size(); gw++) {
			PageData gwPd = gatewayList.get(gw);
			String gatewayId = String.valueOf(gwPd.get("c_gateway_id"));
			// 命令内容
			List<String> oneCmdList = new ArrayList<String>();

			// 根据网关ID获取已生成的网关序列号
			pd.put("c_gateway_id", gatewayId);
			List<PageData> gatewayStrategyList = strategySetOperateService.getGatewayStrategyByGatewayId(pd);

			// 存在已生成的网关序列号
			if (gatewayStrategyList != null && gatewayStrategyList.size() > 0) {
				// TODO 序列号超过100,数据回滚,抛出错误
//				if ((strategy2ApplyList.size() + gatewayStrategyList.size()) > 100) {
//					logBefore(logger, "超出网关最大承载策略数量");
//					logBefore(logger, "应用策略包异常结束");
//					map.put("result", "failed.");
//					map.put("msg", "超出网关最大承载策略数量");
//					return AppUtil.returnObject(pd, map);
//					throw new Exception("超出网关最大承载策略数量");
//				}

				// 序列号使用状况初始化最多100
				int[][] serialNoSts = new int[100][1];
				for (int i = 0; i < 100; i++) {
					serialNoSts[i][0] = 0; // 未使用
				}

				for (int i = 0; i < gatewayStrategyList.size(); i++) {
					// 序列号
					int getwayStrategy = Integer.parseInt(gatewayStrategyList.get(i).get("b_gateway_strategy").toString());
					serialNoSts[getwayStrategy - 1][0] = 1; // 已使用
				}

				// 分配序列号
				int serialNo = 0;
				for (int i = 0; i < strategy2ApplyList.size(); i++) {
					PageData pdStrategy2 = strategy2ApplyList.get(i);
					String strategy2Id = pdStrategy2.get("id").toString();

					for (int j = serialNo; j < 100; j++) {
						if (serialNoSts[j][0] == 0) {
							serialNo = j + 1;
							pd.put("b_gateway_strategy_id", "");
							pd.put("c_gateway_id", gatewayId);
							pd.put("b_ctrl_strategy_id", strategy2Id);

							pd.put("b_gateway_strategy", serialNo); // 网关序列号
							strategySetOperateService.insertGatewayStrategy(pd); // 网关策略对应表
							strategySetOperateService.insertStrategyGatewayTerm2(pd); // 网关策略与网关控制分组对应表

							pd.put("b_cmd_type_id", "12");
							String oneCmd = getOneCmd(gatewayId, strategy2Id, serialNo);
							oneCmdList.add(oneCmd);
							pd.put("cmd", oneCmd);
							strategySetOperateService.insertGatewayStrategyCmd(pd); // 网关策略内容表
							break;
						}
					}
				}
			} else {
				// 不存在已生成的网关序列号
				for (int i = 0; i < strategy2ApplyList.size(); i++) {
					PageData pdStrategy2 = strategy2ApplyList.get(i);
					String strategy2Id = pdStrategy2.get("id").toString();

					pd.put("b_gateway_strategy_id", "");
					pd.put("c_gateway_id", gatewayId);
					pd.put("b_ctrl_strategy_id", strategy2Id);

					pd.put("b_gateway_strategy", i + 1);
					strategySetOperateService.insertGatewayStrategy(pd); // 网关策略对应表
					strategySetOperateService.insertStrategyGatewayTerm2(pd); // 网关策略与网关控制分组对应表

					pd.put("b_cmd_type_id", "12");
					String oneCmd = getOneCmd(gatewayId, strategy2Id, i + 1);
					oneCmdList.add(oneCmd);
					pd.put("cmd", oneCmd);
					strategySetOperateService.insertGatewayStrategyCmd(pd); // 网关策略内容表

				}
			}
			
			// 【计划个数,网关策略序列号1、网关策略序列号2、网关策略序列号3...】
			// 一次最多下发35个计划
			List<String> cmdLineList = getCmdLineList(oneCmdList, ";");
			if (cmdLineList.size() > 0) {
				pd.put("b_user_log_id", "");
				pd.put("b_log_type_id", "9");
				pd.put("comment", "应用策略包");
				// 插入用户日志表
				strategySetOperateService.insertUserLog(pd);

				for (int i = 0; i < cmdLineList.size(); i++) {
					pd.put("status", "1");
					pd.put("b_cmd_type_id", "12");
					pd.put("cmd", cmdLineList.get(i));
					// 插入终端日志/命令表
					strategySetOperateService.insertClientLog(pd);
				}
			}
		}

		logBefore(logger, "应用策略包结束");

		map.put("result", "success");
		return AppUtil.returnObject(pd, map);
	}

	/**
	 * 删除所选策略包
	 */
	@RequestMapping(value = "/delApplySet")
	@ResponseBody
	@Transactional
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
		
		// 删除下列表
		// b_gateway_strategy_cmd 网关策略内容表
		// b_strategy_gatewayterm2 网关策略与网关控制分组对应表
		// b_gateway_strategy 网关策略对应表
		// b_strategy_gatewayterm 策略与网关控制组对应表
		// b_strategy_clientterm 策略与平台对应表
		// b_ctrl_strategy2_apply 应用策略表
		// b_strategy_term_apply 应用策略包表
		strategySetOperateService.deleteApplyStragySet(pd);

		// 根据网关ID把策略ID分组
		Map<String, Object> getwayMap = groupGateway(strategyGatewayList);
		Iterator<Entry<String, Object>> it = getwayMap.entrySet().iterator();
		while (it.hasNext()) {
			Map.Entry<String, Object> entry = it.next();
			String gatewayId = entry.getKey();
			List<GatewayStrategy> list = (List<GatewayStrategy>) entry.getValue();
			// 命令内容
			List<String> oneCmdList = new ArrayList<String>();

			pd.put("c_gateway_id", gatewayId);
			for (int i = 0; i < list.size(); i++) {
				// 网关策略序列号
				String gatewayStrategy = list.get(i).getGateway_strategy();
				logBefore(logger, "网关策略对应表ID:" + gatewayId + " 网关策略序列号:" + gatewayStrategy);
				oneCmdList.add(gatewayStrategy);
			}

			// 【计划个数,网关策略序列号1、网关策略序列号2、网关策略序列号3...】
			// 一次最多下发35个计划
			List<String> cmdLineList = getCmdLineList(oneCmdList, "、");

			if (cmdLineList.size() > 0) {
				pd.put("b_user_log_id", "");
				pd.put("b_log_type_id", "9");
				pd.put("comment", "注销策略包");
				// 插入用户日志表
				strategySetOperateService.insertUserLog(pd);

				for (int i = 0; i < cmdLineList.size(); i++) {
					pd.put("status", "1");
					pd.put("b_cmd_type_id", "32");
					pd.put("cmd", cmdLineList.get(i));
					// 插入终端日志/命令表
					strategySetOperateService.insertClientLog(pd);
				}
			}
		}		
		

		logBefore(logger, "删除所选策略包结束");

		map.put("result", "success");
		return AppUtil.returnObject(pd, map);
	}	

	/**
	 * 根据网关ID分组
	 * 
	 * @param strategyGatewayTermList
	 * @return 分组后Map
	 */
	private Map<String, Object> groupGateway(List<PageData> strategyGatewayList) {

		Map<String, Object> getwayMap = new HashMap<String, Object>();
		String gatewayIdBef = "";
		List<GatewayStrategy> gatewayStrategyMapList = new ArrayList<GatewayStrategy>();
		for (int i = 0; i < strategyGatewayList.size(); i++) {
			String gatewayId = strategyGatewayList.get(i).get("c_gateway_id").toString();
			String gateway_strategy = strategyGatewayList.get(i).get("b_gateway_strategy").toString();

			if (!gatewayId.equals(gatewayIdBef)) {
				if (gatewayStrategyMapList.size() != 0) {
					getwayMap.put(gatewayIdBef, gatewayStrategyMapList);
				}

				GatewayStrategy gatewayStrategy = new GatewayStrategy();
				gatewayStrategy.setGateway_id(gatewayId);
				gatewayStrategy.setGateway_strategy(gateway_strategy);

				gatewayStrategyMapList = new ArrayList<GatewayStrategy>();
				gatewayStrategyMapList.add(gatewayStrategy);
				gatewayIdBef = gatewayId;
			} else {
				GatewayStrategy gatewayStrategy = new GatewayStrategy();
				gatewayStrategy.setGateway_id(gatewayId);
				gatewayStrategy.setGateway_strategy(gateway_strategy);

				gatewayStrategyMapList.add(gatewayStrategy);
			}
		}
		getwayMap.put(gatewayIdBef, gatewayStrategyMapList);

		return getwayMap;
	}

	/**
	 * 获得指定策略内容做成的命令行 格式
	 * 计划1编号,定时调节,开始日期,结束日期,执行月,执行日,执行时间,执行组号,亮度,灯色;计划2编号,定时调节,开始日期,结束日期,执行月,执行日,执行时间,执行组号,亮度,灯色;....
	 * 
	 * @param gatewayId
	 *            网关ID
	 * @param strategyId
	 *            策略ID
	 * @param gatewayStrategy
	 *            网关序列号
	 * @return 格式化命令行
	 * @throws Exception
	 */
	private String getOneCmd(String gatewayId, String strategyId, int gatewayStrategy) throws Exception {
		PageData pd = new PageData();
		pd.put("c_gateway_id", gatewayId);
		pd.put("b_ctrl_strategy_id", strategyId);
		pd = strategySetOperateService.getStrategyGatewayTeamByStrategyGateway(pd);

		if (pd == null)
			return "";

		String cmd = gatewayStrategy + "," + pd.get("b_strategy_type_id") + "," + pd.get("datetime1") + ","
				+ pd.get("datetime2") + ",";
		;

		if (pd.get("b_strategy_type_id").toString().equals("1")) {
			// 定时调节
			cmd = cmd + pd.get("month") + "," + pd.get("day") + ",";
		} else if (pd.get("b_strategy_type_id").toString().equals("2")) {
			// 周期调节
			cmd = cmd + pd.get("period") + "," + pd.get("days") + ",";
		}
		cmd = cmd + pd.get("time") + "," + pd.get("gateway_team") + "," + pd.get("bright") + "," + pd.get("value");

		return cmd;
	}

	/**
	 * 获得命令行内容
	 * 
	 * @param commandList 所有策略命令
	 * @return 命令行
	 * @throws Exception
	 */
	private List<String> getCmdLineList(List<String> commandList, String separator) {
		List<String> retCmdList = new ArrayList<String>();

		while (commandList.size() > 35) {
			List<String> oneCmdList = commandList.subList(0, 35);
			commandList = commandList.subList(35, commandList.size());

			String oneCmd = StringUtils.join(oneCmdList, separator);
			retCmdList.add(oneCmdList.size() + "," + oneCmd);
		}

		if (commandList.size() > 0) {
			// 计划设置个数
			retCmdList.add(commandList.size() + "," + StringUtils.join(commandList, separator));
		}
		return retCmdList;
	}

	/**
	 * 判断是否超过每个网关的策略承载数
	 * 
	 * @param commandList 所有策略命令
	 * @return true 超过; false 未超过
	 * @throws Exception
	 */
	private boolean isStrategyNumOver(Page page, List<PageData> gatewayList) throws Exception {
		PageData countPd = strategy2Service.getStrategy2CountBySetId(page);
		int strategyNum = Integer.valueOf(countPd.get("number").toString());
		
		PageData pd = page.getPd();
		
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
