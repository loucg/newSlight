package com.fh.service.system.fhlog;

import java.util.List;

import com.fh.entity.Page;
import com.fh.util.PageData;
import com.sun.istack.internal.Nullable;

/** 
 * 说明： 操作日志记录接口
 * 创建人：FH Q313596790
 * 创建时间：2016-05-10
 * @version
 */
public interface FHlogManager{

	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(String userid, String comment, int type)throws Exception;
	
	/**
	 * 新增终端日志
	 * @param userid 用户id
	 * @param comment 详细内容
	 * @param deviceid 终端id的数组，没有则为null
	 * @param gatewayid 网关断路器id的,如果没有则为null
	 * @param cmdType 在CMDType类中
	 * @param value 参考命令表规范文档,终端列表逗号后的值
	 */
	public void saveDeviceLog(String userid, String comment,@Nullable String[] deviceids,  @Nullable String gatewayid, int cmdType, @Nullable String value) throws Exception;
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception;
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> list(Page page)throws Exception;
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	public List<PageData> listAll(PageData pd)throws Exception;
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception;
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception;
	
	/**
	 * 获取所有日志类型
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> getLogTypeList(PageData pd) throws Exception;
	
	/**
	 * 获取所有终端日志类型
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> getDeviceTypeList(PageData pd) throws Exception;
	
	/**
	 * 获取终端日志
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public List<PageData> getDeviceLogList(Page page) throws Exception;
	
	/**
	 * 获取所有终端日志，下载用
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> getAllDeviceList(PageData pd) throws Exception;
}

