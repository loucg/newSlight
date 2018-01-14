package com.fh.util;

import java.util.Calendar;
import java.util.Properties;

import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

public class LampInfoCollectionJob implements Job{
	@Override
	public void execute(JobExecutionContext arg0) throws JobExecutionException {
		try {
			Properties pros = DbFH.getPprVue();
			String delSql = pros.getProperty("delLampAttr");
			String insSql = pros.getProperty("insLampAttr");
			Calendar c = Calendar.getInstance();
			int nowHour = c.get(Calendar.HOUR_OF_DAY);
			if(nowHour == 0) {
				DbFH.executeUpdateFH(delSql);
			}
			DbFH.executeUpdateFH(insSql);
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
}
