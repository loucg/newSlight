package com.fh.service.map;

import java.util.ArrayList;
import java.util.List;

import com.fh.entity.map.c_client;
import com.fh.entity.map.c_term;
import com.fh.entity.map.draw_client;
import com.fh.util.PageData;

/**	地图控制类
 * @author zjc
 * 修改日期：2017.1.29
 */
public interface C_clientManager {

	 public List<c_term> queryAllterm() throws Exception ;
	 public List<c_client> queryAllterm_client(c_client p) throws Exception ;
	 public int queryCountterm_client(c_client p) throws Exception ;
	 public List<c_client> addClientMaker(c_client cc) throws Exception ; 
	 public List<c_client> getTypenameByGroup(int groupname) throws Exception ;
	 public List<c_client> getAddressByType(c_client cc) throws Exception ;
	 public List<c_client> getClientnameByaddress(c_client cc) throws Exception ;
	 public List<c_client> getClientigByname(c_client cc) throws Exception ;
	 public List<c_client> getSearchClient(c_client cc) throws Exception ;
	 public void updateClientAttr_brightness(c_client cc) throws Exception ;
	 public void updateClientAttr_status(c_client cc)throws Exception ;
	public void updateClientAttr_statusON(c_client cc) throws Exception ;
	public void updateClientAttr_statusOff(c_client cc) throws Exception ;
	public List<c_client> queryAllterm_gateway(c_client p) throws Exception ;
	public List<c_client> querGatewayPower(c_client p) throws Exception ;
	public List<String> querGatewayClient(c_client p) throws Exception ;
	public int queryCountgateway(c_client p) throws Exception ;
	public List<c_client> getTypenameByGroupGateway(int groupnameid) throws Exception ;
	public List<c_client> getAddressByTypeGataway(c_client cc) throws Exception ;
	public List<c_client> getClientnameByaddressGateway(c_client cc) throws Exception ;
	public List<c_client> getClientigBynameGateway(c_client cc) throws Exception ;
	public List<c_client> getSearchGateway(c_client cc) throws Exception ;
	public List<c_client> getClientByDraw(List  list) throws Exception;
	public List<c_client> getGatewayByDraw(List  list) throws Exception;
	public void updateClientDraw_status(draw_client dc)throws Exception;
	
		
}
