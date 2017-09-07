package com.fh.service.slight.language.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.service.slight.language.InternationalService;
import com.fh.util.PageData;

@Service("internationalService")
public class InternationalServiceImpl implements InternationalService{

	@Resource(name="daoSupport")
	private DaoSupport dao;
	
 
	public PageData getLanguage(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		return (PageData)dao.findForObject("InternationalMapper.getLanguage", pd);
	}
	
	

}
