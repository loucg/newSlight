package com.fh.service.group.mem;

import java.util.List;

import com.fh.entity.Page;
import com.fh.util.PageData;

/**
 * 分组配置的接口
 * @author xiaozhou
 *
 */
public interface GroupMemService {

	/**
	 * 获取分组后的组列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	List<PageData> listMem(Page page)throws Exception;

	/**
	 * 获取未分组的成员列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	List<PageData> listOthers(Page page)throws Exception;

	/**
	 * 添加组成员
	 * @param pd
	 * @throws Exception
	 */
	void addMember(PageData pd) throws Exception;

	/**
	 * 踢删组员
	 * @param pd
	 * @throws Exception
	 */
	void removeMember(PageData pd) throws Exception;

	/**
	 * 修改组员
	 * @param highp
	 * @throws Exception
	 */
	void update(PageData pd) throws Exception;

	/**
	 * 添加组网c_gateway_term
	 * @param pd
	 * @throws Exception
	 */
	
	void addMemberAssist(PageData pd) throws Exception;

	/**
	 * 一次搜索
	 * @param pd
	 * @throws Exception
	 */
	List<PageData> getGTList(PageData pd) throws Exception;

	/**
	 * 二次搜索
	 * @param pd
	 * @throws Exception
	 */
	List<PageData> getSGTList(PageData pd) throws Exception;

	void addMemberAssistFirst(PageData pd) throws Exception;
	
	/**
	 * 	删除网组表里面的数据（最后一张表）
	 * @param pd
	 * @throws Exception
	 */
	void removeMemberLast(PageData pd) throws Exception;

	List<PageData> searchRemoveMember(PageData pd) throws Exception;

	Integer conutRemoveMember(PageData pd) throws Exception;

	void removeMemberContinueLast(PageData pd) throws Exception;

	Integer searchRemoveMemberGT(PageData pd) throws Exception;
	

	Integer solveProblemMember(PageData pd) throws Exception;

	void addCmdContent(PageData pd) throws Exception;
	Integer searchUserLogId(PageData pd) throws Exception;

	Integer searchfirst(PageData pd) throws Exception;

	Integer searchsecond(PageData pd) throws Exception;

	String searchthird(PageData pd) throws Exception;
	
	void finallypage(PageData pd) throws Exception;

	//踢除部分的命令
	List<PageData> getGatewayId(PageData pd) throws Exception;

	Integer searchdeletefirst(PageData pd) throws Exception;

	Integer searchdeletesecond(PageData pd) throws Exception;

	String searchdeletethird(PageData pd) throws Exception;

	void finallydeletepage(PageData pd) throws Exception;

	Integer getSGTListcount(PageData pd) throws Exception;

	List<PageData> getSGTListAll(PageData pd) throws Exception;

	void finallypagelast(PageData pd) throws Exception;

	void finallydeletepagelast(PageData pd) throws Exception;
 
	 
	
 

 
 

}
