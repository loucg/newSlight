package com.fh.service.analysis.light.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.service.analysis.light.LightanalysisManager;
import com.fh.util.PageData;

@Service("lightanalysisService")
public class LightanalysisService implements LightanalysisManager{
	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**获取公司列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("LightMapper.datalistPage", page);
	}
}
