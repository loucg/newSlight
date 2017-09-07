package com.fh.entity.system;
/**
 * 
* 类名称：策略类型
* 类描述： 
* @author wap
* 作者单位： 
* 联系方式：
* 修改时间：2017年7月25日
* @version 1.0
 */
public class StrategyType {

	private String id;			    //编号
	private String name;			//策略类型名称
	private String comment;			//策略类型说明
	
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
	public String getComment(){
		return comment;
	}
	public void setComment(String comment){
		this.comment = comment;
	}
	
}