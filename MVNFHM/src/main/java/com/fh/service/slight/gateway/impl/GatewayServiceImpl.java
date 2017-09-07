package com.fh.service.slight.gateway.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.service.slight.gateway.GatewayService;
import com.fh.util.PageData;

@Service("gatewayService")
public class GatewayServiceImpl implements GatewayService{
	@Resource(name="daoSupport")
	 private DaoSupport dao;


	public List<PageData> getGatewayList(Page page) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>)dao.findForList("RepairMapper.getGatewaylistPage", page);
	}

	public void editGateway(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		dao.update("RepairMapper.editGateway", pd);
	}

	public PageData getGatewayById(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		return (PageData)dao.findForObject("RepairMapper.getGatewayById", pd);
	}
	public void createGateway(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		dao.save("RepairMapper.createGateway", pd);
	}

}
