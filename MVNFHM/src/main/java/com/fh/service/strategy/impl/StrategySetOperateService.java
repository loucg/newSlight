package com.fh.service.strategy.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.entity.system.GatewayStrategy;
import com.fh.service.fhoa.department.DepartmentManager;
import com.fh.service.strategy.Strategy2ApplyManager;
import com.fh.service.strategy.Strategy2Manager;
import com.fh.service.strategy.StrategySetApplyManager;
import com.fh.service.strategy.StrategySetManager;
import com.fh.service.strategy.StrategySetOperateManager;
import com.fh.service.system.fhlog.FHlogManager;
import com.fh.service.system.menu.MenuManager;
import com.fh.service.system.user.UserManager;
import com.fh.util.Logger;
import com.fh.util.PageData;

/**
 * 应用策略包中策略的下发/注销操作类
 * 
 * @001 2017/10/18 wap add
 */
@Service("strategySetOperateService")
public class StrategySetOperateService implements StrategySetOperateManager {
	private final Logger logger = Logger.getLogger(this.getClass());
	
	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	@Resource(name = "strategy2ApplyService")
	private Strategy2ApplyManager strategy2ApplyService;
	@Resource(name = "strategySetApplyService")
	private StrategySetApplyManager strategySetApplyService;

	/**
	 * 查询指定	分组所包含所有网关
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> getGatewayListByTermId(PageData pd) throws Exception{
		return (List<PageData>) dao.findForList("StrategySetOperateMapper.getGatewayListByTermId", pd);
	}
	
	/**
	 * 获取策略组中策略对应的所有网关控制分组列表
	 * 
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> getGatewayByStrategySetIds(Page page) throws Exception {
		return (List<PageData>) dao.findForList("StrategySetOperateMapper.getGatewayByStrategySetId", page);
	}
	
	/**
	 * 查询指定网关ID所对应的网管策略
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> getGatewayStrategyByGatewayId(PageData pd) throws Exception{
		return (List<PageData>) dao.findForList("StrategySetOperateMapper.getGatewayStrategyByGatewayId", pd);
	}
	
	/**
	 * 查询指定网关ID所对应的网管策略数
	 * @param pd
	 * @throws Exception
	 */
	public PageData getStrategyNumByGatewayId(PageData pd) throws Exception{
		return (PageData) dao.findForObject("StrategySetOperateMapper.getStrategyNumByGatewayId", pd);
	}
	
	/**
	 * 查询指定策略和网关对应的网关控制分组
	 * @param pd
	 * @throws Exception
	 */
	public PageData getStrategyGatewayTeamByStrategyGateway(PageData pd) throws Exception {
		return (PageData) dao.findForObject("StrategySetOperateMapper.getStrategyGatewayTeamByStrategyGateway", pd);
	}
	
	/**
	 * 用网关ID和策略ID查询网关策略对应表(网关策略对应表) 
	 * @param pd
	 * @throws Exception
	 */
	public List<PageData> getGatewayStrategy(PageData pd) throws Exception{
		return (List<PageData>) dao.findForList("StrategySetOperateMapper.getGatewayStrategy", pd);
	}

	/**
	 * 插入网关策略对应表
	 * @param pd
	 * @throws Exception
	 */
	@Transactional
	public Object insertGatewayStrategy(PageData pd) throws Exception {
		return dao.save("StrategySetOperateMapper.insertGatewayStrategy", pd);
	}
	
	/**
	 * 插入网关策略与网关控制分组对应表
	 * @param pd
	 * @return 
	 * @throws Exception
	 */
	public void insertStrategyGatewayTerm2(PageData pd) throws Exception {
		dao.save("StrategySetOperateMapper.insertStrategyGatewayTerm2", pd);
	}
	
	/**
	 * 插入网关策略内容表
	 * @param pd
	 * @throws Exception
	 */
	public void insertGatewayStrategyCmd(PageData pd) throws Exception {
		dao.save("StrategySetOperateMapper.insertGatewayStrategyCmd", pd);
	}
	
	/**
	 * 插入用户日志
	 * @param pd
	 * @throws Exception
	 */
	public void insertUserLog(PageData pd) throws Exception {
		dao.save("StrategySetOperateMapper.insertUserLog", pd);
	}
	
	/**
	 * 插入终端日志/命令表
	 * @param pd
	 * @throws Exception
	 */
	public void insertClientLog(PageData pd) throws Exception {
		dao.save("StrategySetOperateMapper.insertClientLog", pd);
	}
	
	/**
	 * 删除网关策略内容 
	 * @param pd
	 * @throws Exception
	 */
	public void deleteGatewayStrategyCmd(Page page) throws Exception{
		dao.delete("StrategySetOperateMapper.deleteGatewayStrategyCmd", page);
	}
	
