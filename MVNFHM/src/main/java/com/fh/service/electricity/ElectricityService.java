package com.fh.service.electricity;

import java.util.List;

import com.fh.entity.Page;
import com.fh.util.PageData;

/**
 * 通电设置的类接口
 * @author xiaozhou
 *
 */
public interface ElectricityService {

	/**
	 * 获取终端和上电下点时间的列表
	 * @param page
	 * @return
	 */
	public List<PageData> listElectricity(Page page) throws Exception;

	/**
	 * 通过id获取数据
	 * @param pd
	 * @return
	 */
	public PageData findById(PageData pd) throws Exception;

	/**
	 * 修改一条上电断电时间
	 * @param pd
	 */
	public void update(PageData pd) throws Exception;


}
