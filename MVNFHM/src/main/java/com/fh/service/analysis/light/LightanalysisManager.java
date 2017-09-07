package com.fh.service.analysis.light;

import java.util.List;

import com.fh.entity.Page;
import com.fh.util.PageData;

public interface LightanalysisManager {

	/**获取系统配置列表
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> list(Page page)throws Exception;

}
