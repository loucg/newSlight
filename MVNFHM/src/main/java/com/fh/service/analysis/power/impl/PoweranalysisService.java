package com.fh.service.analysis.power.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.service.analysis.power.PoweranalysisManager;
import com.fh.util.PageData;

@Service("analysispowerService")
public class PoweranalysisService implements PoweranalysisManager{
	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**获取公司列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("PowerMapper.datalistPage", page);
	}
	
	@SuppressWarnings("unchecked")
	public List<PageData> monthlist(Page page)throws Exception{
		return (List<PageData>)dao.findForList("PowerMapper.monthdatalistPage", page);
	}
	
	@SuppressWarnings("unchecked")
	public List<PageData> firstmonthlist(Page page)throws Exception{
		return (List<PageData>)dao.findForList("PowerMapper.firstdatalistPage", page);
	}
}
