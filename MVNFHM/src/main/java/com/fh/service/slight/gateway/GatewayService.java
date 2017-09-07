package com.fh.service.slight.gateway;

import java.util.List;

import com.fh.entity.Page;
import com.fh.util.PageData;

/**
 * 基础配置类接口
 * @author mxc
 *
 */
public interface GatewayService {
	
	/**
	 * 获取网关维修记录列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	 
	public List<PageData> getGatewayList(Page page) throws Exception;

	/**
	 * 修改网关维修记录
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public void editGateway(PageData pd) throws Exception;
	/*	*//**
	 * 新增网关维修记录
	 * @param pd
	 * @return
	 * @throws Exception
	 */ 
	public void createGateway(PageData pd) throws Exception; 
	
	/**
	 * 根据id获取网关维修记录
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData getGatewayById(PageData pd) throws Exception;

}
