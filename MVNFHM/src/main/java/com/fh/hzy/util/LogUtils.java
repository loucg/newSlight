package com.fh.hzy.util;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;

public class LogUtils {
	public static List<String> getTypeList(){
		Class<LogType> clazz = LogType.class;
		List<String> types = new ArrayList<>();
		Field[] fields = clazz.getFields();
		for(Field field : fields){
			String fieldName = field.getName();
			 try   
			   {      
			       String firstLetter = fieldName.substring(0, 1).toUpperCase();      
			       String getter = "get" + firstLetter + fieldName.substring(1);      
			       Method method = clazz.newInstance().getClass().getMethod(getter, new Class[] {});      
			       types.add((String)method.invoke(clazz.newInstance(), new Object[] {}));      
			   } catch (Exception e)   
			   {      
			       System.out.println("属性不存在");      
			       return null;      
			   }      
		}
		return types;
	}
}
