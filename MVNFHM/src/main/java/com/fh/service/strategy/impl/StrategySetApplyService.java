package com.fh.service.strategy.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.service.strategy.StrategySetApplyManager;
import com.fh.util.PageData;

/**	应用策略包类
 * @author wap
 * @001 2017/10/18 wap add
 */
@Service("strategySetApplyService")
public class StrategySetApplyService implements StrategySetApplyManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增应用策略包(从策略包中直接复制)
	 * @param pd
	 * @throws Exception
	 */
	public void addStrategySet(PageData pd) throws Exception {
		dao.save("StrategySetApplyMapper.insert", pd);
	}
	
	/**删除应用策略包
	 * @param id
	 * @throws Exception
	 */
	public void deleteStrategySetById(String id) throws Exception {
		dao.update("StrategySetApplyMapper.remove", id);
	}
	
}
