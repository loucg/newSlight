package com.fh.entity.map;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;



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
	
	
	
	
	
	public c_client getSearchconditions() {
		return searchconditions;
	}
	public void setSearchconditions(c_client searchconditions) {
		this.searchconditions = searchconditions;
	}

	private ArrayList<String> cclientgateway;
	private c_client searchconditions =null;
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
		if( powerup==null) return true;
		else return false;
	}
	public String getPowerup() {
		return powerup;
	}
	public void setPowerup(String powerup) {
		this.powerup = powerup;
	}
	public boolean getPowerdownisnull() {
		if( powerdown==null) return true;
		else return false;
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
	
/*	public c_client(c_client c) {
		this.id=c.getId();
		this.typeid=c.getTypeid();
		this.termid=c.getTermid();
		this.name=c.getName();
		this.coordinate=c.getCoordinate();
		this.location=c.getLocation();
		this.lamppolenum=c.getLamppolenum();
		this.termname=c.getTermname();
		this.typename=c.getTypename();
		this.status=c.getStatus();
		this.brightness=c.getBrightness();
		this.xcoordinate=c.getXcoordinate();
		this.ycoordinate=c.getYcoordinate();
		
	}*/
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