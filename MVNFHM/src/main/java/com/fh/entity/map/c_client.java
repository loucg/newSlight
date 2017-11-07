package com.fh.entity.map;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;

public class c_client extends PageBean implements Serializable {

	private static final long serialVersionUID = 1L;
	private Integer id;
	private Integer typeid;
	private Integer termid;
	private String name;
	private String coordinate;
	private String location;
	private String lamppolenum;
	private String termname;
	private String typename;
	private String aliastypename;

	private String status;
	private float brightness;
	private double xcoordinate;
	private double ycoordinate;
	private String powerup;
	private String powerdown;
	private Date tdate;
	private String client_attri_id;
	private String map_pictrue_path;
	private String coordinate_google_source;
	private String coordinate_google;
	private String coordinate_baidu_source;

	public String getCoordinate_baidu_source() {
		return coordinate_baidu_source;
	}

	public void setCoordinate_baidu_source(String coordinate_baidu_source) {
		this.coordinate_baidu_source = coordinate_baidu_source;
	}

	private int partMaplinetCnt;
	private String partMap_Id;
	private String mapFlag;
	private Integer gatewayid;
	private String gatewayname;
	private String c_client_id;

	public String getcoordinate_google_source() {
		return coordinate_google_source;
	}

	public void setCoordinate_source(String coordinate_google_source) {
		this.coordinate_google_source = coordinate_google_source;
	}

	private String coordinate_source;

	public String getC_client_id() {
		return c_client_id;
	}

	public void setC_client_id(String c_client_id) {
		this.c_client_id = c_client_id;
	}

	public String getGatewayname() {
		return gatewayname;
	}

	public void setGatewayname(String gatewayname) {
		this.gatewayname = gatewayname;
	}

	public Integer getGatewayid() {
		return gatewayid;
	}

	public void setGatewayid(Integer gatewayid) {
		this.gatewayid = gatewayid;
	}

	public String getMapFlag() {
		return mapFlag;
	}

	public void setMapFlag(String mapFlag) {
		this.mapFlag = mapFlag;
	}

	public String getCoordinate_google() {
		return coordinate_google;
	}

	public void setCoordinate_google(String coordinate_google) {
		this.coordinate_google = coordinate_google;
	}

	public String getMap_pictrue_path() {
		return map_pictrue_path;
	}

	public void setMap_pictrue_path(String map_pictrue_path) {
		this.map_pictrue_path = map_pictrue_path;
	}

	public String getPartMap_Id() {
		return partMap_Id;
	}

	public void setPartMap_Id(String partMap_Id) {
		this.partMap_Id = partMap_Id;
	}

	public int getPartMaplinetCnt() {
		return partMaplinetCnt;
	}

	public void setPartMaplinetCnt(int partMaplinetCnt) {
		this.partMaplinetCnt = partMaplinetCnt;
	}

	public String getClientType() {
		return clientType;
	}

	public void setClientType(String clientType) {
		this.clientType = clientType;
	}

	private String clientType;

	public String getClient_attri_id() {
		return client_attri_id;
	}

	public void setClient_attri_id(String client_attri_id) {
		this.client_attri_id = client_attri_id;
	}

	public c_client getSearchconditions() {
		return searchconditions;
	}

	public void setSearchconditions(c_client searchconditions) {
		this.searchconditions = searchconditions;
	}

	private ArrayList<String> cclientgateway;
	private c_client searchconditions = null;
	private ArrayList<Integer> drawid = new ArrayList<Integer>();

	public ArrayList<Integer> getDrawid() {
		return drawid;
	}

	public void setDrawid(ArrayList<Integer> drawid) {
		this.drawid = drawid;
	}

	public Date getTdate() {
		return tdate;
	}

	public void setTdate(Date tdate) {
		this.tdate = tdate;
	}

	public ArrayList<String> getCclientgateway() {
		return cclientgateway;
	}

	public void setCclientgateway(ArrayList<String> cclientgateway) {
		this.cclientgateway = cclientgateway;
	}

	public boolean getPowerupisnull() {
		if (powerup == null)
			return true;
		else
			return false;
	}

	public String getPowerup() {
		return powerup;
	}

	public void setPowerup(String powerup) {
		this.powerup = powerup;
	}

	public boolean getPowerdownisnull() {
		if (powerdown == null)
			return true;
		else
			return false;
	}

	public String getPowerdown() {
		return powerdown;
	}

	public void setPowerdown(String powerdown) {
		this.powerdown = powerdown;
	}

	public c_client() {

	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	/*
	 * public c_client(c_client c) { this.id=c.getId(); this.typeid=c.getTypeid();
	 * this.termid=c.getTermid(); this.name=c.getName();
	 * this.coordinate=c.getCoordinate(); this.location=c.getLocation();
	 * this.lamppolenum=c.getLamppolenum(); this.termname=c.getTermname();
	 * this.typename=c.getTypename(); this.status=c.getStatus();
	 * this.brightness=c.getBrightness(); this.xcoordinate=c.getXcoordinate();
	 * this.ycoordinate=c.getYcoordinate();
	 * 
	 * }
	 */
	public String getAliastypename() {
		return aliastypename;
	}

	public void setAliastypename(String aliastypename) {
		this.aliastypename = aliastypename;
	}

	public Integer getTermid() {
		return termid;
	}

	public void setTermid(Integer termid) {
		this.termid = termid;
	}

	public Integer getTypeid() {
		return typeid;
	}

	public void setTypeid(Integer typeid) {
		this.typeid = typeid;
	}

	public String getTypename() {
		return typename;
	}

	public void setTypename(String typename) {
		this.typename = typename;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public double getXcoordinate() {
		return xcoordinate;
	}

	public void setXcoordinate(double xcoordinate) {
		this.xcoordinate = xcoordinate;
	}

	public double getYcoordinate() {
		return ycoordinate;
	}

	public void setYcoordinate(double ycoordinate) {
		this.ycoordinate = ycoordinate;
	}

	public String getTermname() {
		return termname;
	}

	public void setTermname(String termname) {
		this.termname = termname;
	}

	public float getBrightness() {
		return brightness;
	}

	public void setBrightness(float brightness) {
		this.brightness = brightness;
	}

	public String getLamppolenum() {
		return lamppolenum;
	}

	public void setLamppolenum(String lamppolenum) {
		this.lamppolenum = lamppolenum;
	}

	public String getCoordinate() {
		return coordinate;
	}

	public void setCoordinate(String coordinate) {
		this.coordinate = coordinate;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

}