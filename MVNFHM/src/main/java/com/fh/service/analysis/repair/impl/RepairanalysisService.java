package com.fh.service.analysis.repair.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.service.analysis.repair.RepairanalysisManager;
import com.fh.util.PageData;


@Service("repairanalysisService")
public class RepairanalysisService implements RepairanalysisManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**获取公司列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("RepairMapper.datalistPage", page);
	}
}
