package com.fh.service.slight.status.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.service.slight.status.StatusStrategyService;
import com.fh.util.PageData;

@Service("statusStrategyService")
public class StatusStrategyServiceImpl implements StatusStrategyService{

	@Resource(name="daoSupport")
	DaoSupport dao;
	
	@Override
	public List<PageData> getDayGroupList(PageData pd) throws Exception{
		// TODO Auto-generated method stub
		return (List<PageData>)dao.findForList("StatusStrategyMapper.getDayGroup", pd);
	}

	@Override
	public List<PageData> getStrategyList(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>)dao.findForList("StatusStrategyMapper.getStrategyList", pd);
	}


	@Override
	public List<PageData> getMonthGroupList(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>)dao.findForList("StatusStrategyMapper.getMonthGroup", pd);
	}
	
	
}
