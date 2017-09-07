package com.fh.service.strategy;

import java.util.List;

import com.fh.entity.Page;
import com.fh.entity.system.Strategy;
import com.fh.util.PageData;

/**	策略条目类
 * @author wap
 * 修改日期：2017.08.22
 */
public interface StrategyManager {
	
	/**策略列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public List<PageData> listStrategys(Page page) throws Exception;
	
	/**通过id查找
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findById(PageData pd) throws Exception;
	
	/**新增策略
	 * @param pd
	 * @throws Exception
	 */
	public void addStrategy(PageData pd) throws Exception;
	
	/**保存修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd) throws Exception;
	
	/**删除一个策略
	 * @param id
	 * @throws Exception
	 */
	public void deleteStrategyById(String id) throws Exception;
		
	/**删除多个策略
	 * @param page
	 * @throws Exception
	 */
	public void deleteStrategyByIds(Page page) throws Exception;

	/**
	 * 更新策略下发状态
	 * 
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public void updateStrategyStatus(Page page) throws Exception;
	
}
