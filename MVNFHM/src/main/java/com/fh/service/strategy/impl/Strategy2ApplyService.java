package com.fh.service.strategy.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.service.strategy.Strategy2ApplyManager;
import com.fh.util.PageData;

/**
 * 应用策略包中策略
 * 
 * @author wap @001 2017/10/17 wap add
 */
@Service("strategy2ApplyService")
public class Strategy2ApplyService implements Strategy2ApplyManager {

	@Resource(name = "daoSupport")
	private DaoSupport dao;

	/**
	 * 通过id查找
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findStrategy2ById(PageData pd) throws Exception {
		return (PageData) dao.findForObject("Strategy2ApplyMapper.findById", pd);
	}

	/**
	 * 添加应用策略包中策略
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void addStrategy2(PageData pd) throws Exception {
		dao.save("Strategy2ApplyMapper.insert", pd);
	}

	/**
	 * 删除应用策略包中策略
	 * 
	 * @param page
	 * @throws Exception
	 */
	public void deleteStrategy2ByIds(Page page) throws Exception {
		dao.delete("Strategy2ApplyMapper.deleteStrategy2ByIds", page);
	}

	/**
	 * 更新应用策略包中策略 下发状态
	 * 
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public void updateStrategy2Status(Page page) throws Exception {
		dao.update("Strategy2ApplyMapper.updateStrategy2Status", page);
	}
	
	/**
	 * 根据复数个应用策略包ID查询所属应用策略
	 * 
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public List<PageData> findStrategy2BySetIds(Page page) throws Exception {
		return (List<PageData>) dao.findForList("Strategy2ApplyMapper.findStrategy2BySetIds", page);
	}
	
	/**
	 * 根据应用策略包ID查询所属应用策略
	 * 
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public List<PageData> listStrategy2BySetId(Page page) throws Exception {
		return (List<PageData>) dao.findForList("Strategy2ApplyMapper.strategy2ApplylistPage", page);
	}

}
