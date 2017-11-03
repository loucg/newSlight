package com.fh.service.strategy;

import java.util.List;

import com.fh.entity.Page;
import com.fh.entity.system.Strategy;
import com.fh.util.PageData;

/**	应用策略包类
 * @author wap
 * @001 2017/10/18 wap add
 */
public interface StrategySetApplyManager {

	/**新增应用策略包(从策略包中直接复制)
	 * @param pd
	 * @throws Exception
	 */
	public void addStrategySet(PageData pd) throws Exception;
	
	
	/**踢删应用策略包
	 * @param id
	 * @throws Exception
	 */
	public void deleteStrategySetById(String id) throws Exception;

}
