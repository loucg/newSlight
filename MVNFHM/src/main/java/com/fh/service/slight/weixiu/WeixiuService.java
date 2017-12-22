package com.fh.service.slight.weixiu;

import java.util.List;

import com.fh.entity.Page;
import com.fh.util.PageData;

/**
 * 基础配置类接口
 * @author mxc
 *
 */
public interface WeixiuService {
	
	/**
	 * 获取终端维修记录列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	 
	public List<PageData> getWeixiuList(Page page) throws Exception;

	/**
	 * 修改终端维修记录
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public void editWeixiu(PageData pd) throws Exception;
/*	*//**
	 * 新增终端维修记录
	 * @param pd
	 * @return
	 * @throws Exception
	 */ 
	public void createWeixiu(PageData pd) throws Exception; 
	
	/**
	 * 根据id获取终端维修记录
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData getWeixiuById(PageData pd) throws Exception;

}
