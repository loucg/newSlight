package com.fh.service.electricity.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.service.electricity.ElectricityService;
import com.fh.util.PageData;

@Service("electricityService")
public class ElectricityServiceImpl implements ElectricityService {
	
	@Resource(name = "daoSupport")
	private DaoSupport dao;

	
	/**
	 * 列表
	 * @param page
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listElectricity(Page page) throws Exception {
		return (List<PageData>)dao.findForList("ElectricityMapper.electricitylistPage", page);
	}


	/**
	 * 通过id获取数据
	 */
	@Override
	public PageData findById(PageData pd) throws Exception {
		return (PageData)dao.findForObject("ElectricityMapper.findById", pd);
	}


	/**
	 * 修改一条上电断电时间
	 */
	@Override
	public void update(PageData pd) throws Exception {
		dao.update("ElectricityMapper.update", pd);
		
	}


}
