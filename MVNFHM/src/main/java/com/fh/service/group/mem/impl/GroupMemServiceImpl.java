package com.fh.service.group.mem.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.service.group.mem.GroupMemService;
import com.fh.util.PageData;

@Service("groupMemService")
public class GroupMemServiceImpl implements GroupMemService {
	
	@Resource(name = "daoSupport")
	private DaoSupport dao;

	/**
	 * 已分组列表
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listMem(Page page) throws Exception {
		return (List<PageData>)dao.findForList("GroupMemMapper.memlistPage", page);
	}

	/**
	 * 未分组成员列表
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listOthers(Page page) throws Exception {
		return (List<PageData>)dao.findForList("GroupMemMapper.otherlistPage", page);
	}

	/**
	 * 添加组成员
	 */
	public void addMember(PageData pd) throws Exception {
		dao.save("GroupMemMapper.addMember", pd);
		
	}
	
	/**
	 * 一次搜索
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> getGTList(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>)dao.findForList("GroupMemMapper.getGTList", pd);
	}
	/**
	 * 二次搜索
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> getSGTList(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>) dao.findForList("GroupMemMapper.getSGTList", pd);
	}
	
	/**
	 * 一次搜索(最后一张表)
	 * @return 
	 */
	@Override
	public void addMemberAssistFirst(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		dao.save("GroupMemMapper.addMemberAssistFirst", pd);
	}

	@Override
	public void addMemberAssist(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		dao.save("GroupMemMapper.addMemberAssist", pd);
	}



	/**
	 * 踢删组员
	 */
	public void removeMember(PageData pd) throws Exception {
		dao.delete("GroupMemMapper.removeMember", pd);
	}

	/**
	 * 修改组员
	 */
	public void update(PageData pd) throws Exception {
		dao.update("GroupMemMapper.updateMember", pd);
	}

	/**
	 * 删除网组表里面的数据（最后一张表）
	 */
	@Override
	public void removeMemberLast(PageData pd) throws Exception {
		dao.delete("GroupMemMapper.removeMemberLast", pd);
	}

 

	@Override
	public Integer solveProblemMember(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		return  (Integer) dao.findForObject("GroupMemMapper.solveProblemMember", pd);
	}

	@Override
	public List<PageData> searchRemoveMember(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void removeMemberContinueLast(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		dao.delete("GroupMemMapper.removeMemberContinueLast", pd);
	}

	/**
	 * 计算的c_gateway_team_id的总数（最后一张表）
	 */
	@Override
	public Integer conutRemoveMember(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		return  (Integer) dao.findForObject("GroupMemMapper.conutRemoveMember", pd);
	}



	
	/**
	 * 剔除人员（别人的思想）
	 */
	@SuppressWarnings("unchecked")
	@Override
	public Integer searchRemoveMemberGT(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		return (Integer) dao.findForObject("GroupMemMapper.searchRemoveMemberGT", pd);
	}

	/**
	 * 添加cmd命令内容1
	 */
	@Override
	public void addCmdContent(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		dao.save("GroupMemMapper.addCmdContent", pd);
	}
	//获取b_user_log的id
	@Override
	public Integer searchUserLogId(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		return  (Integer) dao.findForObject("GroupMemMapper.searchUserLogId", pd);
	}
	
	//111111111
	@Override
	public Integer searchfirst(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		return  (Integer) dao.findForObject("GroupMemMapper.searchfirst", pd);
	}

	@Override
	public Integer searchsecond(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		return  (Integer) dao.findForObject("GroupMemMapper.searchsecond", pd);
	}

	@Override
	public String searchthird(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		return  (String) dao.findForObject("GroupMemMapper.searchthird", pd);
	}

	//插入最后一张命令表
	@Override
	public void finallypage(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		dao.save("GroupMemMapper.finallypage", pd);
	}
	

	@Override
	public void finallypagelast(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		dao.save("GroupMemMapper.finallypagelast", pd);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> getGatewayId(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>) dao.findForList("GroupMemMapper.getGatewayId", pd);
	}

	@Override
	public Integer searchdeletefirst(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		return  (Integer) dao.findForObject("GroupMemMapper.searchdeletefirst", pd);
	}

	@Override
	public Integer searchdeletesecond(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		return  (Integer) dao.findForObject("GroupMemMapper.searchdeletesecond", pd);
	}

	@Override
	public String searchdeletethird(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		return  (String) dao.findForObject("GroupMemMapper.searchdeletethird", pd);
	}

	@Override
	public void finallydeletepage(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		dao.save("GroupMemMapper.finallydeletepage", pd);
	}
	

	@Override
	public void finallydeletepagelast(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		dao.save("GroupMemMapper.finallydeletepagelast", pd);
	}

	@Override
	public Integer getSGTListcount(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		return  (Integer) dao.findForObject("GroupMemMapper.getSGTListcount", pd);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> getSGTListAll(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>) dao.findForList("GroupMemMapper.getSGTListAll", pd);
	}
  
	
}
