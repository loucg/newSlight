package com.fh.entity.map;



public class JsonResultBean {

	private static final long serialVersionUID = 1L;
	private JsonStatus status = JsonStatus.EXCEPTION;
	private String message;

	public JsonStatus getStatus() {
		return status;
	}

	public void setStatus(JsonStatus status) {
		this.status = status;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

}
