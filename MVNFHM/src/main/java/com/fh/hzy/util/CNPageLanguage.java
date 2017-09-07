package com.fh.hzy.util;

/**
 * 中文分页
 * @author hongzhiyuanzj
 *
 */
public class CNPageLanguage implements IPageLanguage{

	@Override
	public String getTotal() {
		// TODO Auto-generated method stub
		return "共";
	}

	@Override
	public String getItem() {
		// TODO Auto-generated method stub
		return "条";
	}

	@Override
	public String getPageNumber() {
		// TODO Auto-generated method stub
		return "页码";
	}

	@Override
	public String getFirstPage() {
		// TODO Auto-generated method stub
		return "首页";
	}

	@Override
	public String getPrePage() {
		// TODO Auto-generated method stub
		return "上页";
	}

	@Override
	public String getJump() {
		// TODO Auto-generated method stub
		return "跳转";
	}

	@Override
	public String getNextPage() {
		// TODO Auto-generated method stub
		return "下页";
	}

	@Override
	public String getLastPage() {
		// TODO Auto-generated method stub
		return "尾页";
	}

	@Override
	public String getVisiableItem() {
		// TODO Auto-generated method stub
		return "显示条数";
	}

	@Override
	public String getPage() {
		// TODO Auto-generated method stub
		return "页";
	}
	
}
