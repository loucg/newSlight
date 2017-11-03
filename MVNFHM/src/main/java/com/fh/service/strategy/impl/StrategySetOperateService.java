package com.fh.service.strategy.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.service.strategy.StrategySetOperateManager;
import com.fh.util.PageData;

/**
 * 应用策略包中策略的下发/注销操作类
 * 
 * @001 2017/10/18 wap add
 */
@Service("strategySetOperateService")
public class StrategySetOperateService implements StrategySetOperateManager {

	@Resource(name = "daoSupport")
	private DaoSupport dao;

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

}
