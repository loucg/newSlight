package com.fh.entity.map;

import java.io.Serializable;



public class c_client_term implements Serializable {
	private static final long serialVersionUID = 1L;
	private Integer c_term_id;
	private Integer c_client_id;
	public  c_client_term( ) {
	}
	public Integer getC_term_id() {
		return c_term_id;
	}
	public void setC_term_id(Integer c_term_id) {
		this.c_term_id = c_term_id;
	}
	public Integer getC_client_id() {
		return c_client_id;
	}
	public void setC_client_id(Integer c_client_id) {
		this.c_client_id = c_client_id;
	}


}