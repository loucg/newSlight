package com.fh.service.system.status.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.system.Status;
import com.fh.service.system.status.StatusManager;
import com.fh.util.PageData;

/**	状态
 * @author zjc
 * 修改日期：2017.1.29
 */
@Service("statusService")
public class StatusService implements StatusManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**列出所有状态
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Status> listAllStatusByPId(PageData pd) throws Exception {
		return (List<Status>) dao.findForList("StatusMapper.listAllStatusByPId", pd);
	}
	
	/**列出所有帐号状态
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Status> listAllAccountStatusById(PageData pd) throws Exception {
		return (List<Status>) dao.findForList("StatusMapper.listAllAccountStatusById", pd);
	}
	
	/**通过id查找
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findObjectById(PageData pd) throws Exception {
		return (PageData)dao.findForObject("StatusMapper.findObjectById", pd);
	}
	
	/**添加
	 * @param pd
	 * @throws Exception
	 */
	public void add(PageData pd) throws Exception {
		dao.save("StatusMapper.insert", pd);
	}
	
	/**保存修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd) throws Exception {
		dao.update("StatusMapper.edit", pd);
	}
	
	/**删除状态
	 * @param id
	 * @throws Exception
	 */
	public void deleteStatusById(String id) throws Exception {
		dao.delete("StatusMapper.deleteStatusById", id);
	}
	
	/**通过id查找
	 * @param id
	 * @return
	 * @throws Exception
	 */
	public Status getStatusById(String id) throws Exception {
		return (Status) dao.findForObject("StatusMapper.getStatusById", id);
	}

}
