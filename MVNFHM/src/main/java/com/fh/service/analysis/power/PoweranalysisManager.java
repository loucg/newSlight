package com.fh.service.analysis.power;

import java.util.List;

import com.fh.entity.Page;
import com.fh.util.PageData;

public interface PoweranalysisManager {

	/**获取系统配置列表
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> list(Page page)throws Exception;
	
	public List<PageData> monthlist(Page page)throws Exception;
	
	public List<PageData> firstmonthlist(Page page)throws Exception;
}
