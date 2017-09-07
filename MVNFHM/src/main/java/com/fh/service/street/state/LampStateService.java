package com.fh.service.street.state;

import java.util.List;

import com.fh.entity.Page;
import com.fh.util.PageData;

/**
 * 路灯状态-网关状态列表的接口
 * @author xiaozhou
 *
 */
public interface LampStateService {

	/**
	 * 获取分组后的组列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	List<PageData> listLampState(Page page)throws Exception;

	/**
	 * 获取状态编号对应的状态
	 * @param smid
	 * @param svalue
	 * @return
	 * @throws Exception 
	 */
	PageData getStatus(PageData pd) throws Exception;

	/**
	 * 根据灯编号获取灯的详细信息
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	PageData viewLampDetail(PageData pd)throws Exception;

	/**
	 * 调节等的亮度
	 * @param pd
	 * @throws Exception
	 */
	void adjustBrt(PageData pd)throws Exception;

	/**
	 * 获取策略列表
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	List<PageData> getStrategy(Page page) throws Exception;

	/**
	 * 更新组对应得策略
	 * @param pd
	 * @throws Exception
	 */
	void upTermStrid(PageData pd)throws Exception;

	


}
