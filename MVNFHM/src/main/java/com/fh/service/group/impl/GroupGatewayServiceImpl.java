package com.fh.service.group.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.service.group.GroupGatewayService;
import com.fh.util.PageData;

@Service("groupGatewayService")
public class GroupGatewayServiceImpl implements GroupGatewayService {
	
	@Resource(name = "daoSupport")
	private DaoSupport dao;

	/**
	 * 获取所在分组的网关列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listGateways(Page page) throws Exception {
		return (List<PageData>)dao.findForList("GroupGatewayMapper.getGatewaylistPage", page);
	}	
	
	/**
	 * 获取所在网关的终端列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listClientsByGatewayId(Page page) throws Exception {
		return (List<PageData>)dao.findForList("GroupGatewayMapper.listClientsByGatewayId", page);
	}
}
