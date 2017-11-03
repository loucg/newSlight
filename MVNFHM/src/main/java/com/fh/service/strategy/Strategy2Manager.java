package com.fh.service.strategy;

import java.util.List;

import com.fh.entity.Page;
import com.fh.util.PageData;

/**
 * 策略组中策略类
 * 
 * @author wap 修改日期：2017.7.30
 */
public interface Strategy2Manager {

	/**
	 * 策略组中策略列表
	 * 
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public List<PageData> listStrategy2(Page page) throws Exception;

	/**
	 * 通过策略组中策略id查找中策略组中策略
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findStrategy2ById(PageData pd) throws Exception;

	/**
	 * 选择添加策略组中策略
	 * 
	 * @param page
	 * @throws Exception
	 */
	public void selectStrategy2(Page page) throws Exception;
	
	/**
	 * 添加策略组中策略
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void addStrategy2(PageData pd) throws Exception;

	/**
	 * 保存修改策略组中策略
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void editStrategy2(PageData pd) throws Exception;

	/**
	 * 踢删策略组中策略
	 * 
	 * @param page
	 * @throws Exception
	 */
	public void deleteStrategy2ById(Page page) throws Exception;

	/**
	 * 更新策略组中策略 下发状态
	 * 
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public void updateStrategy2Status(Page page) throws Exception;

	/**
	 * 获得指定策略包中所有有效策略数量
	 * 
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public PageData getStrategy2CountBySetId(Page page) throws Exception;
	
}
