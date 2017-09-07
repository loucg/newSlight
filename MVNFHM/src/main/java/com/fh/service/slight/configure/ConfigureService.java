package com.fh.service.slight.configure;

import java.util.List;

import com.fh.entity.Page;
import com.fh.util.PageData;

/**
 * 基础配置类接口
 * 
 * @author hongzhiyuanzj
 *
 */
public interface ConfigureService {

	/**
	 * 获得普通电源列表
	 * 
	 * @return
	 * @throws Exception
	 */
	public List<PageData> getNPowerList(Page page) throws Exception;

	/**
	 * 修改普通电源
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public void editNPower(PageData pd) throws Exception;

	/**
	 * 新增普通电源
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public void createNPower(PageData pd) throws Exception;

	/**
	 * 获取灯信息列表
	 * 
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public List<PageData> getLampList(Page page) throws Exception;

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
	 * 获取传感器列表
	 * 
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public List<PageData> getSensorList(Page page) throws Exception;

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
	 * 获取灯杆列表
	 * 
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public List<PageData> getPoleList(Page page) throws Exception;

	/**
	 * 修改灯杆信息
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public void editPole(PageData pd) throws Exception;

	/**
	 * 新增灯杆信息
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public void createPole(PageData pd) throws Exception;

	/**
	 * 获取sim卡列表
	 * 
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public List<PageData> getSimList(Page page) throws Exception;

	/**
	 * 修改sim卡信息
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public void editSim(PageData pd) throws Exception;

	/**
	 * 新增sim卡信息
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public void createSim(PageData pd) throws Exception;

	/**
	 * 获取一体化电源和单灯控制器
	 * 
	 * @return
	 */
	public List<PageData> getDeviceList(Page page) throws Exception;

	/**
	 * 获取网关、断路器、普通断路器
	 * 
	 * @return
	 * @throws Exception
	 */
	public List<PageData> getGatewayList(Page page) throws Exception;

	/**
	 * 获取断路器
	 * 
	 * @return
	 * @throws Exception
	 */
	public List<PageData> getBreakerList(Page page) throws Exception;

	/**
	 * 修改一体化电源和单灯控制器
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void editDevice(PageData pd) throws Exception;

	/**
	 * 新增一体化电源和单灯控制器
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void createDevice(PageData pd) throws Exception;

	/**
	 * 修改网关、断路器、普通断路器
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void editGateway(PageData pd) throws Exception;

	/**
	 * 新增网关 、断路器、普通断路器
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void createGateway(PageData pd) throws Exception;

	/**
	 * 获取类型列表
	 * 
	 * @return
	 * @throws Exception
	 */
	public List<PageData> getDeviceType(PageData pd) throws Exception;

	/**
	 * 获取所有普通电源
	 * 
	 * @return
	 * @throws Exception
	 */
	public List<PageData> getAllNPower(PageData pd) throws Exception;

	/**
	 * 获取所有灯
	 * 
	 * @return
	 * @throws Exception
	 */
	public List<PageData> getAllLamp(PageData pd) throws Exception;

	/**
	 * 获取所有灯杆
	 * 
	 * @return
	 * @throws Exception
	 */
	public List<PageData> getAllPole(PageData pd) throws Exception;

	/**
	 * 获取所有传感器
	 * 
	 * @return
	 * @throws Exception
	 */
	public List<PageData> getAllSensor(PageData pd) throws Exception;

	/**
	 * 获取所有sim卡
	 * 
	 * @return
	 * @throws Exception
	 */
	public List<PageData> getAllSim(PageData pd) throws Exception;

	/**
	 * 根据id获取灯
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData getLampById(PageData pd) throws Exception;

	/**
	 * 根据id获取普通电源
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData getNPowerById(PageData pd) throws Exception;

	/**
	 * 根据id获取灯杆
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData getPoleById(PageData pd) throws Exception;

	/**
	 * 根据id获取传感器
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData getSensorById(PageData pd) throws Exception;

	/**
	 * 根据id获取Sim卡
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData getSimById(PageData pd) throws Exception;

	/**
	 * 根据id获取网关断路器
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData getGatewayAndBreakById(PageData pd) throws Exception;

	/**
	 * 根据id获取终端
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData getDeviceById(PageData pd) throws Exception;

	/**
	 * 根据编号获取终端
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData getDeviceByNumber(PageData pd) throws Exception;

	public PageData getGatewayByNumber(PageData pd) throws Exception;

	/**
	 * 获取网关类型
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> getTypeList(Page page) throws Exception;

	/**
	 * 获取断路器类型
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> getTypeList2(Page page) throws Exception;

	public void addUserLog(PageData pd) throws Exception;

	public Integer searchUserLogId(PageData pd) throws Exception;

	public void finallyaddpageone(PageData pd) throws Exception;

	public void finallyaddpagetwo(PageData pd) throws Exception;

	/**
	 * 获取网关所在的组
	 * 
	 * @param PageData
	 *            page
	 * @return
	 * @throws Exception
	 */
	public List<PageData> getGateWayTermInfo(Page page) throws Exception;

	/**
	 * 设置网关所在的组
	 * 
	 * @param PageData
	 *            page
	 * @return
	 * @throws Exception
	 */
	public void clearGateWayTermInfo(Page page) throws Exception;
}
