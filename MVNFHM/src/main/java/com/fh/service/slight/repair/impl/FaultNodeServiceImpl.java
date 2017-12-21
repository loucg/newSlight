package com.fh.service.slight.weixiu.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.service.slight.weixiu.WeixiuService;
import com.fh.util.PageData;

@Service("weixiuService")
public class WeixiuServiceImpl implements WeixiuService{
	
	@Resource(name="daoSupport")
	 private DaoSupport dao;
	
	public List<PageData> getWeixiuList(Page page) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>) dao.findForList("RepairMapper.getWeixiulistPage", page);
	}

	public void editWeixiu(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		dao.update("RepairMapper.editWeixiu", pd);
	}

	public PageData getWeixiuById(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		return (PageData)dao.findForObject("RepairMapper.getWeixiuById", pd);
	}

 	public void createWeixiu(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		dao.save("RepairMapper.createWeixiu", pd);
	} 


}
