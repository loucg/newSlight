package com.fh.service.slight.status;

import com.fh.util.PageData;

public interface StatusMainService {
	
	public PageData getStgAndGroupCnt(PageData pd) throws Exception;
	
	public PageData getClientTotal(PageData pd) throws Exception;
	public PageData getClientNormal(PageData pd) throws Exception;
	public PageData getGatewayTotal(PageData pd) throws Exception;
	public PageData getGatewayNormal(PageData pd) throws Exception;
	public PageData getGatewayFaultCnt(PageData pd) throws Exception;
	public PageData getClientFaultCnt(PageData pd) throws Exception;
	public PageData getTodayPower(PageData pd) throws Exception;
}
