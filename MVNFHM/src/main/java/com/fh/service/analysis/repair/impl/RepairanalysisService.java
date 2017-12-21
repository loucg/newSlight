package com.fh.service.analysis.repair.impl;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.clienttype.ClientTypeUtils;
import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.entity.system.User;
import com.fh.hzy.util.LogType;
import com.fh.hzy.util.UserUtils;
import com.fh.service.analysis.repair.RepairanalysisManager;
import com.fh.service.group.mem.GroupMemService;
import com.fh.service.slight.gateway.GatewayService;
import com.fh.service.strategy.StrategySetOperateManager;
import com.fh.service.system.fhlog.FHlogManager;
import com.fh.util.Const;
import com.fh.util.Jurisdiction;
import com.fh.util.ObjectExcelView;
import com.fh.util.PageData;
import com.fh.util.Tools;


@Service("repairanalysisService")
public class RepairanalysisService implements RepairanalysisManager{
	
	private static final String COMMA = ",";
	private static final String SEMICOLON  = ";";
	private static final String CHINESE_COMMA  = "、";
	// 命令行长度
	private static final int CMD_LENGTH  = 20;

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	@Resource(name="fhlogService")
	private FHlogManager fhlog;
	
	@Resource(name = "strategySetOperateService")
	private StrategySetOperateManager strategySetOperateService;
	
    @Resource(name="groupMemService")
    private GroupMemService groupMemService;
    
	@Resource(name="gatewayService") 
	private GatewayService gatewayService;
	
	/**获取公司列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("RepairMapper.datalistPage", page);
	}
	
	/**获取待维修网关列表
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> listGateway(Page page) throws Exception {
		return (List<PageData>)dao.findForList("RepairMapper.faultgatewaylistPage", page);
	}
	
	/**获取可替换网关列表
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> listRepairableGateway(Page page) throws Exception {
		return (List<PageData>)dao.findForList("RepairMapper.repairableGatewaylistPage", page);
	}
	
	/**更新障碍网关状态
	 * @param pd
	 * @throws Exception
	 */
	public void updateGatewayStatus(PageData pd) throws Exception {
		dao.update("RepairMapper.updateGatewayStatus", pd);
	}
	
	/**获取旧网关的节点信息
	 * @param page
	 * @throws Exception
	 */
	@Override
	public List<PageData> getOldClientNodeAdress(PageData pd) throws Exception {
		return (List<PageData>)dao.findForList("RepairMapper.getOldClientNodeAdress", pd);
	}
	
	/**用新网关id更新旧网关id
	 * @param pd
	 * @throws Exception
	 */
	public void updateOldGatewayId(PageData pd) throws Exception {
		dao.update("RepairMapper.updateOldGatewayId", pd);
	}
	
	/**获取分组节点信息
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> getTermInfo(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("RepairMapper.getTermInfo", pd);
	};
	
	/**获取策略信息
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> getStrategyInfo(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("RepairMapper.getStrategyInfo", pd);
	};
	
	/**用新网关id更新分组表旧网关id
	 * @param page
	 * @throws Exception
	 */
	public void updateOldTermGatewayId(PageData pd)throws Exception{
		dao.update("RepairMapper.updateOldTermGatewayId", pd);
	}
	
	/**用新网关id更新策略表旧网关id
	 * @param page
	 * @throws Exception
	 */
	public void updateOldStrategyGatewayId(PageData pd)throws Exception{
		dao.update("RepairMapper.updateOldStrategyGatewayId", pd);
	}
	
	/**删除命令表中数据
	 * @param page
	 * @throws Exception
	 */
	public void deleteNewGatewayCmd(PageData pd)throws Exception{
		dao.update("RepairMapper.deleteNewGatewayCmd", pd);
	}
	
