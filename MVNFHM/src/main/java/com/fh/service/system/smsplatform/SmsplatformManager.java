package com.fh.service.system.smsplatform;

import java.util.List;
import com.fh.entity.Page;
import com.fh.util.PageData;

/** 
 * 说明： 站内信接口
 * 创建人：FH Q313596790
 * 创建时间：2016-01-17
 * @version
 */
public interface SmsplatformManager{

	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception;
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception;
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception;
	
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
	
	/**获取未读总数
	 * @param pd
	 * @throws Exception
	 */
	public PageData findFhsmsCount(String USERNAME)throws Exception;
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception;
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> listAllSms(Page page)throws Exception;
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delSms(PageData pd)throws Exception;
	
	/**修改状态
	 * @param pd
	 * @throws Exception
	 */
	public void editSms(PageData pd)throws Exception;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void saveSms(PageData pd)throws Exception;
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findBySmsId(PageData pd)throws Exception;
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public List<PageData> findSmsDestById(Page page)throws Exception;
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delDestination(PageData pd)throws Exception;
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findSmsSettingInfoById(PageData page)throws Exception;
	
	/**修改状态
	 * @param pd
	 * @throws Exception
	 */
	public void editSmsDest(PageData pd)throws Exception;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void insertDest(PageData pd)throws Exception;
	
	/**根据设备类型，故障类型和地址判断是否已经设置过了
	 * @param pd
	 * @throws Exception
	 */
	public int getSmsDestCount(PageData pd)throws Exception;
}

