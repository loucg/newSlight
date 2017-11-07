package com.fh.service.slight.configure.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.service.slight.configure.ConfigureService;
import com.fh.util.PageData;

@Service("configureService")
public class ConfigureSerivceImpl implements ConfigureService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;

	@Override
	public List<PageData> getNPowerList(Page page) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>) dao.findForList("ConfigureMapper.getNPowerlistPage", page);
	}

	@Override
	public void editNPower(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		dao.update("ConfigureMapper.editNPower", pd);
	}

	@Override
	public void createNPower(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		dao.save("ConfigureMapper.createNPower", pd);
	}

	@Override
	public List<PageData> getLampList(Page page) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>) dao.findForList("ConfigureMapper.getLamplistPage", page);
	}

	@Override
	public void editLamp(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		dao.update("ConfigureMapper.editLamp", pd);
	}

	@Override
	public void createLamp(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		dao.save("ConfigureMapper.createLamp", pd);
	}

	@Override
	public List<PageData> getSensorList(Page page) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>) dao.findForList("ConfigureMapper.getSensorlistPage", page);
	}

	@Override
	public void editSensor(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		dao.update("ConfigureMapper.editSensor", pd);
	}

	@Override
	public void createSensor(PageData pd) throws Exception {
		dao.save("ConfigureMapper.insertSensor", pd);
		int lastid = (Integer) dao.findForObject("ConfigureMapper.lastInsertId", pd);
		pd.put("id", lastid);
		pd.put("client_type", 2);
		dao.save("ConfigureMapper.insertClientGateway", pd);
		dao.save("ConfigureMapper.insertSensorAttr1", pd);
		dao.save("ConfigureMapper.insertSensorAttr2", pd);
	}

	@Override
	public List<PageData> getPoleList(Page page) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>) dao.findForList("ConfigureMapper.getPolelistPage", page);
	}

	@Override
	public void editPole(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		dao.update("ConfigureMapper.editPole", pd);
	}

	@Override
	public void createPole(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		dao.save("ConfigureMapper.createPole", pd);
	}

	@Override
	public List<PageData> getSimList(Page page) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>) dao.findForList("ConfigureMapper.getSimlistPage", page);
	}

	@Override
	public void editSim(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		dao.update("ConfigureMapper.editSim", pd);
	}

	@Override
	public void createSim(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		dao.save("ConfigureMapper.createSim", pd);
	}

	@Override
	public List<PageData> getDeviceList(Page page) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>) dao.findForList("ConfigureMapper.getDevicelistPage", page);
	}

	@Override
	public List<PageData> getGatewayList(Page page) throws Exception {

		return (List<PageData>) dao.findForList("ConfigureMapper.getGatewaylistPage", page);
	}

	@Override
	public List<PageData> getBreakerList(Page page) throws Exception {

		return (List<PageData>) dao.findForList("ConfigureMapper.getBreakerlistPage", page);
	}

	@Override
	public void editDevice(PageData pd) throws Exception {
		dao.update("ConfigureMapper.editDevice", pd);
	}

	@Override
	public void createDevice(PageData pd) throws Exception {
		dao.save("ConfigureMapper.insertClient", pd);
		int lastid = (Integer) dao.findForObject("ConfigureMapper.lastInsertId", pd);
		pd.put("id", lastid);
		pd.put("client_type", 2);
		dao.save("ConfigureMapper.insertClientGateway", pd);
		dao.save("ConfigureMapper.insertClientAttr1", pd);
		dao.save("ConfigureMapper.insertClientAttr2", pd);
	}

	@Override
	public void editGateway(PageData pd) throws Exception {
		dao.save("ConfigureMapper.editGateway", pd);
	}

	@Override
	public void createGateway(PageData pd) throws Exception {
		dao.save("ConfigureMapper.insertGateway", pd);
		int lastid = (Integer) dao.findForObject("ConfigureMapper.lastInsertId", pd);
		pd.put("id", lastid);
		dao.save("ConfigureMapper.insertGatewayAttr1", pd);
		dao.save("ConfigureMapper.insertGatewayAttr2", pd);
	}

	@Override
	public List<PageData> getDeviceType(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>) dao.findForList("ConfigureMapper.getDeviceType", pd);
	}

	@Override
	public List<PageData> getAllNPower(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>) dao.findForList("ConfigureMapper.getAllNPower", pd);
	}

	@Override
	public List<PageData> getAllLamp(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>) dao.findForList("ConfigureMapper.getAllLamp", pd);
	}

	@Override
	public List<PageData> getAllPole(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>) dao.findForList("ConfigureMapper.getAllPole", pd);
	}

	@Override
	public List<PageData> getAllSensor(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>) dao.findForList("ConfigureMapper.getAllSensor", pd);
	}

	@Override
	public List<PageData> getAllSim(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>) dao.findForList("ConfigureMapper.getAllSim", pd);
	}

	@Override
	public PageData getLampById(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		return (PageData) dao.findForObject("ConfigureMapper.getLampById", pd);
	}

	@Override
	public PageData getNPowerById(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		return (PageData) dao.findForObject("ConfigureMapper.getNPowerById", pd);
	}

	@Override
	public PageData getPoleById(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		return (PageData) dao.findForObject("ConfigureMapper.getPoleById", pd);
	}

	@Override
	public PageData getSensorById(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		return (PageData) dao.findForObject("ConfigureMapper.getSensorById", pd);
	}

	@Override
	public PageData getSimById(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		return (PageData) dao.findForObject("ConfigureMapper.getSimById", pd);
	}

	@Override
	public PageData getGatewayAndBreakById(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		return (PageData) dao.findForObject("ConfigureMapper.getGatewayAndBreakById", pd);
	}

	@Override
	public PageData getDeviceById(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		return (PageData) dao.findForObject("ConfigureMapper.getDeviceById", pd);
	}

	@Override
	public PageData getDeviceByNumber(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		return (PageData) dao.findForObject("ConfigureMapper.getDeviceByNumber", pd);
	}

	@Override
	public PageData getGatewayByNumber(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		return (PageData) dao.findForObject("ConfigureMapper.getGatewayByNumber", pd);
	}

	@Override
	public List<PageData> getTypeList(Page page) throws Exception {
		return (List<PageData>) dao.findForList("ConfigureMapper.getTypelist", page);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> getTypeList2(Page page) throws Exception {
		return (List<PageData>) dao.findForList("ConfigureMapper.getTypelist2", page);
	}

	@Override
	public void addUserLog(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		dao.save("ConfigureMapper.addUserLog", pd);
	}

	@Override
	public Integer searchUserLogId(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		return (Integer) dao.findForObject("ConfigureMapper.searchUserLogId", pd);
	}

	@Override
	public void finallyaddpageone(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		dao.save("ConfigureMapper.finallyaddpageone", pd);
	}

	@Override
	public void finallyaddpagetwo(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		dao.save("ConfigureMapper.finallyaddpagetwo", pd);
	}
	
	@Override
	public PageData getUserByNameAndPwd(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		return (PageData)dao.findForObject("ConfigureMapper.getUserInfo", pd);
	}

	@Override
	public void updateStatus(PageData pd) throws Exception {
		// TODO Auto-generated method stub  
		dao.save("ConfigureMapper.updateStatus", pd);
	}

	public List<PageData> getGateWayTermInfo(Page page) throws Exception {
		return (List<PageData>) dao.findForList("ConfigureMapper.listTermsByGatewayId", page);
	}

	public List<PageData> clearGateWayTermInfo(Page page) throws Exception {
		return (List<PageData>)dao.findForList("ConfigureMapper.delTermsandStrategyByGeatewayID", page);
	
	}

	@Override
	public List<PageData> getAllClientType(PageData pd) throws Exception {
		return (List<PageData>) dao.findForList("ConfigureMapper.getClientType", pd);
	}
	
	@Override
	public PageData getSensorByNumber(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		return (PageData) dao.findForObject("ConfigureMapper.getSensorByNumber", pd);
	}
	@Override
	public PageData viewGatewayNet(PageData pd) throws Exception{
		return (PageData) dao.findForObject("ConfigureMapper.viewGatewayInfo", pd);
	}
}
