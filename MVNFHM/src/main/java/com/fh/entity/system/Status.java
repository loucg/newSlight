package com.fh.entity.system;
/**
 * 
* 类名称：状态
* 类描述： 
* @author zjc
* 作者单位： 
* 联系方式：
* 修改时间：2017年1月29日
* @version 1.0
 */
public class Status {

	private String value;			    //值
	private String name;			//状态名称
	
	public String getValue(){
		return value;
	}
	public void setValue(String value){
		this.value = value;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
}