package com.fh.service.clienttype;

import java.util.List;

import com.fh.entity.Page;
import com.fh.util.PageData;

/**
 * 基础配置类接口
 * 
 * @author hongzhiyuanzj
 *
 */
public interface ClienttypeService {

	/**
	 * 修改灯信息
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public void editLamp(PageData pd) throws Exception;

	/**
	 * 新增灯信息
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public void createLamp(PageData pd) throws Exception;

	/**
	 * 修改传感器信息
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public void editSensor(PageData pd) throws Exception;

	/**
	 * 新增传感器信息
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public void createSensor(PageData pd) throws Exception;


	/**
	 * 修改网关
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void editGateway(PageData pd) throws Exception;

	/**
	 * 新增网关
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void createGateway(PageData pd) throws Exception;
	
	/**
	 * 修改断路器
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void editBreaker(PageData pd) throws Exception;

	/**
	 * 新增断路器
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void createBreaker(PageData pd) throws Exception;
	/**
	 * 修改终端
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void editClient(PageData pd) throws Exception;

	/**
	 * 新增终端
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void createClient(PageData pd) throws Exception;



	/**
	 * 获取所有灯
	 * 
	 * @return
	 * @throws Exception
	 */
	public List<PageData> getLampList(Page page) throws Exception;

	/**
	 * 获取所有传感器
	 * 
	 * @return
	 * @throws Exception
	 */
	public List<PageData> getSensorList(Page page) throws Exception;
	
	/**
	 * 获取所有终端
	 * 
	 * @return
	 * @throws Exception
	 */
	public List<PageData> getClientList(Page page) throws Exception;
	/**
	 * 获取所有网关
	 * 
	 * @return
	 * @throws Exception
	 */
	public List<PageData> getGatewayList(Page page) throws Exception;
	
	/**
	 * 获取所有断路器
	 * 
	 * @return
	 * @throws Exception
	 */
	public List<PageData> getBreakerList(Page page) throws Exception;


	/**
	 * 根据id获取灯
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData getLampById(PageData pd) throws Exception;
	
	/**
	 * 根据id获取断路器
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData getBreakerById(PageData pd) throws Exception;
	
	/**
	 * 根据id获取网关
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData getGatewayById(PageData pd) throws Exception;
	
	/**
	 * 根据id获取传感器
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData getSensorById(PageData pd) throws Exception;
	/**
	 * 根据id获取传感器
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData getClientById(PageData pd) throws Exception;
	
	/**删除图片
	 * @param pd
	 * @throws Exception
	 */
	public void delSensorPic(PageData pd)throws Exception;
	
	/**删除图片
	 * @param pd
	 * @throws Exception
	 */
	public void delLampPic(PageData pd)throws Exception;
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delGateway(PageData pd)throws Exception;
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delSensor(PageData pd)throws Exception;
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delLamp(PageData pd)throws Exception;
	
	/**删除check
	 * @param pd
	 * @throws Exception
	 */
	public PageData getClientTypeCount(PageData pd)throws Exception;
	
	/**删除check
	 * @param pd
	 * @throws Exception
	 */
	public PageData getSensorTypeCount(PageData pd)throws Exception;
	
	/**删除check
	 * @param pd
	 * @throws Exception
	 */
	public PageData getGatewayTypeCount(PageData pd)throws Exception;

}
