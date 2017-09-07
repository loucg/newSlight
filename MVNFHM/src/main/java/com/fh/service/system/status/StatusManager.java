package com.fh.service.system.status;

import java.util.List;

import com.fh.entity.system.Status;
import com.fh.util.PageData;

/**	状态接口类
 * @author zjc
 * 修改日期：2017.1.29
 */
public interface StatusManager {
	
	/**列出所有状态
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<Status> listAllStatusByPId(PageData pd) throws Exception;
	
	/**列出所有帐号状态
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<Status> listAllAccountStatusById(PageData pd) throws Exception;
	
	/**通过id查找
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findObjectById(PageData pd) throws Exception;
	
	/**添加
	 * @param pd
	 * @throws Exception
	 */
	public void add(PageData pd) throws Exception;
	
	/**保存修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd) throws Exception;
	
	/**删除状态
	 * @param id
	 * @throws Exception
	 */
	public void deleteStatusById(String id) throws Exception;
		
	/**通过id查找
	 * @param id
	 * @return
	 * @throws Exception
	 */
	public Status getStatusById(String id) throws Exception;
		
}
