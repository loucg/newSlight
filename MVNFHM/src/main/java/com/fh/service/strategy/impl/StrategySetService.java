package com.fh.service.strategy.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.service.strategy.StrategySetManager;
import com.fh.util.PageData;

/**
 * 策略包
 * 
 * @author wap 修改日期：2017.7.29
 */
@Service("strategySetService")
public class StrategySetService implements StrategySetManager {

	@Resource(name = "daoSupport")
	private DaoSupport dao;

	/**
	 * 策略包列表
	 * 
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listStrategySet(Page page) throws Exception {
		return (List<PageData>) dao.findForList("StrategySetMapper.strategySetlistPage", page);
	}

	/**
	 * 通过id查找策略包
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findStrategySetById(PageData pd) throws Exception {
		return (PageData) dao.findForObject("StrategySetMapper.findStrategySetById", pd);
	}

	/**
	 * 新增策略包
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void addStrategySet(PageData pd) throws Exception {
		dao.save("StrategySetMapper.insert", pd);
	}

	/**
	 * 保存修改策略包名称说明
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void editStrategySet(PageData pd) throws Exception {
		dao.update("StrategySetMapper.update", pd);
	}

	/**
	 * 删除策略包
	 * 
	 * @param id
	 * @throws Exception
	 */
	public void deleteStrategySetById(String id) throws Exception {
		dao.update("StrategySetMapper.remove", id);
	}

	/**
	 * 可选择策略包列表
	 * 
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listOtherStrategySet(Page page) throws Exception {
		return (List<PageData>) dao.findForList("StrategySetMapper.otherStrategySetlistPage", page);
	}


}
