package com.fh.entity.map;
import java.io.Serializable;



public class c_term implements Serializable {
	private static final long serialVersionUID = 1L;
	private Integer id;
	private Integer b_ctrl_strategy_id;
	private Integer b_user_id;
	private String explain;
	private String name;
	private Integer status;
public c_term() {
		
	}
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}


	public Integer getB_ctrl_strategy_id() {
		return b_ctrl_strategy_id;
	}

	public void setB_ctrl_strategy_id(Integer b_ctrl_strategy_id) {
		this.b_ctrl_strategy_id = b_ctrl_strategy_id;
	}

	public Integer getB_user_id() {
		return b_user_id;
	}

	public void setB_user_id(Integer b_user_id) {
		this.b_user_id = b_user_id;
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

	public Integer getStatus() {
		return this.status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}


}
