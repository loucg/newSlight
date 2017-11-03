package com.fh.service.strategy;

import java.util.List;

import com.fh.entity.Page;
import com.fh.util.PageData;

/**
 * 策略包类
 * 
 * @author wap 修改日期：2017.7.29
 */
public interface StrategySetManager {

	/**
	 * 策略包列表
	 * 
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public List<PageData> listStrategySet(Page page) throws Exception;

	/**
	 * 通过id查找策略包
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findStrategySetById(PageData pd) throws Exception;

	/**
	 * 新增策略包
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void addStrategySet(PageData pd) throws Exception;

	/**
	 * 保存修改策略包名称说明
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void editStrategySet(PageData pd) throws Exception;

	/**
	 * 踢删策略包
	 * 
	 * @param id
	 * @throws Exception
	 */
	public void deleteStrategySetById(String id) throws Exception;

	/**
	 * 可选择策略包列表
	 * 
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public List<PageData> listOtherStrategySet(Page page) throws Exception;
}
