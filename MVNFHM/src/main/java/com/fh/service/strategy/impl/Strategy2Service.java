package com.fh.service.strategy.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.service.strategy.Strategy2Manager;
import com.fh.util.PageData;

/**
 * 策略中策略
 * 
 * @author wap 修改日期：2017.7.29
 * @002 2017/11/2 wap modify 
 */
@Service("strategy2Service")
public class Strategy2Service implements Strategy2Manager {

	@Resource(name = "daoSupport")
	private DaoSupport dao;

	/**
	 * 策略列表
	 * 
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listStrategy2(Page page) throws Exception {
		return (List<PageData>) dao.findForList("Strategy2Mapper.strategy2listPage", page);
	}

	/**
	 * 通过id查找
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findStrategy2ById(PageData pd) throws Exception {
		return (PageData) dao.findForObject("Strategy2Mapper.findById", pd);
	}

	/**
	 * 选择添加策略组中策略
	 * 
	 * @param page
	 * @throws Exception
	 */
	public void selectStrategy2(Page page) throws Exception {
		dao.save("Strategy2Mapper.insertStrategy2", page);
	}
	
	/**
	 * 添加策略组中策略
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void addStrategy2(PageData pd) throws Exception {
		dao.save("Strategy2Mapper.insert", pd);
	}

	/**
	 * 保存修改
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void editStrategy2(PageData pd) throws Exception {
		dao.update("Strategy2Mapper.edit", pd);
	}

	/**
	 * 删除策略组中策略
	 * 
	 * @param page
	 * @throws Exception
	 */
	public void deleteStrategy2ById(Page page) throws Exception {
		dao.delete("Strategy2Mapper.deleteStrategy2ByIds", page);
	}

	/**
	 * 更新策略组中策略 下发状态
	 * 
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public void updateStrategy2Status(Page page) throws Exception {
		dao.update("Strategy2Mapper.updateStrategy2Status", page);
	}
	
	/**
	 * 获得指定策略包中所有有效策略数量
	 * 
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public PageData getStrategy2CountBySetId(Page page) throws Exception {
		return (PageData) dao.findForObject("Strategy2Mapper.getStrategy2CountBySetId", page);
	}
	
}