	/**获取网关分组信息
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> getGatewayTermInfo(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("RepairMapper.getGatewayTermInfo", pd);
	};
	
	/**获取id获取故障网关信息
	 * @param page
	 * @throws Exception
	 */
	public PageData getfaultGatewayById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("RepairMapper.getfaultGatewayById", pd);
	};
	
	/**获取id获取故障维修信息
	 * @param page
	 * @throws Exception
	 */
	public PageData getGatewayRepairById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("RepairMapper.getGatewayRepairById", pd);
	};
	
	/**按下完成按钮动作
	 * @param page
	 * @throws Exception
	 */
	@Transactional
	public void updateCompleteInfo(PageData pd)throws Exception{
		// 获得登录的用户id
		User user = (User) Jurisdiction.getSession().getAttribute(Const.SESSION_USER);
		// 根据ID查询维修网关信息
		PageData gatewayFaultPd =getfaultGatewayById(pd);
		gatewayFaultPd.put("oldGatewayid", gatewayFaultPd.get("c_gateway_id"));
		gatewayFaultPd.put("newGatewayid", gatewayFaultPd.get("c_gateway_new_id"));
		gatewayFaultPd.put("status", "2");
		// 更新网关维修状态 为完了
		this.updateGatewayStatus(gatewayFaultPd);
		// 查询有无网关维修信息
		PageData gatewayRepairPd = getGatewayRepairById(gatewayFaultPd);
		gatewayRepairPd.put("id", gatewayFaultPd.get("id"));
		//维修人员
		gatewayRepairPd.put("repairman", user.getUSER_ID());
		// 维修描述
		gatewayRepairPd.put("operate", "旧网关"+gatewayFaultPd.get("c_gateway_id")+"替换为"+"新网关"+gatewayFaultPd.get("c_gateway_new_id"));//维修结果 已修复
		if (null == gatewayRepairPd.get("register")) {
			// 登记人员
			gatewayRepairPd.put("register", user.getUSER_ID());//登记人员
			//生成维修时间
			gatewayRepairPd.put("tdate", Calendar.getInstance().getTime());//创建时间
			gatewayService.createGateway(gatewayRepairPd);
		} else {
			// 修改维修记录
			gatewayService.editGateway(gatewayRepairPd);
		}
	}
	
	/**按下撤销按钮动作
	 * @param page
	 * @throws Exception
	 */
	public void updateCancelInfo(PageData pd)throws Exception{
		// 根据ID查询维修网关信息
		PageData gatewayFaultPd =getfaultGatewayById(pd);
		gatewayFaultPd.put("oldGatewayid", gatewayFaultPd.get("c_gateway_id"));
		gatewayFaultPd.put("newGatewayid", null);
		gatewayFaultPd.put("status", "1");
		// 更新网关维修状态 为未修复
		this.updateGatewayStatus(gatewayFaultPd);
		// 旧网关ID
		pd.put("oldGatewayid", gatewayFaultPd.get("c_gateway_new_id"));
		// 新网关ID
		pd.put("newGatewayid", gatewayFaultPd.get("c_gateway_id"));
		// 将“网关终端关联表”中新网关ID都给替换为原网关ID	
		pd.put("tableName", "c_client_gateway");
		updateOldGatewayId(pd);
		// 更新新分组网关ID为旧分组网关ID
		pd.put("tableName", "c_gateway_term");
		updateOldGatewayId(pd);
		// 更新新策略网关Id未旧策略网关ID
		pd.put("tableName", "b_gateway_strategy");
		updateOldGatewayId(pd);
		// 删除命令表中数据
		pd.put("newGatewayid", gatewayFaultPd.get("c_gateway_new_id"));
		deleteNewGatewayCmd(pd);
	}
	
	/**更换网关
	 * @param page
	 * @throws Exception
	 */
	@Transactional
	public List<PageData> updateGateway(PageData pd) throws Exception {

		// 写节点信息到命令表
		List<PageData> nodeInfoList = writeNodeInfo(pd);
		// 将“网关终端关联表”中原网关ID都给替换为新网关ID	
		pd.put("tableName", "c_client_gateway");
		updateOldGatewayId(pd);
		// 根据原网关ID查询出所有备份的分组,向命令表中插入对新网关同样的指令
		writeTermInfo(pd);
		// 更新原分组网关Id
		pd.put("tableName", "c_gateway_term");
		updateOldGatewayId(pd);
		// 根据原网关ID查询出所有备份的策略,向命令表中插入对新网关同样的指令
		writeStrategyInfo(pd);
		// 更新原策略网关Id
		pd.put("tableName", "b_gateway_strategy");
		updateOldGatewayId(pd);
		// 更新网关状态未已替换，待确认
		pd.put("status", "3");//已替换 待确认
		updateGatewayStatus(pd);
		return nodeInfoList;
}
	
	/**写节点信息到命令表
	 * @param page
	 * @throws Exception
	 */
	private List<PageData> writeNodeInfo(PageData pd) throws Exception{
		// 共同项目
		setCommonItem(pd,1);//组网命令
		
		// 获取旧网关的节点信息
		List<PageData> nodeAddrInfo = getOldClientNodeAdress(pd);
		// 总节点个数
		int totalNodecnt = nodeAddrInfo.size();
		// 节点地址循环
		StringBuilder sbInfo = new StringBuilder();
		// 本次节点起始序号
		int nodeIndex = 1;
		int loopCnt = 0;
		int tmpTotalNodecnt = totalNodecnt;
		for (PageData nodeInfo : nodeAddrInfo) {
			loopCnt++;
			// 总节点个数
			sbInfo.append(totalNodecnt);
			sbInfo.append(COMMA);
			// 本次节点起始序号
			sbInfo.append(nodeIndex);
			sbInfo.append(COMMA);
			// 本次节点个数
			if (tmpTotalNodecnt <= CMD_LENGTH) {
				sbInfo.append(tmpTotalNodecnt);
			} else {
				sbInfo.append(20);
			}
			sbInfo.append(COMMA);
			// 节点地址
			sbInfo.append(nodeInfo.getString("node"));
			sbInfo.append(CHINESE_COMMA);
			//节点类型
			sbInfo.append((int)nodeInfo.get("type"));
			sbInfo.append(CHINESE_COMMA);
			//节点编码
			sbInfo.append(nodeInfo.getString("client_code"));
			sbInfo.append(CHINESE_COMMA);
			// 节点GPS
			sbInfo.append(nodeInfo.getString("coordinate"));
			sbInfo.append(SEMICOLON);
			// 一条指令中最多包含20个节点，剩余的另起指令
			if (tmpTotalNodecnt <= CMD_LENGTH && tmpTotalNodecnt == loopCnt) {
				pd.put("cmd", sbInfo.substring(0, sbInfo.length() - 1).toString());
				fhlog.saveNodeInfo(pd);
				// 信息清空
				sbInfo.setLength(0);
			} else if (tmpTotalNodecnt > CMD_LENGTH && loopCnt == CMD_LENGTH) {
				tmpTotalNodecnt -= CMD_LENGTH;
				nodeIndex++;
				loopCnt = 0;
				pd.put("cmd", sbInfo.substring(0, sbInfo.length() - 1).toString());
				fhlog.saveNodeInfo(pd);
				// 信息清空
				sbInfo.setLength(0);
			}
		}
		// 下载节点信息到本地
//		ObjectExcelView erv = new ObjectExcelView();
//		new ModelAndView(erv,ClientTypeUtils.exportNode(nodeAddrInfo));
		return nodeAddrInfo;
	}
	
	/**写分组信息到命令表
	 * @param page
	 * @throws Exception
	 */
	private void writeTermInfo(PageData pd) throws Exception{
		// 共同项目
		setCommonItem(pd,3);//分组下发
		dao.save("LogMapper.insertLog", pd);
		int lastid = (Integer) dao.findForObject("ConfigureMapper.lastInsertId", pd);
		pd.put("b_user_log_id", lastid);
		// 获取网关分组数据
		List<PageData> gatewayTermInfo = getGatewayTermInfo(pd);
		if (gatewayTermInfo != null && gatewayTermInfo.size() > 0) {
			for(PageData gatewayTermPd : gatewayTermInfo) {
				// 总节点个数
				Integer one001 = groupMemService.searchsecond(gatewayTermPd);
				pd.put("ONE", one001);
				// 网关分组号
				Integer one002 = groupMemService.searchfirst(gatewayTermPd);
				pd.put("TWO", one002);
				if(one001>100){
					pd.put("TEN", one001-100);
					//节点信息
					String one003 = groupMemService.searchthird(gatewayTermPd);
					String sb = "";
					String sb2 = "";
					String ArrayDATA_STR[] =one003.split("、");
					 
					for( int b = 0; b < 100; b++ )
					{
						sb = sb + ArrayDATA_STR[b] +"、";  
					}
					sb = sb.substring(0,sb.length() - 1);
					 
					for( int p = 100; p < ArrayDATA_STR.length; p++ )
					{
						sb2 = sb2 + ArrayDATA_STR[p] +"、"; 
					}
					sb2 = sb2.substring(0,sb2.length()-1);
					
					pd.put("THREE", one003);
					pd.put("FOUR", sb.toString());
					pd.put("FIVE", sb2.toString());
					
					pd.put("cmd", pd.get("ONE")+","+"1"+","+"100"+","+pd.get("TWO")+","+pd.get("FOUR"));
					pd.put("cmd1", pd.get("ONE")+","+"101"+","+pd.get("TEN")+","+pd.get("TWO")+","+pd.get("FIVE"));
					////插入最后一张命令表
					groupMemService.finallypage(pd);
					groupMemService.finallypagelast(pd);
					pd.put("msg", "ok");
					
				}
				else {//总节点个数小于等于100时
					//第三个参数
					String one003 = groupMemService.searchthird(gatewayTermPd);
					pd.put("THREE", one003);
					pd.put("cmd", pd.get("ONE")+","+"1"+","+pd.get("ONE")+","+pd.get("TWO")+","+pd.get("THREE"));
					//插入最后一张命令表
					groupMemService.finallypage(pd);
				}
				
			}
		}
	}
	
	/**写策略信息到命令表
	 * @param page
	 * @throws Exception
	 */
	private void writeStrategyInfo(PageData pd) throws Exception{
		// 共同项目
		setCommonItem(pd,12);//策略下发
		// 策略信息组合
		List<String> oneCmdList = new ArrayList<String>();
		// 获取分组节点信息
		List<PageData> termInfo = getStrategyInfo(pd);
		for (PageData nodeInfo : termInfo) {
			// 总节点个数
			oneCmdList.add(nodeInfo.getString("cmd"));
		}
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
	/**设置共同项目
	 * @param page
	 */
	private void setCommonItem(PageData pd, int cmdid) {
		// 共同项目
		pd.put("userid", UserUtils.getUserid());
		pd.put("type", LogType.changegateway);
		pd.put("comment", "更换网关");
		pd.put("tdate", Tools.date2Str(new Date()));
		pd.put("gateway", (Integer)pd.get("newGatewayid"));
		pd.put("c_gateway_id", (Integer)pd.get("newGatewayid"));
		pd.put("b_cmd_type_id", cmdid);
		pd.put("status", 1);
		pd.put("cmdid", cmdid);
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
}
