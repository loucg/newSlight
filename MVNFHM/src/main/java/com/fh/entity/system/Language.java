package com.fh.entity.system;
/**
 * 
* 类名称：语言
* 类描述： 
* @author zjc
* 作者单位： 
* 联系方式：
* 修改时间：2017年1月29日
* @version 1.0
 */
public class Language {

	private String id;			    //编号
	private String name;			//语言名称
	
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
	
}