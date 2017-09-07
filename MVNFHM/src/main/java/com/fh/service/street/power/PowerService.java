package com.fh.service.street.power;

import java.util.List;

import com.fh.entity.Page;
import com.fh.util.PageData;

/**
 * 路灯状态-能耗接口
 * @author xiaozhou
 *
 */
public interface PowerService {

	//默认查询，按天查询上月，所有的能耗
	List<PageData> listPowerDaily(Page page) throws Exception;

	//分组按天查询
	List<PageData> listPowerByDay(Page page) throws Exception;

	//所有按月查询
	List<PageData> listPowerByMonth(Page page) throws Exception;




}
