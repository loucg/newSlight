package com.fh.service.smartgroup.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.service.smartgroup.SmartGroupService;
import com.fh.util.PageData;

@Service("smartGroupService")
public class SmartGroupServiceImpl implements SmartGroupService {
	
	@Resource(name = "daoSupport")
	private DaoSupport dao;


	/**
	 * 获取灯杆数
	 */
	public PageData getLampCount(PageData pd) throws Exception {
		return (PageData)dao.findForObject("SmartGroupMapper.LampCount", pd);
	}


	/**
	 * 获取功率和
	 */
	public double getSumPower(PageData pd) throws Exception {
		return (double) dao.findForObject("SmartGroupMapper.SumPower", pd);
	}


	/**
	 * 获取对应列表
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> getClientPower(PageData pd) throws Exception {
		return (List<PageData>)dao.findForList("SmartGroupMapper.ClientPower", pd);
	}


	/**
	 * 小组的详细信息
	 */
	public PageData getGroup(PageData pd) throws Exception {
		return (PageData)dao.findForObject("SmartGroupMapper.GroupDetails", pd);
	}


	/**
	 * 获取坐标点
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> getClientCoordinates(PageData pd) throws Exception {
		return (List<PageData>)dao.findForList("SmartGroupMapper.ClientCoordinate", pd);
	}

	

}
