package com.fh.controller.strategy;

import java.io.PrintWriter;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.Target;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;


import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.entity.system.GatewayStrategy;
import com.fh.entity.system.User;
import com.fh.service.system.fhlog.FHlogManager;
import com.fh.service.system.menu.MenuManager;
import com.fh.service.strategy.StrategyOperateManager;
import com.fh.service.strategy.StrategyManager;
import com.fh.service.system.user.UserManager;
import com.fh.util.AppUtil;
import com.fh.util.Const;
import com.fh.util.Jurisdiction;
import com.fh.util.PageData;
import com.fh.util.Tools;
import com.mysql.fabric.xmlrpc.base.Array;

/** 
 * 类名称：StrategyOperateController
 * 创建人：wap
 * 更新时间：2017年7月30日
 * @version
 */
@Controller
@RequestMapping(value="/strategy/strategyset")
public class StrategyOperateController extends BaseController {
	
	String menuUrl = "/strategy/strategyset/sendS2.do"; //菜单地址(权限用)
	@Resource(name="userService")
	private UserManager userService;
	@Resource(name="menuService")
	private MenuManager menuService;
	@Resource(name="fhlogService")
	private FHlogManager FHLOG;
	@Resource(name="strategyService")
	private StrategyManager strategyService;
	@Resource(name="strategyOperateService")
	private StrategyOperateManager strategyOperateService;
	
	@Resource(name = "sqlSessionTemplate")
	private SqlSessionTemplate sqlSessionTemplate;

