package com.fh.service.slight.repair.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.service.slight.repair.MaintenanceRecordService;
import com.fh.service.slight.repair.NodeRepairService;
import com.fh.util.PageData;

@Service("maintenanceRecordService")
public class MaintenanceRecordServiceImpl implements MaintenanceRecordService{
	@Resource(name="daoSupport")
	private DaoSupport dao;
	
	/**
	 * 获取所有维修记录列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> getMaintenanceRecordList(Page page) throws Exception {
		return (List<PageData>) dao.findForList("MaintenanceRecordMapper.getOwnClientlistPage", page);
	}
	
	/**
	 * 根据id获取网关维修记录
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData getFaultGatewayById(PageData pd) throws Exception {
		return (PageData)dao.findForObject("MaintenanceRecordMapper.getGatewayFaultById", pd);
	}

}
