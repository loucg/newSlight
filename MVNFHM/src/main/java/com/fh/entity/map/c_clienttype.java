package com.fh.entity.map;

import java.io.Serializable;
import java.util.List;

public class c_clienttype implements Serializable {
	private static final long serialVersionUID = 1L;

	private int id;

	private String explain;

	private String name;

public c_clienttype() {
		
	}
	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getExplain() {
		return this.explain;
	}

	public void setExplain(String explain) {
		this.explain = explain;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}



}