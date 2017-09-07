package com.fh.hzy.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 * 
 * @author hongzhiyuanzj
 *
 */
public class DateUtils {
	private static SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
	
	/**
	 * 将字符串的日期转换成Date
	 * @param string
	 * @return
	 */
	public static Date getDate(String string){
		try {
			return format.parse(string);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return new Date();
	}

	/**
	 * 获取当前日期的Date
	 * @return
	 */
	public static Date getCurrentDate(){
		
		String time = format.format(Calendar.getInstance().getTime());
		try {
			return format.parse(time);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return new Date();
		}
	}
	
	/**
	 * 获得当前日期第二天Date
	 * @return
	 */
	public static Date getDefaultNextDay(){
		
		Calendar c = Calendar.getInstance();
		c.add(Calendar.DAY_OF_MONTH, +1);
		return c.getTime();
		
	}
	
	/**
	 * 获取当前时间的下一个月
	 * @return
	 */
	public static Date getDefaultNextMonth(){
		Calendar c = Calendar.getInstance();
		c.add(Calendar.MONTH, +1);
		return c.getTime();
	}
	
	public static String toDateString(Date date){
		
		return format.format(date);
		
	}
}
