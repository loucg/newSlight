package com.fh.service.analysis.repair;

import java.util.List;

import com.fh.entity.Page;
import com.fh.util.PageData;

public interface RepairanalysisManager {
	
	/**获取维修列表
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> list(Page page)throws Exception;

}
