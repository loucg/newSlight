package com.fh.service.strategy;

import java.util.List;

import com.fh.entity.Page;
import com.fh.util.PageData;

/**
 * 控制策略的接口
 * @author zjc
 *
 */
public interface StrategyGroupManager {

	/**
	 * 获取分配策略后的组列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	List<PageData> listGroups(Page page)throws Exception;

	/**
	 * 获取未分配策略的组列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	List<PageData> listOthers(Page page)throws Exception;

	/**
	 * 添加组
	 * @param pd
	 * @throws Exception
	 */
	void addGroup(PageData pd) throws Exception;

	/**
	 * 踢删组
	 * @param pd
	 * @throws Exception
	 */
	void removeGroup(PageData pd) throws Exception;

}