	/**
	 * 下发策略
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/sendS2")
	@ResponseBody
	@Transactional
	public Object sendS2() throws Exception{
		logBefore(logger,"正在下发策略中策略");

		Map<String,Object> map = new HashMap<String,Object>();		
		PageData pd = new PageData();
		pd = this.getPageData();
				
		//获得登录的用户id
		User user = (User)Jurisdiction.getSession().getAttribute(Const.SESSION_USER);
		String sys_user_id = user.getUSER_ID();
		pd.put("sys_user_id", sys_user_id);
		System.out.println(sys_user_id);
		
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
		String tdate = df.format(new Date());
		pd.put("tdate", tdate);				//创建时间
		System.out.println(tdate);
		
		logBefore(logger, pd.getString("strategy_ids"));	
		
		// 根据策略ID查找网关
		Page page = new Page();
		page.setPd(pd);
		// orderby c_gateway_id,b_ctrl_strategy_id
		List<PageData> strategyGatewayTermList = strategyOperateService.getGatewayByStrategyIds(page); 
		
		if(strategyGatewayTermList==null) {
			map.put("result", "failed.");
			return AppUtil.returnObject(pd, map);
		}
		
		// 根据网关ID分组
		Map<String,Object> getwayMap = groupGateway(strategyGatewayTermList);
		
		// 根据网关ID生成网关策略表序列号,1网关ID对应策略100条,
		Iterator<Entry<String, Object>> it = getwayMap.entrySet().iterator();
		while (it.hasNext()) {
			Map.Entry<String, Object> entry = it.next();
			String gatewayId = entry.getKey();
			List<GatewayStrategy> list =  (List<GatewayStrategy>) entry.getValue();
			// 命令内容
			List<String> oneCmdList = new ArrayList<String>();
			
			// 根据网关ID获取已生成的网关序列号
			pd.put("c_gateway_id", gatewayId);
			List<PageData> gatewayStrategyList = strategyOperateService.getGatewayStrategyByGatewayId(pd);
			
			// 存在已生成的网关序列号
			if(gatewayStrategyList!=null && gatewayStrategyList.size()>0) {
				// TODO 序列号超过100,数据回滚,抛出错误 
				if((list.size()+gatewayStrategyList.size()) > 100 ) {
					throw new Exception("超出网关最大承载策略数量");
				}
				
				// 序列号使用状况初始化最多100
				int[][] serialNoSts = new int[100][1];
				for(int i=0; i<100; i++) {
					serialNoSts[i][0] = 0;	// 未使用
				}
				
				for(int i=0; i<gatewayStrategyList.size(); i++) {
					// 序列号
					int getwayStrategy = Integer.parseInt(gatewayStrategyList.get(i).get("b_gateway_strategy").toString());
					serialNoSts[getwayStrategy-1][0] = 1;	// 已使用
				}
				
				// 分配序列号	
				int serialNo = 0;
				for(int i=0; i<list.size(); i++) {
					for(int j=serialNo; j<100; j++) {
						if(serialNoSts[j][0]==0) {
							serialNo = j+1;
							pd.put("b_gateway_strategy_id", "");
							pd.put("c_gateway_id", gatewayId);
							pd.put("b_ctrl_strategy_id", list.get(i).getStrategy_id());
							pd.put("b_gateway_strategy", serialNo);				//网关序列号
							strategyOperateService.insertGatewayStrategy(pd);	//网关策略对应表
							strategyOperateService.insertStrategyGatewayTerm2(pd);	//网关策略与网关控制分组对应表
							
							pd.put("b_cmd_type_id", "12");
							String oneCmd = getOneCmd(gatewayId, list.get(i).getStrategy_id(), serialNo);
							oneCmdList.add(oneCmd);
							pd.put("cmd", oneCmd);
							strategyOperateService.insertGatewayStrategyCmd(pd);	//网关策略内容表
							break;
						}
					}
				}
			}else {
				// 不存在已生成的网关序列号
				for(int i=0; i<list.size(); i++) {
					pd.put("b_gateway_strategy_id", "");
					pd.put("c_gateway_id", gatewayId);
					pd.put("b_ctrl_strategy_id", list.get(i).getStrategy_id());
					pd.put("b_gateway_strategy", i+1);
					strategyOperateService.insertGatewayStrategy(pd);		//网关策略对应表
					strategyOperateService.insertStrategyGatewayTerm2(pd);	//网关策略与网关控制分组对应表
					
					pd.put("b_cmd_type_id", "12");
					String oneCmd = getOneCmd(gatewayId, list.get(i).getStrategy_id(), i+1);
					oneCmdList.add(oneCmd);
					pd.put("cmd", oneCmd);
					strategyOperateService.insertGatewayStrategyCmd(pd);	//网关策略内容表
				}
			}
			
			//【计划个数,网关策略序列号1、网关策略序列号2、网关策略序列号3...】
			// 一次最多下发35个计划
			List<String> cmdLineList = getCmdLineList(oneCmdList, ";");
			if(cmdLineList.size() > 0) {
				pd.put("b_user_log_id", "");
				pd.put("b_log_type_id", "9");
				pd.put("comment", "下发策略");
				// 插入用户日志表
				strategyOperateService.insertUserLog(pd);
				
				for(int i=0; i<cmdLineList.size(); i++) {
					pd.put("status", "1");
					pd.put("b_cmd_type_id", "12");
					pd.put("cmd", cmdLineList.get(i));
					// 插入终端日志/命令表
					strategyOperateService.insertClientLog(pd);
				}
			}
		}
		
		// 状态更新成已下发
		pd.put("status2", "1");
		page.setPd(pd);
		strategyService.updateStrategyStatus(page);
		map.put("result", "success");		
		return AppUtil.returnObject(pd, map);
	}
	
	
	/**
	 * 注销策略
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/cancelS2")
	@ResponseBody
	@Transactional
	public Object cancelS2() throws Exception{
		logBefore(logger,"正在注销策略中策略");

		Map<String,Object> map = new HashMap<String,Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		
		//获得登录的用户id
		User user = (User)Jurisdiction.getSession().getAttribute(Const.SESSION_USER);
		String sys_user_id = user.getUSER_ID();
		pd.put("sys_user_id", sys_user_id);
		System.out.println(sys_user_id);
		
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
		String tdate = df.format(new Date());
		pd.put("tdate", tdate);				//创建时间
		System.out.println(tdate);
		
		logBefore(logger, pd.getString("strategy_ids"));
		
		// 根据策略ID查找网关
		Page page = new Page();
		page.setPd(pd);
		// orderby c_gateway_id,b_ctrl_strategy_id
		List<PageData> strategyGatewayTermList = strategyOperateService.getGatewayByStrategyIds(page); 
		
		if(strategyGatewayTermList==null) {
			map.put("result", "failed.");
			return AppUtil.returnObject(pd, map);
		}
		
		// 根据网关ID把策略ID分组
		Map<String,Object> getwayMap = groupGateway(strategyGatewayTermList);
		Iterator<Entry<String, Object>> it = getwayMap.entrySet().iterator();
		while (it.hasNext()) {
			Map.Entry<String, Object> entry = it.next();
			String gatewayId = entry.getKey();
			List<GatewayStrategy> list =  (List<GatewayStrategy>) entry.getValue();
			// 命令内容
			List<String> oneCmdList = new ArrayList<String>();

			pd.put("c_gateway_id", gatewayId);
			for(int i=0; i<list.size(); i++) {
				pd.put("b_ctrl_strategy_id", list.get(i).getStrategy_id());
				// 查询所有网关策略对应表
				PageData gatewayStrategyPd = strategyOperateService.getGatewayStrategy(pd);
				
				if(gatewayStrategyPd!=null) {
					// 网关策略对应表ID
					String id = gatewayStrategyPd.get("id").toString();
					// 网关策略序列号
					String gatewayStrategy = gatewayStrategyPd.get("b_gateway_strategy").toString();
					logBefore(logger, "网关策略对应表ID:" + id + " 网关策略序列号:" + gatewayStrategy);

					gatewayStrategyPd.put("b_gateway_strategy_id", id);
					page.setPd(gatewayStrategyPd);
					strategyOperateService.deleteStrategyGatewayTerm2(page);	//网关策略与网关控制分组对应表
					strategyOperateService.deleteGatewayStrategyCmd(page);		//网关策略内容表
					strategyOperateService.deleteGatewayStrategy(page);			//网关策略对应表
				
					oneCmdList.add(gatewayStrategy);
				}
			}

			//【计划个数,网关策略序列号1、网关策略序列号2、网关策略序列号3...】
			// 一次最多下发35个计划
			List<String> cmdLineList = getCmdLineList(oneCmdList, "、");
			
			if(cmdLineList.size() > 0) {
				pd.put("b_user_log_id", "");
				pd.put("b_log_type_id", "9");
				pd.put("comment", "注销策略");
				// 插入用户日志表
				strategyOperateService.insertUserLog(pd);
	
				for(int i=0; i<cmdLineList.size(); i++) {
					pd.put("status", "1");
					pd.put("b_cmd_type_id", "32");
					pd.put("cmd", cmdLineList.get(i));
					// 插入终端日志/命令表
					strategyOperateService.insertClientLog(pd);
				}
			}
		}

		// 状态更新成已注销
		pd.put("status2", "2");
		page.setPd(pd);
		strategyService.updateStrategyStatus(page);

		map.put("result", "success");		
		return AppUtil.returnObject(pd, map);		
	}
	
	/**
	 * 根据网关ID分组
	 * @param strategyGatewayTermList
	 * @return 分组后Map
	 */
	private Map<String,Object> groupGateway(List<PageData> strategyGatewayTermList)
	{
		
		Map<String,Object> getwayMap = new HashMap<String,Object>();
		String gatewayIdBef="";
		List<GatewayStrategy> gatewayStrategyMapList = new ArrayList<GatewayStrategy>();
		for(int i=0; i<strategyGatewayTermList.size(); i++) {
			String gatewayId = strategyGatewayTermList.get(i).get("c_gateway_id").toString();
			String strategyId = strategyGatewayTermList.get(i).get("b_ctrl_strategy_id").toString();
			
			if(!gatewayId.equals(gatewayIdBef)) {
				if(gatewayStrategyMapList.size()!=0) {
					getwayMap.put(gatewayIdBef, gatewayStrategyMapList);
				}
				
				GatewayStrategy gatewayStrategy = new GatewayStrategy();
				gatewayStrategy.setGateway_id(gatewayId);	
				gatewayStrategy.setStrategy_id(strategyId);
				
				gatewayStrategyMapList = new ArrayList<GatewayStrategy>();
				gatewayStrategyMapList.add(gatewayStrategy);
				gatewayIdBef = gatewayId;
			}else {
				GatewayStrategy gatewayStrategy = new GatewayStrategy();
				gatewayStrategy.setGateway_id(gatewayId);
				gatewayStrategy.setStrategy_id(strategyId);
				
				gatewayStrategyMapList.add(gatewayStrategy);
			}			
		}
		getwayMap.put(gatewayIdBef, gatewayStrategyMapList);
		
		return getwayMap;
	}
	
	
	/**
	 * 获得指定策略内容做成的命令行
	 * 格式 
	 * 计划1编号,定时调节,开始日期,结束日期,执行月,执行日,执行时间,执行组号,亮度,灯色;计划2编号,定时调节,开始日期,结束日期,执行月,执行日,执行时间,执行组号,亮度,灯色;....
	 * @param gatewayId			网关ID
	 * @param strategyId		策略ID
	 * @param gatewayStrategy	网关序列号
	 * @return 格式化命令行
	 * @throws Exception
	 */
	private String getOneCmd(String gatewayId, String strategyId, int gatewayStrategy) throws Exception{
		PageData pd = new PageData();
		pd.put("c_gateway_id", gatewayId);
		pd.put("b_ctrl_strategy_id", strategyId);
		pd = strategyOperateService.getStrategyGatewayTeamByStrategyGateway(pd);
		
		if(pd==null)
			return "";
		
		String cmd = gatewayStrategy + "," + pd.get("b_strategy_type_id")+","+pd.get("datetime1")+","+pd.get("datetime2")+",";;
		
		if(pd.get("b_strategy_type_id").toString().equals("1")) {
			// 定时调节
			cmd = cmd + pd.get("month") + "," + pd.get("day") + ",";
		}else if(pd.get("b_strategy_type_id").toString().equals("2")) {
			// 周期调节
			cmd = cmd + pd.get("period") + "," + pd.get("days") + ",";
		}
		cmd = cmd + pd.get("time") + "," + pd.get("gateway_team") + "," + pd.get("bright") + "," + pd.get("value");
	
		return cmd;
	}
	
	/**
	 * 获得命令行内容
	 * @param commandList 所有策略命令
	 * @return 命令行
	 * @throws Exception
	 */
	private List<String> getCmdLineList(List<String> commandList, String separator) {
		List<String> retCmdList = new ArrayList<String>();
		
		while(commandList.size()>35) {
			List<String> oneCmdList = commandList.subList(0, 35);
			commandList = commandList.subList(35, commandList.size());
			
			String oneCmd = StringUtils.join(oneCmdList, separator);
			retCmdList.add(oneCmdList.size() + "," + oneCmd);
		}
		
		if(commandList.size()>0) {
			// 计划设置个数
			retCmdList.add(commandList.size() + "," + StringUtils.join(commandList, separator));
		}
		return retCmdList;

	}
	
	
	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}

}


