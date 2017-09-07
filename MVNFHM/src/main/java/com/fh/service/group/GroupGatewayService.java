package com.fh.service.group;

import java.util.List;

import com.fh.entity.Page;
import com.fh.util.PageData;

/**
 * 分组网关的接口
 * @author wap 20170826
 *
 */
public interface GroupGatewayService {

	/**
	 * 获取所在分组的网关列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	List<PageData> listGateways(Page page)throws Exception;

	/**
	 * 获取所在网关的终端列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public List<PageData> listClientsByGatewayId(Page page) throws Exception;
}
