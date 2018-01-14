package com.fh.util;

import java.util.Calendar;
import java.util.Properties;

import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

public class LampStatisticsJob implements Job{
	@Override
	public void execute(JobExecutionContext arg0) throws JobExecutionException {
		try {
			Properties pros = DbFH.getPprVue();
			String delSql = pros.getProperty("delClientStatistic");
			String insSql = pros.getProperty("insClientStatistic");
			String insBkSql = pros.getProperty("insClientStatisticBK");
			Calendar c = Calendar.getInstance();
			if(c.get(Calendar.DATE)==c.getActualMinimum(Calendar.DAY_OF_MONTH)) {
				DbFH.executeUpdateFH(delSql);
			}
			DbFH.executeUpdateFH(insSql);
			DbFH.executeUpdateFH(insBkSql);
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
}
