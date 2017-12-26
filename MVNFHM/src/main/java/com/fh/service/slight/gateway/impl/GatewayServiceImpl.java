package com.fh.service.slight.gateway.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.service.analysis.repair.RepairanalysisManager;
import com.fh.service.slight.gateway.GatewayService;
import com.fh.util.PageData;

@Service("gatewayService")
public class GatewayServiceImpl implements GatewayService{
	@Resource(name="daoSupport")
	 private DaoSupport dao;
	
	@Resource(name="repairanalysisService")
	private RepairanalysisManager repairanalysisService;


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
		dao.save("RepairMapper.createGatewayRepairInfo", pd);
	}
	
	public void editRegistion(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		dao.update("RepairMapper.editRegistion", pd);
	}
	
	public void updateFaultGateway(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		dao.save("RepairMapper.updateFaultGateway", pd);
	}

	/**
	 * 登記网关修復信息
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	@Override
	@Transactional
	public void registe(PageData pd) throws Exception {
		// 創建維修數據
		createGateway(pd);
		//更新網關狀態
		dao.save("RepairMapper.updateGatewayStatusById", pd);
	}
}
