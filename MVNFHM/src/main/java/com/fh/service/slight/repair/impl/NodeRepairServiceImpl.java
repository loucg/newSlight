package com.fh.service.slight.repair.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.service.slight.repair.NodeRepairService;
import com.fh.util.PageData;

@Service("nodeRepairService")
public class NodeRepairServiceImpl implements NodeRepairService{
	@Resource(name="daoSupport")
	private DaoSupport dao;
	
	/**
	 * 获取终端故障记录列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> getFaultNodeList(Page page) throws Exception {
		return (List<PageData>) dao.findForList("NodeRepairMapper.getFaultNodelistPage", page);
	}
	
	/**
	 * 获取节点详细信息
	 * @param PageData
	 * @return
	 * @throws Exception
	 */	 
	public PageData getNodeInfoById(PageData pd) throws Exception{
		return (PageData)dao.findForObject("NodeRepairMapper.getNodeInfoById", pd);
	}

	/**
	 * 根据id获取终端维修记录
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData getFaultNodeById(PageData pd) throws Exception {
		return (PageData)dao.findForObject("NodeRepairMapper.getFaultNodeById", pd);
	}

	/**
	 * 新增终端维修记录
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	@Transactional
	public void insertNodeRepair(PageData pd) throws Exception {
		dao.save("NodeRepairMapper.createNodeRepair", pd);
		dao.update("NodeRepairMapper.updateFaultNodeStatus", pd);
	} 
}
