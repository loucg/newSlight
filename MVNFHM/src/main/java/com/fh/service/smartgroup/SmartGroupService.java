package com.fh.service.smartgroup;

import java.util.List;

import com.fh.util.PageData;

/**
 * 智能分组的接口
 * @author xiaozhou
 *
 */
public interface SmartGroupService {

	/**
	 * 获取该分组下的灯杆的数量
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	PageData getLampCount(PageData pd)throws Exception;

	/**
	 * 获取改组的功率的总和
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	double getSumPower(PageData pd) throws Exception;

	/**
	 * 获取改组下的终端号和功率相对应的列表
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	List<PageData> getClientPower(PageData pd)throws Exception;

	/**
	 * 获取小组详细信息
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	PageData getGroup(PageData pd)throws Exception;

	/**
	 * 获取终端的所有的坐标
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	List<PageData> getClientCoordinates(PageData pd) throws Exception;

	

}
