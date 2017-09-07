package com.fh.hzy.util;
/**
 * 
 * @author hongzhiyuanzj
 *
 */
public interface IPageLanguage {
	
	
	//共
	public String getTotal();
	//条
	public String getItem();
	//页
	public String getPage();
	//页码
	public String getPageNumber();
	//首页
	public String getFirstPage();
	//上页 
	public String getPrePage();
	//跳转
	public String getJump();
	//下页
	public String getNextPage();
	//尾页
	public String getLastPage();
	//显示条数
	public String getVisiableItem();
	
}
