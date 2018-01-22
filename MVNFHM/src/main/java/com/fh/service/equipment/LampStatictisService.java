package com.fh.service.equipment;

import java.util.List;

import com.fh.entity.Page;
import com.fh.entity.system.Menu;
import com.fh.util.PageData;

public interface LampStatictisService {


	/**
	 * 灯能耗 DAY，
	 * 
	 * @param pd
	 * @return
	 */
	public List<PageData> listLampEnergyStatitcsNumByDay(Page page) throws Exception;

	/**
	 * 灯能耗 week，
	 * 
	 * @param pd
	 * @return
	 */
	public List<PageData> listLampEnergyStatitcsNumByWeek(Page page) throws Exception;

	/**
	 * 灯能耗 month，
	 * 
	 * @param pd
	 * @return
	 */
	public List<PageData> listLampEnergyStatitcsNumByMonth(Page page) throws Exception;
	
	/**
	 * @param menu
	 * @throws Exception
	 */
	public void saveMenuCard(PageData pd) throws Exception;
	
	/**
	 * @param menu
	 * @throws Exception
	 */
	public void delMenuCard(PageData pd) throws Exception;
	
}
