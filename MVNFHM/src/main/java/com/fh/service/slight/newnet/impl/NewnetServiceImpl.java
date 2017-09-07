package com.fh.service.slight.newnet.impl;


import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.service.slight.newnet.NewnetService;
import com.fh.util.PageData;

@Service("newnetService")

public class NewnetServiceImpl implements NewnetService{
	
	@Resource(name="daoSupport")
	 private DaoSupport dao;

	public PageData getNewnetById(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		return (PageData)dao.findForObject("RepairMapper.getNewnetById", pd);
	}

	public List<PageData> getNewnetList(Page page) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>)dao.findForList("RepairMapper.getNewnetlistPage", page);
	}

	@Override
	public List<PageData> getClientList(Page page) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>) dao.findForList("RepairMapper.getClientlistPage", page);
	}

	
	@Override
	public void addClients(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		dao.save("RepairMapper.addClient", pd);
	}

	@Override
	public List<PageData> getOwnClientList(Page page) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>)dao.findForList("RepairMapper.getOwnClientlistPage", page);
	}

	@Override
	public void deleteClients(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		dao.delete("RepairMapper.deleteClient", pd);
	}

	
	
}
