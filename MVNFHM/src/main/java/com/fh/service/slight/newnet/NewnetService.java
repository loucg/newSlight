package com.fh.service.slight.newnet;

import java.util.List;

import com.fh.entity.Page;
import com.fh.util.PageData;

/**
 * 基础配置类接口
 * @author mxc
 *
 */

public interface NewnetService {
	
	
	/**
	 * 获取网关列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	 
	public List<PageData> getNewnetList(Page page) throws Exception;

	/**
	 * 根据id获取网关
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData getNewnetById(PageData pd) throws Exception;
	
	
	/**
	 * 获取终端列表
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> getClientList(Page page) throws Exception;
	
	/**
	 * 获得已添加的终端列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public List<PageData> getOwnClientList(Page page) throws Exception;
	
	/**
	 * 添加终端进网关
	 * @param pd
	 * @throws Exception
	 */
	public void addClients(PageData pd) throws Exception;
	
	/**
	 * 从网关移除终端
	 * @param pd
	 * @throws Exception
	 */
	public void deleteClients(PageData pd) throws Exception;
	

}
