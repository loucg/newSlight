package com.fh.service.strategy.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.service.strategy.StrategyOperateManager;
import com.fh.util.PageData;

/**
 * 策略组中策略的下发/注销操作类
 * 
 * @author wap 修改日期：2017.7.29
 */
@Service("strategyOperateService")
public class StrategyOperateService implements StrategyOperateManager {

	@Resource(name = "daoSupport")
	private DaoSupport dao;

	/**
	 * 获取策略组中策略对应的所有网关控制分组列表
	 * 
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> getGatewayByStrategyIds(Page page) throws Exception {
		return (List<PageData>) dao.findForList("StrategyOperateMapper.getGatewayByStrategyIds", page);
	}
	
	/**
	 * 查询指定网关ID所对应的网管策略
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> getGatewayStrategyByGatewayId(PageData pd) throws Exception{
		return (List<PageData>) dao.findForList("StrategyOperateMapper.getGatewayStrategyByGatewayId", pd);
	}
	
	/**
	 * 查询指定策略和网关对应的网关控制分组
	 * @param pd
	 * @throws Exception
	 */
	public PageData getStrategyGatewayTeamByStrategyGateway(PageData pd) throws Exception {
		return (PageData) dao.findForObject("StrategyOperateMapper.getStrategyGatewayTeamByStrategyGateway", pd);
	}
	
	/**
	 * 用网关ID和策略ID查询网关策略对应表(网关策略对应表) 
	 * @param pd
	 * @throws Exception
	 */
	public PageData getGatewayStrategy(PageData pd) throws Exception{
		return (PageData) dao.findForObject("StrategyOperateMapper.getGatewayStrategy", pd);
	}

	/**
	 * 插入网关策略对应表
	 * @param pd
	 * @throws Exception
	 */
	@Transactional
	public Object insertGatewayStrategy(PageData pd) throws Exception {
		return dao.save("StrategyOperateMapper.insertGatewayStrategy", pd);
	}
	
	/**
	 * 插入网关策略与网关控制分组对应表
	 * @param pd
	 * @return 
	 * @throws Exception
	 */
	public void insertStrategyGatewayTerm2(PageData pd) throws Exception {
		dao.save("StrategyOperateMapper.insertStrategyGatewayTerm2", pd);
	}
	
	/**
	 * 插入网关策略内容表
	 * @param pd
	 * @throws Exception
	 */
	public void insertGatewayStrategyCmd(PageData pd) throws Exception {
		dao.save("StrategyOperateMapper.insertGatewayStrategyCmd", pd);
	}
	
	/**
	 * 插入用户日志
	 * @param pd
	 * @throws Exception
	 */
	public void insertUserLog(PageData pd) throws Exception {
		dao.save("StrategyOperateMapper.insertUserLog", pd);
	}
	
	/**
	 * 插入终端日志/命令表
	 * @param pd
	 * @throws Exception
	 */
	public void insertClientLog(PageData pd) throws Exception {
		dao.save("StrategyOperateMapper.insertClientLog", pd);
	}
	
	/**
	 * 删除网关策略内容 
	 * @param pd
	 * @throws Exception
	 */
	public void deleteGatewayStrategyCmd(Page page) throws Exception{
		dao.delete("StrategyOperateMapper.deleteGatewayStrategyCmd", page);
	}
	
	/**
	 * 删除网关策略与网关控制分组
	 * @param pd
	 * @throws Exception
	 */
	public void deleteStrategyGatewayTerm2(Page page) throws Exception{
		dao.delete("StrategyOperateMapper.deleteStrategyGatewayTerm2", page);
	}
	
	/**
	 * 删除网关策略
	 * @param pd
	 * @throws Exception
	 */
	public void deleteGatewayStrategy(Page page) throws Exception{
		dao.delete("StrategyOperateMapper.deleteGatewayStrategy", page);
	}
	

}
