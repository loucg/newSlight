package com.fh.service.street.state;

import java.util.List;

import com.fh.entity.Page;
import com.fh.util.PageData;

/**
 * 路灯状态-网关状态列表的接口
 * 
 * @author xiaozhou
 *
 */
public interface GatewayStateService {

	/**
	 * 获取列表
	 * 
	 * @param page
	 * @return
	 * @throws Exception
	 */
	List<PageData> listGatewayState(Page page) throws Exception;

	/**
	 * 获取指定网关 下的所有终端信息
	 * 
	 * @param page
	 * @return
	 * @throws Exception
	 */
	List<PageData> viewClientDetail(Page page) throws Exception;

	/**
	 * 获取指定网关 名称
	 * 
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public List<PageData> viewgateWayName(Page page) throws Exception;

	/**
	 * 获取网关 所有状态
	 * 
	 * @param PageData
	 * @return
	 * @throws Exception
	 */
	public List<PageData> getWorkStatus(PageData pd) throws Exception;
	/**
	 * 获取指定网关 下的所有传感器信息
	 * 
	 * @param PageData
	 * @return
	 * @throws Exception
	 */
	public List<PageData> viewSensorDetail(Page page) throws Exception;
}
