package com.fh.service.equipment.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.service.equipment.EquipmentService;
import com.fh.util.PageData;

@Service("equipmentservice")
public class EquipmentServiceImpl implements EquipmentService {
	@Resource(name = "daoSupport")
	private DaoSupport dao;

	/**
	 * 获取网关在线率，
	 * 
	 * @param page
	 * @return
	 */
	@Override
	public List<PageData> listGatenum(Page page) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>) dao.findForList("EquipmentMapper.selectgatewaynum", page);
	}

	/**
	 * 获取灯在线率，
	 * 
	 * @param pd
	 * @return
	 */
	@Override
	public List<PageData> listLightnum(Page page) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>) dao.findForList("EquipmentMapper.selectOnlineLightnum", page);
	}

	/**
	 * 设备损坏数，
	 * 
	 * @param pd
	 * @return
	 */
	@Override
	public List<PageData> listEquipmentFaultNum(Page page) throws Exception {
		return (List<PageData>) dao.findForList("EquipmentMapper.selectEquipmentFaultNum", page);
		// TODO Auto-generated method stub

	}

	/**
	 * 设备总数，
	 * 
	 * @param pd
	 * @return
	 */
	@Override
	public List<PageData> listEquipmentNum(Page page) throws Exception {
		return (List<PageData>) dao.findForList("EquipmentMapper.selectEquipmentNum", page);
		// TODO Auto-generated method stub

	}

	/**
	 * 统计损坏数量，
	 * 
	 * @param pd
	 * @return
	 */
	@Override
	public List<PageData> listDeviceFaultStatitcsNum(Page page) throws Exception {
		return (List<PageData>) dao.findForList("EquipmentMapper.select_devicefault_seq", page);
		// TODO Auto-generated method stub

	}

	/**
	 * 统计损坏数量 week，
	 * 
	 * @param pd
	 * @return
	 */
	public List<PageData> listDeviceFaultStatitcsNumbyweek(Page page) throws Exception {
		return (List<PageData>) dao.findForList("EquipmentMapper.select_devicefault_week", page);
		// TODO Auto-generated method stub

	}

	/**
	 * 统计损坏数量 month，
	 * 
	 * @param pd
	 * @return
	 */
	public List<PageData> listDeviceFaultStatitcsNumbymonth(Page page) throws Exception {
		return (List<PageData>) dao.findForList("EquipmentMapper.select_devicefault_month", page);
		// TODO Auto-generated method stub

	}

	/**
	 * 统计损坏统计插入，
	 * 
	 * @param pd
	 * @return
	 */
	@Override
	public void update(Page pd) throws Exception {
		dao.update("EquipmentMapper.update", pd);

	}

	/**
	 * 统计损坏统计删除
	 * 
	 * @param pd
	 * @return
	 */
	@Override
	public void delete(Page pd) throws Exception {
		dao.update("EquipmentMapper.delete", pd);

	}
}
