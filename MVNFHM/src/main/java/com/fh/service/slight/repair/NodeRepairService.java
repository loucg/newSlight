package com.fh.service.slight.repair;

import java.util.List;


import com.fh.entity.Page;
import com.fh.util.PageData;

public interface NodeRepairService {
	
	/**
	 * 获取终端故障记录列表
	 * @param page
	 * @return
	 * @throws Exception
	 */	 
	public List<PageData> getFaultNodeList(Page page) throws Exception;
	
	
	/**
	 * 获取节点详细信息
	 * @param PageData
	 * @return
	 * @throws Exception
	 */	 
	public PageData getNodeInfoById(PageData pd) throws Exception;	
	
	/**
	 * 根据id获取终端维修记录
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData getFaultNodeById(PageData pd) throws Exception;

	/**
	 * 新增终端维修记录
	 * @param pd
	 * @return
	 * @throws Exception
	 */ 
	public void insertNodeRepair(PageData pd) throws Exception; 
	
}
