package com.fh.service.analysis.fault.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.service.analysis.fault.FaultanalysisManager;
import com.fh.util.PageData;

@Service("faultanalysisService")
public class FaultanalysisService implements FaultanalysisManager{
	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**获取公司列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("FaultMapper.datalistPage", page);
	}
}
