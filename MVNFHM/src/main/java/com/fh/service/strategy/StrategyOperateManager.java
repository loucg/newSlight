package com.fh.service.strategy;

import java.util.List;

import com.fh.entity.Page;
import com.fh.util.PageData;

/**
 * 策略发送注销的接口
 * @author wap
 *
 */
public interface StrategyOperateManager {

	/**
	 * 获取策略组中策略对应的所有网关控制分组列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	List<PageData> getGatewayByStrategyIds(Page page)throws Exception;

	/**
	 * 查询指定网关ID所对应的网管策略
	 * @param pd
	 * @throws Exception
	 */
	List<PageData> getGatewayStrategyByGatewayId(PageData pd) throws Exception;
	
	/**
	 * 查询指定策略和网关对应的网关控制分组
	 * @param pd
	 * @throws Exception
	 */
	PageData getStrategyGatewayTeamByStrategyGateway(PageData pd) throws Exception;
	
	/**
	 * 用网关ID和策略ID查询网关策略(网关策略对应表) 
	 * @param pd
	 * @throws Exception
	 */
	PageData getGatewayStrategy(PageData pd) throws Exception;
	
	/**
	 * 插入网关策略对应表
	 * @param pd
	 * @throws Exception
	 */
	Object insertGatewayStrategy(PageData pd) throws Exception;

	/**
	 * 插入网关策略与网关控制分组对应表
	 * @param pd
	 * @throws Exception
	 */
	void insertStrategyGatewayTerm2(PageData pd) throws Exception;

	/**
	 * 插入网关策略内容表
	 * @param pd
	 * @throws Exception
	 */
	void insertGatewayStrategyCmd(PageData pd) throws Exception;

	/**
	 * 插入日志
	 * @param pd
	 * @throws Exception
	 */
	void insertUserLog(PageData pd) throws Exception;

	/**
	 * 插入终端日志
	 * @param pd
	 * @throws Exception
	 */
	void insertClientLog(PageData pd) throws Exception;
	
	/**
	 * 删除网关策略内容 
	 * @param page
	 * @throws Exception
	 */
	void deleteGatewayStrategyCmd(Page page) throws Exception;
	
	/**
	 * 删除网关策略与网关控制分组
	 * @param page
	 * @throws Exception
	 */
	void deleteStrategyGatewayTerm2(Page page) throws Exception;
	
	/**
	 * 删除网关策略
	 * @param page
	 * @throws Exception
	 */
	void deleteGatewayStrategy(Page page) throws Exception;

}
