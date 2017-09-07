package com.fh.controller.slight.configure;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.fh.util.ObjectExcelView;
import com.fh.util.PageData;

public class ConfigureUtils {
	
	private static String[] status = {"测试", "等启用","正常", "欠费", "停机", "销号"};
	
	public static String getType(String string){
		if(string.equals("系统")||string.equals("捷布")){
			return "1";
			
		}else{
			return "2";
		}
	}
	
	public static String getSimStatus(String string){
		
		for(int i=0;i<status.length;i++){
			if(string.equals(status[i])){
				
				return i+1+"";
			}
		}
		return "";
	}
	
	public static Map<String, Object> exportNPower(List<PageData> list){
		Map<String, Object> dataMap = new HashMap<>();
		List<String> titles = new ArrayList<>();
		titles.add("序号");
		titles.add("规格/名称");
		titles.add("厂家");
		titles.add("类型");
		titles.add("功率");
		titles.add("备注");
		dataMap.put("titles", titles);
		
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<list.size();i++){
			String t = list.get(i).getString("type");
			if(t!=null){
				t = t.equals("1")?"系统":"自备";
			}
			PageData vpd = new PageData();
			vpd.put("var1", i+1+"");		
			vpd.put("var2", list.get(i).getString("name"));		
			vpd.put("var3", list.get(i).getString("vendor"));			
			vpd.put("var4", t);	
			vpd.put("var5", list.get(i).getString("power"));		
			vpd.put("var6", list.get(i).getString("comment"));	
			varList.add(vpd);
		}
		dataMap.put("varList", varList);
		return dataMap;
	}
	
	public static Map<String, Object> exportSimcard(List<PageData> list){
		Map<String, Object> dataMap = new HashMap<>();
		List<String> titles = new ArrayList<>();
		titles.add("序号");
		titles.add("ICCID");
		titles.add("电话号码");
		titles.add("类型");
		titles.add("状态");
		titles.add("余额");
		titles.add("备注");
		dataMap.put("titles", titles);
		
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<list.size();i++){
			String t = list.get(i).getString("type");
			if(t!=null){
				t = t.equals("1")?"系统":"自备";
			}
			String status = list.get(i).getString("status");
			if(status!=null){
				if(status.equals("1")){
					status = "测试";
				}
				if(status.equals("2")){
					status = "等启用";
				}
				if(status.equals("3")){
					status = "正常";
				}
				if(status.equals("4")){
					status = "欠费";
				}
				if(status.equals("5")){
					status = "停机";
				}
				if(status.equals("6")){
					status = "销号";
				}
			}
			PageData vpd = new PageData();
			vpd.put("var1", i+1+"");		
			vpd.put("var2", list.get(i).getString("iccid"));		
			vpd.put("var3", list.get(i).getString("mobile"));
			vpd.put("var4", t);	
			vpd.put("var5", status);		
			vpd.put("var6", list.get(i).getString("money"));	
			vpd.put("var7", list.get(i).getString("comment"));
			varList.add(vpd);
		}
		dataMap.put("varList", varList);
		return dataMap;
	}
	
	public static int getDeviceType(String type){
		int t = 0;
		if(type.equals("一体化电源")){
			t = 1;
		}else if(type.equals("单灯控制器")){
			t = 2;
		}else if(type.equals("网关")){
			t = 3;
		}else if(type.equals("断路器")){
			t = 4;
		}else if(type.equals("普通断路器")){
			t = 5;
		}else if(type.equals("终端组合")){
			t = 6;
		}
		return t;
		
	}
	
	public static Map<String, Object> exportDevice(List<PageData> list){
		Map<String, Object> dataMap = new HashMap<>();
		List<String> titles = new ArrayList<>();
		titles.add("终端编号");
		titles.add("终端名称");
		titles.add("终端类型");
		titles.add("位置");
		titles.add("坐标");
		titles.add("电话号码");
		titles.add("电源规格");
		titles.add("灯规格");
		titles.add("传感器规格");
		titles.add("电线杆");
		titles.add("电杆号");
		titles.add("密码");
		titles.add("备注");
		dataMap.put("titles", titles);
		
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<list.size();i++){
			String t = list.get(i).getString("type");
			if(t!=null){
				if(t.equals("1")){
					t = "一体化电源";
				}
				if(t.equals("2")){
					t = "单灯控制器";
				}
				if(t.equals("3")){
					t = "网关";
				}
				if(t.equals("4")){
					t = "断路器";
				}
				if(t.equals("5")){
					t = "普通断路器";
				}
				if(t.equals("6")){
					t = "终端组合";
				}
			}
			
			PageData vpd = new PageData();
			vpd.put("var1", list.get(i).getString("number"));		
			vpd.put("var2", list.get(i).getString("name"));
			vpd.put("var3", t);	
			vpd.put("var4", list.get(i).getString("location"));		
			vpd.put("var5", list.get(i).getString("coordinate"));	
			vpd.put("var6", list.get(i).getString("mobile"));
			vpd.put("var7", list.get(i).getString("power"));
			vpd.put("var8", list.get(i).getString("lamp"));
			vpd.put("var9", list.get(i).getString("sensor"));
			vpd.put("var10", list.get(i).getString("pole"));
			vpd.put("var11", list.get(i).getString("polenumber"));
			vpd.put("var12", list.get(i).getString("password"));
			vpd.put("var13", list.get(i).getString("comment"));
			varList.add(vpd);
		}
		dataMap.put("varList", varList);
		return dataMap;
	}
}
