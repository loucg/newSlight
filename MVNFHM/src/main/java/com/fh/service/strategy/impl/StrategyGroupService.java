package com.fh.service.strategy.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.service.strategy.StrategyGroupManager;
import com.fh.util.PageData;

@Service("strategyGroupService")
public class StrategyGroupService implements StrategyGroupManager {
	
	@Resource(name = "daoSupport")
	private DaoSupport dao;

	/**
	 * 获取分配策略后的组列表
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listGroups(Page page) throws Exception {
		return (List<PageData>)dao.findForList("StrategyGroupMapper.grouplistPage", page);
	}

	/**
	 * 获取未分配策略的组列表
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listOthers(Page page) throws Exception {
		return (List<PageData>)dao.findForList("StrategyGroupMapper.otherlistPage", page);
	}

	/**
	 * 添加组
	 */
	public void addGroup(PageData pd) throws Exception {
		dao.save("StrategyGroupMapper.addClientTerm", pd);
		dao.save("StrategyGroupMapper.addGatewayTerm", pd);
	}

	/**
	 * 踢删组
	 */
	public void removeGroup(PageData pd) throws Exception {
		dao.delete("StrategyGroupMapper.removeClientTerm", pd);
		dao.delete("StrategyGroupMapper.removeGatewayTerm", pd);
	}

}
