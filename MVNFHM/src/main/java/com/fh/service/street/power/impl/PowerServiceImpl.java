package com.fh.service.street.power.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.service.street.power.PowerService;
import com.fh.util.PageData;

@Service("powerService")
public class PowerServiceImpl implements PowerService {
	
	@Resource(name = "daoSupport")
	private DaoSupport dao;


	//默认
	@SuppressWarnings("unchecked")
	public List<PageData> listPowerDaily(Page page) throws Exception {
		return (List<PageData>)dao.findForList("PowerMapper.DefaultPower", page);
	}

	//查询表 b_term_power_daily_report
	@SuppressWarnings("unchecked")
	public List<PageData> listPowerByDay(Page page) throws Exception {
		return (List<PageData>)dao.findForList("PowerMapper.PowerDaily", page);
	}

	//查询表 b_client_power_monthly_report
	@SuppressWarnings("unchecked")
	public List<PageData> listPowerByMonth(Page page) throws Exception {
		return (List<PageData>)dao.findForList("PowerMapper.PowerMonth", page);
	}




}
