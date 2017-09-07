package com.fh.service.system.fhlog.impl;

import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.hzy.util.LogType;
import com.fh.hzy.util.UserUtils;
import com.fh.service.system.fhlog.FHlogManager;
import com.fh.util.PageData;
import com.fh.util.Tools;
import com.fh.util.UuidUtil;

/** 
 * 说明： 操作日志记录
 * 创建人：FH Q313596790
 * 创建时间：2016-05-10
 * @version
 */
@Service("fhlogService")
public class FHlogService implements FHlogManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(String userid, String comment, int type)throws Exception{
		
		PageData pd = new PageData();
		pd.put("userid", userid);
		pd.put("type", type);
		pd.put("comment", comment);
		pd.put("time", Tools.date2Str(new Date()));
		dao.save("LogMapper.insertLog", pd);
	}
	
	/**
	 * 
	 * 添加终端日志
	 */
	@Override
	public void saveDeviceLog(String userid, String comment, String[] deviceids, String gatewayid, int cmdtype, String value) throws Exception{
		
		if(value==null){
			value="";
		}
		
		PageData pd = new PageData();
		pd.put("userid", userid);
		pd.put("type", LogType.devicecontrol);
		pd.put("comment", comment);
		pd.put("time", Tools.date2Str(new Date()));
		dao.save("LogMapper.insertLog", pd);
		int lastid = (Integer)dao.findForObject("ConfigureMapper.lastInsertId", pd);
		if(deviceids==null){
			pd.put("gateway", gatewayid);
			pd.put("cmd", value);
			pd.put("cmdid", cmdtype);
			pd.put("logid", lastid);
			dao.save("LogMapper.insertDeviceLog", pd);
		}else{
		
			StringBuffer sb = new StringBuffer();
			sb.append("(");
			for(int i=0;i<deviceids.length;i++){
				sb.append(deviceids[i]);
				if(i!=deviceids.length-1){
					sb.append(",");
				}
			}
			sb.append(")");
			pd.put("ids", sb.toString());
			if(gatewayid==null){
				Set<Long> sets = new HashSet<>();
				for(String deviceid: deviceids){
					pd.put("client", deviceid);
					PageData result = (PageData)dao.findForObject("LogMapper.getGatewayid", pd);
					if(result!=null){
						sets.add((Long)result.get("gateway"));
					}
				}
				for(long gateway: sets){
					pd.put("gateway", gateway);
//					PageData result = (PageData)dao.findForObject("LogMapper.getDeviceListString", pd);
					PageData result = (PageData)dao.findForObject("LogMapper.getDeviceListString2", pd);
					String param1 = result.getString("param1");
					String param2 = result.getString("param2");
					pd.put("cmd", param1+"."+param2+","+value);
					pd.put("cmdid", cmdtype);
					pd.put("logid", lastid);
					dao.save("LogMapper.insertDeviceLog", pd);
					System.out.println("生成了指令");
				}
			}else{
				PageData result = (PageData)dao.findForObject("LogMapper.getDeviceCode", pd);
				String cmd = result.getString("cmd");
				pd.put("gateway", gatewayid);
				pd.put("cmd", cmd+","+value);
				pd.put("cmdid", cmdtype);
				pd.put("logid", lastid);
				dao.save("LogMapper.insertDeviceLog", pd);
				
			}
		}
		
	}



	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("FHlogMapper.delete", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		PageData pd = page.getPd();
		pd.put("userid", UserUtils.getUserid());
		pd = (PageData)dao.findForObject("RoleMapper.getRoleNameByUserid", pd);
		if(pd.getString("rolename").equals("超级管理员")){
			pd.put("userid", null);
		}else{
			pd.put("userid", UserUtils.getUserid());
		}
		
		return (List<PageData>)dao.findForList("LogMapper.getLoglistPage", page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		pd.put("userid", UserUtils.getUserid());
		pd = (PageData)dao.findForObject("RoleMapper.getRoleNameByUserid", pd);
		if(pd.getString("rolename").equals("超级管理员")){
			pd.put("userid", null);
		}else{
			pd.put("userid", UserUtils.getUserid());
		}
		
		return (List<PageData>)dao.findForList("LogMapper.getLogAllPage", pd);
	}
	
	
	
	@Override
	public List<PageData> getDeviceLogList(Page page) throws Exception {
		PageData pd = page.getPd();
		pd.put("userid", UserUtils.getUserid());
		pd = (PageData)dao.findForObject("RoleMapper.getRoleNameByUserid", pd);
		if(pd.getString("rolename").equals("超级管理员")){
			pd.put("userid", null);
		}else{
			pd.put("userid", UserUtils.getUserid());
		}
		
		return (List<PageData>)dao.findForList("LogMapper.getDeviceLoglistPage", page);
	}


	@Override
	public List<PageData> getAllDeviceList(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		pd.put("userid", UserUtils.getUserid());
		pd = (PageData)dao.findForObject("RoleMapper.getRoleNameByUserid", pd);
		if(pd.getString("rolename").equals("超级管理员")){
			pd.put("userid", null);
		}else{
			pd.put("userid", UserUtils.getUserid());
		}
		
		return (List<PageData>)dao.findForList("LogMapper.getDeviceLogAllPage", pd);
	}


	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("FHlogMapper.findById", pd);
	}
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("FHlogMapper.deleteAll", ArrayDATA_IDS);
	}

	@Override
	public List<PageData> getLogTypeList(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>)dao.findForList("LogMapper.getLogTypeList", pd);
	}


	@Override
	public List<PageData> getDeviceTypeList(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>)dao.findForList("LogMapper.getDeviceTypeList", pd);
	}
	
	
	
}

