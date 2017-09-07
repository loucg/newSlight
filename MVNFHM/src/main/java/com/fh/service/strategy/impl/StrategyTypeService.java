package com.fh.service.strategy.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.entity.system.Language;
import com.fh.entity.system.StrategyType;
import com.fh.service.strategy.StrategyTypeManager;
import com.fh.util.PageData;


/**	控制策略
 * @author zjc
 * 修改日期：2017.1.29
 */
@Service("strategyTypeService")
public class StrategyTypeService implements StrategyTypeManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**查找所有策略类型
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<StrategyType> getStrategyTypeList(PageData pd) throws Exception {
		return (List<StrategyType>) dao.findForList("StrategyTypeMapper.getStrategyTypeList",pd);
	}


}
