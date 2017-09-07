package com.fh.service.equipment;

import java.util.List;

import com.fh.entity.Page;
import com.fh.util.PageData;

public interface EquipmentService {
	/**
	 * 获取网关在线率，
	 * 
	 * @param page
	 * @return
	 */
	public List<PageData> listGatenum(Page page) throws Exception;

	/**
	 * 获取灯在线率，
	 * 
	 * @param pd
	 * @return
	 */
	public List<PageData> listLightnum(Page page) throws Exception;

	/**
	 * 设备损坏数，
	 * 
	 * @param pd
	 * @return
	 */
	public List<PageData> listEquipmentFaultNum(Page page) throws Exception;

	/**
	 * 设备总数，
	 * 
	 * @param pd
	 * @return
	 */
	public List<PageData> listEquipmentNum(Page page) throws Exception;

	/**
	 * 统计损坏数量 month，
	 * 
	 * @param pd
	 * @return
	 */
	public List<PageData> listDeviceFaultStatitcsNum(Page page) throws Exception;

	/**
	 * 统计损坏数量 week，
	 * 
	 * @param pd
	 * @return
	 */
	public List<PageData> listDeviceFaultStatitcsNumbyweek(Page page) throws Exception;

	/**
	 * 统计损坏数量 month，
	 * 
	 * @param pd
	 * @return
	 */
	public List<PageData> listDeviceFaultStatitcsNumbymonth(Page page) throws Exception;

	/**
	 * 插入损坏设备数目
	 */

	public void update(Page pd) throws Exception;

	/**
	 * 删除损坏设备数目
	 */

	public void delete(Page pd) throws Exception;
}
