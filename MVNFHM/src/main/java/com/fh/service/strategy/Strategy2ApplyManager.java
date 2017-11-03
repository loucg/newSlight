package com.fh.service.strategy;

import java.util.List;

import com.fh.entity.Page;
import com.fh.util.PageData;

/**
 * 应用策略包中策略类
 * 
 * @author wap
 * @author wap @001 2017/10/17 wap add
 */
public interface Strategy2ApplyManager {

	/**
	 * 通过应用策略id查找应用策略
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findStrategy2ById(PageData pd) throws Exception;

	/**
	 * 添加应用策略包中策略
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void addStrategy2(PageData pd) throws Exception;

	/**
	 * 删除策略包中策略
	 * 
	 * @param page
	 * @throws Exception
	 */
	public void deleteStrategy2ByIds(Page page) throws Exception;

	/**
	 * 更新应用策略包中策略 下发状态
	 * 
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public void updateStrategy2Status(Page page) throws Exception;
	
	/**
	 * 根据复数个应用策略包ID查询所属应用策略
	 * 
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public List<PageData> findStrategy2BySetIds(Page page) throws Exception;

	/**
	 * 根据应用策略包ID查询所属所属应用策略
	 * 
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public List<PageData> listStrategy2BySetId(Page page) throws Exception;
	
}
