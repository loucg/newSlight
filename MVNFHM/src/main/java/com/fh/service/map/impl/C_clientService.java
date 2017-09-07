package com.fh.service.map.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.map.c_client;
import com.fh.entity.map.c_term;
import com.fh.entity.map.draw_client;
import com.fh.entity.system.Status;
import com.fh.hzy.util.CMDType;
import com.fh.hzy.util.UserUtils;
import com.fh.service.map.C_clientManager;
import com.fh.service.system.fhlog.FHlogManager;
import com.fh.service.system.status.StatusManager;
import com.fh.util.PageData;

/**	地图控制
 * @author zjc
 * 修改日期：2017.1.29
 */
@Service("c_clientService")
public class C_clientService implements C_clientManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
    @Resource(name="fhlogService")
	private FHlogManager fhlogService;
	
////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	
    @SuppressWarnings("unchecked")
	@Override
	public List<c_term> queryAllterm() throws Exception {
		c_term a=new c_term();
		return  (List<c_term>)dao.findForList("C_clientMapper.queryAllterm",a);
	}
	@SuppressWarnings("unchecked")
	@Override
	public List<c_client> queryAllterm_client(c_client p) throws Exception  {
		List<c_client> adm=(List<c_client>)dao.findForList("C_clientMapper.queryAllterm_client",p);
		 c_client c=new c_client();
		 for(int i=0;i<adm.size();i++){
			 c=adm.get(i);
			 String coordinate=c.getCoordinate();
			 coordinate=coordinate.trim();
			 coordinate=coordinate.replace(" ","");
			 String[] coordsplit = coordinate.split(",");
			 double xcoordinate=Double.parseDouble(coordsplit[0]);
			 double ycoordinate=Double.parseDouble(coordsplit[1]);
			 c.setCoordinate(coordinate);
			 c.setXcoordinate(xcoordinate);
			 c.setYcoordinate(ycoordinate);
			 }
		return  adm;
	}
	@SuppressWarnings("unchecked")
	@Override
	public List<c_client> addClientMaker(c_client cc) throws Exception  {
		
		 List<c_client> adm=(List<c_client>)dao.findForList("C_clientMapper.queryAllclient_status",cc);
		 c_client c=new c_client();
		 for(int i=0;i<adm.size();i++){
			 c=adm.get(i);
			 String coordinate=c.getCoordinate();
			 coordinate=coordinate.trim();
			 coordinate=coordinate.replace(" ","");
			 String[] coordsplit = coordinate.split(",");
			 double xcoordinate=Double.parseDouble(coordsplit[0]);
			 double ycoordinate=Double.parseDouble(coordsplit[1]);
			 c.setCoordinate(coordinate);
			 c.setXcoordinate(xcoordinate);
			 c.setYcoordinate(ycoordinate);
			 }
		return  adm;
	}
	@Override
	@SuppressWarnings("unchecked")
	public List<c_client> getTypenameByGroup(int groupname)  throws Exception {
		return  (List<c_client>)dao.findForList("C_clientMapper.getTypenameByGroup",groupname);
	}
	@Override
	@SuppressWarnings("unchecked")
	public List<c_client> getAddressByType(c_client cc) throws Exception  {
		return  (List<c_client>)dao.findForList("C_clientMapper.getAddressByType",cc);
	}
	@Override
	@SuppressWarnings("unchecked")
	public List<c_client> getClientnameByaddress(c_client cc)  throws Exception {
		return  (List<c_client>)dao.findForList("C_clientMapper.getClientnameByaddress",cc);
	}
	@Override
	@SuppressWarnings("unchecked")
	public List<c_client> getClientigByname(c_client cc)  throws Exception {
		return  (List<c_client>)dao.findForList("C_clientMapper.getClientigByname",cc);
	}
	@Override
	@SuppressWarnings("unchecked")
	public List<c_client> getSearchClient(c_client cc1)  throws Exception {
		List<c_client> scl= (List<c_client>)dao.findForList("C_clientMapper.getSearchClient",cc1);
		 c_client cc=new c_client();
		 for(int i=0;i<scl.size();i++){
			 cc=scl.get(i);
			 String coordinate=cc.getCoordinate();
			 coordinate=coordinate.trim();
			 coordinate=coordinate.replace(" ","");
			 String[] coordsplit = coordinate.split(",");
			 double xcoordinate=Double.parseDouble(coordsplit[0]);
			 double ycoordinate=Double.parseDouble(coordsplit[1]);
			 cc.setCoordinate(coordinate);
			 cc.setXcoordinate(xcoordinate);
			 cc.setYcoordinate(ycoordinate);
			 cc.setSearchconditions(cc1);
			 }
		return scl;
	}

	@Override
	@SuppressWarnings("unchecked")
	public void updateClientAttr_brightness(c_client cc) throws Exception  {
		String[] ids=new String[1];
		ids[0]=String.valueOf(cc.getId());
		dao.update("C_clientMapper.updateClientAttr_brightness", cc);
		fhlogService.saveDeviceLog(UserUtils.getUserid(), "调节亮度", 
				ids, null, CMDType.ADJUST_BRIGHTNESS, null);
		
		
	}
	@Override
	@SuppressWarnings("unchecked")
	public int queryCountterm_client(c_client p) throws Exception  {
		return  (Integer)dao.findForObject("C_clientMapper.queryCountterm_client",p);
	}
	
	@Override
	public void updateClientAttr_status(c_client cc) throws Exception {
		String[] ids=new String[1];
		ids[0]=String.valueOf(cc.getId());
		if(cc.getBrightness()!=0){
			updateClientAttr_statusOff(cc);
			fhlogService.saveDeviceLog(UserUtils.getUserid(), "关灯", 
					ids, null, CMDType.TURN_OFF, null);
		}else
		{
			updateClientAttr_statusON(cc);	
			fhlogService.saveDeviceLog(UserUtils.getUserid(), "开灯", 
					ids, null, CMDType.TURN_ON, null);
		}
	}
	@Override
	@SuppressWarnings("unchecked")
	public void updateClientAttr_statusON(c_client cc) throws Exception  {
		dao.update("C_clientMapper.updateClientAttr_statusON", cc);
		
	}
	@Override
	@SuppressWarnings("unchecked")
	public void updateClientAttr_statusOff(c_client cc) throws Exception  {
		dao.update("C_clientMapper.updateClientAttr_statusOff", cc);
		
	}
	@Override
	@SuppressWarnings("unchecked")
	public List<c_client> queryAllterm_gateway(c_client p) throws Exception  {	
		List<c_client> qtg= (List<c_client>)dao.findForList("C_clientMapper.queryAllterm_gateway",p);
		c_client c=new c_client();
		 ArrayList<String> a=new ArrayList<String>();
		 ArrayList<c_client> b=new  ArrayList<c_client>();
		 for(int i=0;i<qtg.size();i++){
			 c=qtg.get(i);
			 String coordinate=c.getCoordinate();
			 coordinate=coordinate.trim();
			 coordinate=coordinate.replace(" ","");
			 String[] coordsplit = coordinate.split(",");
			 double xcoordinate=Double.parseDouble(coordsplit[0]);
			 double ycoordinate=Double.parseDouble(coordsplit[1]);
			 c.setCoordinate(coordinate);
			 c.setXcoordinate(xcoordinate);
			 c.setYcoordinate(ycoordinate);
			 if(c.getTypename().contains("网关")){
				a=(ArrayList<String>) querGatewayClient(c);
				 c.setCclientgateway(a);
			 }else{
				b=(ArrayList<c_client>) querGatewayPower(c);
				if(!c.getPowerupisnull())c.setPowerup(b.get(0).getPowerup());
				if(!c.getPowerdownisnull())c.setPowerdown(b.get(0).getPowerdown());
			 }
			 }
		return qtg;
	}
	@Override
	@SuppressWarnings("unchecked")
	public List<c_client> getSearchGateway(c_client cc1) throws Exception  {
		List<c_client> gcl= (List<c_client>)dao.findForList("C_clientMapper.getSearchGateway",cc1);
		 c_client cc=new c_client();
		 ArrayList<String> a=new ArrayList<String>();
		 ArrayList<c_client> b=new  ArrayList<c_client>();
		 for(int i=0;i<gcl.size();i++){
			 cc=gcl.get(i);
			 String coordinate=cc.getCoordinate();
			 coordinate=coordinate.trim();
			 coordinate=coordinate.replace(" ","");
			 String[] coordsplit = coordinate.split(",");
			 double xcoordinate=Double.parseDouble(coordsplit[0]);
			 double ycoordinate=Double.parseDouble(coordsplit[1]);
			 cc.setCoordinate(coordinate);
			 cc.setXcoordinate(xcoordinate);
			 cc.setYcoordinate(ycoordinate);
			 cc.setSearchconditions(cc1);
			 if(cc.getTypename().contains("网关")){
					a=(ArrayList<String>) querGatewayClient(cc);
					 cc.setCclientgateway(a);
				 }else{
					b=(ArrayList<c_client>) querGatewayPower(cc);
					cc.setPowerup(b.get(0).getPowerup());
					cc.setPowerdown(b.get(0).getPowerdown());
				 }
			 }
		return gcl;
	}
	@Override
	@SuppressWarnings("unchecked")
	public List<c_client> querGatewayPower(c_client p) throws Exception {
		return  (List<c_client>)dao.findForList("C_clientMapper.querGatewayPower",p);
	}
	@Override
	@SuppressWarnings("unchecked")
	public List<String> querGatewayClient(c_client p) throws Exception {
		return  (List<String>)dao.findForList("C_clientMapper.querGatewayClient",p);
	}
	@Override
	@SuppressWarnings("unchecked")
	public int queryCountgateway(c_client p)  throws Exception {
		return  (int)dao.findForObject("C_clientMapper.queryCountgateway",p);
	}
	@Override
	@SuppressWarnings("unchecked")
	public List<c_client> getTypenameByGroupGateway(int groupnameid) throws Exception  {
		return  (List<c_client>)dao.findForList("C_clientMapper.getTypenameByGroupGateway",groupnameid);
	}
	@Override
	@SuppressWarnings("unchecked")
	public List<c_client> getAddressByTypeGataway(c_client cc)  throws Exception {
		return  (List<c_client>)dao.findForList("C_clientMapper.getAddressByTypeGataway",cc);
	}
	@Override
	@SuppressWarnings("unchecked")
	public List<c_client> getClientnameByaddressGateway(c_client cc) throws Exception  {
		return  (List<c_client>)dao.findForList("C_clientMapper.getClientnameByaddressGateway",cc);
	}
	@Override
	@SuppressWarnings("unchecked")
	public List<c_client> getClientigBynameGateway(c_client cc) throws Exception  {
		return  (List<c_client>)dao.findForList("C_clientMapper.getClientigBynameGateway",cc);
	}
	@SuppressWarnings("unchecked")
	@Override
	public List<c_client> getClientByDraw(List  list) throws Exception {
		List<c_client> scl= (List<c_client>)dao.findForList("C_clientMapper.getClientByDraw",list);
		 c_client cc=new c_client();
		 for(int i=0;i<scl.size();i++){
			 cc=scl.get(i);
			 String coordinate=cc.getCoordinate();
			 coordinate=coordinate.trim();
			 coordinate=coordinate.replace(" ","");
			 String[] coordsplit = coordinate.split(",");
			 double xcoordinate=Double.parseDouble(coordsplit[0]);
			 double ycoordinate=Double.parseDouble(coordsplit[1]);
			 cc.setCoordinate(coordinate);
			 cc.setXcoordinate(xcoordinate);
			 cc.setYcoordinate(ycoordinate);
			 cc.setDrawid((ArrayList<Integer>) list);
			 }
		return scl;
	}
	@SuppressWarnings("unchecked")
	@Override
	public List<c_client> getGatewayByDraw(List  list) throws Exception {	
		List<c_client> qtg= (List<c_client>)dao.findForList("C_clientMapper.getGatewayByDraw",list);
		c_client c=new c_client();
		 ArrayList<String> a=new ArrayList<String>();
		 ArrayList<c_client> b=new  ArrayList<c_client>();
		 for(int i=0;i<qtg.size();i++){
			 c=qtg.get(i);
			 String coordinate=c.getCoordinate();
			 coordinate=coordinate.trim();
			 coordinate=coordinate.replace(" ","");
			 String[] coordsplit = coordinate.split(",");
			 double xcoordinate=Double.parseDouble(coordsplit[0]);
			 double ycoordinate=Double.parseDouble(coordsplit[1]);
			 c.setCoordinate(coordinate);
			 c.setXcoordinate(xcoordinate);
			 c.setYcoordinate(ycoordinate);
			 c.setDrawid((ArrayList<Integer>) list);
			 if(c.getTypename().contains("网关")){
				a=(ArrayList<String>) querGatewayClient(c);
				 c.setCclientgateway(a);
			 }else{
				b=(ArrayList<c_client>) querGatewayPower(c);
				c.setPowerup(b.get(0).getPowerup());
				c.setPowerdown(b.get(0).getPowerdown());
			 }
			 }
		return qtg;

	}
	@Override
	public void updateClientDraw_status(draw_client dc) throws Exception {
		List  list=dc.getDrawid();
		String strings[]=new String[list.size()];
		for(int i=0,j=list.size();i<j;i++){
		strings[i]=String.valueOf(list.get(i));
		}
		
		
		
		
		if(dc.getTakeid()==1){
			//List  list=dc.getDrawid();
			dao.update("C_clientMapper.updateClientDraw_statusON", list);
			fhlogService.saveDeviceLog(UserUtils.getUserid(), "开灯", 
					strings, null, CMDType.TURN_ON, null);
		}
		else if(dc.getTakeid()==2){
			//List  list=dc.getDrawid();
			dao.update("C_clientMapper.updateClientDraw_statusOFF", list);
			fhlogService.saveDeviceLog(UserUtils.getUserid(), "关灯", 
					strings, null, CMDType.TURN_OFF, null);
		}
		else{
			//List  list=dc.getDrawid();
			System.out.println("****************************************");
			System.out.println(dc.getBright());
			System.out.println("****************************************");
			System.out.println("****************************************");
			System.out.println("****************************************");
			dao.update("C_clientMapper.updateClientDraw_Bright", dc);
			fhlogService.saveDeviceLog(UserUtils.getUserid(), "调节亮度", 
					strings, null, CMDType.ADJUST_BRIGHTNESS, null);
		}
		
	}

	
	
}
