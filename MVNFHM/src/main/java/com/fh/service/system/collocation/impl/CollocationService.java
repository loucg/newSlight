package com.fh.service.system.collocation.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.service.system.collocation.CollocationManager;
import com.fh.util.PageData;

@Service("collocationService")
public class CollocationService implements CollocationManager{
	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**获取公司列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("CollocationMapper.datalistPage", page);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("CollocationMapper.findById", pd);
	}
	
	/**修改部门
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("CollocationMapper.edit", pd);
	}
	
	/**获取主键
	 * @param pd
	 * @throws Exception
	 */
	public PageData getid(String id)throws Exception{
		return (PageData)dao.findForObject("CollocationMapper.getid",id);
	}
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("CollocationMapper.save", pd);
	}
}
