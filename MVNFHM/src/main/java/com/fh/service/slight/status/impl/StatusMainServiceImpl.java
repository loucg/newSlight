package com.fh.service.slight.status.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.service.slight.status.StatusMainService;
import com.fh.util.PageData;
@Service("statusMainService")
public class StatusMainServiceImpl implements StatusMainService{

	@Resource(name="daoSupport")
	DaoSupport dao;
	
	@Override
	public PageData getStgAndGroupCnt(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		return (PageData)dao.findForObject("StatusStrategyMapper.getStgAndGroupCnt", pd);
		
	}

	@Override
	public PageData getClientTotal(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		return (PageData)dao.findForObject("StatusStrategyMapper.getClientTotal", pd);
	}

	@Override
	public PageData getClientNormal(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		return (PageData)dao.findForObject("StatusStrategyMapper.getClientNormal", pd);
	}

	@Override
	public PageData getGatewayTotal(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		return (PageData)dao.findForObject("StatusStrategyMapper.getGatewayTotal", pd);
	}

	@Override
	public PageData getGatewayNormal(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		return (PageData)dao.findForObject("StatusStrategyMapper.getGatewayNormal", pd);
	}

	@Override
	public PageData getGatewayFaultCnt(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		return (PageData)dao.findForObject("StatusStrategyMapper.getGatewayFaultCnt", pd);
	}

	@Override
	public PageData getClientFaultCnt(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		return (PageData)dao.findForObject("StatusStrategyMapper.getClientFaultCnt", pd);
	}

	@Override
	public PageData getTodayPower(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		return (PageData)dao.findForObject("StatusStrategyMapper.getTodayPower", pd);
	}
	
	

	
	
}
