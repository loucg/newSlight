package com.fh.service.street.state.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.service.street.state.LampStateService;
import com.fh.util.PageData;

@Service("lampStateService")
public class LampStateServiceImpl implements LampStateService {
	
	@Resource(name = "daoSupport")
	private DaoSupport dao;

	/**
	 * 列表
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listLampState(Page page) throws Exception {
		return (List<PageData>)dao.findForList("LampStateMapper.lampstatelistPage", page);
	}

	/**
	 * 获取状态
	 * @throws Exception 
	 */
	public PageData getStatus(PageData pd) throws Exception{
		return (PageData)dao.findForObject("LampStateMapper.findStatus", pd);
	}

	/**
	 * 灯详细信息
	 */
	public PageData viewLampDetail(PageData pd) throws Exception {
		return (PageData)dao.findForObject("LampStateMapper.lampDetail", pd);
	}

	/**
	 * 调节灯的亮度
	 */
	public void adjustBrt(PageData pd) throws Exception {
		dao.update("LampStateMapper.adjustBrt", pd);
	}

	/**
	 * 查询策略
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> getStrategy(Page page) throws Exception {
		return (List<PageData>)dao.findForList("LampStateMapper.findStrategy", page);
	}

	/**
	 * 调节组的策略
	 */
	public void upTermStrid(PageData pd) throws Exception {
		dao.update("LampStateMapper.adjustStr", pd);
	}

	

}
