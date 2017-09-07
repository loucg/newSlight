package com.fh.service.street.fault.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.service.street.fault.FaultService;
import com.fh.util.PageData;

@Service("faultService")
public class FaultServiceImpl implements FaultService {
	
	@Resource(name = "daoSupport")
	private DaoSupport dao;

	/**
	 * 获取所有异常列表
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAllFault(Page page) throws Exception {
		return (List<PageData>)dao.findForList("FaultMapper.allfaultlistPage", page);
	}
	
	/**
	 * 获取网关异常列表
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listGatewayFault(Page page) throws Exception {
		return (List<PageData>)dao.findForList("FaultMapper.gatewayfaultlistPage", page);
	}

	/**
	 * 获取断路器异常列表
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listBreakerFault(Page page) throws Exception {
		return (List<PageData>)dao.findForList("FaultMapper.breakerfaultlistPage", page);
	}

	/**
	 * 获取路灯异常列表
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listLampFault(Page page) throws Exception {
		return (List<PageData>)dao.findForList("FaultMapper.lampfaultlistPage", page);
	}

	/**
	 * 获取传感器异常列表
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listSensorFault(Page page) throws Exception {
		return (List<PageData>)dao.findForList("FaultMapper.sensorfaultlistPage", page);
	}
	
	/**
	 * 获取电压异常列表
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listVoFault(Page page) throws Exception {
		return (List<PageData>)dao.findForList("FaultMapper.vofaultlistPage", page);
	}

}
