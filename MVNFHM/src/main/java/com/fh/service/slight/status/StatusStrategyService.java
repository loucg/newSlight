package com.fh.service.slight.status;

import java.util.List;

import com.fh.util.PageData;

/**
 * 亮灯统计分组配置接口
 * @author hongzhiyuanzj
 *
 */
public interface StatusStrategyService {
	
	/**
	 * 按日查找
	 * @return
	 */
	public List<PageData> getDayGroupList(PageData pd) throws Exception;
	
	/**
	 * 按月查找
	 * @return
	 */
	public List<PageData> getMonthGroupList(PageData pd) throws Exception;
	
	/**
	 * 获取策略列表
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> getStrategyList(PageData pd) throws Exception;
}
