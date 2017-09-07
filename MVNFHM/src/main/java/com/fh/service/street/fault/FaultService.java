package com.fh.service.street.fault;

import java.util.List;

import com.fh.entity.Page;
import com.fh.util.PageData;

/**
 * 路灯状态-故障列表的接口
 * @author xiaozhou
 *
 */
public interface FaultService {

	/**
	 * 获取所有异常列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public List<PageData> listAllFault(Page page) throws Exception;
	
	/**
	 * 获取网关异常列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	List<PageData> listGatewayFault(Page page)throws Exception;
	
	/**
	 * 获取断路器异常列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	List<PageData> listBreakerFault(Page page)throws Exception;

	/**
	 * 获取路灯异常列表
	 * @param page
	 * @return
	 */
	List<PageData> listLampFault(Page page)throws Exception;
	
	/**
	 * 获取传感器异常列表
	 * @param page
	 * @return
	 */
	List<PageData> listSensorFault(Page page)throws Exception;

	/**
	 * 获取电压异常列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	List<PageData> listVoFault(Page page)throws Exception;

}