	/**
	 * 删除网关策略与网关控制分组
	 * @param pd
	 * @throws Exception
	 */
	public void deleteStrategyGatewayTerm2(Page page) throws Exception{
		dao.delete("StrategySetOperateMapper.deleteStrategyGatewayTerm2", page);
	}
	
	/**
	 * 删除网关策略
	 * @param pd
	 * @throws Exception
	 */
	public void deleteGatewayStrategy(Page page) throws Exception{
		dao.delete("StrategySetOperateMapper.deleteGatewayStrategy", page);
	}
	
	/**
	 * 添加应用策略与平台/网关对应表
	 */
	public void addGroup(PageData pd) throws Exception {
		dao.save("StrategySetOperateMapper.addClientTerm", pd);
		dao.save("StrategySetOperateMapper.addGatewayTerm", pd);
	}


	/**
	 * 注销应用策略包
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public void deleteApplyStragySet(PageData pd) throws Exception {
		dao.findForList("StrategySetOperateMapper.delApplyStrategySet", pd);
	}
	
	/**
	 * 应用所选策略包
	 * @param page
	 * @param gatewayList
	 * @return
	 */
	@Transactional
	public void insertApplyStrategySet(Page page, List<PageData> gatewayList) throws Exception {
		PageData pd = page.getPd();
		
		String strategysetIds = pd.getString("strategyset_ids"); // 策略包ID
		String[] strategysets = strategysetIds.split(",");
	
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
			this.addGroup(pd);
		}
		
		// 根据网关ID生成网关策略表序列号,1网关ID对应策略100条
		for (int gw = 0; gw < gatewayList.size(); gw++) {
			PageData gwPd = gatewayList.get(gw);
			String gatewayId = String.valueOf(gwPd.get("c_gateway_id"));
			// 命令内容
			List<String> oneCmdList = new ArrayList<String>();

			// 根据网关ID获取已生成的网关序列号
			pd.put("c_gateway_id", gatewayId);
			List<PageData> gatewayStrategyList = this.getGatewayStrategyByGatewayId(pd);

			// 存在已生成的网关序列号
			if (gatewayStrategyList != null && gatewayStrategyList.size() > 0) {

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
							this.insertGatewayStrategy(pd); // 网关策略对应表
							this.insertStrategyGatewayTerm2(pd); // 网关策略与网关控制分组对应表

							pd.put("b_cmd_type_id", "12");
							String oneCmd = getOneCmd(gatewayId, strategy2Id, serialNo);
							oneCmdList.add(oneCmd);
							pd.put("cmd", oneCmd);
							this.insertGatewayStrategyCmd(pd); // 网关策略内容表
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
					this.insertGatewayStrategy(pd); // 网关策略对应表
					this.insertStrategyGatewayTerm2(pd); // 网关策略与网关控制分组对应表

					pd.put("b_cmd_type_id", "12");
					String oneCmd = getOneCmd(gatewayId, strategy2Id, i + 1);
					oneCmdList.add(oneCmd);
					pd.put("cmd", oneCmd);
					this.insertGatewayStrategyCmd(pd); // 网关策略内容表

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
				this.insertUserLog(pd);

				for (int i = 0; i < cmdLineList.size(); i++) {
					pd.put("status", "1");
					pd.put("b_cmd_type_id", "12");
					pd.put("cmd", cmdLineList.get(i));
					// 插入终端日志/命令表
					this.insertClientLog(pd);
				}
			}
		}
	}
	
	
	/**
	 * 删除应用策略包
	 * @param page
	 * @param strategyGatewayList
	 * @return
	 */
	@Transactional
	public void deleteAppliedStrategySet(Page page, List<PageData> strategyGatewayList) throws Exception {
		PageData pd = page.getPd();
		
		// 删除下列表
		// b_gateway_strategy_cmd 网关策略内容表
		// b_strategy_gatewayterm2 网关策略与网关控制分组对应表
		// b_gateway_strategy 网关策略对应表
		// b_strategy_gatewayterm 策略与网关控制组对应表
		// b_strategy_clientterm 策略与平台对应表
		// b_ctrl_strategy2_apply 应用策略表
		// b_strategy_term_apply 应用策略包表
		this.deleteApplyStragySet(pd);

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
				logger.info("网关策略对应表ID:" + gatewayId + " 网关策略序列号:" + gatewayStrategy);
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
				this.insertUserLog(pd);
				
				for (int i = 0; i < cmdLineList.size(); i++) {
					pd.put("status", "1");
					pd.put("b_cmd_type_id", "32");
					pd.put("cmd", cmdLineList.get(i));
					// 插入终端日志/命令表
					this.insertClientLog(pd);
				}
			}
		}		
				
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
		pd = this.getStrategyGatewayTeamByStrategyGateway(pd);

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

	


}
