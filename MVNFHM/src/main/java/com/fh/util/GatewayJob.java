package com.fh.util;

import java.sql.SQLException;
import java.util.List;

import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

public class GatewayJob implements Job{
	public static final String REGEX = ".*";
	@Override
	public void execute(JobExecutionContext arg0) throws JobExecutionException {
		
		try {
			// 掉线检测
			String gatewayUnlinesql = "UPDATE c_gateway_upload_status SET status = '3' where timestampdiff(minute,tdate,now()) > 5";
			DbFH.executeUpdateFH(gatewayUnlinesql);
			// 取得短信平台
			String adminInfoSql = "select " + 
					"			a.phone," + 
					"			d.smsplatform," + 
					"			a.name" + 
					"		from " + 
					"			sys_user a,b_user_company b,b_department c,b_company d" + 
					"		where " + 
					"			a.USERNAME = 'admin'" + 
					"			and a.user_id=b.b_user_id" + 
					"			and b.b_department_id = c.id" + 
					"			and c.b_company_id = d.id";
			String faultGatewayQuery = "SELECT"+ 
					"					    1 as device_type," + 
					"					    a.type," + 
					"						b.name," + 
					"						b.location," + 
					"						b_status.`name` status_name," + 
					"						a.fault_no," + 
					"						a.tdate," + 
					"						d.name_CH as device_name," + 
					"						c.gateway_code AS code " + 
					"		FROM b_gateway_fault AS a" + 
					"			INNER JOIN c_gateway_attr1 AS b ON a.c_gateway_id = b.c_gateway_id" + 
					"			INNER JOIN c_gateway AS c ON b.c_gateway_id = c.id" + 
					"			LEFT JOIN c_gateway_type AS d ON d.id = b.c_gateway_type_id" + 
					"			LEFT JOIN b_status " + 
					"				ON  b_status.b_status_main_id = '3'" + 
					"		 			AND a.type = b_status.value"+ 
					"		WHERE a.status = 1 and a.sms_sent is null"+
					"		UNION " +
					"		SELECT " + 
					"			    2 as device_type," + 
					"				a.type," + 
					"				c.name," + 
					"				c.location," + 
					"				e.`name` AS status_name," + 
					"				a.fault_no," + 
					"				a.tdate," + 
					"				f.name as device_name," + 
					"				d.client_code AS code" + 
					"		FROM b_client_fault AS a" + 
					"			INNER JOIN c_client_attr1 AS c ON a.c_client_id = c.c_client_id" + 
					"			LEFT JOIN c_client AS d ON c.c_client_id = d.id " + 
					"			LEFT JOIN c_client_type AS f ON f.id = c.c_client_type_id " + 
					"			LEFT JOIN b_status AS e ON e.b_status_main_id = '4' AND a.type = e.value " + 
					"		WHERE a.status='1' and a.sms_sent is null	"+
					"       ORDER BY device_type  ASC  ";
			String gatewaySmsSentSql = "UPDATE b_gateway_fault SET sms_sent = '1' where status = 1 and sms_sent is null";
			String nodeSmsSentSql = "UPDATE b_client_fault SET sms_sent = '1' where status = 1 and sms_sent is null";
			
			Object[] adminInfoList = DbFH.executeQueryFH(adminInfoSql);
			List<List<Object>> dataList = (List<List<Object>>) adminInfoList[1];
			String adminPhone = (String)dataList.get(0).get(0);
			String smsplatformType = (String)dataList.get(0).get(1);
			String adminName = (String)dataList.get(0).get(2);
			String smsSettingSql = "select" + 
					"		a.device_type," + 
					"		a.fault_type," + 
					"		a.location," + 
					"		a.send_to_admin," + 
					"		a.send_to_person," + 
					"		b.phone, " + 
					"		b.name " + 
					"	  from " + 
					"		b_sms_destination a" + 
					"		Left join sys_user b" + 
					"		on a.send_to_person = b.USER_ID" + 
					"		LEFT JOIN b_status c ON " + 
					"		c.value = a.fault_type and c.b_status_main_id = 3" + 
					"		LEFT JOIN b_status d ON " + 
					"		d.value = a.fault_type and d.b_status_main_id = 4" + 
					"	  where b_note_id = "+ smsplatformType;
			// 检索短信平台设置信息
			Object[] smsSettingInfoList = DbFH.executeQueryFH(smsSettingSql);
			List<List<Object>> smsSettingInfo = (List<List<Object>>) smsSettingInfoList[1];
			// 检索网关错误信息
			Object[] gatewayfaultInfoList = DbFH.executeQueryFH(faultGatewayQuery);
			List<List<Object>> gatewayfaultInfo = (List<List<Object>>) gatewayfaultInfoList[1];
			for(List<Object> faultInfoList : gatewayfaultInfo) {
				if(smsSettingInfo != null && smsSettingInfo.size() > 0) {
					boolean smsSentFlg = false;
					for(List<Object> smsInfo : smsSettingInfo){
						if("1".equals(smsInfo.get(0))
								&&faultInfoList.get(1).equals(smsInfo.get(1))
								&&cnvNullData(faultInfoList.get(3)).matches(REGEX+(String)smsInfo.get(2)+REGEX)
								) {
							smsSentFlg =true;
							if("1".equals(smsInfo.get(3))) {
								SmsAli.sendSms(adminName+","+cnvNullData(smsInfo.get(6)), cnvNullData(faultInfoList.get(3)),cnvNullData(faultInfoList.get(7)),cnvNullData(faultInfoList.get(6)),cnvNullData(faultInfoList.get(4)),adminPhone,cnvNullData(smsInfo.get(5)));
							}else {
								SmsAli.sendSms(cnvNullData(smsInfo.get(6)), cnvNullData(faultInfoList.get(3)),cnvNullData(faultInfoList.get(7)),cnvNullData(faultInfoList.get(6)),cnvNullData(faultInfoList.get(4)),adminPhone,"");
							}
							continue;
						}else if("2".equals(smsInfo.get(0))
								&&faultInfoList.get(1).equals(smsInfo.get(1))
								&&cnvNullData(faultInfoList.get(3)).matches(REGEX+(String)smsInfo.get(2)+REGEX)
								) {
							smsSentFlg =true;
							if("1".equals(smsInfo.get(3))) {
								SmsAli.sendSms(adminName+","+cnvNullData(smsInfo.get(6)), cnvNullData(faultInfoList.get(3)),cnvNullData(faultInfoList.get(7)),cnvNullData(faultInfoList.get(6)),cnvNullData(faultInfoList.get(4)),adminPhone,cnvNullData(smsInfo.get(5)));
							}else {
								SmsAli.sendSms(cnvNullData(smsInfo.get(6)), cnvNullData(faultInfoList.get(3)),cnvNullData(faultInfoList.get(7)),cnvNullData(faultInfoList.get(6)),cnvNullData(faultInfoList.get(4)),adminPhone,"");
							}
							continue;
						}
					}
					if(!smsSentFlg){
						// 没有设置地址
						SmsAli.sendSms(cnvNullData(adminName), cnvNullData(faultInfoList.get(3)),cnvNullData(faultInfoList.get(7)),cnvNullData(faultInfoList.get(6)),cnvNullData(faultInfoList.get(4)),adminPhone,"");
					}
				} else {
					SmsAli.sendSms(cnvNullData(adminName), cnvNullData(faultInfoList.get(3)),cnvNullData(faultInfoList.get(7)),cnvNullData(faultInfoList.get(6)),cnvNullData(faultInfoList.get(4)),adminPhone,"");
				}
			}
			DbFH.executeUpdateFH(gatewaySmsSentSql);
			DbFH.executeUpdateFH(nodeSmsSentSql);
		} catch (ClassNotFoundException e1) {
			e1.printStackTrace();
		} catch (SQLException e1) {
			e1.printStackTrace();
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	private String cnvNullData(Object str){
		if(str == null) {
			return "";
		}
		return str.toString();
	}
}
