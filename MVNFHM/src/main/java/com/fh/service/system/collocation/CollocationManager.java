package com.fh.service.system.collocation;

import java.util.List;

import com.fh.entity.Page;
import com.fh.util.PageData;

public interface CollocationManager {
	
	/**获取系统配置列表
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> list(Page page)throws Exception;
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception;
	
	/**修改部门
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception;
	
	/**获取部门id
	 * @param pd
	 * @throws Exception
	 */
	public PageData getid(String companyid)throws Exception;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception;
}
