package com.fh.entity.system;
/**
 * 
* 类名称：控制策略
* 类描述： 
* @author zjc
* 作者单位： 
* 联系方式：
* 修改时间：2017年2月13日
* @version 1.0
 */
public class Strategy {

	private String id;			    //编号
	private String name;			//策略名称
	private String explain;			//策略说明
	private String json;			//策略json
	private String status;			//状态
	private String tdate;			//创建时间
	
	public String getId(){
		return id;
	}
	public void setId(String id){
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getExplain() {
		return explain;
	}
	public void setExplain(String explain) {
		this.explain = explain;
	}
	public String getJson() {
		return json;
	}
	public void setJson(String json) {
		this.json = json;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getTdate() {
		return tdate;
	}
	public void setTdate(String tdate) {
		this.tdate = tdate;
	}
}