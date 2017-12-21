package com.fh.service.slight.repair;

import java.util.List;


import com.fh.entity.Page;
import com.fh.util.PageData;

public interface MaintenanceRecordService {
	
	/**
	 * 获取所有维修记录列表
	 * @param page
	 * @return
	 * @throws Exception
	 */	 
	public List<PageData> getMaintenanceRecordList(Page page) throws Exception;
	
	
	/**
	 * 根据id获取网关维修记录
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData getFaultGatewayById(PageData pd) throws Exception;

}
