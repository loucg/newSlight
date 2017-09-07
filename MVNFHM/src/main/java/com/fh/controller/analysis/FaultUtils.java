package com.fh.controller.analysis;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.fh.util.PageData;

public class FaultUtils {
	public static Map<String, Object> exportFault(List<PageData> list){
		Map<String, Object> dataMap = new HashMap<>();
		List<String> titles = new ArrayList<>();
		titles.add("组名");
		titles.add("终端编号");
		titles.add("终端名称");
		titles.add("位置");
		titles.add("灯杆号");
		titles.add("网关名称");
		titles.add("故障类型");
		titles.add("开始时间");
		titles.add("异常描述");
		titles.add("修复时间");
		dataMap.put("titles", titles);
		
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<list.size();i++){
			String type = list.get(i).get("type").toString();
			if(type.equals("1")){
				type="灯开路";
			}
			else if(type.equals("2")){
				type="灯短路";
			}
			else if(type.equals("3")){
				type="灯异常";
			}
			else if(type.equals("4")){
				type="网关异常";
			}
			else if(type.equals("5")){
				type="断路器异常";
			}
			String tdate="";
			if(list.get(i).get("tdate")!=null){
				tdate=list.get(i).get("tdate").toString();
			}
			String repairtime="";
			if(list.get(i).get("repairtime")!=null){
				repairtime=list.get(i).get("repairtime").toString();
			}
			PageData vpd = new PageData();
			vpd.put("var1", list.get(i).getString("groupname"));		
			vpd.put("var2", list.get(i).getString("client_code"));		
			vpd.put("var3", list.get(i).getString("name"));	
			vpd.put("var4", list.get(i).getString("location"));	
			vpd.put("var5", list.get(i).getString("lamp_pole_num"));	
			vpd.put("var6", list.get(i).getString("wgname"));	
			vpd.put("var7", type);	
			vpd.put("var8", tdate);		
			vpd.put("var9", list.get(i).getString("comment"));
			vpd.put("var10", repairtime);
			varList.add(vpd);
		}
		dataMap.put("varList", varList);
		return dataMap;
	}

	public static Map<String, Object> exportRepair(List<PageData> list){
		Map<String, Object> dataMap = new HashMap<>();
		List<String> titles = new ArrayList<>();
		titles.add("组名");
		titles.add("终端编号");
		titles.add("终端名称");
		titles.add("位置");
		titles.add("灯杆号");
		titles.add("网关");
		titles.add("故障类型");
		titles.add("开始时间");
		titles.add("异常描述");
		titles.add("登记人");
		titles.add("维修人");
		titles.add("修复时间");
		titles.add("修复结果");
		titles.add("修复说明");
		dataMap.put("titles", titles);
		
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<list.size();i++){
			String type = list.get(i).get("type").toString();
			if(type.equals("1")){
				type="灯开路";
			}
			else if(type.equals("2")){
				type="灯短路";
			}
			else if(type.equals("3")){
				type="灯异常";
			}
			else if(type.equals("4")){
				type="网关异常";
			}
			else if(type.equals("5")){
				type="断路器异常";
			}
			String tdate="";
			if(list.get(i).get("tdate")!=null){
				tdate=list.get(i).get("tdate").toString();
			}
			String repairtime="";
			if(list.get(i).get("repairtime")!=null){
				repairtime=list.get(i).get("repairtime").toString();
			}
			PageData vpd = new PageData();
			vpd.put("var1", list.get(i).getString("groupname"));		
			vpd.put("var2", list.get(i).getString("client_code"));		
			vpd.put("var3", list.get(i).getString("name"));	
			vpd.put("var4", list.get(i).getString("location"));	
			vpd.put("var5", list.get(i).getString("lamp_pole_num"));	
			vpd.put("var6", list.get(i).getString("wgname"));	
			vpd.put("var7", type);	
			vpd.put("var8", tdate);		
			vpd.put("var9", list.get(i).getString("comment"));
			vpd.put("var10", list.get(i).getString("register"));
			vpd.put("var11", list.get(i).getString("repairman"));
			vpd.put("var12", repairtime);
			vpd.put("var13", list.get(i).getString("result"));
			vpd.put("var14", list.get(i).getString("explain"));
			varList.add(vpd);
		}
		dataMap.put("varList", varList);
		return dataMap;
	}
	public static Map<String, Object> exportLight(List<PageData> list){
		Map<String, Object> dataMap = new HashMap<>();
		List<String> titles = new ArrayList<>();
		titles.add("组名");
		titles.add("终端编号");
		titles.add("终端名称");
		titles.add("位置");
		titles.add("灯杆号");
		titles.add("亮灯比");
		titles.add("总时间");
		titles.add("总天数");
		dataMap.put("titles", titles);
		
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<list.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", list.get(i).getString("groupname"));		
			vpd.put("var2", list.get(i).getString("client_code"));		
			vpd.put("var3", list.get(i).getString("name"));	
			vpd.put("var4", list.get(i).getString("location"));	
			vpd.put("var5", list.get(i).getString("lamp_pole_num"));	
			vpd.put("var6", list.get(i).getString("per"));	
			vpd.put("var7", list.get(i).getString("time"));		
			vpd.put("var8", list.get(i).getString("day"));
			varList.add(vpd);
		}
		dataMap.put("varList", varList);
		return dataMap;
	}
	public static Map<String, Object> exportPower(List<PageData> list){
		Map<String, Object> dataMap = new HashMap<>();
		List<String> titles = new ArrayList<>();
		titles.add("组名");
		titles.add("终端编号");
		titles.add("终端名称");
		titles.add("位置");
		titles.add("灯杆号");
		titles.add("能耗（KW）");
		titles.add("策略名称");
		dataMap.put("titles", titles);
		
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<list.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", list.get(i).getString("groupname"));		
			vpd.put("var2", list.get(i).getString("client_code"));		
			vpd.put("var3", list.get(i).getString("name"));	
			vpd.put("var4", list.get(i).getString("location"));	
			vpd.put("var5", list.get(i).getString("lamp_pole_num"));	
			vpd.put("var6", list.get(i).get("power").toString());	
			vpd.put("var7", list.get(i).getString("clname"));		
			varList.add(vpd);
		}
		dataMap.put("varList", varList);
		return dataMap;
	}
}
