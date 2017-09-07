package com.fh.service.strategy;

import java.util.List;

import com.fh.entity.Page;
import com.fh.entity.system.StrategyType;
import com.fh.util.PageData;

/**	控制策略类
 * @author zjc
 * 修改日期：2017.1.29
 */
public interface StrategyTypeManager {

	/**
	 * 查找所有策略类型
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<StrategyType> getStrategyTypeList(PageData pd) throws Exception;
	
}
