package com.fh.service.street.state.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.service.street.state.GatewayStateService;
import com.fh.util.PageData;

@Service("gatewayStateService")
public class GatewayStateServiceImpl implements GatewayStateService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;

	/**
	 * 列表
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listGatewayState(Page page) throws Exception {
		return (List<PageData>) dao.findForList("GatewayStateMapper.gatewaystatelistPage", page);
	}

	/**
	 * 获取指定网关 下的所有终端信息
	 * 
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@Override
	public List<PageData> viewClientDetail(Page page) throws Exception {
		return (List<PageData>) dao.findForList("GatewayStateMapper.clientInfolistPage", page);
	}

	/**
	 * 获取指定网关 下的所有终端信息
	 * 
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@Override
	public List<PageData> viewgateWayName(Page page) throws Exception {
		return (List<PageData>) dao.findForList("GatewayStateMapper.getgateway", page);
	}
	
	/**
	 * 获取网关 所有状态
	 * 
	 * @param PageData
	 * @return
	 * @throws Exception
	 */
	@Override
	public List<PageData> getWorkStatus(PageData pd) throws Exception {
		return (List<PageData>) dao.findForList("GatewayStateMapper.getWorkStatus", pd);
	}	
	
	/**
	 * 获取指定网关 下的所有传感器信息
	 * 
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@Override
	public List<PageData> viewSensorDetail(Page page) throws Exception {
		return (List<PageData>) dao.findForList("GatewayStateMapper.sensorInfolistPage", page);
	}
	
	/**
	 * 获取指定网关 下的灯节点个数
	 * 
	 * @param PageData
	 * @return
	 * @throws Exception
	 */
	public int getLampCount(Page pd) throws Exception{
		return (Integer) dao.findForObject("GatewayStateMapper.getLampCount", pd);
	}
	
	/**
	 * 获取指定网关 下的传感器节点个数
	 * 
	 * @param PageData
	 * @return
	 * @throws Exception
	 */
	public int getSensorCount(Page pd) throws Exception{
		return (Integer) dao.findForObject("GatewayStateMapper.getSensorCount", pd);
	}

}
