package com.fh.service.strategy.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.entity.system.Strategy;
import com.fh.service.strategy.StrategyManager;
import com.fh.util.PageData;

/**	策略条目
 * @author wap
 * 修改日期：2017.08.22
 */
@Service("strategyService")
public class StrategyService implements StrategyManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**策略列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listStrategys(Page page) throws Exception {
		return (List<PageData>) dao.findForList("StrategyMapper.strategylistPage", page);
	}
	
	/**通过id查找
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findById(PageData pd) throws Exception {
		return (PageData)dao.findForObject("StrategyMapper.findById", pd);
	}
	
	/**新增策略
	 * @param pd
	 * @throws Exception
	 */
	public void addStrategy(PageData pd) throws Exception {
		dao.save("StrategyMapper.insert", pd);
	}
	
	/**保存修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd) throws Exception {
		dao.update("StrategyMapper.edit", pd);
	}
	
	/**删除一个策略
	 * @param id
	 * @throws Exception
	 */
	public void deleteStrategyById(String id) throws Exception {
		dao.delete("StrategyMapper.deleteStrategyById", id);
	}
	
	/**
	 * 删除多个策略
	 * 
	 * @param page
	 * @throws Exception
	 */
	public void deleteStrategyByIds(Page page) throws Exception {
		dao.delete("StrategyMapper.deleteStrategyByIds", page);
	}

	/**
	 * 更新策略下发状态
	 * 
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public void updateStrategyStatus(Page page) throws Exception {
		dao.update("StrategyMapper.updateStrategyStatus", page);
	}

}
