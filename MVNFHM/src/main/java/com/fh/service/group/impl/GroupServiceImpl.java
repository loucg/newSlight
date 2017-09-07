package com.fh.service.group.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.service.group.GroupService;
import com.fh.util.PageData;

@Service("groupService")
public class GroupServiceImpl implements GroupService {
	
	@Resource(name = "daoSupport")
	private DaoSupport dao;

	/**
	 * 列表
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listGroup(Page page) throws Exception {
		return (List<PageData>)dao.findForList("GroupMapper.grouplistPage", page);
	}

	/**
	 * 组信息
	 */
	public PageData findById(PageData pd) throws Exception {
		return (PageData)dao.findForObject("GroupMapper.findById", pd);
	}

	/**
	 * 新增分组
	 */
	public void addGroup(PageData pd) throws Exception {
		dao.save("GroupMapper.saveGroup", pd);
	}

	/**
	 * 更新分组
	 */
	public void updateGroup(PageData pd) throws Exception {
		dao.update("GroupMapper.editGroup", pd);
	}

	/**
	 * 获取灯杆数
	 */
	public PageData getLampCount(PageData pd) throws Exception {
		return (PageData)dao.findForObject("GroupMapper.findById", pd);
	}

	/**
	 * 删除分组
	 */
	public void deleteGroup(String id) throws Exception {
		dao.delete("GroupMapper.deleteById", id);
	}

	

}
