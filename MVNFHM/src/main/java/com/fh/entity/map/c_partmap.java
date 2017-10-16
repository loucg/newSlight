package com.fh.entity.map;

import java.io.Serializable;

public class c_partmap extends PageBean implements Serializable {

	private static final long serialVersionUID = 1L;

	private String partmap_name;
	private String inner_coordinate;
	private String c_termid;
	private String map_pictrue_path;
	private String c_client_id;
	private String external_coordinate;
	private String c_client_type_id;
	private int clinetCnt;
	private String id;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public int getClinetCnt() {
		return clinetCnt;
	}

	public void setClinetCnt(int clinetCnt) {
		this.clinetCnt = clinetCnt;
	}

	public String getPartmap_name() {
		return partmap_name;
	}

	public void setPartmap_name(String partmap_name) {
		this.partmap_name = partmap_name;
	}

	public String getInner_coordinate() {
		return inner_coordinate;
	}

	public void setInner_coordinate(String inner_coordinate) {
		this.inner_coordinate = inner_coordinate;
	}

	public String getC_termid() {
		return c_termid;
	}

	public void setC_termid(String c_termid) {
		this.c_termid = c_termid;
	}

	public String getMap_pictrue_path() {
		return map_pictrue_path;
	}

	public void setMap_pictrue_path(String map_pictrue_path) {
		this.map_pictrue_path = map_pictrue_path;
	}

	public String getC_client_id() {
		return c_client_id;
	}

	public void setC_client_id(String c_client_id) {
		this.c_client_id = c_client_id;
	}

	public String getExternal_coordinate() {
		return external_coordinate;
	}

	public void setExternal_coordinate(String external_coordinate) {
		this.external_coordinate = external_coordinate;
	}

	public String getC_client_type_id() {
		return c_client_type_id;
	}

	public void setC_client_type_id(String c_client_type_id) {
		this.c_client_type_id = c_client_type_id;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

}