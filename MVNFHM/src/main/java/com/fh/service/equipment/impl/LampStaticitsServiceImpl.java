package com.fh.service.equipment.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.entity.system.Menu;
import com.fh.service.equipment.LampStatictisService;
import com.fh.util.PageData;

@Service("lampStatictisService")
public class LampStaticitsServiceImpl implements LampStatictisService {
	@Resource(name = "daoSupport")
	private DaoSupport dao;

	/**
	 * 灯能耗 day，
	 * 
	 * @param pd
	 * @return
	 */
	@Override
	public List<PageData> listLampEnergyStatitcsNumByDay(Page page) throws Exception {
		return (List<PageData>) dao.findForList("EquipmentMapper.select_lamp_energy_day", page);
		// TODO Auto-generated method stub

	}

	/**
	 * 灯能耗 week，
	 * 
	 * @param pd
	 * @return
	 */
	public List<PageData> listLampEnergyStatitcsNumByWeek(Page page) throws Exception {
		return (List<PageData>) dao.findForList("EquipmentMapper.select_lamp_energy_week", page);
		// TODO Auto-generated method stub

	}

	/**
	 * 灯能耗 month，
	 * 
	 * @param pd
	 * @return
	 */
	public List<PageData> listLampEnergyStatitcsNumByMonth(Page page) throws Exception {
		return (List<PageData>) dao.findForList("EquipmentMapper.select_lamp_energy_month", page);
		// TODO Auto-generated method stub
	}
	
	/**
	 * @param menu
	 * @throws Exception
	 */
	public void saveMenuCard(PageData pd) throws Exception{
		dao.save("EquipmentMapper.insertSubMenu", pd);
	}
	
	/**
	 * @param menu
	 * @throws Exception
	 */
	public void delMenuCard(PageData pd) throws Exception{
		dao.save("EquipmentMapper.deleteSubMenu", pd);
	}
}
