package com.fh.service.system.smsplatform.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.util.PageData;
import com.fh.service.system.fhsms.FhsmsManager;
import com.fh.service.system.smsplatform.SmsplatformManager;

/** 
 * 说明： 站内信
 * 创建人：FH Q313596790
 * 创建时间：2016-01-17
 * @version
 */
@Service("smsplatformService")
public class SmsplatformService implements SmsplatformManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("FhsmsMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("FhsmsMapper.delete", pd);
	}
	
	/**修改状态
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("FhsmsMapper.edit", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("FhsmsMapper.datalistPage", page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("FhsmsMapper.listAll", pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("FhsmsMapper.findById", pd);
	}
	
	/**获取未读总数
	 * @param pd
	 * @throws Exception
	 */
	public PageData findFhsmsCount(String USERNAME)throws Exception{
		return (PageData)dao.findForObject("FhsmsMapper.findFhsmsCount", USERNAME);
	}
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("FhsmsMapper.deleteAll", ArrayDATA_IDS);
	}
	
	@Override
	public List<PageData> listAllSms(Page page) throws Exception {
		return (List<PageData>)dao.findForList("FhsmsMapper.smslistPage", page);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delSms(PageData pd)throws Exception{
		dao.delete("FhsmsMapper.deleteSms", pd);
	}
	
	/**修改状态
	 * @param pd
	 * @throws Exception
	 */
	public void editSms(PageData pd)throws Exception{
		dao.update("FhsmsMapper.editSms", pd);
	}
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void saveSms(PageData pd)throws Exception{
		dao.save("FhsmsMapper.saveSms", pd);
	}

	@Override
	public PageData findBySmsId(PageData pd) throws Exception {
		return (PageData)dao.findForObject("FhsmsMapper.findBySmsId", pd);
	}

	@Override
	public List<PageData> findSmsDestById(Page page) throws Exception {
		return (List<PageData>)dao.findForList("FhsmsMapper.getSmsDestinationlistPage", page);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delDestination(PageData pd)throws Exception{
		dao.delete("FhsmsMapper.deleteSmsDest", pd);
	}
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findSmsSettingInfoById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("FhsmsMapper.findSmsSettingInfoById", pd);
	}
	
	/**修改状态
	 * @param pd
	 * @throws Exception
	 */
	public void editSmsDest(PageData pd)throws Exception{
		dao.update("FhsmsMapper.editSmsDest", pd);
	}
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void insertDest(PageData pd)throws Exception{
		dao.save("FhsmsMapper.insertSmsDest", pd);
	}
	
	/**根据设备类型，故障类型和地址判断是否已经设置过了
	 * @param pd
	 * @throws Exception
	 */
	public int getSmsDestCount(PageData pd)throws Exception{
		return (Integer)dao.findForObject("FhsmsMapper.getSmsDestCount", pd);
	}
}

