package com.fh.service.clienttype.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.service.clienttype.ClienttypeService;
import com.fh.util.PageData;

@Service("clienttypeService")
public class ClienttypeServiceImpl implements ClienttypeService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;

	@Override
	public void editLamp(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		dao.update("ClienttypeMapper.editLamp", pd);
	}

	@Override
	public void createLamp(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		dao.save("ClienttypeMapper.createLamp", pd);
	}

	@Override
	public void editSensor(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		dao.update("ClienttypeMapper.editSensor", pd);
	}

	@Override
	public void createSensor(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		dao.save("ClienttypeMapper.createSensor", pd);
	}

	@Override
	public void editGateway(PageData pd) throws Exception {
		dao.save("ClienttypeMapper.editGateway", pd);
	}

	@Override
	public void createGateway(PageData pd) throws Exception {
		dao.save("ClienttypeMapper.createGateway", pd);
//		int lastid = (Integer) dao.findForObject("ClienttypeMapper.lastInsertId", pd);
//		pd.put("id", lastid);
//		dao.save("ConfigureMapper.insertGatewayAttr1", pd);
//		dao.save("ConfigureMapper.insertGatewayAttr2", pd);
	}


	@Override
	public List<PageData> getLampList(Page page) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>) dao.findForList("ClienttypeMapper.getLamplistPage", page);
	}


	@Override
	public List<PageData> getSensorList(Page page) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>) dao.findForList("ClienttypeMapper.getSensorlistPage", page);
	}

	@Override
	public PageData getLampById(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		return (PageData) dao.findForObject("ClienttypeMapper.getClientById", pd);
	}


	@Override
	public PageData getSensorById(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		return (PageData) dao.findForObject("ClienttypeMapper.getSensorById", pd);
	}

	@Override
	public void editBreaker(PageData pd) throws Exception {
		dao.save("ClienttypeMapper.editBreaker", pd);
	}

	@Override
	public void createBreaker(PageData pd) throws Exception {
		dao.save("ClienttypeMapper.createBreaker", pd);
	}

	@Override
	public void editClient(PageData pd) throws Exception {
		dao.save("ClienttypeMapper.editClient", pd);
	}

	@Override
	public void createClient(PageData pd) throws Exception {
		dao.save("ClienttypeMapper.createClient", pd);
	}

	@Override
	public List<PageData> getClientList(Page page) throws Exception {
		return (List<PageData>) dao.findForList("ClienttypeMapper.getClientlistPage", page);
	}

	@Override
	public List<PageData> getGatewayList(Page page) throws Exception {
		return (List<PageData>) dao.findForList("ClienttypeMapper.getGatewaylistPage", page);
	}

	@Override
	public List<PageData> getBreakerList(Page page) throws Exception {
		return (List<PageData>) dao.findForList("ClienttypeMapper.getBreakerListPage", page);
	}

	@Override
	public PageData getBreakerById(PageData pd) throws Exception {
		return (PageData) dao.findForObject("ClienttypeMapper.getBreakerById", pd);
	}

	@Override
	public PageData getGatewayById(PageData pd) throws Exception {
		return (PageData) dao.findForObject("ClienttypeMapper.getGatewayById", pd);
	}

	@Override
	public PageData getClientById(PageData pd) throws Exception {
		return (PageData) dao.findForObject("ClienttypeMapper.getClientById", pd);
	}
	
	
	/**删除图片
	 * @param pd
	 * @throws Exception
	 */
	public void delSensorPic(PageData pd)throws Exception{
		dao.update("ClienttypeMapper.delSensorPic", pd);
	}
	
	/**删除图片
	 * @param pd
	 * @throws Exception
	 */
	public void delLampPic(PageData pd)throws Exception{
		dao.update("ClienttypeMapper.delLampPic", pd);
	}

	@Override
	public void delGateway(PageData pd) throws Exception {
		dao.delete("ClienttypeMapper.delGateway", pd);
	}

	@Override
	public void delSensor(PageData pd) throws Exception {
		dao.delete("ClienttypeMapper.delSensor", pd);
	}

	@Override
	public void delLamp(PageData pd) throws Exception {
		dao.delete("ClienttypeMapper.delLamp", pd);
	}

	@Override
	public PageData getClientTypeCount(PageData pd) throws Exception {
		return (PageData) dao.findForObject("ClienttypeMapper.getClientTypeCount", pd);
	}
	
	@Override
	public PageData getSensorTypeCount(PageData pd) throws Exception {
		return (PageData) dao.findForObject("ClienttypeMapper.getSensorTypeCount", pd);
	}
	
	@Override
	public PageData getGatewayTypeCount(PageData pd) throws Exception {
		return (PageData) dao.findForObject("ClienttypeMapper.getGatewayTypeCount", pd);
	}
	
}
